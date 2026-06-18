page 50044 "Work Center Document"
{
    Caption = 'Centro Trabajo';
    PageType = Document;
    SourceTable = "Work center Header";
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
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
                field("Total Cost"; Rec."Total Cost")
                {
                    ApplicationArea = All;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                }
            }
            part(Part1;50045)
            {
                ApplicationArea = All;
                Editable = true;
                SubPageLink = "Work Center No."=FIELD("No.");
            }
        }
    }
}
