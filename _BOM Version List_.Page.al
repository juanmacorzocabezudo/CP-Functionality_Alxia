page 50049 "BOM Version List"
{
    ApplicationArea = All;
    Caption = 'BOM Version List';
    PageType = List;
    SourceTable = "BOM Version Header";
    UsageCategory = Administration;
    CardPageID = "BOM Version Header";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("BOM Version"; Rec."BOM Version")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Version Date"; Rec."Version Date")
                {
                    ApplicationArea = All;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                }
                field(StandarCost; Rec.StandarCost)
                {
                    ApplicationArea = All;
                }
                field(UnitCost; Rec.UnitCost)
                {
                    ApplicationArea = All;
                }
                field(CosteLMFijado; Rec.CosteLMFijado)
                {
                    ApplicationArea = All;
                }
                field(CostesGenerales; Rec.CostesGenerales)
                {
                    ApplicationArea = All;
                }
                field(ExWork; Rec.ExWork)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
