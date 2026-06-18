table 50038 PuntosdeObservaciones
{
    DataClassification = CustomerContent;
    Caption = 'Puntos de Observaciones';

    fields
    {
        field(1; "Codigo Punto Observacion"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Código punto observación';
        }
        field(2; Descripcion; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripción';
        }
    }
    keys
    {
        key(Key1; "Codigo Punto Observacion")
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
