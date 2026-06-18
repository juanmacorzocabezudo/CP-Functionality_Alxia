page 50143 SuministroRecursos
{
    ApplicationArea = All;
    Caption = 'Suministro por Recursos';
    PageType = List;
    SourceTable = "Supply By Resource";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Resource; Rec.Resource)
                {
                    ApplicationArea = All;
                }
                field("Resource Name"; Rec."Resource Name")
                {
                    ApplicationArea = All;
                }
                field("Type"; Rec."Type")
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("UofM Supply"; Rec."UofM Supply")
                {
                    ApplicationArea = All;
                }
                field("Quantity per"; Rec."Quantity per")
                {
                    ApplicationArea = All;
                }
                field(Price; Rec.Price)
                {
                    ApplicationArea = All;
                }
                field(Cost; Rec.Cost)
                {
                    ApplicationArea = All;
                }
                field(Machine; Rec.Machine)
                {
                    ApplicationArea = All;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                }
                field("Resource Direct Cost"; Rec."Resource Direct Cost")
                {
                    ApplicationArea = All;
                }
                field("UofM Resource"; Rec."UofM Resource")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
