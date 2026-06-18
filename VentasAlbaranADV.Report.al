report 50002 VentasAlbaranADV
{
    // ADVANCE - Base de datos BASE 2016 - ADV001
    // 
    // ADVANCE - Log de cambios
    // -----------------------------------------------------
    //   ADVANCE
    //   Fecha: 06-08-2018
    //   Técnico: JMM
    //   Presupuesto: Proyecto I008987 - Modificaciones Albarán de Venta
    //   Modificación: mostrar nuevos campos
    //   Etiqueta: ADV002
    // -----------------------------------------------------
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layout/50002.VentasAlbaranADV2.rdl';
    Caption = 'Albarán venta';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Shipment Header";110)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Posted Sales Shipment';

            column(No_SalesShptHeader; "No.")
            {
            }
            column(PageCaption; PageCaptionCap)
            {
            }
            column(CompanyInfo_TextoRegistro; CompanyInfo.Business_Register_Text_alx)
            {
            }
            column(CompanyInfo_ClausulaRGPD; CompanyInfo.Clausula_alx)
            {
            }
            column(Cabecera_MuestraCabecera; go_MuestraCabecera)
            {
            }
            column(Cabecera_DireccionEnvio; LBL_DireccionEnvio)
            {
            }
            column(Cabecera_DireccionFiscal; LBL_DireccionFiscal)
            {
            }
            dataitem(CopyLoop;2000000026)
            {
                DataItemTableView = SORTING(Number);

                dataitem(PageLoop;2000000026)
                {
                    DataItemTableView = SORTING(Number)WHERE(Number=CONST(1));

                    column(CompanyInfo2Picture; CompanyInfo2.Picture)
                    {
                    }
                    column(CompanyInfo1Picture; CompanyInfo1.Picture)
                    {
                    }
                    column(CompanyInfo3Picture; CompanyInfo3.Picture)
                    {
                    }
                    column(SalesShptCopyText; STRSUBSTNO(Text002, CopyText))
                    {
                    }
                    column(ShipToAddr1; ShipToAddr[1])
                    {
                    }
                    column(CompanyAddr1; CompanyAddr[1])
                    {
                    }
                    column(ShipToAddr2; ShipToAddr[2])
                    {
                    }
                    column(CompanyAddr2; CompanyAddr[2])
                    {
                    }
                    column(ShipToAddr3; ShipToAddr[3])
                    {
                    }
                    column(CompanyAddr3; CompanyAddr[3])
                    {
                    }
                    column(ShipToAddr4; ShipToAddr[4])
                    {
                    }
                    column(CompanyAddr4; CompanyAddr[4])
                    {
                    }
                    column(ShipToAddr5; ShipToAddr[5])
                    {
                    }
                    column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
                    {
                    }
                    column(ShipToAddr6; ShipToAddr[6])
                    {
                    }
                    column(Pie_LOPD1;'')
                    {
                    }
                    column(Pie_LOPD2;'')
                    {
                    }
                    column(Pie_LOPD3;'')
                    {
                    }
                    column(Pie_LOPD4;'')
                    {
                    }
                    #pragma warning disable AL0432
                    column(CompanyInfoHomePage; CompanyInfo."Home Page")
                    {
                    }
                    #pragma warning restore AL0432
                    column(CompanyInfoEmail; CompanyInfo."E-Mail")
                    {
                    }
                    column(CompanyInfoFaxNo; CompanyInfo."Fax No.")
                    {
                    }
                    column(CompanyInfoVATRegtnNo; CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(CompanyInfoGiroNo; CompanyInfo."Giro No.")
                    {
                    }
                    column(CompanyInfoBankName; CompanyInfo."Bank Name")
                    {
                    }
                    column(CompanyInfoBankAccountNo; CompanyInfo."Bank Account No.")
                    {
                    }
                    column(SelltoCustNo_SalesShptHeader; "Sales Shipment Header"."Sell-to Customer No.")
                    {
                    }
                    column(DocDate_SalesShptHeader; FORMAT("Sales Shipment Header"."Document Date", 0, 4))
                    {
                    }
                    column(SalesPersonText; SalesPersonText)
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(ExternadDoc_SalesShptHeader; "Sales Shipment Header"."External Document No.")
                    {
                    }
                    column(ReferenceText; ReferenceText)
                    {
                    }
                    column(YourRef_SalesShptHeader; "Sales Shipment Header"."Your Reference")
                    {
                    }
                    column(ShipToAddr7; ShipToAddr[7])
                    {
                    }
                    column(ShipToAddr8; ShipToAddr[8])
                    {
                    }
                    column(CompanyAddr5; CompanyAddr[5])
                    {
                    }
                    column(CompanyAddr6; CompanyAddr[6])
                    {
                    }
                    column(ShptDate_SalesShptHeader; FORMAT("Sales Shipment Header"."Shipment Date"))
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(ItemTrackingAppendixCaption; ItemTrackingAppendixCaptionLbl)
                    {
                    }
                    column(PhoneNoCaption; PhoneNoCaptionLbl)
                    {
                    }
                    column(VATRegNoCaption; VATRegNoCaptionLbl)
                    {
                    }
                    column(GiroNoCaption; GiroNoCaptionLbl)
                    {
                    }
                    column(BankNameCaption; BankNameCaptionLbl)
                    {
                    }
                    column(BankAccNoCaption; BankAccNoCaptionLbl)
                    {
                    }
                    column(ShipmentNoCaption; ShipmentNoCaptionLbl)
                    {
                    }
                    column(ShipmentDateCaption; ShipmentDateCaptionLbl)
                    {
                    }
                    column(HomePageCaption; HomePageCaptionLbl)
                    {
                    }
                    column(EmailCaption; EmailCaptionLbl)
                    {
                    }
                    column(DocumentDateCaption; DocumentDateCaptionLbl)
                    {
                    }
                    column(SelltoCustNo_SalesShptHeaderCaption; "Sales Shipment Header".FIELDCAPTION("Sell-to Customer No."))
                    {
                    }
                    column(CabAlbaran_AlbaranValorado; "Sales Shipment Header".AlbaranValorado)
                    {
                    }
                    column(CabAlbaran_Importe1; "Sales Shipment Header".Est_Importe1)
                    {
                    }
                    column(CabAlbaran_ImporteDtoFactura; "Sales Shipment Header".Est_ImporteDtoFactura)
                    {
                    }
                    column(CabAlbaran_DtoPP; "Sales Shipment Header".Est_DtoPP)
                    {
                    }
                    column(CabAlbaran_Total1; CabAlbaran_Total1)
                    {
                    }
                    column(CabAlbaran_ImporteIVA; CabAlbaran_ImporteIVA)
                    {
                    }
                    column(CabAlbaran_Total2; CabAlbaran_Total2)
                    {
                    }
                    column(CabAlbaran_TextoIVA; "Sales Shipment Header".Est_TextoIVA)
                    {
                    }
                    column(CabAlbaran_PreciosIVAIncluido; "Sales Shipment Header"."Prices Including VAT")
                    {
                    }
                    column(CabAlbaran_OcultarInfoEmpresa; gb_OcultaInfoEmpresa)
                    {
                    }
                    column(CabAlbaran_VentaA1; gvs_VentaAddr[1])
                    {
                    }
                    column(CabAlbaran_VentaA2; gvs_VentaAddr[2])
                    {
                    }
                    column(CabAlbaran_VentaA3; gvs_VentaAddr[3])
                    {
                    }
                    column(CabAlbaran_VentaA4; gvs_VentaAddr[4])
                    {
                    }
                    column(CabAlbaran_VentaA5; gvs_VentaAddr[5])
                    {
                    }
                    column(CabAlbaran_VentaA6; gvs_VentaAddr[6])
                    {
                    }
                    column(CabAlbaran_VentaA7; gvs_VentaAddr[7])
                    {
                    }
                    column(CabAlbaran_VentaA8; gvs_VentaAddr[8])
                    {
                    }
                    column(CabAlbaran_TextoTotalIncl; gs_TextoTotalIncl)
                    {
                    }
                    column(CabAlbaran_TextoTotalExcl; gs_TextoTotalExcl)
                    {
                    }
                    column(CabAlbaran_TieneComentarios; gb_TieneComentarios)
                    {
                    }
                    column(TIT_ImporteIVA; TITImporteIVA)
                    {
                    }
                    column(COL_Precio; COLPrecio)
                    {
                    }
                    column(COL_PorcDto; COLPorcDto)
                    {
                    }
                    column(COL_PorcIVA; COLPorcIVA)
                    {
                    }
                    column(COL_Importe; COLImporte)
                    {
                    }
                    column(TIT_Subtotal; TITSubtotal)
                    {
                    }
                    column(TIT_ImporteDescFact; TITImporteDescFact)
                    {
                    }
                    column(TIT_ImporteDescPago; TITImporteDescPago)
                    {
                    }
                    column(COL_Comentarios; COLComentarios)
                    {
                    }
                    column(Albaran_TITFormaDePago; TITFormaDePago)
                    {
                    }
                    column(Albaran_TITTerminosDePago; TITTerminosDePago)
                    {
                    }
                    column(Albaran_TITBanco; TITBanco)
                    {
                    }
                    column(Albaran_TerminosDePago; gs_TerminosDePago)
                    {
                    }
                    column(Albaran_FormaDePago; gs_FormaDePago)
                    {
                    }
                    column(Albaran_Banco; gs_Banco)
                    {
                    }
                    column(CustomerPhoneCaption; PhoneCustomerLbl)
                    {
                    }
                    column(AliasPhoneCaption; AliasCustomerLbl)
                    {
                    }
                    column(Cab_TelefonoCliente; gs_TelefonoCliente)
                    {
                    }
                    column(Cab_AliasCliente; gs_AliasCLiente)
                    {
                    }
                    column(Albaran_HorarioApRecep; "Sales Shipment Header".HorarioAperturaRecepcion)
                    {
                    }
                    column(NumClienteCaption; NumClienteLbl)
                    {
                    }
                    column(TextoDevoluciones; TextDevoluciones)
                    {
                    }
                    column(NumTelefono_DirEnvio; gs_DireccionEnvioNumeroTelefono)
                    {
                    }
                    column(HorarioEntrega_DirEnvio; gs_DireccionEnvioHorarioEntrega)
                    {
                    }
                    column(LBL_Logistica; LBL_Logistica)
                    {
                    }
                    column(LBL_TotalBultos; LBL_TotalBultos)
                    {
                    }
                    column(LBL_TotalPeso; LBL_TotalPeso)
                    {
                    }
                    column(Logistica_TotalBultos; gn_TotalBultos)
                    {
                    }
                    column(Logistica_TotalPeso; gn_TotalPesoBruto)
                    {
                    }
                    column(FechaEntregarequerida; "Sales Shipment Header"."Requested Delivery Date")
                    {
                    IncludeCaption = true;
                    }
                    column(HorarioApertura; "Sales Shipment Header".HorarioAperturaRecepcion)
                    {
                    }
                    dataitem(DimensionLoop1;2000000026)
                    {
                        DataItemLinkReference = "Sales Shipment Header";
                        DataItemTableView = SORTING(Number)WHERE(Number=FILTER(1..));

                        column(DimText; DimText)
                        {
                        }
                        column(HeaderDimensionsCaption; HeaderDimensionsCaptionLbl)
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN BEGIN
                                IF NOT DimSetEntry1.FINDSET THEN CurrReport.BREAK;
                            END
                            ELSE IF NOT Continue THEN CurrReport.BREAK;
                            CLEAR(DimText);
                            Continue:=FALSE;
                            REPEAT OldDimText:=DimText;
                                IF DimText = '' THEN DimText:=STRSUBSTNO('%1 - %2', DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code")
                                ELSE
                                    DimText:=STRSUBSTNO('%1; %2 - %3', DimText, DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code");
                                IF STRLEN(DimText) > MAXSTRLEN(OldDimText)THEN BEGIN
                                    DimText:=OldDimText;
                                    Continue:=TRUE;
                                    EXIT;
                                END;
                            UNTIL DimSetEntry1.NEXT = 0;
                        end;
                        trigger OnPreDataItem()
                        begin
                            IF NOT ShowInternalInfo THEN CurrReport.BREAK;
                        end;
                    }
                    dataitem("Sales Shipment Line";111)
                    {
                        DataItemLink = "Document No."=FIELD("No.");
                        DataItemLinkReference = "Sales Shipment Header";
                        DataItemTableView = SORTING("Document No.", "Line No.");

                        column(Description_SalesShptLine; Description)
                        {
                        }
                        column(ShowInternalInfo; ShowInternalInfo)
                        {
                        }
                        column(ShowCorrectionLines; ShowCorrectionLines)
                        {
                        }
                        column(Type_SalesShptLine; FORMAT(Type, 0, 2))
                        {
                        }
                        column(AsmHeaderExists; AsmHeaderExists)
                        {
                        }
                        column(DocumentNo_SalesShptLine; "Document No.")
                        {
                        }
                        column(LinNo; LinNo)
                        {
                        }
                        column(Qty_SalesShptLine; Quantity)
                        {
                        }
                        column(UOM_SalesShptLine; "Unit of Measure")
                        {
                        }
                        column(No_SalesShptLine; "No.")
                        {
                        }
                        column(LineNo_SalesShptLine; "Line No.")
                        {
                        }
                        column(LinVenta_PrecioUnitario; "Sales Shipment Line"."Unit Price")
                        {
                        }
                        column(LinVenta_PorcDescuento; "Sales Shipment Line"."Line Discount %")
                        {
                        }
                        column(LinVenta_PorcIVA; "Sales Shipment Line"."VAT %")
                        {
                        }
                        column(LinVenta_Importe; gn_ImporteLinea)
                        {
                        }
                        column(Description_SalesShptLineCaption; FIELDCAPTION(Description))
                        {
                        }
                        column(Qty_SalesShptLineCaption; FIELDCAPTION(Quantity))
                        {
                        }
                        column(UOM_SalesShptLineCaption; FIELDCAPTION("Unit of Measure"))
                        {
                        }
                        column(No_SalesShptLineCaption; FIELDCAPTION("No."))
                        {
                        }
                        column(UnidadLogistica_Caption; LBL_UnidadLogistica)
                        {
                        }
                        column(CantidadUnidadLogistica_Caption; LBL_CantidadUnidadLogistica)
                        {
                        }
                        column(LinVenta_CantidadUnidadLogistica; gs_CantidadUnidadLogistica)
                        {
                        }
                        column(LinVenta_UnidadLogistica; gs_UnidadLogistica)
                        {
                        }
                        dataitem(DimensionLoop2;2000000026)
                        {
                            DataItemTableView = SORTING(Number)WHERE(Number=FILTER(1..));

                            column(DimText1; DimText)
                            {
                            }
                            column(LineDimensionsCaption; LineDimensionsCaptionLbl)
                            {
                            }
                            trigger OnAfterGetRecord()
                            begin
                                IF Number = 1 THEN BEGIN
                                    IF NOT DimSetEntry2.FINDSET THEN CurrReport.BREAK;
                                END
                                ELSE IF NOT Continue THEN CurrReport.BREAK;
                                CLEAR(DimText);
                                Continue:=FALSE;
                                REPEAT OldDimText:=DimText;
                                    IF DimText = '' THEN DimText:=STRSUBSTNO('%1 - %2', DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code")
                                    ELSE
                                        DimText:=STRSUBSTNO('%1; %2 - %3', DimText, DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code");
                                    IF STRLEN(DimText) > MAXSTRLEN(OldDimText)THEN BEGIN
                                        DimText:=OldDimText;
                                        Continue:=TRUE;
                                        EXIT;
                                    END;
                                UNTIL DimSetEntry2.NEXT = 0;
                            end;
                            trigger OnPreDataItem()
                            begin
                                IF NOT ShowInternalInfo THEN CurrReport.BREAK;
                            end;
                        }
                        dataitem(DisplayAsmInfo;2000000026)
                        {
                            DataItemTableView = SORTING(Number);

                            column(PostedAsmLineItemNo; BlanksForIndent + PostedAsmLine."No.")
                            {
                            }
                            column(PostedAsmLineDescription; BlanksForIndent + PostedAsmLine.Description)
                            {
                            }
                            column(PostedAsmLineQuantity; PostedAsmLine.Quantity)
                            {
                            DecimalPlaces = 0: 5;
                            }
                            column(PostedAsmLineUOMCode; GetUnitOfMeasureDescr(PostedAsmLine."Unit of Measure Code"))
                            {
                            //DecimalPlaces = 0 : 5;
                            }
                            trigger OnAfterGetRecord()
                            var
                                ItemTranslation: Record 30;
                            begin
                                IF Number = 1 THEN PostedAsmLine.FINDSET
                                ELSE
                                    PostedAsmLine.NEXT;
                                IF ItemTranslation.GET(PostedAsmLine."No.", PostedAsmLine."Variant Code", "Sales Shipment Header"."Language Code")THEN PostedAsmLine.Description:=ItemTranslation.Description;
                            end;
                            trigger OnPreDataItem()
                            begin
                                IF NOT DisplayAssemblyInformation THEN CurrReport.BREAK;
                                IF NOT AsmHeaderExists THEN CurrReport.BREAK;
                                PostedAsmLine.SETRANGE("Document No.", PostedAsmHeader."No.");
                                SETRANGE(Number, 1, PostedAsmLine.COUNT);
                            end;
                        }
                        dataitem("Item Entry Relation";6507)
                        {
                            DataItemLink = "Source ID"=FIELD("Document No."), "Source Ref. No."=FIELD("Line No.");
                            DataItemTableView = SORTING("Source ID", "Source Type", "Source Subtype", "Source Ref. No.", "Source Prod. Order Line", "Source Batch Name")WHERE("Source Type"=CONST(111), "Source Subtype"=CONST(0));

                            dataitem("Value Entry";5802)
                            {
                                DataItemLink = "Item Ledger Entry No."=FIELD("Item Entry No.");
                                DataItemTableView = SORTING("Entry No.")WHERE("Item Ledger Entry Quantity"=FILTER(<>0));

                                dataitem("Item Ledger Entry";32)
                                {
                                    DataItemLink = "Entry No."=FIELD("Item Ledger Entry No.");
                                    DataItemTableView = SORTING("Entry No.")ORDER(Ascending);

                                    column(LotNo_ItemLedgerEntry; "Item Ledger Entry"."Lot No.")
                                    {
                                    }
                                    column(var_CaptionLote; var_CaptionLote)
                                    {
                                    }
                                    trigger OnAfterGetRecord()
                                    var
                                        ItemApplnEntry: Record 339;
                                        ItemLedgEntry: Record 32;
                                    begin
                                        var_CaptionLote:=STRSUBSTNO(txt_Lote, "Item Ledger Entry"."Lot No.", -"Item Ledger Entry".Quantity);
                                        ItemApplnEntry.RESET;
                                        ItemApplnEntry.SETCURRENTKEY("Outbound Item Entry No.", "Item Ledger Entry No.", "Cost Application");
                                        ItemApplnEntry.SETRANGE("Outbound Item Entry No.", "Entry No.");
                                        ItemApplnEntry.SETRANGE("Item Ledger Entry No.", "Entry No.");
                                        IF ItemApplnEntry.FINDFIRST THEN BEGIN
                                            ItemLedgEntry.GET(ItemApplnEntry."Inbound Item Entry No.");
                                            "Expiration Date":=ItemLedgEntry."Expiration Date";
                                        END;
                                        IF "Item Ledger Entry"."Expiration Date" <> 0D THEN var_CaptionLote+=STRSUBSTNO(txt_LoteFechaCaducidad, "Item Ledger Entry"."Expiration Date");
                                    end;
                                }
                            }
                        }
                        trigger OnAfterGetRecord()
                        begin
                            IF gb_PrimerRegistro THEN gb_PrimerRegistro:=FALSE
                            ELSE
                                CLEAR(CompanyInfo3.Picture);
                            LinNo:="Line No.";
                            IF NOT ShowCorrectionLines AND Correction THEN CurrReport.SKIP;
                            DimSetEntry2.SETRANGE("Dimension Set ID", "Dimension Set ID");
                            IF DisplayAssemblyInformation THEN AsmHeaderExists:=AsmToShipmentExists(PostedAsmHeader);
                            //INICIO ADV001
                            //Calcular importe de línea
                            gn_ImporteLinea:=("Sales Shipment Line".Quantity * "Sales Shipment Line"."Unit Price") * (1 - ("Sales Shipment Line"."Line Discount %" / 100));
                            //FIN ADV001
                            //INICIO ADV002
                            gs_CantidadUnidadLogistica:='';
                            gn_CantidadUL:=0;
                            gs_UnidadLogistica:='';
                            gt_UnidadMedida.RESET;
                            gt_Producto.RESET;
                            IF("Sales Shipment Line".Type = "Sales Shipment Line".Type::Item) AND ("Sales Shipment Line"."No." <> '')THEN BEGIN
                                gt_UnidadMedida.SETRANGE(gt_UnidadMedida."Item No.", "Sales Shipment Line"."No.");
                                gt_UnidadMedida.SETRANGE(gt_UnidadMedida."Unidad Logística Albaran", TRUE);
                                IF gt_UnidadMedida.COUNT = 1 THEN BEGIN
                                    IF gt_UnidadMedida.FINDSET THEN BEGIN
                                        gs_CantidadUnidadLogistica:=FORMAT(gt_UnidadMedida."Qty. per Unit of Measure") + ' ' + "Sales Shipment Line"."Unit of Measure" + '/' + gt_UnidadMedida.Code;
                                        gn_CantidadUL:="Sales Shipment Line".Quantity / gt_UnidadMedida."Qty. per Unit of Measure";
                                        //gn_TotalBultos += gn_CantidadUL;
                                        gs_UnidadLogistica:=FORMAT(gn_CantidadUL) + ' ' + gt_UnidadMedida.Code;
                                    //IF gt_Producto.GET("Sales Shipment Line"."No.") THEN BEGIN
                                    //gn_TotalPesoBruto += gt_Producto."Gross Weight";
                                    //END;
                                    END;
                                END;
                            END;
                        //FIN ADV002
                        end;
                        trigger OnPostDataItem()
                        begin
                            // Item Tracking:
                            IF ShowLotSN THEN BEGIN
                                ItemTrackingDocMgt.SetRetrieveAsmItemTracking(TRUE);
                                TrackingSpecCount:=ItemTrackingDocMgt.RetrieveDocumentItemTracking(TrackingSpecBuffer, "Sales Shipment Header"."No.", DATABASE::"Sales Shipment Header", 0);
                                ItemTrackingDocMgt.SetRetrieveAsmItemTracking(FALSE);
                            END;
                        end;
                        trigger OnPreDataItem()
                        begin
                            MoreLines:=FIND('+');
                            WHILE MoreLines AND (Description = '') AND ("No." = '') AND (Quantity = 0)DO MoreLines:=NEXT(-1) <> 0;
                            IF NOT MoreLines THEN CurrReport.BREAK;
                            SETRANGE("Line No.", 0, "Line No.");
                        end;
                    }
                    dataitem(Total;2000000026)
                    {
                        DataItemTableView = SORTING(Number)WHERE(Number=CONST(1));
                    }
                    dataitem(Total2;2000000026)
                    {
                        DataItemTableView = SORTING(Number)WHERE(Number=CONST(1));

                        column(BilltoCustNo_SalesShptHeader; "Sales Shipment Header"."Bill-to Customer No.")
                        {
                        }
                        column(CustAddr1; CustAddr[1])
                        {
                        }
                        column(CustAddr2; CustAddr[2])
                        {
                        }
                        column(CustAddr3; CustAddr[3])
                        {
                        }
                        column(CustAddr4; CustAddr[4])
                        {
                        }
                        column(CustAddr5; CustAddr[5])
                        {
                        }
                        column(CustAddr6; CustAddr[6])
                        {
                        }
                        column(CustAddr7; CustAddr[7])
                        {
                        }
                        column(CustAddr8; CustAddr[8])
                        {
                        }
                        column(BilltoAddressCaption; BilltoAddressCaptionLbl)
                        {
                        }
                        column(BilltoCustNo_SalesShptHeaderCaption; "Sales Shipment Header".FIELDCAPTION("Bill-to Customer No."))
                        {
                        }
                        trigger OnPreDataItem()
                        begin
                            IF NOT ShowCustAddr THEN CurrReport.BREAK;
                        end;
                    }
                    dataitem(di_Comentarios;44)
                    {
                        DataItemLink = "No."=FIELD("No.");
                        DataItemLinkReference = "Sales Shipment Header";
                        DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.")ORDER(Ascending)WHERE("Document Type"=CONST(Shipment));

                        column(Comment_diComentarios; di_Comentarios.Comment)
                        {
                        }
                    }
                    dataitem(ItemTrackingLine;2000000026)
                    {
                        DataItemTableView = SORTING(Number);

                        column(TrackingSpecBufferNo; TrackingSpecBuffer."Item No.")
                        {
                        }
                        column(TrackingSpecBufferDesc; TrackingSpecBuffer.Description)
                        {
                        }
                        column(TrackingSpecBufferLotNo; TrackingSpecBuffer."Lot No.")
                        {
                        }
                        column(TrackingSpecBufferSerNo; TrackingSpecBuffer."Serial No.")
                        {
                        }
                        column(TrackingSpecBufferQty; TrackingSpecBuffer."Quantity (Base)")
                        {
                        }
                        column(ShowTotal; ShowTotal)
                        {
                        }
                        column(ShowGroup; ShowGroup)
                        {
                        }
                        column(QuantityCaption; QuantityCaptionLbl)
                        {
                        }
                        column(SerialNoCaption; SerialNoCaptionLbl)
                        {
                        }
                        column(LotNoCaption; LotNoCaptionLbl)
                        {
                        }
                        column(DescriptionCaption; DescriptionCaptionLbl)
                        {
                        }
                        column(NoCaption; NoCaptionLbl)
                        {
                        }
                        dataitem(TotalItemTracking;2000000026)
                        {
                            DataItemTableView = SORTING(Number)WHERE(Number=CONST(1));

                            column(Quantity1; TotalQty)
                            {
                            }
                        }
                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN TrackingSpecBuffer.FINDSET
                            ELSE
                                TrackingSpecBuffer.NEXT;
                            IF NOT ShowCorrectionLines AND TrackingSpecBuffer.Correction THEN CurrReport.SKIP;
                            IF TrackingSpecBuffer.Correction THEN TrackingSpecBuffer."Quantity (Base)":=-TrackingSpecBuffer."Quantity (Base)";
                            ShowTotal:=FALSE;
                            IF ItemTrackingAppendix.IsStartNewGroup(TrackingSpecBuffer)THEN ShowTotal:=TRUE;
                            ShowGroup:=FALSE;
                            IF(TrackingSpecBuffer."Source Ref. No." <> OldRefNo) OR (TrackingSpecBuffer."Item No." <> OldNo)THEN BEGIN
                                OldRefNo:=TrackingSpecBuffer."Source Ref. No.";
                                OldNo:=TrackingSpecBuffer."Item No.";
                                TotalQty:=0;
                            END
                            ELSE
                                ShowGroup:=TRUE;
                            TotalQty+=TrackingSpecBuffer."Quantity (Base)";
                        end;
                        trigger OnPreDataItem()
                        begin
                            IF TrackingSpecCount = 0 THEN CurrReport.BREAK;
                            //CurrReport.NEWPAGE;
                            SETRANGE(Number, 1, TrackingSpecCount);
                            TrackingSpecBuffer.SETCURRENTKEY("Source ID", "Source Type", "Source Subtype", "Source Batch Name", "Source Prod. Order Line", "Source Ref. No.");
                        end;
                    }
                    trigger OnPreDataItem()
                    begin
                        // Item Tracking:
                        IF ShowLotSN THEN BEGIN
                            TrackingSpecCount:=0;
                            OldRefNo:=0;
                            ShowGroup:=FALSE;
                        END;
                    end;
                }
                trigger OnAfterGetRecord()
                begin
                    IF Number > 1 THEN BEGIN
                        CopyText:=Text001;
                        OutputNo+=1;
                    END;
                    //CurrReport.PAGENO := 1;
                    TotalQty:=0; // Item Tracking
                end;
                trigger OnPostDataItem()
                begin
                    IF NOT CurrReport.PREVIEW THEN ShptCountPrinted.RUN("Sales Shipment Header");
                end;
                trigger OnPreDataItem()
                begin
                    NoOfLoops:=1 + ABS(NoOfCopies);
                    CopyText:='';
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo:=1;
                end;
            }
            trigger OnAfterGetRecord()
            var
                lt_GLSetup: Record 98;
                lt_Comentarios: Record 44;
                lt_FormaPago: Record 289;
                lt_Banco: Record 270;
                lt_BancoCli: Record 287;
                lt_TerminosPago: Record 3;
                lt_Cliente: Record 18;
                lt_LineasAlbaranVenta: Record 111;
            begin
                CurrReport.LANGUAGE:=Language2.GetLanguageID('ESP');
                IF RespCenter.GET("Responsibility Center")THEN BEGIN
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No.":=RespCenter."Phone No.";
                    CompanyInfo."Fax No.":=RespCenter."Fax No.";
                END
                ELSE
                    FormatAddr.Company(CompanyAddr, CompanyInfo);
                DimSetEntry1.SETRANGE("Dimension Set ID", "Dimension Set ID");
                IF "Salesperson Code" = '' THEN BEGIN
                    SalesPurchPerson.INIT;
                    SalesPersonText:='';
                END
                ELSE
                BEGIN
                    SalesPurchPerson.GET("Salesperson Code");
                    SalesPersonText:=Text000;
                END;
                IF "Your Reference" = '' THEN ReferenceText:=''
                ELSE
                    ReferenceText:=FIELDCAPTION("Your Reference");
                FormatAddr.SalesShptShipTo(ShipToAddr, "Sales Shipment Header");
                // FormatAddr.SalesShptBillTo(ShipToAddr, CustAddr, "Sales Shipment Header");
                //INICIO ADV001
                //Quito estas líneas porque siempre se imprimen los datos de envío
                //ShowCustAddr := "Bill-to Customer No." <> "Sell-to Customer No.";
                //FOR i := 1 TO ARRAYLEN(CustAddr) DO
                //  IF CustAddr[i] <> ShipToAddr[i] THEN
                //    ShowCustAddr := TRUE;
                //FIN ADV001
                IF LogInteraction THEN IF NOT CurrReport.PREVIEW THEN SegManagement.LogDocument(5, "No.", 0, 0, DATABASE::Customer, "Sell-to Customer No.", "Salesperson Code", "Campaign No.", "Posting Description", '');
                //INICIO ADV001
                //Guardo en una variable los datos del venta a para mostrarlos a la izquierda, y la del envía-a irá a la derecha
                FormatAddr.SalesShptSellTo(gvs_VentaAddr, "Sales Shipment Header");
                lt_GLSetup.GET;
                IF "Currency Code" = '' THEN BEGIN
                    lt_GLSetup.TESTFIELD("LCY Code");
                    gs_TextoTotalIncl:=STRSUBSTNO(TITTotalIncl, lt_GLSetup."LCY Code");
                    gs_TextoTotalExcl:=STRSUBSTNO(TITTotalExcl, lt_GLSetup."LCY Code");
                END
                ELSE
                BEGIN
                    gs_TextoTotalIncl:=STRSUBSTNO(TITTotalIncl, "Currency Code");
                    gs_TextoTotalExcl:=STRSUBSTNO(TITTotalExcl, "Currency Code");
                END;
                lt_Comentarios.RESET;
                lt_Comentarios.SETRANGE("Document Type", lt_Comentarios."Document Type"::Shipment);
                lt_Comentarios.SETRANGE("No.", "Sales Shipment Header"."No.");
                gb_TieneComentarios:=(NOT lt_Comentarios.ISEMPTY);
                //Buscar el banco que hay que mostrar, dependiendo de lo que hayan configurado en la forma de pago
                gs_Banco:='';
                gs_FormaDePago:='';
                IF lt_FormaPago.GET("Sales Shipment Header"."Payment Method Code")THEN BEGIN
                    gs_FormaDePago:=lt_FormaPago.Description;
                    CASE lt_FormaPago.BancoImpresionVentasMigr OF lt_FormaPago.BancoImpresionVentasMigr::Empresa: BEGIN
                        IF lt_Banco.GET("Sales Shipment Header".CodBancoEmpresa)THEN gs_Banco:=lt_Banco.IBAN + '-' + lt_Banco."SWIFT Code";
                    END;
                    lt_FormaPago.BancoImpresionVentasMigr::Cliente: BEGIN
                        IF lt_BancoCli.GET("Sales Shipment Header"."Bill-to Customer No.", "Sales Shipment Header"."Cust. Bank Acc. Code")THEN gs_Banco:=lt_BancoCli.IBAN + '-' + lt_BancoCli."SWIFT Code";
                    END;
                    END;
                END;
                gs_TerminosDePago:='';
                IF lt_TerminosPago.GET("Sales Shipment Header"."Payment Terms Code")THEN gs_TerminosDePago:=lt_TerminosPago.Description;
                gs_AliasCLiente:='';
                gs_TelefonoCliente:='';
                lt_Cliente.GET("Bill-to Customer No.");
                gs_AliasCLiente:=lt_Cliente."Search Name";
                gs_TelefonoCliente:=lt_Cliente."Phone No.";
                //FIN ADV001
                //INICIO ADV002
                gs_DireccionEnvioNumeroTelefono:='';
                gs_DireccionEnvioHorarioEntrega:='';
                gt_DireccionEnvio.RESET;
                IF("Sales Shipment Header"."Ship-to Code" <> '') AND ("Sales Shipment Header"."Sell-to Customer No." <> '')THEN BEGIN
                    IF gt_DireccionEnvio.GET("Sales Shipment Header"."Sell-to Customer No.", "Sales Shipment Header"."Ship-to Code")THEN BEGIN
                        gs_DireccionEnvioNumeroTelefono:=gt_DireccionEnvio."Phone No.";
                        gs_DireccionEnvioHorarioEntrega:=gt_DireccionEnvio.HorarioEntrega;
                    END;
                END;
                gn_TotalBultos:=0;
                gn_TotalPesoBruto:=0;
                gt_UnidadMedida.RESET;
                gt_Producto.RESET;
                lt_LineasAlbaranVenta.RESET;
                lt_LineasAlbaranVenta.SETRANGE(lt_LineasAlbaranVenta."Document No.", "Sales Shipment Header"."No.");
                lt_LineasAlbaranVenta.SETRANGE(lt_LineasAlbaranVenta.Type, lt_LineasAlbaranVenta.Type::Item);
                IF lt_LineasAlbaranVenta.FINDSET THEN BEGIN
                    REPEAT IF lt_LineasAlbaranVenta."No." <> '' THEN BEGIN
                            gt_UnidadMedida.SETRANGE(gt_UnidadMedida."Item No.", lt_LineasAlbaranVenta."No.");
                            gt_UnidadMedida.SETRANGE(gt_UnidadMedida."Unidad Logística Albaran", TRUE);
                            IF gt_UnidadMedida.COUNT = 1 THEN BEGIN
                                IF gt_UnidadMedida.FINDSET THEN BEGIN
                                    //gn_TotalBultos += lt_LineasAlbaranVenta.Quantity / gt_UnidadMedida."Qty. per Unit of Measure";
                                    IF gt_Producto.GET(lt_LineasAlbaranVenta."No.")THEN BEGIN
                                        gn_TotalPesoBruto+=gt_Producto."Gross Weight" * lt_LineasAlbaranVenta.Quantity;
                                    END;
                                END;
                            END;
                            // GAP00041 >>>
                            // Se cambia el cálculo de la impresión de albarán para que tome el dato para el cálculo de números de bulto del campo "Unidad Logística en Vigor".
                            //SL >>> Fix Divicion por 0
                            if lt_LineasAlbaranVenta."Unidad Logística en Vigor" = 0 then Error('Unidad Logística en Vigor es 0');
                            //SL <<< Fix Divicion por 0
                            gn_TotalBultos:=gn_TotalBultos + (lt_LineasAlbaranVenta.Quantity / lt_LineasAlbaranVenta."Unidad Logística en Vigor");
                        // GAP00041 <<<
                        END;
                    UNTIL lt_LineasAlbaranVenta.NEXT = 0;
                END;
                //AGRALAMO Correción informe Albaranes
                lt_LineasAlbaranVenta.RESET;
                lt_LineasAlbaranVenta.SETRANGE(lt_LineasAlbaranVenta."Document No.", "Sales Shipment Header"."No.");
                IF lt_LineasAlbaranVenta.FINDSET THEN BEGIN
                    REPEAT //Total IVA incluido
                        CabAlbaran_Total2+=(lt_LineasAlbaranVenta.Quantity * lt_LineasAlbaranVenta."Unit Price") * (1 - (lt_LineasAlbaranVenta."Line Discount %" / 100));
                        //Total IVA
                        CabAlbaran_ImporteIVA+=((lt_LineasAlbaranVenta.Quantity * lt_LineasAlbaranVenta."Unit Price") * (1 - (lt_LineasAlbaranVenta."Line Discount %" / 100))) * (lt_LineasAlbaranVenta."VAT %" / 100);
                    UNTIL lt_LineasAlbaranVenta.NEXT = 0;
                    //Total Ext Iva
                    CabAlbaran_Total1+=CabAlbaran_Total2 - CabAlbaran_ImporteIVA;
                END;
            //FIN ADV002
            //AGRALAMO Correción informe Albaranes
            end;
        }
    }
    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field(NoOfCopies; NoOfCopies)
                    {
                        ApplicationArea = All;
                        Caption = 'No. of Copies';
                    }
                    field(ShowInternalInfo; ShowInternalInfo)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Internal Information';
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        ApplicationArea = All;
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                    }
                    field("Show Correction Lines"; ShowCorrectionLines)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Correction Lines';
                    }
                    field(DisplayAsmInfo; DisplayAssemblyInformation)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Assembly Components';
                    }
                    field(go_MuestraCabecera; go_MuestraCabecera)
                    {
                        ApplicationArea = All;
                        Caption = 'Mostrar cabecera';
                    }
                }
            }
        }
        actions
        {
        }
        trigger OnInit()
        begin
            LogInteractionEnable:=TRUE;
        end;
        trigger OnOpenPage()
        begin
            InitLogInteraction;
            LogInteractionEnable:=LogInteraction;
            go_MuestraCabecera:=go_MuestraCabecera::Mostrar;
        end;
    }
    labels
    {
    lblHorario='Horario apertura / recepción mercancía';
    lblNumDocExterno='Nº documento externo';
    }
    trigger OnInitReport()
    begin
        CompanyInfo.GET;
        SalesSetup.GET;
        CompanyInfo3.GET;
        CompanyInfo3.CALCFIELDS(Picture);
    end;
    trigger OnPreReport()
    var
        lt_LineasAlbaranVenta: Record 111;
    begin
        IF NOT CurrReport.USEREQUESTPAGE THEN InitLogInteraction;
        AsmHeaderExists:=FALSE;
        gb_PrimerRegistro:=TRUE;
    end;
    var Text000: Label 'Salesperson';
    Text001: Label 'COPY';
    Text002: Label 'Albarán venta';
    SalesPurchPerson: Record 13;
    CompanyInfo: Record 79;
    CompanyInfo1: Record 79;
    CompanyInfo2: Record 79;
    CompanyInfo3: Record 79;
    SalesSetup: Record 311;
    DimSetEntry1: Record 480;
    DimSetEntry2: Record 480;
    //Language: Record "8";
    Language2: Codeunit Language;
    TrackingSpecBuffer: Record 336 temporary;
    PostedAsmHeader: Record 910;
    PostedAsmLine: Record 911;
    ShptCountPrinted: Codeunit 314;
    SegManagement: Codeunit 5051;
    ItemTrackingDocMgt: Codeunit 6503;
    RespCenter: Record 5714;
    ItemTrackingAppendix: Report 6521;
    CustAddr: array[8]of Text[50];
    ShipToAddr: array[8]of Text[50];
    CompanyAddr: array[8]of Text[50];
    SalesPersonText: Text[20];
    ReferenceText: Text[80];
    MoreLines: Boolean;
    NoOfCopies: Integer;
    OutputNo: Integer;
    NoOfLoops: Integer;
    TrackingSpecCount: Integer;
    OldRefNo: Integer;
    OldNo: Code[20];
    CopyText: Text[30];
    ShowCustAddr: Boolean;
    i: Integer;
    FormatAddr: Codeunit 365;
    DimText: Text[120];
    OldDimText: Text[75];
    ShowInternalInfo: Boolean;
    Continue: Boolean;
    LogInteraction: Boolean;
    ShowCorrectionLines: Boolean;
    ShowLotSN: Boolean;
    ShowTotal: Boolean;
    ShowGroup: Boolean;
    TotalQty: Decimal;
    LogInteractionEnable: Boolean;
    DisplayAssemblyInformation: Boolean;
    AsmHeaderExists: Boolean;
    LinNo: Integer;
    ItemTrackingAppendixCaptionLbl: Label 'Item Tracking - Appendix';
    PhoneNoCaptionLbl: Label 'Nº teléfono';
    VATRegNoCaptionLbl: Label 'CIF/NIF';
    GiroNoCaptionLbl: Label 'Nº giro postal';
    BankNameCaptionLbl: Label 'Banco';
    BankAccNoCaptionLbl: Label 'Nº cuenta';
    // GAP00041 >>>
    //ShipmentNoCaptionLbl: Label 'Fecha envió';
    ShipmentNoCaptionLbl: Label 'N° albarán';
    // GAP00041 <<<
    ShipmentDateCaptionLbl: Label 'Posting Date';
    HomePageCaptionLbl: Label 'Home Page';
    EmailCaptionLbl: Label 'E-Mail';
    DocumentDateCaptionLbl: Label 'Fecha emisión documento';
    HeaderDimensionsCaptionLbl: Label 'Header Dimensions';
    LineDimensionsCaptionLbl: Label 'Line Dimensions';
    BilltoAddressCaptionLbl: Label 'Bill-to Address';
    QuantityCaptionLbl: Label 'Quantity';
    SerialNoCaptionLbl: Label 'Serial No.';
    LotNoCaptionLbl: Label 'Lot No.';
    DescriptionCaptionLbl: Label 'Descripción';
    NoCaptionLbl: Label 'No.';
    PageCaptionCap: Label 'Pagina %1 of %2';
    gn_ImporteLinea: Decimal;
    TITTotalIncl: Label 'Total %1 Incl. VAT+EC';
    TITTotalExcl: Label 'Total %1 Excl. VAT+EC';
    gs_TextoTotalIncl: Text[100];
    gs_TextoTotalExcl: Text[100];
    gvs_VentaAddr: array[8]of Text[50];
    gb_TieneComentarios: Boolean;
    TITImporteIVA: Label 'Amount VAT+EC';
    COLPrecio: Label 'Sales Price';
    COLPorcDto: Label '% Disc.';
    COLPorcIVA: Label '% VAT';
    COLImporte: Label 'Amount';
    COLComentarios: Label 'Comments';
    TITSubtotal: Label 'Subtotal';
    TITImporteDescFact: Label 'Invoice discount amount';
    TITImporteDescPago: Label 'Payment discount amount';
    TITFormaDePago: Label 'Forma de pago';
    TITTerminosDePago: Label 'Término de pago';
    TITBanco: Label 'Bank';
    gs_Banco: Text[100];
    gs_FormaDePago: Text[100];
    gs_TerminosDePago: Text[100];
    gb_OcultaInfoEmpresa: Boolean;
    gb_PrimerRegistro: Boolean;
    go_MuestraCabecera: Option Mostrar, "No mostrar", "Mostrar solo logo";
    LBL_DireccionFiscal: Label 'Dirección fiscal';
    LBL_DireccionEnvio: Label 'Dirección envío';
    txt_Lote: Label 'Lot: %1, Cantidad: %2';
    txt_LoteFechaCaducidad: Label ', Fecha de caducidad: %1';
    var_CaptionLote: Text;
    PhoneCustomerLbl: Label 'Nº teléfono Cliente';
    gs_AliasCLiente: Text[50];
    gs_TelefonoCliente: Text[30];
    AliasCustomerLbl: Label 'Alias Cliente';
    NumClienteLbl: Label 'Nº Cliente';
    TextDevoluciones: Label 'No se aceptan devoluciones de producto pasadas 24h desde la recepción del pedido.';
    gs_DireccionEnvioHorarioEntrega: Text[50];
    gt_DireccionEnvio: Record 222;
    gs_DireccionEnvioNumeroTelefono: Text[30];
    gs_CantidadUnidadLogistica: Text[30];
    gs_UnidadLogistica: Text[30];
    LBL_UnidadLogistica: Label 'Ud. Logística';
    LBL_CantidadUnidadLogistica: Label 'Cantidad / U.L.';
    gt_UnidadMedida: Record 5404;
    gn_CantidadUL: Decimal;
    gn_TotalBultos: Decimal;
    gt_Producto: Record 27;
    gn_TotalPesoBruto: Decimal;
    LBL_Logistica: Label 'Logística:';
    LBL_TotalBultos: Label 'Total Bultos:';
    LBL_TotalPeso: Label 'Total Kg:';
    CabAlbaran_Total2: Decimal;
    CabAlbaran_Total1: Decimal;
    CabAlbaran_ImporteIVA: Decimal;
    procedure InitLogInteraction()
    begin
        //LogInteraction := SegManagement.FindInteractTmplCode(5) <> '';
        LogInteraction:=SegManagement.FindInteractionTemplateCode("Interaction Log Entry Document Type"::"Sales Shpt. Note") <> '';
    end;
    procedure InitializeRequest(NewNoOfCopies: Integer; NewShowInternalInfo: Boolean; NewLogInteraction: Boolean; NewShowCorrectionLines: Boolean; NewShowLotSN: Boolean; DisplayAsmInfo: Boolean)
    begin
        NoOfCopies:=NewNoOfCopies;
        ShowInternalInfo:=NewShowInternalInfo;
        LogInteraction:=NewLogInteraction;
        ShowCorrectionLines:=NewShowCorrectionLines;
        ShowLotSN:=NewShowLotSN;
        DisplayAssemblyInformation:=DisplayAsmInfo;
    end;
    procedure GetUnitOfMeasureDescr(UOMCode: Code[10]): Text[10]var
        UnitOfMeasure: Record 204;
    begin
        IF NOT UnitOfMeasure.GET(UOMCode)THEN EXIT(UOMCode);
        EXIT(UnitOfMeasure.Description);
    end;
    procedure BlanksForIndent(): Text[10]begin
        EXIT(PADSTR('', 2, ' '));
    end;
}
