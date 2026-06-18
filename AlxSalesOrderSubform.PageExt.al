pageextension 50045 AlxSalesOrderSubform extends "Sales Order Subform"
{
    actions
    {
        addafter(ReplaceAllocationAccountWithLines)
        {
            action(Mark)
            {
                ApplicationArea = All;
                Caption = 'Quitar';
                Image = RemoveLine;
                ToolTip = 'Mark Line';

                trigger OnAction()
                begin
                    if UserId = 'BC' then Rec.MarkLine();
                end;
            }
        }
    }
}
