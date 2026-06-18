table 50019 AlxiaAlergenos
{
    Caption = 'AlxiaAlergenos';
    DataClassification = CustomerContent;
    LookupPageID = AlxiaAlergenos;

    fields
    {
        field(1; "Line No."; Integer)
        {
            Caption = 'Line No.';
            AutoIncrement = true;
        }
        field(2; Alergeno; Text[250])
        {
            Caption = 'Alergeno';
        }
    }
    keys
    {
        key(PK; "Line No.", Alergeno)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Line No.", Alergeno)
        {
        }
        fieldgroup(Brick; "Line No.", Alergeno)
        {
        }
    }
}
