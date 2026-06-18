pageextension 50047 AlxPostedSalesCreditMemo extends "Posted Sales Credit Memo"
{
    layout
    {
        addafter("Document Date")
        {
            field("Fecha Servicio"; Rec."Fecha Servicio")
            {
                ApplicationArea = All;
                ShowMandatory = true;
            }
        }
    }
}
