table 50040 PuntosdeControl
{
    DataClassification = CustomerContent;
    Caption = 'Puntos de Control';

    fields
    {
        field(1; "Codigo Punto Control"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Código punto de control';
        }
        field(2; Descripcion; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripción';
        }
    }
    keys
    {
        key(Key1; "Codigo Punto Control")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    // Add changes to field groups here
    }
    var myInt: Integer;
    trigger OnInsert()
    begin
    end;
    trigger OnModify()
    begin
    end;
    trigger OnDelete()
    begin
    end;
    trigger OnRename()
    begin
    end;
}
