codeunit 50000 AlxiaFuncionesImportadas
{
    PROCEDURE CalcItemCosteCalculado(VAR Rcd_Item: Record 27; VarActual: Boolean): Decimal;
    VAR
        BOMComp: Record "BOM Component";
        costeEstandarArticulos: Decimal;
        ItemAux: Record Item;
        Resource: Record Resource;
    BEGIN
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
    END;
    procedure CalcItemCostCalcResType(var Rcd_Item: Record Item; ResourceType: Integer): Decimal var
        BOMComp: Record "BOM Component";
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
    procedure CalcItemPerCostCalcResType(var Rcd_Item: Record Item; ResourceType: Integer)ReturPerCost: Decimal var
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
    procedure CalcItemCostCalcItem(var Rcd_Item: Record Item): Decimal var
        BOMComp: Record "BOM Component";
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
    procedure CalcItemCostCalcPosition(var Rcd_Item: Record Item; Pos: Code[10]): Decimal var
        BOMComp: Record "BOM Component";
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
    procedure CalcItemCostCalcProdType(var Rcd_Item: Record Item; VarProdType: Text[20]): Decimal var
        BOMComp: Record "BOM Component";
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
    procedure CalcItemPerCostCalcProdType(var Rcd_Item: Record Item; VarProdType: Text[20])ReturPerCost: Decimal var
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
    procedure CalcItemUnitCosteCalculado(var Rcd_Item: Record Item)ReturnCost: Decimal var
        BOMComp: Record "BOM Component";
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
    procedure CalcItemUnitCostCalcItem(var Rcd_Item: Record Item)ReturnCost: Decimal var
        BOMComp: Record "BOM Component";
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
    procedure CalcItemUnitCostCalcPosition(var Rcd_Item: Record Item; Pos: Code[10])ReturnCost: Decimal var
        BOMComp: Record "BOM Component";
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
    procedure CalcItemUnitCostCalcProdType(var Rcd_Item: Record Item; VarProdType: Text[20])ReturnCost: Decimal var
        BOMComp: Record "BOM Component";
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
    procedure CalcItemPerUnitCostCalcProdType(var Rcd_Item: Record Item; VarProdType: Text[20])ReturPerCost: Decimal var
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
    procedure CalcBOMVersionItemCosteCalculado(var ParBOMVersionHeader: Record "BOM Version Header"): Decimal var
        BOMVersionLines: Record "BOM Version Lines";
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
    procedure CalcBOMVersionItemCostCalcResType(var ParBOMVersionHeader: Record "BOM Version Header"; ResourceType: Integer): Decimal var
        BOMVersionLines: Record "BOM Version Lines";
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
    procedure CalcBOMVersionItemPerCostCalcResType(var ParBOMVersionHeader: Record "BOM Version Header"; ResourceType: Integer)ReturPerCost: Decimal var
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
    procedure CalcBOMVersionItemCostCalcItem(var ParBOMVersionHeader: Record "BOM Version Header"): Decimal var
        BOMVersionLines: Record "BOM Version Lines";
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
    procedure CalcBOMVersionItemCostCalcPosition(var ParBOMVersionHeader: Record "BOM Version Header"; Pos: Code[10]): Decimal var
        BOMVersionLines: Record "BOM Version Lines";
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
    procedure CalcBOMVersionItemCostCalcType(var ParBOMVersionHeader: Record "BOM Version Header"; VarProdType: Text[20]): Decimal var
        BOMVersionLines: Record "BOM Version Lines";
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
    procedure CalcBOMVersionItemPerCostCalcType(var ParBOMVersionHeader: Record "BOM Version Header"; VarProdType: Text[20])ReturPerCost: Decimal var
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
    procedure CalcBOMVersionItemUnitCosteCalculado(var ParBOMVersionHeader: Record "BOM Version Header")ReturnCost: Decimal var
        BOMVersionLines: Record "BOM Version Lines";
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
    procedure CalcBOMVersionItemUnitCostCalcItem(var ParBOMVersionHeader: Record "BOM Version Header")ReturnCost: Decimal var
        BOMVersionLines: Record "BOM Version Lines";
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
    procedure CalcBOMVersionItemUnitCostCalcPosition(var ParBOMVersionHeader: Record "BOM Version Header"; Pos: Code[10])ReturnCost: Decimal var
        BOMVersionLines: Record "BOM Version Lines";
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
    procedure CalcBOMVersionItemUnitCostCalcType(var ParBOMVersionHeader: Record "BOM Version Header"; VarProdType: Text[20])ReturnCost: Decimal var
        BOMVersionLines: Record "BOM Version Lines";
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
    procedure CalcBOMVersionItemPerUnitCostCalcType(var ParBOMVersionHeader: Record "BOM Version Header"; VarProdType: Text[20])ReturPerCost: Decimal var
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
        BOMAditionalCostCheck: Record "BOM Aditional Cost";
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
        BOMAditionalCostCheck: Record "BOM Aditional Cost";
        CosteReceta: Decimal;
        Item: Record Item;
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
        BOMAditionalCostCheck: Record "BOM Aditional Cost";
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
    procedure CalcAditionalUnitCoste(BOMAditionalCost: Record "BOM Aditional Cost"; VarActual: Boolean)ReturnCost: Decimal var
        BOMCost: Decimal;
        Item: Record Item;
        BOMVersionHeader: Record "BOM Version Header";
        BOMAditionalCostCheck: Record "BOM Aditional Cost";
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
    procedure CalcAditionalUnitCosteLine(BOMAditionalCost: Record "BOM Aditional Cost"; VarActual: Boolean)ReturnCost: Decimal var
        BOMCost: Decimal;
        Item: Record Item;
        BOMVersionHeader: Record "BOM Version Header";
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
    procedure CalcAditionalFixedCoste(BOMAditionalCost: Record "BOM Aditional Cost")ReturnCost: Decimal var
        BOMCost: Decimal;
        Item: Record Item;
        BOMVersionHeader: Record "BOM Version Header";
        BOMAditionalCostCheck: Record "BOM Aditional Cost";
        ParentItem: Record Item;
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
        BOMAditionalCostCheck: Record "BOM Aditional Cost";
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
    procedure CalcAditionalItemUnitCoste(BOMAditionalCost: Record "BOM Aditional Cost")ReturnCost: Decimal var
        BOMCost: Decimal;
        Item: Record Item;
        BOMVersionHeader: Record "BOM Version Header";
        BOMAditionalCostCheck: Record "BOM Aditional Cost";
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
    procedure CalcAditionalItemUnitCosteLine(BOMAditionalCost: Record "BOM Aditional Cost")ReturnCost: Decimal var
        BOMCost: Decimal;
        Item: Record Item;
        BOMVersionHeader: Record "BOM Version Header";
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
    procedure CalcItemStadisticsCost(var Rcd_Item: Record Item; CostType: Option StdCost, UnitCost; VarActual: Boolean): Decimal var
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
    procedure CalcBOMVersionItemStadisticsCoste(var ParBOMVersionHeader: Record "BOM Version Header"; CostType: Option StdCost, UnitCost; VarActual: Boolean): Decimal var
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
    procedure CalcBeneficioSobrePrecio(var Item: Record Item; precioFijado: Boolean; precioReceta: Boolean; precioProducto: Boolean; precioMedioLM: Boolean; PrecioEstandarLM: Boolean)ReturBeneficio: Decimal var
        precioExWorkSTD: Decimal;
        costeTotalComponentesSTDActual: Decimal;
        costeTotalGeneralSinBeneficio: Decimal;
        BOMAditionalCostAux: Record "BOM Aditional Cost";
        BOMAditionalCost: Record "BOM Aditional Cost";
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
    procedure CalcPerBeneficioSobrePrecio(var Item: Record Item; precioFijado: Boolean; precioReceta: Boolean; precioProducto: Boolean; precioMedioLM: Boolean; precioEstandarLM: Boolean)ReturPerBeneficio: Decimal var
        VarExWork: Decimal;
        VarBeneficio: Decimal;
        costeTotalComponentesSTDActual: Decimal;
        costeTotalGeneralSinBeneficio: Decimal;
        BOMAditionalCost: Record "BOM Aditional Cost";
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
    procedure CalcBeneficioActualizado(BOMAditionalCost: Record "BOM Aditional Cost")ReturBeneficio: Decimal var
        Item: Record Item;
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
    procedure CalcBeneficioItemUnitCostActualizado(BOMAditionalCost: Record "BOM Aditional Cost")ReturBeneficio: Decimal var
        Item: Record Item;
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
    procedure CalcPerBeneficioActualizado(BOMAditionalCost: Record "BOM Aditional Cost")ReturPerBeneficio: Decimal var
        Item: Record Item;
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
        BOMAditionalCost: Record "BOM Aditional Cost";
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
        BOMAditionalCost: Record "BOM Aditional Cost";
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
    procedure CalcPesoBrutoNetoReceta(Item: Record Item; Bruto: Boolean; Neto: Boolean): Decimal var
        BOMComponent: Record "BOM Component";
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
    procedure CalcPerMermaReceta(Item: Record Item): Decimal var
        loteReceta: Decimal;
    begin
        IF Item."Base Unit of Measure" = 'KG' THEN loteReceta:=Item."Lote Receta"
        ELSE IF Item."Statistics Unit of Measurement" = 'KG' THEN loteReceta:=Item."Statistics Lot";
        IF loteReceta = 0 THEN EXIT(0);
        EXIT((1 - CalcPesoBrutoNetoReceta(Item, TRUE, FALSE) / loteReceta) * 100);
    end;
    //BEGIN Funciones migradas CDU 905 "Assembly Line Management"
    var WarningModeOff: Boolean;
    procedure AddBOMLineEventos(AsmHeader: Record 900; var AssemblyLine: Record 901; BomComponent: Record 50014)
    begin
        InsertAsmLine(AsmHeader, AssemblyLine, FALSE);
        AddBOMLine2Eventos(AsmHeader, AssemblyLine, FALSE, BomComponent, GetWarningMode);
    end;
    local procedure AddBOMLine2Eventos(AsmHeader: Record 900; var AssemblyLine: Record 901; AsmLineRecordIsTemporary: Boolean; BomComponent: Record 50014; ShowDueDateBeforeWorkDateMessage: Boolean)
    var
        DueDateBeforeWorkDateMsgShown: Boolean;
        SkipVerificationsThatChangeDatabase: Boolean;
        Item: Record 27;
    begin
        SkipVerificationsThatChangeDatabase:=AsmLineRecordIsTemporary;
        AssemblyLine.SetSkipVerificationsThatChangeDatabase(SkipVerificationsThatChangeDatabase);
        AssemblyLine.VALIDATE(Type, BomComponent.Type);
        // Inicio ADV001
        AssemblyLine.gfu_SetCantidadCabecera(AsmHeader.Quantity, AsmHeader."Quantity (Base)", AsmHeader."Remaining Quantity", AsmHeader."Remaining Quantity (Base)", AsmHeader."Quantity to Assemble", AsmHeader."Quantity to Assemble (Base)", TRUE);
        // Fin ADV001
        AssemblyLine.VALIDATE("No.", BomComponent."No.");
        AssemblyLine.Position:=BomComponent.Position;
        AssemblyLine."Position 2":=BomComponent."Position 2";
        AssemblyLine."Position 3":=BomComponent."Position 3";
        IF AssemblyLine.Type = AssemblyLine.Type::Resource THEN CASE BomComponent."Resource Usage Type" OF BomComponent."Resource Usage Type"::Direct: AssemblyLine.VALIDATE("Resource Usage Type", AssemblyLine."Resource Usage Type"::Direct);
            BomComponent."Resource Usage Type"::Fixed: AssemblyLine.VALIDATE("Resource Usage Type", AssemblyLine."Resource Usage Type"::Fixed);
            END;
        AssemblyLine.VALIDATE("Unit of Measure Code", BomComponent."Unit of Measure Code");
        IF AssemblyLine.Type <> AssemblyLine.Type::" " THEN AssemblyLine.VALIDATE("Quantity per", AssemblyLine.CalcQuantityFromBOM(BomComponent.Type, BomComponent."Quantity per", 1, AsmHeader."Qty. per Unit of Measure", AssemblyLine."Resource Usage Type"));
        AssemblyLine.VALIDATE(Quantity, AssemblyLine.CalcQuantityFromBOM(BomComponent.Type, BomComponent."Quantity per", AsmHeader.Quantity, AsmHeader."Qty. per Unit of Measure", AssemblyLine."Resource Usage Type"));
        AssemblyLine.VALIDATE("Quantity to Consume", AssemblyLine.CalcQuantityFromBOM(BomComponent.Type, BomComponent."Quantity per", AsmHeader."Quantity to Assemble", AsmHeader."Qty. per Unit of Measure", AssemblyLine."Resource Usage Type"));
        AssemblyLine.ValidateDueDate(AsmHeader, AsmHeader."Starting Date", ShowDueDateBeforeWorkDateMessage);
        DueDateBeforeWorkDateMsgShown:=(AssemblyLine."Due Date" < WORKDATE) AND ShowDueDateBeforeWorkDateMessage;
        AssemblyLine.ValidateLeadTimeOffset(AsmHeader, BomComponent."Lead-Time Offset", NOT DueDateBeforeWorkDateMsgShown AND ShowDueDateBeforeWorkDateMessage);
        AssemblyLine.Description:=BomComponent.Description;
        AssemblyLine."Description 2":=AsmHeader."Description 2";
        IF AssemblyLine.Type = AssemblyLine.Type::Item THEN AssemblyLine.VALIDATE("Variant Code", BomComponent."Variant Code");
        IF AsmHeader."Location Code" <> '' THEN IF AssemblyLine.Type = AssemblyLine.Type::Item THEN AssemblyLine.VALIDATE("Location Code", AsmHeader."Location Code");
        //-- #9785
        AssemblyLine.VALIDATE("Related Work Center", BomComponent."Related Work Center");
        //++ #9785
        //-- #9969
        AssemblyLine.VALIDATE("Perc. Loss", 0);
        IF Item.GET(AssemblyLine."No.")THEN AssemblyLine.VALIDATE("Perc. Loss", Item."Perc. Loss");
        //++ #9969
        //-- #9993
        AssemblyLine.VALIDATE("Cantidad por Lote", BomComponent."Cantidad por Lote");
        //-- #9993
        AssemblyLine.MODIFY(TRUE);
        // Inicio ADV001
        AssemblyLine.gfu_SetCantidadCabecera(AsmHeader.Quantity, AsmHeader."Quantity (Base)", AsmHeader."Remaining Quantity", AsmHeader."Remaining Quantity (Base)", AsmHeader."Quantity to Assemble", AsmHeader."Quantity to Assemble (Base)", FALSE);
    // Fin ADV001
    end;
    local procedure InsertAsmLine(AsmHeader: Record 900; var AssemblyLine: Record 901; AsmLineRecordIsTemporary: Boolean)
    begin
        AssemblyLine.INIT;
        AssemblyLine."Document Type":=AsmHeader."Document Type";
        AssemblyLine."Document No.":=AsmHeader."No.";
        AssemblyLine."Line No.":=GetNextAsmLineNo(AssemblyLine, AsmLineRecordIsTemporary);
        AssemblyLine.INSERT(TRUE);
    end;
    procedure GetNextAsmLineNo(var AsmLine: Record 901; AsmLineRecordIsTemporary: Boolean): Integer var
        TempAssemblyLine2: Record 901 temporary;
        AssemblyLine2: Record 901;
    begin
        IF AsmLineRecordIsTemporary THEN BEGIN
            TempAssemblyLine2.COPY(AsmLine, TRUE);
            TempAssemblyLine2.SETRANGE("Document Type", AsmLine."Document Type");
            TempAssemblyLine2.SETRANGE("Document No.", AsmLine."Document No.");
            IF TempAssemblyLine2.FINDLAST THEN EXIT(TempAssemblyLine2."Line No." + 10000);
        END
        ELSE
        BEGIN
            AssemblyLine2.SETRANGE("Document Type", AsmLine."Document Type");
            AssemblyLine2.SETRANGE("Document No.", AsmLine."Document No.");
            IF AssemblyLine2.FINDLAST THEN EXIT(AssemblyLine2."Line No." + 10000);
        END;
        EXIT(10000);
    end;
    local procedure GetWarningMode(): Boolean begin
        EXIT(NOT WarningModeOff);
    end;
    //END Funciones migradas CDU 905 "Assembly Line Management"
    procedure RoutingCostPerUnit2(Type: Option "Work Center", "Machine Center", " "; var DirUnitCost: Decimal; var IndirCostPct: Decimal; var OvhdRate: Decimal; var UnitCost: Decimal; var UnitCostCalculation: Option Time, Unit; WorkCenter: Record 99000754; MachineCenter: Record 99000758)
    begin
        UnitCostCalculation:=UnitCostCalculation::Time;
        CASE Type OF Type::"Work Center": BEGIN
            UnitCostCalculation:=WorkCenter."Unit Cost Calculation".AsInteger();
            IndirCostPct:=WorkCenter."Indirect Cost %";
            OvhdRate:=WorkCenter."Overhead Rate";
            IF WorkCenter."Specific Unit Cost" THEN BEGIN
                DirUnitCost:=CalcDirUnitCost(UnitCost, OvhdRate, IndirCostPct);
            END
            ELSE
            BEGIN
                DirUnitCost:=WorkCenter."Direct Unit Cost";
                UnitCost:=WorkCenter."Unit Cost";
            END;
        END;
        Type::"Machine Center": BEGIN
            MachineCenter.TESTFIELD("Work Center No.");
            DirUnitCost:=MachineCenter."Direct Unit Cost";
            OvhdRate:=MachineCenter."Overhead Rate";
            IndirCostPct:=MachineCenter."Indirect Cost %";
            UnitCost:=MachineCenter."Unit Cost";
        END;
        END;
    end;
    procedure CalcDirUnitCost(UnitCost: Decimal; OvhdRate: Decimal; IndirCostPct: Decimal): Decimal begin
        EXIT((UnitCost - OvhdRate) / (1 + IndirCostPct / 100));
    end;
    var GetPlanningParameters: Codeunit 99000855;
    SKU: Record 5700 temporary;
    CalendarMgmt: Codeunit 7600;
    CalChange: Record 7602;
    CustomCalendarChange: array[2]of Record "Customized Calendar Change";
    procedure PlannedEndingDate2(ItemNo: Code[20]; LocationCode: Code[10]; VariantCode: Code[50]; VendorNo: Code[20]; LeadTime: Code[20]; RefOrderType: Option " ", Purchase, "Prod. Order", Transfer, Assembly; StartingDate: Date): Date var
        TransferRoute: Record 5742;
        PlannedReceiptDate: Date;
        ShippingTime: DateFormula;
    begin
        // Returns Ending Date calculated forward from Starting Date
        IF RefOrderType = RefOrderType::Transfer THEN BEGIN
            GetPlanningParameters.AtSKU(SKU, ItemNo, VariantCode, LocationCode);
            TransferRoute.GetTransferRoute(SKU."Transfer-from Code", LocationCode, TransferRoute."In-Transit Code", TransferRoute."Shipping Agent Code", TransferRoute."Shipping Agent Service Code");
            TransferRoute.GetShippingTime(SKU."Transfer-from Code", LocationCode, TransferRoute."Shipping Agent Code", TransferRoute."Shipping Agent Service Code", ShippingTime);
            TransferRoute.CalcPlannedReceiptDateForward(StartingDate, PlannedReceiptDate, ShippingTime, LocationCode, TransferRoute."Shipping Agent Code", TransferRoute."Shipping Agent Service Code");
            EXIT(PlannedReceiptDate);
        END;
        IF DateFormulaIsEmpty(LeadTime)THEN EXIT(StartingDate);
        IF(VendorNo <> '') AND (RefOrderType = RefOrderType::Purchase)THEN begin
            CustomCalendarChange[1].SetSource(CalChange."Source Type"::Vendor, VendorNo, '', '');
            CustomCalendarChange[2].SetSource(CalChange."Source Type"::Location, LocationCode, '', '');
            EXIT(CalendarMgmt.CalcDateBOC(LeadTime, StartingDate, CustomCalendarChange, TRUE));
        end;
        CustomCalendarChange[1].SetSource(CalChange."Source Type"::Location, LocationCode, '', '');
        CustomCalendarChange[2].SetSource(CalChange."Source Type"::Location, LocationCode, '', '');
        EXIT(CalendarMgmt.CalcDateBOC(LeadTime, StartingDate, CustomCalendarChange, FALSE));
    end;
    local procedure DateFormulaIsEmpty(DateFormulaText: Code[30]): Boolean var
        DateFormula: DateFormula;
    begin
        IF DateFormulaText = '' THEN EXIT(TRUE);
        EVALUATE(DateFormula, DateFormulaText);
        EXIT(CALCDATE(DateFormula, WORKDATE) = WORKDATE);
    end;
    //POST assembly
    var ItemJnlPostLine: Codeunit 22;
    procedure lfu_Autoconsumo(var PostedAsmHeader: Record 910; PostingNoSeries: Code[10]; SourceCode: Code[10]; PostingDate: Date)
    var
        ItemLedgerEntry: Record 32;
        ItemJnlLine: Record 83;
        bAutoReserve: Boolean;
        cu_CreateReservEntry: Codeunit 99000830;
        CDU: Codeunit "Assembly-Post";
        recReservEntry: Record "Reservation Entry";
        Status: Enum "Reservation Status";
    begin
        ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETRANGE("Document No.", PostedAsmHeader."No.");
        ItemLedgerEntry.SETRANGE("Posting Date", PostedAsmHeader."Posting Date");
        ItemLedgerEntry.SETRANGE("Document Type", ItemLedgerEntry."Document Type"::"Posted Assembly");
        ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::"Assembly Output");
        IF ItemLedgerEntry.FINDSET THEN REPEAT CLEAR(ItemJnlLine);
                ItemJnlLine.INIT;
                ItemJnlLine."Entry Type":=ItemJnlLine."Entry Type"::"Negative Adjmt.";
                ItemJnlLine."Source Code":=SourceCode;
                ItemJnlLine."Document Type":=ItemJnlLine."Document Type"::"Posted Assembly";
                ItemJnlLine."Document No.":=PostedAsmHeader."No.";
                ItemJnlLine."Document Date":=PostingDate;
                ItemJnlLine."Document Line No.":=0;
                ItemJnlLine."Order No.":=ItemLedgerEntry."Order No.";
                ItemJnlLine."Order Type":=ItemJnlLine."Order Type"::Assembly;
                ItemJnlLine."Order Line No.":=0;
                ItemJnlLine."Source Type":=ItemLedgerEntry."Source Type";
                ItemJnlLine."Source No.":=ItemLedgerEntry."Source No.";
                ItemJnlLine.VALIDATE("Posting Date", PostingDate);
                ItemJnlLine."Posting No. Series":=PostingNoSeries;
                ItemJnlLine.Type:=ItemJnlLine.Type::" ";
                ItemJnlLine.VALIDATE("Item No.", ItemLedgerEntry."Item No.");
                ItemJnlLine.VALIDATE("Variant Code", ItemLedgerEntry."Variant Code");
                ItemJnlLine.VALIDATE("Location Code", ItemLedgerEntry."Location Code");
                ItemJnlLine.VALIDATE("Bin Code", PostedAsmHeader."Bin Code");
                ItemJnlLine."Gen. Prod. Posting Group":=PostedAsmHeader."Gen. Prod. Posting Group";
                ItemJnlLine."Inventory Posting Group":=PostedAsmHeader."Inventory Posting Group";
                ItemJnlLine.VALIDATE("Unit of Measure Code", ItemLedgerEntry."Unit of Measure Code");
                ItemJnlLine.VALIDATE("Qty. per Unit of Measure", ItemLedgerEntry."Qty. per Unit of Measure");
                ItemJnlLine.VALIDATE(Quantity, ItemLedgerEntry.Quantity);
                ItemJnlLine.VALIDATE("Dimension Set ID", ItemLedgerEntry."Dimension Set ID");
                ItemJnlLine."Shortcut Dimension 1 Code":=ItemLedgerEntry."Global Dimension 1 Code";
                ItemJnlLine."Shortcut Dimension 2 Code":=ItemLedgerEntry."Global Dimension 2 Code";
                UpdateItemCategoryAndGroupCode(ItemJnlLine);
                ItemJnlLine."Expiration Date":=ItemLedgerEntry."Expiration Date";
                recReservEntry.Reset();
                recReservEntry."Lot No.":=ItemLedgerEntry."Lot No.";
                //recReservEntry."Qty. per Unit of Measure" := ItemJnlLine."Qty. per Unit of Measure";
                //recReservEntry.Quantity := ItemJnlLine.Quantity;
                //recReservEntry."Quantity (Base)" := ItemJnlLine."Quantity (Base)";
                //recReservEntry
                CLEAR(cu_CreateReservEntry);
                cu_CreateReservEntry.CreateReservEntryFor(DATABASE::"Item Journal Line", ItemJnlLine."Entry Type".AsInteger(), ItemJnlLine."Journal Template Name", ItemJnlLine."Journal Batch Name", 0, ItemJnlLine."Line No.", ItemJnlLine."Qty. per Unit of Measure", ItemJnlLine.Quantity, ItemJnlLine."Quantity (Base)", recReservEntry);
                cu_CreateReservEntry.CreateEntry(ItemJnlLine."Item No.", ItemJnlLine."Variant Code", ItemJnlLine."Location Code", '', PostingDate, PostingDate, 0, Status::Surplus);
                ItemJnlPostLine.RunWithCheck(ItemJnlLine);
            UNTIL ItemLedgerEntry.NEXT = 0;
    end;
    local procedure UpdateItemCategoryAndGroupCode(var ItemJnlLine: Record "Item Journal Line")
    var
        Item: Record Item;
    begin
        Item.Get(ItemJnlLine."Item No.");
        ItemJnlLine."Item Category Code":=Item."Item Category Code";
    end;
}
