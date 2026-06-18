codeunit 50012 AlxiaCalculateStandardCost
{
    trigger OnRun()
    begin
    end;
    var Text000: Label 'Too many levels. Must be below %1.';
    MfgSetup: Record 99000765;
    GLSetup: Record 98;
    TempItem: Record 27 temporary;
    TempWorkCenter: Record 99000754 temporary;
    TempMachineCenter: Record 99000758 temporary;
    #pragma warning disable AL0432
    TempResCost: Record 202 temporary;
    #pragma warning restore AL0432
    ProdBOMVersionErrBuf: Record 99000779 temporary;
    RtngVersionErrBuf: Record 99000786 temporary;
    CostCalcMgt: Codeunit 5836;
    MfgCostCalcMgt: Codeunit "Mfg. Cost Calculation Mgt.";
    FunImp: Codeunit AlxiaFuncionesImportadas;
    VersionMgt: Codeunit 99000756;
    UOMMgt: Codeunit 5402;
    Window: Dialog;
    MaxLevel: Integer;
    CalculationDate: Date;
    CalcMultiLevel: Boolean;
    UseAssemblyList: Boolean;
    LogErrors: Boolean;
    Text001: Label '&Top level,&All levels';
    ShowDialog: Boolean;
    StdCostWkshName: Text[50];
    Text002: Label '@1@@@@@@@@@@@@@';
    CalcMfgPrompt: Label 'One or more subassemblies on the assembly list for item %1 use replenishment system Prod. Order. Do you want to calculate standard cost for those subassemblies?';
    TargetText: Label 'Standard Cost,Unit Price';
    RecursionInstruction: Label 'Calculate the %3 of item %1 %2 by rolling up the assembly list components. Select All levels to include and update the %3 of any subassemblies.', Comment = '%1 = Item No., %2 = Description';
    NonAssemblyItemError: Label 'Item %1 %2 does not use replenishment system Assembly. The %3 will not be calculated.', Comment = '%1 = Item No., %2 = Description';
    NoAssemblyListError: Label 'Item %1 %2 has no assembly list. The %3 will not be calculated.', Comment = '%1 = Item No., %2 = Description';
    NonAssemblyComponentWithList: Label 'One or more subassemblies on the assembly list for this item does not use replenishment system Assembly. The %1 for these subassemblies will not be calculated. Are you sure that you want to continue?';
    ColIdx: Option, StdCost, ExpCost, ActCost, Dev, "Var";
    RowIdx: Option, MatCost, ResCost, ResOvhd, AsmOvhd, Total;
    VarSkipCalcItemMessageGlobal: Boolean;
    DepthGlobal: Integer;
    AssemblyContainsProdBOMGlobal: Boolean;
    NewCalcMultiLevelGlobal: Boolean;
    procedure SetProperties(NewCalculationDate: Date; NewCalcMultiLevel: Boolean; NewUseAssemblyList: Boolean; NewLogErrors: Boolean; NewStdCostWkshName: Text[50]; NewShowDialog: Boolean)
    begin
        TempItem.DELETEALL;
        ProdBOMVersionErrBuf.DELETEALL;
        RtngVersionErrBuf.DELETEALL;
        CLEARALL;
        CalculationDate:=NewCalculationDate;
        CalcMultiLevel:=NewCalcMultiLevel;
        UseAssemblyList:=NewUseAssemblyList;
        LogErrors:=NewLogErrors;
        StdCostWkshName:=NewStdCostWkshName;
        ShowDialog:=NewShowDialog;
        MaxLevel:=50;
        MfgSetup.GET;
        GLSetup.GET;
    end;
    procedure TestPreconditions(var Item: Record 27; var NewProdBOMVersionErrBuf: Record 99000779; var NewRtngVersionErrBuf: Record 99000786)
    var
        TempItem2: Record 27 temporary;
    begin
        CalcItems(Item, TempItem2);
        ProdBOMVersionErrBuf.RESET;
        IF ProdBOMVersionErrBuf.FIND('-')THEN REPEAT NewProdBOMVersionErrBuf:=ProdBOMVersionErrBuf;
                NewProdBOMVersionErrBuf.INSERT;
            UNTIL ProdBOMVersionErrBuf.NEXT = 0;
        RtngVersionErrBuf.RESET;
        IF RtngVersionErrBuf.FIND('-')THEN REPEAT NewRtngVersionErrBuf:=RtngVersionErrBuf;
                NewRtngVersionErrBuf.INSERT;
            UNTIL RtngVersionErrBuf.NEXT = 0;
    end;
    local procedure AnalyzeAssemblyList(var Item: Record 27; var Depth: Integer; var NonAssemblyItemWithList: Boolean; var ContainsProdBOM: Boolean)
    var
        BOMComponent: Record 90;
        SubItem: Record 27;
        BaseDepth: Integer;
        MaxDepth: Integer;
    begin
        IF Item.IsMfgItem AND ((Item."Production BOM No." <> '') OR (Item."Routing No." <> ''))THEN BEGIN
            ContainsProdBOM:=TRUE;
            IF Item."Production BOM No." <> '' THEN AnalyzeProdBOM(Item."Production BOM No.", Depth, NonAssemblyItemWithList, ContainsProdBOM)
            ELSE
                Depth+=1;
            EXIT END;
        BOMComponent.SETRANGE("Parent Item No.", Item."No.");
        IF BOMComponent.FINDSET THEN BEGIN
            IF NOT Item.IsAssemblyItem THEN BEGIN
                NonAssemblyItemWithList:=TRUE;
                EXIT END;
            Depth+=1;
            BaseDepth:=Depth;
            REPEAT IF BOMComponent.Type = BOMComponent.Type::Item THEN BEGIN
                    SubItem.GET(BOMComponent."No.");
                    MaxDepth:=BaseDepth;
                    AnalyzeAssemblyList(SubItem, MaxDepth, NonAssemblyItemWithList, ContainsProdBOM);
                    IF MaxDepth > Depth THEN Depth:=MaxDepth END UNTIL BOMComponent.NEXT = 0 END;
    end;
    local procedure AnalyzeProdBOM(ProductionBOMNo: Code[20]; var Depth: Integer; var NonAssemblyItemWithList: Boolean; var ContainsProdBOM: Boolean)
    var
        ProdBOMLine: Record 99000772;
        SubItem: Record 27;
        PBOMVersionCode: Code[10];
        BaseDepth: Integer;
        MaxDepth: Integer;
    begin
        SetProdBOMFilters(ProdBOMLine, PBOMVersionCode, ProductionBOMNo);
        IF ProdBOMLine.FINDSET THEN BEGIN
            Depth+=1;
            BaseDepth:=Depth;
            REPEAT CASE ProdBOMLine.Type OF ProdBOMLine.Type::Item: BEGIN
                    SubItem.GET(ProdBOMLine."No.");
                    MaxDepth:=BaseDepth;
                    AnalyzeAssemblyList(SubItem, MaxDepth, NonAssemblyItemWithList, ContainsProdBOM);
                    IF MaxDepth > Depth THEN Depth:=MaxDepth END;
                ProdBOMLine.Type::"Production BOM": BEGIN
                    MaxDepth:=BaseDepth;
                    AnalyzeProdBOM(ProdBOMLine."No.", MaxDepth, NonAssemblyItemWithList, ContainsProdBOM);
                    MaxDepth-=1;
                    IF MaxDepth > Depth THEN Depth:=MaxDepth END;
                END;
            UNTIL ProdBOMLine.NEXT = 0 END end;
    procedure PrepareAssemblyCalculation(var Item: Record 27; var Depth: Integer; Target: Option "Standard Cost", "Unit Price"; var ContainsProdBOM: Boolean)Instruction: Text[1024]var
        CalculationTarget: Text[80];
        SubNonAssemblyItemWithList: Boolean;
    begin
        //** #10777 - Se pasa a funcion global
        CalculationTarget:=SELECTSTR(Target, TargetText);
        IF NOT Item.IsAssemblyItem THEN ERROR(NonAssemblyItemError, Item."No.", Item.Description, CalculationTarget);
        AnalyzeAssemblyList(Item, Depth, SubNonAssemblyItemWithList, ContainsProdBOM);
        IF Depth = 0 THEN ERROR(NoAssemblyListError, Item."No.", Item.Description, CalculationTarget);
        Instruction:=STRSUBSTNO(RecursionInstruction, Item."No.", Item.Description, CalculationTarget);
        IF SubNonAssemblyItemWithList THEN Instruction+=STRSUBSTNO(NonAssemblyComponentWithList, CalculationTarget)end;
    procedure CalcItem(ItemNo: Code[20]; NewUseAssemblyList: Boolean)
    var
        Item: Record 27;
        ItemCostMgt: Codeunit 5804;
        Instruction: Text[1024];
        NewCalcMultiLevel: Boolean;
        Depth: Integer;
        AssemblyContainsProdBOM: Boolean;
        CalcMfgItems: Boolean;
    begin
        Item.GET(ItemNo);
        //-- #10777
        IF VarSkipCalcItemMessageGlobal THEN BEGIN
            Depth:=DepthGlobal;
            AssemblyContainsProdBOM:=AssemblyContainsProdBOMGlobal;
            NewCalcMultiLevel:=NewCalcMultiLevelGlobal;
        END
        ELSE
        BEGIN
            /*********************** TEXTO ORIGINAL ***********************/
            IF NewUseAssemblyList THEN Instruction:=PrepareAssemblyCalculation(Item, Depth, 1, AssemblyContainsProdBOM) // 1=StandardCost
            ELSE IF NOT Item.IsMfgItem THEN EXIT;
            IF NOT NewUseAssemblyList OR (Depth > 1)THEN CASE STRMENU(Text001, 1, Instruction)OF 0: EXIT;
                1: NewCalcMultiLevel:=FALSE;
                2: NewCalcMultiLevel:=TRUE;
                END;
        /********************* FIN TEXTO ORIGINAL *********************/
        END;
        //++ #10777
        SetProperties(WORKDATE, NewCalcMultiLevel, NewUseAssemblyList, FALSE, '', FALSE);
        IF NewUseAssemblyList THEN BEGIN
            IF NewCalcMultiLevel AND AssemblyContainsProdBOM THEN CalcMfgItems:=CONFIRM(CalcMfgPrompt, FALSE, Item."No.");
            CalcAssemblyItem(ItemNo, Item, 0, CalcMfgItems)END
        ELSE
            CalcMfgItem(ItemNo, Item, 0);
        IF TempItem.FIND('-')THEN REPEAT ItemCostMgt.UpdateStdCostShares(TempItem);
            UNTIL TempItem.NEXT = 0;
    end;
    procedure CalcItems(var Item: Record 27; var NewTempItem: Record 27)
    var
        Item2: Record 27;
        Item3: Record 27;
        NoOfRecords: Integer;
        LineCount: Integer;
    begin
        NewTempItem.DELETEALL;
        Item2.COPY(Item);
        NoOfRecords:=Item.COUNT;
        IF ShowDialog THEN Window.OPEN(Text002);
        IF Item2.FIND('-')THEN REPEAT LineCount:=LineCount + 1;
                IF ShowDialog THEN Window.UPDATE(1, ROUND(LineCount / NoOfRecords * 10000, 1));
                IF UseAssemblyList THEN CalcAssemblyItem(Item2."No.", Item3, 0, TRUE)
                ELSE
                    CalcMfgItem(Item2."No.", Item3, 0);
            UNTIL Item2.NEXT = 0;
        TempItem.RESET;
        IF TempItem.FIND('-')THEN REPEAT NewTempItem:=TempItem;
                NewTempItem.INSERT;
            UNTIL TempItem.NEXT = 0;
        IF ShowDialog THEN Window.CLOSE;
    end;
    local procedure CalcAssemblyItem(ItemNo: Code[20]; var Item: Record 27; Level: Integer; CalcMfgItems: Boolean)
    var
        BOMComp: Record 90;
        CompItem: Record 27;
        Res: Record 156;
        LotSize: Decimal;
        ComponentQuantity: Decimal;
        LT_PRODUCTO: Record 27;
        LT_RECURSO: Record 156;
        AsmInfoPaneMgt: Codeunit AlxiaAssemblyInfoManagement;
    begin
        IF Level > MaxLevel THEN ERROR(Text000, MaxLevel);
        IF GetItem(ItemNo, Item)THEN EXIT;
        IF NOT Item.IsAssemblyItem THEN EXIT;
        IF NOT CalcMultiLevel AND (Level <> 0)THEN EXIT;
        BOMComp.SETRANGE("Parent Item No.", ItemNo);
        BOMComp.SETFILTER(Type, '<>%1', BOMComp.Type::" ");
        BOMComp.SETRANGE(Maquila, FALSE); //** #9862
        IF BOMComp.FINDSET THEN BEGIN
            Item."Rolled-up Material Cost":=0;
            Item."Rolled-up Capacity Cost":=0;
            Item."Rolled-up Cap. Overhead Cost":=0;
            Item."Rolled-up Mfg. Ovhd Cost":=0;
            Item."Rolled-up Subcontracted Cost":=0;
            Item."Single-Level Material Cost":=0;
            Item."Single-Level Capacity Cost":=0;
            Item."Single-Level Cap. Ovhd Cost":=0;
            Item."Single-Level Subcontrd. Cost":=0;
            REPEAT CASE BOMComp.Type OF BOMComp.Type::Item: BEGIN
                    //AGRALAMO - 412
                    //SL Validacion de ItemNo.
                    if BOMComp."No." <> '' then begin
                        GetItem(BOMComp."No.", CompItem);
                        ComponentQuantity:=BOMComp."Quantity per" * UOMMgt.GetQtyPerUnitOfMeasure(CompItem, BOMComp."Unit of Measure Code");
                        IF CompItem.IsAssemblyItem OR CompItem.IsMfgItem THEN BEGIN
                            IF CompItem.IsAssemblyItem THEN CalcAssemblyItem(BOMComp."No.", CompItem, Level + 1, CalcMfgItems)
                            ELSE IF CalcMfgItems THEN CalcMfgItem(BOMComp."No.", CompItem, Level + 1);
                            Item."Rolled-up Material Cost"+=ComponentQuantity * CompItem."Rolled-up Material Cost";
                            Item."Rolled-up Capacity Cost"+=ComponentQuantity * CompItem."Rolled-up Capacity Cost";
                            Item."Rolled-up Cap. Overhead Cost"+=ComponentQuantity * CompItem."Rolled-up Cap. Overhead Cost";
                            Item."Rolled-up Mfg. Ovhd Cost"+=ComponentQuantity * CompItem."Rolled-up Mfg. Ovhd Cost";
                            Item."Rolled-up Subcontracted Cost"+=ComponentQuantity * CompItem."Rolled-up Subcontracted Cost";
                            Item."Single-Level Material Cost"+=ComponentQuantity * CompItem."Standard Cost" END
                        ELSE
                        BEGIN
                            //-- #9766
                            //Item."Rolled-up Material Cost" += ComponentQuantity * CompItem."Unit Cost";
                            //Item."Single-Level Material Cost" += ComponentQuantity * CompItem."Unit Cost"
                            Item."Rolled-up Material Cost"+=ComponentQuantity * CompItem."Standard Cost";
                            Item."Single-Level Material Cost"+=ComponentQuantity * CompItem."Standard Cost";
                        //++ #9766
                        END end;
                //SL End Validacion de ItemNo.
                END;
                BOMComp.Type::Resource: BEGIN
                    LotSize:=1;
                    IF BOMComp."Resource Usage Type" = BOMComp."Resource Usage Type"::Fixed THEN IF Item."Lot Size" <> 0 THEN LotSize:=Item."Lot Size";
                    GetResCost(BOMComp."No.", TempResCost);
                    Res.GET(BOMComp."No.");
                    ComponentQuantity:=BOMComp."Quantity per" * UOMMgt.GetResQtyPerUnitOfMeasure(Res, BOMComp."Unit of Measure Code") / LotSize;
                    Item."Single-Level Capacity Cost"+=ComponentQuantity * TempResCost."Direct Unit Cost";
                    Item."Single-Level Cap. Ovhd Cost"+=ComponentQuantity * (TempResCost."Unit Cost" - TempResCost."Direct Unit Cost");
                END;
                END;
            UNTIL BOMComp.NEXT = 0;
            Item."Single-Level Mfg. Ovhd Cost":=ROUND((Item."Single-Level Material Cost" + Item."Single-Level Capacity Cost" + Item."Single-Level Cap. Ovhd Cost") * Item."Indirect Cost %" / 100 + Item."Overhead Rate", GLSetup."Unit-Amount Rounding Precision");
            Item."Rolled-up Material Cost":=ROUND(Item."Rolled-up Material Cost", GLSetup."Unit-Amount Rounding Precision");
            Item."Rolled-up Capacity Cost":=ROUND(Item."Rolled-up Capacity Cost" + Item."Single-Level Capacity Cost", GLSetup."Unit-Amount Rounding Precision");
            Item."Rolled-up Cap. Overhead Cost":=ROUND(Item."Rolled-up Cap. Overhead Cost" + Item."Single-Level Cap. Ovhd Cost", GLSetup."Unit-Amount Rounding Precision");
            Item."Rolled-up Mfg. Ovhd Cost":=ROUND(Item."Rolled-up Mfg. Ovhd Cost" + Item."Single-Level Mfg. Ovhd Cost", GLSetup."Unit-Amount Rounding Precision");
            Item."Rolled-up Subcontracted Cost":=ROUND(Item."Rolled-up Subcontracted Cost", GLSetup."Unit-Amount Rounding Precision");
            Item."Standard Cost":=ROUND(Item."Single-Level Material Cost" + Item."Single-Level Capacity Cost" + Item."Single-Level Cap. Ovhd Cost" + Item."Single-Level Mfg. Ovhd Cost" + Item."Single-Level Subcontrd. Cost", GLSetup."Unit-Amount Rounding Precision");
            Item."Single-Level Capacity Cost":=ROUND(Item."Single-Level Capacity Cost", GLSetup."Unit-Amount Rounding Precision");
            Item."Single-Level Cap. Ovhd Cost":=ROUND(Item."Single-Level Cap. Ovhd Cost", GLSetup."Unit-Amount Rounding Precision");
            Item."Last Unit Cost Calc. Date":=CalculationDate;
            //++ KR
            // Añadir al coste estandar los costes generales de CP
            Item."Standard Cost":=ROUND(AsmInfoPaneMgt.CalcAditionalFixedTotalCoste(Item."No.", 0) + Item.Receta_CosteLMFijado - AsmInfoPaneMgt.CalcBeneficioSobrePrecio(Item, TRUE, FALSE, FALSE, FALSE, FALSE), GLSetup."Unit-Amount Rounding Precision");
            //--
            TempItem:=Item;
            TempItem.INSERT END;
        //INICIO ADV0001
        /*
        BOMComp.RESET;
        BOMComp.SETRANGE("Parent Item No.",ItemNo);
        BOMComp.SETFILTER(Type,'<>%1',BOMComp.Type::" ");
        IF BOMComp.FINDSET THEN
          REPEAT
            IF Item."Lote Receta" <> 0 THEN BEGIN
                IF BOMComp.Type=BOMComp.Type::Item THEN BEGIN
                  LT_PRODUCTO.GET(BOMComp."No.");
                  //++ KR 06/07/21
                  //BOMComp.CosteUnitario := LT_PRODUCTO."Unit Cost";     //ADV002
                  //BOMComp."Importancia en Coste" := BOMComp."Quantity per" * LT_PRODUCTO."Unit Cost" / Item."Standard Cost" *100;
        
                  BOMComp.CosteUnitario := LT_PRODUCTO."Standard Cost";     //ADV002
                  BOMComp."Importancia en Coste" := BOMComp."Quantity per" * BOMComp.CosteUnitario / Item."Standard Cost" *100;
                  //--
                END ELSE IF (BOMComp.Type=BOMComp.Type::Resource) AND (BOMComp."Resource Usage Type"= BOMComp."Resource Usage Type"::Direct) THEN BEGIN
                  LT_RECURSO.GET(BOMComp."No.");
                  BOMComp.CosteUnitario := LT_RECURSO."Unit Cost";     //ADV002
                  BOMComp."Importancia en Coste" := BOMComp."Quantity per" * LT_RECURSO."Unit Cost"/ Item."Standard Cost" * 100;
                END;
            END ELSE BEGIN
              BOMComp."Importancia en Coste" := 0;
            END;
        
            //ADV002 Inicio
            //BOMComp."Coste Calculado" := BOMComp.CosteUnitario * BOMComp."Quantity per";
            BOMComp.MODIFY;
            //ADV002 Fin
        
          UNTIL BOMComp.NEXT=0;
        */
        BOMComp.RESET;
        BOMComp.SETRANGE("Parent Item No.", ItemNo);
        BOMComp.SETFILTER(Type, '<>%1', BOMComp.Type::" ");
        IF BOMComp.FINDSET THEN REPEAT //SL Validacion de ItemNo. 
                if BOMComp."No." <> '' then begin
                    IF BOMComp.Type = BOMComp.Type::Item THEN BEGIN
                        LT_PRODUCTO.GET(BOMComp."No.");
                        //++ KR 06/07/21
                        //BOMComp.CosteUnitario := LT_PRODUCTO."Unit Cost";     //ADV002
                        //BOMComp."Importancia en Coste" := BOMComp."Quantity per" * LT_PRODUCTO."Unit Cost" / Item."Standard Cost" *100;
                        //-- #10652
                        //BOMComp.CosteUnitario := LT_PRODUCTO."Standard Cost";     //ADV002
                        BOMComp.CosteUnitario:=LT_PRODUCTO."Standard Cost" * BOMComp.GetUnitOfMeasurmentPer(BOMComp."No.", BOMComp."Unit of Measure Code");
                    //++ #10652
                    //BOMComp."Importancia en Coste" := BOMComp."Quantity per" * BOMComp.CosteUnitario / Item."Standard Cost" *100;
                    //--
                    END
                    ELSE IF(BOMComp.Type = BOMComp.Type::Resource) AND (BOMComp."Resource Usage Type" = BOMComp."Resource Usage Type"::Direct)THEN BEGIN
                            LT_RECURSO.GET(BOMComp."No.");
                            BOMComp.CosteUnitario:=LT_RECURSO."Unit Cost"; //ADV002
                        //BOMComp."Importancia en Coste" := BOMComp."Quantity per" * LT_RECURSO."Unit Cost"/ Item."Standard Cost" * 100;
                        END;
                    BOMComp.VALIDATE(BOMComp."Quantity per");
                    //ADV002 Inicio
                    //BOMComp."Coste Calculado" := BOMComp.CosteUnitario * BOMComp."Quantity per";
                    BOMComp.MODIFY;
                //ADV002 Fin
                end;
            //SL End Validacion de ItemNo. 
            UNTIL BOMComp.NEXT = 0;
        Item.ActualizarImportanciaEnCoste;
    //FIN ADV0001
    end;
    procedure CalcAssemblyItemPrice(ItemNo: Code[20])
    var
        Item: Record 27;
        Instruction: Text[1024];
        Depth: Integer;
        NewCalcMultiLevel: Boolean;
        AssemblyContainsProdBOM: Boolean;
    begin
        Item.GET(ItemNo);
        Instruction:=PrepareAssemblyCalculation(Item, Depth, 2, AssemblyContainsProdBOM); // 2=UnitPrice
        IF Depth > 1 THEN CASE STRMENU(Text001, 1, Instruction)OF 0: EXIT;
            1: NewCalcMultiLevel:=FALSE;
            2: NewCalcMultiLevel:=TRUE;
            END;
        SetProperties(WORKDATE, NewCalcMultiLevel, TRUE, FALSE, '', FALSE);
        Item.GET(ItemNo);
        DoCalcAssemblyItemPrice(Item, 0);
    end;
    local procedure DoCalcAssemblyItemPrice(var Item: Record 27; Level: Integer)
    var
        BOMComp: Record 90;
        CompItem: Record 27;
        CompResource: Record 156;
        UnitPrice: Decimal;
    begin
        IF Level > MaxLevel THEN ERROR(Text000, MaxLevel);
        IF NOT CalcMultiLevel AND (Level <> 0)THEN EXIT;
        IF NOT Item.IsAssemblyItem THEN EXIT;
        BOMComp.SETRANGE("Parent Item No.", Item."No.");
        IF BOMComp.FIND('-')THEN BEGIN
            REPEAT CASE BOMComp.Type OF BOMComp.Type::Item: IF CompItem.GET(BOMComp."No.")THEN BEGIN
                        DoCalcAssemblyItemPrice(CompItem, Level + 1);
                        UnitPrice+=BOMComp."Quantity per" * UOMMgt.GetQtyPerUnitOfMeasure(CompItem, BOMComp."Unit of Measure Code") * CompItem."Unit Price";
                    END;
                BOMComp.Type::Resource: IF CompResource.GET(BOMComp."No.")THEN UnitPrice+=BOMComp."Quantity per" * UOMMgt.GetResQtyPerUnitOfMeasure(CompResource, BOMComp."Unit of Measure Code") * CompResource."Unit Price";
                END UNTIL BOMComp.NEXT = 0;
            UnitPrice:=ROUND(UnitPrice, GLSetup."Unit-Amount Rounding Precision");
            Item.VALIDATE("Unit Price", UnitPrice);
            Item.MODIFY(TRUE)END;
    end;
    local procedure CalcMfgItem(ItemNo: Code[20]; var Item: Record 27; Level: Integer)
    var
        LotSize: Decimal;
        MfgItemQtyBase: Decimal;
        SLMat: Decimal;
        SLCap: Decimal;
        SLSub: Decimal;
        SLCapOvhd: Decimal;
        SLMfgOvhd: Decimal;
        RUMat: Decimal;
        RUCap: Decimal;
        RUSub: Decimal;
        RUCapOvhd: Decimal;
        RUMfgOvhd: Decimal;
    begin
        IF Level > MaxLevel THEN ERROR(Text000, MaxLevel);
        IF GetItem(ItemNo, Item)THEN EXIT;
        IF NOT CalcMultiLevel AND (Level <> 0)THEN EXIT;
        LotSize:=1;
        IF Item.IsMfgItem THEN BEGIN
            IF Item."Lot Size" <> 0 THEN LotSize:=Item."Lot Size";
            MfgItemQtyBase:=MfgCostCalcMgt.CalcQtyAdjdForBOMScrap(LotSize, Item."Scrap %");
            CalcRtngCost(Item."Routing No.", MfgItemQtyBase, SLCap, SLSub, SLCapOvhd);
            CalcProdBOMCost(Item, Item."Production BOM No.", Item."Routing No.", MfgItemQtyBase, TRUE, Level, SLMat, RUMat, RUCap, RUSub, RUCapOvhd, RUMfgOvhd);
            SLMfgOvhd:=CostCalcMgt.CalcOvhdCost(SLMat + SLCap + SLSub + SLCapOvhd, Item."Indirect Cost %", Item."Overhead Rate", LotSize);
            Item."Last Unit Cost Calc. Date":=CalculationDate;
        END
        ELSE IF Item.IsAssemblyItem THEN BEGIN
                CalcAssemblyItem(ItemNo, Item, Level, TRUE);
                EXIT END
            ELSE
            BEGIN
                SLMat:=Item."Unit Cost";
                RUMat:=Item."Unit Cost";
            END;
        Item."Single-Level Material Cost":=CalcCostPerUnit(SLMat, LotSize);
        Item."Single-Level Capacity Cost":=CalcCostPerUnit(SLCap, LotSize);
        Item."Single-Level Subcontrd. Cost":=CalcCostPerUnit(SLSub, LotSize);
        Item."Single-Level Cap. Ovhd Cost":=CalcCostPerUnit(SLCapOvhd, LotSize);
        Item."Single-Level Mfg. Ovhd Cost":=CalcCostPerUnit(SLMfgOvhd, LotSize);
        Item."Rolled-up Material Cost":=CalcCostPerUnit(RUMat, LotSize);
        Item."Rolled-up Capacity Cost":=CalcCostPerUnit(RUCap + SLCap, LotSize);
        Item."Rolled-up Subcontracted Cost":=CalcCostPerUnit(RUSub + SLSub, LotSize);
        Item."Rolled-up Cap. Overhead Cost":=CalcCostPerUnit(RUCapOvhd + SLCapOvhd, LotSize);
        Item."Rolled-up Mfg. Ovhd Cost":=CalcCostPerUnit(RUMfgOvhd + SLMfgOvhd, LotSize);
        Item."Standard Cost":=Item."Single-Level Material Cost" + Item."Single-Level Capacity Cost" + Item."Single-Level Subcontrd. Cost" + Item."Single-Level Cap. Ovhd Cost" + Item."Single-Level Mfg. Ovhd Cost";
        TempItem:=Item;
        TempItem.INSERT;
    end;
    local procedure SetProdBOMFilters(var ProdBOMLine: Record 99000772; var PBOMVersionCode: Code[10]; ProdBOMNo: Code[20])
    var
        ProdBOMHeader: Record 99000771;
    begin
        PBOMVersionCode:=VersionMgt.GetBOMVersion(ProdBOMNo, CalculationDate, TRUE);
        IF PBOMVersionCode = '' THEN BEGIN
            ProdBOMHeader.GET(ProdBOMNo);
            TestBOMVersionIsCertified(PBOMVersionCode, ProdBOMHeader);
        END;
        ProdBOMLine.SETRANGE("Production BOM No.", ProdBOMNo);
        ProdBOMLine.SETRANGE("Version Code", PBOMVersionCode);
        ProdBOMLine.SETFILTER("Starting Date", '%1|..%2', 0D, CalculationDate);
        ProdBOMLine.SETFILTER("Ending Date", '%1|%2..', 0D, CalculationDate);
        ProdBOMLine.SETFILTER("No.", '<>%1', '')end;
    local procedure CalcProdBOMCost(MfgItem: Record 27; ProdBOMNo: Code[20]; RtngNo: Code[20]; MfgItemQtyBase: Decimal; IsTypeItem: Boolean; Level: Integer; var SLMat: Decimal; var RUMat: Decimal; var RUCap: Decimal; var RUSub: Decimal; var RUCapOvhd: Decimal; var RUMfgOvhd: Decimal)
    var
        CompItem: Record 27;
        ProdBOMLine: Record 99000772;
        CompItemQtyBase: Decimal;
        UOMFactor: Decimal;
        PBOMVersionCode: Code[10];
    begin
        IF ProdBOMNo = '' THEN EXIT;
        SetProdBOMFilters(ProdBOMLine, PBOMVersionCode, ProdBOMNo);
        IF IsTypeItem THEN UOMFactor:=UOMMgt.GetQtyPerUnitOfMeasure(MfgItem, VersionMgt.GetBOMUnitOfMeasure(ProdBOMNo, PBOMVersionCode))
        ELSE
            UOMFactor:=1;
        REPEAT CompItemQtyBase:=MfgCostCalcMgt.CalcCompItemQtyBase(ProdBOMLine, CalculationDate, MfgItemQtyBase, RtngNo, IsTypeItem) / UOMFactor;
            CASE ProdBOMLine.Type OF ProdBOMLine.Type::Item: BEGIN
                CalcMfgItem(ProdBOMLine."No.", CompItem, Level + 1);
                IncrCost(SLMat, CompItem."Standard Cost", CompItemQtyBase);
                IncrCost(RUMat, CompItem."Rolled-up Material Cost", CompItemQtyBase);
                IncrCost(RUCap, CompItem."Rolled-up Capacity Cost", CompItemQtyBase);
                IncrCost(RUSub, CompItem."Rolled-up Subcontracted Cost", CompItemQtyBase);
                IncrCost(RUCapOvhd, CompItem."Rolled-up Cap. Overhead Cost", CompItemQtyBase);
                IncrCost(RUMfgOvhd, CompItem."Rolled-up Mfg. Ovhd Cost", CompItemQtyBase);
            END;
            ProdBOMLine.Type::"Production BOM": CalcProdBOMCost(MfgItem, ProdBOMLine."No.", RtngNo, CompItemQtyBase, FALSE, Level, SLMat, RUMat, RUCap, RUSub, RUCapOvhd, RUMfgOvhd);
            END;
        UNTIL ProdBOMLine.NEXT = 0;
    end;
    local procedure CalcRtngCost(RtngHeaderNo: Code[20]; MfgItemQtyBase: Decimal; var SLCap: Decimal; var SLSub: Decimal; var SLCapOvhd: Decimal)
    var
        RtngLine: Record 99000764;
        RtngHeader: Record 99000763;
    begin
        IF RtngLine.CertifiedRoutingVersionExists(RtngHeaderNo, CalculationDate)THEN BEGIN
            IF RtngLine."Version Code" = '' THEN BEGIN
                RtngHeader.GET(RtngHeaderNo);
                TestRtngVersionIsCertified(RtngLine."Version Code", RtngHeader);
            END;
            REPEAT CalcRtngLineCost(RtngLine, MfgItemQtyBase, SLCap, SLSub, SLCapOvhd);
            UNTIL RtngLine.NEXT = 0;
        END;
    end;
    local procedure CalcRtngCostPerUnit(Type: Option "Work Center", "Machine Center", " "; No: Code[20]; var DirUnitCost: Decimal; var IndirCostPct: Decimal; var OvhdRate: Decimal; var UnitCost: Decimal; var UnitCostCalculation: Option Time, Unit)
    var
        WorkCenter: Record 99000754;
        MachineCenter: Record 99000758;
    begin
        CASE Type OF Type::"Work Center": GetWorkCenter(No, WorkCenter);
        Type::"Machine Center": GetMachineCenter(No, MachineCenter);
        END;
        FunImp.RoutingCostPerUnit2(Type, DirUnitCost, IndirCostPct, OvhdRate, UnitCost, UnitCostCalculation, WorkCenter, MachineCenter);
    end;
    local procedure CalcCostPerUnit(CostPerLot: Decimal; LotSize: Decimal): Decimal begin
        EXIT(ROUND(CostPerLot / LotSize, GLSetup."Unit-Amount Rounding Precision"));
    end;
    local procedure TestBOMVersionIsCertified(BOMVersionCode: Code[20]; ProdBOMHeader: Record 99000771): Boolean begin
        IF BOMVersionCode = '' THEN BEGIN
            IF ProdBOMHeader.Status <> ProdBOMHeader.Status::Certified THEN IF LogErrors THEN InsertInErrBuf(ProdBOMHeader."No.", '', FALSE)
                ELSE
                    ProdBOMHeader.TESTFIELD(Status, ProdBOMHeader.Status::Certified);
        END;
    end;
    local procedure InsertInErrBuf(No: Code[20]; Version: Code[10]; IsRtng: Boolean)
    begin
        IF NOT LogErrors THEN EXIT;
        IF IsRtng THEN BEGIN
            RtngVersionErrBuf."Routing No.":=No;
            RtngVersionErrBuf."Version Code":=Version;
            IF RtngVersionErrBuf.INSERT THEN;
        END
        ELSE
        BEGIN
            ProdBOMVersionErrBuf."Production BOM No.":=No;
            ProdBOMVersionErrBuf."Version Code":=Version;
            IF ProdBOMVersionErrBuf.INSERT THEN;
        END;
    end;
    local procedure GetItem(ItemNo: Code[20]; var Item: Record 27)IsInBuffer: Boolean var
        StdCostWksh: Record 5841;
    begin
        IF TempItem.GET(ItemNo)THEN BEGIN
            Item:=TempItem;
            IsInBuffer:=TRUE;
        END
        ELSE
        BEGIN
            Item.GET(ItemNo);
            IF(StdCostWkshName <> '') AND NOT(Item.IsMfgItem OR Item.IsAssemblyItem)THEN BEGIN
                IF StdCostWksh.GET(StdCostWkshName, StdCostWksh.Type::Item, ItemNo)THEN BEGIN
                    Item."Unit Cost":=StdCostWksh."New Standard Cost";
                    Item."Standard Cost":=StdCostWksh."New Standard Cost";
                    Item."Indirect Cost %":=StdCostWksh."New Indirect Cost %";
                    Item."Overhead Rate":=StdCostWksh."New Overhead Rate";
                END;
            END;
            IsInBuffer:=FALSE;
        END;
    end;
    local procedure GetWorkCenter(No: Code[20]; var WorkCenter: Record 99000754)
    var
        StdCostWksh: Record 5841;
    begin
        IF TempWorkCenter.GET(No)THEN WorkCenter:=TempWorkCenter
        ELSE
        BEGIN
            WorkCenter.GET(No);
            IF StdCostWkshName <> '' THEN BEGIN
                IF StdCostWksh.GET(StdCostWkshName, StdCostWksh.Type::"Work Center", No)THEN BEGIN
                    WorkCenter."Unit Cost":=StdCostWksh."New Standard Cost";
                    WorkCenter."Indirect Cost %":=StdCostWksh."New Indirect Cost %";
                    WorkCenter."Overhead Rate":=StdCostWksh."New Overhead Rate";
                    WorkCenter."Direct Unit Cost":=CostCalcMgt.CalcDirUnitCost(StdCostWksh."New Standard Cost", StdCostWksh."New Overhead Rate", StdCostWksh."New Indirect Cost %");
                END;
            END;
            TempWorkCenter:=WorkCenter;
            TempWorkCenter.INSERT;
        END;
    end;
    local procedure GetMachineCenter(No: Code[20]; var MachineCenter: Record 99000758)
    var
        StdCostWksh: Record 5841;
    begin
        IF TempMachineCenter.GET(No)THEN MachineCenter:=TempMachineCenter
        ELSE
        BEGIN
            MachineCenter.GET(No);
            IF StdCostWkshName <> '' THEN BEGIN
                IF StdCostWksh.GET(StdCostWkshName, StdCostWksh.Type::"Machine Center", No)THEN BEGIN
                    MachineCenter."Unit Cost":=StdCostWksh."New Standard Cost";
                    MachineCenter."Indirect Cost %":=StdCostWksh."New Indirect Cost %";
                    MachineCenter."Overhead Rate":=StdCostWksh."New Overhead Rate";
                    MachineCenter."Direct Unit Cost":=CostCalcMgt.CalcDirUnitCost(StdCostWksh."New Standard Cost", StdCostWksh."New Overhead Rate", StdCostWksh."New Indirect Cost %");
                END;
            END;
            TempMachineCenter:=MachineCenter;
            TempMachineCenter.INSERT;
        END;
    end;
    #pragma warning disable AL0432
    local procedure GetResCost(No: Code[20]; var ResCost: Record 202)
    #pragma warning restore AL0432
    var
        StdCostWksh: Record 5841;
    begin
        IF TempResCost.GET(TempResCost.Type::Resource, No)THEN ResCost:=TempResCost
        ELSE
        BEGIN
            ResCost.INIT;
            ResCost.Code:=No;
            ResCost."Work Type Code":='';
            #pragma warning disable AL0432
            CODEUNIT.RUN(CODEUNIT::"Resource-Find Cost", ResCost);
            #pragma warning restore AL0432
            IF StdCostWkshName <> '' THEN BEGIN
                IF StdCostWksh.GET(StdCostWkshName, StdCostWksh.Type::Resource, No)THEN BEGIN
                    ResCost."Unit Cost":=StdCostWksh."New Standard Cost";
                    ResCost."Direct Unit Cost":=CostCalcMgt.CalcDirUnitCost(StdCostWksh."New Standard Cost", StdCostWksh."New Overhead Rate", StdCostWksh."New Indirect Cost %");
                END;
            END;
            TempResCost:=ResCost;
            TempResCost.INSERT;
        END;
    end;
    local procedure IncrCost(var Cost: Decimal; UnitCost: Decimal; Qty: Decimal)
    begin
        Cost:=Cost + (Qty * UnitCost);
    end;
    procedure CalculateAssemblyCostExp(AssemblyHeader: Record 900; var ExpCost: array[5]of Decimal)
    begin
        GLSetup.GET;
        ExpCost[RowIdx::AsmOvhd]:=ROUND(CalcOverHeadAmt(AssemblyHeader.CalcTotalCost(ExpCost), AssemblyHeader."Indirect Cost %", AssemblyHeader."Overhead Rate" * AssemblyHeader.Quantity), GLSetup."Unit-Amount Rounding Precision");
    end;
    local procedure CalculateAssemblyCostStd(ItemNo: Code[20]; QtyBase: Decimal; var StdCost: array[5]of Decimal)
    var
        Item: Record 27;
        StdTotalCost: Decimal;
    begin
        GLSetup.GET;
        Item.GET(ItemNo);
        StdCost[RowIdx::MatCost]:=ROUND(Item."Single-Level Material Cost" * QtyBase, GLSetup."Unit-Amount Rounding Precision");
        StdCost[RowIdx::ResCost]:=ROUND(Item."Single-Level Capacity Cost" * QtyBase, GLSetup."Unit-Amount Rounding Precision");
        StdCost[RowIdx::ResOvhd]:=ROUND(Item."Single-Level Cap. Ovhd Cost" * QtyBase, GLSetup."Unit-Amount Rounding Precision");
        StdTotalCost:=StdCost[RowIdx::MatCost] + StdCost[RowIdx::ResCost] + StdCost[RowIdx::ResOvhd];
        StdCost[RowIdx::AsmOvhd]:=ROUND(CalcOverHeadAmt(StdTotalCost, Item."Indirect Cost %", Item."Overhead Rate" * QtyBase), GLSetup."Unit-Amount Rounding Precision");
    end;
    procedure CalcOverHeadAmt(CostAmt: Decimal; IndirectCostPct: Decimal; OverheadRateAmt: Decimal): Decimal begin
        EXIT(CostAmt * IndirectCostPct / 100 + OverheadRateAmt);
    end;
    local procedure CalculatePostedAssemblyCostExp(PostedAssemblyHeader: Record 910; var ExpCost: array[5]of Decimal)
    begin
        GLSetup.GET;
        ExpCost[RowIdx::AsmOvhd]:=ROUND(CalcOverHeadAmt(PostedAssemblyHeader.CalcTotalCost(ExpCost), PostedAssemblyHeader."Indirect Cost %", PostedAssemblyHeader."Overhead Rate" * PostedAssemblyHeader.Quantity), GLSetup."Unit-Amount Rounding Precision");
    end;
    local procedure CalcTotalAndVar(var Value: array[5, 5]of Decimal)
    begin
        CalcTotal(Value);
        CalcVariance(Value);
    end;
    local procedure CalcTotal(var Value: array[5, 5]of Decimal)
    var
        RowId: Integer;
        ColId: Integer;
    begin
        FOR ColId:=1 TO 3 DO BEGIN
            Value[ColId, 5]:=0;
            FOR RowId:=1 TO 4 DO Value[ColId, 5]+=Value[ColId, RowId];
        END;
    end;
    local procedure CalcVariance(var Value: array[5, 5]of Decimal)
    var
        i: Integer;
    begin
        FOR i:=1 TO 5 DO BEGIN
            Value[ColIdx::Dev, i]:=CalcIndicatorPct(Value[ColIdx::StdCost, i], Value[ColIdx::ActCost, i]);
            Value[ColIdx::"Var", i]:=Value[ColIdx::ActCost, i] - Value[ColIdx::StdCost, i];
        END;
    end;
    local procedure CalcIndicatorPct(Value: Decimal; "Sum": Decimal): Decimal begin
        IF Value = 0 THEN EXIT(0);
        EXIT(ROUND((Sum - Value) / Value * 100, 1));
    end;
    procedure CalcAsmOrderStatistics(AssemblyHeader: Record 900; var Value: array[5, 5]of Decimal)
    begin
        CalculateAssemblyCostStd(AssemblyHeader."Item No.", AssemblyHeader."Quantity (Base)", Value[ColIdx::StdCost]);
        CalculateAssemblyCostExp(AssemblyHeader, Value[ColIdx::ExpCost]);
        AssemblyHeader.CalcActualCosts(Value[ColIdx::ActCost]);
        CalcTotalAndVar(Value);
    end;
    procedure CalcPostedAsmOrderStatistics(PostedAssemblyHeader: Record 910; var Value: array[5, 5]of Decimal)
    begin
        CalculateAssemblyCostStd(PostedAssemblyHeader."Item No.", PostedAssemblyHeader."Quantity (Base)", Value[ColIdx::StdCost]);
        CalculatePostedAssemblyCostExp(PostedAssemblyHeader, Value[ColIdx::ExpCost]);
        PostedAssemblyHeader.CalcActualCosts(Value[ColIdx::ActCost]);
        CalcTotalAndVar(Value);
    end;
    procedure CalcRtngLineCost(RtngLine: Record 99000764; MfgItemQtyBase: Decimal; var SLCap: Decimal; var SLSub: Decimal; var SLCapOvhd: Decimal)
    var
        WorkCenter: Record 99000754;
        CostCalculationMgt: Codeunit 5836;
        UnitCost: Decimal;
        DirUnitCost: Decimal;
        IndirCostPct: Decimal;
        OvhdRate: Decimal;
        CostTime: Decimal;
        UnitCostCalculation2: Option;
        UnitCostCalculation: Enum "Unit Cost Calculation Type";
    begin
        IF(RtngLine.Type = RtngLine.Type::"Work Center") AND (RtngLine."No." <> '')THEN WorkCenter.GET(RtngLine."No.");
        UnitCost:=RtngLine."Unit Cost per";
        CalcRtngCostPerUnit(RtngLine.Type.AsInteger(), RtngLine."No.", DirUnitCost, IndirCostPct, OvhdRate, UnitCost, UnitCostCalculation2);
        CostTime:=MfgCostCalcMgt.CalculateCostTime(MfgItemQtyBase, RtngLine."Setup Time", RtngLine."Setup Time Unit of Meas. Code", RtngLine."Run Time", RtngLine."Run Time Unit of Meas. Code", RtngLine."Lot Size", RtngLine."Scrap Factor % (Accumulated)", RtngLine."Fixed Scrap Qty. (Accum.)", RtngLine."Work Center No.", UnitCostCalculation, MfgSetup."Cost Incl. Setup", RtngLine."Concurrent Capacities");
        IF(RtngLine.Type = RtngLine.Type::"Work Center") AND (WorkCenter."Subcontractor No." <> '')THEN IncrCost(SLSub, DirUnitCost, CostTime)
        ELSE
            IncrCost(SLCap, DirUnitCost, CostTime);
        IncrCost(SLCapOvhd, CostCalcMgt.CalcOvhdCost(DirUnitCost, IndirCostPct, OvhdRate, 1), CostTime);
    end;
    local procedure TestRtngVersionIsCertified(RtngVersionCode: Code[20]; RtngHeader: Record 99000763): Boolean begin
        IF RtngVersionCode = '' THEN BEGIN
            IF RtngHeader.Status <> RtngHeader.Status::Certified THEN IF LogErrors THEN InsertInErrBuf(RtngHeader."No.", '', TRUE)
                ELSE
                    RtngHeader.TESTFIELD(Status, RtngHeader.Status::Certified);
        END;
    end;
    procedure GetCalcItemParameters(VarSkipCalcItemMessageLocal: Boolean; DepthLocal: Integer; AssemblyContainsProdBOMLocal: Boolean; NewCalcMultiLevelLocal: Boolean)
    begin
        //-- #10777
        VarSkipCalcItemMessageGlobal:=VarSkipCalcItemMessageLocal;
        DepthGlobal:=DepthLocal;
        AssemblyContainsProdBOMGlobal:=AssemblyContainsProdBOMLocal;
        NewCalcMultiLevelGlobal:=NewCalcMultiLevelLocal;
    //++ #10777
    end;
}
