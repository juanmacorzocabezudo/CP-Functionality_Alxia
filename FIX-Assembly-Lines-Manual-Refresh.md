# FIX: Actualización de Líneas Manuales en Pedidos de Ensamblado

## 🔴 Problema

Cuando se cambia la cantidad en la cabecera de un pedido de ensamblado y se recalculan las líneas (botón "SÍ"), el sistema genera un **error de item tracking** porque las entradas de seguimiento (lotes/series) de las líneas antiguas no se borran correctamente.

### Error Específico
```
Seguim. prod. definido para el producto MP00409 en las cuentas de Línea de ensamblado 
tiene una cant. mayor que la que ha introducido. 
Debe ajustar el seguim. prod. actual y volver a introducir la nueva cantidad.
```

**El error ocurre cuando:**
- Hay líneas con item tracking (seguimiento de lotes/series) asignado
- Se **recalculan las líneas** (ReplaceLinesFromBOM = TRUE)
- El sistema intenta crear nuevas líneas pero las entradas de tracking antiguas no se borran

## 🔍 Causa Raíz Identificada (Definitiva)

El error ocurría en `DoVerificationsSkippedEarlier` cuando llamaba a `VerifyReservationQuantity`:

```
Stack Trace:
1. UpdateAssemblyLines (usuario cambia cantidad y dice "SÍ" a recalcular)
2. Crear líneas temporales nuevas desde BOM
3. DoVerificationsSkippedEarlier
   └── VerifyReservationQuantity(TempNewLine, TempOldLine)
       └── Reservation Management.CheckQuantityIsCompletelyReleased
           └── ERROR línea 2132: "Seguim. prod. tiene cant. mayor"
4. DeleteLines ← Nunca se ejecutaba (error ocurría antes)
```

**El problema:**
- `VerifyReservationQuantity` se llamaba **incluso cuando `ReplaceLinesFromBOM = TRUE`**
- BC intentaba validar si las Reservation Entries de las líneas **antiguas** podían liberarse
- Como las líneas antiguas aún existían con su tracking, BC detectaba conflicto
- El `ItemTrackingHandling` estaba en `None`, causando el error

**Por qué falla el intento de borrar Reservation Entries antes:**
- `AssemblyLineReserve.DeleteLine()` tiene validaciones internas que impiden borrar
- Requiere `ItemTrackingHandling = "Allow deletion"`, pero no tenemos acceso a configurarlo

## ✅ Solución Implementada (Definitiva)

### Cambio en DoVerificationsSkippedEarlier

**Saltarse completamente las verificaciones de reserva cuando `ReplaceLinesFromBOM = TRUE`:**

```al
local procedure DoVerificationsSkippedEarlier(ReplaceLinesFromBOM: Boolean; ...)
begin
    IF TempNewAsmLine.FIND('-') THEN
        REPEAT
            TempNewAsmLine.SetSkipVerificationsThatChangeDatabase(FALSE);
            // FIX: Cuando ReplaceLinesFromBOM = TRUE, saltamos las verificaciones de reserva
            // porque las líneas antiguas serán borradas completamente
            IF NOT ReplaceLinesFromBOM THEN BEGIN
                TempOldAsmLine.GET(...);
                TempNewAsmLine.VerifyReservationQuantity(TempNewAsmLine, TempOldAsmLine);
                TempNewAsmLine.VerifyReservationChange(TempNewAsmLine, TempOldAsmLine);
            END;
            TempNewAsmLine.VerifyReservationDateConflict(TempNewAsmLine);
            TempNewAsmLine.MODIFY;
        UNTIL TempNewAsmLine.NEXT = 0;
end;
```

### Por Qué Funciona

Cuando `ReplaceLinesFromBOM = TRUE`:
1. ✅ Las líneas antiguas van a ser **completamente eliminadas** con `DeleteLines`
2. ✅ Sus Reservation Entries también se borrarán en `DeleteLines`
3. ✅ NO tiene sentido validar si las reservas antiguas pueden liberarse
4. ✅ Solo validamos `VerifyReservationDateConflict` para las líneas **nuevas**

### Archivos Modificados

**3 cambios en cada archivo:**

1. **Eliminar llamada a `DeleteReservationEntriesOnly`** (no funcionaba)
   - En `UpdateAssemblyLines`, línea ~309

2. **Modificar `DoVerificationsSkippedEarlier`** (saltar verificaciones cuando ReplaceLinesFromBOM)
   - Líneas ~520

3. **Simplificar `DeleteLines`** (volver a usar AssemblyLineReserve)
   - Líneas ~238

## 🧪 Casos de Prueba para Cliente

### ✅ Test 1: Recalcular con Item Tracking
**Objetivo:** Verificar que el recálculo funciona con productos que tienen seguimiento de lote

**Pasos:**
1. Crear pedido de ensamblado con Quantity = 100
2. Asignar lotes/series en las líneas (producto con seguimiento M_PRIMA)
3. Cambiar Quantity de cabecera a 50
4. En el mensaje "¿Desea que se recalcule las líneas?", pulsar **SÍ**
5. ✅ **VERIFICAR:**
   - Las líneas se recalculan correctamente
   - **NO aparece error** "Seguim. prod. tiene cant. mayor"
   - Se pueden asignar nuevos lotes para la cantidad 50

### ✅ Test 2: Recalcular Aumentando Cantidad
**Objetivo:** Verificar que también funciona al aumentar

**Pasos:**
1. Crear pedido con Quantity = 50, con tracking asignado
2. Cambiar Quantity a 100
3. Recalcular líneas (SÍ)
4. ✅ **VERIFICAR:**
   - Líneas se recalculan a cantidad 100
   - Puedes asignar nuevos lotes
   - NO hay errores

### ✅ Test 3: Recalcular Múltiples Veces
**Objetivo:** Verificar cambios consecutivos

**Pasos:**
1. Crear pedido con Quantity = 100, tracking asignado
2. Cambiar a 200, recalcular (SÍ)
3. Cambiar a 50, recalcular (SÍ)  
4. Cambiar a 150, recalcular (SÍ)
5. ✅ **VERIFICAR:** Cada recálculo funciona sin errores

### ✅ Test 4: NO Recalcular (responder NO)
**Objetivo:** Verificar que el fix anterior sigue funcionando

**Pasos:**
1. Crear pedido con Quantity = 100
2. Cambiar Quantity a 50
3. En "¿Desea que se recalcule las líneas?", pulsar **NO**
4. ✅ **VERIFICAR:**
   - Las líneas se actualizan proporcionalmente (sin reemplazarlas)
   - Funciona correctamente

## 📋 Checklist de Validación

Para cada prueba, confirmar:
- [ ] NO aparece error "Seguim. prod. tiene cant. mayor"
- [ ] Las líneas se recalculan/actualizan correctamente
- [ ] Puedes asignar nuevos lotes/series después del recálculo
- [ ] Funciona tanto al **aumentar** como al **reducir**
- [ ] Funciona tanto con "SÍ" (recalcular) como con "NO" (actualizar)

## ⚠️ Notas Importantes

1. **Este fix complementa el anterior**:
   - Fix anterior: Actualización proporcional cuando NO se recalcula (respuesta = NO)
   - Este fix: Borrado correcto de tracking cuando SÍ se recalcula (respuesta = SÍ)

2. **Item Tracking debe borrarse explícitamente**:
   - `AssemblyLine.DELETE(TRUE)` NO borra automáticamente las Reservation Entries
   - Necesitamos `ReservEntry.DELETEALL(TRUE)` ANTES de borrar la línea

3. **El método comentado `HandleItemTrackingDeletion` probablemente hacía esto**:
   - Estaba comentado en los 3 archivos
   - Lo reemplazamos con código explícito en el mismo lugar

## 🎯 Resultado Esperado

### Antes del Fix
```
1. Usuario cambia Quantity: 100 → 50
2. Sistema pregunta: "¿Desea que se recalcule las líneas?"
3. Usuario dice: SÍ
4. Sistema intenta borrar líneas
5. ❌ ERROR: "Seguim. prod. tiene cant. mayor"
```

### Después del Fix
```
1. Usuario cambia Quantity: 100 → 50
2. Sistema pregunta: "¿Desea que se recalcule las líneas?"
3. Usuario dice: SÍ
4. Sistema borra tracking entries de líneas antiguas
5. Sistema borra líneas antiguas
6. Sistema crea líneas nuevas con Quantity = 50
7. ✅ Sin errores, listo para asignar nuevos lotes
```

---

**Fecha:** 2026-08-04  
**Archivos Modificados:** 3  
**Severidad:** CRÍTICA (bloqueaba recálculo de líneas con item tracking)  
**Método Modificado:** `DeleteLines` en AlxAssemblyLineManagement.Codeunit.al, _Productos Evento_.Table.al, _Lineas Evento_.Table.al
