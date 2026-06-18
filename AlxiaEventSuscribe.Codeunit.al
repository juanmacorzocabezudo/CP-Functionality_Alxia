codeunit 50005 AlxiaEventSuscribe
{
    Permissions = TableData 32 = rm;

    var
        Text10000: Label 'No puede marcarse Autoconsumo en Ensamblados para pedido.';
        Text20000: Label 'No se puede registrar una receta en simulación';

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Assembly-Post", 'OnBeforeOnRun', '', true, true)]
    local procedure AlxiaOnBeforeOnRun(var AssemblyHeader: Record "Assembly Header"; SuppressCommit: Boolean)
    var
        FuncionesVarias: Codeunit FuncionesVarias;
    begin
        //ADV001 Inicio
        AssemblyHeader.CALCFIELDS("Assemble to Order");
        IF AssemblyHeader.Autoconsumo AND (AssemblyHeader."Assemble to Order") THEN ERROR(Text10000);
        IF AssemblyHeader.Simulacion THEN ERROR(Text20000);
        //ADV001 Fin
        //-- #9627
        CLEAR(FuncionesVarias);
        FuncionesVarias.PostAllAssocietedDocs(AssemblyHeader);
        //++ #9627
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Assembly-Post", 'OnAfterPost', '', true, true)]
    local procedure AlxOnAfterPost(var AssemblyHeader: Record "Assembly Header"; var AssemblyLine: Record "Assembly Line"; PostedAssemblyHeader: Record "Posted Assembly Header"; var ItemJnlPostLine: Codeunit "Item Jnl.-Post Line"; var ResJnlPostLine: Codeunit "Res. Jnl.-Post Line"; var WhseJnlRegisterLine: Codeunit "Whse. Jnl.-Register Line")
    var
        Func: Codeunit AlxiaFuncionesImportadas;
    begin
        IF (AssemblyHeader."Document Type" = AssemblyHeader."Document Type"::Order) AND (AssemblyHeader.Autoconsumo) THEN Func.lfu_Autoconsumo(PostedAssemblyHeader, AssemblyHeader."Posting No. Series", PostedAssemblyHeader."Source Code", PostedAssemblyHeader."Posting Date");
    end;

    [EventSubscriber(ObjectType::Table, database::"Assembly Header", 'OnValidateItemNoOnBeforeValidateDates', '', true, true)]
    local procedure AlxOnValidateItemNoOnBeforeValidateDates(var AssemblyHeader: Record "Assembly Header"; xAssemblyHeader: Record "Assembly Header"; var IsHandled: Boolean)
    var
        Item: Record Item;
    begin
        Item.reset;
        Item.SetRange("No.", AssemblyHeader."Item No.");
        Item.FindSet();
        AssemblyHeader.VALIDATE("Unit of Measure Code", Item."Base Unit of Measure");
        AssemblyHeader.VALIDATE("Perc. Loss", Item."Perc. Loss"); //** #9969
        AssemblyHeader.VALIDATE("Lot Quantity", Item."Lote Receta"); //** #9993
        //-- #9993
        IF Item."Status LM" <> Item."Status LM"::Certificated THEN ERROR('La receta del producto %1 no esta certificada', Item."No.");
        //++ #9993
    end;

    [EventSubscriber(ObjectType::Table, database::"Assembly Header", 'onAfterValidateEvent', 'Item No.', false, false)]
    local procedure AlxiOnAfterValidateItem(var Rec: Record "Assembly Header")
    var
        cFuncionesVarias: Codeunit FuncionesVarias;
    begin
        CLEAR(cFuncionesVarias);
        cFuncionesVarias.CreateAssamblyOrders(Rec);
    end;
    // ADVANCE - Log de cambios
    // -----------------------------------------------------
    //   ADVANCE
    //   Fecha: 31-05-2016
    //   Técnico: JMAP
    //   Presupuesto: Proyecto I002670 - Cálculo de comisiones
    //   Modificación:
    //   Etiqueta: ADV001
    // -----------------------------------------------------
    //   ADVANCE
    //   Fecha: 21-11-2016
    //   Técnico: JMAP
    //   Presupuesto: Proyecto I003509 - Nuevos Campos en pedidos de compra
    //   Etiqueta: ADV002
    // -----------------------------------------------------
    // #11552 - Se traspasa el codigo a la tabla para no tener problemas con la actualizacion de objetos
    [EventSubscriber(ObjectType::Table, 36, 'OnCheckSalesPostRestrictions', '', false, false)]
    local procedure gfu_SalesHeader_OnCheckSalesPostRestrictions(var Sender: Record 36)
    begin
        Sender.TESTFIELD("VAT Registration No.");
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterPostSalesDoc', '', false, false)]
    local procedure gfu_cu80_OnAfterPostSalesDoc(var SalesHeader: Record 36; var GenJnlPostLine: Codeunit 12; SalesShptHdrNo: Code[20]; RetRcpHdrNo: Code[20]; SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20])
    var
        cu_GestionComisiones: Codeunit 50001;
    begin
        //ADV001 Inicio
        IF (SalesShptHdrNo <> '') OR (RetRcpHdrNo <> '') THEN cu_GestionComisiones.gfu_GeneraComisionVenta(SalesShptHdrNo, RetRcpHdrNo);
        //ADV001 Fin
    end;

    [EventSubscriber(ObjectType::Table, 38, 'OnCheckPurchasePostRestrictions', '', false, false)]
    local procedure gfu_PurchHeader_OnCheckPurchasePostRestrictions(var Sender: Record 38)
    var
        lt_PurchLine: Record 39;
    begin
        //ADV002 Inicio
        IF Sender."Document Type" = Sender."Document Type"::Order THEN BEGIN
            Sender.TESTFIELD(PersonaRecibe);
            lt_PurchLine.RESET;
            lt_PurchLine.SETRANGE("Document Type", Sender."Document Type");
            lt_PurchLine.SETRANGE("Document No.", Sender."No.");
            lt_PurchLine.SETRANGE(Type, lt_PurchLine.Type::Item);
            lt_PurchLine.SETFILTER("Qty. to Receive", '<>0');
            IF lt_PurchLine.FINDSET THEN
                REPEAT
                    lt_PurchLine.TESTFIELD(TemperaturaRecepcion);
                    lt_PurchLine.TESTFIELD(AspectoCorrecto);
                    lt_PurchLine.TESTFIELD(HigieneTranspCorrecta);
                UNTIL lt_PurchLine.NEXT = 0;
        END;
        //ADV002 Fin
    end;

    [EventSubscriber(ObjectType::Codeunit, 22, 'OnAfterInsertItemLedgEntry', '', false, false)]
    local procedure gfu_cu22_OnAfterInsertItemLedgEntry(var ItemLedgerEntry: Record 32; ItemJournalLine: Record 83)
    begin
        //ADV002 Inicio
        ItemLedgerEntry.PersonaRecibe := ItemJournalLine.PersonaRecibe;
        ItemLedgerEntry.TemperaturaRecepcion := ItemJournalLine.TemperaturaRecepcion;
        ItemLedgerEntry.AspectoCorrecto := ItemJournalLine.AspectoCorrecto;
        ItemLedgerEntry.HigieneTranspCorrecta := ItemJournalLine.HigieneTranspCorrecta;
        ItemLedgerEntry.Observaciones := ItemJournalLine.Observaciones;
        ItemLedgerEntry.MODIFY;
        //ADV002 Fin
    end;

    [EventSubscriber(ObjectType::Table, 900, 'OnAfterValidateEvent', 'Quantity', false, false)]
    procedure T900_OnAfterValidate_Quantity(var Rec: Record 900; var xRec: Record 900; CurrFieldNo: Integer)
    begin
        //-- #11552
        /*
            IF (Rec."Cantidad Original" = 0) AND (Rec.Quantity <> 0) THEN
              Rec."Cantidad Original" := Rec.Quantity;

            Rec.Diferencia := Rec.Quantity - Rec."Cantidad Original";

            Rec."Diferencia%" := 0;
            IF Rec."Cantidad Original" <> 0 THEN
              Rec."Diferencia%" := Rec.Diferencia / Rec."Cantidad Original" * 100;
            */
        //++ #11552
    end;

    [EventSubscriber(ObjectType::Table, 901, 'OnAfterValidateEvent', 'Quantity', false, false)]
    procedure T901_OnAfterValidate_Quantity(var Rec: Record 901; var xRec: Record 901; CurrFieldNo: Integer)
    begin
        //-- #11552
        /*
            IF (Rec."Cantidad Original" = 0) AND (Rec.Quantity <> 0) THEN
              Rec."Cantidad Original" := Rec.Quantity;

            Rec.Diferencia := Rec.Quantity - Rec."Cantidad Original";

            Rec."Diferencia%" := 0;
            IF Rec."Cantidad Original" <> 0 THEN
              Rec."Diferencia%" := Rec.Diferencia / Rec."Cantidad Original" * 100;
            */
        //++ #11552
    end;

    [EventSubscriber(ObjectType::Table, 901, 'OnAfterValidateEvent', 'Quantity', false, false)]
    procedure T901_OnAfterValidate_QuantityPer(var Rec: Record 901; var xRec: Record 901; CurrFieldNo: Integer)
    begin
        //-- #11552
        /*
            IF (Rec."Cantidad Por Original" = 0) AND (Rec."Quantity per" <> 0) THEN
              Rec."Cantidad Por Original" := Rec."Quantity per";
            */
        //++ #11552
    end;

    [EventSubscriber(ObjectType::Table, 901, 'OnBeforeDeleteEvent', '', false, false)]
    procedure T901_OnBeforeDeleteEvent(var Rec: Record 901; RunTrigger: Boolean)
    var
        AssemblyHeader: Record 900;
        AssemblyLine: Record 901;
    begin
        // Buscamos ensamblados en cascada y los borramos si no están bloqueados
        IF Rec.ISTEMPORARY THEN EXIT;
        AssemblyHeader.RESET;
        AssemblyHeader.SETRANGE(AssemblyHeader."Document Type", Rec."Document Type");
        AssemblyHeader.SETRANGE(AssemblyHeader."Associated Order", TRUE);
        AssemblyHeader.SETRANGE(AssemblyHeader."Associated Order No.", Rec."Document No.");
        AssemblyHeader.SETRANGE(AssemblyHeader."Associated Order Line", Rec."Line No.");
        IF NOT AssemblyHeader.FINDFIRST THEN EXIT;
        IF AssemblyHeader."Associated Blocked" THEN BEGIN
            ERROR('Atención este borrado generaría el borrado del ensamblado %1 que está bloqueado. Desbloqueelo primero.', AssemblyHeader."No.");
        END;
        AssemblyHeader.DELETE(TRUE);
        // JMC 17-06-2026 Eliminamos el mensaje para que no aparezca en cascada al cambiar el estado del evento.
        //MESSAGE('Se ha borrado el ensamblado %1 ya que dependía del ensamblado %2', AssemblyHeader."No.", Rec."Document No.");
        /*
            IF AssemblyHeader.FINDFIRST THEN
            BEGIN
              AssemblyLine.RESET;
              AssemblyLine.SETRANGE(AssemblyLine."Document Type", AssemblyHeader."Document Type");
              AssemblyLine.SETRANGE(AssemblyLine."Document No.", AssemblyHeader."No.");
              IF AssemblyLine.FINDFIRST THEN
              RePEAT

              UNTIL AssemblyLine.NEXT = 0;
            END;
            */
    end;

    [EventSubscriber(ObjectType::Table, 90, 'OnAfterModifyEvent', '', false, false)]
    procedure T90_OnAfterModifyEvent(var Rec: Record 90; var xRec: Record 90; RunTrigger: Boolean)
    begin
        /*
            IF Rec.ISTEMPORARY THEN
              EXIT;

            Rec.ActualizarImportanciaEnCoste;
            */
    end;

    [EventSubscriber(ObjectType::Codeunit, 905, 'OnAddBOMLineOnAfterValidatedNo', '', false, false)]
    local procedure AlxOnAddBOMLineOnAfterValidatedNo(AssemblyHeader: Record "Assembly Header"; var AssemblyLine: Record "Assembly Line"; BOMComponent: Record "BOM Component")
    begin
        // Inicio ADV001
        AssemblyLine.gfu_SetCantidadCabecera(AssemblyHeader.Quantity, AssemblyHeader."Quantity (Base)", AssemblyHeader."Remaining Quantity", AssemblyHeader."Remaining Quantity (Base)", AssemblyHeader."Quantity to Assemble", AssemblyHeader."Quantity to Assemble (Base)", TRUE);
        // Fin ADV001
    end;

    [EventSubscriber(ObjectType::Codeunit, 905, 'OnAfterTransferBOMComponent', '', false, false)]
    local procedure AlxOnAfterTransferBOMComponent(var AssemblyLine: Record "Assembly Line"; BOMComponent: Record "BOM Component"; AssemblyHeader: Record "Assembly Header")
    begin
        //-- #9785
        AssemblyLine.VALIDATE("Related Work Center", BomComponent."Related Work Center");
        //++ #9785
        //-- #9969
        AssemblyLine.VALIDATE("Perc. Loss", BomComponent."Perc. Loss");
        //++ #9969
        //-- #9993
        AssemblyLine.VALIDATE("Cantidad por Lote", BomComponent."Cantidad por Lote");
        //-- #9993
        //AssemblyLine.MODIFY(TRUE);
        // Inicio ADV001
        AssemblyLine.gfu_SetCantidadCabecera(AssemblyHeader.Quantity, AssemblyHeader."Quantity (Base)", AssemblyHeader."Remaining Quantity", AssemblyHeader."Remaining Quantity (Base)", AssemblyHeader."Quantity to Assemble", AssemblyHeader."Quantity to Assemble (Base)", FALSE);
        // Fin ADV001
    end;

    [EventSubscriber(ObjectType::Table, 901, 'OnBeforeValidateDueDate', '', false, false)]
    local procedure AlxOnBeforeValidateDueDate(var AsmLine: Record "Assembly Line"; AsmHeader: Record "Assembly Header"; NewDueDate: Date; var ShowDueDateBeforeWorkDateMsg: Boolean)
    begin
        ShowDueDateBeforeWorkDateMsg := false;
    end;

    [EventSubscriber(ObjectType::Table, 900, 'OnBeforeValidateQuantity', '', false, false)]
    local procedure AlxOnBeforeValidateQuantity(var AssemblyHeader: Record "Assembly Header"; var xAssemblyHeader: Record "Assembly Header"; FieldNumber: Integer; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, 900, 'OnBeforeValidateQuantityBase', '', false, false)]
    local procedure AlxOnBeforeValidateQuantityBase(var AssemblyHeader: Record "Assembly Header"; var xAssemblyHeader: Record "Assembly Header"; FieldNumber: Integer; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;
    //SL Bloqueo por cantidad base
    [EventSubscriber(ObjectType::Table, 336, 'OnBeforeTestFieldError', '', false, false)]
    local procedure AlxOnBeforeTestFieldError(FieldCaptionText: Text[80]; CurrFieldValue: Decimal; CompareValue: Decimal; var IsHandled: Boolean)
    begin
        //IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Assembly-Post", 'OnAfterCreateItemJnlLineFromAssemblyLine', '', true, true)]
    local procedure AlxOnAfterCreateItemJnlLineFromAssemblyLine(var ItemJournalLine: Record "Item Journal Line"; AssemblyLine: Record "Assembly Line")
    begin
        ItemJournalLine."Related Work Center" := ItemJournalLine."Related Work Center"; //** #9785
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnInsertItemLedgEntryOnBeforeVerifyOnInventory', '', true, true)]
    local procedure AlxOnInsertItemLedgEntryOnBeforeVerifyOnInventory(ItemJnlLine: Record "Item Journal Line"; ItemLedgEntry: Record "Item Ledger Entry"; var IsHandled: Boolean)
    begin
        //IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, 36, 'OnBeforeValidateShipmentDate', '', false, false)]
    local procedure OnBeforeValidateShipmentDate(var SalesHeader: Record "Sales Header"; CurrentFieldNo: Integer; var IsHandled: Boolean)
    begin
        SalesHeader."Fecha Servicio" := SalesHeader."Shipment Date";
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforePostSalesDoc', '', false, false)]
    local procedure AlxOnBeforePostSalesDoc(var SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; PreviewMode: Boolean; var HideProgressWindow: Boolean; var IsHandled: Boolean; var CalledBy: Integer)
    var
        rSRS: Record "Sales & Receivables Setup";
        TotalSalesLine: Record "Sales Line";
        DocumentTotals: Codeunit "Document Totals";
        ImportePedido: Decimal;
        VATAmount: Decimal;
        InvoiceDiscountAmount: Decimal;
        InvoiceDiscountPct: Decimal;
    begin
        rSRS.GET;
        if not rSRS."Dimension Obligatoria" then begin
            SalesHeader.TestField("Shortcut Dimension 1 Code");
        end;
        //SL Validacion GAP00032 
        if SalesHeader."Importe Rechazado" <> 0 then begin
            DocumentTotals.CalculateSalesSubPageTotals(SalesHeader, TotalSalesLine, VATAmount, InvoiceDiscountAmount, InvoiceDiscountPct);
            ImportePedido := TotalSalesLine."Line Amount";
            if ImportePedido <> SalesHeader."Importe Contratado" then begin
                if not Confirm('El importe contratado no coincide con el importe del pedido, desea continuar?') then Error('El importe contratado no coincide con el importe del pedido');
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 64, 'OnRunAfterFilterSalesShpLine', '', false, false)]
    local procedure AlxOnRunAfterFilterSalesShpLine(var SalesShptLine: Record "Sales Shipment Line"; SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    begin
        SalesShptLine.SetRange(NoShow, false);
    end;

    [EventSubscriber(ObjectType::Table, 36, 'OnBeforeSendToPosting', '', false, false)]
    local procedure OnBeforeSendToPosting(var SalesHeader: Record "Sales Header"; var IsSuccess: Boolean; var IsHandled: Boolean; PostingCodeunitID: Integer)
    var
        rSRS: Record "Sales & Receivables Setup";
    begin
        rSRS.GET;
        if not rSRS."Dimension Obligatoria" then begin
            SalesHeader.TestField("Fecha Servicio");
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 90, 'OnRunOnBeforePostInvoice', '', false, false)]
    local procedure c90_OnRunOnBeforePostInvoice(PurchaseHeader: Record "Purchase Header"; var EverythingInvoiced: Boolean)
    var
        rPurchaseLine: Record "Purchase Line";
        rItemReference: Record "Item Reference";
    begin
        rPurchaseLine.SetRange("Document Type", rPurchaseLine."Document Type"::Invoice);
        rPurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
        rPurchaseLine.SetRange(Type, rPurchaseLine.Type::Item);
        if rPurchaseLine.FindFirst() then begin
            repeat
                rItemReference.Reset();
                rItemReference.SetRange("Reference Type", rItemReference."Reference Type"::Vendor);
                rItemReference.SetRange("Reference Type No.", PurchaseHeader."Buy-from Vendor No.");
                rItemReference.SetRange("Item No.", rPurchaseLine."No.");
                rItemReference.SetRange("Variant Code", rPurchaseLine."Variant Code");
                rItemReference.SetRange("Unit of Measure", rPurchaseLine."Unit of Measure Code");
                if not rItemReference.FindFirst() then begin
                    rItemReference."Reference Type" := rItemReference."Reference Type"::Vendor;
                    rItemReference."Reference Type No." := PurchaseHeader."Buy-from Vendor No.";
                    rItemReference."Item No." := rPurchaseLine."No.";
                    rItemReference."Variant Code" := rPurchaseLine."Variant Code";
                    rItemReference."Unit of Measure" := rPurchaseLine."Unit of Measure Code";
                    rItemReference.Insert();
                end;
            until rPurchaseLine.Next() = 0;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Assembly Line Management", 'OnAfterTransferBOMComponent', '', false, false)]
    local procedure OnAfterTransferBOMComponent(var AssemblyLine: Record "Assembly Line"; BOMComponent: Record "BOM Component"; AssemblyHeader: Record "Assembly Header")
    var
        rItem: Record Item;
        rResource: Record "Resource";
        rConfVentas: Record "Sales & Receivables Setup";
    begin
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
    end;
    //SL >>> GAP00054
    [EventSubscriber(ObjectType::Table, 77, 'OnBeforeSaveReportAsPDF', '', false, false)]
    local procedure OnBeforeSaveReportAsPDF(var ReportID: Integer; RecordVariant: Variant; var LayoutCode: Code[20]; var IsHandled: Boolean; FilePath: Text[250]; ReportUsage: Enum "Report Selection Usage"; SaveToBlob: Boolean; var TempBlob: Codeunit "Temp Blob"; var ReportSelections: Record "Report Selections")
    var
        rSalesInvoice: Record "Sales Invoice Header";
        LineasEvento: Record "Lineas Evento";
        RecVariant: Variant;
        OutStream: OutStream;
        RepCapitulo: Report 50012;
        RepCapituloDtl: Report 50013;
        RepImpresionDetallada: Report 50062;
        RepGenerica: Report 50062;
    begin
        if ReportID = 50062 then begin
            rSalesInvoice := RecordVariant;
            if not LineasEvento.Get(rSalesInvoice.NoEvento) then Clear(LineasEvento);
            if rSalesInvoice.NoEvento <> '' then begin
                if rSalesInvoice."Shortcut Dimension 1 Code" = 'CATERING' then begin
                    case rSalesInvoice."Tipo de Impresión" of
                        rSalesInvoice."Tipo de Impresión"::"Impresion por Capitulo":
                            begin
                                // Imprimir impresión por capítulo. 50012
                                IsHandled := true;
                                TempBlob.CreateOutStream(OutStream);
                                RepCapitulo.ConfigurarFiltros(rSalesInvoice."No.", rSalesInvoice.NoEvento, rSalesInvoice."No Impresion Comentarios");
                                if LineasEvento.FindFirst() then begin
                                    RecVariant := LineasEvento;
                                    RepCapitulo.SaveAs('', ReportFormat::Pdf, OutStream, GetRecRef(RecVariant));
                                end
                                else
                                    RepCapitulo.SaveAs('', ReportFormat::Pdf, OutStream, GetRecRef(RecordVariant));
                            end;
                        rSalesInvoice."Tipo de Impresión"::"Imp. por Capitulo Dtl.":
                            begin
                                // Imprimir impresión por capítulo detallado. 50013
                                IsHandled := true;
                                TempBlob.CreateOutStream(OutStream);
                                RepCapituloDtl.ConfigurarFiltros(rSalesInvoice."No.", rSalesInvoice.NoEvento, rSalesInvoice."No Impresion Comentarios");
                                if LineasEvento.FindFirst() then begin
                                    RecVariant := LineasEvento;
                                    RepCapituloDtl.SaveAs('', ReportFormat::Pdf, OutStream, GetRecRef(RecVariant));
                                end
                                else
                                    RepCapituloDtl.SaveAs('', ReportFormat::Pdf, OutStream, GetRecRef(RecordVariant));
                            end;
                        rSalesInvoice."Tipo de Impresión"::"Impresion Concepto Generico", rSalesInvoice."Tipo de Impresión"::"Impresion Detallada":
                            begin
                                // Imprimir impresión detallada. 50004
                                IsHandled := true;
                                TempBlob.CreateOutStream(OutStream);
                                RepGenerica.ConfigurarFiltros(rSalesInvoice."No.", true);
                                RepGenerica.SaveAs('', ReportFormat::Pdf, OutStream, GetRecRef(RecordVariant));
                            end;
                    end;
                end;
            end
            else begin
                // Imprimir impresión por capítulo. 50062
                IsHandled := true;
                TempBlob.CreateOutStream(OutStream);
                RepGenerica.ConfigurarFiltros(rSalesInvoice."No.", true);
                RepGenerica.SaveAs('', ReportFormat::Pdf, OutStream, GetRecRef(RecordVariant));
            end;
        end;
    end;

    local procedure GetRecRef(RecVariant: Variant) RecRef: RecordRef
    begin
        if RecVariant.IsRecordRef() then exit(RecVariant);
        if RecVariant.IsRecord() then RecRef.GetTable(RecVariant);
    end;
    //SL <<< GAP00054
}
