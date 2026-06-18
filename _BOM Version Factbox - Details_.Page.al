page 50054 "BOM Version Factbox - Details"
{
    Caption = 'Version LM - Detalles';
    PageType = CardPart;
    SourceTable = "BOM Version Header";

    layout
    {
        area(content)
        {
            group(ItemInf)
            {
                Caption = 'Información producto';

                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field(StandarCost; Rec.StandarCost)
                {
                    ApplicationArea = All;
                    Caption = 'Coste Estándard';
                }
                field(UnitCost; Rec.UnitCost)
                {
                    ApplicationArea = All;
                    Caption = 'Coste Medio';
                }
                field(CosteLMFijado; Rec.CosteLMFijado)
                {
                    ApplicationArea = All;
                    Caption = 'Coste LM Fijado';
                }
                field(CostesGenerales; Rec.CostesGenerales)
                {
                    ApplicationArea = All;
                    Caption = 'Costes Generales';
                }
                field(ExWork; Rec.ExWork)
                {
                    ApplicationArea = All;
                    Caption = 'ExWork';
                }
            }
            group(StandardCostVersion)
            {
                Caption = 'Coste Estandar Version';

                field(TOTALStandardStadisticsCostVersion; AsmInfoPaneMgt.CalcBOMVersionItemStadisticsCoste(Rec, 0, FALSE))
                {
                    ApplicationArea = All;
                    Caption = 'Coste Std. Estadistico TOTAL';
                }
                field(TOTALStandardCostVersion; AsmInfoPaneMgt.CalcAditionalUnitTotalCoste(Rec."Item No.", Rec."BOM Version", FALSE) + AsmInfoPaneMgt.CalcBOMVersionItemCosteCalculado(Rec))
                {
                    ApplicationArea = All;
                    Caption = 'Coste Std. TOTAL';
                }
                field(AddStandardCostVersion; AsmInfoPaneMgt.CalcAditionalUnitTotalCoste(Rec."Item No.", Rec."BOM Version", FALSE))
                {
                    ApplicationArea = All;
                    Caption = 'Coste Std. Generales.';
                }
                field(CosteTotalVersion; AsmInfoPaneMgt.CalcBOMVersionItemCosteCalculado(Rec))
                {
                    ApplicationArea = All;
                    Caption = 'Coste Total Calculado';
                }
                field(CosteTotalMPVersion; AsmInfoPaneMgt.CalcBOMVersionItemCostCalcType(Rec, 'MP*'))
                {
                    ApplicationArea = All;
                    Caption = 'Coste Calc. MP';
                }
                field(CosteTotalMPVersionPer; AsmInfoPaneMgt.CalcBOMVersionItemPerCostCalcType(Rec, 'MP*'))
                {
                    ApplicationArea = All;
                    Caption = '% Coste Calc. MP';
                }
                field(CosteTotalMAVersion; AsmInfoPaneMgt.CalcBOMVersionItemCostCalcType(Rec, 'MA*'))
                {
                    ApplicationArea = All;
                    Caption = 'Coste Calc. MA';
                }
                field(CosteTotalMAVersionPer; AsmInfoPaneMgt.CalcBOMVersionItemPerCostCalcType(Rec, 'MA*'))
                {
                    ApplicationArea = All;
                    Caption = '% Coste Calc. MA';
                }
                field(CosteTotalRecMaquinaVersion; AsmInfoPaneMgt.CalcBOMVersionItemCostCalcResType(Rec, 2))
                {
                    ApplicationArea = All;
                    Caption = 'Coste Calc. Rec. Máquina';
                }
                field(CosteTotalRecMaquinaVersionPer; AsmInfoPaneMgt.CalcBOMVersionItemPerCostCalcResType(Rec, 2))
                {
                    ApplicationArea = All;
                    Caption = '% Coste Calc. Rec. Máquina';
                }
                field(CosteTotalRecPersonaVersion; AsmInfoPaneMgt.CalcBOMVersionItemCostCalcResType(Rec, 1))
                {
                    ApplicationArea = All;
                    Caption = 'Coste Calc. Rec. Persona';
                }
                field(CosteTotalRecPersonaVersionPer; AsmInfoPaneMgt.CalcBOMVersionItemPerCostCalcResType(Rec, 1))
                {
                    ApplicationArea = All;
                    Caption = '% Coste Calc. Rec. Persona';
                }
                field(CosteTotalRestoCompVersion; AsmInfoPaneMgt.CalcBOMVersionItemCostCalcItem(Rec))
                {
                    ApplicationArea = All;
                    Caption = 'Coste Calc. Resto Comp.';
                    Visible = false;
                }
                field(CosteTotalPos1Version; AsmInfoPaneMgt.CalcBOMVersionItemCostCalcPosition(Rec, '1'))
                {
                    ApplicationArea = All;
                    Caption = 'Coste Calc. Pos. 1';
                    Visible = false;
                }
                field(CosteTotalPos2Version; AsmInfoPaneMgt.CalcBOMVersionItemCostCalcPosition(Rec, '2'))
                {
                    ApplicationArea = All;
                    Caption = 'Coste Calc. Pos. 2';
                    Visible = false;
                }
                field(CosteTotalPos3Version; AsmInfoPaneMgt.CalcBOMVersionItemCostCalcPosition(Rec, '3'))
                {
                    ApplicationArea = All;
                    Caption = 'Coste Calc. Pos. 3';
                    Visible = false;
                }
            }
            group(UnitCostVersion)
            {
                Caption = 'Coste Unitario Version';

                field(TOTALStadisticsUnitCostVersion; AsmInfoPaneMgt.CalcBOMVersionItemStadisticsCoste(Rec, 1, TRUE))
                {
                    ApplicationArea = All;
                    Caption = 'Coste Estadistico TOTAL';
                }
                field(TOTALUnitCostVersion; AsmInfoPaneMgt.CalcAditionalItemUnitTotalCoste(Rec."Item No.", Rec."BOM Version") + AsmInfoPaneMgt.CalcBOMVersionItemUnitCosteCalculado(Rec))
                {
                    ApplicationArea = All;
                    Caption = 'Coste Unitario TOTAL';
                }
                field(AddUnitCostVersion; AsmInfoPaneMgt.CalcAditionalItemUnitTotalCoste(Rec."Item No.", Rec."BOM Version"))
                {
                    ApplicationArea = All;
                    Caption = 'Coste Unitario Generales';
                }
                field(UnitCosteTotalVersion; AsmInfoPaneMgt.CalcBOMVersionItemUnitCosteCalculado(Rec))
                {
                    ApplicationArea = All;
                    Caption = 'Coste Total Calculado';
                }
                field(UnitCosteTotalMPVersion; AsmInfoPaneMgt.CalcBOMVersionItemUnitCostCalcType(Rec, 'MP*'))
                {
                    ApplicationArea = All;
                    Caption = 'Coste Calc. MP';
                }
                field(UnitCosteTotalMPVersionPer; AsmInfoPaneMgt.CalcBOMVersionItemPerUnitCostCalcType(Rec, 'MP*'))
                {
                    ApplicationArea = All;
                    Caption = '% Coste Calc. MP';
                }
                field(UnitCosteTotalMAVersion; AsmInfoPaneMgt.CalcBOMVersionItemUnitCostCalcType(Rec, 'MA*'))
                {
                    ApplicationArea = All;
                    Caption = 'Coste Calc. MA';
                }
                field(UnitCosteTotalMAVersionPer; AsmInfoPaneMgt.CalcBOMVersionItemPerUnitCostCalcType(Rec, 'MA*'))
                {
                    ApplicationArea = All;
                    Caption = '% Coste Calc. MA';
                }
                field(UnitCosteTotalRecMaquinaVersion; AsmInfoPaneMgt.CalcBOMVersionItemCostCalcResType(Rec, 2))
                {
                    ApplicationArea = All;
                    Caption = 'Coste Calc. Rec. Máquina';
                }
                field(PerUnitCosteTotalRecMaquinaVersion; AsmInfoPaneMgt.CalcBOMVersionItemPerCostCalcResType(Rec, 2))
                {
                    ApplicationArea = All;
                    Caption = '% Coste Calc. Rec. Máquina';
                }
                field(UnitCosteTotalRecPersonaVersion; AsmInfoPaneMgt.CalcBOMVersionItemCostCalcResType(Rec, 1))
                {
                    ApplicationArea = All;
                    Caption = 'Coste Calc. Rec. Persona';
                }
                field(PerUnitCosteTotalRecPersonaVersion; AsmInfoPaneMgt.CalcBOMVersionItemPerCostCalcResType(Rec, 1))
                {
                    ApplicationArea = All;
                    Caption = '% Coste Calc. Rec. Persona';
                }
                field(UnitCosteTotalRestoCompVersion; AsmInfoPaneMgt.CalcBOMVersionItemUnitCostCalcItem(Rec))
                {
                    ApplicationArea = All;
                    Caption = 'Coste Calc. Resto Comp.';
                    Visible = false;
                }
                field(UnitCosteTotalPos1Version; AsmInfoPaneMgt.CalcBOMVersionItemUnitCostCalcPosition(Rec, '1'))
                {
                    ApplicationArea = All;
                    Caption = 'Coste Calc. Pos. 1';
                    Visible = false;
                }
                field(UnitCosteTotalPos2Version; AsmInfoPaneMgt.CalcBOMVersionItemUnitCostCalcPosition(Rec, '2'))
                {
                    ApplicationArea = All;
                    Caption = 'Coste Calc. Pos. 2';
                    Visible = false;
                }
                field(UnitCosteTotalPos3Version; AsmInfoPaneMgt.CalcBOMVersionItemUnitCostCalcPosition(Rec, '3'))
                {
                    ApplicationArea = All;
                    Caption = '<Coste Calc. Pos. 3>';
                }
            }
        }
    }
    actions
    {
    }
    trigger OnAfterGetRecord()
    begin
        Item.GET(Rec."Item No.");
    end;
    var AsmInfoPaneMgt: Codeunit AlxiaAssemblyInfoManagement;
    Item: Record 27;
}
