page 50043 "Supply By Resource"
{
    Caption = 'Suministro por recurso';
    PageType = List;
    SourceTable = 50021;

    //UsageCategory = Administration;
    //ApplicationArea = All;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field(Resource; Rec.Resource)
                {
                    ApplicationArea = All;
                }
                field("Resource Name"; Rec."Resource Name")
                {
                    ApplicationArea = All;
                }
                field("UofM Resource"; Rec."UofM Resource")
                {
                    ApplicationArea = All;
                }
                field("Resource Direct Cost"; Rec."Resource Direct Cost")
                {
                    ApplicationArea = All;
                }
            }
            repeater(Group)
            {
                field(Recurso; Rec.Resource)
                {
                    ApplicationArea = All;
                }
                field(RecursoNombre; Rec."Resource Name")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
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
            }
        }
    }
    actions
    {
    }
}
