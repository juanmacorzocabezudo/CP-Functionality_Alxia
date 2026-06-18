page 50003 "Formatos Producto"
{
    DataCaptionFields = "Cod. Formato", Descripcion, Alias;
    PageType = List;
    PopulateAllFields = true;
    SourceTable = "Formato Producto";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cod. Formato"; Rec."Cod. Formato")
                {
                    ApplicationArea = All;
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                }
                field(Alias; Rec.Alias)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}
