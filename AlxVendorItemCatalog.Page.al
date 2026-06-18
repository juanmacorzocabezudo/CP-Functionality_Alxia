page 50104 AlxVendorItemCatalog
{
    ApplicationArea = All;
    Caption = 'Marca proveedores';
    PageType = List;
    SourceTable = "Item Vendor";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Item No."; Rec."Item No.")
                {
                    Editable = false;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    Caption = 'Marca';
                    Editable = false;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                }
            }
        }
    }
}
