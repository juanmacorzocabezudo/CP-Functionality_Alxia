codeunit 50003 FuncionesVarias
{
    Permissions = tableData 111=rimd,
        tabledata 112=rimd,
        tabledata 37=rimd,
        tabledata 337=rimd;

    VAR VarFirstOrderNo: Code[20];
    SkipQuestion: Boolean;
    PROCEDURE CreateAssamblyOrders(VAR ParAssemblyHeader: Record 900);
    VAR
        AssemblyLineLocal: Record 901;
        InsAssemblyHeader: Record 900;
        InsAssemblyLine: Record 901;
        Item: Record 27;
        BOMComponent: Record 90;
        ModAssemblyLine: Record 901;
    BEGIN
        //-- #9627
        CLEAR(VarFirstOrderNo);
        VarFirstOrderNo:=ParAssemblyHeader."No.";
        AssemblyLineLocal.RESET;
        AssemblyLineLocal.SETRANGE("Document Type", ParAssemblyHeader."Document Type");
        AssemblyLineLocal.SETRANGE("Document No.", ParAssemblyHeader."No.");
        AssemblyLineLocal.SETRANGE(Type, AssemblyLineLocal.Type::Item);
        IF AssemblyLineLocal.FINDSET THEN BEGIN
            REPEAT Item.RESET;
                Item.GET(AssemblyLineLocal."No.");
                Item.CALCFIELDS("Assembly BOM");
                IF Item."Assembly BOM" THEN BEGIN
                    InsAssemblyHeader.RESET;
                    InsAssemblyHeader.SETRANGE("Associated Order", TRUE);
                    InsAssemblyHeader.SETRANGE("Associated Order No.", AssemblyLineLocal."Document No.");
                    InsAssemblyHeader.SETRANGE("Associated Order Line", AssemblyLineLocal."Line No.");
                    IF InsAssemblyHeader.FINDFIRST THEN BEGIN
                        //IF InsAssemblyHeader."Quantity to Assemble (Base)" <> AssemblyLineLocal."Quantity to Consume (Base)" THEN BEGIN
                        ModAssamblyOrders(AssemblyLineLocal);
                    //END;
                    END
                    ELSE
                    BEGIN
                        InsAssamblyOrders(ParAssemblyHeader, AssemblyLineLocal, Item);
                    END;
                END;
            UNTIL AssemblyLineLocal.NEXT = 0;
        END;
        IF ParAssemblyHeader."Associated Order" THEN BEGIN
            ModAssamblyOrderLine(ParAssemblyHeader);
        END;
    //++ #9627
    END;
    PROCEDURE ModAssamblyOrderLine(AssemblyHeader: Record 900);
    VAR
        ModAssemblyLine: Record 901;
        VarModRec: Boolean;
    BEGIN
        //-- #9627
        CLEAR(VarModRec);
        ModAssemblyLine.RESET;
        ModAssemblyLine.SETRANGE("Document Type", ModAssemblyLine."Document Type"::Order);
        ModAssemblyLine.SETRANGE("Document No.", AssemblyHeader."Associated Order No.");
        ModAssemblyLine.SETRANGE("Line No.", AssemblyHeader."Associated Order Line");
        IF ModAssemblyLine.FINDFIRST THEN BEGIN
            IF ModAssemblyLine.Quantity <> AssemblyHeader.Quantity THEN BEGIN
                VarModRec:=TRUE;
                ModAssemblyLine.VALIDATE(Quantity, AssemblyHeader.Quantity);
            END;
            IF ModAssemblyLine."Location Code" <> AssemblyHeader."Location Code" THEN BEGIN
                VarModRec:=TRUE;
                ModAssemblyLine.VALIDATE("Location Code", AssemblyHeader."Location Code");
            END;
            IF ModAssemblyLine."Due Date" <> AssemblyHeader."Due Date" THEN BEGIN
                VarModRec:=TRUE;
                ModAssemblyLine.VALIDATE("Due Date", AssemblyHeader."Due Date");
            END;
            IF VarModRec THEN ModAssemblyLine.MODIFY(TRUE);
        END;
    //++ #9627
    END;
    PROCEDURE ModAssamblyOrders(AssemblyLine: Record 901);
    VAR
        ModAssemblyHeader: Record 900;
        ErrorAssociatedBloc: Label 'ENU=The line cannot be change because the associated order is blocked;ESP=La linea no se puede modificar porque el pedido asociado esta bloqueado';
    BEGIN
        //-- #9627
        ModAssemblyHeader.RESET;
        ModAssemblyHeader.SETRANGE("Associated Order", TRUE);
        ModAssemblyHeader.SETRANGE("Associated Order No.", AssemblyLine."Document No.");
        ModAssemblyHeader.SETRANGE("Associated Order Line", AssemblyLine."Line No.");
        IF ModAssemblyHeader.FINDFIRST THEN BEGIN
            IF ModAssemblyHeader."Associated Blocked" THEN BEGIN
                ERROR(ErrorAssociatedBloc);
            END
            ELSE
            BEGIN
                ModAssemblyHeader.SetWarningsOff;
                ModAssemblyHeader.ShowConfirmChangeQtyOff(TRUE);
                ModAssemblyHeader.VALIDATE(Quantity, AssemblyLine."Quantity to Consume (Base)");
                ModAssemblyHeader.VALIDATE("Location Code", AssemblyLine."Location Code");
                ModAssemblyHeader.VALIDATE("Due Date", AssemblyLine."Due Date");
                ModAssemblyHeader.MODIFY(TRUE);
            END;
        END;
    //++ #9627
    END;
    PROCEDURE InsAssamblyOrders(AssemblyHeader: Record 900; AssemblyLine: Record 901; Item: Record 27);
    VAR
        InsAssemblyHeader: Record 900;
    BEGIN
        //-- #9627
        InsAssemblyHeader.INIT;
        InsAssemblyHeader."Document Type":=AssemblyLine."Document Type";
        InsAssemblyHeader.INSERT(TRUE);
        InsAssemblyHeader.SetWarningsOff;
        InsAssemblyHeader.VALIDATE("Item No.", AssemblyLine."No.");
        InsAssemblyHeader.VALIDATE("Unit of Measure Code", AssemblyLine."Unit of Measure Code");
        InsAssemblyHeader.Description:=AssemblyLine.Description;
        InsAssemblyHeader."Description 2":=AssemblyLine."Description 2";
        InsAssemblyHeader."Variant Code":=AssemblyLine."Variant Code";
        InsAssemblyHeader."Location Code":=AssemblyLine."Location Code";
        InsAssemblyHeader."Inventory Posting Group":=AssemblyLine."Inventory Posting Group";
        InsAssemblyHeader.VALIDATE("Unit Cost", AssemblyLine."Unit Cost");
        InsAssemblyHeader."Due Date":=AssemblyLine."Due Date";
        InsAssemblyHeader."Starting Date":=AssemblyHeader."Starting Date";
        InsAssemblyHeader."Ending Date":=AssemblyHeader."Ending Date";
        //SL Agregar la fecha de produccion en los pedidos en cascada
        InsAssemblyHeader.AGRALAFechaProduccion:=AssemblyHeader.AGRALAFechaProduccion;
        InsAssemblyHeader.AGRALAFechaEntrega:=AssemblyHeader.AGRALAFechaEntrega;
        //SL END
        InsAssemblyHeader.Quantity:=AssemblyLine.Quantity;
        InsAssemblyHeader."Quantity (Base)":=AssemblyLine."Quantity (Base)";
        InsAssemblyHeader.InitRemainingQty;
        InsAssemblyHeader.InitQtyToAssemble;
        // -- 20/04/2022 -> ILR. Al no hacer validate de Quantity no salta el evento que rellena cantidad original
        InsAssemblyHeader."Cantidad Original":=AssemblyLine.Quantity;
        InsAssemblyHeader.Diferencia:=AssemblyLine.Diferencia;
        InsAssemblyHeader."Diferencia%":=AssemblyLine."Diferencia%";
        // ++
        IF AssemblyLine."Bin Code" <> '' THEN InsAssemblyHeader."Bin Code":=AssemblyLine."Bin Code"
        ELSE
            InsAssemblyHeader.GetDefaultBin;
        InsAssemblyHeader."Planning Flexibility":=AssemblyHeader."Planning Flexibility";
        InsAssemblyHeader."Shortcut Dimension 1 Code":=AssemblyLine."Shortcut Dimension 1 Code";
        InsAssemblyHeader."Shortcut Dimension 2 Code":=AssemblyLine."Shortcut Dimension 2 Code";
        InsAssemblyHeader."Dimension Set ID":=AssemblyLine."Dimension Set ID";
        InsAssemblyHeader.NoEvento:=AssemblyHeader.NoEvento;
        InsAssemblyHeader."Associated Order":=TRUE;
        InsAssemblyHeader."Associated Order No.":=AssemblyLine."Document No.";
        InsAssemblyHeader."Associated Order Line":=AssemblyLine."Line No.";
        InsAssemblyHeader."Associated First Order No.":=VarFirstOrderNo;
        InsAssemblyHeader.VALIDATE("Net Amount"); //** #9969
        InsAssemblyHeader.MODIFY;
        InsAssamblyOrdersLines(InsAssemblyHeader, AssemblyLine, Item);
    //++ #9627
    END;
    PROCEDURE InsAssamblyOrdersLines(AssemblyHeader: Record 900; AssemblyLine: Record 901; Item: Record 27);
    VAR
        InsAssemblyHeader: Record 900;
        BOMComponent: Record 90;
    BEGIN
        //-- #9627
        AssemblyHeader.SetWarningsOff();
        BOMComponent.RESET;
        BOMComponent.SETRANGE("Parent Item No.", Item."No.");
        IF BOMComponent.FINDFIRST THEN BEGIN
            REPEAT AssemblyHeader.AddBOMLine(BOMComponent);
            UNTIL BOMComponent.NEXT = 0 END;
        CheckNewLinesAssamblyOrders(AssemblyHeader);
    //++ #9627
    END;
    PROCEDURE CheckNewLinesAssamblyOrders(AssemblyHeader: Record 900);
    VAR
        AssemblyLine: Record 901;
        Item: Record 27;
        BOMComponent: Record 90;
    BEGIN
        //-- #9627
        AssemblyLine.RESET;
        AssemblyLine.SETRANGE("Document Type", AssemblyHeader."Document Type");
        AssemblyLine.SETRANGE("Document No.", AssemblyHeader."No.");
        AssemblyLine.SETRANGE(Type, AssemblyLine.Type::Item);
        IF AssemblyLine.FINDSET THEN BEGIN
            REPEAT Item.RESET;
                Item.GET(AssemblyLine."No.");
                Item.CALCFIELDS("Assembly BOM");
                IF Item."Assembly BOM" THEN BEGIN
                    InsAssamblyOrders(AssemblyHeader, AssemblyLine, Item);
                END;
            //SL Net
            //AssemblyLine.Validate("Net Amount");
            UNTIL AssemblyLine.NEXT = 0;
        END;
    //++ #9627
    END;
    PROCEDURE PostAllAssocietedDocs(AssemblyHeader: Record 900);
    VAR
        AssemblyHeaderCheck: Record 900;
    BEGIN
        //-- #9627
        AssemblyHeaderCheck.RESET;
        AssemblyHeaderCheck.SETCURRENTKEY("Document Type", "No.");
        AssemblyHeaderCheck.ASCENDING(FALSE);
        AssemblyHeaderCheck.SETRANGE("Document Type", AssemblyHeader."Document Type");
        AssemblyHeaderCheck.SETRANGE("Associated First Order No.", AssemblyHeader."No.");
        IF AssemblyHeaderCheck.FINDSET THEN BEGIN
            REPEAT CODEUNIT.RUN(CODEUNIT::"Assembly-Post (Yes/No)", AssemblyHeaderCheck);
            UNTIL AssemblyHeaderCheck.NEXT = 0;
        END;
    //++ #9627
    END;
    PROCEDURE CreateNewBOMVersion(Item: Record 27);
    VAR
        VersionNum: Integer;
        BOMComponent: Record 90;
        RecetaComentarios: Record 50009;
        BOMVersionHeader: Record 50024;
        BOMVersionLines: Record 50025;
        TextCreateNewVersion: Label 'Esta accion archivara la receta como una nueva version, quiere continuar?';
        BOMCommentVersion: Record 50026;
        BOMAditionalCost: Record 50029;
        BOMAditionalCostVersion: Record 50029;
        AsmInfoPaneMgt: Codeunit 915;
    BEGIN
        //-- #9862
        CLEAR(VersionNum);
        IF NOT SkipQuestion THEN BEGIN
            IF NOT CONFIRM(TextCreateNewVersion, TRUE)THEN EXIT;
        END;
        BOMComponent.RESET;
        BOMComponent.SETRANGE("Parent Item No.", Item."No.");
        IF BOMComponent.FINDSET THEN BEGIN
            BOMVersionHeader.RESET;
            BOMVersionHeader.SETRANGE("Item No.", Item."No.");
            IF BOMVersionHeader.FINDLAST THEN VersionNum:=BOMVersionHeader."BOM Version" + 1
            ELSE
                VersionNum:=1;
            BOMVersionHeader.INIT;
            BOMVersionHeader.VALIDATE("Item No.", Item."No.");
            BOMVersionHeader.VALIDATE("BOM Version", VersionNum);
            BOMVersionHeader.VALIDATE(Description, Item.Description);
            BOMVersionHeader.VALIDATE("Base Unit of Measure", Item."Base Unit of Measure");
            BOMVersionHeader.VALIDATE("Lote Receta", Item."Lote Receta");
            BOMVersionHeader.VALIDATE("Statistics Lot", Item."Statistics Lot");
            BOMVersionHeader.VALIDATE("Statistics Unit of Measurement", Item."Statistics Unit of Measurement");
            BOMVersionHeader.VALIDATE("Version Date", WORKDATE);
            BOMVersionHeader.StandarCost:=Item."Standard Cost";
            BOMVersionHeader.UnitCost:=Item."Unit Cost";
            BOMVersionHeader.CosteLMFijado:=Item.Receta_CosteLMFijado;
            BOMVersionHeader.CostesGenerales:=CalcAditionalFixedTotalCoste(Item."No.", 0);
            BOMVersionHeader.ExWork:=CalcAditionalFixedTotalCoste(Item."No.", 0) + Item.Receta_CosteLMFijado;
            BOMVersionHeader.INSERT;
            REPEAT BOMVersionLines.INIT;
                BOMVersionLines.TRANSFERFIELDS(BOMComponent);
                BOMVersionLines."BOM Version":=VersionNum;
                BOMVersionLines.INSERT;
            UNTIL BOMComponent.NEXT = 0;
            RecetaComentarios.RESET;
            RecetaComentarios.SETRANGE("No.", Item."No.");
            IF RecetaComentarios.FINDSET THEN BEGIN
                REPEAT BOMCommentVersion.INIT;
                    BOMCommentVersion.TRANSFERFIELDS(RecetaComentarios);
                    BOMCommentVersion."BOM Version":=VersionNum;
                    BOMCommentVersion.INSERT;
                UNTIL RecetaComentarios.NEXT = 0;
            END;
            BOMAditionalCost.RESET;
            BOMAditionalCost.SETRANGE("Item No", Item."No.");
            BOMAditionalCost.SETRANGE("BOM Version", 0);
            IF BOMAditionalCost.FINDSET THEN BEGIN
                REPEAT BOMAditionalCost.VALIDATE(BOMAditionalCost.Value);
                    BOMAditionalCostVersion.INIT;
                    BOMAditionalCostVersion.TRANSFERFIELDS(BOMAditionalCost);
                    BOMAditionalCostVersion."BOM Version":=VersionNum;
                    BOMAditionalCostVersion.INSERT;
                UNTIL BOMAditionalCost.NEXT = 0;
            END;
        END;
    //++ #9862
    END;
    PROCEDURE CopyCostBOMfromTemplate(ItemNo: Code[20]; BOMVersion: Integer; TemplateCostHeader: Record 50027);
    VAR
        TextCopyCost: Label 'Esta accion copiara la plantilla a la receta, quiere copiarlo?';
        TemplateCostLine: Record 50028;
        BOMAditionalCost: Record 50029;
    BEGIN
        //-- #9862
        IF CONFIRM(TextCopyCost, TRUE)THEN BEGIN
            TemplateCostLine.RESET;
            TemplateCostLine.SETRANGE("No. Template", TemplateCostHeader."No.");
            IF TemplateCostLine.FINDSET THEN BEGIN
                REPEAT BOMAditionalCost.RESET;
                    BOMAditionalCost.SETRANGE("Item No", ItemNo);
                    BOMAditionalCost.SETRANGE("BOM Version", BOMVersion);
                    BOMAditionalCost.SETRANGE("No. Cost", TemplateCostLine."No. Cost");
                    IF BOMAditionalCost.FINDFIRST THEN BEGIN
                        BOMAditionalCost.VALIDATE("No. Template", TemplateCostLine."No. Template");
                        BOMAditionalCost.VALIDATE("Description Cost", TemplateCostLine.Description);
                        BOMAditionalCost.VALIDATE("Type Coste", TemplateCostLine."Type Coste");
                        BOMAditionalCost.VALIDATE(Value, TemplateCostLine.Value);
                        BOMAditionalCost.VALIDATE("Apply on all cost", TemplateCostLine."Apply on all cost");
                        BOMAditionalCost.MODIFY;
                    END
                    ELSE
                    BEGIN
                        BOMAditionalCost.INIT;
                        BOMAditionalCost.VALIDATE("Item No", ItemNo);
                        BOMAditionalCost.VALIDATE("BOM Version", BOMVersion);
                        BOMAditionalCost.VALIDATE("No. Cost", TemplateCostLine."No. Cost");
                        BOMAditionalCost.VALIDATE("No. Template", TemplateCostLine."No. Template");
                        BOMAditionalCost.VALIDATE("Description Cost", TemplateCostLine.Description);
                        BOMAditionalCost.VALIDATE("Type Coste", TemplateCostLine."Type Coste");
                        BOMAditionalCost.VALIDATE(Value, TemplateCostLine.Value);
                        BOMAditionalCost.VALIDATE("Apply on all cost", TemplateCostLine."Apply on all cost");
                        BOMAditionalCost.INSERT;
                    END;
                UNTIL TemplateCostLine.NEXT = 0;
            END;
        END;
    //++ #9862
    END;
    PROCEDURE RecuperateBOMVersion(ParBOMVersionHeader: Record 50024);
    VAR
        Item: Record 27;
        BOMComponent: Record 90;
        RecetaComentarios: Record 50009;
        BOMVersionHeader: Record 50024;
        BOMVersionLines: Record 50025;
        BOMCommentVersion: Record 50026;
        BOMAditionalCost: Record 50029;
        BOMAditionalCostVersion: Record 50029;
        TextRecuperateVersion: Label 'Quiere archivar la version actual y trasferir esta version como version real?';
    BEGIN
        //-- #9993
        IF NOT SkipQuestion THEN BEGIN
            IF NOT CONFIRM(TextRecuperateVersion, TRUE)THEN EXIT;
        END;
        SkipQuestion:=TRUE;
        Item.RESET;
        Item.GET(ParBOMVersionHeader."Item No.");
        CreateNewBOMVersion(Item);
        SkipQuestion:=FALSE;
        //** Borramos Datos de la receta actual
        BOMComponent.RESET;
        BOMComponent.SETRANGE("Parent Item No.", ParBOMVersionHeader."Item No.");
        IF BOMComponent.FINDSET THEN BEGIN
            REPEAT BOMComponent.DELETE;
            UNTIL BOMComponent.NEXT = 0;
        END;
        RecetaComentarios.RESET;
        RecetaComentarios.SETRANGE("No.", ParBOMVersionHeader."Item No.");
        IF RecetaComentarios.FINDSET THEN BEGIN
            RecetaComentarios.DELETE;
        END;
        BOMAditionalCost.RESET;
        BOMAditionalCost.SETRANGE("Item No", Item."No.");
        BOMAditionalCost.SETRANGE("BOM Version", 0);
        IF BOMAditionalCost.FINDSET THEN BEGIN
            REPEAT BOMAditionalCost.DELETE;
            UNTIL BOMAditionalCost.NEXT = 0;
        END;
        //** Cargamos datos
        BOMVersionHeader.RESET;
        BOMVersionHeader.SETRANGE("Item No.", ParBOMVersionHeader."Item No.");
        BOMVersionHeader.SETRANGE("BOM Version", ParBOMVersionHeader."BOM Version");
        IF BOMVersionHeader.FINDSET THEN BEGIN
            Item.GET(BOMVersionHeader."Item No.");
            Item.VALIDATE("Lote Receta", BOMVersionHeader."Lote Receta");
            Item.VALIDATE("Statistics Lot", BOMVersionHeader."Statistics Lot");
            Item.VALIDATE("Statistics Unit of Measurement", BOMVersionHeader."Statistics Unit of Measurement");
            Item.MODIFY;
            BOMVersionLines.RESET;
            BOMVersionLines.SETRANGE("Parent Item No.", ParBOMVersionHeader."Item No.");
            BOMVersionLines.SETRANGE("BOM Version", ParBOMVersionHeader."BOM Version");
            IF BOMVersionLines.FINDSET THEN BEGIN
                REPEAT BOMComponent.INIT;
                    BOMComponent.TRANSFERFIELDS(BOMVersionLines);
                    BOMComponent.INSERT;
                UNTIL BOMVersionLines.NEXT = 0;
            END;
            BOMCommentVersion.RESET;
            BOMCommentVersion.SETRANGE("No.", ParBOMVersionHeader."Item No.");
            BOMCommentVersion.SETRANGE("BOM Version", ParBOMVersionHeader."BOM Version");
            IF BOMCommentVersion.FINDSET THEN BEGIN
                REPEAT RecetaComentarios.INIT;
                    RecetaComentarios.TRANSFERFIELDS(BOMCommentVersion);
                    RecetaComentarios.INSERT;
                UNTIL BOMCommentVersion.NEXT = 0;
            END;
            BOMAditionalCostVersion.RESET;
            BOMAditionalCostVersion.SETRANGE("Item No", ParBOMVersionHeader."Item No.");
            BOMAditionalCostVersion.SETRANGE("BOM Version", ParBOMVersionHeader."BOM Version");
            IF BOMAditionalCostVersion.FINDSET THEN BEGIN
                REPEAT BOMAditionalCost.INIT;
                    BOMAditionalCost.TRANSFERFIELDS(BOMAditionalCostVersion);
                    BOMAditionalCost."BOM Version":=0;
                    BOMAditionalCost.INSERT;
                UNTIL BOMAditionalCostVersion.NEXT = 0;
            END;
        END;
    //++ #9993
    END;
    /*  #9627 - Se crean las funciones para desglosar las lineas de Ensamblados
     #9862 - Se crea la funcion nueva
     #9969 - Se valida el campo Net Amount
     #9993 - Se crea la funcion para recuperar Version LM */
    PROCEDURE CalcAditionalFixedTotalCoste(ItemNo: Code[20]; BOMVersion: Integer)ReturnCost: Decimal;
    VAR
        BOMAditionalCostCheck: Record 50029;
    BEGIN
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
    END;
    PROCEDURE CalcItemCosteCalculado(VAR Rcd_Item: Record 27; VarActual: Boolean): Decimal;
    VAR
        BOMComp: Record 90;
        costeEstandarArticulos: Decimal;
        ItemAux: Record 27;
        Resource: Record 156;
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
    procedure MarkLineSSL(Rec: Record "Sales Shipment Line")
    var
        rSSL: Record "Sales Shipment Line";
    begin
        rSSL.Reset();
        rSSL.SetRange("Document No.", Rec."Document No.");
        rSSL.SetRange("Line No.", Rec."Line No.");
        if rSSL.FindFirst()then begin
            rSSL.NoShow:=true;
            rSSL.Modify();
        end;
    end;
    procedure MarkLineSL(Rec: Record "Sales Line")
    var
        rSL: Record "Sales Line";
    begin
        rSL.Reset();
        rSL.SetRange("Document Type", Rec."Document Type");
        rSL.SetRange("Document No.", Rec."Document No.");
        if rSL.FindFirst()then begin
            repeat rSL."Qty. Shipped Not Invoiced":=0;
                rSL.Modify();
            until rSL.Next() = 0;
        end;
    end;
    procedure MarkMOV(Rec: Record "Reservation Entry")
    var
        rRE: Record "Reservation Entry";
    begin
        rRE.Reset();
        rRE.SetRange("Entry No.", Rec."Entry No.");
        rRE.SetRange("Item No.", Rec."Item No.");
        if rRE.FindFirst()then begin
            rRE."Item Ledger Entry No.":=rRE.AlxMov;
            rRE.Modify();
        end;
    end;
    // GAP00037 >>>
    procedure Modify_TipoDeImpresionField_OnPostedSalesInvoice(InvoiceNo_: Code[20])
    var
        SalesInvHdr: Record "Sales Invoice Header";
        DefaultNumber: Integer;
        OptionSelected: Integer;
        OptionMembers: Label 'Impresión por capítulo,Impresión por capítulo detallado,Impresión detallada,Impresión concepto genérico,';
        Instruction: Label '¿Ah qué tipo de impresión desea actualizar la factura?';
    begin
        SalesInvHdr.Get(InvoiceNo_);
        DefaultNumber:=1;
        OptionSelected:=0;
        OptionSelected:=StrMenu(OptionMembers, DefaultNumber, Instruction);
        case OptionSelected of 1: SalesInvHdr."Tipo de Impresión":=Enum::AlxiaEventoTipodeImpresion::"Impresion por Capitulo";
        2: SalesInvHdr."Tipo de Impresión":=Enum::AlxiaEventoTipodeImpresion::"Imp. por Capitulo Dtl.";
        3: SalesInvHdr."Tipo de Impresión":=Enum::AlxiaEventoTipodeImpresion::"Impresion Detallada";
        4: SalesInvHdr."Tipo de Impresión":=Enum::AlxiaEventoTipodeImpresion::"Impresion Concepto Generico";
        end;
        SalesInvHdr.Modify();
    end;
    // GAP00037 <<<
    // GAP00037 >>>
    procedure ActivateOrDesactivated_ImpresionComentariosField_OnPostedSalesInvoice(InvoiceNo_: Code[20])
    var
        SalesInvHdr: Record "Sales Invoice Header";
    begin
        SalesInvHdr.Get(InvoiceNo_);
        if SalesInvHdr."No Impresion Comentarios" then SalesInvHdr."No Impresion Comentarios":=false
        else
            SalesInvHdr."No Impresion Comentarios":=true;
        SalesInvHdr.Modify();
    end;
    // GAP00037 <<<
    // GAP00041 >>>
    // Se define un proceso para alimentar todas las líneas de albaranes históricos.
    procedure ActualizarLineasDeAlbaranDeVenta(NroAlbaran: Code[20])
    var
        Lineas: Record "Sales Shipment Line";
        UniMed: Record "Item Unit of Measure";
    begin
        // Mantener como histórico la unidad logística existente en cada caso.
        Lineas.Reset();
        Lineas.SetRange("Document No.", NroAlbaran);
        Lineas.SetRange(Type, Lineas.Type::Item);
        Lineas.SetRange("Unidad Logística en Vigor", 0);
        if Lineas.FindSet()then repeat // Tomar el valor de la “cant por unidad de medida” de la unidad medida marcada como unidad logística.
                UniMed.Reset();
                UniMed.SetRange("Item No.", Lineas."No.");
                UniMed.SetRange("Unidad Logística Albaran", true);
                if UniMed.FindFirst()then begin
                    Lineas."Unidad Logística en Vigor":=UniMed."Qty. per Unit of Measure";
                    Lineas.Modify();
                end;
            until Lineas.Next() = 0;
    end;
    // GAP00041 <<<
    procedure Modify_TipoDeImpresion_PostedSalesInvoice(InvoiceNo_: Code[20])
    var
        SalesInvHdr: Record "Sales Invoice Header";
    begin
        SalesInvHdr.Get(InvoiceNo_);
        SalesInvHdr."Tipo de Impresión":=Enum::AlxiaEventoTipodeImpresion::"Impresion Detallada";
        SalesInvHdr.Modify();
    end;
    //SL >>> GAP00054
    procedure Modify_TipoDeImpresion(InvoiceNo_: Code[20]; _Tipo: Enum AlxiaEventoTipodeImpresion)
    var
        SalesInvHdr: Record "Sales Invoice Header";
    begin
        SalesInvHdr.Get(InvoiceNo_);
        SalesInvHdr."Tipo de Impresión":=_Tipo;
        SalesInvHdr."Tipo de Impresión Ajustada":=true;
        SalesInvHdr.Modify();
    end;
//SL <<< GAP00054
}
