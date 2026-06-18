page 50122 "Tabla Precios"
{
    ApplicationArea = All;
    Caption = 'TABLA PRECIOS';
    PageType = List;
    SourceTable = "Purchase Price";
    UsageCategory = Lists;
    Description = 'GAP00050';
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    LinksAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the number of the item that the purchase price applies to.';
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ToolTip = 'Specifies the number of the vendor who offers the line discount on the item.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the currency code of the purchase price.';
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ToolTip = 'Specifies the date from which the purchase price is valid.';
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    ToolTip = 'Specifies the cost of one unit of the selected item or resource.';
                }
                field("Minimum Quantity"; Rec."Minimum Quantity")
                {
                    ToolTip = 'Specifies the minimum quantity of the item that you must buy from the vendor in order to get the purchase price.';
                }
                field("Ending Date"; Rec."Ending Date")
                {
                    ToolTip = 'Specifies the date to which the purchase price is valid.';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ToolTip = 'Specifies how each unit of the item or resource is measured, such as in pieces or hours. By default, the value in the Base Unit of Measure field on the item or resource card is inserted.';
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ToolTip = 'Specifies the variant of the item on the line.';
                }
                field(AGRALADescription; Rec.AGRALADescription)
                {
                    ToolTip = 'Specifies the value of the Descripción del producto field.', Comment = '%';
                }
                field(Definicion; Rec.Definicion)
                {
                    ToolTip = 'Specifies the value of the Definicion field.', Comment = '%';
                }
                field(AGRALAVendorName; Rec.AGRALAVendorName)
                {
                    ToolTip = 'Specifies the value of the Nombre proveedor field.', Comment = '%';
                }
                field(AGRALALineDiscount; Rec.AGRALALineDiscount)
                {
                    ToolTip = 'Specifies the value of the % Descuento linea field.', Comment = '%';
                }
                field(AGRALAImporteDescontado; Rec.AGRALAImporteDescontado)
                {
                    ToolTip = 'Specifies the value of the Coste unit. direct. con descuento field.', Comment = '%';
                }
                field("Mejor Proveedor"; Rec."Mejor Proveedor")
                {
                    ToolTip = 'Specifies the value of the Mejor Proveedor field.', Comment = '%';
                }
            }
        }
    }
}
