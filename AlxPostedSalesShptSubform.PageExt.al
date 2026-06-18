pageextension 50044 AlxPostedSalesShptSubform extends "Posted Sales Shpt. Subform"
{
    layout
    {
        // Add changes to page layout here
        addlast(Control1)
        {
            field("Unidad Logística en Vigor"; Rec."Unidad Logística en Vigor")
            {
                ApplicationArea = Basic, Suite;
                Description = 'GAP00041';
                Editable = false;
            }
        }
    }
    actions
    {
        // Add changes to page actions here
        addafter(DocumentLineTracking)
        {
            action(Mark)
            {
                ApplicationArea = All;
                Caption = 'Quitar del filtro';
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
