page 50046 "Work Center Document List"
{
    ApplicationArea = All;
    Caption = 'Lista Centro Trabajo';
    PageType = List;
    SourceTable = "Work center Header";
    UsageCategory = Administration;
    CardPageID = "Work Center Document";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Unit of Mesaruement"; Rec."Unit of Mesaruement")
                {
                    ApplicationArea = All;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                }
                field("Total Cost"; Rec."Total Cost")
                {
                    ApplicationArea = All;
                }
            }
            part(Part1;50045)
            {
                ApplicationArea = All;
                Editable = true;
                Caption = 'Recursos';
                SubPageLink = "Work Center No."=FIELD("No.");
            }
        }
    }
    actions
    {
        area(Processing)
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
        }
    }
}
