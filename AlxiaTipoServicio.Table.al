table 50033 AlxiaTipoServicio
{
    Caption = 'AlxiaTipoServicio';
    DataClassification = CustomerContent;
    LookupPageId = AlxiaTipoServicio;

    fields
    {
        field(1; "Código"; Code[20])
        {
            Caption = 'Código ';
        }
        field(2; "Descripción"; Text[250])
        {
            Caption = 'Descripción ';
        }
        field(3; "Requiere Info calidad"; Boolean)
        {
            Caption = 'Requiere Info calidad';
        }
    }
    keys
    {
        key(PK; "Código")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Código", "Descripción")
        {
        }
        fieldgroup(Brick; "Código", "Descripción")
        {
        }
    }
}
