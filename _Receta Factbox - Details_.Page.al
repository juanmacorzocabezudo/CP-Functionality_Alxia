page 50016 "Receta Factbox - Details"
{
    // #9785 - Se introduce el coste unitario
    Caption = 'Receta - Detalle';
    PageType = CardPart;
    SourceTable = Item;

    layout
    {
        area(content)
        {
            group(ItemInf)
            {
                Caption = 'Información producto';

                field("Standard Cost"; Rec."Standard Cost")
                {
                    Caption = 'Costo estándar';
                    ApplicationArea = All;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    Caption = 'Costo unitario';
                    ApplicationArea = All;
                }
                field(PerBeneficioFixedWork; FORMAT(AsmInfoPaneMgt.CalcPerBeneficioSobrePrecio(Rec, TRUE, FALSE, FALSE, FALSE, FALSE)) + '%')
                {
                    ApplicationArea = All;
                    Caption = '% Beneficio (FIJADO)';
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Producto';
                }
                field(ExWorkSTDFijado; AsmInfoPaneMgt.CalcAditionalFixedTotalCoste(Rec."No.", 0) + Rec.Receta_CosteLMFijado)
                {
                    ApplicationArea = All;
                    Caption = 'ExWork (FIJADO)';
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
            group(StandardCost)
            {
                Caption = 'Coste Estandar';

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
                    Caption = 'Aditional Std. Cost';
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
                field(CosteTotalRecMaquina; AsmInfoPaneMgt.CalcItemCostCalcResType(Rec, 2))
                {
                    ApplicationArea = All;
                    Caption = 'Coste Rec. Máq.';
                }
                field(CosteTotalRecPersona; AsmInfoPaneMgt.CalcItemCostCalcResType(Rec, 1))
                {
                    ApplicationArea = All;
                    Caption = 'Coste Rec. Persona';
                }
                field(CosteTotalRestoComp; AsmInfoPaneMgt.CalcItemCostCalcItem(Rec))
                {
                    ApplicationArea = All;
                    Caption = 'Coste Resto Comp';
                    Visible = false;
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
            group(UnitCost)
            {
                Caption = 'Unit Cost';

                field(CosteUnitarioActual; AsmInfoPaneMgt.CalcItemUnitCosteCalculado(Rec) + AsmInfoPaneMgt.CalcAditionalItemUnitTotalCoste(Rec."No.", 0) - AsmInfoPaneMgt.CalcBeneficioSobrePrecio(Rec, FALSE, FALSE, FALSE, TRUE, FALSE))
                {
                    ApplicationArea = All;
                    Caption = 'Coste Unitario Actual';
                }
                field(TOTALStadisticsUnitCost; AsmInfoPaneMgt.CalcItemStadisticsCost(Rec, 1, TRUE))
                {
                    ApplicationArea = All;
                    Caption = 'TOTAL Stadistics Unit EXWORK';
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(TOTALUnitCost; AsmInfoPaneMgt.CalcAditionalItemUnitTotalCoste(Rec."No.", 0) + AsmInfoPaneMgt.CalcItemUnitCosteCalculado(Rec))
                {
                    ApplicationArea = All;
                    Caption = 'TOTAL Unit EXWORK';
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
                    Caption = 'Aditional Unit Cost';
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
                field(UnitCosteTotalRecMaquina; AsmInfoPaneMgt.CalcItemCostCalcResType(Rec, 2))
                {
                    ApplicationArea = All;
                    Caption = 'Coste Rec. Máquina';
                }
                field(UnitCosteTotalRecPersona; AsmInfoPaneMgt.CalcItemCostCalcResType(Rec, 1))
                {
                    ApplicationArea = All;
                    Caption = 'Coste Rec. Persona';
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
                field(UnitCosteTotalRecMaquinaPer; FORMAT(AsmInfoPaneMgt.CalcItemPerCostCalcResType(Rec, 2), 0) + '%')
                {
                    ApplicationArea = All;
                    Caption = '% Coste Rec. Máquina';
                }
                field(UnitCosteTotalRecPersonaPer; FORMAT(AsmInfoPaneMgt.CalcItemPerCostCalcResType(Rec, 1), 0) + '%')
                {
                    ApplicationArea = All;
                    Caption = '% Coste Rec. Persona';
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
            group(Pesos)
            {
                Caption = 'Pesos y Mermas';

                field(PesoBruto; AsmInfoPaneMgt.CalcPesoBrutoNetoReceta(Rec, TRUE, FALSE))
                {
                    ApplicationArea = All;
                    Caption = 'Peso Bruto';
                }
                field(PesoNeto; AsmInfoPaneMgt.CalcPesoBrutoNetoReceta(Rec, FALSE, TRUE))
                {
                    ApplicationArea = All;
                    Caption = 'Peso Neto';
                }
                field("%Merma"; AsmInfoPaneMgt.CalcPerMermaReceta(Rec))
                {
                    ApplicationArea = All;
                    Caption = '% Merma';
                }
            }
        }
    }
    actions
    {
    }
    var AsmInfoPaneMgt: Codeunit AlxiaFuncionesImportadas;
}
