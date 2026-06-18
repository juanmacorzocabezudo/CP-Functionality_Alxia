table 50041 LineasPuntosDeControl
{
    DataClassification = CustomerContent;
    Caption = 'Líneas Puntos de Control';

    fields
    {
        field(1; "Codigo Punto Control"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Código punto control';
        }
        field(2; "Nro. Linea"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'N° línea';
        }
        field(3; Descripcion; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripción';
        }
    }
    keys
    {
        key(Key1; "Codigo Punto Control", "Nro. Linea")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    // Add changes to field groups here
    }
    procedure NextLineNo(): Integer var
        Lines: Record LineasPuntosDeControl;
    begin
        Lines.Reset();
        Lines.SetRange("Codigo Punto Control", Rec."Codigo Punto Control");
        if Lines.FindLast()then exit(Lines."Nro. Linea" + 1000);
        exit(1000);
    end;
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
