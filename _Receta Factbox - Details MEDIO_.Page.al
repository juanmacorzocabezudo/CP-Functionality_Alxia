page 50064 "Receta Factbox - Details MEDIO"
{
    // #9785 - Se introduce el coste unitario
    Caption = 'Receta - Coste Medio';
    PageType = CardPart;
    SourceTable = Item;

    layout
    {
        area(content)
        {
            group(UnitCost)
            {
                Caption = 'Coste Unitario Receta';

                field(CosteUnitarioActual; AsmInfoPaneMgt.CalcItemUnitCosteCalculado(Rec) + AsmInfoPaneMgt.CalcAditionalItemUnitTotalCoste(Rec."No.", 0) - AsmInfoPaneMgt.CalcBeneficioSobrePrecio(Rec, FALSE, FALSE, FALSE, TRUE, FALSE))
                {
                    ApplicationArea = All;
                    Caption = 'Coste Unitario Actual';
                }
                field(TOTALStadisticsUnitCost; AsmInfoPaneMgt.CalcItemStadisticsCost(Rec, 1, TRUE))
                {
                    ApplicationArea = All;
                    Caption = 'EXWORK Estadistico TOTAL';
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(TOTALUnitCost; AsmInfoPaneMgt.CalcAditionalItemUnitTotalCoste(Rec."No.", 0) + AsmInfoPaneMgt.CalcItemUnitCosteCalculado(Rec))
                {
                    ApplicationArea = All;
                    Caption = 'EXWORK Unitario TOTAL';
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(BeneficioUnitCoste; AsmInfoPaneMgt.CalcBeneficioSobrePrecio(Rec, FALSE, FALSE, FALSE, TRUE, FALSE))
                {
                    ApplicationArea = All;
                    Caption = 'Beneficio Unitario';
                }
                field(AddUnitCost; AsmInfoPaneMgt.CalcAditionalItemUnitTotalCoste(Rec."No.", 0) - AsmInfoPaneMgt.CalcBeneficioSobrePrecio(Rec, FALSE, FALSE, FALSE, TRUE, FALSE))
                {
                    ApplicationArea = All;
                    Caption = 'Coste Generales Unitario';
                }
                field(UnitCosteTotal; AsmInfoPaneMgt.CalcItemUnitCosteCalculado(Rec))
                {
                    ApplicationArea = All;
                    Caption = 'Coste Total LM';
                }
                field(UnitCosteTotalMP; AsmInfoPaneMgt.CalcItemUnitCostCalcProdType(Rec, 'MP*'))
                {
                    ApplicationArea = All;
                    Caption = 'Coste MP';
                }
                field(UnitCosteTotalMA; AsmInfoPaneMgt.CalcItemUnitCostCalcProdType(Rec, 'MA*'))
                {
                    ApplicationArea = All;
                    Caption = 'Coste MA';
                }
                field(UnitCosteTotalRecPersona; AsmInfoPaneMgt.CalcItemCostCalcResType(Rec, 1))
                {
                    ApplicationArea = All;
                    Caption = 'Coste Rec. Persona';
                }
                field(UnitCosteTotalRecMaquina; AsmInfoPaneMgt.CalcItemCostCalcResType(Rec, 2))
                {
                    ApplicationArea = All;
                    Caption = 'Coste Rec. Máquina';
                }
                field(UnitCosteTotalRestoComp; AsmInfoPaneMgt.CalcItemUnitCostCalcItem(Rec))
                {
                    ApplicationArea = All;
                    Caption = 'Coste Resto Comp.';
                    Visible = false;
                }
                field(UnitCosteTotalMPPer; FORMAT(AsmInfoPaneMgt.CalcItemPerUnitCostCalcProdType(Rec, 'MP*'), 0) + '%')
                {
                    ApplicationArea = All;
                    Caption = '% Coste MP';
                }
                field(UnitCosteTotalMAPer; FORMAT(AsmInfoPaneMgt.CalcItemPerUnitCostCalcProdType(Rec, 'MA*'), 0) + '%')
                {
                    ApplicationArea = All;
                    Caption = '% Coste MA';
                }
                field(UnitCosteTotalRecPersonaPer; FORMAT(AsmInfoPaneMgt.CalcItemPerCostCalcResType(Rec, 1), 0) + '%')
                {
                    ApplicationArea = All;
                    Caption = '% Coste Rec. Persona';
                }
                field(UnitCosteTotalRecMaquinaPer; FORMAT(AsmInfoPaneMgt.CalcItemPerCostCalcResType(Rec, 2), 0) + '%')
                {
                    ApplicationArea = All;
                    Caption = '% Coste Rec. Máquina';
                }
                field(UnitCosteTotalPos1; AsmInfoPaneMgt.CalcItemUnitCostCalcPosition(Rec, '1'))
                {
                    ApplicationArea = All;
                    Caption = 'Coste Pos. 1';
                    Visible = false;
                }
                field(UnitCosteTotalPos2; AsmInfoPaneMgt.CalcItemUnitCostCalcPosition(Rec, '2'))
                {
                    ApplicationArea = All;
                    Caption = 'Coste Pos. 2';
                }
                field(UnitCosteTotalPos3; AsmInfoPaneMgt.CalcItemUnitCostCalcPosition(Rec, '3'))
                {
                    ApplicationArea = All;
                    Caption = 'Coste Pos. 3';
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
