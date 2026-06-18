tableextension 50000 AlxiaAssemblyHeader extends "Assembly Header"
{
    fields
    {
        field(50000; NoEvento; Code[20])
        {
            Caption = 'Nº Evento';
            Description = 'ADV001';
            TableRelation = Evento;
        }
        field(50001; Autoconsumo; Boolean)
        {
            Description = 'ADV001';
        }
        field(50002; Simulacion; Boolean)
        {
            Description = 'ADV001';
        }
        field(50003; planificado; Boolean)
        {
        }
        field(50020; "Perc. Loss"; Decimal)
        {
            Caption = '% Loss';
            Description = '#9969';

            trigger OnValidate()
            begin
                //-- #9969
                VALIDATE("Net Amount");
            //++ #9969
            end;
        }
        field(50021; "Net Amount"; Decimal)
        {
            Caption = 'Net Amount';
            Description = '#9969';
            Editable = false;

            trigger OnValidate()
            begin
                //-- #9969
                "Net Amount":=Rec.Quantity - (Rec.Quantity * Rec."Perc. Loss") / 100;
            //++ #9969
            end;
        }
        field(50030; "Lot Quantity"; Decimal)
        {
            Caption = 'Lot Quantity';
            Description = '#9993';
            Editable = false;
        }
        field(50040; AGRALANivel; Text[30])
        {
            Description = '#22003';
        }
        field(50041; AGRALARecetaMadre; Text[50])
        {
            Description = '#22003';
            TableRelation = "Assembly Header"."No.";

            trigger OnLookup()
            var
                rlAssemblyHeader: Record "Assembly Header";
            begin
                rlAssemblyHeader.SETRANGE("Document Type", Rec."Document Type");
                rlAssemblyHeader.SETRANGE("No.", Rec."No.");
                PAGE.RUN(900, rlAssemblyHeader);
            end;
        }
        field(50042; AGRALAFechaProduccion; Date)
        {
            Caption = 'Fecha producción';
            Description = '863';

            trigger OnValidate()
            begin
                AGRALAModifyDatesAsociatedOrders(TRUE, FALSE, FALSE);
                IF AGRALAFechaProduccion <> 0D THEN AGRALASemana:=DATE2DWY(AGRALAFechaProduccion, 2)
                ELSE
                    AGRALASemana:=0;
            end;
        }
        field(50043; AGRALAFechaEntrega; Date)
        {
            Caption = 'Fecha entrega';
            Description = '863';

            trigger OnValidate()
            begin
            ///AGRALAModifyDatesAsociatedOrders(FALSE, FALSE, TRUE);
            end;
        }
        field(50044; "AGRALAFechaUltimaFabricación"; Date)
        {
            CalcFormula = Max("Posted Assembly Header"."Posting Date" WHERE("Item No."=FIELD("Item No.")));
            Caption = 'Fecha ultima fabricación';
            Description = '863';
            Editable = false;
            FieldClass = FlowField;

            trigger OnLookup()
            var
                rlPostedAssemblyHeader: Record "Posted Assembly Header";
                plPostedAssemblyOrders: Page "Posted Assembly Orders";
            begin
                CALCFIELDS(Rec.AGRALAFechaUltimaFabricación);
                rlPostedAssemblyHeader.SETRANGE("Posting Date", Rec.AGRALAFechaUltimaFabricación);
                rlPostedAssemblyHeader.SETRANGE("Item No.", Rec."Item No.");
                IF rlPostedAssemblyHeader.FINDFIRST()THEN BEGIN
                    plPostedAssemblyOrders.SETTABLEVIEW(rlPostedAssemblyHeader);
                    plPostedAssemblyOrders.RUNMODAL();
                END;
            end;
        }
        field(50045; AGRALASemana; Integer)
        {
            Caption = 'Semana';
            Description = '863';
            Editable = false;
        }
        field(50046; AGRALAParteReceta; Option)
        {
            Caption = 'Parte receta';
            Description = '863';
            OptionCaption = ' ,Impresa,En cronograma';
            OptionMembers = " ", Impresa, Cronograma;
        }
        field(50047; AGRALAObservaciones; Text[250])
        {
            Caption = 'Observaciones';
            Description = '863';
        }
        field(50048; AGRALAObservacionesIntern; Text[250])
        {
            Caption = 'Observaciones internas';
            Description = '915';
        }
        field(60000; "Cantidad Original"; Decimal)
        {
            DecimalPlaces = 0: 5;
            Description = 'KR';
            Editable = false;
        }
        field(60002; Diferencia; Decimal)
        {
            DecimalPlaces = 0: 5;
            Description = 'KR';
            Editable = false;
        }
        field(60003; "Diferencia%"; Decimal)
        {
            Description = 'KR';
            Editable = false;
        }
        field(70000; "Associated Order"; Boolean)
        {
            Caption = 'Associated Order';
            Description = '#9627';
            Editable = false;
        }
        field(70001; "Associated Order No."; Code[20])
        {
            Caption = 'Asociado Pedido Nº';
            Description = '#9627';
            Editable = false;
        }
        field(70002; "Associated Order Line"; Integer)
        {
            Caption = 'Associated Order Line';
            Description = '#9627';
            Editable = false;
        }
        field(70004; "Associated Blocked"; Boolean)
        {
            Caption = 'Associated Blocked';
            Description = '#9627';
        }
        field(70005; "Associated First Order No."; Code[20])
        {
            Caption = 'Asociado Primer Pedido Nº';
            Description = '#9627';
            Editable = false;
        }
        field(80000; "Standard Cost"; Decimal)
        {
            Caption = 'Standard Cost';
            Description = '#9766';
            Editable = false;

            trigger OnValidate()
            begin
                "Cost Std Amount":=ROUND(Quantity * "Standard Cost"); //** #9766
            end;
        }
        field(80001; "Cost Std Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost Standard Amount';
            Description = '#9766';
            Editable = false;
        }
        field(80002; "Rolled-up Assembly Std Cost"; Decimal)
        {
            CalcFormula = Sum("Assembly Line"."Cost Amount" WHERE("Document Type"=FIELD("Document Type"), "Document No."=FIELD("No."), Type=FILTER(Item|Resource)));
            Caption = 'Rolled-up Assembly Standard Cost';
            Description = '#9766';
            FieldClass = FlowField;
        }
        modify("Item No.")
        {
        trigger OnBeforeValidate()
        begin
            //++ #9993
            AssemblyLineMgt.SkipPreCheckAndConfirmUpdate(NOTShowConfirmChange);
        //** #9627
        end;
        trigger OnAfterValidate()
        var
            RecItem: Record Item;
        begin
            if "Item No." <> '' then begin
                RecItem.Reset();
                RecItem.SetRange("No.", "Item No.");
                RecItem.FindFirst();
                "Standard Cost":=GetUnitStandardCost; //** #9766
                VALIDATE("Perc. Loss", RecItem."Perc. Loss"); //** #9969
                VALIDATE("Lot Quantity", RecItem."Lote Receta"); //** #9993
                IF RecItem."Status LM" <> RecItem."Status LM"::Certificated THEN ERROR('La receta del producto %1 no esta certificada', Item."No.");
                //++ #9993
                AssemblyLineMgt.SkipPreCheckAndConfirmUpdate(NOTShowConfirmChange);
                //** #9627
                AssemblyLineMgt.UpdateAssemblyLines(Rec, xRec, FIELDNO("Item No."), TRUE, CurrFieldNo, CurrentFieldNum);
                AssemblyHeaderReserve.VerifyChange(Rec, xRec);
                ClearCurrentFieldNum(FIELDNO("Item No."));
            end;
        end;
        }
        modify("Location Code")
        {
        trigger OnBeforeValidate()
        begin
            AssemblyLineMgt.SkipPreCheckAndConfirmUpdate(NOTShowConfirmChange); //** #9627
            VALIDATE("Standard Cost", GetUnitStandardCost); //** #9766
        end;
        }
        modify("Posting Date")
        {
        trigger OnAfterValidate()
        begin
            //++AGRALA 915
            AGRALAModifyDatesAsociatedOrders(FALSE, TRUE, FALSE);
        //--AGRALA 915
        end;
        }
        modify("Variant Code")
        {
        trigger OnBeforeValidate()
        begin
            AssemblyLineMgt.SkipPreCheckAndConfirmUpdate(NOTShowConfirmChange); //** #9627
            VALIDATE("Standard Cost", GetUnitStandardCost); //** #9766
        end;
        }
        modify(Quantity)
        {
        /*  trigger OnBeforeValidate()
             begin

             end; */
        trigger OnAfterValidate()
        var
            ls_Pregunta: Text;
        begin
            CheckIsNotAsmToOrder;
            TestStatusOpen;
            SetCurrentFieldNum(FIELDNO(Quantity));
            RoundQty(Quantity);
            "Cost Amount":=ROUND(Quantity * "Unit Cost");
            "Cost Std Amount":=ROUND(Quantity * "Standard Cost"); //** 9766
            IF Quantity < "Assembled Quantity" THEN ERROR(Text002, FIELDCAPTION(Quantity), FIELDCAPTION("Assembled Quantity"), "Assembled Quantity");
            "Quantity (Base)":=CalcBaseQty(Quantity);
            InitRemainingQty;
            InitQtyToAssemble;
            VALIDATE("Quantity to Assemble");
            // Inicio ADV002
            // Líneas eliminadas:
            /*
                AssemblyLineMgt.UpdateAssemblyLines(Rec,xRec,FIELDNO(Quantity),ReplaceLinesFromBOM,CurrFieldNo,CurrentFieldNum);
                AssemblyHeaderReserve.VerifyQuantity(Rec,xRec)
                */
            IF(Quantity <> xRec.Quantity) AND (xRec.Quantity <> 0)THEN BEGIN
                ls_Pregunta:=(Text016);
                //-- #9627
                IF NOTShowConfirmChange THEN BEGIN
                    AssemblyLineMgt.SkipPreCheckAndConfirmUpdate(NOTShowConfirmChange); //** #9627
                    AssemblyLineMgt.SetWarningsOff();
                    AssemblyLineMgt.UpdateAssemblyLines(Rec, xRec, FIELDNO(Quantity), ReplaceLinesFromBOM, CurrFieldNo, CurrentFieldNum);
                    AssemblyHeaderReserve.VerifyQuantity(Rec, xRec)END
                ELSE
                BEGIN
                    /****************** TEXTO ORIGINAL ******************/
                    IF DIALOG.CONFIRM(ls_Pregunta)THEN BEGIN
                        AssemblyLineMgt.SkipPreCheckAndConfirmUpdate(NOTShowConfirmChange); //** #9627
                        AssemblyLineMgt.SetWarningsOff();
                        AssemblyLineMgt.UpdateAssemblyLines(Rec, xRec, FIELDNO(Quantity), ReplaceLinesFromBOM, CurrFieldNo, CurrentFieldNum);
                        AssemblyHeaderReserve.VerifyQuantity(Rec, xRec)END;
                /**************** FIN TEXTO ORIGINAL ****************/
                END;
            //-- #9627
            END
            ELSE
            BEGIN
                AssemblyLineMgt.SkipPreCheckAndConfirmUpdate(NOTShowConfirmChange); //** #9627
                AssemblyLineMgt.SetWarningsOff();
                AssemblyLineMgt.UpdateAssemblyLines(Rec, xRec, FIELDNO(Quantity), ReplaceLinesFromBOM, CurrFieldNo, CurrentFieldNum);
                AssemblyHeaderReserve.VerifyQuantity(Rec, xRec)END;
            // Fin ADV002
            // Fin ADV002
            ClearCurrentFieldNum(FIELDNO(Quantity));
            //++ KR 10/05/21
            //VALIDATE("Quantity to Assemble");
            //--
            //-- #9969
            VALIDATE("Net Amount");
            //++ #9969
            //-- #11552
            IF(Rec."Cantidad Original" = 0) AND (Rec.Quantity <> 0)THEN Rec."Cantidad Original":=Rec.Quantity;
            Rec.Diferencia:=Rec.Quantity - Rec."Cantidad Original";
            Rec."Diferencia%":=0;
            IF Rec."Cantidad Original" <> 0 THEN Rec."Diferencia%":=Rec.Diferencia / Rec."Cantidad Original" * 100;
        //++ #11552
        end;
        }
    }
    procedure AddBOMLineEvento(BOMComp: Record 50014)
    var
        AsmLine: Record 901;
    begin
        AssemblyLineMgt.AddBOMLineEventos(Rec, AsmLine, BOMComp);
        AutoReserveAsmLine(AsmLine);
    end;
    local procedure AGRALAModifyDatesAsociatedOrders(Production: Boolean; Posting: Boolean; Delivery: Boolean)
    var
        rlAssemblyHeader: Record 900;
    begin
        rlAssemblyHeader.RESET();
        rlAssemblyHeader.SETRANGE("Associated Order", TRUE);
        IF rlAssemblyHeader.FINDSET()THEN REPEAT IF rlAssemblyHeader."Associated Order No." = Rec."No." THEN BEGIN
                    IF Production THEN BEGIN
                        rlAssemblyHeader.AGRALAFechaProduccion:=Rec.AGRALAFechaProduccion;
                        IF rlAssemblyHeader.AGRALAFechaProduccion <> 0D THEN rlAssemblyHeader.AGRALASemana:=DATE2DWY(rlAssemblyHeader.AGRALAFechaProduccion, 2)
                        ELSE
                            rlAssemblyHeader.AGRALASemana:=0;
                    END;
                    IF Posting THEN rlAssemblyHeader."Posting Date":=Rec."Posting Date";
                    IF Delivery THEN rlAssemblyHeader.AGRALAFechaEntrega:=Rec.AGRALAFechaEntrega;
                    rlAssemblyHeader.MODIFY();
                END
                ELSE IF rlAssemblyHeader."Associated First Order No." = Rec."No." THEN BEGIN
                        IF Production THEN BEGIN
                            rlAssemblyHeader.AGRALAFechaProduccion:=Rec.AGRALAFechaProduccion;
                            IF rlAssemblyHeader.AGRALAFechaProduccion <> 0D THEN rlAssemblyHeader.AGRALASemana:=DATE2DWY(rlAssemblyHeader.AGRALAFechaProduccion, 2)
                            ELSE
                                rlAssemblyHeader.AGRALASemana:=0;
                        END;
                        IF Posting THEN rlAssemblyHeader."Posting Date":=Rec."Posting Date";
                        IF Delivery THEN rlAssemblyHeader.AGRALAFechaEntrega:=Rec.AGRALAFechaEntrega;
                        rlAssemblyHeader.MODIFY();
                    END;
            UNTIL rlAssemblyHeader.NEXT() = 0;
    end;
    var NOTShowConfirmChange: Boolean;
    AssemblyLineMgt: Codeunit AlxAssemblyLineManagement;
    AssemblyHeaderReserve: Codeunit 925;
    Text016: Label 'Se ha modificado la Cantidad en la cabecera del Pedido. ¿Desea que se recalcule las lineas?';
    Text002: Label '%1 cannot be lower than the %2, which is %3.';
    CurrentFieldNum: Integer;
    Item: Record 27;
    StockkeepingUnit: Record 5700;
    GLSetupRead: Boolean;
    GLSetup: Record 98;
    procedure ShowConfirmChangeQtyOff(NOTShowConfirmChangeLocal: Boolean)
    begin
        //-- #9627
        NOTShowConfirmChange:=NOTShowConfirmChangeLocal;
    //++ #9627
    end;
    local procedure ReplaceLinesFromBOM(): Boolean var
        NoLinesWerePresent: Boolean;
        LinesPresent: Boolean;
        DeleteLines: Boolean;
    begin
        NoLinesWerePresent:=(xRec.Quantity * xRec."Qty. per Unit of Measure" = 0);
        LinesPresent:=(Quantity * "Qty. per Unit of Measure" <> 0);
        DeleteLines:=(Quantity = 0);
        EXIT((NoLinesWerePresent AND LinesPresent) OR DeleteLines);
    end;
    local procedure ClearCurrentFieldNum(NewCurrentFieldNum: Integer)
    begin
        IF CurrentFieldNum = NewCurrentFieldNum THEN CurrentFieldNum:=0;
    end;
    local procedure GetItem()
    begin
        TESTFIELD("Item No.");
        IF Item."No." <> "Item No." THEN Item.GET("Item No.");
    end;
    local procedure GetUnitStandardCost(): Decimal var
        SkuItemUnitCost: Decimal;
    begin
        //-- #9766
        IF "Item No." = '' THEN EXIT(0);
        GetItem;
        IF GetSKU THEN SkuItemUnitCost:=StockkeepingUnit."Standard Cost" * "Qty. per Unit of Measure"
        ELSE
            SkuItemUnitCost:=Item."Standard Cost" * "Qty. per Unit of Measure";
        EXIT(RoundUnitAmount(SkuItemUnitCost));
    //++ #9766
    end;
    local procedure GetSKU(): Boolean begin
        IF(StockkeepingUnit."Location Code" = "Location Code") AND (StockkeepingUnit."Item No." = "Item No.") AND (StockkeepingUnit."Variant Code" = "Variant Code")THEN EXIT(TRUE);
        IF StockkeepingUnit.GET("Location Code", "Item No.", "Variant Code")THEN EXIT(TRUE);
        EXIT(FALSE);
    end;
    local procedure GetGLSetup()
    begin
        IF NOT GLSetupRead THEN GLSetup.GET;
        GLSetupRead:=TRUE;
    end;
    local procedure RoundUnitAmount(UnitAmount: Decimal): Decimal begin
        GetGLSetup;
        EXIT(ROUND(UnitAmount, GLSetup."Unit-Amount Rounding Precision"));
    end;
    local procedure SetCurrentFieldNum(NewCurrentFieldNum: Integer): Boolean begin
        IF CurrentFieldNum = 0 THEN BEGIN
            CurrentFieldNum:=NewCurrentFieldNum;
            EXIT(TRUE);
        END;
        EXIT(FALSE);
    end;
    local procedure CalcBaseQty(Qty: Decimal): Decimal var
        UOMMgt: Codeunit 5402;
    begin
        EXIT(UOMMgt.CalcBaseQty(Qty, "Qty. per Unit of Measure"));
    end;
}
