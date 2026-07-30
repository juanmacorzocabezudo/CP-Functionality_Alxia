# Documentación Funcional: Cálculo de Costes en Recetas y Eventos

**Fecha:** 2026-07-07  
**Versión:** 1.0  
**Alcance:** Listas de Materiales (L.M.) y Componentes de Eventos

---

## 1. Resumen Ejecutivo

Este documento explica cómo se calcula el **Coste Estándar Marcado** (`CosteUnitario`) en las líneas de componentes de recetas y eventos, identificando las diferencias entre:

1. **Cálculo Inicial**: Cuando se añade manualmente un nuevo producto/recurso
2. **Recálculo Automático**: Cuando se ejecuta la función "Calcular Costes y Precios"

---

## 2. Contexto Funcional

### 2.1. Objetos Involucrados

| Objeto | Tabla/Página | Descripción |
|--------|-------------|-------------|
| **Subformulario Receta** | Página 50001 | Lista de materiales de ensamblado (BOM Component) |
| **Componentes Evento** | Página 50015 / Tabla 50014 | Componentes específicos de eventos |
| **BOM Component** | Extensión de tabla 90 | Componentes de lista de materiales estándar |

### 2.2. Campos Clave

| Campo | Nombre Técnico | Descripción |
|-------|----------------|-------------|
| **Coste Estándar Marcado** | `CosteUnitario` | Coste unitario del componente (campo 50004) |
| **Cantidad por Lote** | `Cantidad por Lote` | Cantidad del componente por lote de producción |
| **Coste Lote** | `Coste Lote` | Coste total del componente para el lote completo |
| **Coste Calculado** | `Coste Calculado` | Coste calculado por unidad de medida base |

---

## 3. Cálculo Inicial de Costes

### 3.1. Momento de Ejecución

El cálculo inicial se ejecuta **automáticamente** cuando:
- El usuario selecciona un producto en el campo `"No."` de una nueva línea
- El usuario cambia la unidad de medida de un componente existente
- El usuario modifica la "Cantidad por Lote" de un componente

### 3.2. Lógica de Cálculo

#### **Campo "Coste Lote" (Cálculo Inicial)**

Este es el campo que más confusión genera. Se calcula en el trigger `OnValidate` del campo "Cantidad por Lote":

```
Coste Lote = Cantidad por Lote × CosteUnitario
```

**Ubicación técnica:** `_Componentes Evento_.Table.al`, línea 328  
**Código:**
```al
"Coste Lote" := "Cantidad por Lote" * CosteUnitario;
```

**Ejemplo inicial:**
- Producto: BIZCOCHO-001
- CosteUnitario: 2.00 € (Standard Cost de la ficha)
- Cantidad por Lote: 5 unidades
- **Coste Lote = 5 × 2.00 = 10.00 €**

Este cálculo **NO considera los componentes hijos** del producto, solo multiplica la cantidad por el coste unitario de la ficha.

#### **Campo "CosteUnitario" (Coste Estandar Marcado)**

Para **Productos** (Type = Item):

```
CosteUnitario = Standard Cost del Producto × Factor de Conversión de UM
```

**Detalles:**
- Se obtiene el campo `"Standard Cost"` de la ficha del producto
- Se multiplica por el factor de conversión de la unidad de medida seleccionada
- Si el `"Standard Cost"` es 0 (solo en Componentes Evento), se usa `"Unit Cost"` como alternativa

**Ubicación técnica:** `AlxiaBOMComponent.TableExt.al`, línea 195-198  
**Código:**
```al
CosteUnitario := Item."Standard Cost" * GetUnitOfMeasurmentPer(Rec."No.", Rec."Unit of Measure Code");
```

#### Para **Recursos** (Type = Resource):

```
CosteUnitario = Unit Cost del Recurso
```

**Detalles:**
- Se obtiene directamente el campo `"Unit Cost"` de la ficha del recurso
- No se aplica factor de conversión

**Ubicación técnica:** `AlxiaBOMComponent.TableExt.al`, línea 239  
**Código:**
```al
CosteUnitario := Res."Unit Cost";
```

### 3.3. Características del Cálculo Inicial

✅ **Ventajas:**
- Refleja el coste estándar configurado en las fichas maestras
- Inmediato y predecible
- Coherente con el sistema de costes estándar

⚠️ **Limitaciones:**
- No considera los componentes hijos de productos con sub-recetas
- No calcula costes acumulados de varios niveles
- Puede diferir del coste real si la receta tiene componentes

---

## 4. Recálculo con "Calcular Costes y Precios"

### 4.1. Momento de Ejecución

El recálculo se ejecuta **manualmente** cuando:
- El usuario hace clic en el botón **"Calcular Costes y Precios"** (en Componentes Evento, página 50015)
- El sistema procesa el evento para actualizar costes directos e indirectos

#### **Campo "Coste Lote" (Recálculo con botón)**

**⚠️ CRÍTICO:** Este es el cambio más importante que genera confusión.

Para productos **CON sub-receta** (Assembly BOM = true):
```
Coste Lote = SUMA de "Coste Lote" de TODOS los componentes hijos
```

Para productos **SIN sub-receta** (Assembly BOM = false):
```
Coste Lote = NO se modifica (mantiene el cálculo inicial)
```

**Proceso:**
1. **Idenreal (Evento.Table.al, líneas 2204-2235):**
```al
IF Item."Assembly BOM" THEN BEGIN
    // Busca componentes hijos del producto
    ComponentesEventos2.RESET;
    ComponentesEventos2.SETRANGE("Codigo Evento", ComponentesEvento."Codigo Evento");
    ComponentesEventos2.SETRANGE("Linea Evento", ComponentesEvento."Linea Evento");
    ComponentesEventos2.SETRANGE("Parent Item No.", ComponentesEvento."No.");
    
    // Recursión: primero calcula costes de niveles inferiores
    CalcularCosteLMRecursivo(ComponentesEventos2);
    
    // Suma TODOS los "Coste Lote" de los componentes hijos
    ComponentesEventos2.CALCSUMS("Coste Lote");
    
    // ⚠️ SOBRESCRIBE el Coste Lote con la suma de los hijos
    ComponentesEvento."Coste Lote" := ComponentesEventos2."Coste Lote";
    
    // Recalcula CosteUnitario basado en el nuevo Coste Lote
    ComponentesEvento.CosteUnitario := 0;
    IF ComponentesEvento."Cantidad por Lote" <> 0 THEN 
        ComponentesEvento.CosteUnitario := ComponentesEvento."Coste Lote" / ComponentesEvento."Cantidad por Lote";
    
    // Actualiza Coste Calculado
    ComponentesEvento."Coste Calculado" := ComponentesEvento."Quantity per" * ComponentesEvento.CosteUnitario;
    ComponentesEvento.MODIFY
    // Recursión para calcular costes de niveles inferiores
    CalcularCosteLMRecursivo(ComponentesEventos2);
    
    // Suma costes de todos los hijos
    ComponentesEventos2.CALCSUMS("Coste Lote");
    ComponentesEvento."Coste Lote" := ComponentesEventos2."Coste Lote";
    
    // Recalcula CosteUnitario
    IF ComponentesEvento."Cantidad por Lote" <> 0 THEN 
        ComponentesEvento.CosteUnitario := ComponentesEvento."Coste Lote" / ComponentesEvento."Cantidad por Lote";
END;
```

### 4.3. Características del Recálculo

✅ **Ventajas:**
- Calcula el coste real basado en los componentes efectivos
- Considera múltiples niveles de sub-recetas
- Refleja cambios en componentes hijos
- Útil para productos intermedios con estructura compleja

⚠️ **Limitaciones:**
- **Sobrescribe** el coste estándar configurado inicialmente
- Puede generar diferencias si los componentes no están actualizados
- DeCoste Lote (Producto)** | `Cantidad × CosteUnitario` | `SUMA Coste Lote de hijos` (si tiene sub-receta) |
| **Coste Lote (Recurso)** | `Cantidad × CosteUnitario` | No cambia |
| **CosteUnitario (origen)** | Standard Cost de la ficha | `Coste Lote (recalculado) / Cantidad` |
| **Considera Sub-recetas** | ❌ No | ✅ Sí (recursivo) |
| **Momento** | Al añadir línea / cambiar cantidad | Al hacer clic en botón |
| **Sobrescribe valores** | No | ✅ Sí (Coste Lote y CosteUnitario) |
| **Origen de datos** | Fichas maestras | Componentes reales del evento |
| **Aplica a productos sin sub-receta** | ✅ Sí | ❌ No (mantiene valores iniciales)

| Aspecto | Cálculo Inicial | Recálculo (Calcular Costes) |
|---------|-----------------|----------------------------|
| **Origen del Coste** | Ficha del producto/recurso | Suma de componentes hijos |
| **Fórmula (Producto)** | `Standard Cost × Factor UM` | `Coste Lote / Cantidad por Lote` |
| **Fórmula (Recurso)** | `Unit Cost` | `Coste Lote / Cantidad por Lote` |
| **Considera Sub-recetas** | ❌ No | ✅ Sí (recursivo) |
| **Momento** | Al añadir línea | Al hacer clic en botón |
| **Puede modificarse** | No (automático) | Sí (sobrescribe) |
| **Origen de datos** | Fichas maestras | Componentes del evento |
 Detallado

#### Escenario: Producto "Tarta de Chocolate" con sub-receta

**Estructura del evento:**
```
TARTA-001 (Producto final - Cantidad por Lote: 1)
├── BIZCOCHO-001 (Sub-receta - Cantidad por Lote: 5 uds)
│   ├── HARINA (MP): 2.50 kg × 0.80 €/kg = 2.00 € → Coste Lote: 2.00 €
│   ├── HUEVOS (MP): 30 uds × 0.15 €/ud = 4.50 € → Coste Lote: 4.50 €
│   └── AZUCAR (MP): 1.00 kg × 1.20 €/kg = 1.20 € → Coste Lote: 1.20 €
└── CHOCOLATE (MP): 0.30 kg × 5.00 €/kg = 1.50 € → Coste Lote: 1.50 €
```

**Datos de fichas:**
- BIZCOCHO-001: Standard Cost = 2.00 €/ud

---

#### **PASO 1: Cálculo Inicial (al cargar el producto)**

Cuando añades BIZCOCHO-001 al evento con Cantidad por Lote = 5:

```
CosteUnitario BIZCOCHO = Standard Cost = 2.00 €/ud
Coste Lote BIZCOCHO = Cantidad × CosteUnitario
                    = 5 × 2.00 = 10.00 €
```

**Estado después de cargar:**
| Componente | Cantidad Lote | CosteUnitario | Coste Lote | Origen |
|------------|---------------|---------------|------------|--------|
| HARINA | 2.50 kg | 0.80 €/kg | 2.00 € | Ficha |
| HUEVOS | 30 uds | 0.15 €/ud | 4.50 € | Ficha |
| AZUCAR | 1.00 kg | 1.20 €/kg | 1.20 € | Ficha |
| **BIZCOCHO-001** | **5 uds** | **2.00 €/ud** | **10.00 €** | **Ficha** |
| CHOCOLATE | 0.30 kg | 5.00 €/kg | 1.50 € | Ficha |

---

#### **PASO 2: Recálculo con "Calcular Costes y Precios"**

El sistema detecta que BIZCOCHO-001 tiene sub-receta (Assembly BOM = true) y ejecuta el proceso recursivo:

**2.1. Suma los "Coste Lote" de los componentes de BIZCOCHO-001:**
```
Total Coste Lote hijos = HARINA + HUEVOS + AZUCAR
                       = 2.00 + 4.50 + 1.20 = 7.70 €
```

**2.2. Sobrescribe el "Coste Lote" de BIZCOCHO-001:**
```
ANTES: Coste Lote BIZCOCHO = 10.00 € (5 × 2.00)
AHORA: Coste Lote BIZCOCHO = 7.70 € (suma de componentes reales)
```

**2.3. Recalcula el CosteUnitario de BIZCOCHO-001:**
```
CosteUnitario BIZCOCHO = Coste Lote / Cantidad por Lote
                       = 7.70 / 5 = 1.54 €/ud
```

**Estado después de recalcular:**
| Componente | Cantidad Lote | CosteUnitario | Coste Lote | Cambio |
|------------|---------------|---------------|------------|--------|
| HARINA | 2.50 kg | 0.80 €/kg | 2.00 € | Sin cambio |
| HUEVOS | 30 uds | 0.15 €/ud | 4.50 € | Sin cambio |
| AZUCAR | 1.00 kg | 1.20 €/kg | 1.20 € | Sin cambio |
| **BIZCOCHO-001** | **5 uds** | **1.54 €/ud** ⬇️ | **7.70 €** ⬇️ | **✅ Recalculado** |
| CHOCOLATE | 0.30 kg | 5.00 €/kg | 1.50 € | Sin cambio |

---

#### **Diferencias Clave:**

| Campo | Inicial | Después del botón | Diferencia |
|-------|---------|-------------------|------------|
| **Coste Lote BIZCOCHO** | 10.00 € | 7.70 € | -2.30 € (-23%) |
| **CosteUnitario BIZCOCHO** | 2.00 €/ud | 1.54 €/ud | -0.46 €/ud (-23%) |

**¿Por qué la diferencia?**
- **Inicial**: Usa el Standard Cost (2.00 €) de la ficha, multiplicado por la cantidad
- **Recálculo**: Suma el coste REAL de los componentes (7.70 €), que es menor que lo planificado

**¿Qué componentes se modifican?**
- ✅ **Solo BIZCOCHO-001** (porque tiene Assembly BOM = true)
- ❌ HARINA, HUEVOS, AZUCAR, CHOCOLATE mantienen sus valores (sin sub-receta)
**Resultado:** El CosteUnitario cambia de 2.00 € a 1.54 € porque refleja el coste real de los componentes.

---

## 6. Impacto Funcional

### 6.1. En Recetas (BOM Component)

- **Página:** 50001 "Subformulario Receta"
- **Comportamiento:** Solo aplica cálculo inicial (no tiene botón de recálculo)
- **Uso recomendado:** Para recetas maestras con costes estándar fijos
| Campo | Cálculo | Solo si tiene sub-receta |
|-------|---------|--------------------------|
| **Coste Lote** | Suma de "Coste Lote" de componentes hijos | ✅ Sí |
| **CosteUnitario** | Coste Lote (recalculado) / Cantidad por Lote | ✅ Sí |
| **Coste Calculado** | Quantity per × CosteUnitario (recalculado) | ✅ Sí |
| **Importancia en Coste** | (Coste Lote / Coste Total Producto) × 100 | ❌ No (todos) |
  - **Cálculo inicial** al crear el evento (costes planificados)
  - **Recálculo** al confirmar componentes reales (costes efectivos)

### 6.3. Otros Cálculos Derivados

El botón "Calcular Costes y Precios" también:
1. **Actualiza "Coste Calculado"**: `Quantity per × CosteUnitario`
2. **Recalcula "Importancia en Coste"**: Peso porcentual del componente en el coste total
3. **Distribuye costes indirectos**: Reparte recursos y otros costes proporcionales
4. **Actualiza precios de venta**: Aplica márgenes según configuración

---

## 7. Recomendaciones Funcionales

### 7.1. Cuándo usar el Cálculo Inicial

✅ Usar cuando:
- Los productos tienen costes estándar bien definidos
- No hay cambios frecuentes en componentes
- Se trabaja con recetas maestras estables

### 7.2. Cuándo ejecutar "Calcular Costes y Precios"

✅ Ejecutar cuando:
- Se han modificado componentes del evento
- Se necesita el coste real acumulado de sub-recetas
- Se quiere validar la diferencia entre coste planificado vs. real
- Antes de confirmar presupuestos o pedidos

### 7.3. Precauciones

⚠️ **Atención:**
- El recálculo **sobrescribe** el coste estándar inicial
- Puede causar diferencias si los componentes hijos no están actualizados
- No hay "Deshacer" automático; se debe volver a cargar desde las fichas maestras
- La "Cantidad por Lote" debe estar correctamente informada en todos los niveles

---

## 8. Campos Relacionados Afectados

### 8.1. Campos que se actualizan con el Recálculo

| Campo | Cálculo |
|-------|---------|
| **Coste Lote** | Suma de costes de componentes hijos |
| **CosteUnitario** | Coste Lote / Cantidad por Lote |
| **Coste Calculado** | Quantity per × CosteUnitario |
| **Importancia en Coste** | (Coste Lote / Coste Total Producto) × 100 |

### 8.2. Campos que NO se modifican

| Campo | Origen |
|-------|--------|
| **Standard Cost** (ficha producto) | ❌ No cambia |
| **Unit Cost** (ficha producto/recurso) | ❌ No cambia |
| **Cantidad por Lote** | ❌ No cambia |
| **Quantity per** | ❌ No cambia |

---

## 9. Trazabilidad Técnica

### 9.1. Archivos y Procedimientos Clave

| Archivo | Procedimiento/Trigger | Líneas | Función |
|---------|----------------------|--------|---------|
| `AlxiaBOMComponent.TableExt.al` | `OnAfterValidate("No.")` | 187-243 | Cálculo inicial al añadir producto/recurso |
| `AlxiaBOMComponent.TableExt.al` | `OnAfterValidate("Unit of Measure Code")` | 246-257 | Actualiza coste al cambiar UM |
| `Evento.Table.al` | `gfu_CalculoCostesPrecios()` | 942-1402 | Proceso completo de cálculo de evento |
| `Evento.Table.al` | `CalcularCosteLMRecursivo()` | 2204-2235 | Recálculo recursivo de costes |
| `AlxiaItems.TableExt.al` | `ActualizarImportanciaEnCosteEventos()` | 342-398 | Actualiza porcentaje de importancia |

### 9.2. Flujo de Ejecución del Botón

```
Usuario hace clic en "Calcular Costes y Precios"
    ↓
_Componentes Evento_.Page.al, action trigger (línea 137-154)
    ↓
Item.ActualizarImportanciaEnCosteEventos() [Pre-cálculo]
    ↓
recEvento.gfu_CalculoCostesPrecios() [Proceso principal]
    ↓
Para cada línea del evento:
    ├── Calcula coste directo (suma Coste Lote)
    ├── CalcularCosteLMRecursivo() [AQUÍ SE MODIFICA CosteUnitario]
    ├── Calcula costes indirectos (recursos)
    ├── Calcula márgenes y precios propuestos
    └── Actualiza totales del evento
```

---

## 10. Preguntas Frecuentes (FAQ)

### ❓ ¿Por qué cambia el "Coste Lote" al calcular costes?

**Respuesta:** Porque el botón **SOLO recalcula productos con sub-recetas** (Assembly BOM = true). En lugar de usar el coste estándar de la ficha multiplicado por la cantidad, suma el "Coste Lote" REAL de todos sus componentes hijos.

**Ejemplo:**
- **Inicial**: Coste Lote = 5 uds × 2.00 €/ud = 10.00 € (usa Standard Cost)
- **Recálculo**: Coste Lote = Suma componentes = 7.70 € (usa costes reales)

### ❓ ¿Por qué el "CosteUnitario" también cambia?

Porque después de recalcular el "Coste Lote", el sistema recalcula el CosteUnitario dividiendo el nuevo Coste Lote por la Cantidad:

```
CosteUnitario = Coste Lote (recalculado) / Cantidad por Lote
              = 7.70 / 5 = 1.54 €/ud
```

Antes era 2.00 €/ud (de la ficha), ahora es 1.54 €/ud (calculado).

### ❓ ¿Qué productos se modifican al hacer clic en el botón?

**Se modifican:**
- ✅ Productos con sub-recetas (Assembly BOM = true)
- ✅ Solo los campos: Coste Lote, CosteUnitario, Coste Calculado
   - `Coste Lote = Cantidad × CosteUnitario (de la ficha)`
3. **Recálculo**: Preciso, basado en componentes reales, ideal para confirmación
   - `Coste Lote = SUMA de Coste Lote de componentes hijos` (solo si tiene sub-receta)
4. **Sobrescritura crítica**: El botón **modifica "Coste Lote" y "CosteUnitario"** de productos con sub-recetas
5. **Selectivo**: Solo afecta a productos con Assembly BOM = true
6. **Uso recomendado**: Ejecutar "Calcular Costes" cuando necesites validar costes efectivos de productos con sub-recetas

### Resumen Visual del Cambio

```
PRODUCTO CON SUB-RECETA (BIZCOCHO-001):

  CARGA INICIAL:
  ┌─────────────────────────────────────────────┐
  │ Cantidad por Lote: 5 uds                    │
  │ CosteUnitario: 2.00 €/ud (Standard Cost)    │
  │ Coste Lote: 5 × 2.00 = 10.00 €              │
  └─────────────────────────────────────────────┘

           ↓ [Botón "Calcular Costes y Precios"]

  DESPUÉS DEL RECÁLCULO:
  ┌─────────────────────────────────────────────┐
  │ Cantidad por Lote: 5 uds (sin cambio)       │
  │ CosteUnitario: 1.54 €/ud ⬇️ (recalculado)   │
  │ Coste Lote: 7.70 € ⬇️ (suma de componentes)│
  └─────────────────────────────────────────────┘
  
  Componentes hijos:
  - HARINA: 2.00 €
  - HUEVOS: 4.50 €
  - AZUCAR: 1.20 €
  ──────────────────
  SUMA:     7.70 € → Nuevo "Coste Lote"
```
- ❌ Recursos (mantienen sus valores iniciales)
- ❌ Materias primas finales (sin componentes)

### ❓ ¿Cómo puedo restaurar el coste original?

**Opción 1 (Recomendada):** Borrar y volver a añadir la línea del componente
```
1. Eliminar la línea de BIZCOCHO-001
2. Volver a seleccionar BIZCOCHO-001 en una nueva línea
3. Configurar la Cantidad por Lote = 5
→ Volverá a calcular: Coste Lote = 5 × 2.00 = 10.00 €
```

**Opción 2:** Modificar manualmente el campo "Cantidad por Lote" (trigger recalcula)
```
1. Cambiar Cantidad por Lote a 0
2. Volver a cambiar a 5
→ Se ejecuta OnValidate: Coste Lote = 5 × CosteUnitario
```

**⚠️ Nota:** Si vuelves a hacer clic en "Calcular Costes", se recalculará de nuevo con la suma de componentes.

### ❓ ¿El recálculo afecta a la ficha del producto?

**No.** El recálculo solo modifica los campos en la tabla de componentes del evento (`Componentes Evento`). Los campos `Standard Cost` y `Unit Cost` de las fichas maestras (tabla `Item` y `Resource`) permanecen inalterados.

| Tabla | Campo | ¿Se modifica? |
|-------|-------|---------------|
| Componentes Evento | Coste Lote | ✅ Sí |
| Componentes Evento | CosteUnitario | ✅ Sí |
| Item (ficha) | Standard Cost | ❌ No |
| Item (ficha) | Unit Cost | ❌ No |

### ❓ ¿Cuándo debo ejecutar el botón?

**Ejecutar cuando:**
- ✅ Has modificado componentes de productos con sub-recetas
- ✅ Quieres validar el coste real vs. el planificado
- ✅ Antes de confirmar presupuestos (para costes precisos)
- ✅ Necesitas distribuir costes indirectos (recursos)

**NO ejecutar cuando:**
- ❌ Los productos no tienen sub-recetas (no hay efecto)
- ❌ Quieres mantener los costes estándar de las fichas
- ❌ Estás en fase de planificación inicial

### ❓ ¿Por qué mi producto sin sub-receta no cambia al calcular?

**Es correcto.** El proceso `CalcularCosteLMRecursivo` **SOLO aplica a productos con Assembly BOM = true**. Los productos sin sub-recetas mantienen su cálculo inicial:

```al
IF Item."Assembly BOM" THEN BEGIN
    // Solo entra aquí si tiene sub-receta
    ComponentesEvento."Coste Lote" := ComponentesEventos2."Coste Lote";
END;
// Si no tiene sub-receta, NO modifica nada
```

---

## 11. Conclusiones

1. **Dos lógicas diferentes**: El sistema utiliza dos métodos de cálculo con propósitos distintos
2. **Cálculo inicial**: Rápido, basado en fichas maestras, ideal para planificación
3. **Recálculo**: Preciso, basado en componentes reales, ideal para confirmación
4. **Sobrescritura**: El botón modifica el coste inicial, requiere precaución
5. **Uso recomendado**: Ejecutar "Calcular Costes" solo cuando se necesite validar costes efectivos

---

**Documento elaborado por:** GitHub Copilot  
**Revisión técnica requerida:** Sí  
**Audiencia:** Equipo funcional y técnico  
**Próxima revisión:** Al modificar lógica de cálculo de costes
