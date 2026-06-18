page 50059 "BOM Aditional Cost"
{
    ApplicationArea = All;
    Caption = 'LM. Adicional Coste';
    PageType = List;
    SourceTable = "BOM Aditional Cost";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            group(Informacion)
            {
                Caption = 'Información';

                group("Coste FIJADO")
                {
                    Caption = 'Coste FIJADO';

                    field(CosteLMFijado; Item.Receta_CosteLMFijado)
                    {
                        Caption = 'Coste Total LM (FIJADO)';
                        Editable = false;
                    }
                    field(CostesGeneralesFijados; AsmInfoPaneMgt.CalcAditionalFixedTotalCoste(Rec."Item No", 0) - AsmInfoPaneMgt.CalcBeneficioSobrePrecio(Item, TRUE, FALSE, FALSE, FALSE, FALSE))
                    {
                        Caption = 'Costes Generales (FIJADO)';
                    }
                    field(TOTALFixedCostEXWORK; AsmInfoPaneMgt.CalcAditionalFixedTotalCoste(Rec."Item No", 0) + Item.Receta_CosteLMFijado)
                    {
                        Caption = 'EXWORK Estándar (FIJADO)';
                        Style = Strong;
                        StyleExpr = TRUE;
                    }
                    field(BeneficioFixedWork; AsmInfoPaneMgt.CalcBeneficioSobrePrecio(Item, TRUE, FALSE, FALSE, FALSE, FALSE))
                    {
                        Caption = 'Beneficio (FIJADO)';
                    }
                    field(PerBeneficioFixedWork; AsmInfoPaneMgt.CalcPerBeneficioSobrePrecio(Item, TRUE, FALSE, FALSE, FALSE, FALSE))
                    {
                        Caption = '% Beneficio (FIJADO)';
                    }
                }
                group("Coste RECETA")
                {
                    Caption = 'Coste RECETA';
                    Visible = false;

                    field(TOTALStandardItemsCost; AsmInfoPaneMgt.CalcItemCosteCalculado(Item, FALSE))
                    {
                        Caption = 'Coste Total LM (RECETA)';
                        Style = Ambiguous;
                        StyleExpr = TRUE;
                    }
                    field(CostesGeneralesReceta; AsmInfoPaneMgt.CalcAditionalUnitTotalCosteReceta(Rec."Item No", 0, FALSE))
                    {
                        Caption = 'Costes Generales (RECETA)';
                        Style = Ambiguous;
                        StyleExpr = TRUE;
                    }
                    field(TOTALRecetaStandardCostEXWORK; AsmInfoPaneMgt.CalcAditionalUnitTotalCosteReceta(Rec."Item No", 0, FALSE) + AsmInfoPaneMgt.CalcItemCosteCalculado(Item, FALSE))
                    {
                        Caption = 'EXWORK Estándar (RECETA)';
                        Style = Ambiguous;
                        StyleExpr = TRUE;
                    }
                    field(BeneficioRecetaWork; AsmInfoPaneMgt.CalcBeneficioSobrePrecio(Item, FALSE, TRUE, FALSE, FALSE, FALSE))
                    {
                        Caption = 'Beneficio (RECETA)';
                        StyleExpr = VarFormatBeneficioReceta;
                    }
                    field(PerBeneficioRecetaWork; AsmInfoPaneMgt.CalcPerBeneficioSobrePrecio(Item, FALSE, TRUE, FALSE, FALSE, FALSE))
                    {
                        Caption = '% Beneficio (RECETA)';
                        StyleExpr = VarFormatBeneficioReceta;
                    }
                }
                group("Coste PRODUCTOS")
                {
                    Caption = 'Coste PRODUCTOS';

                    field(TOTALStandardItemsCostActual; AsmInfoPaneMgt.CalcItemCosteCalculado(Item, TRUE))
                    {
                        Caption = 'Coste Total LM (PROD)';
                        Style = StandardAccent;
                        StyleExpr = TRUE;
                    }
                    field(CostesGeneralesProductos2; AsmInfoPaneMgt.CalcAditionalCostWithoutApply(Rec."Item No", 0, TRUE))
                    {
                        Caption = 'Costes Generales (PRODUCTOS)';
                        Style = StandardAccent;
                        StyleExpr = TRUE;
                    }
                    field(TOTALItemsStandardCostEXWORK; AsmInfoPaneMgt.CalcAditionalUnitTotalCosteReceta(Rec."Item No", 0, TRUE) + AsmInfoPaneMgt.CalcItemCosteCalculado(Item, TRUE))
                    {
                        Caption = 'EXWORK Estándar (PRODUCTOS)';
                        Style = StandardAccent;
                        StyleExpr = TRUE;
                    }
                    field(BeneficiProductoWork; AsmInfoPaneMgt.CalcBeneficioSobrePrecio(Item, FALSE, FALSE, TRUE, FALSE, FALSE))
                    {
                        Caption = 'Beneficio (PRODUCTO)';
                        StyleExpr = VarFormatBeneficioProducto;
                    }
                    field(PerBeneficiProductoWork; AsmInfoPaneMgt.CalcPerBeneficioSobrePrecio(Item, FALSE, FALSE, TRUE, FALSE, FALSE))
                    {
                        Caption = '% Beneficio (PRODUCTO)';
                        StyleExpr = VarFormatBeneficioProducto;
                    }
                }
                field(TOTALUnitCostEXWORK; AsmInfoPaneMgt.CalcAditionalItemUnitTotalCoste(Rec."Item No", 0) + AsmInfoPaneMgt.CalcItemUnitCosteCalculado(Item))
                {
                    Caption = 'EXWORK Coste Medio (ORIGINAL)';
                    Style = Favorable;
                    StyleExpr = TRUE;
                    Visible = false;
                }
            }
            repeater(Group)
            {
                Caption = 'Lines';

                field("No. Cost"; Rec."No. Cost")
                {
                    Caption = 'Nº Coste';
                    ApplicationArea = All;
                }
                field("Description Cost"; Rec."Description Cost")
                {
                    Caption = 'Descripcion Coste';
                    ApplicationArea = All;
                }
                field("Type Coste"; Rec."Type Coste")
                {
                    Caption = 'Tipo Coste';
                    ApplicationArea = All;
                }
                field(Value; Rec.Value)
                {
                    Caption = 'Valor';
                    ApplicationArea = All;
                }
                field("Apply on all cost"; Rec."Apply on all cost")
                {
                    Caption = 'Aplica en todos los costes';
                    ApplicationArea = All;
                }
                field("Aditional fixed cost"; Rec."Aditional fixed cost")
                {
                    Caption = 'Costes Generales (FIJADO)';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("StandardCost"; AsmInfoPaneMgt.CalcAditionalUnitCoste(Rec, FALSE))
                {
                    Caption = 'Aditional standard cost (RECETA)';
                    ApplicationArea = All;
                    Style = Ambiguous;
                    StyleExpr = TRUE;
                    Visible = false;
                }
                field(AditionalCost; AsmInfoPaneMgt.CalcAditionalUnitCoste(Rec, TRUE))
                {
                    Caption = 'Aditional standard cost (PRODUCTO)';
                    ApplicationArea = All;
                    Editable = false;
                    Style = StandardAccent;
                    StyleExpr = TRUE;
                }
                field(BenefitActualize; AsmInfoPaneMgt.CalcBeneficioActualizado(Rec))
                {
                    //BlankZero = true;
                    Caption = 'Beneficio (PRODUCTO)';
                    ApplicationArea = All;
                    StyleExpr = VarFormatBeneficio;
                }
                field(PerBenefitActualize; AsmInfoPaneMgt.CalcPerBeneficioActualizado(Rec))
                {
                    //BlankZero = true;
                    Caption = '% Beneficio (PRODUCTO)';
                    ApplicationArea = All;
                    StyleExpr = VarFormatBeneficio;
                }
                field("Aditional unit cost"; Rec."Aditional unit cost")
                {
                    Caption = 'Aditional unit cost (ORIGINAL)';
                    ApplicationArea = All;
                    Style = Favorable;
                    StyleExpr = TRUE;
                    Visible = false;
                }
                field(AditionalUnitCost; AsmInfoPaneMgt.CalcAditionalItemUnitCoste(Rec))
                {
                    Caption = 'Aditional unit cost (ACTUAL)';
                    ApplicationArea = All;
                    Editable = false;
                    Style = StandardAccent;
                    StyleExpr = TRUE;
                    Visible = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            group("pr")
            {
                Caption = 'Actions';

                action(AddCost)
                {
                    Caption = 'Coste Adicional';
                    Image = CostEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        TemplateCostHeader: Record 50027;
                        FuncionesVarias: Codeunit 50003;
                    begin
                        TemplateCostHeader.RESET;
                        IF PAGE.RUNMODAL(50056, TemplateCostHeader) = ACTION::LookupOK THEN BEGIN
                            CLEAR(FuncionesVarias);
                            FuncionesVarias.CopyCostBOMfromTemplate(Rec."Item No", Rec."BOM Version", TemplateCostHeader);
                        END;
                    end;
                }
                /*  action(SetRecetaCost)
                 {
                     Caption = 'Fijar coste LM Receta';
                     Image = AddWatch;
                     Promoted = true;

                     trigger OnAction()
                     var
                         BOMAditionalCost: Record 50029;
                     begin


                         IF NOT CONFIRM('Atención, va a fijar el nuevo coste de LM con los valores de la receta, está de acuerdo?') THEN
                             EXIT;

                         IF (Item."No." = '') AND (Rec.GETFILTER("Item No") <> '') THEN BEGIN
                             Item.GET(Rec.GETFILTER("Item No"));
                         END;

                         Item.SetFijarCosteLMRecetaEnFichaArticulo;

                         BOMAditionalCost.RESET;
                         BOMAditionalCost.SETRANGE(BOMAditionalCost."Item No", Item."No.");
                         IF BOMAditionalCost.FINDFIRST THEN
                             REPEAT
                                 BOMAditionalCost.VALIDATE(Value);
                                 BOMAditionalCost.MODIFY;
                             UNTIL BOMAditionalCost.NEXT = 0;
                     end;
                 } */
                action(ActualiceCost)
                {
                    Caption = 'Fijar Coste Estandar Productos';
                    Image = Approval;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        BOMComponent: Record 90;
                        BOMAditionalCost: Record 50029;
                        AGRALAHistoricoCosteEstandar: Record 50030;
                    begin
                        //AGRALAMO - 412
                        texto:=Rec.GETFILTERS();
                        AGRALAHistoricoCosteEstandar.RESET;
                        AGRALAHistoricoCosteEstandar.SETRANGE(AGRALAIdProducto, Rec."Item No");
                        AGRALAHistoricoCosteEstandar.SETRANGE(AGRALACosteGeneral, Item."Standard Cost");
                        IF NOT AGRALAHistoricoCosteEstandar.FINDFIRST THEN BEGIN
                            AGRALAHistoricoCosteEstandar.AGRALAIdProducto:=Item."No.";
                            AGRALAHistoricoCosteEstandar.AGRALACosteGeneral:=Item."Standard Cost";
                            AGRALAHistoricoCosteEstandar.AGRALAFechaModificacion:=CURRENTDATETIME;
                            AGRALAHistoricoCosteEstandar.INSERT;
                        END;
                        Rec.ActualicyCost(Rec."Item No", Rec."BOM Version");
                        BOMComponent.RESET;
                        BOMComponent.SETRANGE("Parent Item No.", Rec."Item No");
                        BOMComponent.SETRANGE(Maquila, FALSE);
                        BOMComponent.SETRANGE("Assembly BOM", TRUE);
                        IF BOMComponent.FINDSET THEN BEGIN
                            BOMAditionalCost.SETRANGE("Item No", BOMComponent."No.");
                            IF BOMAditionalCost.FINDFIRST THEN BEGIN
                                REPEAT Rec.ActualicyCost(BOMAditionalCost."Item No", BOMAditionalCost."BOM Version");
                                UNTIL BOMAditionalCost.NEXT = 0 END;
                        END;
                        Rec.ActualicyCost(Rec."Item No", Rec."BOM Version");
                    //AGRALAMO - 412
                    end;
                }
            /* action(PruebaProceso)
                {

                    trigger OnAction()
                    var
                        AGRALABOMAditionalCost: Record 50029;
                        AGRALAItem: Record 27;
                        BOMComponent: Record 90;
                        BOMAditionalCost: Record 50029;
                        AGRALAHistoricoCosteEstandar: Record 50030;
                        Item: Record 27;
                        AGRALAActualizaCosteEstandar: Codeunit 50011;
                    begin
                        //AGRALAMO - 413
                        AGRALAActualizaCosteEstandar.RUN;

                        //AGRALAMO - 413
                    end;
                } */
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        Item.GET(Rec."Item No");
        //-- #9993
        GetFormatBeneficio;
    //++ #9993
    end;
    trigger OnDeleteRecord(): Boolean begin
        //-- #9993
        GetFormatBeneficio;
    //++ #9993
    end;
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean begin
        //-- #9993
        GetFormatBeneficio;
    //++ #9993
    end;
    trigger OnModifyRecord(): Boolean begin
        //-- #9993
        GetFormatBeneficio;
    //++ #9993
    end;
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //-- #9993
        GetFormatBeneficio;
    //++ #9993
    end;
    trigger OnOpenPage()
    var
        ItemAux: Record 27;
    begin
        IF(Item."No." = '') AND (Rec.GETFILTER("Item No") <> '')THEN BEGIN
            Item.GET(Rec.GETFILTER("Item No"));
        END;
    end;
    var AsmInfoPaneMgt: Codeunit AlxiaAssemblyInfoManagement;
    Item: Record 27;
    VarPerBeneficion: Decimal;
    VarFormatBeneficio: Text;
    VarFormatBeneficioReceta: Text;
    VarFormatBeneficioProducto: Text;
    texto: Text;
    local procedure GetFormatBeneficio()
    begin
        //-- #9993
        CLEAR(VarPerBeneficion);
        VarPerBeneficion:=AsmInfoPaneMgt.CalcPerBeneficioActualizado(Rec);
        VarFormatBeneficio:='';
        IF VarPerBeneficion <= 15 THEN VarFormatBeneficio:='UnFavorable'
        ELSE
        BEGIN
            IF(VarPerBeneficion <= 25)THEN VarFormatBeneficio:='Ambiguous'
            ELSE
                VarFormatBeneficio:='Favorable';
        END;
        GetFormatBeneficioReceta;
    //++ #9993
    end;
    local procedure GetFormatBeneficioReceta()
    begin
        //-- #9993
        CLEAR(VarPerBeneficion);
        VarPerBeneficion:=AsmInfoPaneMgt.CalcPerBeneficioSobrePrecio(Item, FALSE, TRUE, FALSE, FALSE, FALSE);
        VarFormatBeneficioReceta:='';
        IF VarPerBeneficion <= 15 THEN VarFormatBeneficioReceta:='UnFavorable'
        ELSE
        BEGIN
            IF(VarPerBeneficion <= 25)THEN VarFormatBeneficioReceta:='Ambiguous'
            ELSE
                VarFormatBeneficioReceta:='Favorable';
        END;
        VarPerBeneficion:=AsmInfoPaneMgt.CalcPerBeneficioSobrePrecio(Item, FALSE, FALSE, TRUE, FALSE, FALSE);
        VarFormatBeneficioProducto:='';
        IF VarPerBeneficion <= 15 THEN VarFormatBeneficioProducto:='UnFavorable'
        ELSE
        BEGIN
            IF(VarPerBeneficion <= 25)THEN VarFormatBeneficioProducto:='Ambiguous'
            ELSE
                VarFormatBeneficioProducto:='Favorable';
        END;
    //++ #9993
    end;
}
