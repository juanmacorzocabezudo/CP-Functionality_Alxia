page 50058 "Template Cost Lines"
{
    // #9862 - Se crea la nueva page
    Caption = 'Lineas Plantilla costes';
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = 50028;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No. Cost"; Rec."No. Cost")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Type Coste"; Rec."Type Coste")
                {
                    ApplicationArea = All;
                }
                field(Value; Rec.Value)
                {
                    ApplicationArea = All;
                }
                field("Apply on all cost"; Rec."Apply on all cost")
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
