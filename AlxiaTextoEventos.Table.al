table 50031 AlxiaTextoEventos
{
    Caption = 'AlxiaTextoEventos';
    DataClassification = CustomerContent;
    LookupPageId = AlxiaTextoEventos;

    fields
    {
        field(1; "Código Texto"; Code[20])
        {
            Caption = 'Código Texto';
        }
        field(2; "Descripción Texto"; Text[2048])
        {
            Caption = 'Descripción Texto';
        }
        field(3; "Texto Saludo"; Text[2048])
        {
            Caption = 'Texto Saludo';
        }
        field(4; "Texto Otras opciones"; Text[2048])
        {
            Caption = 'Texto Otras opciones';
        }
        field(5; "Texto Directrices"; Text[2048])
        {
            Caption = 'Texto Directrices';
        }
        field(6; "Texto Cliente aporta para si"; Text[2048])
        {
            Caption = 'Texto Cliente aporta para si';
        }
        field(7; "Texto Cliente aporta catering"; Text[2048])
        {
            Caption = 'Texto Cliente aporta catering';
        }
        field(8; "Texto Doc. obligatoria"; Text[2048])
        {
            Caption = 'Texto Documentación obligatoria';
        }
        field(9; "Texto Formas de pago"; Text[2048])
        {
            Caption = 'Texto Formas de pago';
        }
        field(10; "Texto Condiciones contratación"; Text[2048])
        {
            Caption = 'Texto Condiciones contratación';
        }
        field(11; "Texto Despedida"; Text[2048])
        {
            Caption = 'Texto Despedida';
        }
    }
    keys
    {
        key(PK; "Código Texto")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Código Texto", "Descripción Texto")
        {
        }
        fieldgroup(Brick; "Código Texto", "Descripción Texto")
        {
        }
    }
}
