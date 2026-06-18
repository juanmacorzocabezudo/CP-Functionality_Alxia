codeunit 50002 AlxiaAssemblyInfoManagement
{
    // ADVANCE - Log de cambios
    // -----------------------------------------------------
    //   ADVANCE
    //   Fecha: 11-04-2016
    //   Técnico: JMAP
    //   Presupuesto: Proyecto I002074 - Desarrollo funcionalidades Recetas
    // 
    //   Etiqueta: ADV001
    // -----------------------------------------------------
    // #9766 - Se añaden las funciones para calcular los costes estandar
    // #10652 - Se introduce codigo para poner el coste en unidad medida base
    trigger OnRun()
    begin
    end;
    var Item: Record 27;
    AvailableToPromise: Codeunit 5790;
    procedure CalcAvailability(var AsmLine: Record 901): Decimal var
        GrossRequirement: Decimal;
        ScheduledReceipt: Decimal;
        //PeriodType: Option Day,Week,Month,Quarter,Year;
        PeriodType: Enum "Analysis Period Type";
        LookaheadDateformula: DateFormula;
    begin
        IF GetItem(AsmLine)THEN BEGIN
            SetItemFilter(Item, AsmLine);
            EXIT(AvailableToPromise.CalcQtyAvailableToPromise(Item, GrossRequirement, ScheduledReceipt, CalcAvailabilityDate(AsmLine), PeriodType, LookaheadDateformula));
        END;
    end;
    local procedure CalcAvailabilityDate(AsmLine: Record 901): Date begin
        IF AsmLine."Due Date" <> 0D THEN EXIT(AsmLine."Due Date");
        EXIT(WORKDATE);
    end;
    procedure CalcAvailableInventory(var AsmLine: Record 901): Decimal begin
        IF GetItem(AsmLine)THEN BEGIN
            SetItemFilter(Item, AsmLine);
            EXIT(AvailableToPromise.CalcAvailableInventory(Item));
        END;
    end;
    procedure CalcScheduledReceipt(var AsmLine: Record 901): Decimal begin
        IF GetItem(AsmLine)THEN BEGIN
            SetItemFilter(Item, AsmLine);
            EXIT(AvailableToPromise.CalcScheduledReceipt(Item));
        END;
    end;
    procedure CalcGrossRequirement(var AsmLine: Record 901): Decimal begin
        IF GetItem(AsmLine)THEN BEGIN
            SetItemFilter(Item, AsmLine);
            EXIT(AvailableToPromise.CalcGrossRequirement(Item));
        END;
    end;
    procedure CalcReservedReceipt(var AsmLine: Record 901): Decimal begin
        IF GetItem(AsmLine)THEN BEGIN
            SetItemFilter(Item, AsmLine);
            EXIT(AvailableToPromise.CalcReservedReceipt(Item));
        END;
    end;
    procedure CalcReservedRequirement(var AsmLine: Record 901): Decimal begin
        IF GetItem(AsmLine)THEN BEGIN
            SetItemFilter(Item, AsmLine);
            EXIT(AvailableToPromise.CalcReservedRequirement(Item));
        END;
    end;
    local procedure CalcNoOfSubstitutions(var AsmLine: Record 901): Integer begin
        IF GetItem(AsmLine)THEN BEGIN
            Item.CALCFIELDS("No. of Substitutes");
            EXIT(Item."No. of Substitutes");
        END;
    end;
    local procedure ItemCommentExists(AsmLine: Record 901): Boolean begin
        IF GetItem(AsmLine)THEN BEGIN
            Item.CALCFIELDS(Comment);
            EXIT(Item.Comment);
        END;
    end;
    procedure LookupItem(AsmLine: Record 901)
    begin
        AsmLine.TESTFIELD(Type, AsmLine.Type::Item);
        AsmLine.TESTFIELD("No.");
        GetItem(AsmLine);
        PAGE.RUNMODAL(PAGE::"Item Card", Item);
    end;
    local procedure LookupItemComment(AsmLine: Record 901)
    var
        CommentLine: Record 97;
    begin
        IF GetItem(AsmLine)THEN BEGIN
            CommentLine.SETRANGE("Table Name", CommentLine."Table Name"::Item);
            CommentLine.SETRANGE("No.", AsmLine."No.");
            PAGE.RUNMODAL(PAGE::"Comment Sheet", CommentLine);
        END;
    end;
    local procedure GetItem(AsmLine: Record 901): Boolean begin
        IF(AsmLine.Type <> AsmLine.Type::Item) OR (AsmLine."No." = '')THEN EXIT(FALSE);
        IF AsmLine."No." <> Item."No." THEN Item.GET(AsmLine."No.");
        EXIT(TRUE);
    end;
    local procedure SetItemFilter(var Item: Record 27; AsmLine: Record 901)
    begin
        Item.RESET;
        Item.SETRANGE("Date Filter", 0D, CalcAvailabilityDate(AsmLine));
        Item.SETRANGE("Variant Filter", AsmLine."Variant Code");
        Item.SETRANGE("Location Filter", AsmLine."Location Code");
        Item.SETRANGE("Drop Shipment Filter", FALSE);
    end;
    procedure CalcItemCosteCalculado(var Rcd_Item: Record 27; VarActual: Boolean): Decimal var
        BOMComp: Record 90;
        costeEstandarArticulos: Decimal;
        ItemAux: Record 27;
        Resource: Record 156;
    begin
        //ADV001 Inicio
        IF VarActual THEN BEGIN
            costeEstandarArticulos:=0;
            BOMComp.RESET;
            BOMComp.SETCURRENTKEY("Parent Item No.", Type, TipoRecurso, Position);
            BOMComp.SETRANGE("Parent Item No.", Rcd_Item."No.");
            //BOMComp.SETRANGE(Type, BOMComp.Type::Item);
            BOMComp.SETRANGE(Maquila, FALSE);
            IF BOMComp.FINDFIRST THEN REPEAT IF BOMComp.Type = BOMComp.Type::Item THEN BEGIN
                        ItemAux.GET(BOMComp."No.");
                        //-- #10652
                        //costeEstandarArticulos += BOMComp."Quantity per" * ItemAux."Standard Cost";
                        costeEstandarArticulos+=BOMComp."Quantity per" * ItemAux."Standard Cost" * BOMComp.GetUnitOfMeasurmentPer(BOMComp."No.", BOMComp."Unit of Measure Code");
                    //++ #10652
                    END
                    ELSE IF BOMComp.Type = BOMComp.Type::Resource THEN BEGIN
                            Resource.GET(BOMComp."No.");
                            costeEstandarArticulos+=BOMComp."Quantity per" * Resource."Unit Cost";
                        END;
                UNTIL BOMComp.NEXT = 0;
            EXIT(costeEstandarArticulos);
        END
        ELSE
        BEGIN
            BOMComp.RESET;
            BOMComp.SETCURRENTKEY("Parent Item No.", Type, TipoRecurso, Position);
            BOMComp.SETRANGE("Parent Item No.", Rcd_Item."No.");
            BOMComp.SETRANGE(Maquila, FALSE);
            BOMComp.CALCSUMS("Coste Calculado");
            EXIT(BOMComp."Coste Calculado");
        END;
    //ADV001 Fin
    end;
    procedure CalcItemCostCalcResType(var Rcd_Item: Record 27; ResourceType: Integer): Decimal var
        BOMComp: Record 90;
    begin
        //ADV001 Inicio
        BOMComp.RESET;
        BOMComp.SETCURRENTKEY("Parent Item No.", Type, TipoRecurso, Position);
        BOMComp.SETRANGE("Parent Item No.", Rcd_Item."No.");
        BOMComp.SETRANGE(Type, BOMComp.Type::Resource);
        BOMComp.SETRANGE(TipoRecurso, ResourceType);
        BOMComp.SETRANGE(Maquila, FALSE);
        BOMComp.CALCSUMS("Coste Calculado");
        EXIT(BOMComp."Coste Calculado");
    //ADV001 Fin
    end;
    procedure CalcItemPerCostCalcResType(var Rcd_Item: Record 27; ResourceType: Integer)ReturPerCost: Decimal var
        VarTotalCost: Decimal;
        VarTotalCostType: Decimal;
    begin
        //-- #9993
        CLEAR(ReturPerCost);
        CLEAR(VarTotalCost);
        CLEAR(VarTotalCostType);
        VarTotalCost:=CalcItemCosteCalculado(Rcd_Item, FALSE);
        VarTotalCostType:=CalcItemCostCalcResType(Rcd_Item, ResourceType);
        IF VarTotalCost <> 0 THEN ReturPerCost:=ROUND((VarTotalCostType * 100 / VarTotalCost), 0.01);
        EXIT(ReturPerCost);
    //++ #9993
    end;
    procedure CalcItemCostCalcItem(var Rcd_Item: Record 27): Decimal var
        BOMComp: Record 90;
    begin
        //ADV001 Inicio
        BOMComp.RESET;
        BOMComp.SETCURRENTKEY("Parent Item No.", Type, TipoRecurso, Position);
        BOMComp.SETRANGE("Parent Item No.", Rcd_Item."No.");
        BOMComp.SETRANGE(Type, BOMComp.Type::Item);
        BOMComp.SETRANGE(Maquila, FALSE);
        BOMComp.CALCSUMS("Coste Calculado");
        EXIT(BOMComp."Coste Calculado");
    //ADV001 Fin
    end;
    procedure CalcItemCostCalcPosition(var Rcd_Item: Record 27; Pos: Code[10]): Decimal var
        BOMComp: Record 90;
    begin
        //ADV001 Inicio
        BOMComp.RESET;
        BOMComp.SETCURRENTKEY("Parent Item No.", Type, TipoRecurso, Position);
        BOMComp.SETRANGE("Parent Item No.", Rcd_Item."No.");
        BOMComp.SETRANGE(Position, Pos);
        BOMComp.SETRANGE(Maquila, FALSE);
        BOMComp.CALCSUMS("Coste Calculado");
        EXIT(BOMComp."Coste Calculado");
    //ADV001 Fin
    end;
    procedure CalcItemCostCalcProdType(var Rcd_Item: Record 27; VarProdType: Text[20]): Decimal var
        BOMComp: Record 90;
    begin
        //-- #9993
        BOMComp.RESET;
        BOMComp.SETCURRENTKEY("Parent Item No.", Type, TipoRecurso, Position);
        BOMComp.SETRANGE("Parent Item No.", Rcd_Item."No.");
        BOMComp.SETRANGE(Type, BOMComp.Type::Item);
        IF VarProdType <> '' THEN BOMComp.SETFILTER("No.", VarProdType);
        BOMComp.SETRANGE(Maquila, FALSE);
        BOMComp.CALCSUMS("Coste Calculado");
        EXIT(BOMComp."Coste Calculado");
    //+ #9993
    end;
    procedure CalcItemPerCostCalcProdType(var Rcd_Item: Record 27; VarProdType: Text[20])ReturPerCost: Decimal var
        VarTotalCost: Decimal;
        VarTotalCostType: Decimal;
    begin
        //-- #9993
        CLEAR(ReturPerCost);
        CLEAR(VarTotalCost);
        CLEAR(VarTotalCostType);
        VarTotalCost:=CalcItemCosteCalculado(Rcd_Item, FALSE);
        VarTotalCostType:=CalcItemCostCalcProdType(Rcd_Item, VarProdType);
        IF VarTotalCost <> 0 THEN ReturPerCost:=ROUND((VarTotalCostType * 100 / VarTotalCost), 0.01);
        EXIT(ReturPerCost);
    //++ #9993
    end;
    procedure CalcItemUnitCosteCalculado(var Rcd_Item: Record 27)ReturnCost: Decimal var
        BOMComp: Record 90;
    begin
        //-- #9766
        CLEAR(ReturnCost);
        BOMComp.RESET;
        BOMComp.SETCURRENTKEY("Parent Item No.", Type, TipoRecurso, Position);
        BOMComp.SETRANGE("Parent Item No.", Rcd_Item."No.");
        BOMComp.SETRANGE(Maquila, FALSE);
        IF BOMComp.FINDSET THEN BEGIN
            REPEAT //++ KR 06/07/21
                ReturnCost:=ReturnCost + (BOMComp.CalcItemUnitCost(BOMComp) * BOMComp."Quantity per");
            //ReturnCost := ReturnCost + (BOMComp.CalcItemStandardCost(BOMComp)*BOMComp."Quantity per");
            //--
            UNTIL BOMComp.NEXT = 0;
        END;
        EXIT(ReturnCost);
    //++ #9766
    end;
    procedure CalcItemUnitCostCalcItem(var Rcd_Item: Record 27)ReturnCost: Decimal var
        BOMComp: Record 90;
    begin
        //-- #9766
        CLEAR(ReturnCost);
        BOMComp.RESET;
        BOMComp.SETCURRENTKEY("Parent Item No.", Type, TipoRecurso, Position);
        BOMComp.SETRANGE("Parent Item No.", Rcd_Item."No.");
        BOMComp.SETRANGE(Maquila, FALSE);
        BOMComp.SETRANGE(Type, BOMComp.Type::Item);
        IF BOMComp.FINDSET THEN BEGIN
            REPEAT ReturnCost:=ReturnCost + (BOMComp.CalcItemUnitCost(BOMComp) * BOMComp."Quantity per");
            UNTIL BOMComp.NEXT = 0;
        END;
        EXIT(ReturnCost);
    //++ #9766
    end;
    procedure CalcItemUnitCostCalcPosition(var Rcd_Item: Record 27; Pos: Code[10])ReturnCost: Decimal var
        BOMComp: Record 90;
    begin
        //-- #9766
        CLEAR(ReturnCost);
        BOMComp.RESET;
        BOMComp.SETCURRENTKEY("Parent Item No.", Type, TipoRecurso, Position);
        BOMComp.SETRANGE("Parent Item No.", Rcd_Item."No.");
        BOMComp.SETRANGE(Position, Pos);
        BOMComp.SETRANGE(Maquila, FALSE);
        IF BOMComp.FINDSET THEN BEGIN
            REPEAT ReturnCost:=ReturnCost + (BOMComp.CalcItemUnitCost(BOMComp) * BOMComp."Quantity per");
            UNTIL BOMComp.NEXT = 0;
        END;
        EXIT(ReturnCost);
    //++ #9766
    end;
    procedure CalcItemUnitCostCalcProdType(var Rcd_Item: Record 27; VarProdType: Text[20])ReturnCost: Decimal var
        BOMComp: Record 90;
    begin
        //-- #9993
        CLEAR(ReturnCost);
        BOMComp.RESET;
        BOMComp.SETCURRENTKEY("Parent Item No.", Type, TipoRecurso, Position);
        BOMComp.SETRANGE("Parent Item No.", Rcd_Item."No.");
        BOMComp.SETRANGE(Type, BOMComp.Type::Item);
        IF VarProdType <> '' THEN BOMComp.SETFILTER("No.", VarProdType);
        BOMComp.SETRANGE(Maquila, FALSE);
        IF BOMComp.FINDSET THEN BEGIN
            REPEAT ReturnCost:=ReturnCost + (BOMComp.CalcItemUnitCost(BOMComp) * BOMComp."Quantity per");
            UNTIL BOMComp.NEXT = 0;
        END;
        EXIT(ReturnCost)//+ #9993
    end;
    procedure CalcItemPerUnitCostCalcProdType(var Rcd_Item: Record 27; VarProdType: Text[20])ReturPerCost: Decimal var
        VarTotalCost: Decimal;
        VarTotalCostType: Decimal;
    begin
        //-- #9993
        CLEAR(ReturPerCost);
        CLEAR(VarTotalCost);
        CLEAR(VarTotalCostType);
        VarTotalCost:=CalcItemUnitCosteCalculado(Rcd_Item);
        VarTotalCostType:=CalcItemUnitCostCalcProdType(Rcd_Item, VarProdType);
        IF VarTotalCost <> 0 THEN ReturPerCost:=ROUND((VarTotalCostType * 100 / VarTotalCost), 0.01);
        EXIT(ReturPerCost);
    //++ #9993
    end;
    procedure CalcBOMVersionItemCosteCalculado(var ParBOMVersionHeader: Record 50024): Decimal var
        BOMVersionLines: Record 50025;
    begin
        //-- #9862
        BOMVersionLines.RESET;
        BOMVersionLines.SETCURRENTKEY("Parent Item No.", Type, TipoRecurso, Position);
        BOMVersionLines.SETRANGE("Parent Item No.", ParBOMVersionHeader."Item No.");
        BOMVersionLines.SETRANGE("BOM Version", ParBOMVersionHeader."BOM Version");
        BOMVersionLines.SETRANGE(Maquila, FALSE);
        BOMVersionLines.CALCSUMS("Coste Calculado");
        EXIT(BOMVersionLines."Coste Calculado");
    //++ #9862
    end;
    procedure CalcBOMVersionItemCostCalcResType(var ParBOMVersionHeader: Record 50024; ResourceType: Integer): Decimal var
        BOMVersionLines: Record 50025;
    begin
        //-- #9862
        BOMVersionLines.RESET;
        BOMVersionLines.SETCURRENTKEY("Parent Item No.", Type, TipoRecurso, Position);
        BOMVersionLines.SETRANGE("Parent Item No.", ParBOMVersionHeader."Item No.");
        BOMVersionLines.SETRANGE("BOM Version", ParBOMVersionHeader."BOM Version");
        BOMVersionLines.SETRANGE(Type, BOMVersionLines.Type::Resource);
        BOMVersionLines.SETRANGE(TipoRecurso, ResourceType);
        BOMVersionLines.SETRANGE(Maquila, FALSE);
        BOMVersionLines.CALCSUMS("Coste Calculado");
        EXIT(BOMVersionLines."Coste Calculado");
    //++ #9862
    end;
    procedure CalcBOMVersionItemPerCostCalcResType(var ParBOMVersionHeader: Record 50024; ResourceType: Integer)ReturPerCost: Decimal var
        VarTotalCost: Decimal;
        VarTotalCostType: Decimal;
    begin
        //-- #9993
        CLEAR(ReturPerCost);
        CLEAR(VarTotalCost);
        CLEAR(VarTotalCostType);
        VarTotalCost:=CalcBOMVersionItemCosteCalculado(ParBOMVersionHeader);
        VarTotalCostType:=CalcBOMVersionItemCostCalcResType(ParBOMVersionHeader, ResourceType);
        IF VarTotalCost <> 0 THEN ReturPerCost:=ROUND((VarTotalCostType * 100 / VarTotalCost), 0.01);
        EXIT(ReturPerCost);
    //++ #9993
    end;
    procedure CalcBOMVersionItemCostCalcItem(var ParBOMVersionHeader: Record 50024): Decimal var
        BOMVersionLines: Record 50025;
    begin
        //-- #9862
        BOMVersionLines.RESET;
        BOMVersionLines.SETCURRENTKEY("Parent Item No.", Type, TipoRecurso, Position);
        BOMVersionLines.SETRANGE("Parent Item No.", ParBOMVersionHeader."Item No.");
        BOMVersionLines.SETRANGE("BOM Version", ParBOMVersionHeader."BOM Version");
        BOMVersionLines.SETRANGE(Type, BOMVersionLines.Type::Item);
        BOMVersionLines.SETRANGE(Maquila, FALSE);
        BOMVersionLines.CALCSUMS("Coste Calculado");
        EXIT(BOMVersionLines."Coste Calculado");
    //++ #9862
    end;
    procedure CalcBOMVersionItemCostCalcPosition(var ParBOMVersionHeader: Record 50024; Pos: Code[10]): Decimal var
        BOMVersionLines: Record 50025;
    begin
        //-- #9862
        BOMVersionLines.RESET;
        BOMVersionLines.SETCURRENTKEY("Parent Item No.", Type, TipoRecurso, Position);
        BOMVersionLines.SETRANGE("Parent Item No.", ParBOMVersionHeader."Item No.");
        BOMVersionLines.SETRANGE("BOM Version", ParBOMVersionHeader."BOM Version");
        BOMVersionLines.SETRANGE(Position, Pos);
        BOMVersionLines.SETRANGE(Maquila, FALSE);
        BOMVersionLines.CALCSUMS("Coste Calculado");
        EXIT(BOMVersionLines."Coste Calculado");
    //++ #9862
    end;
    procedure CalcBOMVersionItemCostCalcType(var ParBOMVersionHeader: Record 50024; VarProdType: Text[20]): Decimal var
        BOMVersionLines: Record 50025;
    begin
        //-- #9862
        BOMVersionLines.RESET;
        BOMVersionLines.SETCURRENTKEY("Parent Item No.", Type, TipoRecurso, Position);
        BOMVersionLines.SETRANGE("Parent Item No.", ParBOMVersionHeader."Item No.");
        BOMVersionLines.SETRANGE("BOM Version", ParBOMVersionHeader."BOM Version");
        IF VarProdType <> '' THEN BOMVersionLines.SETFILTER("No.", VarProdType);
        BOMVersionLines.SETRANGE(Maquila, FALSE);
        BOMVersionLines.CALCSUMS("Coste Calculado");
        EXIT(BOMVersionLines."Coste Calculado");
    //++ #9862
    end;
    procedure CalcBOMVersionItemPerCostCalcType(var ParBOMVersionHeader: Record 50024; VarProdType: Text[20])ReturPerCost: Decimal var
        VarTotalCost: Decimal;
        VarTotalCostType: Decimal;
    begin
        //-- #9993
        CLEAR(ReturPerCost);
        CLEAR(VarTotalCost);
        CLEAR(VarTotalCostType);
        VarTotalCost:=CalcBOMVersionItemCosteCalculado(ParBOMVersionHeader);
        VarTotalCostType:=CalcBOMVersionItemCostCalcType(ParBOMVersionHeader, VarProdType);
        IF VarTotalCost <> 0 THEN ReturPerCost:=ROUND((VarTotalCostType * 100 / VarTotalCost), 0.01);
        EXIT(ReturPerCost);
    //++ #9993
    end;
    procedure CalcBOMVersionItemUnitCosteCalculado(var ParBOMVersionHeader: Record 50024)ReturnCost: Decimal var
        BOMVersionLines: Record 50025;
    begin
        //-- #9862
        CLEAR(ReturnCost);
        BOMVersionLines.RESET;
        BOMVersionLines.SETCURRENTKEY("Parent Item No.", Type, TipoRecurso, Position);
        BOMVersionLines.SETRANGE("Parent Item No.", ParBOMVersionHeader."Item No.");
        BOMVersionLines.SETRANGE("BOM Version", ParBOMVersionHeader."BOM Version");
        BOMVersionLines.SETRANGE(Maquila, FALSE);
        IF BOMVersionLines.FINDSET THEN BEGIN
            REPEAT ReturnCost:=ReturnCost + (BOMVersionLines.CalcItemUnitCost(BOMVersionLines) * BOMVersionLines."Quantity per");
            UNTIL BOMVersionLines.NEXT = 0;
        END;
        EXIT(ReturnCost);
    //++ #9862
    end;
    procedure CalcBOMVersionItemUnitCostCalcItem(var ParBOMVersionHeader: Record 50024)ReturnCost: Decimal var
        BOMVersionLines: Record 50025;
    begin
        //-- #9862
        CLEAR(ReturnCost);
        BOMVersionLines.RESET;
        BOMVersionLines.SETCURRENTKEY("Parent Item No.", Type, TipoRecurso, Position);
        BOMVersionLines.SETRANGE("Parent Item No.", ParBOMVersionHeader."Item No.");
        BOMVersionLines.SETRANGE("BOM Version", ParBOMVersionHeader."BOM Version");
        BOMVersionLines.SETRANGE(Type, BOMVersionLines.Type::Item);
        BOMVersionLines.SETRANGE(Maquila, FALSE);
        IF BOMVersionLines.FINDSET THEN BEGIN
            REPEAT ReturnCost:=ReturnCost + (BOMVersionLines.CalcItemUnitCost(BOMVersionLines) * BOMVersionLines."Quantity per");
            UNTIL BOMVersionLines.NEXT = 0;
        END;
        EXIT(ReturnCost);
    //++ #9862
    end;
    procedure CalcBOMVersionItemUnitCostCalcPosition(var ParBOMVersionHeader: Record 50024; Pos: Code[10])ReturnCost: Decimal var
        BOMVersionLines: Record 50025;
    begin
        //-- #9862
        CLEAR(ReturnCost);
        BOMVersionLines.RESET;
        BOMVersionLines.SETCURRENTKEY("Parent Item No.", Type, TipoRecurso, Position);
        BOMVersionLines.SETRANGE("Parent Item No.", ParBOMVersionHeader."Item No.");
        BOMVersionLines.SETRANGE("BOM Version", ParBOMVersionHeader."BOM Version");
        BOMVersionLines.SETRANGE(Maquila, FALSE);
        BOMVersionLines.SETRANGE(Position, Pos);
        IF BOMVersionLines.FINDSET THEN BEGIN
            REPEAT ReturnCost:=ReturnCost + (BOMVersionLines.CalcItemUnitCost(BOMVersionLines) * BOMVersionLines."Quantity per");
            UNTIL BOMVersionLines.NEXT = 0;
        END;
        EXIT(ReturnCost);
    //++ #9862
    end;
    procedure CalcBOMVersionItemUnitCostCalcType(var ParBOMVersionHeader: Record 50024; VarProdType: Text[20])ReturnCost: Decimal var
        BOMVersionLines: Record 50025;
    begin
        //-- #9993
        CLEAR(ReturnCost);
        BOMVersionLines.RESET;
        BOMVersionLines.SETCURRENTKEY("Parent Item No.", Type, TipoRecurso, Position);
        BOMVersionLines.SETRANGE("Parent Item No.", ParBOMVersionHeader."Item No.");
        BOMVersionLines.SETRANGE("BOM Version", ParBOMVersionHeader."BOM Version");
        BOMVersionLines.SETRANGE(Maquila, FALSE);
        IF VarProdType <> '' THEN BOMVersionLines.SETFILTER("No.", VarProdType);
        BOMVersionLines.SETRANGE(Maquila, FALSE);
        IF BOMVersionLines.FINDSET THEN BEGIN
            REPEAT ReturnCost:=ReturnCost + (BOMVersionLines.CalcItemUnitCost(BOMVersionLines) * BOMVersionLines."Quantity per");
            UNTIL BOMVersionLines.NEXT = 0;
        END;
        EXIT(ReturnCost);
    //+ #9993
    end;
    procedure CalcBOMVersionItemPerUnitCostCalcType(var ParBOMVersionHeader: Record 50024; VarProdType: Text[20])ReturPerCost: Decimal var
        VarTotalCost: Decimal;
        VarTotalCostType: Decimal;
    begin
        //-- #9993
        CLEAR(ReturPerCost);
        CLEAR(VarTotalCost);
        CLEAR(VarTotalCostType);
        VarTotalCost:=CalcBOMVersionItemUnitCosteCalculado(ParBOMVersionHeader);
        VarTotalCostType:=CalcBOMVersionItemUnitCostCalcType(ParBOMVersionHeader, VarProdType);
        IF VarTotalCost <> 0 THEN ReturPerCost:=ROUND((VarTotalCostType * 100 / VarTotalCost), 0.01);
        EXIT(ReturPerCost);
    //++ #9993
    end;
    procedure CalcAditionalUnitTotalCoste(ItemNo: Code[20]; BOMVersion: Integer; VarActual: Boolean)ReturnCost: Decimal var
        BOMAditionalCostCheck: Record 50029;
    begin
        //-- #9766
        CLEAR(ReturnCost);
        BOMAditionalCostCheck.RESET;
        BOMAditionalCostCheck.SETRANGE("Item No", ItemNo);
        BOMAditionalCostCheck.SETRANGE("BOM Version", BOMVersion);
        IF BOMAditionalCostCheck.FINDSET THEN BEGIN
            REPEAT IF VarActual THEN ReturnCost:=ReturnCost + CalcAditionalUnitCoste(BOMAditionalCostCheck, VarActual)
                ELSE
                    ReturnCost:=ReturnCost + BOMAditionalCostCheck."Aditional standard cost";
            UNTIL BOMAditionalCostCheck.NEXT = 0;
        END;
        EXIT(ReturnCost);
    //++ #9766
    end;
    procedure CalcAditionalUnitTotalCosteReceta(ItemNo: Code[20]; BOMVersion: Integer; varActual: Boolean)ReturnCost: Decimal var
        BOMAditionalCostCheck: Record 50029;
        CosteReceta: Decimal;
        Item: Record 27;
    begin
        //-- #9766
        /*
        CLEAR(ReturnCost);
        
        BOMAditionalCostCheck.RESET;
        BOMAditionalCostCheck.SETRANGE("Item No", ItemNo);
        BOMAditionalCostCheck.SETRANGE("BOM Version", BOMVersion);
        IF BOMAditionalCostCheck.FINDSET THEN BEGIN
           REPEAT
             IF VarActual THEN
                ReturnCost := ReturnCost + CalcAditionalUnitCoste(BOMAditionalCostCheck, VarActual)
             ELSE
                ReturnCost := ReturnCost + BOMAditionalCostCheck."Aditional standard cost";
           UNTIL BOMAditionalCostCheck.NEXT = 0;
        END;
        
        EXIT(ReturnCost);
        */
        //++ #9766
        Item.GET(ItemNo);
        CosteReceta:=CalcItemCosteCalculado(Item, varActual);
        BOMAditionalCostCheck.RESET;
        BOMAditionalCostCheck.SETRANGE("Item No", ItemNo);
        BOMAditionalCostCheck.SETRANGE("BOM Version", BOMVersion);
        BOMAditionalCostCheck.SETRANGE("Apply on all cost", FALSE);
        IF BOMAditionalCostCheck.FINDSET THEN BEGIN
            REPEAT IF BOMAditionalCostCheck."Type Coste" = BOMAditionalCostCheck."Type Coste"::"%" THEN BEGIN
                    ReturnCost:=ReturnCost + (CosteReceta * BOMAditionalCostCheck.Value / 100);
                END
                ELSE
                BEGIN
                    ReturnCost:=ReturnCost + BOMAditionalCostCheck.Value;
                END;
            UNTIL BOMAditionalCostCheck.NEXT = 0;
        END;
        BOMAditionalCostCheck.RESET;
        BOMAditionalCostCheck.SETRANGE("Item No", ItemNo);
        BOMAditionalCostCheck.SETRANGE("BOM Version", BOMVersion);
        BOMAditionalCostCheck.SETRANGE("Apply on all cost", TRUE);
        IF BOMAditionalCostCheck.FINDSET THEN BEGIN
            REPEAT IF BOMAditionalCostCheck."Type Coste" = BOMAditionalCostCheck."Type Coste"::"%" THEN BEGIN
                    ReturnCost:=ReturnCost + ((ReturnCost + CosteReceta) * BOMAditionalCostCheck.Value / 100);
                END
                ELSE
                BEGIN
                    ReturnCost:=ReturnCost + BOMAditionalCostCheck.Value;
                END;
            UNTIL BOMAditionalCostCheck.NEXT = 0;
        END;
        EXIT(ReturnCost);
    end;
    procedure CalcAditionalFixedTotalCoste(ItemNo: Code[20]; BOMVersion: Integer)ReturnCost: Decimal var
        BOMAditionalCostCheck: Record 50029;
    begin
        //-- #9766
        CLEAR(ReturnCost);
        BOMAditionalCostCheck.RESET;
        BOMAditionalCostCheck.SETRANGE("Item No", ItemNo);
        BOMAditionalCostCheck.SETRANGE("BOM Version", BOMVersion);
        IF BOMAditionalCostCheck.FINDSET THEN BEGIN
            REPEAT ReturnCost:=ReturnCost + BOMAditionalCostCheck."Aditional fixed cost";
            UNTIL BOMAditionalCostCheck.NEXT = 0;
        END;
        EXIT(ReturnCost);
    //++ #9766
    end;
    procedure CalcAditionalUnitCoste(BOMAditionalCost: Record 50029; VarActual: Boolean)ReturnCost: Decimal var
        BOMCost: Decimal;
        Item: Record 27;
        BOMVersionHeader: Record 50024;
        BOMAditionalCostCheck: Record 50029;
    begin
        //-- #9766
        CLEAR(BOMCost);
        CLEAR(ReturnCost);
        IF NOT BOMAditionalCost."Apply on all cost" THEN BEGIN
            BOMCost:=CalcAditionalUnitCosteLine(BOMAditionalCost, VarActual);
            ReturnCost:=BOMCost;
        END
        ELSE
        BEGIN
            BOMAditionalCostCheck.RESET;
            BOMAditionalCostCheck.SETRANGE("Item No", BOMAditionalCost."Item No");
            BOMAditionalCostCheck.SETRANGE("BOM Version", BOMAditionalCost."BOM Version");
            BOMAditionalCostCheck.SETFILTER("No. Cost", '<>%1', BOMAditionalCost."No. Cost");
            IF BOMAditionalCostCheck.FINDSET THEN BEGIN
                REPEAT BOMCost:=BOMCost + CalcAditionalUnitCosteLine(BOMAditionalCostCheck, VarActual);
                UNTIL BOMAditionalCostCheck.NEXT = 0;
            END;
            CASE BOMAditionalCost."Type Coste" OF BOMAditionalCost."Type Coste"::"%": BEGIN
                IF BOMAditionalCost."BOM Version" = 0 THEN BEGIN
                    Item.RESET;
                    IF Item.GET(BOMAditionalCost."Item No")THEN BEGIN
                        BOMCost:=BOMCost + CalcItemCosteCalculado(Item, VarActual);
                    END;
                END
                ELSE
                BEGIN
                    BOMVersionHeader.RESET;
                    IF BOMVersionHeader.GET(BOMAditionalCost."Item No", BOMAditionalCost."BOM Version")THEN BEGIN
                        BOMCost:=BOMCost + CalcBOMVersionItemCosteCalculado(BOMVersionHeader);
                    END;
                END;
                ReturnCost:=ROUND(((BOMAditionalCost.Value * BOMCost) / 100), 0.01);
            END;
            BOMAditionalCost."Type Coste"::Eur: BEGIN
                ReturnCost:=BOMCost + BOMAditionalCost.Value;
            END;
            END;
        //ReturnCost := CalcBeneficioActualizado(BOMAditionalCost);
        END;
        EXIT(ReturnCost);
    //++ #9766
    end;
    procedure CalcAditionalUnitCosteLine(BOMAditionalCost: Record 50029; VarActual: Boolean)ReturnCost: Decimal var
        BOMCost: Decimal;
        Item: Record 27;
        BOMVersionHeader: Record 50024;
    begin
        //-- #9766
        CLEAR(BOMCost);
        CLEAR(ReturnCost);
        CASE BOMAditionalCost."Type Coste" OF BOMAditionalCost."Type Coste"::"%": BEGIN
            IF BOMAditionalCost."BOM Version" = 0 THEN BEGIN
                Item.RESET;
                IF Item.GET(BOMAditionalCost."Item No")THEN BEGIN
                    BOMCost:=CalcItemCosteCalculado(Item, VarActual);
                END;
            END
            ELSE
            BEGIN
                BOMVersionHeader.RESET;
                IF BOMVersionHeader.GET(BOMAditionalCost."Item No", BOMAditionalCost."BOM Version")THEN BEGIN
                    BOMCost:=CalcBOMVersionItemUnitCosteCalculado(BOMVersionHeader);
                END;
            END;
            ReturnCost:=ROUND(((BOMAditionalCost.Value * BOMCost) / 100), 0.01);
        END;
        BOMAditionalCost."Type Coste"::Eur: BEGIN
            ReturnCost:=BOMAditionalCost.Value;
        END;
        END;
        EXIT(ReturnCost);
    //++ #9766
    end;
    procedure CalcAditionalFixedCoste(BOMAditionalCost: Record 50029)ReturnCost: Decimal var
        BOMCost: Decimal;
        Item: Record 27;
        BOMVersionHeader: Record 50024;
        BOMAditionalCostCheck: Record 50029;
        ParentItem: Record 27;
    begin
        //-- #9766
        ParentItem.GET(BOMAditionalCost."Item No");
        CLEAR(BOMCost);
        CLEAR(ReturnCost);
        IF NOT BOMAditionalCost."Apply on all cost" THEN BEGIN
            //BOMCost := CalcAditionalUnitCosteLine(BOMAditionalCost, VarActual);
            IF BOMAditionalCost."Type Coste" = BOMAditionalCost."Type Coste"::"%" THEN BEGIN
                BOMCost:=ParentItem.Receta_CosteLMFijado * BOMAditionalCost.Value / 100;
            END
            ELSE IF BOMAditionalCost."Type Coste" = BOMAditionalCost."Type Coste"::Eur THEN BEGIN
                    BOMCost:=BOMAditionalCost.Value;
                END;
            ReturnCost:=BOMCost;
        END
        ELSE
        BEGIN
            BOMAditionalCostCheck.RESET;
            BOMAditionalCostCheck.SETRANGE("Item No", BOMAditionalCost."Item No");
            BOMAditionalCostCheck.SETRANGE("BOM Version", BOMAditionalCost."BOM Version");
            BOMAditionalCostCheck.SETFILTER("No. Cost", '<>%1', BOMAditionalCost."No. Cost");
            IF BOMAditionalCostCheck.FINDSET THEN BEGIN
                REPEAT BOMCost:=BOMCost + CalcAditionalFixedCoste(BOMAditionalCostCheck);
                UNTIL BOMAditionalCostCheck.NEXT = 0;
            END;
            CASE BOMAditionalCost."Type Coste" OF BOMAditionalCost."Type Coste"::"%": BEGIN
                IF BOMAditionalCost."BOM Version" = 0 THEN BEGIN
                    Item.RESET;
                    IF Item.GET(BOMAditionalCost."Item No")THEN BEGIN
                        //BOMCost := BOMCost + CalcItemCosteCalculado(Item, VarActual);
                        BOMCost:=BOMCost + ParentItem.Receta_CosteLMFijado;
                    END;
                END
                ELSE
                BEGIN
                    BOMVersionHeader.RESET;
                    IF BOMVersionHeader.GET(BOMAditionalCost."Item No", BOMAditionalCost."BOM Version")THEN BEGIN
                        BOMCost:=BOMCost + CalcBOMVersionItemCosteCalculado(BOMVersionHeader);
                    END;
                END;
                ReturnCost:=ROUND(((BOMAditionalCost.Value * BOMCost) / 100), 0.01);
            END;
            BOMAditionalCost."Type Coste"::Eur: BEGIN
                ReturnCost:=BOMCost + BOMAditionalCost.Value;
            END;
            END;
        //ReturnCost := CalcBeneficioActualizado(BOMAditionalCost);
        END;
        EXIT(ReturnCost);
    //++ #9766
    end;
    procedure CalcAditionalItemUnitTotalCoste(ItemNo: Code[20]; BOMVersion: Integer)ReturnCost: Decimal var
        BOMAditionalCostCheck: Record 50029;
    begin
        //-- #9766
        CLEAR(ReturnCost);
        BOMAditionalCostCheck.RESET;
        BOMAditionalCostCheck.SETRANGE("Item No", ItemNo);
        BOMAditionalCostCheck.SETRANGE("BOM Version", BOMVersion);
        IF BOMAditionalCostCheck.FINDSET THEN BEGIN
            REPEAT ReturnCost:=ReturnCost + CalcAditionalItemUnitCoste(BOMAditionalCostCheck);
            UNTIL BOMAditionalCostCheck.NEXT = 0;
        END;
        EXIT(ReturnCost);
    //++ #9766
    end;
    procedure CalcAditionalItemUnitCoste(BOMAditionalCost: Record 50029)ReturnCost: Decimal var
        BOMCost: Decimal;
        Item: Record 27;
        BOMVersionHeader: Record 50024;
        BOMAditionalCostCheck: Record 50029;
    begin
        //-- #9766
        CLEAR(BOMCost);
        CLEAR(ReturnCost);
        IF NOT BOMAditionalCost."Apply on all cost" THEN BEGIN
            BOMCost:=CalcAditionalItemUnitCosteLine(BOMAditionalCost);
            ReturnCost:=BOMCost;
        END
        ELSE
        BEGIN
            BOMAditionalCostCheck.RESET;
            BOMAditionalCostCheck.SETRANGE("Item No", BOMAditionalCost."Item No");
            BOMAditionalCostCheck.SETRANGE("BOM Version", BOMAditionalCost."BOM Version");
            BOMAditionalCostCheck.SETFILTER("No. Cost", '<>%1', BOMAditionalCost."No. Cost");
            IF BOMAditionalCostCheck.FINDSET THEN BEGIN
                REPEAT BOMCost:=BOMCost + CalcAditionalItemUnitCosteLine(BOMAditionalCostCheck);
                UNTIL BOMAditionalCostCheck.NEXT = 0;
            END;
            CASE BOMAditionalCost."Type Coste" OF BOMAditionalCost."Type Coste"::"%": BEGIN
                IF BOMAditionalCost."BOM Version" = 0 THEN BEGIN
                    Item.RESET;
                    IF Item.GET(BOMAditionalCost."Item No")THEN BEGIN
                        BOMCost:=BOMCost + CalcItemUnitCosteCalculado(Item);
                    END;
                END
                ELSE
                BEGIN
                    BOMVersionHeader.RESET;
                    IF BOMVersionHeader.GET(BOMAditionalCost."Item No", BOMAditionalCost."BOM Version")THEN BEGIN
                        BOMCost:=BOMCost + CalcBOMVersionItemUnitCosteCalculado(BOMVersionHeader);
                    END;
                END;
                ReturnCost:=ROUND(((BOMAditionalCost.Value * BOMCost) / 100), 0.01);
            END;
            BOMAditionalCost."Type Coste"::Eur: BEGIN
                ReturnCost:=BOMCost + BOMAditionalCost.Value;
            END;
            END;
        //ReturnCost := CalcBeneficioItemUnitCostActualizado(BOMAditionalCost);
        END;
        EXIT(ReturnCost);
    //++ #9766
    end;
    procedure CalcAditionalItemUnitCosteLine(BOMAditionalCost: Record 50029)ReturnCost: Decimal var
        BOMCost: Decimal;
        Item: Record 27;
        BOMVersionHeader: Record 50024;
    begin
        //-- #9766
        CLEAR(BOMCost);
        CLEAR(ReturnCost);
        CASE BOMAditionalCost."Type Coste" OF BOMAditionalCost."Type Coste"::"%": BEGIN
            IF BOMAditionalCost."BOM Version" = 0 THEN BEGIN
                Item.RESET;
                IF Item.GET(BOMAditionalCost."Item No")THEN BEGIN
                    BOMCost:=CalcItemUnitCosteCalculado(Item);
                END;
            END
            ELSE
            BEGIN
                BOMVersionHeader.RESET;
                IF BOMVersionHeader.GET(BOMAditionalCost."Item No", BOMAditionalCost."BOM Version")THEN BEGIN
                    BOMCost:=CalcBOMVersionItemUnitCosteCalculado(BOMVersionHeader);
                END;
            END;
            ReturnCost:=ROUND(((BOMAditionalCost.Value * BOMCost) / 100), 0.01);
        END;
        BOMAditionalCost."Type Coste"::Eur: BEGIN
            ReturnCost:=BOMAditionalCost.Value;
        END;
        END;
        EXIT(ReturnCost);
    //++ #9766
    end;
    procedure CalcItemStadisticsCost(var Rcd_Item: Record 27; CostType: Option StdCost, UnitCost; VarActual: Boolean): Decimal var
        VarAditionalCost: Decimal;
        VarCalcCost: Decimal;
        VarStadisticsCost: Decimal;
    begin
        //-- #9862
        CLEAR(VarAditionalCost);
        CLEAR(VarCalcCost);
        CLEAR(VarStadisticsCost);
        CASE CostType OF CostType::StdCost: BEGIN
            //VarAditionalCost := CalcAditionalUnitTotalCoste(Rcd_Item."No.",0,VarActual);
            VarAditionalCost:=CalcAditionalUnitTotalCosteReceta(Rcd_Item."No.", 0, VarActual);
            VarCalcCost:=CalcItemCosteCalculado(Rcd_Item, VarActual);
        END;
        CostType::UnitCost: BEGIN
            VarAditionalCost:=CalcAditionalItemUnitTotalCoste(Rcd_Item."No.", 0);
            VarCalcCost:=CalcItemUnitCosteCalculado(Rcd_Item);
        END;
        END;
        IF Rcd_Item."Statistics Lot" <> 0 THEN BEGIN
            VarStadisticsCost:=ROUND((((VarAditionalCost + VarCalcCost) * Rcd_Item."Lote Receta") / (Rcd_Item."Statistics Lot")), 0.01);
        //VarStadisticsCost := ROUND((((VarAditionalCost + VarCalcCost))/(Rcd_Item."Statistics Lot")), 0.01);
        END;
        EXIT(VarStadisticsCost);
    //++ #9862
    end;
    procedure CalcBOMVersionItemStadisticsCoste(var ParBOMVersionHeader: Record 50024; CostType: Option StdCost, UnitCost; VarActual: Boolean): Decimal var
        VarAditionalCost: Decimal;
        VarCalcCost: Decimal;
        VarStadisticsCost: Decimal;
    begin
        //-- #9862
        CLEAR(VarAditionalCost);
        CLEAR(VarCalcCost);
        CLEAR(VarStadisticsCost);
        CASE CostType OF CostType::StdCost: BEGIN
            VarAditionalCost:=CalcAditionalUnitTotalCoste(ParBOMVersionHeader."Item No.", ParBOMVersionHeader."BOM Version", VarActual);
            VarCalcCost:=CalcBOMVersionItemCosteCalculado(ParBOMVersionHeader);
        END;
        CostType::UnitCost: BEGIN
            VarAditionalCost:=CalcAditionalItemUnitTotalCoste(ParBOMVersionHeader."Item No.", ParBOMVersionHeader."BOM Version");
            VarCalcCost:=CalcBOMVersionItemUnitCosteCalculado(ParBOMVersionHeader);
        END;
        END;
        IF ParBOMVersionHeader."Statistics Lot" <> 0 THEN BEGIN
            VarStadisticsCost:=ROUND((((VarAditionalCost + VarCalcCost) * ParBOMVersionHeader."Lote Receta") / (ParBOMVersionHeader."Statistics Lot")), 0.01);
        END;
        EXIT(VarStadisticsCost);
    //++ #9862
    end;
    procedure CalcBeneficioSobrePrecio(var Item: Record 27; precioFijado: Boolean; precioReceta: Boolean; precioProducto: Boolean; precioMedioLM: Boolean; PrecioEstandarLM: Boolean)ReturBeneficio: Decimal var
        precioExWorkSTD: Decimal;
        costeTotalComponentesSTDActual: Decimal;
        costeTotalGeneralSinBeneficio: Decimal;
        BOMAditionalCostAux: Record 50029;
        BOMAditionalCost: Record 50029;
    begin
        CLEAR(ReturBeneficio);
        BOMAditionalCost.RESET;
        BOMAditionalCost.SETRANGE(BOMAditionalCost."Item No", Item."No.");
        BOMAditionalCost.SETRANGE(BOMAditionalCost."BOM Version", 0);
        BOMAditionalCost.SETRANGE(BOMAditionalCost."Apply on all cost", TRUE);
        IF NOT BOMAditionalCost.FINDFIRST THEN EXIT(0);
        IF BOMAditionalCost."Apply on all cost" THEN BEGIN
            /*
             ReturBeneficio := (CalcAditionalUnitTotalCoste(BOMAditionalCost."Item No",0,FALSE) + CalcItemCosteCalculado(Item))
                               - CalcItemUnitCosteCalculado(Item)
                               - CalcAditionalCostWithApply(BOMAditionalCost."Item No", BOMAditionalCost."BOM Version");
            */
            //++ TODO
            /*
            ReturBeneficio := (CalcAditionalUnitTotalCoste(BOMAditionalCost."Item No",0,FALSE) + CalcItemCosteCalculado(Item, FALSE))
                              - CalcAditionalUnitTotalCoste(BOMAditionalCost."Item No", 0, TRUE)
                              - CalcAditionalCostWithApply(BOMAditionalCost."Item No", BOMAditionalCost."BOM Version");
            */
            //precioExWorkSTD := CalcAditionalUnitTotalCoste(BOMAditionalCost."Item No",0,FALSE) + CalcItemCosteCalculado(Item, FALSE);
            precioExWorkSTD:=CalcAditionalFixedTotalCoste(Item."No.", 0) + Item.Receta_CosteLMFijado;
            IF precioFijado THEN BEGIN
                // Comentado, sacado el beneficio directamente :):)
                /*
                costeTotalComponentesSTDActual := Item.Receta_CosteLMFijado;
                // Obtenemos coste de LM
                costeTotalGeneralSinBeneficio := CalcAditionalFixedTotalCoste(Item."No.",0);
                // Le restamos el beneficio
                costeTotalGeneralSinBeneficio := costeTotalGeneralSinBeneficio - CalcAditionalFixedCoste(BOMAditionalCostAux);
                */
                EXIT(CalcAditionalFixedCoste(BOMAditionalCost));
            END
            ELSE IF precioReceta THEN BEGIN
                    costeTotalComponentesSTDActual:=CalcItemCosteCalculado(Item, FALSE);
                    costeTotalGeneralSinBeneficio:=CalcAditionalCostWithoutApply(Item."No.", 0, FALSE);
                END
                ELSE IF precioProducto THEN BEGIN
                        costeTotalComponentesSTDActual:=CalcItemCosteCalculado(Item, TRUE);
                        costeTotalGeneralSinBeneficio:=CalcAditionalCostWithoutApply(Item."No.", 0, TRUE);
                    END
                    ELSE IF precioMedioLM THEN BEGIN
                            // este cálculo se usa en los factbox, y el precio a comparar es sobre coste medio
                            precioExWorkSTD:=CalcAditionalItemUnitTotalCoste(Item."No.", 0) + CalcItemUnitCosteCalculado(Item);
                            costeTotalComponentesSTDActual:=CalcItemUnitCosteCalculado(Item);
                            costeTotalGeneralSinBeneficio:=CalcAditionalItemUnitCostWithoutApply(Item."No.", 0);
                        /*IF BOMAditionalCost."Type Coste" = BOMAditionalCost."Type Coste"::"%" THEN
                              ReturBeneficio := BOMAditionalCost.Value * costeTotalComponentesSTDActual / 100
                            ELSE
                              ReturBeneficio := BOMAditionalCost.Value;

                            EXIT(ReturBeneficio);*/
                        END
                        ELSE IF PrecioEstandarLM THEN BEGIN
                                // este cálculo se usa en los factbox, y el precio a comparar es sobre coste estandar
                                precioExWorkSTD:=CalcAditionalUnitTotalCosteReceta(Item."No.", 0, FALSE) + CalcItemCosteCalculado(Item, FALSE);
                                costeTotalComponentesSTDActual:=CalcItemCosteCalculado(Item, FALSE);
                                costeTotalGeneralSinBeneficio:=CalcAditionalCostWithoutApply(Item."No.", 0, FALSE);
                            /*IF BOMAditionalCost."Type Coste" = BOMAditionalCost."Type Coste"::"%" THEN
                                  ReturBeneficio := BOMAditionalCost.Value * costeTotalComponentesSTDActual / 100
                                ELSE
                                  ReturBeneficio := BOMAditionalCost.Value;

                                EXIT(ReturBeneficio);*/
                            END;
            ReturBeneficio:=precioExWorkSTD - costeTotalComponentesSTDActual - costeTotalGeneralSinBeneficio;
        END
        ELSE
        BEGIN
            ReturBeneficio:=0;
        END;
        EXIT(ReturBeneficio);
    end;
    procedure CalcPerBeneficioSobrePrecio(var Item: Record 27; precioFijado: Boolean; precioReceta: Boolean; precioProducto: Boolean; precioMedioLM: Boolean; precioEstandarLM: Boolean)ReturPerBeneficio: Decimal var
        VarExWork: Decimal;
        VarBeneficio: Decimal;
        costeTotalComponentesSTDActual: Decimal;
        costeTotalGeneralSinBeneficio: Decimal;
        BOMAditionalCost: Record 50029;
    begin
        CLEAR(ReturPerBeneficio);
        CLEAR(VarBeneficio);
        CLEAR(VarExWork);
        BOMAditionalCost.RESET;
        BOMAditionalCost.SETRANGE(BOMAditionalCost."Item No", Item."No.");
        BOMAditionalCost.SETRANGE(BOMAditionalCost."BOM Version", 0);
        BOMAditionalCost.SETRANGE(BOMAditionalCost."Apply on all cost", TRUE);
        IF NOT BOMAditionalCost.FINDFIRST THEN EXIT(0);
        IF BOMAditionalCost."Apply on all cost" THEN BEGIN
            // Beneficio
            VarBeneficio:=CalcBeneficioSobrePrecio(Item, precioFijado, precioReceta, precioProducto, precioMedioLM, precioEstandarLM);
            // (Coste producto + costes generales sin beneficio)
            //VarExWork := (CalcAditionalUnitTotalCoste(BOMAditionalCost."Item No",0,FALSE) + CalcItemCosteCalculado(Item, FALSE))
            costeTotalComponentesSTDActual:=CalcItemCosteCalculado(Item, TRUE);
            costeTotalGeneralSinBeneficio:=CalcAditionalCostWithoutApply(Item."No.", 0, TRUE);
            IF precioFijado THEN BEGIN
                // Comentado, sacado el beneficio directamente :):)
                costeTotalComponentesSTDActual:=Item.Receta_CosteLMFijado;
                // Obtenemos costes generales de LM
                costeTotalGeneralSinBeneficio:=CalcAditionalFixedTotalCoste(Item."No.", 0);
                // Le restamos el beneficio
                costeTotalGeneralSinBeneficio:=costeTotalGeneralSinBeneficio - VarBeneficio;
            END
            ELSE IF precioReceta THEN BEGIN
                    costeTotalComponentesSTDActual:=CalcItemCosteCalculado(Item, FALSE);
                    costeTotalGeneralSinBeneficio:=CalcAditionalCostWithoutApply(Item."No.", 0, FALSE);
                END
                ELSE IF precioProducto THEN BEGIN
                        costeTotalComponentesSTDActual:=CalcItemCosteCalculado(Item, TRUE);
                        costeTotalGeneralSinBeneficio:=CalcAditionalCostWithoutApply(Item."No.", 0, TRUE);
                    END
                    ELSE IF precioMedioLM THEN BEGIN
                            costeTotalComponentesSTDActual:=CalcItemUnitCosteCalculado(Item);
                            costeTotalGeneralSinBeneficio:=CalcAditionalItemUnitTotalCoste(Item."No.", 0) - VarBeneficio;
                        END
                        ELSE IF precioEstandarLM THEN BEGIN
                                costeTotalComponentesSTDActual:=CalcItemCosteCalculado(Item, FALSE);
                                costeTotalGeneralSinBeneficio:=CalcAditionalFixedTotalCoste(Item."No.", 0) - VarBeneficio;
                            END;
            IF VarBeneficio <> 0 THEN ReturPerBeneficio:=ROUND((VarBeneficio / (costeTotalComponentesSTDActual + costeTotalGeneralSinBeneficio) * 100), 0.01);
        END
        ELSE
        BEGIN
            ReturPerBeneficio:=0;
        END;
        EXIT(ReturPerBeneficio);
    end;
    procedure CalcBeneficioActualizado(BOMAditionalCost: Record 50029)ReturBeneficio: Decimal var
        Item: Record 27;
        precioExWorkSTD: Decimal;
        costeTotalComponentesSTDActual: Decimal;
        costeTotalGeneralSinBeneficio: Decimal;
    begin
        CLEAR(ReturBeneficio);
        IF BOMAditionalCost."Apply on all cost" THEN BEGIN
            Item.GET(BOMAditionalCost."Item No");
            /*
             ReturBeneficio := (CalcAditionalUnitTotalCoste(BOMAditionalCost."Item No",0,FALSE) + CalcItemCosteCalculado(Item))
                               - CalcItemUnitCosteCalculado(Item)
                               - CalcAditionalCostWithApply(BOMAditionalCost."Item No", BOMAditionalCost."BOM Version");
            */
            //++ TODO
            /*
            ReturBeneficio := (CalcAditionalUnitTotalCoste(BOMAditionalCost."Item No",0,FALSE) + CalcItemCosteCalculado(Item, FALSE))
                              - CalcAditionalUnitTotalCoste(BOMAditionalCost."Item No", 0, TRUE)
                              - CalcAditionalCostWithApply(BOMAditionalCost."Item No", BOMAditionalCost."BOM Version");
            */
            //precioExWorkSTD := CalcAditionalUnitTotalCoste(BOMAditionalCost."Item No",0,FALSE) + CalcItemCosteCalculado(Item, FALSE);
            precioExWorkSTD:=CalcAditionalFixedTotalCoste(Item."No.", 0) + Item.Receta_CosteLMFijado;
            costeTotalComponentesSTDActual:=CalcItemCosteCalculado(Item, TRUE);
            costeTotalGeneralSinBeneficio:=CalcAditionalCostWithoutApply(Item."No.", 0, TRUE);
            ReturBeneficio:=precioExWorkSTD - costeTotalComponentesSTDActual - costeTotalGeneralSinBeneficio;
        END
        ELSE
        BEGIN
            ReturBeneficio:=0;
        END;
        EXIT(ReturBeneficio);
    end;
    procedure CalcBeneficioItemUnitCostActualizado(BOMAditionalCost: Record 50029)ReturBeneficio: Decimal var
        Item: Record 27;
        precioExWorkSTD: Decimal;
        costeTotalComponentesItemActual: Decimal;
        costeTotalGeneralSinBeneficio: Decimal;
    begin
        CLEAR(ReturBeneficio);
        IF BOMAditionalCost."Apply on all cost" THEN BEGIN
            Item.GET(BOMAditionalCost."Item No");
            /*
             ReturBeneficio := (CalcAditionalUnitTotalCoste(BOMAditionalCost."Item No",0,FALSE) + CalcItemCosteCalculado(Item))
                               - CalcItemUnitCosteCalculado(Item)
                               - CalcAditionalCostWithApply(BOMAditionalCost."Item No", BOMAditionalCost."BOM Version");
            */
            precioExWorkSTD:=CalcAditionalItemUnitTotalCoste(Item."No.", 0) + CalcItemUnitCosteCalculado(Item);
            costeTotalComponentesItemActual:=CalcItemUnitCosteCalculado(Item);
            costeTotalGeneralSinBeneficio:=CalcAditionalItemUnitCostWithoutApply(Item."No.", 0);
            ReturBeneficio:=precioExWorkSTD - costeTotalComponentesItemActual - costeTotalGeneralSinBeneficio;
        END
        ELSE
        BEGIN
            ReturBeneficio:=0;
        END;
        EXIT(ReturBeneficio);
    end;
    procedure CalcPerBeneficioActualizado(BOMAditionalCost: Record 50029)ReturPerBeneficio: Decimal var
        Item: Record 27;
        VarExWork: Decimal;
        VarBeneficio: Decimal;
        costeTotalComponentesSTDActual: Decimal;
        costeTotalGeneralSinBeneficio: Decimal;
    begin
        CLEAR(ReturPerBeneficio);
        CLEAR(VarBeneficio);
        CLEAR(VarExWork);
        IF BOMAditionalCost."Apply on all cost" THEN BEGIN
            Item.GET(BOMAditionalCost."Item No");
            // Beneficio
            VarBeneficio:=CalcBeneficioActualizado(BOMAditionalCost);
            // (Coste producto + costes generales sin beneficio)
            //VarExWork := (CalcAditionalUnitTotalCoste(BOMAditionalCost."Item No",0,FALSE) + CalcItemCosteCalculado(Item, FALSE))
            costeTotalComponentesSTDActual:=CalcItemCosteCalculado(Item, TRUE);
            costeTotalGeneralSinBeneficio:=CalcAditionalCostWithoutApply(Item."No.", 0, TRUE);
            IF VarBeneficio <> 0 THEN ReturPerBeneficio:=ROUND((VarBeneficio / (costeTotalComponentesSTDActual + costeTotalGeneralSinBeneficio) * 100), 0.01);
        END
        ELSE
        BEGIN
            ReturPerBeneficio:=0;
        END;
        EXIT(ReturPerBeneficio);
    end;
    procedure CalcAditionalCostWithoutApply(VarItemNo: Code[20]; VarBOMVersion: Integer; VarActual: Boolean)ReturnAddCost: Decimal var
        BOMAditionalCost: Record 50029;
    begin
        CLEAR(ReturnAddCost);
        BOMAditionalCost.RESET;
        BOMAditionalCost.SETRANGE("Item No", VarItemNo);
        BOMAditionalCost.SETRANGE("BOM Version", VarBOMVersion);
        BOMAditionalCost.SETRANGE("Apply on all cost", FALSE);
        IF BOMAditionalCost.FINDSET THEN BEGIN
            REPEAT //ReturnAddCost := ReturnAddCost + CalcAditionalItemUnitCoste(BOMAditionalCost);
                ReturnAddCost:=ReturnAddCost + CalcAditionalUnitCoste(BOMAditionalCost, VarActual);
            UNTIL BOMAditionalCost.NEXT = 0;
        END;
        EXIT(ReturnAddCost);
    end;
    local procedure CalcAditionalItemUnitCostWithoutApply(VarItemNo: Code[20]; VarBOMVersion: Integer)ReturnAddCost: Decimal var
        BOMAditionalCost: Record 50029;
    begin
        CLEAR(ReturnAddCost);
        BOMAditionalCost.RESET;
        BOMAditionalCost.SETRANGE("Item No", VarItemNo);
        BOMAditionalCost.SETRANGE("BOM Version", VarBOMVersion);
        BOMAditionalCost.SETRANGE("Apply on all cost", FALSE);
        IF BOMAditionalCost.FINDSET THEN BEGIN
            REPEAT ReturnAddCost:=ReturnAddCost + CalcAditionalItemUnitCoste(BOMAditionalCost);
            //ReturnAddCost := ReturnAddCost + CalcAditionalUnitCoste(BOMAditionalCost, TRUE);
            UNTIL BOMAditionalCost.NEXT = 0;
        END;
        EXIT(ReturnAddCost);
    end;
    procedure CalcPesoBrutoNetoReceta(Item: Record 27; Bruto: Boolean; Neto: Boolean): Decimal var
        BOMComponent: Record 90;
    begin
        BOMComponent.RESET;
        BOMComponent.SETCURRENTKEY("Parent Item No.", Type, TipoRecurso, Position);
        BOMComponent.SETRANGE(BOMComponent."Parent Item No.", Item."No.");
        BOMComponent.SETRANGE(BOMComponent.Type, BOMComponent.Type::Item);
        BOMComponent.SETFILTER(BOMComponent."No.", 'MP*');
        BOMComponent.CALCSUMS(BOMComponent."Cantidad por Lote", BOMComponent."Net Amount");
        IF Bruto THEN EXIT(BOMComponent."Cantidad por Lote")
        ELSE IF Neto THEN EXIT(BOMComponent."Net Amount");
        EXIT(0);
    end;
    procedure CalcPerMermaReceta(Item: Record 27): Decimal var
        loteReceta: Decimal;
    begin
        IF Item."Base Unit of Measure" = 'KG' THEN loteReceta:=Item."Lote Receta"
        ELSE IF Item."Statistics Unit of Measurement" = 'KG' THEN loteReceta:=Item."Statistics Lot";
        IF loteReceta = 0 THEN EXIT(0);
        EXIT((1 - CalcPesoBrutoNetoReceta(Item, TRUE, FALSE) / loteReceta) * 100);
    end;
}
