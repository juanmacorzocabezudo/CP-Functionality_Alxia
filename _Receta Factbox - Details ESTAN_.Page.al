page 50063 "Receta Factbox - Details ESTAN"
{
    // #9785 - Se introduce el coste unitario
    Caption = 'Receta - Coste Estandar';
    PageType = CardPart;
    SourceTable = Item;

    layout
    {
        area(content)
        {
            group(StandardCost)
            {
                Caption = 'Coste Estandar Receta';

                field(CosteEstandarActual; AsmInfoPaneMgt.CalcItemCosteCalculado(Rec, FALSE) + AsmInfoPaneMgt.CalcAditionalUnitTotalCosteReceta(Rec."No.", 0, FALSE) - AsmInfoPaneMgt.CalcBeneficioSobrePrecio(Rec, FALSE, FALSE, FALSE, FALSE, TRUE))
                {
                    ApplicationArea = All;
                    Caption = 'Coste Estandar';
                }
                field(TOTALStandardStadisticsCost; AsmInfoPaneMgt.CalcItemStadisticsCost(Rec, 0, FALSE))
                {
                    ApplicationArea = All;
                    Caption = 'TOTAL Std. Stadistics EXWORK';
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(TOTALStandardCost; AsmInfoPaneMgt.CalcAditionalUnitTotalCosteReceta(Rec."No.", 0, FALSE) + AsmInfoPaneMgt.CalcItemCosteCalculado(Rec, FALSE))
                {
                    ApplicationArea = All;
                    Caption = 'TOTAL Std. EXWORK';
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(BeneficioSTD; AsmInfoPaneMgt.CalcBeneficioSobrePrecio(Rec, FALSE, FALSE, FALSE, FALSE, TRUE))
                {
                    ApplicationArea = All;
                    Caption = 'Beneficio Std.';
                }
                field(AddStandardCost; AsmInfoPaneMgt.CalcAditionalUnitTotalCosteReceta(Rec."No.", 0, FALSE) - AsmInfoPaneMgt.CalcBeneficioSobrePrecio(Rec, FALSE, FALSE, FALSE, FALSE, TRUE))
                {
                    ApplicationArea = All;
                    Caption = 'Costes Generales Std.';
                }
                field(CosteTotal; AsmInfoPaneMgt.CalcItemCosteCalculado(Rec, FALSE))
                {
                    ApplicationArea = All;
                    Caption = 'Coste Total LM';
                }
                field(CosteTotalMP; AsmInfoPaneMgt.CalcItemCostCalcProdType(Rec, 'MP*'))
                {
                    ApplicationArea = All;
                    Caption = 'Coste MP';
                }
                field(CosteTotalMA; AsmInfoPaneMgt.CalcItemCostCalcProdType(Rec, 'MA*'))
                {
                    ApplicationArea = All;
                    Caption = 'Coste MA';
                }
                field(CosteTotalRecPersona; AsmInfoPaneMgt.CalcItemCostCalcResType(Rec, 1))
                {
                    ApplicationArea = All;
                    Caption = 'Coste Rec. Persona';
                }
                field(CosteTotalRecMaquina; AsmInfoPaneMgt.CalcItemCostCalcResType(Rec, 2))
                {
                    ApplicationArea = All;
                    Caption = 'Coste Rec. Máq.';
                }
                field(CosteTotalMPPer; FORMAT(AsmInfoPaneMgt.CalcItemPerCostCalcProdType(Rec, 'MP*'), 0) + '%')
                {
                    ApplicationArea = All;
                    Caption = '% Coste MP';
                }
                field(CosteTotalMAPer; FORMAT(AsmInfoPaneMgt.CalcItemPerCostCalcProdType(Rec, 'MA*'), 0) + '%')
                {
                    ApplicationArea = All;
                    Caption = '% Coste MA';
                }
                field(CosteTotalRecPersonaPer; FORMAT(AsmInfoPaneMgt.CalcItemPerCostCalcResType(Rec, 1), 0) + '%')
                {
                    ApplicationArea = All;
                    Caption = '% Coste Rec. Persona';
                }
                field(CosteTotalRecMaquinaPer; FORMAT(AsmInfoPaneMgt.CalcItemPerCostCalcResType(Rec, 2), 0) + '%')
                {
                    ApplicationArea = All;
                    Caption = '% Coste Rec. Máq.';
                }
                field(CosteTotalRestoComp; AsmInfoPaneMgt.CalcItemCostCalcItem(Rec))
                {
                    ApplicationArea = All;
                    Caption = 'Coste Resto Comp';
                    Visible = false;
                }
                field(CosteTotalPos1; AsmInfoPaneMgt.CalcItemCostCalcPosition(Rec, '1'))
                {
                    ApplicationArea = All;
                    Caption = 'Coste Calc. Pos. 1';
                    Visible = false;
                }
                field(CosteTotalPos2; AsmInfoPaneMgt.CalcItemCostCalcPosition(Rec, '2'))
                {
                    ApplicationArea = All;
                    Caption = 'Coste Calc. Pos. 2';
                }
                field(CosteTotalPos3; AsmInfoPaneMgt.CalcItemCostCalcPosition(Rec, '3'))
                {
                    ApplicationArea = All;
                    Caption = 'Coste Calc. Pos. 3';
                    Visible = false;
                }
            }
        }
    }
    actions
    {
    }
    var AsmInfoPaneMgt: Codeunit AlxiaFuncionesImportadas;
}
