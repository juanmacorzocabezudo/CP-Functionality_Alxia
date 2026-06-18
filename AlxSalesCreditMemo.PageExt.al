pageextension 50046 AlxSalesCreditMemo extends "Sales Credit Memo"
{
    layout
    {
        addafter("Due Date")
        {
            field("Fecha Servicio"; Rec."Fecha Servicio")
            {
                ApplicationArea = All;
            }
        }
    }
}
