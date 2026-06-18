table 50036 AlxRecetasNiveles
{
    Caption = 'AlxRecetasNiveles';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Parent Item No."; Code[20])
        {
            Caption = 'Producto', Comment = 'ESP="Producto"';
            NotBlank = true;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'N Linea', Comment = 'ESP="N Linea"';
        }
        field(3; Type;Enum "BOM Component Type")
        {
            Caption = 'Tipo';
        }
        field(4; "No."; Code[20])
        {
            Caption = 'Nº Producto', Comment = 'ESP="Nº Producto"';
        }
        field(5; "Assembly BOM"; Boolean)
        {
            Caption = 'L.M. de ensamblado', Comment = 'ESP="L.M. de ensamblado"';
        }
        field(6; Description; Text[100])
        {
            Caption = 'Descripción', Comment = 'ESP="Descripción"';
        }
        field(7; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unidad de medida', Comment = 'ESP="Unidad de medida"';
        }
        field(8; "Quantity per"; Decimal)
        {
            Caption = 'Cantidad por', Comment = 'ESP="Cantidad por"';
        }
        field(9; Position; Code[10])
        {
            Caption = 'Posicion', Comment = 'ESP="Posicion"';
        }
        field(10; "Position 2"; Code[10])
        {
            Caption = 'Posicion 2';
        }
        field(11; "Position 3"; Code[10])
        {
            Caption = 'Posicion 3';
        }
        field(12; "Machine No."; Code[10])
        {
            Caption = 'Machine No.', Comment = 'ESP="Machine No."';
        }
        field(13; "Lead-Time Offset"; DateFormula)
        {
            Caption = 'Lead-Time Offset';
        }
        field(14; "BOM Description"; Text[100])
        {
            CalcFormula = lookup(Item.Description where("No."=field("Parent Item No.")));
            Caption = 'Description L.M. de ensamblado', Comment = 'ESP="Description L.M. de ensamblado"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(20; "Resource Usage Type"; Option)
        {
            Caption = 'Tipo uso recurso';
            OptionCaption = 'Direct,Fixed';
            OptionMembers = Direct, "Fixed";
        }
        field(5402; "Variant Code"; Code[10])
        {
            Caption = 'Marca';
        }
        field(5900; "Installed in Line No."; Integer)
        {
            Caption = 'Installed in Line No.';
        }
        field(5901; "Installed in Item No."; Code[20])
        {
            Caption = 'Instalado en nº prod.';
        }
        field(50000; "Cantidad por Lote"; Decimal)
        {
            Caption = 'Cantidad por Lote';
            DecimalPlaces = 0: 6;
        }
        field(50001; "Importancia en Coste"; Decimal)
        {
            Caption = 'Importancia en Coste';
            Editable = false;
        }
        field(50002; "Cantidad por Bandeja"; Decimal)
        {
            Caption = 'Cantidad por Bandeja';
            Enabled = false;
        }
        field(50003; "Proveedor por Defecto"; Code[20])
        {
            Caption = 'Proveedor por Defecto';
            CalcFormula = Lookup(Item."Vendor No." WHERE("No."=FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50004; CosteUnitario; Decimal)
        {
            Caption = 'Coste Unitario';
            Description = '#9993 Se cambia el nombre en ESP';
            Editable = false;
        }
        field(50005; Comentario; Text[80])
        {
            Caption = 'Comentario';
        }
        field(50007; "Coste Calculado"; Decimal)
        {
            caption = 'Coste Calculado';
            Editable = false;
        }
        field(50010; TipoRecurso; Option)
        {
            Caption = 'Tipo Recurso';
            Editable = false;
            OptionCaption = ' ,Persona,Maquina';
            OptionMembers = " ", Person, Machine;
        }
        field(50015; "Related Work Center"; Code[20])
        {
            Caption = 'No. Centro trabajo';
            Description = '#9785';
            Editable = false;
        }
        field(50016; Maquila; Boolean)
        {
            Caption = 'Maquila';
        }
        field(50020; "Perc. Loss"; Decimal)
        {
            Caption = '% Merma';
            Description = '#9862';
        }
        field(50021; "Net Amount"; Decimal)
        {
            Caption = 'Cantidad neta', Comment = 'ESP="Cantidad neta"';
            Description = '#9862';
            Editable = false;
        }
        field(50030; "Parent Item Desciption"; Text[100])
        {
            CalcFormula = Lookup(Item.Description WHERE("No."=FIELD("Parent Item No.")));
            Caption = 'Descripcion receta madre', Comment = 'ESP="Descripcion receta madre"';
            Description = '#9993';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50031; Nivel; Option)
        {
            Caption = 'Nivel';
            OptionCaption = '00 - Receta madre,01 - Nivel,02 - Nivel,03 - Nivel,04 - Nivel,05 - Nivel';
            OptionMembers = "00 - Receta madre", "01 - Nivel", "02 - Nivel", "03 - Nivel", "04 - Nivel", "05 - Nivel";
        }
        field(50032; ProductoBase; Code[20])
        {
            Caption = 'Producto Base';
        }
        field(50033; LineNo; Integer)
        {
            Caption = 'Line No';
            AutoIncrement = true;
        }
        field(50034; Bloqueado; Boolean)
        {
            Caption = 'Bloqueado';
            Editable = false;
        }
        field(50035; "Lote receta"; Integer)
        {
            Caption = 'Lote receta';
            Editable = false;
        }
        field(50036; "Statistics Lot"; Decimal)
        {
            Caption = 'Lote Estadistico';
            Editable = false;
        }
        field(50037; "Statistics Unit of Measurement"; Code[20])
        {
            Caption = 'Unidad Medida Estadisticas';
            Editable = false;
        }
        field(50038; "Unidad medida Item"; Code[10])
        {
            Caption = 'Unidad medida base';
            Editable = false;
        }
    }
    keys
    {
        key(Key1; LineNo, "Parent Item No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; Type, "No.")
        {
        }
    }
}
