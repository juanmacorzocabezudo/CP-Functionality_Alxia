page 50045 "Work Center Subpage"
{
    Caption = 'Subpage Centro Trabajo';
    PageType = ListPart;
    SourceTable = "Work Center Line";
    DelayedInsert = true;
    LinksAllowed = false;
    Editable = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Resource Name"; Rec."Resource Name")
                {
                    ApplicationArea = All;
                }
                field("Quantity per"; Rec."Quantity per")
                {
                    ApplicationArea = All;
                }
                field("Unit of Mesaruement"; Rec."Unit of Mesaruement")
                {
                    ApplicationArea = All;
                }
                field("Resource Cost"; Rec."Resource Cost")
                {
                    ApplicationArea = All;
                }
                field(Cost; Rec.Cost)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Supply Bu Resource")
            {
                Caption = 'Suministros por recursos';
                ApplicationArea = All;
                Image = ResourceCosts;
                RunObject = Page 50043;
                RunPageLink = Resource=FIELD("No.");
            }
            action("Resources Usage")
            {
                Caption = 'Puntos de uso';
                ApplicationArea = All;
                Image = Track;
                RunObject = Page 50055;
                RunPageLink = "No."=FIELD("No.");
                RunPageView = SORTING("Parent Item No.", "Line No.")ORDER(Ascending)WHERE(Type=CONST(Resource));
            }
        }
    }
}
