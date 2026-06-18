codeunit 50001 "Gestion comisiones"
{
    // ADVANCE - Log de cambios
    // -----------------------------------------------------
    //   ADVANCE
    //   Fecha: 31-05-2016
    //   Técnico: JMAP
    //   Presupuesto: Proyecto I002670 - Cálculo de comisiones
    //   Modificación:
    // 
    //   Etiqueta: ADV001
    // -----------------------------------------------------
    // #10037 - Se comenta la funcion por cambio de tabla
    trigger OnRun()
    begin
    end;
    local procedure lfu_CalculaComisionAlbaranEvento(Rcd_Albaran: Record 110)
    var
        Rcd_Evento: Record 50004;
        Rcd_MovComision: Record 50011;
        GLSetup: Record 98;
    begin
        IF Rcd_Albaran.NoEvento <> '' THEN BEGIN
            Rcd_Evento.GET(Rcd_Albaran.NoEvento);
            IF(Rcd_Evento.CodVendedor <> '') AND (Rcd_Evento."Commission %" <> 0)THEN BEGIN
                GLSetup.GET;
                GLSetup.TESTFIELD("Amount Rounding Precision");
                CLEAR(Rcd_MovComision);
                Rcd_MovComision.INIT;
                Rcd_MovComision."Salesperson Code":=Rcd_Evento.CodVendedor;
                Rcd_MovComision."Customer No.":=Rcd_Albaran."Sell-to Customer No.";
                Rcd_MovComision."Document Type":=Rcd_MovComision."Document Type"::"Sales Shipment";
                Rcd_MovComision."Order No.":=Rcd_Albaran."Order No.";
                Rcd_MovComision."Shipment No.":=Rcd_Albaran."No.";
                Rcd_MovComision."Posting Date":=Rcd_Albaran."Posting Date";
                Rcd_MovComision.NoEvento:=Rcd_Albaran.NoEvento;
                Rcd_MovComision."Commission %":=Rcd_Evento."Commission %";
                Rcd_MovComision.Amount:=Rcd_Albaran.Est_Total1;
                Rcd_MovComision."Comission Amount":=ROUND(Rcd_MovComision.Amount * Rcd_MovComision."Commission %" / 100, GLSetup."Amount Rounding Precision");
                Rcd_MovComision.INSERT(TRUE);
            END;
        END;
    end;
    procedure gfu_GeneraComisionVenta(SalesShptHdrNo: Code[20]; RetRcpHdrNo: Code[20])
    var
        lt_SalesShipmentHeader: Record 110;
        lt_ReturnReceiptHeader: Record 6660;
    begin
        //IF (Rcd_SalesHeader."Document Type" = Rcd_SalesHeader."Document Type"::Order) AND Rcd_SalesHeader.Ship THEN BEGIN
        IF SalesShptHdrNo <> '' THEN BEGIN
            //Rcd_SalesShipmentHeader.GET(Rcd_SalesHeader."Last Shipping No.");
            lt_SalesShipmentHeader.GET(SalesShptHdrNo);
            IF lt_SalesShipmentHeader.NoEvento <> '' THEN lfu_CalculaComisionAlbaranEvento(lt_SalesShipmentHeader)
            ELSE
                lfu_CalculaComisionAlbaran(lt_SalesShipmentHeader);
        END;
        IF RetRcpHdrNo <> '' THEN BEGIN
            lt_ReturnReceiptHeader.GET(RetRcpHdrNo);
            lfu_CalculaComisionRecepDev(lt_ReturnReceiptHeader);
        END;
    end;
    local procedure lfu_CalculaComisionAlbaran(Rcd_Albaran: Record 110)
    var
        Rcd_ItemLedgerEntry: Record 32;
        Rcd_TeamSalesperson: Record 5084;
        CodEquipo: Code[10];
    begin
        IF(Rcd_Albaran.NoEvento = '') AND (Rcd_Albaran."Salesperson Code" <> '')THEN BEGIN
            Rcd_ItemLedgerEntry.RESET;
            Rcd_ItemLedgerEntry.SETRANGE("Document No.", Rcd_Albaran."No.");
            Rcd_ItemLedgerEntry.SETRANGE("Posting Date", Rcd_Albaran."Posting Date");
            Rcd_ItemLedgerEntry.SETRANGE("Entry Type", Rcd_ItemLedgerEntry."Entry Type"::Sale);
            Rcd_ItemLedgerEntry.SETRANGE("Document Type", Rcd_ItemLedgerEntry."Document Type"::"Sales Shipment");
            IF Rcd_ItemLedgerEntry.FINDFIRST THEN REPEAT Rcd_TeamSalesperson.RESET;
                    Rcd_TeamSalesperson.SETRANGE("Salesperson Code", Rcd_Albaran."Salesperson Code");
                    IF Rcd_TeamSalesperson.FINDFIRST THEN BEGIN
                        CodEquipo:=Rcd_TeamSalesperson."Team Code";
                        Rcd_TeamSalesperson.RESET;
                        Rcd_TeamSalesperson.SETRANGE(Rcd_TeamSalesperson."Team Code", CodEquipo);
                        IF Rcd_TeamSalesperson.FINDSET THEN REPEAT lfu_CalculaComisionMovProducto(Rcd_ItemLedgerEntry, Rcd_TeamSalesperson."Salesperson Code");
                            UNTIL Rcd_TeamSalesperson.NEXT = 0;
                    END
                    ELSE
                    BEGIN
                        lfu_CalculaComisionMovProducto(Rcd_ItemLedgerEntry, Rcd_Albaran."Salesperson Code");
                    END;
                UNTIL Rcd_ItemLedgerEntry.NEXT = 0;
        END;
    end;
    local procedure lfu_CalculaComisionMovProducto(ItemLedgerEntry: Record 32; Vendedor: Code[10])
    var
        Rcd_CalculoComisiones: Record 50008;
        Rcd_MovComision: Record 50011;
        Rcd_SalesShipmentLine: Record 111;
        GLSetup: Record 98;
        Rcd_Vendedor: Record 13;
        lt_ReturnReceiptLine: Record 6661;
    begin
    //-- #10037
    /******************************** COMENTADO #10037 *******************************
        GLSetup.GET;
        GLSetup.TESTFIELD("Amount Rounding Precision");
        ItemLedgerEntry.CALCFIELDS("Sales Amount (Actual)","Sales Amount (Expected)");
        
        //Busca primero por articulo
        Rcd_CalculoComisiones.RESET;
        Rcd_CalculoComisiones.SETRANGE("Customer No.",Vendedor);
        Rcd_CalculoComisiones.SETRANGE("Vendor Name 1",0D,ItemLedgerEntry."Posting Date");
        Rcd_CalculoComisiones.SETFILTER("Vendor Code 2",'%1|>=%2',0D,ItemLedgerEntry."Posting Date");
        Rcd_CalculoComisiones.SETRANGE("Customer Name",Rcd_CalculoComisiones."Customer Name"::"0");
        Rcd_CalculoComisiones.SETRANGE("Item No.",ItemLedgerEntry."Item No.");
        IF Rcd_CalculoComisiones.FINDFIRST THEN BEGIN
          CLEAR(Rcd_MovComision);
          Rcd_MovComision.INIT;
          Rcd_MovComision."Salesperson Code" := Vendedor;
          IF ItemLedgerEntry."Document Type" = ItemLedgerEntry."Document Type"::"Sales Shipment" THEN BEGIN
            Rcd_SalesShipmentLine.GET(ItemLedgerEntry."Document No.",ItemLedgerEntry."Document Line No.");
            Rcd_MovComision."Customer No." := Rcd_SalesShipmentLine."Sell-to Customer No.";
            Rcd_MovComision."Order No." := Rcd_SalesShipmentLine."Order No.";
            Rcd_MovComision."Order Line No." := Rcd_SalesShipmentLine."Order Line No.";
            Rcd_MovComision."Document Type" := Rcd_MovComision."Document Type"::"Sales Shipment";
          END ELSE IF ItemLedgerEntry."Document Type" = ItemLedgerEntry."Document Type"::"Sales Return Receipt" THEN BEGIN
            lt_ReturnReceiptLine.GET(ItemLedgerEntry."Document No.",ItemLedgerEntry."Document Line No.");
            Rcd_MovComision."Customer No." := lt_ReturnReceiptLine."Sell-to Customer No.";
            Rcd_MovComision."Order No." := lt_ReturnReceiptLine."Return Order No.";
            Rcd_MovComision."Order Line No." := lt_ReturnReceiptLine."Return Order Line No.";
            Rcd_MovComision."Document Type" := Rcd_MovComision."Document Type"::"Sales Return Receipt";
          END;
          Rcd_MovComision."Shipment No." := ItemLedgerEntry."Document No.";
          Rcd_MovComision."Shipment Line No." := ItemLedgerEntry."Document Line No.";
          Rcd_MovComision."Posting Date" := ItemLedgerEntry."Posting Date";
          Rcd_MovComision."Item No." := ItemLedgerEntry."Item No.";
          Rcd_MovComision.Amount := ItemLedgerEntry."Sales Amount (Actual)" + ItemLedgerEntry."Sales Amount (Expected)";
          IF Rcd_CalculoComisiones."Item Description" = Rcd_CalculoComisiones."Item Description"::"0" THEN BEGIN
            Rcd_MovComision."Commission %" := 0 ;
            Rcd_MovComision."Comission Amount" := ROUND(Rcd_CalculoComisiones."Vendor Code 1",GLSetup."Amount Rounding Precision");
            IF Rcd_MovComision."Document Type" = Rcd_MovComision."Document Type"::"Sales Return Receipt" THEN
              Rcd_MovComision."Comission Amount" := - Rcd_MovComision."Comission Amount";
          END ELSE IF Rcd_CalculoComisiones."Item Description" = Rcd_CalculoComisiones."Item Description"::"1" THEN BEGIN
            Rcd_MovComision."Commission %" := Rcd_CalculoComisiones."Vendor Code 1";
            Rcd_MovComision."Comission Amount" := ROUND(Rcd_MovComision.Amount * Rcd_CalculoComisiones."Vendor Code 1" /100,GLSetup."Amount Rounding Precision");
          END;
          Rcd_MovComision.INSERT(TRUE);
        END ELSE BEGIN
          Rcd_CalculoComisiones.SETRANGE("Customer Name",Rcd_CalculoComisiones."Customer Name"::"1");
          Rcd_CalculoComisiones.SETRANGE("Item No.",ItemLedgerEntry."Item Category Code");
          IF Rcd_CalculoComisiones.FINDFIRST THEN BEGIN
            CLEAR(Rcd_MovComision);
            Rcd_MovComision.INIT;
            Rcd_MovComision."Salesperson Code" := Vendedor;
            IF ItemLedgerEntry."Document Type" = ItemLedgerEntry."Document Type"::"Sales Shipment" THEN BEGIN
              Rcd_SalesShipmentLine.GET(ItemLedgerEntry."Document No.",ItemLedgerEntry."Document Line No.");
              Rcd_MovComision."Customer No." := Rcd_SalesShipmentLine."Sell-to Customer No.";
              Rcd_MovComision."Order No." := Rcd_SalesShipmentLine."Order No.";
              Rcd_MovComision."Order Line No." := Rcd_SalesShipmentLine."Order Line No.";
              Rcd_MovComision."Document Type" := Rcd_MovComision."Document Type"::"Sales Shipment";
            END ELSE IF ItemLedgerEntry."Document Type" = ItemLedgerEntry."Document Type"::"Sales Return Receipt" THEN BEGIN
              lt_ReturnReceiptLine.GET(ItemLedgerEntry."Document No.",ItemLedgerEntry."Document Line No.");
              Rcd_MovComision."Customer No." := lt_ReturnReceiptLine."Sell-to Customer No.";
              Rcd_MovComision."Order No." := lt_ReturnReceiptLine."Return Order No.";
              Rcd_MovComision."Order Line No." := lt_ReturnReceiptLine."Return Order Line No.";
              Rcd_MovComision."Document Type" := Rcd_MovComision."Document Type"::"Sales Return Receipt";
            END;
            Rcd_MovComision."Shipment No." := ItemLedgerEntry."Document No.";
            Rcd_MovComision."Shipment Line No." := ItemLedgerEntry."Document Line No.";
            Rcd_MovComision."Posting Date" := ItemLedgerEntry."Posting Date";
            Rcd_MovComision."Item No." := ItemLedgerEntry."Item No.";
            Rcd_MovComision.Amount := ItemLedgerEntry."Sales Amount (Actual)" + ItemLedgerEntry."Sales Amount (Expected)";
            IF Rcd_CalculoComisiones."Item Description" = Rcd_CalculoComisiones."Item Description"::"0" THEN BEGIN
              Rcd_MovComision."Commission %" := 0 ;
              Rcd_MovComision."Comission Amount" := ROUND(Rcd_CalculoComisiones."Vendor Code 1",GLSetup."Amount Rounding Precision");
              IF Rcd_MovComision."Document Type" = Rcd_MovComision."Document Type"::"Sales Return Receipt" THEN
                Rcd_MovComision."Comission Amount" := - Rcd_MovComision."Comission Amount";
            END ELSE IF Rcd_CalculoComisiones."Item Description" = Rcd_CalculoComisiones."Item Description"::"1" THEN BEGIN
              Rcd_MovComision."Commission %" := Rcd_CalculoComisiones."Vendor Code 1";
              Rcd_MovComision."Comission Amount" := ROUND(Rcd_MovComision.Amount * Rcd_CalculoComisiones."Vendor Code 1" /100,GLSetup."Amount Rounding Precision");
            END;
            Rcd_MovComision.INSERT(TRUE);
          END ELSE BEGIN
            Rcd_Vendedor.GET(Vendedor);
            IF Rcd_Vendedor."Commission %" <> 0 THEN BEGIN
              CLEAR(Rcd_MovComision);
              Rcd_MovComision.INIT;
              Rcd_MovComision."Salesperson Code" := Vendedor;
              IF ItemLedgerEntry."Document Type" = ItemLedgerEntry."Document Type"::"Sales Shipment" THEN BEGIN
                Rcd_SalesShipmentLine.GET(ItemLedgerEntry."Document No.",ItemLedgerEntry."Document Line No.");
                Rcd_MovComision."Customer No." := Rcd_SalesShipmentLine."Sell-to Customer No.";
                Rcd_MovComision."Order No." := Rcd_SalesShipmentLine."Order No.";
                Rcd_MovComision."Order Line No." := Rcd_SalesShipmentLine."Order Line No.";
                Rcd_MovComision."Document Type" := Rcd_MovComision."Document Type"::"Sales Shipment";
              END ELSE IF ItemLedgerEntry."Document Type" = ItemLedgerEntry."Document Type"::"Sales Return Receipt" THEN BEGIN
                lt_ReturnReceiptLine.GET(ItemLedgerEntry."Document No.",ItemLedgerEntry."Document Line No.");
                Rcd_MovComision."Customer No." := lt_ReturnReceiptLine."Sell-to Customer No.";
                Rcd_MovComision."Order No." := lt_ReturnReceiptLine."Return Order No.";
                Rcd_MovComision."Order Line No." := lt_ReturnReceiptLine."Return Order Line No.";
                Rcd_MovComision."Document Type" := Rcd_MovComision."Document Type"::"Sales Return Receipt";
              END;
              Rcd_MovComision."Shipment No." := ItemLedgerEntry."Document No.";
              Rcd_MovComision."Shipment Line No." := ItemLedgerEntry."Document Line No.";
              Rcd_MovComision."Posting Date" := ItemLedgerEntry."Posting Date";
              Rcd_MovComision."Item No." := ItemLedgerEntry."Item No.";
              Rcd_MovComision.Amount := ItemLedgerEntry."Sales Amount (Actual)" + ItemLedgerEntry."Sales Amount (Expected)";
              Rcd_MovComision."Commission %" := Rcd_Vendedor."Commission %";
              Rcd_MovComision."Comission Amount" := ROUND(Rcd_MovComision.Amount * Rcd_Vendedor."Commission %" /100,GLSetup."Amount Rounding Precision");
              Rcd_MovComision.INSERT(TRUE);
            END;
          END;
        END;
        ****************************** FIN COMENTADO #10037 ******************************/
    //++ #10037
    end;
    procedure lfu_CalculaComisionRecepDev(Rcd_RecepDev: Record 6660)
    var
        Rcd_ItemLedgerEntry: Record 32;
        Rcd_TeamSalesperson: Record 5084;
        CodEquipo: Code[10];
    begin
        IF(Rcd_RecepDev."Salesperson Code" <> '')THEN BEGIN
            Rcd_ItemLedgerEntry.RESET;
            Rcd_ItemLedgerEntry.SETRANGE("Document No.", Rcd_RecepDev."No.");
            Rcd_ItemLedgerEntry.SETRANGE("Posting Date", Rcd_RecepDev."Posting Date");
            Rcd_ItemLedgerEntry.SETRANGE("Entry Type", Rcd_ItemLedgerEntry."Entry Type"::Sale);
            Rcd_ItemLedgerEntry.SETRANGE("Document Type", Rcd_ItemLedgerEntry."Document Type"::"Sales Return Receipt");
            IF Rcd_ItemLedgerEntry.FINDFIRST THEN REPEAT Rcd_TeamSalesperson.RESET;
                    Rcd_TeamSalesperson.SETRANGE("Salesperson Code", Rcd_RecepDev."Salesperson Code");
                    IF Rcd_TeamSalesperson.FINDFIRST THEN BEGIN
                        CodEquipo:=Rcd_TeamSalesperson."Team Code";
                        Rcd_TeamSalesperson.RESET;
                        Rcd_TeamSalesperson.SETRANGE(Rcd_TeamSalesperson."Team Code", CodEquipo);
                        IF Rcd_TeamSalesperson.FINDSET THEN REPEAT lfu_CalculaComisionMovProducto(Rcd_ItemLedgerEntry, Rcd_TeamSalesperson."Salesperson Code");
                            UNTIL Rcd_TeamSalesperson.NEXT = 0;
                    END
                    ELSE
                    BEGIN
                        lfu_CalculaComisionMovProducto(Rcd_ItemLedgerEntry, Rcd_RecepDev."Salesperson Code");
                    END;
                UNTIL Rcd_ItemLedgerEntry.NEXT = 0;
        END;
    end;
}
