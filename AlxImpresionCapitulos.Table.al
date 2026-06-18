table 50042 AlxImpresionCapitulos
{
    Caption = 'AlxImpresionCapitulos';
    DataClassification = CustomerContent;
    LookupPageId = AlxImpresionCapitulos;

    fields
    {
        field(1; Code; Code[20])
        {
            Caption = 'Codigo';
        }
        field(2; Descripcion; Text[150])
        {
            Caption = 'Descripción';
        }
        field(3; Total; Decimal)
        {
        }
        field(4; CantidadComensales; Integer)
        {
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; Code, Descripcion)
        {
        }
        fieldgroup(Brick; Code, Descripcion)
        {
        }
    }
}
