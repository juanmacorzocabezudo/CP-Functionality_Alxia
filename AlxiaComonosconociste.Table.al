table 50015 AlxiaComonosconociste
{
    Caption = 'AlxiaComonosconociste';
    //DataClassification = CustomerContent;
    LookupPageID = AlxiaComonosconociste;

    fields
    {
        field(1; id; Integer)
        {
            Caption = 'id';
            AutoIncrement = true;
        }
        field(2; Valor; Text[250])
        {
            Caption = 'Valor';
        }
    }
    keys
    {
        key(PK; id, Valor)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; id, Valor)
        {
        }
        fieldgroup(Brick; id, Valor)
        {
        }
    }
}
