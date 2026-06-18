report 50062 AlxSales_Invoice
{
    //A01: Inicio
    // 
    // ADVANCE - Log de cambios
    // -----------------------------------------------------
    //   ADVANCE
    //   Fecha: 13-04-2016
    //   Técnico: JMAP
    //   Presupuesto: Proyecto I002433 - Modificación de informes
    // 
    //   Etiqueta: ADV001
    // -----------------------------------------------------
    Caption = 'Factura';
    Permissions = TableData 7190=rimd;
    PreviewMode = PrintLayout;
    ApplicationArea = Basic, Suite;
    DefaultRenderingLayout = ImpresionPorConceptoGenerico;

    dataset
    {
        dataitem("Sales Invoice Header";112)
        {
            DataItemTableView = SORTING("No.");

            column(No_SalesInvHdr; "No.")
            {
            }
            column(PaymentTermsDescription; PaymentTerms.Description)
            {
            }
            column(ShipmentMethodDescription; ShipmentMethod.Description)
            {
            }
            column(PaymentMethodDescription; PaymentMethod.Description)
            {
            }
            column(PmtTermsDescCaption; PmtTermsDescCaptionLbl)
            {
            }
            column(ShpMethodDescCaption; ShpMethodDescCaptionLbl)
            {
            }
            column(PmtMethodDescCaption; PmtMethodDescCaptionLbl)
            {
            }
            column(DocDateCaption; DocDateCaptionLbl)
            {
            }
            column(HomePageCaption; HomePageCaptionCap)
            {
            }
            column(EmailCaption; EmailCaptionLbl)
            {
            }
            column(DisplayAdditionalFeeNote; DisplayAdditionalFeeNote)
            {
            }
            column(NoEvento_SalesInvHdr; NoEvento)
            {
            }
            column(TipoImpresion_SalesInvHdr; "Tipo de Impresión")
            {
            }
            column(ImprimirComentarios_SalesInvHdr; "No Impresion Comentarios")
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
                    column(DocumentCaption; STRSUBSTNO(DocumentCaption, CopyText))
                    {
                    }
                    column(CustAddr1; CustAddr[1])
                    {
                    }
                    column(CompanyAddr1; CompanyAddr[1])
                    {
                    }
                    column(CustAddr2; CustAddr[2])
                    {
                    }
                    column(CompanyAddr2; CompanyAddr[2])
                    {
                    }
                    column(CustAddr3; CustAddr[3])
                    {
                    }
                    column(CompanyAddr3; CompanyAddr[3])
                    {
                    }
                    column(CustAddr4; CustAddr[4])
                    {
                    }
                    column(CompanyAddr4; CompanyAddr[4])
                    {
                    }
                    column(CustAddr5; CustAddr[5])
                    {
                    }
                    column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
                    {
                    }
                    column(CustAddr6; CustAddr[6])
                    {
                    }
                    column(CompanyInfoVATRegistrationNo; CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(CompanyInfoHomePage;'') //CompanyInfo."Home Page") // No se utiliza.
                    {
                    }
                    column(CompanyInfoEmail; CompanyInfo."E-Mail")
                    {
                    }
                    column(CompanyInfoFaxNo; CompanyInfo."Fax No.")
                    {
                    }
                    column(CompanyInfoBankName; CompanyInfo."Bank Name")
                    {
                    }
                    column(CompanyInfoBankAccountNo; CompanyInfo."Bank Account No.")
                    {
                    }
                    column(BilltoCustNo_SalesInvHdr; "Sales Invoice Header"."Bill-to Customer No.")
                    {
                    }
                    column(PostingDate_SalesInvHdr; FORMAT("Sales Invoice Header"."Posting Date", 0, 4))
                    {
                    }
                    column(VATNoText; VATNoText)
                    {
                    }
                    column(VATRegNo_SalesInvHeader; "Sales Invoice Header"."VAT Registration No.")
                    {
                    }
                    column(DueDate_SalesInvHeader; FORMAT("Sales Invoice Header"."Due Date", 0, 4))
                    {
                    }
                    column(SalesPersonText; SalesPersonText)
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(No_SalesInvoiceHeader1; "Sales Invoice Header"."No.")
                    {
                    }
                    column(ReferenceText; ReferenceText)
                    {
                    }
                    column(YourReference_SalesInvHdr; "Sales Invoice Header"."Your Reference")
                    {
                    }
                    column(NoDocExtCaption; NoDocExternLbl)
                    {
                    }
                    column(ExternalDocNo_SalesInvHdr; "Sales Invoice Header"."External Document No.")
                    {
                    }
                    column(OrderNoText; OrderNoText)
                    {
                    }
                    column(OrderNo_SalesInvHeader; "Sales Invoice Header"."Order No.")
                    {
                    }
                    column(CustAddr7; CustAddr[7])
                    {
                    }
                    column(CustAddr8; CustAddr[8])
                    {
                    }
                    column(CompanyAddr5; CompanyAddr[5])
                    {
                    }
                    column(CompanyAddr6; CompanyAddr[6])
                    {
                    }
                    column(DocDate_SalesInvoiceHdr; FORMAT("Sales Invoice Header"."Document Date", 0, 4))
                    {
                    }
                    column(PricesInclVAT_SalesInvHdr; "Sales Invoice Header"."Prices Including VAT")
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(PricesInclVATYesNo; FORMAT("Sales Invoice Header"."Prices Including VAT"))
                    {
                    }
                    column(PageCaption; PageCaptionCap)
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
                    column(DueDateCaption; DueDateCaptionLbl)
                    {
                    }
                    column(InvoiceNoCaption; InvoiceNoCaptionLbl)
                    {
                    }
                    column(PostingDateCaption; PostingDateCaptionLbl)
                    {
                    }
                    column(BilltoCustNo_SalesInvHdrCaption; "Sales Invoice Header".FIELDCAPTION("Bill-to Customer No."))
                    {
                    }
                    column(PricesInclVAT_SalesInvHdrCaption; "Sales Invoice Header".FIELDCAPTION("Prices Including VAT"))
                    {
                    }
                    column(CACCaption; CACCaptionLbl)
                    {
                    }
                    column(Factura_MuestraDescuento; gb_MuestraDescuento)
                    {
                    }
                    column(FaxNoCaption; FaxNoCaptionLbl)
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
                    column(CompanyInfo_TextoRegistro; CompanyInfo.Business_Register_Text_alx)
                    {
                    }
                    column(CompanyInfo_ClausulaRGPD; CompanyInfo.Clausula_alx)
                    {
                    }
                    column(Cabecera_Banco; gs_BancoCabecera)
                    {
                    }
                    column(ImportePdteCaption; ImportePdteLbl)
                    {
                    }
                    column(Cabecera_ImpPdte; ImpPdte)
                    {
                    }
                    column(TextoPieCaption; TextoPieLbl)
                    {
                    }
                    /*  column(Cabecera_Cobrado; "Sales Invoice Header".Cobrado)
                     {
                     }  */
                    column(Cabecera_Cobrado;'')
                    {
                    }
                    dataitem(DimensionLoop1;2000000026)
                    {
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = SORTING(Number)WHERE(Number=FILTER(1..));

                        column(DimText; DimText)
                        {
                        }
                        column(Number_DimensionLoop1; Number)
                        {
                        }
                        column(HdrDimsCaption; HdrDimsCaptionLbl)
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
                                IF DimText = '' THEN DimText:=STRSUBSTNO('%1 %2', DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code")
                                ELSE
                                    DimText:=STRSUBSTNO('%1, %2 %3', DimText, DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code");
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
                    dataitem("Sales Invoice Line";113)
                    {
                        DataItemLink = "Document No."=FIELD("No.");
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = SORTING("Document No.", "Line No.");

                        column(GetCarteraInvoice; GetCarteraInvoice)
                        {
                        }
                        column(LineAmt_SalesInvoiceLine; "Line Amount")
                        {
                        AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                        AutoFormatType = 1;
                        }
                        column(Description_SalesInvLine; Description)
                        {
                        }
                        column(No_SalesInvoiceLine; "No.")
                        {
                        }
                        column(Quantity_SalesInvoiceLine; Quantity)
                        {
                        }
                        column(UOM_SalesInvoiceLine; "Unit of Measure")
                        {
                        }
                        column(UnitPrice_SalesInvLine; "Unit Price")
                        {
                        AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                        AutoFormatType = 2;
                        }
                        column(LineDisc_SalesInvoiceLine; "Line Discount %")
                        {
                        }
                        column(VATIdent_SalesInvLine; "VAT Identifier")
                        {
                        }
                        column(PostedShipmentDate; FORMAT(PostedShipmentDate))
                        {
                        }
                        column(Type_SalesInvoiceLine; FORMAT("Sales Invoice Line".Type))
                        {
                        }
                        column(InvDiscountAmount;-"Inv. Discount Amount")
                        {
                        AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                        AutoFormatType = 1;
                        }
                        column(TotalSubTotal; TotalSubTotal)
                        {
                        AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(TotalInvoiceDiscountAmount; TotalInvoiceDiscountAmount)
                        {
                        AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(TotalAmount; TotalAmount)
                        {
                        AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(TotalGivenAmount; TotalGivenAmount)
                        {
                        }
                        column(SalesInvoiceLineAmount; Amount)
                        {
                        AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                        AutoFormatType = 1;
                        }
                        column(AmountIncludingVATAmount; "Amount Including VAT" - Amount)
                        {
                        AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                        AutoFormatType = 1;
                        }
                        column(Amount_SalesInvoiceLineIncludingVAT; "Amount Including VAT")
                        {
                        AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                        AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmtText; VATAmountLine.VATAmountText)
                        {
                        }
                        column(TotalExclVATText; TotalExclVATText)
                        {
                        }
                        column(TotalInclVATText; TotalInclVATText)
                        {
                        }
                        column(TotalAmountInclVAT; TotalAmountInclVAT)
                        {
                        AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(TotalAmountVAT; TotalAmountVAT)
                        {
                        AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(VATBaseDisc_SalesInvHdr; "Sales Invoice Header"."VAT Base Discount %")
                        {
                        AutoFormatType = 1;
                        }
                        column(TotalPaymentDiscountOnVAT; TotalPaymentDiscountOnVAT)
                        {
                        AutoFormatType = 1;
                        }
                        column(VATAmtLineVATCalcType; VATAmountLine."VAT Calculation Type")
                        {
                        }
                        column(LineNo_SalesInvoiceLine; "Line No.")
                        {
                        }
                        column(PmtinvfromdebtpaidtoFactCompCaption; PmtinvfromdebtpaidtoFactCompCaptionLbl)
                        {
                        }
                        column(UnitPriceCaption; UnitPriceCaptionLbl)
                        {
                        }
                        column(DiscountCaption; DiscountCaptionLbl)
                        {
                        }
                        column(AmtCaption; AmtCaptionLbl)
                        {
                        }
                        column(PostedShpDateCaption; PostedShpDateCaptionLbl)
                        {
                        }
                        column(InvDiscAmtCaption; InvDiscAmtCaptionLbl)
                        {
                        }
                        column(SubtotalCaption; SubtotalCaptionLbl)
                        {
                        }
                        column(PmtDiscGivenAmtCaption; PmtDiscGivenAmtCaptionLbl)
                        {
                        }
                        column(PmtDiscVATCaption; PmtDiscVATCaptionLbl)
                        {
                        }
                        column(Description_SalesInvLineCaption; FIELDCAPTION(Description))
                        {
                        }
                        column(No_SalesInvoiceLineCaption; FIELDCAPTION("No."))
                        {
                        }
                        column(Quantity_SalesInvoiceLineCaption; FIELDCAPTION(Quantity))
                        {
                        }
                        column(UOM_SalesInvoiceLineCaption; FIELDCAPTION("Unit of Measure"))
                        {
                        }
                        column(VATIdent_SalesInvLineCaption; VATIdentifierCaptionLbl)
                        {
                        }
                        column(Type_SalesInvLne; Type.AsInteger())
                        {
                        }
                        column(Evento_ConceptoGenericoFacturacion; ConceptoGenFactTxt)
                        {
                        }
                        column(Evento_CGF_Cant; ConceptoGenFactCant)
                        {
                        }
                        column(Evento_CGF_PV; ConceptoGenFactPV)
                        {
                        }
                        column(Evento_CGF_IVA; ConceptoGenFactIVA)
                        {
                        }
                        column(Evento_CGF_Imp; ConceptoGenFactImp)
                        {
                        }
                        column(Evento_ImpConceptAdulto_Desc; ImpPorCapituloAdultoDesc)
                        {
                        }
                        column(Evento_ImpConceptAdulto_Cant; ImpPorCapituloAdultoCant)
                        {
                        }
                        column(Evento_ImpConceptAdulto_PV; ImpPorCapituloAdultoPV)
                        {
                        }
                        column(Evento_ImpConceptAdulto_IVA; ImpPorCapituloAdultoIVA)
                        {
                        }
                        column(Evento_ImpConceptAdulto_Imp; ImpPorCapituloAdultoImp)
                        {
                        }
                        column(Evento_ImpConceptNinno_Desc; ImpPorCapituloNinnoDesc)
                        {
                        }
                        column(Evento_ImpConceptNinno_Cant; ImpPorCapituloNinnoCant)
                        {
                        }
                        column(Evento_ImpConceptNinno_PV; ImpPorCapituloNinnoPV)
                        {
                        }
                        column(Evento_ImpConceptNinno_IVA; ImpPorCapituloNinnoIVA)
                        {
                        }
                        column(Evento_ImpConceptNinno_Imp; ImpPorCapituloNinnoImp)
                        {
                        }
                        column(Evento_ImpConceptOtros_Desc; ImpPorCapituloOtrosDesc)
                        {
                        }
                        column(Evento_ImpConceptOtros_Cant; ImpPorCapituloOtrosCant)
                        {
                        }
                        column(Evento_ImpConceptOtros_PV; ImpPorCapituloOtrosPV)
                        {
                        }
                        column(Evento_ImpConceptOtros_IVA; ImpPorCapituloOtrosIVA)
                        {
                        }
                        column(Evento_ImpConceptOtros_Imp; ImpPorCapituloOtrosImp)
                        {
                        }
                        dataitem("Sales Shipment Buffer";2000000026)
                        {
                            DataItemTableView = SORTING(Number);

                            column(PostingDate_SalesShipmentBuffer; FORMAT(SalesShipmentBuffer."Posting Date"))
                            {
                            }
                            column(Quantity_SalesShipmentBuffer; SalesShipmentBuffer.Quantity)
                            {
                            DecimalPlaces = 0: 5;
                            }
                            column(ShpCaption; ShpCaptionLbl)
                            {
                            }
                            trigger OnAfterGetRecord()
                            begin
                                IF Number = 1 THEN SalesShipmentBuffer.FIND('-')
                                ELSE
                                    SalesShipmentBuffer.NEXT;
                            end;
                            trigger OnPreDataItem()
                            begin
                                SalesShipmentBuffer.SETRANGE("Document No.", "Sales Invoice Line"."Document No.");
                                SalesShipmentBuffer.SETRANGE("Line No.", "Sales Invoice Line"."Line No.");
                                SETRANGE(Number, 1, SalesShipmentBuffer.COUNT);
                            end;
                        }
                        dataitem(DimensionLoop2;2000000026)
                        {
                            DataItemTableView = SORTING(Number)WHERE(Number=FILTER(1..));

                            column(DimText1; DimText)
                            {
                            }
                            column(LineDimsCaption; LineDimsCaptionLbl)
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
                                    IF DimText = '' THEN DimText:=STRSUBSTNO('%1 %2', DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code")
                                    ELSE
                                        DimText:=STRSUBSTNO('%1, %2 %3', DimText, DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code");
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
                                DimSetEntry2.SETRANGE("Dimension Set ID", "Sales Invoice Line"."Dimension Set ID");
                            end;
                        }
                        dataitem(AsmLoop;2000000026)
                        {
                            DataItemTableView = SORTING(Number);

                            column(TempPostedAsmLineUOMCode; GetUOMText(TempPostedAsmLine."Unit of Measure Code"))
                            {
                            //DecimalPlaces = 0 : 5;
                            }
                            column(TempPostedAsmLineQuantity; TempPostedAsmLine.Quantity)
                            {
                            DecimalPlaces = 0: 5;
                            }
                            column(TempPostedAsmLineVariantCode; BlanksForIndent + TempPostedAsmLine."Variant Code")
                            {
                            //DecimalPlaces = 0 : 5;
                            }
                            column(TempPostedAsmLineDescrip; BlanksForIndent + TempPostedAsmLine.Description)
                            {
                            }
                            column(TempPostedAsmLineNo; BlanksForIndent + TempPostedAsmLine."No.")
                            {
                            }
                            trigger OnAfterGetRecord()
                            var
                                ItemTranslation: Record 30;
                            begin
                                IF Number = 1 THEN TempPostedAsmLine.FINDSET
                                ELSE
                                    TempPostedAsmLine.NEXT;
                                IF ItemTranslation.GET(TempPostedAsmLine."No.", TempPostedAsmLine."Variant Code", "Sales Invoice Header"."Language Code")THEN TempPostedAsmLine.Description:=ItemTranslation.Description;
                            end;
                            trigger OnPreDataItem()
                            begin
                                CLEAR(TempPostedAsmLine);
                                IF NOT DisplayAssemblyInformation THEN CurrReport.BREAK;
                                CollectAsmInformation;
                                CLEAR(TempPostedAsmLine);
                                SETRANGE(Number, 1, TempPostedAsmLine.COUNT);
                            end;
                        }
                        trigger OnAfterGetRecord()
                        begin
                            PostedShipmentDate:=0D;
                            IF Quantity <> 0 THEN PostedShipmentDate:=FindPostedShipmentDate;
                            IF(Type = Type::"G/L Account") AND (NOT ShowInternalInfo)THEN "No.":='';
                            IF VATPostingSetup.GET("Sales Invoice Line"."VAT Bus. Posting Group", "Sales Invoice Line"."VAT Prod. Posting Group")THEN BEGIN
                                VATAmountLine.INIT;
                                VATAmountLine."VAT Identifier":="VAT Identifier";
                                VATAmountLine."VAT Calculation Type":="VAT Calculation Type";
                                VATAmountLine."Tax Group Code":="Tax Group Code";
                                VATAmountLine."VAT %":=VATPostingSetup."VAT %";
                                VATAmountLine."EC %":=VATPostingSetup."EC %";
                                VATAmountLine."VAT Base":="Sales Invoice Line".Amount;
                                VATAmountLine."Amount Including VAT":="Sales Invoice Line"."Amount Including VAT";
                                VATAmountLine."Line Amount":="Line Amount";
                                VATAmountLine."Pmt. Discount Amount":="Pmt. Discount Amount";
                                IF "Allow Invoice Disc." THEN VATAmountLine."Inv. Disc. Base Amount":="Line Amount";
                                VATAmountLine."Invoice Discount Amount":="Inv. Discount Amount";
                                VATAmountLine.SetCurrencyCode("Sales Invoice Header"."Currency Code");
                                VATAmountLine."VAT Difference":="VAT Difference";
                                VATAmountLine."EC Difference":="EC Difference";
                                IF "Sales Invoice Header"."Prices Including VAT" THEN VATAmountLine."Prices Including VAT":=TRUE;
                                VATAmountLine."VAT Clause Code":="VAT Clause Code";
                                VATAmountLine.InsertLine;
                                TotalSubTotal+="Line Amount";
                                TotalInvoiceDiscountAmount-="Inv. Discount Amount";
                                TotalAmount+=Amount;
                                TotalAmountVAT+="Amount Including VAT" - Amount;
                                TotalAmountInclVAT+="Amount Including VAT";
                                TotalGivenAmount-="Pmt. Discount Amount";
                                TotalPaymentDiscountOnVAT+=-("Line Amount" - "Inv. Discount Amount" - "Pmt. Discount Amount" - "Amount Including VAT");
                            END;
                            ConceptoGenFactTxt:='';
                            if "Sales Invoice Header"."Tipo de Impresión" = Enum::AlxiaEventoTipodeImpresion::"Impresion Concepto Generico" then begin
                                ConceptoGenFactCant:=1;
                                ConceptoGenFactPV:=0;
                                ConceptoGenFactIVA:=0;
                                ConceptoGenFactImp:=0;
                                if MostrarLineaEvento()then begin
                                    Evento.Get("Sales Invoice Header".NoEvento);
                                    Evento.TestField("Concepto Generico Facturacion");
                                    ConceptoGenFactTxt:=Evento."Concepto Generico Facturacion";
                                    Cantidad_ConceptoGenericoFacturacion();
                                end;
                            end;
                            ImpPorCapituloAdultoDesc:='';
                            ImpPorCapituloNinnoDesc:='';
                            ImpPorCapituloOtrosDesc:='';
                            if "Sales Invoice Header"."Tipo de Impresión" = Enum::AlxiaEventoTipodeImpresion::"Impresion por Capitulo" then if MostrarLineaEvento()then begin
                                    ImpresionPorCapitulo_LineaAdulto("Sales Invoice Header".NoEvento);
                                    ImpresionPorCapitulo_LineaNinno("Sales Invoice Header".NoEvento);
                                    ImpresionPorCapitulo_LineaOtros("Sales Invoice Header".NoEvento);
                                end;
                        end;
                        trigger OnPreDataItem()
                        begin
                            if "Sales Invoice Header"."No Impresion Comentarios" then SetFilter(Type, '<>%1', 0);
                            VATAmountLine.DELETEALL;
                            SalesShipmentBuffer.RESET;
                            SalesShipmentBuffer.DELETEALL;
                            FirstValueEntryNo:=0;
                            MoreLines:=FIND('+');
                            WHILE MoreLines AND (Description = '') AND ("No." = '') AND (Quantity = 0) AND (Amount = 0)DO MoreLines:=NEXT(-1) <> 0;
                            IF NOT MoreLines THEN CurrReport.BREAK;
                            SETRANGE("Line No.", 0, "Line No.");
                        end;
                    }
                    dataitem(VATCounter;2000000026)
                    {
                        DataItemTableView = SORTING(Number);

                        column(VATAmountLineVATBase; VATAmountLine."VAT Base")
                        {
                        AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                        AutoFormatType = 1;
                        }
                        column(VATAmountLineVATAmount; VATAmountLine."VAT Amount")
                        {
                        AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(VATAmountLineLineAmount; VATAmountLine."Line Amount")
                        {
                        AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscBaseAmt; VATAmountLine."Inv. Disc. Base Amount")
                        {
                        AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscountAmt; VATAmountLine."Invoice Discount Amount" + VATAmountLine."Pmt. Discount Amount")
                        {
                        AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(VATAmtLineECAmount; VATAmountLine."EC Amount")
                        {
                        AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(VATAmountLineVAT; VATAmountLine."VAT %")
                        {
                        DecimalPlaces = 0: 6;
                        }
                        column(VATAmtLineVATIdentifier; VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATAmountLineEC; VATAmountLine."EC %")
                        {
                        AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(VATAmtLineVATCaption; VATAmtLineVATCaptionLbl)
                        {
                        }
                        column(VATECBaseCaption; VATECBaseCaptionLbl)
                        {
                        }
                        column(VATAmountCaption; VATAmountCaptionLbl)
                        {
                        }
                        column(VATAmtSpecCaption; VATAmtSpecCaptionLbl)
                        {
                        }
                        column(VATIdentCaption; VATIdentCaptionLbl)
                        {
                        }
                        column(InvDiscBaseAmtCaption; InvDiscBaseAmtCaptionLbl)
                        {
                        }
                        column(LineAmtCaption1; LineAmtCaption1Lbl)
                        {
                        }
                        column(InvPmtDiscCaption; InvPmtDiscCaptionLbl)
                        {
                        }
                        column(ECAmtCaption; ECAmtCaptionLbl)
                        {
                        }
                        column(ECCaption; ECCaptionLbl)
                        {
                        }
                        column(TotalCaption; TotalCaptionLbl)
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                            IF VATAmountLine."VAT Amount" = 0 THEN VATAmountLine."VAT %":=0;
                            IF VATAmountLine."EC Amount" = 0 THEN VATAmountLine."EC %":=0;
                        end;
                        trigger OnPreDataItem()
                        begin
                            SETRANGE(Number, 1, VATAmountLine.COUNT);
                        /*  CurrReport.CREATETOTALS(
                             VATAmountLine."Line Amount", VATAmountLine."Inv. Disc. Base Amount",
                             VATAmountLine."Invoice Discount Amount", VATAmountLine."VAT Base", VATAmountLine."VAT Amount",
                             VATAmountLine."EC Amount", VATAmountLine."Pmt. Discount Amount"); */
                        end;
                    }
                    dataitem(VATClauseEntryCounter;2000000026)
                    {
                        DataItemTableView = SORTING(Number);

                        column(VATClauseVATIdentifier; VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATClauseCode; VATAmountLine."VAT Clause Code")
                        {
                        }
                        column(VATClauseDescription; VATClause.Description)
                        {
                        }
                        column(VATClauseDescription2; VATClause."Description 2")
                        {
                        }
                        column(VATClauseAmount; VATAmountLine."VAT Amount")
                        {
                        AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(VATClausesCaption; VATClausesCap)
                        {
                        }
                        column(VATClauseVATIdentifierCaption; VATIdentifierCaptionLbl)
                        {
                        }
                        column(VATClauseVATAmtCaption; VATAmtCaptionLbl)
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                            IF NOT VATClause.GET(VATAmountLine."VAT Clause Code")THEN CurrReport.SKIP;
                            VATClause.TranslateDescription("Sales Invoice Header"."Language Code");
                        end;
                        trigger OnPreDataItem()
                        begin
                            CLEAR(VATClause);
                            SETRANGE(Number, 1, VATAmountLine.COUNT);
                        //CurrReport.CREATETOTALS(VATAmountLine."VAT Amount");
                        end;
                    }
                    dataitem(VatCounterLCY;2000000026)
                    {
                        DataItemTableView = SORTING(Number);

                        column(VALSpecLCYHeader; VALSpecLCYHeader)
                        {
                        }
                        column(VALExchRate; VALExchRate)
                        {
                        }
                        column(VALVATBaseLCY; VALVATBaseLCY)
                        {
                        AutoFormatType = 1;
                        }
                        column(VALVATAmountLCY; VALVATAmountLCY)
                        {
                        AutoFormatType = 1;
                        }
                        column(VATAmountLineVAT1; VATAmountLine."VAT %")
                        {
                        DecimalPlaces = 0: 5;
                        }
                        column(VATAmtLineVATIdentifier1; VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VALVATBaseLCYCaption1; VALVATBaseLCYCaption1Lbl)
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                            VALVATBaseLCY:=VATAmountLine.GetBaseLCY("Sales Invoice Header"."Posting Date", "Sales Invoice Header"."Currency Code", "Sales Invoice Header"."Currency Factor");
                            VALVATAmountLCY:=VATAmountLine.GetAmountLCY("Sales Invoice Header"."Posting Date", "Sales Invoice Header"."Currency Code", "Sales Invoice Header"."Currency Factor");
                        end;
                        trigger OnPreDataItem()
                        begin
                            IF(NOT GLSetup."Print VAT specification in LCY") OR ("Sales Invoice Header"."Currency Code" = '')THEN CurrReport.BREAK;
                            SETRANGE(Number, 1, VATAmountLine.COUNT);
                            //CurrReport.CREATETOTALS(VALVATBaseLCY, VALVATAmountLCY);
                            IF GLSetup."LCY Code" = '' THEN VALSpecLCYHeader:=Text007 + Text008
                            ELSE
                                VALSpecLCYHeader:=Text007 + FORMAT(GLSetup."LCY Code");
                            CurrExchRate.FindCurrency("Sales Invoice Header"."Posting Date", "Sales Invoice Header"."Currency Code", 1);
                            CalculatedExchRate:=ROUND(1 / "Sales Invoice Header"."Currency Factor" * CurrExchRate."Exchange Rate Amount", 0.000001);
                            VALExchRate:=STRSUBSTNO(Text009, CalculatedExchRate, CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem(Total;2000000026)
                    {
                        DataItemTableView = SORTING(Number)WHERE(Number=CONST(1));
                    }
                    dataitem(Total2;2000000026)
                    {
                        DataItemTableView = SORTING(Number)WHERE(Number=CONST(1));

                        column(SelltoCustNo_SalesInvHdr; "Sales Invoice Header"."Sell-to Customer No.")
                        {
                        }
                        column(ShipToAddr1; ShipToAddr[1])
                        {
                        }
                        column(ShipToAddr2; ShipToAddr[2])
                        {
                        }
                        column(ShipToAddr3; ShipToAddr[3])
                        {
                        }
                        column(ShipToAddr4; ShipToAddr[4])
                        {
                        }
                        column(ShipToAddr5; ShipToAddr[5])
                        {
                        }
                        column(ShipToAddr6; ShipToAddr[6])
                        {
                        }
                        column(ShipToAddr7; ShipToAddr[7])
                        {
                        }
                        column(ShipToAddr8; ShipToAddr[8])
                        {
                        }
                        column(ShiptoAddressCaption; ShiptoAddressCaptionLbl)
                        {
                        }
                        column(SelltoCustNo_SalesInvHdrCaption; "Sales Invoice Header".FIELDCAPTION("Sell-to Customer No."))
                        {
                        }
                        trigger OnPreDataItem()
                        begin
                            IF NOT ShowShippingAddr THEN CurrReport.BREAK;
                        end;
                    }
                    dataitem(LineFee;2000000026)
                    {
                        DataItemTableView = SORTING(Number)ORDER(Ascending)WHERE(Number=FILTER(1..));

                        column(LineFeeCaptionLbl; TempLineFeeNoteOnReportHist.ReportText)
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            IF NOT DisplayAdditionalFeeNote THEN CurrReport.BREAK;
                            IF Number = 1 THEN BEGIN
                                IF NOT TempLineFeeNoteOnReportHist.FINDSET THEN CurrReport.BREAK END
                            ELSE IF TempLineFeeNoteOnReportHist.NEXT = 0 THEN CurrReport.BREAK;
                        end;
                    }
                }
                trigger OnAfterGetRecord()
                begin
                    IF Number > 1 THEN BEGIN
                        CopyText:=Text003;
                        OutputNo+=1;
                    END;
                    //CurrReport.PAGENO := 1;
                    TotalSubTotal:=0;
                    TotalInvoiceDiscountAmount:=0;
                    TotalAmount:=0;
                    TotalAmountVAT:=0;
                    TotalAmountInclVAT:=0;
                    TotalGivenAmount:=0;
                    TotalPaymentDiscountOnVAT:=0;
                end;
                trigger OnPostDataItem()
                begin
                    IF NOT CurrReport.PREVIEW THEN SalesInvCountPrinted.RUN("Sales Invoice Header");
                end;
                trigger OnPreDataItem()
                begin
                    NoOfLoops:=ABS(NoOfCopies) + Cust."Invoice Copies" + 1;
                    IF NoOfLoops <= 0 THEN NoOfLoops:=1;
                    CopyText:='';
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo:=1;
                end;
            }
            trigger OnPreDataItem()
            begin
                if NroFactura <> '' then SetRange("No.", NroFactura);
            end;
            trigger OnAfterGetRecord()
            var
                lt_LinFact: Record 113;
                lt_FormaPago: Record 289;
                lt_Banco: Record 270;
                lt_MovsCliente: Record 21;
            begin
                CurrReport.LANGUAGE:=_Language.GetLanguageID('ESP');
                IF RespCenter.GET("Responsibility Center")THEN BEGIN
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No.":=RespCenter."Phone No.";
                    CompanyInfo."Fax No.":=RespCenter."Fax No.";
                END
                ELSE
                    FormatAddr.Company(CompanyAddr, CompanyInfo);
                DimSetEntry1.SETRANGE("Dimension Set ID", "Dimension Set ID");
                //ADV001 IF "Order No." = '' THEN
                //ADV001   OrderNoText := ''
                //ADV001 ELSE
                OrderNoText:=FIELDCAPTION("Order No.");
                IF "Salesperson Code" = '' THEN BEGIN
                    SalesPurchPerson.INIT;
                    SalesPersonText:='';
                END
                ELSE
                BEGIN
                    SalesPurchPerson.GET("Salesperson Code");
                    SalesPersonText:=Text000;
                END;
                //ADV001 IF "Your Reference" = '' THEN
                //ADV001   ReferenceText := ''
                //ADV001 ELSE
                ReferenceText:=FIELDCAPTION("Your Reference");
                //ADV001 IF "VAT Registration No." = '' THEN
                //ADV001   VATNoText := ''
                //ADV001 ELSE
                VATNoText:=FIELDCAPTION("VAT Registration No.");
                IF "Currency Code" = '' THEN BEGIN
                    GLSetup.TESTFIELD("LCY Code");
                    TotalText:=STRSUBSTNO(Text001, GLSetup."LCY Code");
                    TotalInclVATText:=STRSUBSTNO(Text1100000, GLSetup."LCY Code");
                    TotalExclVATText:=STRSUBSTNO(Text1100001, GLSetup."LCY Code");
                END
                ELSE
                BEGIN
                    TotalText:=STRSUBSTNO(Text001, "Currency Code");
                    TotalInclVATText:=STRSUBSTNO(Text1100000, "Currency Code");
                    TotalExclVATText:=STRSUBSTNO(Text1100001, "Currency Code");
                END;
                FormatAddr.SalesInvBillTo(CustAddr, "Sales Invoice Header");
                IF NOT Cust.GET("Bill-to Customer No.")THEN CLEAR(Cust);
                IF "Payment Terms Code" = '' THEN PaymentTerms.INIT
                ELSE
                BEGIN
                    PaymentTerms.GET("Payment Terms Code");
                    PaymentTerms.TranslateDescription(PaymentTerms, "Language Code");
                END;
                IF "Payment Method Code" = '' THEN PaymentMethod.INIT
                ELSE
                    PaymentMethod.GET("Payment Method Code");
                IF "Shipment Method Code" = '' THEN ShipmentMethod.INIT
                ELSE
                BEGIN
                    ShipmentMethod.GET("Shipment Method Code");
                    ShipmentMethod.TranslateDescription(ShipmentMethod, "Language Code");
                END;
                FormatAddr.SalesInvShipTo(ShipToAddr, CustAddr, "Sales Invoice Header");
                ShowShippingAddr:="Sell-to Customer No." <> "Bill-to Customer No.";
                FOR i:=1 TO ARRAYLEN(ShipToAddr)DO IF ShipToAddr[i] <> CustAddr[i]THEN ShowShippingAddr:=TRUE;
                ShowCashAccountingCriteria("Sales Invoice Header");
                GetLineFeeNoteOnReportHist("No.");
                //ADV001 - Inicio
                lt_LinFact.RESET;
                lt_LinFact.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                lt_LinFact.SETFILTER("Line Discount %", '<>%1', 0);
                gb_MuestraDescuento:=(NOT lt_LinFact.ISEMPTY);
                //SL Datos cuenta transferencia
                gs_BancoCabecera:='';
                IF lt_FormaPago.GET("Sales Invoice Header"."Payment Method Code")THEN IF lt_FormaPago.BancoImpresionVentasMigr = lt_FormaPago.BancoImpresionVentasMigr::Empresa THEN if "Sales Invoice Header".CodBancoEmpresaMigr <> '' then begin
                            IF lt_Banco.GET("Sales Invoice Header".CodBancoEmpresaMigr)THEN gs_BancoCabecera:=lt_Banco.IBAN + '-' + lt_Banco."SWIFT Code" end
                        else
                        begin
                            IF lt_Banco.GET("Sales Invoice Header"."Company Bank Account Code")THEN gs_BancoCabecera:=lt_Banco.IBAN + '-' + lt_Banco."SWIFT Code" end;
                ImpPdte:=0;
                lt_MovsCliente.RESET;
                lt_MovsCliente.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                lt_MovsCliente.SETRANGE("Posting Date", "Sales Invoice Header"."Posting Date");
                lt_MovsCliente.SETRANGE("Customer No.", "Sales Invoice Header"."Bill-to Customer No.");
                IF lt_MovsCliente.FINDSET THEN REPEAT lt_MovsCliente.CALCFIELDS("Remaining Amount");
                        ImpPdte:=lt_MovsCliente."Remaining Amount";
                    UNTIL lt_MovsCliente.NEXT = 0;
                //ADV001 - Fin
                IF LogInteraction THEN IF NOT CurrReport.PREVIEW THEN BEGIN
                        IF "Bill-to Contact No." <> '' THEN SegManagement.LogDocument(4, "No.", 0, 0, DATABASE::Contact, "Bill-to Contact No.", "Salesperson Code", "Campaign No.", "Posting Description", '')
                        ELSE
                            SegManagement.LogDocument(4, "No.", 0, 0, DATABASE::Customer, "Bill-to Customer No.", "Salesperson Code", "Campaign No.", "Posting Description", '');
                    END;
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

                    field(NroFactura_Caption; NroFactura)
                    {
                        ApplicationArea = All;
                        Caption = 'N° Factura';
                        Visible = Mostrar;
                    }
                    field(NoOfCopies; NoOfCopies)
                    {
                        ApplicationArea = All;
                        Caption = 'Nº de copias';
                    }
                    field(ShowInternalInfo; ShowInternalInfo)
                    {
                        ApplicationArea = All;
                        Caption = 'Mostrar información interna';
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        ApplicationArea = All;
                        Caption = 'Log Interacción';
                        Enabled = LogInteractionEnable;
                    }
                    field(DisplayAsmInformation; DisplayAssemblyInformation)
                    {
                        ApplicationArea = All;
                        Caption = 'Mostrar componentes del ensamblado';
                    }
                    field(DisplayAdditionalFeeNote; DisplayAdditionalFeeNote)
                    {
                        ApplicationArea = All;
                        Caption = 'Mostrar nota recargo fijo';
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
        end;
    }
    rendering
    {
        layout(ImpresionPorConceptoGenerico)
        {
            Type = RDLC;
            Caption = 'Factura de Venta Registrada';
            LayoutFile = './src/Layout/50062.AlxSalesInvoice2.rdl';
            Summary = './src/Layout/50062.AlxSalesInvoice2.rdl';
        }
    }
    labels
    {
    }
    trigger OnInitReport()
    begin
        GLSetup.GET;
        CompanyInfo.GET;
        SalesSetup.GET;
        CompanyInfo1.GET; //ADV001
        CompanyInfo1.CALCFIELDS(Picture); //ADV001
    //ADV001 - Inicio
    // CASE SalesSetup."Logo Position on Documents" OF
    //  SalesSetup."Logo Position on Documents"::Left:
    //    BEGIN
    //      CompanyInfo3.GET;
    //      CompanyInfo3.CALCFIELDS(Picture);
    //    END;
    //  SalesSetup."Logo Position on Documents"::Center:
    //    BEGIN
    //      CompanyInfo1.GET;
    //      CompanyInfo1.CALCFIELDS(Picture);
    //    END;
    //  SalesSetup."Logo Position on Documents"::Right:
    //    BEGIN
    //      CompanyInfo2.GET;
    //      CompanyInfo2.CALCFIELDS(Picture);
    //    END;
    // END;
    //ADV001 - Fin
    end;
    trigger OnPreReport()
    begin
        IF NOT CurrReport.USEREQUESTPAGE THEN InitLogInteraction;
    end;
    procedure ConfigurarFiltros(NuevoNroFactura: Code[20]; NuevoMostrar: Boolean)
    begin
        NroFactura:=NuevoNroFactura;
        Mostrar:=NuevoMostrar;
        TipodeImpresion:=Enum::AlxiaEventoTipodeImpresion::"Impresion Detallada";
    end;
    var NroFactura: Code[20];
    Mostrar: Boolean;
    TipodeImpresion: Enum AlxiaEventoTipodeImpresion;
    Text000: Label 'Salesperson';
    Text001: Label 'Total %1';
    Text003: Label 'COPY';
    Text004: Label 'Factura %1';
    PageCaptionCap: Label 'Página %1 of %2';
    GLSetup: Record 98;
    ShipmentMethod: Record 10;
    PaymentTerms: Record 3;
    SalesPurchPerson: Record 13;
    CompanyInfo: Record 79;
    CompanyInfo1: Record 79;
    CompanyInfo2: Record 79;
    CompanyInfo3: Record 79;
    SalesSetup: Record 311;
    Cust: Record 18;
    #pragma warning disable AL0432
    VATAmountLine: Record 290 temporary;
    #pragma warning restore AL0432
    DimSetEntry1: Record 480;
    DimSetEntry2: Record 480;
    RespCenter: Record 5714;
    //Language: Record "8";
    _Language: Codeunit Language;
    CurrExchRate: Record 330;
    TempPostedAsmLine: Record 911 temporary;
    VATClause: Record 560;
    TempLineFeeNoteOnReportHist: Record 1053 temporary;
    SalesInvCountPrinted: Codeunit 315;
    FormatAddr: Codeunit 365;
    SegManagement: Codeunit 5051;
    SalesShipmentBuffer: Record 7190 temporary;
    PostedShipmentDate: Date;
    CustAddr: array[8]of Text[50];
    ShipToAddr: array[8]of Text[50];
    CompanyAddr: array[8]of Text[50];
    OrderNoText: Text[80];
    SalesPersonText: Text[30];
    VATNoText: Text[80];
    ReferenceText: Text[80];
    TotalText: Text[50];
    TotalExclVATText: Text[50];
    TotalInclVATText: Text[50];
    MoreLines: Boolean;
    NoOfCopies: Integer;
    NoOfLoops: Integer;
    CopyText: Text[30];
    ShowShippingAddr: Boolean;
    i: Integer;
    NextEntryNo: Integer;
    FirstValueEntryNo: Integer;
    DimText: Text[120];
    OldDimText: Text[75];
    ShowInternalInfo: Boolean;
    Continue: Boolean;
    LogInteraction: Boolean;
    VALVATBaseLCY: Decimal;
    VALVATAmountLCY: Decimal;
    VALSpecLCYHeader: Text[80];
    Text007: Label 'VAT Amount Specification in ';
    Text008: Label 'Local Currency';
    VALExchRate: Text[50];
    Text009: Label 'Exchange rate: %1/%2';
    CalculatedExchRate: Decimal;
    Text010: Label 'Sales - Prepayment Invoice %1';
    OutputNo: Integer;
    TotalSubTotal: Decimal;
    TotalAmount: Decimal;
    TotalAmountInclVAT: Decimal;
    TotalAmountVAT: Decimal;
    TotalInvoiceDiscountAmount: Decimal;
    TotalPaymentDiscountOnVAT: Decimal;
    Text1100000: Label 'Total %1 IVA+RE incl.';
    Text1100001: Label 'Total %1 IVA+RE excl.';
    VATPostingSetup: Record 325;
    PaymentMethod: Record 289;
    TotalGivenAmount: Decimal;
    LogInteractionEnable: Boolean;
    DisplayAssemblyInformation: Boolean;
    PhoneNoCaptionLbl: Label 'N° Teléfono';
    VATRegNoCaptionLbl: Label 'CIF/NIF';
    GiroNoCaptionLbl: Label 'Giro No.';
    BankNameCaptionLbl: Label 'Banco';
    BankAccNoCaptionLbl: Label 'N° Cuenta';
    DueDateCaptionLbl: Label 'Fecha vencimiento';
    InvoiceNoCaptionLbl: Label 'N° Factura';
    PostingDateCaptionLbl: Label 'Fecha emisión documento';
    HdrDimsCaptionLbl: Label 'Header Dimensions';
    PmtinvfromdebtpaidtoFactCompCaptionLbl: Label '';
    UnitPriceCaptionLbl: Label 'Precio venta';
    DiscountCaptionLbl: Label 'Discount %';
    AmtCaptionLbl: Label 'Importe';
    VATClausesCap: Label 'VAT Clause';
    PostedShpDateCaptionLbl: Label 'Posted Shipment Date';
    InvDiscAmtCaptionLbl: Label 'Invoice Discount Amount';
    SubtotalCaptionLbl: Label 'Subtotal';
    PmtDiscGivenAmtCaptionLbl: Label 'Payment Disc Given Amount';
    PmtDiscVATCaptionLbl: Label 'Payment Discount on VAT';
    ShpCaptionLbl: Label 'Shipment';
    LineDimsCaptionLbl: Label 'Line Dimensions';
    VATAmtLineVATCaptionLbl: Label '% IVA';
    VATECBaseCaptionLbl: Label 'Base IVA+RE';
    VATAmountCaptionLbl: Label 'Importe IVA';
    VATAmtSpecCaptionLbl: Label 'Especificación importe IVA';
    VATIdentCaptionLbl: Label 'IVA';
    InvDiscBaseAmtCaptionLbl: Label 'Importe base dto. factura';
    LineAmtCaption1Lbl: Label 'Importe línea';
    InvPmtDiscCaptionLbl: Label 'Descuentos facturas y pagos';
    ECAmtCaptionLbl: Label 'Importe RE';
    ECCaptionLbl: Label '% RE';
    TotalCaptionLbl: Label 'Total';
    VALVATBaseLCYCaption1Lbl: Label 'VAT Base';
    VATAmtCaptionLbl: Label 'Importe IVA';
    VATIdentifierCaptionLbl: Label 'Identific. IVA';
    ShiptoAddressCaptionLbl: Label 'Ship-to Address';
    PmtTermsDescCaptionLbl: Label 'Términos pago';
    ShpMethodDescCaptionLbl: Label 'Shipment Method';
    PmtMethodDescCaptionLbl: Label 'Forma pago';
    DocDateCaptionLbl: Label 'Fecha emisión documento';
    HomePageCaptionCap: Label 'Home Page';
    EmailCaptionLbl: Label 'E-Mail';
    CACCaptionLbl: Text;
    CACTxt: Label 'Régimen especial del criterio de caja';
    DisplayAdditionalFeeNote: Boolean;
    gb_MuestraDescuento: Boolean;
    FaxNoCaptionLbl: Label 'Nº Fax';
    gs_BancoCabecera: Text[50];
    ImportePdteLbl: Label 'Importe pendiente';
    ImpPdte: Decimal;
    TextoPieLbl: Label 'LA FALTA DE PAGO DE ESTA FACTURA EN EL PLAZO DE VENCIMIENTO ESTABLECIDO GENERARA UN 2% MENSUAL EN CONCEPTO DE INTERESES DE DEMORA.';
    NoDocExternLbl: Label 'Nº documento externo';
    Evento: Record Evento;
    SalesReceivablesSetup: Record "Sales & Receivables Setup";
    ConceptoGenFactTxt: Text;
    ConceptoGenFactCant: Decimal;
    ConceptoGenFactPV: Decimal;
    ConceptoGenFactIVA: Decimal;
    ConceptoGenFactImp: Decimal;
    ImpPorCapituloAdultoDesc: Text;
    ImpPorCapituloAdultoCant: Integer;
    ImpPorCapituloAdultoPV: Decimal;
    ImpPorCapituloAdultoIVA: Decimal;
    ImpPorCapituloAdultoImp: Decimal;
    ImpPorCapituloNinnoDesc: Text;
    ImpPorCapituloNinnoCant: Integer;
    ImpPorCapituloNinnoPV: Decimal;
    ImpPorCapituloNinnoIVA: Decimal;
    ImpPorCapituloNinnoImp: Decimal;
    ImpPorCapituloOtrosDesc: Text;
    ImpPorCapituloOtrosCant: Integer;
    ImpPorCapituloOtrosPV: Decimal;
    ImpPorCapituloOtrosIVA: Decimal;
    ImpPorCapituloOtrosImp: Decimal;
    procedure InitLogInteraction()
    begin
        LogInteraction:=SegManagement.FindInteractionTemplateCode("Interaction Log Entry Document Type"::"Sales Inv.") <> '';
    end;
    procedure FindPostedShipmentDate(): Date var
        SalesShipmentHeader: Record 110;
        SalesShipmentBuffer2: Record 7190 temporary;
    begin
        NextEntryNo:=1;
        IF "Sales Invoice Line"."Shipment No." <> '' THEN IF SalesShipmentHeader.GET("Sales Invoice Line"."Shipment No.")THEN EXIT(SalesShipmentHeader."Posting Date");
        IF "Sales Invoice Header"."Order No." = '' THEN EXIT("Sales Invoice Header"."Posting Date");
        CASE "Sales Invoice Line".Type OF "Sales Invoice Line".Type::Item: GenerateBufferFromValueEntry("Sales Invoice Line");
        "Sales Invoice Line".Type::"G/L Account", "Sales Invoice Line".Type::Resource, "Sales Invoice Line".Type::"Charge (Item)", "Sales Invoice Line".Type::"Fixed Asset": GenerateBufferFromShipment("Sales Invoice Line");
        "Sales Invoice Line".Type::" ": EXIT(0D);
        END;
        SalesShipmentBuffer.RESET;
        SalesShipmentBuffer.SETRANGE("Document No.", "Sales Invoice Line"."Document No.");
        SalesShipmentBuffer.SETRANGE("Line No.", "Sales Invoice Line"."Line No.");
        IF SalesShipmentBuffer.FIND('-')THEN BEGIN
            SalesShipmentBuffer2:=SalesShipmentBuffer;
            IF SalesShipmentBuffer.NEXT = 0 THEN BEGIN
                SalesShipmentBuffer.GET(SalesShipmentBuffer2."Document No.", SalesShipmentBuffer2."Line No.", SalesShipmentBuffer2."Entry No.");
                SalesShipmentBuffer.DELETE;
                EXIT(SalesShipmentBuffer2."Posting Date");
            END;
            SalesShipmentBuffer.CALCSUMS(Quantity);
            IF SalesShipmentBuffer.Quantity <> "Sales Invoice Line".Quantity THEN BEGIN
                SalesShipmentBuffer.DELETEALL;
                EXIT("Sales Invoice Header"."Posting Date");
            END;
        END
        ELSE
            EXIT("Sales Invoice Header"."Posting Date");
    end;
    procedure GenerateBufferFromValueEntry(SalesInvoiceLine2: Record 113)
    var
        ValueEntry: Record 5802;
        ItemLedgerEntry: Record 32;
        TotalQuantity: Decimal;
        Quantity: Decimal;
    begin
        TotalQuantity:=SalesInvoiceLine2."Quantity (Base)";
        ValueEntry.SETCURRENTKEY("Document No.");
        ValueEntry.SETRANGE("Document No.", SalesInvoiceLine2."Document No.");
        ValueEntry.SETRANGE("Posting Date", "Sales Invoice Header"."Posting Date");
        ValueEntry.SETRANGE("Item Charge No.", '');
        ValueEntry.SETFILTER("Entry No.", '%1..', FirstValueEntryNo);
        IF ValueEntry.FIND('-')THEN REPEAT IF ItemLedgerEntry.GET(ValueEntry."Item Ledger Entry No.")THEN BEGIN
                    IF SalesInvoiceLine2."Qty. per Unit of Measure" <> 0 THEN Quantity:=ValueEntry."Invoiced Quantity" / SalesInvoiceLine2."Qty. per Unit of Measure"
                    ELSE
                        Quantity:=ValueEntry."Invoiced Quantity";
                    AddBufferEntry(SalesInvoiceLine2, -Quantity, ItemLedgerEntry."Posting Date");
                    TotalQuantity:=TotalQuantity + ValueEntry."Invoiced Quantity";
                END;
                FirstValueEntryNo:=ValueEntry."Entry No." + 1;
            UNTIL(ValueEntry.NEXT = 0) OR (TotalQuantity = 0);
    end;
    procedure GenerateBufferFromShipment(SalesInvoiceLine: Record 113)
    var
        SalesInvoiceHeader: Record 112;
        SalesInvoiceLine2: Record 113;
        SalesShipmentHeader: Record 110;
        SalesShipmentLine: Record 111;
        TotalQuantity: Decimal;
        Quantity: Decimal;
    begin
        TotalQuantity:=0;
        SalesInvoiceHeader.SETCURRENTKEY("Order No.");
        SalesInvoiceHeader.SETFILTER("No.", '..%1', "Sales Invoice Header"."No.");
        SalesInvoiceHeader.SETRANGE("Order No.", "Sales Invoice Header"."Order No.");
        IF SalesInvoiceHeader.FIND('-')THEN REPEAT SalesInvoiceLine2.SETRANGE("Document No.", SalesInvoiceHeader."No.");
                SalesInvoiceLine2.SETRANGE("Line No.", SalesInvoiceLine."Line No.");
                SalesInvoiceLine2.SETRANGE(Type, SalesInvoiceLine.Type);
                SalesInvoiceLine2.SETRANGE("No.", SalesInvoiceLine."No.");
                SalesInvoiceLine2.SETRANGE("Unit of Measure Code", SalesInvoiceLine."Unit of Measure Code");
                IF SalesInvoiceLine2.FIND('-')THEN REPEAT TotalQuantity:=TotalQuantity + SalesInvoiceLine2.Quantity;
                    UNTIL SalesInvoiceLine2.NEXT = 0;
            UNTIL SalesInvoiceHeader.NEXT = 0;
        SalesShipmentLine.SETCURRENTKEY("Order No.", "Order Line No.");
        SalesShipmentLine.SETRANGE("Order No.", "Sales Invoice Header"."Order No.");
        SalesShipmentLine.SETRANGE("Order Line No.", SalesInvoiceLine."Line No.");
        SalesShipmentLine.SETRANGE("Line No.", SalesInvoiceLine."Line No.");
        SalesShipmentLine.SETRANGE(Type, SalesInvoiceLine.Type);
        SalesShipmentLine.SETRANGE("No.", SalesInvoiceLine."No.");
        SalesShipmentLine.SETRANGE("Unit of Measure Code", SalesInvoiceLine."Unit of Measure Code");
        SalesShipmentLine.SETFILTER(Quantity, '<>%1', 0);
        IF SalesShipmentLine.FIND('-')THEN REPEAT IF "Sales Invoice Header"."Get Shipment Used" THEN CorrectShipment(SalesShipmentLine);
                IF ABS(SalesShipmentLine.Quantity) <= ABS(TotalQuantity - SalesInvoiceLine.Quantity)THEN TotalQuantity:=TotalQuantity - SalesShipmentLine.Quantity
                ELSE
                BEGIN
                    IF ABS(SalesShipmentLine.Quantity) > ABS(TotalQuantity)THEN SalesShipmentLine.Quantity:=TotalQuantity;
                    Quantity:=SalesShipmentLine.Quantity - (TotalQuantity - SalesInvoiceLine.Quantity);
                    TotalQuantity:=TotalQuantity - SalesShipmentLine.Quantity;
                    SalesInvoiceLine.Quantity:=SalesInvoiceLine.Quantity - Quantity;
                    IF SalesShipmentHeader.GET(SalesShipmentLine."Document No.")THEN AddBufferEntry(SalesInvoiceLine, Quantity, SalesShipmentHeader."Posting Date");
                END;
            UNTIL(SalesShipmentLine.NEXT = 0) OR (TotalQuantity = 0);
    end;
    procedure CorrectShipment(var SalesShipmentLine: Record 111)
    var
        SalesInvoiceLine: Record 113;
    begin
        SalesInvoiceLine.SETCURRENTKEY("Shipment No.", "Shipment Line No.");
        SalesInvoiceLine.SETRANGE("Shipment No.", SalesShipmentLine."Document No.");
        SalesInvoiceLine.SETRANGE("Shipment Line No.", SalesShipmentLine."Line No.");
        IF SalesInvoiceLine.FIND('-')THEN REPEAT SalesShipmentLine.Quantity:=SalesShipmentLine.Quantity - SalesInvoiceLine.Quantity;
            UNTIL SalesInvoiceLine.NEXT = 0;
    end;
    procedure AddBufferEntry(SalesInvoiceLine: Record 113; QtyOnShipment: Decimal; PostingDate: Date)
    begin
        SalesShipmentBuffer.SETRANGE("Document No.", SalesInvoiceLine."Document No.");
        SalesShipmentBuffer.SETRANGE("Line No.", SalesInvoiceLine."Line No.");
        SalesShipmentBuffer.SETRANGE("Posting Date", PostingDate);
        IF SalesShipmentBuffer.FIND('-')THEN BEGIN
            SalesShipmentBuffer.Quantity:=SalesShipmentBuffer.Quantity + QtyOnShipment;
            SalesShipmentBuffer.MODIFY;
            EXIT;
        END;
        SalesShipmentBuffer."Document No.":=SalesInvoiceLine."Document No.";
        SalesShipmentBuffer."Line No.":=SalesInvoiceLine."Line No.";
        SalesShipmentBuffer."Entry No.":=NextEntryNo;
        SalesShipmentBuffer.Type:=SalesInvoiceLine.Type;
        SalesShipmentBuffer."No.":=SalesInvoiceLine."No.";
        SalesShipmentBuffer.Quantity:=QtyOnShipment;
        SalesShipmentBuffer."Posting Date":=PostingDate;
        SalesShipmentBuffer.INSERT;
        NextEntryNo:=NextEntryNo + 1 end;
    local procedure DocumentCaption(): Text[250]begin
        IF "Sales Invoice Header"."Prepayment Invoice" THEN EXIT(Text010);
        EXIT(Text004);
    end;
    procedure GetCarteraInvoice(): Boolean var
        CustLedgEntry: Record 21;
    begin
        CustLedgEntry.SETCURRENTKEY("Document No.", "Document Type", "Customer No.");
        CustLedgEntry.SETRANGE("Document Type", CustLedgEntry."Document Type"::Invoice);
        CustLedgEntry.SETRANGE("Document No.", "Sales Invoice Header"."No.");
        CustLedgEntry.SETRANGE("Customer No.", "Sales Invoice Header"."Bill-to Customer No.");
        CustLedgEntry.SETRANGE("Posting Date", "Sales Invoice Header"."Posting Date");
        IF CustLedgEntry.FINDFIRST THEN IF CustLedgEntry."Document Situation" = CustLedgEntry."Document Situation"::" " THEN EXIT(FALSE)
            ELSE
                EXIT(TRUE)
        ELSE
            EXIT(FALSE);
    end;
    procedure ShowCashAccountingCriteria(SalesInvoiceHeader: Record 112): Text var
        VATEntry: Record 254;
    begin
        GLSetup.GET;
        IF NOT GLSetup."Unrealized VAT" THEN EXIT;
        CACCaptionLbl:='';
        VATEntry.SETRANGE("Document No.", SalesInvoiceHeader."No.");
        VATEntry.SETRANGE("Document Type", VATEntry."Document Type"::Invoice);
        IF VATEntry.FINDSET THEN REPEAT IF VATEntry."VAT Cash Regime" THEN CACCaptionLbl:=CACTxt;
            UNTIL(VATEntry.NEXT = 0) OR (CACCaptionLbl <> '');
        EXIT(CACCaptionLbl);
    end;
    procedure InitializeRequest(NewNoOfCopies: Integer; NewShowInternalInfo: Boolean; NewLogInteraction: Boolean; DisplayAsmInfo: Boolean)
    begin
        NoOfCopies:=NewNoOfCopies;
        ShowInternalInfo:=NewShowInternalInfo;
        LogInteraction:=NewLogInteraction;
        DisplayAssemblyInformation:=DisplayAsmInfo;
    end;
    procedure CollectAsmInformation()
    var
        ValueEntry: Record 5802;
        ItemLedgerEntry: Record 32;
        PostedAsmHeader: Record 910;
        PostedAsmLine: Record 911;
        SalesShipmentLine: Record 111;
    begin
        TempPostedAsmLine.DELETEALL;
        IF "Sales Invoice Line".Type <> "Sales Invoice Line".Type::Item THEN EXIT;
        ValueEntry.SETCURRENTKEY("Document No.");
        ValueEntry.SETRANGE("Document No.", "Sales Invoice Line"."Document No.");
        ValueEntry.SETRANGE("Document Type", ValueEntry."Document Type"::"Sales Invoice");
        ValueEntry.SETRANGE("Document Line No.", "Sales Invoice Line"."Line No.");
        ValueEntry.SETRANGE(Adjustment, FALSE);
        IF NOT ValueEntry.FINDSET THEN EXIT;
        REPEAT IF ItemLedgerEntry.GET(ValueEntry."Item Ledger Entry No.")THEN IF ItemLedgerEntry."Document Type" = ItemLedgerEntry."Document Type"::"Sales Shipment" THEN BEGIN
                    SalesShipmentLine.GET(ItemLedgerEntry."Document No.", ItemLedgerEntry."Document Line No.");
                    IF SalesShipmentLine.AsmToShipmentExists(PostedAsmHeader)THEN BEGIN
                        PostedAsmLine.SETRANGE("Document No.", PostedAsmHeader."No.");
                        IF PostedAsmLine.FINDSET THEN REPEAT TreatAsmLineBuffer(PostedAsmLine);
                            UNTIL PostedAsmLine.NEXT = 0;
                    END;
                END;
        UNTIL ValueEntry.NEXT = 0;
    end;
    procedure TreatAsmLineBuffer(PostedAsmLine: Record 911)
    begin
        CLEAR(TempPostedAsmLine);
        TempPostedAsmLine.SETRANGE(Type, PostedAsmLine.Type);
        TempPostedAsmLine.SETRANGE("No.", PostedAsmLine."No.");
        TempPostedAsmLine.SETRANGE("Variant Code", PostedAsmLine."Variant Code");
        TempPostedAsmLine.SETRANGE(Description, PostedAsmLine.Description);
        TempPostedAsmLine.SETRANGE("Unit of Measure Code", PostedAsmLine."Unit of Measure Code");
        IF TempPostedAsmLine.FINDFIRST THEN BEGIN
            TempPostedAsmLine.Quantity+=PostedAsmLine.Quantity;
            TempPostedAsmLine.MODIFY;
        END
        ELSE
        BEGIN
            CLEAR(TempPostedAsmLine);
            TempPostedAsmLine:=PostedAsmLine;
            TempPostedAsmLine.INSERT;
        END;
    end;
    procedure GetUOMText(UOMCode: Code[10]): Text[10]var
        UnitOfMeasure: Record 204;
    begin
        IF NOT UnitOfMeasure.GET(UOMCode)THEN EXIT(UOMCode);
        EXIT(UnitOfMeasure.Description);
    end;
    procedure BlanksForIndent(): Text[10]begin
        EXIT(PADSTR('', 2, ' '));
    end;
    local procedure GetLineFeeNoteOnReportHist(SalesInvoiceHeaderNo: Code[20])
    var
        LineFeeNoteOnReportHist: Record 1053;
        CustLedgerEntry: Record 21;
        Customer: Record 18;
    begin
        TempLineFeeNoteOnReportHist.DELETEALL;
        CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::Invoice);
        CustLedgerEntry.SETRANGE("Document No.", SalesInvoiceHeaderNo);
        IF NOT CustLedgerEntry.FINDFIRST THEN EXIT;
        IF NOT Customer.GET(CustLedgerEntry."Customer No.")THEN EXIT;
        LineFeeNoteOnReportHist.SETRANGE("Cust. Ledger Entry No", CustLedgerEntry."Entry No.");
        LineFeeNoteOnReportHist.SETRANGE("Language Code", Customer."Language Code");
        IF LineFeeNoteOnReportHist.FINDSET THEN BEGIN
            REPEAT TempLineFeeNoteOnReportHist.INIT;
                TempLineFeeNoteOnReportHist.COPY(LineFeeNoteOnReportHist);
                TempLineFeeNoteOnReportHist.INSERT;
            UNTIL LineFeeNoteOnReportHist.NEXT = 0;
        END
        ELSE
        BEGIN
            LineFeeNoteOnReportHist.SetRange("Language Code", _Language.GetUserLanguageCode);
            //LineFeeNoteOnReportHist.SETRANGE("Language Code", Language.GetUserLanguage);
            IF LineFeeNoteOnReportHist.FINDSET THEN REPEAT TempLineFeeNoteOnReportHist.INIT;
                    TempLineFeeNoteOnReportHist.COPY(LineFeeNoteOnReportHist);
                    TempLineFeeNoteOnReportHist.INSERT;
                UNTIL LineFeeNoteOnReportHist.NEXT = 0;
        END;
    end;
    //A01: Fin
    local procedure MostrarLineaEvento(): Boolean var
        SalesInvLn: Record "Sales Invoice Line";
    begin
        SalesInvLn.Reset();
        SalesInvLn.SetRange("Document No.", "Sales Invoice Line"."Document No.");
        SalesInvLn.SetFilter(Type, '<>%1', SalesInvLn.Type::" ");
        if SalesInvLn.FindLast()then if SalesInvLn."Line No." = "Sales Invoice Line"."Line No." then exit(true);
        exit(false);
    end;
    local procedure Cantidad_ConceptoGenericoFacturacion()
    var
        SalesInvLn: Record "Sales Invoice Line";
    begin
        SalesInvLn.Reset();
        SalesInvLn.SetRange("Document No.", "Sales Invoice Line"."Document No.");
        SalesInvLn.SetFilter(Type, '<>%1', SalesInvLn.Type::" ");
        //SalesInvLn.SetRange("Unit of Measure Code", 'RC'); // RM 28/11/2025 Se comenta porque no permite calcular todos los importes de las líneas.
        SalesInvLn.SetFilter("Line Amount", '<>%1', 0);
        if SalesInvLn.FindSet()then repeat ConceptoGenFactPV:=ConceptoGenFactPV + SalesInvLn."Line Amount";
                ConceptoGenFactIVA:=SalesInvLn."VAT %";
                ConceptoGenFactImp:=ConceptoGenFactImp + SalesInvLn."Line Amount";
            until SalesInvLn.Next() = 0;
    end;
    local procedure ImpresionPorCapitulo_LineaAdulto(EventCode: Code[20]): Boolean var
        EventLne: Record "Lineas Evento";
    begin
        SalesReceivablesSetup.Get();
        ImpPorCapituloAdultoCant:=0;
        ImpPorCapituloAdultoPV:=0;
        ImpPorCapituloAdultoIVA:=0;
        ImpPorCapituloAdultoImp:=0;
        EventLne.Reset();
        EventLne.SetRange("Codigo Evento", EventCode);
        EventLne.SetRange(Tipo, EventLne.Tipo::Adulto);
        if EventLne.FindSet()then repeat ImpPorCapituloAdultoDesc:=SalesReceivablesSetup."Linea Evento Adulto";
                ImpPorCapituloAdultoCant:=EventLne.Count;
                ImpPorCapituloAdultoPV:=EventLne."Precio Real";
                ImpPorCapituloAdultoIVA:=EventLne."% IVA";
                ImpPorCapituloAdultoImp:=EventLne.Importe;
            until EventLne.Next() = 0;
    end;
    local procedure ImpresionPorCapitulo_LineaNinno(EventCode: Code[20]): Boolean var
        EventLne: Record "Lineas Evento";
    begin
        SalesReceivablesSetup.Get();
        ImpPorCapituloNinnoCant:=0;
        ImpPorCapituloNinnoPV:=0;
        ImpPorCapituloNinnoIVA:=0;
        ImpPorCapituloNinnoImp:=0;
        EventLne.Reset();
        EventLne.SetRange("Codigo Evento", EventCode);
        EventLne.SetRange(Tipo, EventLne.Tipo::"Niño");
        if EventLne.FindSet()then repeat ImpPorCapituloNinnoDesc:=SalesReceivablesSetup."Linea Evento Ninno";
                ImpPorCapituloNinnoCant:=EventLne.Count;
                ImpPorCapituloNinnoPV:=EventLne."Precio Real";
                ImpPorCapituloNinnoIVA:=EventLne."% IVA";
                ImpPorCapituloNinnoImp:=EventLne.Importe;
            until EventLne.Next() = 0;
    end;
    local procedure ImpresionPorCapitulo_LineaOtros(EventCode: Code[20]): Boolean var
        EventLne: Record "Lineas Evento";
    begin
        SalesReceivablesSetup.Get();
        ImpPorCapituloOtrosCant:=0;
        ImpPorCapituloOtrosPV:=0;
        ImpPorCapituloOtrosIVA:=0;
        ImpPorCapituloOtrosImp:=0;
        EventLne.Reset();
        EventLne.SetRange("Codigo Evento", EventCode);
        EventLne.SetRange(Tipo, EventLne.Tipo::Otros);
        if EventLne.FindSet()then repeat ImpPorCapituloOtrosDesc:=SalesReceivablesSetup."Linea Evento Otros";
                ImpPorCapituloOtrosCant:=EventLne.Count;
                ImpPorCapituloOtrosPV:=EventLne."Precio Real";
                ImpPorCapituloOtrosIVA:=EventLne."% IVA";
                ImpPorCapituloOtrosImp:=EventLne.Importe;
            until EventLne.Next() = 0;
    end;
}
