page 50057 "Template Cost Header"
{
    // #9862 - Se crea la nueva page
    Caption = 'Cabecera Plantilla coste';
    PageType = Card;
    SourceTable = 50027;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Create Date"; Rec."Create Date")
                {
                    ApplicationArea = All;
                }
                field(TipoPlantilla; Rec.TipoPlantilla)
                {
                    ApplicationArea = All;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                }
            }
            part(part1;50058)
            {
                ApplicationArea = All;
                SubPageLink = "No. Template"=FIELD("No.");
                SubPageView = SORTING("No. Template", "No. Cost");
            }
        }
    }
    actions
    {
    }
}
