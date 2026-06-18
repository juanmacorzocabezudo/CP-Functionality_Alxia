pageextension 50012 AlixiaResourceList extends "Resource List"
{
    actions
    {
        addafter("Co&mments")
        {
            action(Supply)
            {
                Caption = 'Lista Suministros';
                ApplicationArea = All;
                Image = Tools;
                PromotedCategory = Process;
                RunObject = Page 50042;
                Promoted = true;
                PromotedIsBig = true;
            }
            action("Supply Bu Resource")
            {
                Caption = 'Suministros por recursos';
                ApplicationArea = All;
                Image = ResourceCosts;
                PromotedCategory = Process;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page 50043;
                RunPageLink = Resource=FIELD("No.");
            }
            action("Resources Usage")
            {
                Caption = 'Uso de los recursos';
                ApplicationArea = All;
                PromotedCategory = Process;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page 50055;
                RunPageLink = "No."=FIELD("No.");
                RunPageView = SORTING("Parent Item No.", "Line No.")ORDER(Ascending)WHERE(Type=CONST(Resource));
            }
        }
    }
}
