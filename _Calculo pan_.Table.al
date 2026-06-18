table 50007 "Calculo pan"
{
    fields
    {
        field(1; "Cod. Tipo Evento"; Code[20])
        {
            TableRelation = "Tipo de Evento";
        }
        field(2; "Cod. Variedad Evento"; Code[20])
        {
            TableRelation = "Variedad de Evento";
        }
        field(3; "Descripcion Tipo Evento"; Text[50])
        {
            CalcFormula = Lookup("Tipo de Evento".Descripcion WHERE(Codigo=FIELD("Cod. Tipo Evento")));
            Caption = 'Descripción Tipo Evento';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; "Descripcion Variedad Evento"; Text[50])
        {
            CalcFormula = Lookup("Variedad de Evento".Descripcion WHERE(Codigo=FIELD("Cod. Variedad Evento")));
            Caption = 'Descripción Variedad Evento';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; "Cantidad Barras"; Decimal)
        {
        }
        field(6; "Precio Barras"; Decimal)
        {
        }
        field(7; "Cantidad Pan Gallego"; Decimal)
        {
        }
        field(8; "Precio Pan Gallego"; Decimal)
        {
        }
        field(9; "Cantidad Colines"; Decimal)
        {
        }
        field(10; "Precio Colines"; Decimal)
        {
        }
        field(11; "Cantidad Alcachofas"; Decimal)
        {
        }
        field(12; "Precio Alcachofas"; Decimal)
        {
        }
    }
    keys
    {
        key(Key1; "Cod. Tipo Evento", "Cod. Variedad Evento")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
