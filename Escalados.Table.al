table 50017 Escalados
{
    fields
    {
        field(1; NumeroLM; Code[20])
        {
            Caption = 'Nº L.M.';
            Editable = false;
        }
        field(2; NumeroLinea; Integer)
        {
            Caption = 'Nº Línea';
            Editable = false;
        }
        field(3; Tipo; Option)
        {
            Editable = false;
            OptionCaption = ' ,Producto,Recurso';
            OptionMembers = " ", Producto, Recurso;
        }
        field(4; Numero; Code[20])
        {
            Caption = 'Nº';
            Editable = false;

            trigger OnValidate()
            var
                Productos: Record 27;
            begin
                Productos.RESET();
                Productos.SETRANGE("No.", Numero);
                IF Productos.FINDFIRST()THEN BEGIN
                    CodigoUnidadMedida:=Productos."Base Unit of Measure";
                    Descripcion:=Productos.Description;
                END;
            end;
        }
        field(5; Descripcion; Text[50])
        {
            Caption = 'Descripción';
            Editable = true;
        }
        field(6; CodigoUnidadMedida; Code[10])
        {
            Caption = 'Cód. unidad medida';
            Editable = false;
        }
        field(7; LoteReceta; Integer)
        {
            Caption = 'Lote Receta';
        }
        field(8; CantidadLoteReceta; Decimal)
        {
            Caption = 'Cantidad por Lote Receta';

            trigger OnValidate()
            var
                ltx_Pregunta: Text;
            begin
                // Inicio ADV001
                IF gt_Item.GET(NumeroLM)THEN IF gt_Item."Lote Receta" = LoteReceta THEN IF gt_Componente.GET(NumeroLM, NumeroLinea)THEN IF gt_Componente."Cantidad por Lote" <> CantidadLoteReceta THEN BEGIN
                                ltx_Pregunta:=('La Cantidad por Lote Receta especificada: ' + FORMAT(CantidadLoteReceta) + ', no coincide con la Cantidad por Lote definida en la Receta: ' + FORMAT(gt_Componente."Cantidad por Lote") + '.' + '\' + Text002 + '\' + Text003);
                                IF DIALOG.CONFIRM(ltx_Pregunta)THEN gfu_ActualizarCantidad;
                            END;
            // Fin ADV001
            end;
        }
        field(9; TipoTramo; Option)
        {
            Caption = 'Tipo de tramo';
            OptionCaption = 'Inferior,Más cercano,Superior';
            OptionMembers = Inferior, "Más cercano", Superior;
        }
        field(10; CalculoProporcional; Boolean)
        {
            Caption = 'Cálculo proporcional';
        }
    }
    keys
    {
        key(Key1; NumeroLM, NumeroLinea, Tipo, Numero, Descripcion, CodigoUnidadMedida, LoteReceta)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        // Inicio ADV001
        // Por defecto marcar el check de Proporcional
        CalculoProporcional:=TRUE;
    // Fin ADV001
    end;
    var gt_Item: Record 27;
    gt_Componente: Record 90;
    Text001: Label 'The Quantity per Lot Recipe specified does not match the Quantity per Lot defined in the Recipe';
    Text002: Label 'Do you want to update the amount defined in the Recipe?.';
    Text003: Label '(Remember that you must re-pass the Standard Cost Estimate so that the costs are consistent with this new amount).';
    procedure gfu_ActualizarCantidad()
    begin
        // Inicio ADV001
        gt_Componente.VALIDATE(gt_Componente."Cantidad por Lote", CantidadLoteReceta);
        gt_Componente.MODIFY;
    // Fin ADV001
    end;
}
