pageextension 50034 AlxPostedPurchInvoiceSubform extends "Posted Purch. Invoice Subform"
{
    layout
    {
        addafter("Line Discount %")
        {
            field("Unit Cost (LCY)2"; Rec."Unit Cost (LCY)")
            {
                ApplicationArea = All;
                Caption = 'Coste unitario con descuento';
            }
        }
    }
}
