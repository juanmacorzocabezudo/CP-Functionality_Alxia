table 50039 LineasPuntosDeObservacion
{
    DataClassification = CustomerContent;
    Caption = 'Líneas Puntos de Observacion';

    fields
    {
        field(1; "Codigo Punto Observacion"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Código punto observación';
        }
        field(2; "Nro. Linea"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'N° línea';
        }
        field(3; Observacion; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Observación';
        }
    }
    keys
    {
        key(Key1; "Codigo Punto Observacion", "Nro. Linea")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    // Add changes to field groups here
    }
    procedure NextLineNo(): Integer var
        Lines: Record LineasPuntosDeObservacion;
    begin
        Lines.Reset();
        Lines.SetRange("Codigo Punto Observacion", Rec."Codigo Punto Observacion");
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
