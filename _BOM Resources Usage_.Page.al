page 50055 "BOM Resources Usage"
{
    Caption = 'Puntos de Uso Recursos';
    Editable = false;
    PageType = List;
    SourceTable = 90;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Parent Item No."; Rec."Parent Item No.")
                {
                    ApplicationArea = All;
                }
                field("Parent Item Desciption"; Rec."Parent Item Desciption")
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
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
                field("Assembly BOM"; Rec."Assembly BOM")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Quantity per"; Rec."Quantity per")
                {
                    ApplicationArea = All;
                }
                field("Cantidad por Lote"; Rec."Cantidad por Lote")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(RECETA)
            {
                Caption = 'RECETA';
                ApplicationArea = All;
                Enabled = true;
                Image = BOM;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;
                RunObject = Page 50000;
                RunPageLink = "No."=FIELD("Parent Item No.");
                RunPageMode = Create;
                RunPageView = SORTING("No.")ORDER(Ascending);
            }
        }
    }
}
