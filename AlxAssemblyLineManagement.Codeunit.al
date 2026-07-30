codeunit 50006 AlxAssemblyLineManagement
{
    // UpdateExistingLine-----------------------------------------------------
    //   ADVANCE
    //   Fecha: 14-08-2018
    //   Técnico: JAB
    //   Presupuesto: I009029 - Gestión de escalados
    //   Etiqueta: ADV001
    // -----------------------------------------------------
    // #9627 - Se introduce codigo
    // #9785 - Se traspasa el campo nuevo de los componentes al pedido
    // #9969 - Se traspasa el campo de Perc Loss
    Permissions = TableData 901 = rimd;

    trigger OnRun()
    begin
    end;

    var
        Text001: Label 'Do you want to update the %1 on the lines?';
        Text002: Label 'Do you want to update the Dimensions on the lines?';
        Text003: Label 'Changing %1 will change all the lines. Do you want to change the %1 from %2 to %3?';
        WarningModeOff: Boolean;
        Text004: Label 'This assembly order may have customized lines. Are you sure that you want to reset the lines according to the assembly BOM?';
        Text005: Label 'Due Date %1 is before work date %2 in one or more of the assembly lines.';
        Text006: Label 'Item %1 is not a BOM.';
        Text007: Label 'There is not enough space to explode the BOM.';
        gd_Cantidad: Decimal;
        FuncionesVarias: Codeunit 50003;
        SkipConfirmUpdate: Boolean;

    local procedure LinesExist(AsmHeader: Record 900): Boolean
    var
        AssemblyLine: Record 901;
    begin
        SetLinkToLines(AsmHeader, AssemblyLine);
        EXIT(NOT AssemblyLine.ISEMPTY);
    end;

    local procedure SetLinkToLines(AsmHeader: Record 900; var AssemblyLine: Record 901)
    begin
        AssemblyLine.SETRANGE("Document Type", AsmHeader."Document Type");
        AssemblyLine.SETRANGE("Document No.", AsmHeader."No.");
    end;

    local procedure SetLinkToItemLines(AsmHeader: Record 900; var AssemblyLine: Record 901)
    begin
        SetLinkToLines(AsmHeader, AssemblyLine);
        AssemblyLine.SETRANGE(Type, AssemblyLine.Type::Item);
    end;

    local procedure SetLinkToBOM(AsmHeader: Record 900; var BOMComponent: Record 90)
    begin
        BOMComponent.SETRANGE("Parent Item No.", AsmHeader."Item No.");
    end;

    procedure GetNextAsmLineNo(var AsmLine: Record 901; AsmLineRecordIsTemporary: Boolean): Integer
    var
        TempAssemblyLine2: Record 901 temporary;
        AssemblyLine2: Record 901;
    begin
        IF AsmLineRecordIsTemporary THEN BEGIN
            TempAssemblyLine2.COPY(AsmLine, TRUE);
            TempAssemblyLine2.SETRANGE("Document Type", AsmLine."Document Type");
            TempAssemblyLine2.SETRANGE("Document No.", AsmLine."Document No.");
            IF TempAssemblyLine2.FINDLAST THEN EXIT(TempAssemblyLine2."Line No." + 10000);
        END
        ELSE BEGIN
            AssemblyLine2.SETRANGE("Document Type", AsmLine."Document Type");
            AssemblyLine2.SETRANGE("Document No.", AsmLine."Document No.");
            IF AssemblyLine2.FINDLAST THEN EXIT(AssemblyLine2."Line No." + 10000);
        END;
        EXIT(10000);
    end;

    local procedure InsertAsmLine(AsmHeader: Record 900; var AssemblyLine: Record 901; AsmLineRecordIsTemporary: Boolean)
    begin
        AssemblyLine.INIT;
        AssemblyLine."Document Type" := AsmHeader."Document Type";
        AssemblyLine."Document No." := AsmHeader."No.";
        AssemblyLine."Line No." := GetNextAsmLineNo(AssemblyLine, AsmLineRecordIsTemporary);
        AssemblyLine.INSERT(TRUE);
    end;

    local procedure AddBOMLine2(AsmHeader: Record 900; var AssemblyLine: Record 901; AsmLineRecordIsTemporary: Boolean; BomComponent: Record 90; ShowDueDateBeforeWorkDateMessage: Boolean)
    var
        DueDateBeforeWorkDateMsgShown: Boolean;
        SkipVerificationsThatChangeDatabase: Boolean;
        rItem: Record Item;
        rResource: Record "Resource";
        rConfVentas: Record "Sales & Receivables Setup";
    begin
        SkipVerificationsThatChangeDatabase := AsmLineRecordIsTemporary;
        AssemblyLine.SetSkipVerificationsThatChangeDatabase(SkipVerificationsThatChangeDatabase);
        AssemblyLine.VALIDATE(Type, BomComponent.Type);
        // Inicio ADV001
        AssemblyLine.gfu_SetCantidadCabecera(AsmHeader.Quantity, AsmHeader."Quantity (Base)", AsmHeader."Remaining Quantity", AsmHeader."Remaining Quantity (Base)", AsmHeader."Quantity to Assemble", AsmHeader."Quantity to Assemble (Base)", TRUE);
        // Fin ADV001
        AssemblyLine.VALIDATE("No.", BomComponent."No.");
        AssemblyLine.Position := BomComponent.Position;
        AssemblyLine."Position 2" := BomComponent."Position 2";
        AssemblyLine."Position 3" := BomComponent."Position 3";
        IF AssemblyLine.Type = AssemblyLine.Type::Resource THEN
            CASE BomComponent."Resource Usage Type" OF
                BomComponent."Resource Usage Type"::Direct:
                    AssemblyLine.VALIDATE("Resource Usage Type", AssemblyLine."Resource Usage Type"::Direct);
                BomComponent."Resource Usage Type"::Fixed:
                    AssemblyLine.VALIDATE("Resource Usage Type", AssemblyLine."Resource Usage Type"::Fixed);
            END;
        AssemblyLine.VALIDATE("Unit of Measure Code", BomComponent."Unit of Measure Code");
        IF AssemblyLine.Type <> AssemblyLine.Type::" " THEN AssemblyLine.VALIDATE("Quantity per", AssemblyLine.CalcQuantityFromBOM(BomComponent.Type.AsInteger(), BomComponent."Quantity per", 1, AsmHeader."Qty. per Unit of Measure", AssemblyLine."Resource Usage Type"));
        AssemblyLine.VALIDATE(Quantity, AssemblyLine.CalcQuantityFromBOM(BomComponent.Type.AsInteger(), BomComponent."Quantity per", AsmHeader.Quantity, AsmHeader."Qty. per Unit of Measure", AssemblyLine."Resource Usage Type"));
        AssemblyLine.VALIDATE("Quantity to Consume", AssemblyLine.CalcQuantityFromBOM(BomComponent.Type.AsInteger(), BomComponent."Quantity per", AsmHeader."Quantity to Assemble", AsmHeader."Qty. per Unit of Measure", AssemblyLine."Resource Usage Type"));
        AssemblyLine.ValidateDueDate(AsmHeader, AsmHeader."Starting Date", ShowDueDateBeforeWorkDateMessage);
        DueDateBeforeWorkDateMsgShown := (AssemblyLine."Due Date" < WORKDATE) AND ShowDueDateBeforeWorkDateMessage;
        AssemblyLine.ValidateLeadTimeOffset(AsmHeader, BomComponent."Lead-Time Offset", NOT DueDateBeforeWorkDateMsgShown AND ShowDueDateBeforeWorkDateMessage);
        AssemblyLine.Description := BomComponent.Description;
        AssemblyLine."Description 2" := AsmHeader."Description 2";
        IF AssemblyLine.Type = AssemblyLine.Type::Item THEN AssemblyLine.VALIDATE("Variant Code", BomComponent."Variant Code");
        IF AsmHeader."Location Code" <> '' THEN IF AssemblyLine.Type = AssemblyLine.Type::Item THEN AssemblyLine.VALIDATE("Location Code", AsmHeader."Location Code");
        //-- #9785
        AssemblyLine.VALIDATE("Related Work Center", BomComponent."Related Work Center");
        //++ #9785
        //-- #9969
        AssemblyLine.VALIDATE("Perc. Loss", BomComponent."Perc. Loss");
        //++ #9969
        //-- #9993
        AssemblyLine.VALIDATE("Cantidad por Lote", BomComponent."Cantidad por Lote");
        //-- #9993
        //SL Net
        AssemblyLine.Validate("Net Amount");
        rConfVentas.Get();
        if rConfVentas.CopyDim then begin
            if AssemblyLine."No." <> '' then begin
                if AssemblyLine.Type = AssemblyLine.Type::Item then begin
                    rItem.Reset();
                    rItem.SetRange("No.", AssemblyLine."No.");
                    if rItem.FindFirst() then begin
                        AssemblyLine.Validate("Shortcut Dimension 1 Code", rItem."Global Dimension 1 Code");
                        AssemblyLine.Validate("Shortcut Dimension 2 Code", rItem."Global Dimension 2 Code");
                    end;
                end
                else if AssemblyLine.Type = AssemblyLine.Type::Resource then begin
                    rResource.Reset();
                    rResource.SetRange("No.", AssemblyLine."No.");
                    if rResource.FindFirst() then begin
                        AssemblyLine.Validate("Shortcut Dimension 1 Code", rResource."Global Dimension 1 Code");
                        AssemblyLine.Validate("Shortcut Dimension 2 Code", rResource."Global Dimension 2 Code");
                    end;
                end;
            end;
        end;
        AssemblyLine.MODIFY(TRUE);
        // Inicio ADV001
        AssemblyLine.gfu_SetCantidadCabecera(AsmHeader.Quantity, AsmHeader."Quantity (Base)", AsmHeader."Remaining Quantity", AsmHeader."Remaining Quantity (Base)", AsmHeader."Quantity to Assemble", AsmHeader."Quantity to Assemble (Base)", FALSE);
        // Fin ADV001
    end;

    procedure AddBOMLine(AsmHeader: Record 900; var AssemblyLine: Record 901; BomComponent: Record 90)
    begin
        InsertAsmLine(AsmHeader, AssemblyLine, FALSE);
        AddBOMLine2(AsmHeader, AssemblyLine, FALSE, BomComponent, GetWarningMode);
    end;

    procedure ExplodeAsmList(var AsmLine: Record 901)
    var
        AssemblyHeader: Record 900;
        FromBOMComp: Record 90;
        ToAssemblyLine: Record 901;
        TempAssemblyLine: Record 901 temporary;
        NoOfBOMCompLines: Integer;
        LineSpacing: Integer;
        NextLineNo: Integer;
        DueDateBeforeWorkDate: Boolean;
        NewLineDueDate: Date;
    begin
        AsmLine.TESTFIELD(Type, AsmLine.Type::Item);
        AsmLine.TESTFIELD("Consumed Quantity", 0);
        AsmLine.CALCFIELDS("Reserved Qty. (Base)");
        AsmLine.TESTFIELD("Reserved Qty. (Base)", 0);
        AssemblyHeader.GET(AsmLine."Document Type", AsmLine."Document No.");
        FromBOMComp.SETRANGE("Parent Item No.", AsmLine."No.");
        NoOfBOMCompLines := FromBOMComp.COUNT;
        IF NoOfBOMCompLines = 0 THEN ERROR(Text006, AsmLine."No.");
        ToAssemblyLine.RESET;
        ToAssemblyLine.SETRANGE("Document Type", AsmLine."Document Type");
        ToAssemblyLine.SETRANGE("Document No.", AsmLine."Document No.");
        ToAssemblyLine := AsmLine;
        LineSpacing := 10000;
        IF ToAssemblyLine.FIND('>') THEN BEGIN
            LineSpacing := (ToAssemblyLine."Line No." - AsmLine."Line No.") DIV (1 + NoOfBOMCompLines);
            IF LineSpacing = 0 THEN ERROR(Text007);
        END;
        TempAssemblyLine := AsmLine;
        TempAssemblyLine.INIT;
        TempAssemblyLine.Description := AsmLine.Description;
        TempAssemblyLine."Description 2" := AsmLine."Description 2";
        TempAssemblyLine."No." := AsmLine."No.";
        TempAssemblyLine.INSERT;
        NextLineNo := AsmLine."Line No.";
        FromBOMComp.FINDSET;
        REPEAT
            TempAssemblyLine.INIT;
            TempAssemblyLine."Document Type" := AsmLine."Document Type";
            TempAssemblyLine."Document No." := AsmLine."Document No.";
            NextLineNo := NextLineNo + LineSpacing;
            TempAssemblyLine."Line No." := NextLineNo;
            TempAssemblyLine.INSERT(TRUE);
            AddBOMLine2(AssemblyHeader, TempAssemblyLine, TRUE, FromBOMComp, FALSE);
            TempAssemblyLine.Quantity := TempAssemblyLine.Quantity * AsmLine."Quantity per" * AsmLine."Qty. per Unit of Measure";
            TempAssemblyLine."Quantity (Base)" := TempAssemblyLine."Quantity (Base)" * AsmLine."Quantity per" * AsmLine."Qty. per Unit of Measure";
            TempAssemblyLine."Quantity per" := TempAssemblyLine."Quantity per" * AsmLine."Quantity per" * AsmLine."Qty. per Unit of Measure";
            TempAssemblyLine."Remaining Quantity" := TempAssemblyLine."Remaining Quantity" * AsmLine."Quantity per" * AsmLine."Qty. per Unit of Measure";
            TempAssemblyLine."Remaining Quantity (Base)" := TempAssemblyLine."Remaining Quantity (Base)" * AsmLine."Quantity per" * AsmLine."Qty. per Unit of Measure";
            TempAssemblyLine."Quantity to Consume" := TempAssemblyLine."Quantity to Consume" * AsmLine."Quantity per" * AsmLine."Qty. per Unit of Measure";
            TempAssemblyLine."Quantity to Consume (Base)" := TempAssemblyLine."Quantity to Consume (Base)" * AsmLine."Quantity per" * AsmLine."Qty. per Unit of Measure";
            TempAssemblyLine."Cost Amount" := TempAssemblyLine."Unit Cost" * TempAssemblyLine.Quantity;
            TempAssemblyLine."Dimension Set ID" := AsmLine."Dimension Set ID";
            TempAssemblyLine."Shortcut Dimension 1 Code" := AsmLine."Shortcut Dimension 1 Code";
            TempAssemblyLine."Shortcut Dimension 2 Code" := AsmLine."Shortcut Dimension 2 Code";
            TempAssemblyLine.MODIFY(TRUE);
        UNTIL FromBOMComp.NEXT = 0;
        TempAssemblyLine.RESET;
        TempAssemblyLine.FINDSET;
        ToAssemblyLine := TempAssemblyLine;
        ToAssemblyLine.MODIFY;
        WHILE TempAssemblyLine.NEXT <> 0 DO BEGIN
            ToAssemblyLine := TempAssemblyLine;
            ToAssemblyLine.INSERT;
            IF ToAssemblyLine."Due Date" < WORKDATE THEN BEGIN
                DueDateBeforeWorkDate := TRUE;
                NewLineDueDate := ToAssemblyLine."Due Date";
            END;
        END;
        IF DueDateBeforeWorkDate THEN ShowDueDateBeforeWorkDateMsg(NewLineDueDate);
    end;

    procedure DeleteLines(AsmHeader: Record 900)
    var
        AssemblyLine: Record 901;
    begin
        SetLinkToLines(AsmHeader, AssemblyLine);
        IF AssemblyLine.FIND('-') THEN BEGIN
            //HandleItemTrackingDeletion;
            REPEAT
                AssemblyLine.SuspendStatusCheck(TRUE);
                AssemblyLine.DELETE(TRUE);
            UNTIL AssemblyLine.NEXT = 0;
        END;
    end;

    procedure UpdateWarningOnLines(AsmHeader: Record 900)
    var
        AssemblyLine: Record 901;
    begin
        SetLinkToLines(AsmHeader, AssemblyLine);
        IF AssemblyLine.FINDSET THEN
            REPEAT
                AssemblyLine.UpdateAvailWarning;
                AssemblyLine.MODIFY;
            UNTIL AssemblyLine.NEXT = 0;
    end;

    procedure UpdateAssemblyLines(var AsmHeader: Record 900; OldAsmHeader: Record 900; FieldNum: Integer; ReplaceLinesFromBOM: Boolean; CurrFieldNo: Integer; CurrentFieldNum: Integer)
    var
        AssemblyLine: Record 901;
        TempAssemblyHeader: Record 900 temporary;
        TempAssemblyLine: Record 901 temporary;
        BomComponent: Record 90;
        TempCurrAsmLine: Record 901 temporary;
        ItemCheckAvail: Codeunit 311;
        NoOfLinesFound: Integer;
        UpdateDueDate: Boolean;
        UpdateLocation: Boolean;
        UpdateQuantity: Boolean;
        UpdateUOM: Boolean;
        UpdateQtyToConsume: Boolean;
        UpdateDimension: Boolean;
        DueDateBeforeWorkDate: Boolean;
        NewLineDueDate: Date;
    begin
        IF (FieldNum <> CurrentFieldNum) OR // Update has been called from OnValidate of another field than was originally intended.
 ((NOT (FieldNum IN [AsmHeader.FIELDNO("Item No."), AsmHeader.FIELDNO("Variant Code"), AsmHeader.FIELDNO("Location Code"), AsmHeader.FIELDNO("Starting Date"), AsmHeader.FIELDNO(Quantity), AsmHeader.FIELDNO("Unit of Measure Code"), AsmHeader.FIELDNO("Quantity to Assemble"), AsmHeader.FIELDNO("Dimension Set ID")])) AND (NOT ReplaceLinesFromBOM)) THEN
            EXIT;
        NoOfLinesFound := CopyAssemblyData(AsmHeader, TempAssemblyHeader, TempAssemblyLine);
        IF ReplaceLinesFromBOM THEN BEGIN
            TempAssemblyLine.DELETEALL;
            IF NOT ((AsmHeader."Quantity (Base)" = 0) OR (AsmHeader."Item No." = '')) THEN BEGIN // condition to replace asm lines
                SetLinkToBOM(AsmHeader, BomComponent);
                IF BomComponent.FINDSET THEN
                    REPEAT
                        InsertAsmLine(AsmHeader, TempAssemblyLine, TRUE);
                        AddBOMLine2(AsmHeader, TempAssemblyLine, TRUE, BomComponent, FALSE);
                    UNTIL BomComponent.NEXT <= 0;
            END;
        END
        ELSE IF NoOfLinesFound = 0 THEN EXIT; // MODIFY condition but no lines to modify
        // make pre-checks OR ask user to confirm
        IF PreCheckAndConfirmUpdate(AsmHeader, OldAsmHeader, FieldNum, ReplaceLinesFromBOM, TempAssemblyLine, UpdateDueDate, UpdateLocation, UpdateQuantity, UpdateUOM, UpdateQtyToConsume, UpdateDimension) THEN EXIT;
        IF NOT ReplaceLinesFromBOM THEN
            IF TempAssemblyLine.FIND('-') THEN
                REPEAT
                    TempCurrAsmLine := TempAssemblyLine;
                    TempCurrAsmLine.INSERT;
                    TempAssemblyLine.SetSkipVerificationsThatChangeDatabase(TRUE);
                    UpdateExistingLine(AsmHeader, OldAsmHeader, CurrFieldNo, TempAssemblyLine, UpdateDueDate, UpdateLocation, UpdateQuantity, UpdateUOM, UpdateQtyToConsume, UpdateDimension);
                UNTIL TempAssemblyLine.NEXT = 0;
        IF NOT (FieldNum IN [AsmHeader.FIELDNO("Quantity to Assemble"), AsmHeader.FIELDNO("Dimension Set ID")]) THEN IF ShowAvailability(FALSE, TempAssemblyHeader, TempAssemblyLine) THEN ItemCheckAvail.RaiseUpdateInterruptedError;
        DoVerificationsSkippedEarlier(ReplaceLinesFromBOM, TempAssemblyLine, TempCurrAsmLine, UpdateDimension, AsmHeader."Dimension Set ID", OldAsmHeader."Dimension Set ID");
        AssemblyLine.RESET;
        IF ReplaceLinesFromBOM THEN BEGIN
            DeleteLines(AsmHeader);
            TempAssemblyLine.RESET;
        END;
        IF TempAssemblyLine.FIND('-') THEN
            REPEAT
                IF NOT ReplaceLinesFromBOM THEN AssemblyLine.GET(TempAssemblyLine."Document Type", TempAssemblyLine."Document No.", TempAssemblyLine."Line No.");
                AssemblyLine := TempAssemblyLine;
                IF ReplaceLinesFromBOM THEN
                    AssemblyLine.INSERT(TRUE)
                ELSE
                    AssemblyLine.MODIFY(TRUE);
                AsmHeader.AutoReserveAsmLine(AssemblyLine);
                IF AssemblyLine."Due Date" < WORKDATE THEN BEGIN
                    DueDateBeforeWorkDate := TRUE;
                    NewLineDueDate := AssemblyLine."Due Date";
                END;
            UNTIL TempAssemblyLine.NEXT = 0;
        IF ReplaceLinesFromBOM OR UpdateDueDate THEN IF DueDateBeforeWorkDate THEN ShowDueDateBeforeWorkDateMsg(NewLineDueDate);
        //-- #9627
        CLEAR(FuncionesVarias);
        FuncionesVarias.CreateAssamblyOrders(AsmHeader);
        //++ #9627
    end;

    local procedure PreCheckAndConfirmUpdate(AsmHeader: Record 900; OldAsmHeader: Record 900; FieldNum: Integer; var ReplaceLinesFromBOM: Boolean; var TempAssemblyLine: Record 901 temporary; var UpdateDueDate: Boolean; var UpdateLocation: Boolean; var UpdateQuantity: Boolean; var UpdateUOM: Boolean; var UpdateQtyToConsume: Boolean; var UpdateDimension: Boolean): Boolean
    begin
        UpdateDueDate := FALSE;
        UpdateLocation := FALSE;
        UpdateQuantity := FALSE;
        UpdateUOM := FALSE;
        UpdateQtyToConsume := FALSE;
        UpdateDimension := FALSE;
        CASE FieldNum OF
            AsmHeader.FIELDNO("Item No."):
                BEGIN
                    IF AsmHeader."Item No." <> OldAsmHeader."Item No." THEN IF LinesExist(AsmHeader) THEN IF GUIALLOWED THEN IF NOT CONFIRM(STRSUBSTNO(Text003, AsmHeader.FIELDCAPTION("Item No."), OldAsmHeader."Item No.", AsmHeader."Item No."), TRUE) THEN ERROR('');
                END;
            AsmHeader.FIELDNO("Variant Code"):
                UpdateDueDate := TRUE;
            AsmHeader.FIELDNO("Location Code"):
                BEGIN
                    UpdateDueDate := TRUE;
                    IF AsmHeader."Location Code" <> OldAsmHeader."Location Code" THEN BEGIN
                        TempAssemblyLine.SETRANGE(Type, TempAssemblyLine.Type::Item);
                        TempAssemblyLine.SETFILTER("Location Code", '<>%1', AsmHeader."Location Code");
                        IF NOT TempAssemblyLine.ISEMPTY THEN //-- #9627
                            IF SkipConfirmUpdate THEN
                                UpdateLocation := TRUE
                            ELSE BEGIN
                                /************************ TEXTO ORIGINAL ************************/
                                IF GUIALLOWED THEN IF CONFIRM(STRSUBSTNO(Text001, TempAssemblyLine.FIELDCAPTION("Location Code")), FALSE) THEN UpdateLocation := TRUE;
                                /********************** FIN TEXTO ORIGINAL **********************/
                            END;
                        //++ #9627
                        TempAssemblyLine.SETRANGE("Location Code");
                        TempAssemblyLine.SETRANGE(Type);
                    END;
                END;
            AsmHeader.FIELDNO("Starting Date"):
                UpdateDueDate := TRUE;
            AsmHeader.FIELDNO(Quantity):
                IF AsmHeader.Quantity <> OldAsmHeader.Quantity THEN BEGIN
                    UpdateQuantity := TRUE;
                    UpdateQtyToConsume := TRUE;
                END;
            AsmHeader.FIELDNO("Unit of Measure Code"):
                IF AsmHeader."Unit of Measure Code" <> OldAsmHeader."Unit of Measure Code" THEN
                    UpdateUOM := TRUE;
            AsmHeader.FIELDNO("Quantity to Assemble"):
                UpdateQtyToConsume := TRUE;
            AsmHeader.FIELDNO("Dimension Set ID"):
                IF AsmHeader."Dimension Set ID" <> OldAsmHeader."Dimension Set ID" THEN BEGIN
                    IF LinesExist(AsmHeader) THEN IF GUIALLOWED AND CONFIRM(STRSUBSTNO(Text002)) THEN UpdateDimension := TRUE;
                END;
            ELSE IF CalledFromRefreshBOM(ReplaceLinesFromBOM, FieldNum) THEN IF LinesExist(AsmHeader) THEN IF GUIALLOWED THEN IF NOT CONFIRM(Text004, FALSE) THEN ReplaceLinesFromBOM := FALSE;
        END;
        IF NOT (UpdateDueDate OR UpdateLocation OR UpdateQuantity OR UpdateUOM OR UpdateQtyToConsume OR UpdateDimension) AND // nothing to update
        NOT ReplaceLinesFromBOM THEN
            EXIT(TRUE);
    end;

    local procedure UpdateExistingLine(var AsmHeader: Record 900; OldAsmHeader: Record 900; CurrFieldNo: Integer; var AssemblyLine: Record 901; UpdateDueDate: Boolean; UpdateLocation: Boolean; UpdateQuantity: Boolean; UpdateUOM: Boolean; UpdateQtyToConsume: Boolean; UpdateDimension: Boolean)
    var
        QtyRatio: Decimal;
        QtyToConsume: Decimal;
    begin
        // FIX: Las líneas de comentario (Type = " ") solo actualizan fechas y ubicación
        // No tienen cantidad, por lo que UpdateQuantity y UpdateQtyToConsume deben ser FALSE
        IF AssemblyLine.Type = AssemblyLine.Type::" " THEN BEGIN
            UpdateQuantity := FALSE;
            UpdateQtyToConsume := FALSE;
        END;

        IF AsmHeader.IsStatusCheckSuspended THEN AssemblyLine.SuspendStatusCheck(TRUE);
        IF UpdateLocation THEN BEGIN
            IF AssemblyLine.Type = AssemblyLine.Type::Item THEN AssemblyLine.VALIDATE("Location Code", AsmHeader."Location Code");
        END;
        IF UpdateDueDate THEN BEGIN
            AssemblyLine.SetTestReservationDateConflict(CurrFieldNo <> 0);
            AssemblyLine.ValidateLeadTimeOffset(AsmHeader, AssemblyLine."Lead-Time Offset", FALSE);
        END;
        IF UpdateQuantity THEN BEGIN
            QtyRatio := AsmHeader.Quantity / OldAsmHeader.Quantity;
            // Inicio ADV001
            AssemblyLine.gfu_SetCantidadCabecera(AsmHeader.Quantity, AsmHeader."Quantity (Base)", AsmHeader."Remaining Quantity", AsmHeader."Remaining Quantity (Base)", AsmHeader."Quantity to Assemble", AsmHeader."Quantity to Assemble (Base)", TRUE);
            // Fin ADV001
            IF AssemblyLine.FixedUsage THEN
                AssemblyLine.VALIDATE(Quantity)
            ELSE
                //++ KR 04/11/21
                //AssemblyLine.VALIDATE(Quantity,AssemblyLine.Quantity * QtyRatio);
                AssemblyLine.VALIDATE(Quantity, AssemblyLine."Quantity per" * AsmHeader.Quantity);
            //--
            AssemblyLine.InitQtyToConsume;
        END;
        IF UpdateUOM THEN BEGIN
            QtyRatio := AsmHeader."Qty. per Unit of Measure" / OldAsmHeader."Qty. per Unit of Measure";
            IF AssemblyLine.FixedUsage THEN
                AssemblyLine.VALIDATE("Quantity per")
            ELSE
                AssemblyLine.VALIDATE("Quantity per", AssemblyLine."Quantity per" * QtyRatio);
            AssemblyLine.InitQtyToConsume;
        END;
        IF UpdateQtyToConsume THEN
            IF NOT AssemblyLine.FixedUsage THEN BEGIN
                AssemblyLine.InitQtyToConsume;
                QtyToConsume := AssemblyLine.Quantity * AsmHeader."Quantity to Assemble" / AsmHeader.Quantity;
                AsmHeader.RoundQty(QtyToConsume);
                //SL Error en la cantidad de Remaining
                AssemblyLine."Remaining Quantity" := AssemblyLine.Quantity - AssemblyLine."Consumed Quantity";
                AssemblyLine.VALIDATE("Quantity to Consume", QtyToConsume);
            END;
        IF UpdateDimension THEN AssemblyLine.UpdateDim(AsmHeader."Dimension Set ID", OldAsmHeader."Dimension Set ID");
        AssemblyLine.MODIFY(TRUE);
        // Inicio ADV001
        AssemblyLine.gfu_SetCantidadCabecera(AsmHeader.Quantity, AsmHeader."Quantity (Base)", AsmHeader."Remaining Quantity", AsmHeader."Remaining Quantity (Base)", AsmHeader."Quantity to Assemble", AsmHeader."Quantity to Assemble (Base)", FALSE);
        // Fin ADV001
    end;

    procedure ShowDueDateBeforeWorkDateMsg(ActualLineDueDate: Date)
    begin
        IF GUIALLOWED THEN IF GetWarningMode THEN MESSAGE(Text005, ActualLineDueDate, WORKDATE);
    end;

    procedure CopyAssemblyData(FromAssemblyHeader: Record 900; var ToAssemblyHeader: Record 900; var ToAssemblyLine: Record 901) NoOfLinesInserted: Integer
    var
        AssemblyLine: Record 901;
    begin
        ToAssemblyHeader := FromAssemblyHeader;
        ToAssemblyHeader.INSERT;
        SetLinkToLines(FromAssemblyHeader, AssemblyLine);
        // FIX: Incluir TODAS las líneas, no solo Item y Resource
        // Esto soluciona el problema de líneas añadidas manualmente que no se actualizan
        AssemblyLine.SETFILTER(Type, '%1|%2|%3', AssemblyLine.Type::" ", AssemblyLine.Type::Item, AssemblyLine.Type::Resource);
        ToAssemblyLine.RESET;
        ToAssemblyLine.DELETEALL;
        IF AssemblyLine.FIND('-') THEN
            REPEAT
                ToAssemblyLine := AssemblyLine;
                ToAssemblyLine.INSERT;
                NoOfLinesInserted += 1;
            UNTIL AssemblyLine.NEXT = 0;
    end;

    procedure ShowAvailability(ShowPageEvenIfEnoughComponentsAvailable: Boolean; var TmpAssemblyHeader: Record 900; var TempAssemblyLine: Record 901 temporary) Rollback: Boolean
    var
        Item: Record 27;
        TempAssemblyLine2: Record 901 temporary;
        AssemblySetup: Record 905;
        ItemCheckAvail: Codeunit 311;
        AssemblyAvailability: Page 908;
        Inventory: Decimal;
        GrossRequirement: Decimal;
        ReservedRequirement: Decimal;
        ScheduledReceipts: Decimal;
        ReservedReceipts: Decimal;
        EarliestAvailableDateX: Date;
        QtyAvailToMake: Decimal;
        QtyAvailTooLow: Boolean;
    begin
        AssemblySetup.GET;
        IF NOT GUIALLOWED OR TempAssemblyLine.ISEMPTY OR (NOT AssemblySetup."Stockout Warning" AND NOT ShowPageEvenIfEnoughComponentsAvailable) OR NOT GetWarningMode THEN EXIT(FALSE);
        TmpAssemblyHeader.TESTFIELD("Item No.");
        Item.GET(TmpAssemblyHeader."Item No.");
        ItemCheckAvail.AsmOrderCalculate(TmpAssemblyHeader, Inventory, GrossRequirement, ReservedRequirement, ScheduledReceipts, ReservedReceipts);
        TempAssemblyLine2.COPY(TempAssemblyLine, TRUE);
        AvailToPromise(TmpAssemblyHeader, TempAssemblyLine2, QtyAvailToMake, EarliestAvailableDateX);
        QtyAvailTooLow := QtyAvailToMake < TmpAssemblyHeader."Remaining Quantity";
        /* IF ShowPageEvenIfEnoughComponentsAvailable OR QtyAvailTooLow THEN BEGIN
                AssemblyAvailability.SetData(TmpAssemblyHeader, TempAssemblyLine);
                AssemblyAvailability.SetHeaderInventoryData(
                  Inventory, GrossRequirement, ReservedRequirement, ScheduledReceipts, ReservedReceipts,
                  EarliestAvailableDateX, QtyAvailToMake, QtyAvailTooLow);
                Rollback := NOT (AssemblyAvailability.RUNMODAL = ACTION::Yes);
            END; */
    end;

    local procedure DoVerificationsSkippedEarlier(ReplaceLinesFromBOM: Boolean; var TempNewAsmLine: Record 901 temporary; var TempOldAsmLine: Record 901 temporary; UpdateDimension: Boolean; NewHeaderSetID: Integer; OldHeaderSetID: Integer)
    begin
        IF TempNewAsmLine.FIND('-') THEN
            REPEAT
                TempNewAsmLine.SetSkipVerificationsThatChangeDatabase(FALSE);
                IF NOT ReplaceLinesFromBOM THEN TempOldAsmLine.GET(TempNewAsmLine."Document Type", TempNewAsmLine."Document No.", TempNewAsmLine."Line No.");
                TempNewAsmLine.VerifyReservationQuantity(TempNewAsmLine, TempOldAsmLine);
                TempNewAsmLine.VerifyReservationChange(TempNewAsmLine, TempOldAsmLine);
                TempNewAsmLine.VerifyReservationDateConflict(TempNewAsmLine);
                /*  IF ReplaceLinesFromBOM THEN
                     CASE TempNewAsmLine.Type OF
                         TempNewAsmLine.Type::Item:
                             TempNewAsmLine.CreateDim(DATABASE::Item,  NewHeaderSetID);
                         TempNewAsmLine.Type::Resource:
                             TempNewAsmLine.CreateDim(DATABASE::Resource, TempNewAsmLine."No.", NewHeaderSetID);
                     END
                 ELSE BEGIN
                     IF UpdateDimension THEN
                         TempNewAsmLine.UpdateDim(NewHeaderSetID, OldHeaderSetID);
                 END; */
                TempNewAsmLine.MODIFY;
            UNTIL TempNewAsmLine.NEXT = 0;
    end;

    local procedure AvailToPromise(AsmHeader: Record 900; var AssemblyLine: Record 901; var OrderAbleToAssemble: Decimal; var EarliestDueDate: Date)
    var
        LineAvailabilityDate: Date;
        LineStartingDate: Date;
        EarliestStartingDate: Date;
        LineAbleToAssemble: Decimal;
    begin
        SetLinkToItemLines(AsmHeader, AssemblyLine);
        AssemblyLine.SETFILTER("No.", '<>%1', '');
        AssemblyLine.SETFILTER("Quantity per", '<>%1', 0);
        OrderAbleToAssemble := AsmHeader."Remaining Quantity";
        IF AssemblyLine.FINDSET THEN
            REPEAT
                LineAbleToAssemble := CalcAvailToAssemble(AssemblyLine, AsmHeader, LineAvailabilityDate);
                IF LineAbleToAssemble < OrderAbleToAssemble THEN OrderAbleToAssemble := LineAbleToAssemble;
                IF LineAvailabilityDate > 0D THEN BEGIN
                    LineStartingDate := CALCDATE(AssemblyLine."Lead-Time Offset", LineAvailabilityDate);
                    IF LineStartingDate > EarliestStartingDate THEN EarliestStartingDate := LineStartingDate; // latest of all line starting dates
                END;
            UNTIL AssemblyLine.NEXT = 0;
        //EarliestDueDate := CalcEarliestDueDate(AsmHeader, EarliestStartingDate);
    end;

    local procedure CalcAvailToAssemble(AssemblyLine: Record 901; AsmHeader: Record 900; var LineAvailabilityDate: Date) LineAbleToAssemble: Decimal
    var
        Item: Record 27;
        GrossRequirement: Decimal;
        ScheduledRcpt: Decimal;
        ExpectedInventory: Decimal;
        LineInventory: Decimal;
    begin
        AssemblyLine.CalcAvailToAssemble(AsmHeader, Item, GrossRequirement, ScheduledRcpt, ExpectedInventory, LineInventory, LineAvailabilityDate, LineAbleToAssemble);
    end;
    /* local procedure CalcEarliestDueDate(AsmHeader: Record 900; EarliestStartingDate: Date) EarliestDueDate: Date
    var
        ReqLine: Record "246";
        LeadTimeMgt: Codeunit "5404";
        EarliestEndingDate: Date;
    begin
        WITH AsmHeader DO BEGIN
            EarliestDueDate := 0D;
            IF EarliestStartingDate > 0D THEN BEGIN
                EarliestEndingDate := // earliest starting date + lead time calculation
                  LeadTimeMgt.PlannedEndingDate2("Item No.", "Location Code", "Variant Code",
                    '', LeadTimeMgt.ManufacturingLeadTime("Item No.", "Location Code", "Variant Code"),
                    ReqLine."Ref. Order Type"::Assembly, EarliestStartingDate);
                EarliestDueDate := // earliest ending date + (default) safety lead time
                  LeadTimeMgt.PlannedDueDate("Item No.", "Location Code", "Variant Code",
                    EarliestEndingDate, '', ReqLine."Ref. Order Type"::Assembly);
            END;
        END;
    end; */
    procedure CompletelyPicked(AsmHeader: Record 900): Boolean
    var
        AssemblyLine: Record 901;
    begin
        SetLinkToItemLines(AsmHeader, AssemblyLine);
        IF AssemblyLine.FIND('-') THEN
            REPEAT
                IF NOT AssemblyLine.CompletelyPicked THEN EXIT(FALSE);
            UNTIL AssemblyLine.NEXT = 0;
        EXIT(TRUE);
    end;

    procedure SetWarningsOff()
    begin
        WarningModeOff := TRUE;
    end;

    local procedure GetWarningMode(): Boolean
    begin
        EXIT(NOT WarningModeOff);
    end;

    local procedure CalledFromRefreshBOM(ReplaceLinesFromBOM: Boolean; FieldNum: Integer): Boolean
    begin
        EXIT(ReplaceLinesFromBOM AND (FieldNum = 0));
    end;
    /*  procedure CreateWhseItemTrkgForAsmLines(AsmHeader: Record 900)
     var
         AssemblyLine: Record 901;
         WhseWkshLine: Record "7326";
         ItemTrackingMgt: Codeunit "6500";
         WhseSNRequired: Boolean;
         WhseLNRequired: Boolean;
     begin
         WITH AssemblyLine DO BEGIN
             SetLinkToItemLines(AsmHeader, AssemblyLine);
             IF FINDSET THEN
                 REPEAT
                     ItemTrackingMgt.CheckWhseItemTrkgSetup("No.", WhseSNRequired, WhseLNRequired, FALSE);
                     IF WhseSNRequired OR WhseLNRequired THEN
                         ItemTrackingMgt.InitItemTrkgForTempWkshLine(
                           WhseWkshLine."Whse. Document Type"::Assembly,
                           "Document No.",
                           "Line No.",
                           DATABASE::"Assembly Line",
                           "Document Type",
                           "Document No.",
                           "Line No.",
                           0);
                 UNTIL NEXT = 0;
         END;
     end; */
    procedure SkipPreCheckAndConfirmUpdate(SkipConfirmUpdateLocal: Boolean)
    begin
        //-- #9627
        SkipConfirmUpdate := SkipConfirmUpdateLocal;
        //++ #9627
    end;

    procedure AddBOMLineEventos(AsmHeader: Record 900; var AssemblyLine: Record 901; BomComponent: Record 50014)
    begin
        InsertAsmLine(AsmHeader, AssemblyLine, FALSE);
        AddBOMLine2Eventos(AsmHeader, AssemblyLine, FALSE, BomComponent, false);
    end;

    local procedure AddBOMLine2Eventos(AsmHeader: Record 900; var AssemblyLine: Record 901; AsmLineRecordIsTemporary: Boolean; BomComponent: Record 50014; ShowDueDateBeforeWorkDateMessage: Boolean)
    var
        DueDateBeforeWorkDateMsgShown: Boolean;
        SkipVerificationsThatChangeDatabase: Boolean;
        Item: Record 27;
    begin
        SkipVerificationsThatChangeDatabase := AsmLineRecordIsTemporary;
        AssemblyLine.SetSkipVerificationsThatChangeDatabase(SkipVerificationsThatChangeDatabase);
        AssemblyLine.VALIDATE(Type, BomComponent.Type);
        // Inicio ADV001
        AssemblyLine.gfu_SetCantidadCabecera(AsmHeader.Quantity, AsmHeader."Quantity (Base)", AsmHeader."Remaining Quantity", AsmHeader."Remaining Quantity (Base)", AsmHeader."Quantity to Assemble", AsmHeader."Quantity to Assemble (Base)", TRUE);
        // Fin ADV001
        AssemblyLine.VALIDATE("No.", BomComponent."No.");
        AssemblyLine.Position := BomComponent.Position;
        AssemblyLine."Position 2" := BomComponent."Position 2";
        AssemblyLine."Position 3" := BomComponent."Position 3";
        IF AssemblyLine.Type = AssemblyLine.Type::Resource THEN
            CASE BomComponent."Resource Usage Type" OF
                BomComponent."Resource Usage Type"::Direct:
                    AssemblyLine.VALIDATE("Resource Usage Type", AssemblyLine."Resource Usage Type"::Direct);
                BomComponent."Resource Usage Type"::Fixed:
                    AssemblyLine.VALIDATE("Resource Usage Type", AssemblyLine."Resource Usage Type"::Fixed);
            END;
        AssemblyLine.VALIDATE("Unit of Measure Code", BomComponent."Unit of Measure Code");
        IF AssemblyLine.Type <> AssemblyLine.Type::" " THEN AssemblyLine.VALIDATE("Quantity per", AssemblyLine.CalcQuantityFromBOM(BomComponent.Type, BomComponent."Quantity per", 1, AsmHeader."Qty. per Unit of Measure", AssemblyLine."Resource Usage Type"));
        AssemblyLine.VALIDATE(Quantity, AssemblyLine.CalcQuantityFromBOM(BomComponent.Type, BomComponent."Quantity per", AsmHeader.Quantity, AsmHeader."Qty. per Unit of Measure", AssemblyLine."Resource Usage Type"));
        AssemblyLine.VALIDATE("Quantity to Consume", AssemblyLine.CalcQuantityFromBOM(BomComponent.Type, BomComponent."Quantity per", AsmHeader."Quantity to Assemble", AsmHeader."Qty. per Unit of Measure", AssemblyLine."Resource Usage Type"));
        AssemblyLine.ValidateDueDate(AsmHeader, AsmHeader."Starting Date", ShowDueDateBeforeWorkDateMessage);
        DueDateBeforeWorkDateMsgShown := (AssemblyLine."Due Date" < WORKDATE) AND ShowDueDateBeforeWorkDateMessage;
        AssemblyLine.ValidateLeadTimeOffset(AsmHeader, BomComponent."Lead-Time Offset", NOT DueDateBeforeWorkDateMsgShown AND ShowDueDateBeforeWorkDateMessage);
        AssemblyLine.Description := BomComponent.Description;
        AssemblyLine."Description 2" := AsmHeader."Description 2";
        IF AssemblyLine.Type = AssemblyLine.Type::Item THEN AssemblyLine.VALIDATE("Variant Code", BomComponent."Variant Code");
        IF AsmHeader."Location Code" <> '' THEN IF AssemblyLine.Type = AssemblyLine.Type::Item THEN AssemblyLine.VALIDATE("Location Code", AsmHeader."Location Code");
        //-- #9785
        AssemblyLine.VALIDATE("Related Work Center", BomComponent."Related Work Center");
        //++ #9785
        //-- #9969
        AssemblyLine.VALIDATE("Perc. Loss", 0);
        IF Item.GET(AssemblyLine."No.") THEN AssemblyLine.VALIDATE("Perc. Loss", Item."Perc. Loss");
        //++ #9969
        //-- #9993
        AssemblyLine.VALIDATE("Cantidad por Lote", BomComponent."Cantidad por Lote");
        //-- #9993
        AssemblyLine.MODIFY(TRUE);
        // Inicio ADV001
        AssemblyLine.gfu_SetCantidadCabecera(AsmHeader.Quantity, AsmHeader."Quantity (Base)", AsmHeader."Remaining Quantity", AsmHeader."Remaining Quantity (Base)", AsmHeader."Quantity to Assemble", AsmHeader."Quantity to Assemble (Base)", FALSE);
        // Fin ADV001
    end;

    procedure ValidateAllLinesUpdated(AsmHeader: Record 900): Boolean
    var
        AssemblyLine: Record 901;
        ExpectedQty: Decimal;
    begin
        // FIX: Valida que todas las líneas tienen Quantity consistente con la cantidad de cabecera
        // Esto ayuda a detectar si alguna línea no se actualizó correctamente
        AssemblyLine.SETRANGE("Document Type", AsmHeader."Document Type");
        AssemblyLine.SETRANGE("Document No.", AsmHeader."No.");
        AssemblyLine.SETFILTER(Type, '%1|%2', AssemblyLine.Type::Item, AssemblyLine.Type::Resource);
        AssemblyLine.SETFILTER("Quantity per", '<>0');

        IF AssemblyLine.FINDSET THEN
            REPEAT
                IF NOT AssemblyLine.FixedUsage THEN BEGIN
                    ExpectedQty := AssemblyLine."Quantity per" * AsmHeader.Quantity;
                    AsmHeader.RoundQty(ExpectedQty);
                    // Permitir pequeña diferencia por redondeo
                    IF ABS(AssemblyLine.Quantity - ExpectedQty) > 0.01 THEN
                        EXIT(FALSE);
                END;
            UNTIL AssemblyLine.NEXT = 0;

        EXIT(TRUE);
    end;
}
