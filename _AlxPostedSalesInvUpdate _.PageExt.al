pageextension 50032 "AlxPostedSalesInvUpdate " extends "Posted Sales Invoice - Update"
{
    layout
    {
        addafter("Succeeded Company Name")
        {
            field(CodBancoEmpresaMigr; Rec.CodBancoEmpresaMigr)
            {
                ApplicationArea = All;
                Editable = true;
            }
        }
    }
}
