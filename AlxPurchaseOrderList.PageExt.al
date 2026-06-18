pageextension 50027 AlxPurchaseOrderList extends "Purchase Order List"
{
    layout
    {
        addafter("Location Code")
        {
            field("Vendor Shipment No."; Rec."Vendor Shipment No.")
            {
                ApplicationArea = All;
                Caption = 'Nº albáran proveedor';
            }
        }
    }
}
