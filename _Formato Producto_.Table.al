table 50000 "Formato Producto"
{
    DataCaptionFields = "Cod. Formato", Descripcion, Alias;
    DrillDownPageID = 50003;
    LookupPageID = 50003;

    fields
    {
        field(1; "Cod. Formato"; Code[20])
        {
            Caption = 'Formato';
        }
        field(2; Descripcion; Text[80])
        {
        }
        field(3; Alias; Text[80])
        {
        }
    }
    keys
    {
        key(Key1; "Cod. Formato")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Cod. Formato", Descripcion, Alias)
        {
        }
        fieldgroup(Brick; "Cod. Formato", Descripcion)
        {
        }
    }
}
