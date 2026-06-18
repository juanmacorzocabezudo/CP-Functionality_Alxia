page 50061 "Receta Factbox - Details PROD"
{
    // #9785 - Se introduce el coste unitario
    Caption = 'Receta - Detalles';
    PageType = CardPart;
    SourceTable = Item;

    layout
    {
        area(content)
        {
            group(ItemInf)
            {
                Caption = 'Informacion Producto';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Nº Producto';
                }
                field(PerBeneficioFixedWork; FORMAT(AsmInfoPaneMgt.CalcPerBeneficioSobrePrecio(Rec, TRUE, FALSE, FALSE, FALSE, FALSE)) + '%')
                {
                    ApplicationArea = All;
                    Caption = '% Beneficio (FIJADO)';
                }
                field(ExWorkSTDFijado; AsmInfoPaneMgt.CalcAditionalFixedTotalCoste(Rec."No.", 0) + Rec.Receta_CosteLMFijado)
                {
                    ApplicationArea = All;
                    Caption = 'ExWork (FIJADO)';
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(BeneficiosGeneralesFijado; AsmInfoPaneMgt.CalcBeneficioSobrePrecio(Rec, TRUE, FALSE, FALSE, FALSE, FALSE))
                {
                    ApplicationArea = All;
                    Caption = 'Beneficio (FIJADO)';
                }
                field(CostesGeneralesFijados; AsmInfoPaneMgt.CalcAditionalFixedTotalCoste(Rec."No.", 0) - AsmInfoPaneMgt.CalcBeneficioSobrePrecio(Rec, TRUE, FALSE, FALSE, FALSE, FALSE))
                {
                    ApplicationArea = All;
                    Caption = 'Costes Generales (FIJADO)';
                }
                field(Receta_CosteLMFijado; Rec.Receta_CosteLMFijado)
                {
                    ApplicationArea = All;
                    Caption = 'Coste LM (FIJADO)';
                }
            }
        }
    }
    actions
    {
    }
    var AsmInfoPaneMgt: Codeunit AlxiaFuncionesImportadas;
}
