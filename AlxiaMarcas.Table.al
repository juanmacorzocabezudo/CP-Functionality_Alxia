table 50032 AlxiaMarcas
{
    Caption = 'AlxiaMarcas';
    DataClassification = CustomerContent;
    LookupPageId = AlxiaMarcas;

    fields
    {
        field(1; Codigo; Code[10])
        {
            Caption = 'Codigo';
        }
        field(2; Marca; Text[100])
        {
            Caption = 'Marca';
        }
    }
    keys
    {
        key(PK; Codigo)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; Codigo, Marca)
        {
        }
        fieldgroup(Brick; Codigo, Marca)
        {
        }
    }
}
