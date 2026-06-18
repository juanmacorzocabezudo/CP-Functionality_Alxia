page 50056 "Template Cost List"
{
    // #9862 - Se crea la nueva page
    Caption = 'Lista Plantilla coste';
    CardPageID = "Template Cost Header";
    Editable = false;
    PageType = List;
    SourceTable = 50027;

    layout
    {
        area(content)
        {
            repeater(Group)
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
        }
    }
    actions
    {
    }
}
