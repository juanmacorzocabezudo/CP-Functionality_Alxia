report 50064 AlxSales_Quote
{
    // -----------------------------------------------------
    //   ADVANCE
    //   Fecha: 25-06-2019
    //   Técnico: JAB
    //   Presupuesto: I012653 - Modificaciones Confirmación Pedido / Oferta Venta
    //   Modificación:
    //     - Ajustarlo como "Pro-Forma" tal como está imprimiéndose actualmente desde el pedido de venta.
    //   Etiqueta: ADV001
    // -----------------------------------------------------
    //   ADVANCE
    //   Fecha: 24-06-2020
    //   Técnico: CPL
    //   Presupuesto: Mostrar al pie un texto informativo.
    //   Modificación:
    //   Etiqueta: ADV002
    // -----------------------------------------------------
    DefaultLayout = RDLC;
    //RDLCLayout = './SalesQuote.rdlc';
    RDLCLayout = './src/Layout/Rep50064.AlxSales_Quote.rdl';
    Caption = 'Sales - Quote';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Header";36)
        {
            DataItemTableView = SORTING("Document Type", "No.")WHERE("Document Type"=CONST(Quote));
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Ventas - Proforma';

            column(DocType_SalesHeader; "Document Type")
            {
            }
            column(No_SalesHeader; "No.")
            {
            }
            column(VATIdentifierCaption; VATIdentifierCaptionLbl)
            {
            }
            column(PaymentTermsCaption; PaymentTermsCaptionLbl)
            {
            }
            column(ShipmentMethodCaption; ShipmentMethodCaptionLbl)
            {
            }
            column(PaymentMethodCaption; PaymentMethodCaptionLbl)
            {
            }
            column(DocumentDateCaption; DocumentDateCaptionLbl)
            {
            }
            column(AllowInvDiscCaption; AllowInvDiscCaptionLbl)
            {
            }
            column(gb_MuestraNotaInformativa; gb_MuestraNotaInformativa)
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
                    column(CompanyInfo3Picture; CompanyInfo3.Picture)
                    {
                    }
                    column(CompanyInfo1Picture; CompanyInfo1.Picture)
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
                    column(SalesCopyText; STRSUBSTNO(Text004, CopyText))
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
                    #pragma warning disable AL0432
                    column(CompanyInfoHomePage; CompanyInfo."Home Page")
                    {
                    }
                    #pragma warning restore AL0432
                    column(CompanyInfoEmail; CompanyInfo."E-Mail")
                    {
                    }
                    column(CompanyInfoVATRegistrationNo; CompanyInfo."VAT Registration No.")
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
                    column(BilltoCustNo_SalesHeader; "Sales Header"."Bill-to Customer No.")
                    {
                    }
                    column(DocDate_SalesHeader; FORMAT("Sales Header"."Document Date", 0, 4))
                    {
                    }
                    column(VATNoText; VATNoText)
                    {
                    }
                    column(VATRegNo_SalesHeader; "Sales Header"."VAT Registration No.")
                    {
                    }
                    column(ShipmentDate_SalesHeader; FORMAT("Sales Header"."Shipment Date"))
                    {
                    }
                    column(SalesPersonText; SalesPersonText)
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(No1_SalesHeader; "Sales Header"."No.")
                    {
                    }
                    column(ReferenceText; ReferenceText)
                    {
                    }
                    column(YourReference_SalesHeader; "Sales Header"."Your Reference")
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
                    column(PricesIncludingVAT_SalesHdr; "Sales Header"."Prices Including VAT")
                    {
                    }
                    column(PageCaption; STRSUBSTNO(Text005, ''))
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(PricesInclVATYesNo_SalesHdr; FORMAT("Sales Header"."Prices Including VAT"))
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
                    column(BankAccountNoCaption; BankAccountNoCaptionLbl)
                    {
                    }
                    column(ShipmentDateCaption; ShipmentDateCaptionLbl)
                    {
                    }
                    column(QuoteNoCaption; QuoteNoCaptionLbl)
                    {
                    }
                    column(HomepageCaption; HomepageCaptionLbl)
                    {
                    }
                    column(EMailCaption; EMailCaptionLbl)
                    {
                    }
                    column(BilltoCustNo_SalesHeaderCaption; "Sales Header".FIELDCAPTION("Bill-to Customer No."))
                    {
                    }
                    column(PricesIncludingVAT_SalesHdrCaption; "Sales Header".FIELDCAPTION("Prices Including VAT"))
                    {
                    }
                    column(Cabecera_TieneRE; gb_tieneRE)
                    {
                    }
                    column(Factura_MuestraDescuento; gb_MuestraDescuento)
                    {
                    }
                    dataitem(DimensionLoop1;2000000026)
                    {
                        DataItemLinkReference = "Sales Header";
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
                    dataitem("Sales Line";37)
                    {
                        DataItemLink = "Document Type"=FIELD("Document Type"), "Document No."=FIELD("No.");
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");

                        trigger OnPreDataItem()
                        begin
                            CurrReport.BREAK;
                        end;
                    }
                    dataitem(RoundLoop;2000000026)
                    {
                        DataItemTableView = SORTING(Number);

                        column(LineAmt_SalesLine; SalesLine."Line Amount")
                        {
                        AutoFormatExpression = "Sales Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(No_SalesLine; "Sales Line"."No.")
                        {
                        }
                        column(Description1_SalesLine; "Sales Line".Description)
                        {
                        }
                        column(Quantity_SalesLine; "Sales Line".Quantity)
                        {
                        }
                        column(UnitofMeasure_SalesLine; "Sales Line"."Unit of Measure")
                        {
                        }
                        column(LineAmt1_SalesLine; "Sales Line"."Line Amount")
                        {
                        AutoFormatExpression = "Sales Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(UnitPrice_SalesLine; "Sales Line"."Unit Price")
                        {
                        AutoFormatExpression = "Sales Header"."Currency Code";
                        AutoFormatType = 2;
                        }
                        column(LineDiscount_SalesLine; "Sales Line"."Line Discount %")
                        {
                        }
                        column(AllowInvoiceDisc_SalesLine; "Sales Line"."Allow Invoice Disc.")
                        {
                        IncludeCaption = false;
                        }
                        column(VATIdentifier_SalesLine; "Sales Line"."VAT Identifier")
                        {
                        }
                        column(Type_SalesLine; FORMAT("Sales Line".Type))
                        {
                        }
                        column(No1_SalesLine; "Sales Line"."Line No.")
                        {
                        }
                        column(AllowInvoiceDisYesNo; FORMAT("Sales Line"."Allow Invoice Disc."))
                        {
                        }
                        column(SalesLineInvDiscountAmount;-SalesLine."Inv. Discount Amount")
                        {
                        AutoFormatExpression = "Sales Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(DiscountAmt_SalesLine;-SalesLine."Pmt. Discount Amount")
                        {
                        AutoFormatExpression = "Sales Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(VATAmtText_VATAmtLine; VATAmountLine.VATAmountText)
                        {
                        }
                        column(TotalExclVATText; TotalExclVATText)
                        {
                        }
                        column(TotalInclVATText; TotalInclVATText)
                        {
                        }
                        column(VATAmount; VATAmount)
                        {
                        AutoFormatExpression = "Sales Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(SalesLine_PricesIncludingVAt; "Sales Header"."Prices Including VAT")
                        {
                        }
                        column(VATDiscountAmount;-VATDiscountAmount)
                        {
                        AutoFormatExpression = "Sales Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(TotalAmountInclVAT; TotalAmountInclVAT)
                        {
                        AutoFormatExpression = "Sales Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(VATBaseAmount; VATBaseAmount)
                        {
                        AutoFormatExpression = "Sales Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(UnitPriceCaption; UnitPriceCaptionLbl)
                        {
                        }
                        column(DiscountPercentCaption; DiscountPercentCaptionLbl)
                        {
                        }
                        column(AmountCaption; AmountCaptionLbl)
                        {
                        }
                        column(InvDiscAmtCaption; InvDiscAmtCaptionLbl)
                        {
                        }
                        column(SubtotalCaption; SubtotalCaptionLbl)
                        {
                        }
                        column(PmtDiscGivenAmt; PmtDiscGivenAmtLbl)
                        {
                        }
                        column(PmtDiscVATCaption; PmtDiscVATCaptionLbl)
                        {
                        }
                        column(No_SalesLineCaption; "Sales Line".FIELDCAPTION("No."))
                        {
                        }
                        column(Description1_SalesLineCaption; "Sales Line".FIELDCAPTION(Description))
                        {
                        }
                        column(Quantity_SalesLineCaption; "Sales Line".FIELDCAPTION(Quantity))
                        {
                        }
                        column(UnitofMeasure_SalesLineCaption; "Sales Line".FIELDCAPTION("Unit of Measure"))
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
                                DimSetEntry2.SETRANGE("Dimension Set ID", "Sales Line"."Dimension Set ID");
                            end;
                        }
                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN SalesLine.FIND('-')
                            ELSE
                                SalesLine.NEXT;
                            "Sales Line":=SalesLine;
                            IF NOT "Sales Header"."Prices Including VAT" AND (SalesLine."VAT Calculation Type" = SalesLine."VAT Calculation Type"::"Full VAT")THEN SalesLine."Line Amount":=0;
                            IF(SalesLine.Type = SalesLine.Type::"G/L Account") AND (NOT ShowInternalInfo)THEN "Sales Line"."No.":='';
                        end;
                        trigger OnPostDataItem()
                        begin
                            SalesLine.DELETEALL;
                        end;
                        trigger OnPreDataItem()
                        begin
                            MoreLines:=SalesLine.FIND('+');
                            WHILE MoreLines AND (SalesLine.Description = '') AND (SalesLine."Description 2" = '') AND (SalesLine."No." = '') AND (SalesLine.Quantity = 0) AND (SalesLine.Amount = 0)DO MoreLines:=SalesLine.NEXT(-1) <> 0;
                            IF NOT MoreLines THEN CurrReport.BREAK;
                            SalesLine.SETRANGE("Line No.", 0, SalesLine."Line No.");
                            SETRANGE(Number, 1, SalesLine.COUNT);
                        //CurrReport.CREATETOTALS(SalesLine."Line Amount", SalesLine."Inv. Discount Amount", SalesLine."Pmt. Discount Amount");
                        end;
                    }
                    dataitem(VATCounter;2000000026)
                    {
                        DataItemTableView = SORTING(Number);

                        column(VATBase_VATAmtLine; VATAmountLine."VAT Base")
                        {
                        AutoFormatExpression = "Sales Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(VATAmt_VATAmtLine; VATAmountLine."VAT Amount")
                        {
                        AutoFormatExpression = "Sales Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(LineAmt_VATAmtLine; VATAmountLine."Line Amount")
                        {
                        AutoFormatExpression = "Sales Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(InvDiscBaseAmt_VATAmtLine; VATAmountLine."Inv. Disc. Base Amount")
                        {
                        AutoFormatExpression = "Sales Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(InvDiscountAmt_VATAmtLine; VATAmountLine."Invoice Discount Amount" + VATAmountLine."Pmt. Discount Amount")
                        {
                        AutoFormatExpression = "Sales Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(ECAmount_VATAmtLine; VATAmountLine."EC Amount")
                        {
                        AutoFormatExpression = "Sales Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(VAT_VATAmtLine; VATAmountLine."VAT %")
                        {
                        DecimalPlaces = 0: 6;
                        }
                        column(VATIdentifier_VATAmtLine; VATAmountLine."VAT Identifier")
                        {
                        }
                        column(EC_VATAmtLine; VATAmountLine."EC %")
                        {
                        AutoFormatExpression = "Sales Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(VATPercentCaption; VATPercentCaptionLbl)
                        {
                        }
                        column(VATECBaseCaption; VATECBaseCaptionLbl)
                        {
                        }
                        column(VATAmtCaption; VATAmtCaptionLbl)
                        {
                        }
                        column(VATAmountSpecCaption; VATAmountSpecCaptionLbl)
                        {
                        }
                        column(LineAmtCaption; LineAmtCaptionLbl)
                        {
                        }
                        column(InvDiscBaseAmtCaption; InvDiscBaseAmtCaptionLbl)
                        {
                        }
                        column(InvPmtDiscCaption; InvPmtDiscCaptionLbl)
                        {
                        }
                        column(ECCaption; ECCaptionLbl)
                        {
                        }
                        column(ECAmountCaption; ECAmountCaptionLbl)
                        {
                        }
                        column(TotalCaption; TotalCaptionLbl)
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                        end;
                        trigger OnPreDataItem()
                        begin
                            IF(VATAmount = 0) AND (VATAmountLine."VAT %" + VATAmountLine."EC %" = 0)THEN CurrReport.BREAK;
                            SETRANGE(Number, 1, VATAmountLine.COUNT);
                        /*   CurrReport.CREATETOTALS(
                                VATAmountLine."Line Amount", VATAmountLine."Inv. Disc. Base Amount",
                                VATAmountLine."Invoice Discount Amount", VATAmountLine."VAT Base", VATAmountLine."VAT Amount",
                                VATAmountLine."EC Amount", VATAmountLine."Pmt. Discount Amount"); */
                        end;
                    }
                    dataitem(VATCounterLCY;2000000026)
                    {
                        DataItemTableView = SORTING(Number);

                        column(VALExchRate; VALExchRate)
                        {
                        }
                        column(VALSpecLCYHeader; VALSpecLCYHeader)
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
                        column(VATCtrl_VATAmtLine; VATAmountLine."VAT %")
                        {
                        DecimalPlaces = 0: 5;
                        }
                        column(VATIdentifier1_VATAmtLine; VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATBaseCaption; VATBaseCaptionLbl)
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                            VALVATBaseLCY:=VATAmountLine.GetBaseLCY("Sales Header"."Posting Date", "Sales Header"."Currency Code", "Sales Header"."Currency Factor");
                            VALVATAmountLCY:=VATAmountLine.GetAmountLCY("Sales Header"."Posting Date", "Sales Header"."Currency Code", "Sales Header"."Currency Factor");
                        end;
                        trigger OnPreDataItem()
                        begin
                            IF(NOT GLSetup."Print VAT specification in LCY") OR ("Sales Header"."Currency Code" = '') OR (VATAmountLine.GetTotalVATAmount = 0)THEN CurrReport.BREAK;
                            SETRANGE(Number, 1, VATAmountLine.COUNT);
                            //CurrReport.CREATETOTALS(VALVATBaseLCY, VALVATAmountLCY);
                            IF GLSetup."LCY Code" = '' THEN VALSpecLCYHeader:=Text008 + Text009
                            ELSE
                                VALSpecLCYHeader:=Text008 + FORMAT(GLSetup."LCY Code");
                            CurrExchRate.FindCurrency("Sales Header"."Order Date", "Sales Header"."Currency Code", 1);
                            VALExchRate:=STRSUBSTNO(Text010, CurrExchRate."Relational Exch. Rate Amount", CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem(Total;2000000026)
                    {
                        DataItemTableView = SORTING(Number)WHERE(Number=CONST(1));
                    }
                    dataitem(Total2;2000000026)
                    {
                        DataItemTableView = SORTING(Number)WHERE(Number=CONST(1));

                        column(SelltoCustNo_SalesHeader; "Sales Header"."Sell-to Customer No.")
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
                        column(SelltoCustNo_SalesHeaderCaption; "Sales Header".FIELDCAPTION("Sell-to Customer No."))
                        {
                        }
                        trigger OnPreDataItem()
                        begin
                            IF NOT ShowShippingAddr THEN CurrReport.BREAK;
                        end;
                    }
                }
                trigger OnAfterGetRecord()
                var
                    SalesPost: Codeunit 80;
                begin
                    CLEAR(SalesLine);
                    CLEAR(SalesPost);
                    SalesLine.DELETEALL;
                    VATAmountLine.DELETEALL;
                    SalesPost.GetSalesLines("Sales Header", SalesLine, 0);
                    SalesLine.CalcVATAmountLines(0, "Sales Header", SalesLine, VATAmountLine);
                    SalesLine.UpdateVATOnLines(0, "Sales Header", SalesLine, VATAmountLine);
                    VATAmount:=VATAmountLine.GetTotalVATAmount;
                    VATBaseAmount:=VATAmountLine.GetTotalVATBase;
                    VATDiscountAmount:=VATAmountLine.GetTotalVATDiscount("Sales Header"."Currency Code", "Sales Header"."Prices Including VAT");
                    TotalAmountInclVAT:=VATAmountLine.GetTotalAmountInclVAT;
                    IF(VATAmountLine."VAT Calculation Type" = VATAmountLine."VAT Calculation Type"::"Reverse Charge VAT") AND "Sales Header"."Prices Including VAT" THEN BEGIN
                        VATBaseAmount:=VATAmountLine.GetTotalLineAmount(FALSE, "Sales Header"."Currency Code");
                        TotalAmountInclVAT:=VATAmountLine.GetTotalLineAmount(FALSE, "Sales Header"."Currency Code");
                    END;
                    IF Number > 1 THEN BEGIN
                        CopyText:=Text003;
                        OutputNo+=1;
                    END;
                //CurrReport.PAGENO := 1;
                end;
                trigger OnPostDataItem()
                begin
                    IF Print THEN SalesCountPrinted.RUN("Sales Header");
                end;
                trigger OnPreDataItem()
                begin
                    NoOfLoops:=ABS(NoOfCopies) + 1;
                    CopyText:='';
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo:=1;
                end;
            }
            trigger OnAfterGetRecord()
            var
                "Sell-to Country": Text[50];
                Rcd_SalesLine: Record 37;
                lt_LinFact: Record 113;
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
                //ADV001 Inicio
                gb_tieneRE:=FALSE;
                Rcd_SalesLine.RESET;
                Rcd_SalesLine.SETRANGE("Document Type", "Document Type");
                Rcd_SalesLine.SETRANGE("Document No.", "No.");
                Rcd_SalesLine.SETFILTER("EC %", '<>0');
                gb_tieneRE:=NOT Rcd_SalesLine.ISEMPTY;
                //ADV001 Fin
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
                IF "VAT Registration No." = '' THEN VATNoText:=''
                ELSE
                    VATNoText:=FIELDCAPTION("VAT Registration No.");
                IF "Currency Code" = '' THEN BEGIN
                    GLSetup.TESTFIELD("LCY Code");
                    TotalText:=STRSUBSTNO(Text001, GLSetup."LCY Code");
                    // Inicio ADV001
                    // Línea modificada:
                    /*
                    TotalInclVATText := STRSUBSTNO(Text1100000,GLSetup."LCY Code");
                    */
                    IF gb_tieneRE THEN TotalInclVATText:=STRSUBSTNO(Text1100000, GLSetup."LCY Code")
                    ELSE
                        TotalInclVATText:=STRSUBSTNO(TextIVASinRE, GLSetup."LCY Code");
                    // Fin ADV001
                    TotalExclVATText:=STRSUBSTNO(Text1100001, GLSetup."LCY Code");
                END
                ELSE
                BEGIN
                    TotalText:=STRSUBSTNO(Text001, "Currency Code");
                    // Inicio ADV001
                    // Línea modificada:
                    /*
                    TotalInclVATText := STRSUBSTNO(Text1100000,"Currency Code");
                    */
                    IF gb_tieneRE THEN TotalInclVATText:=STRSUBSTNO(Text1100000, "Currency Code")
                    ELSE
                        TotalInclVATText:=STRSUBSTNO(TextIVASinRE, "Currency Code");
                    // Fin ADV001
                    TotalExclVATText:=STRSUBSTNO(Text1100001, "Currency Code");
                END;
                FormatAddr.SalesHeaderBillTo(CustAddr, "Sales Header");
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
                IF Country.GET("Sell-to Country/Region Code")THEN "Sell-to Country":=Country.Name;
                FormatAddr.SalesHeaderShipTo(ShipToAddr, CustAddr, "Sales Header");
                ShowShippingAddr:="Sell-to Customer No." <> "Bill-to Customer No.";
                FOR i:=1 TO ARRAYLEN(ShipToAddr)DO IF(ShipToAddr[i] <> CustAddr[i]) AND (ShipToAddr[i] <> '') AND (ShipToAddr[i] <> "Sell-to Country")THEN ShowShippingAddr:=TRUE;
                IF Print THEN BEGIN
                    IF ArchiveDocument THEN ArchiveManagement.StoreSalesDocument("Sales Header", LogInteraction);
                    IF LogInteraction THEN BEGIN
                        CALCFIELDS("No. of Archived Versions");
                        IF "Bill-to Contact No." <> '' THEN SegManagement.LogDocument(1, "No.", "Doc. No. Occurrence", "No. of Archived Versions", DATABASE::Contact, "Bill-to Contact No.", "Salesperson Code", "Campaign No.", "Posting Description", "Opportunity No.")
                        ELSE
                            SegManagement.LogDocument(1, "No.", "Doc. No. Occurrence", "No. of Archived Versions", DATABASE::Customer, "Bill-to Customer No.", "Salesperson Code", "Campaign No.", "Posting Description", "Opportunity No.");
                    END;
                END;
                MARK(TRUE);
                // Inicio ADV001
                // Miro si alguna línea de oferta tiene descuento para mostrar o no la columna
                lt_LinFact.RESET;
                lt_LinFact.SETRANGE("Document No.", "Sales Header"."No.");
                lt_LinFact.SETFILTER("Line Discount %", '<>%1', 0);
                gb_MuestraDescuento:=(NOT lt_LinFact.ISEMPTY);
            // Fin ADV001
            end;
            trigger OnPostDataItem()
            var
                ToDo: Record 5080;
                FileManagement: Codeunit 419;
            begin
                MARKEDONLY:=TRUE;
                COMMIT;
                CurrReport.LANGUAGE:=GLOBALLANGUAGE;
            /*  IF NOT FileManagement.IsWebClient THEN
                     IF FIND('-') AND ToDo.WRITEPERMISSION THEN
                         IF Print AND (NoOfRecords = 1) THEN
                             IF CONFIRM(Text007) THEN
                                 CreateTodo; */
            end;
            trigger OnPreDataItem()
            begin
                NoOfRecords:=COUNT;
                Print:=Print OR NOT CurrReport.PREVIEW;
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
                    field(ArchiveDocument; ArchiveDocument)
                    {
                        ApplicationArea = All;
                        Caption = 'Archive Document';

                        trigger OnValidate()
                        begin
                            IF NOT ArchiveDocument THEN LogInteraction:=FALSE;
                        end;
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        ApplicationArea = All;
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;

                        trigger OnValidate()
                        begin
                            IF LogInteraction THEN ArchiveDocument:=ArchiveDocumentEnable;
                        end;
                    }
                    field(MostrarNotaInformativa; gb_MuestraNotaInformativa)
                    {
                        ApplicationArea = All;
                        Caption = 'Mostrar Nota Informativa';
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
            //ArchiveDocument := SalesSetup."Archive Quotes and Orders";
            //LogInteraction := SegManagement.FindInteractTmplCode(1) <> '';
            LogInteraction:=SegManagement.FindInteractionTemplateCode("Interaction Log Entry Document Type"::"Sales Qte.") <> '';
            LogInteractionEnable:=LogInteraction;
        end;
    }
    labels
    {
    }
    trigger OnInitReport()
    begin
        //ADV002 Inicio
        gb_MuestraNotaInformativa:=TRUE;
        //ADV002 Fin
        GLSetup.GET;
        CompanyInfo.GET;
        SalesSetup.GET;
        CASE SalesSetup."Logo Position on Documents" OF SalesSetup."Logo Position on Documents"::"No Logo": ;
        SalesSetup."Logo Position on Documents"::Left: BEGIN
            CompanyInfo3.GET;
            CompanyInfo3.CALCFIELDS(Picture);
        END;
        SalesSetup."Logo Position on Documents"::Center: BEGIN
            CompanyInfo1.GET;
            CompanyInfo1.CALCFIELDS(Picture);
        END;
        SalesSetup."Logo Position on Documents"::Right: BEGIN
            CompanyInfo2.GET;
            CompanyInfo2.CALCFIELDS(Picture);
        END;
        END;
    end;
    var Text000: Label 'Vendedor';
    Text001: Label 'Total %1';
    Text002: Label 'Total %1 Incl. IVA';
    Text003: Label ' COPY';
    Text004: Label 'Venta - Proforma %1';
    Text005: Label 'Pág %1';
    Text006: Label 'Total %1 Excl. IVA';
    GLSetup: Record 98;
    ShipmentMethod: Record 10;
    PaymentTerms: Record 3;
    SalesPurchPerson: Record 13;
    CompanyInfo: Record 79;
    CompanyInfo3: Record 79;
    CompanyInfo1: Record 79;
    CompanyInfo2: Record 79;
    SalesSetup: Record 311;
    #pragma warning disable AL0432
    VATAmountLine: Record 290 temporary;
    #pragma warning restore AL0432
    SalesLine: Record 37 temporary;
    DimSetEntry1: Record 480;
    DimSetEntry2: Record 480;
    RespCenter: Record 5714;
    //Language: Record "8";
    Language2: Codeunit Language;
    Country: Record 9;
    CurrExchRate: Record 330;
    SalesCountPrinted: Codeunit 313;
    FormatAddr: Codeunit 365;
    SegManagement: Codeunit 5051;
    ArchiveManagement: Codeunit 5063;
    CustAddr: array[8]of Text[50];
    ShipToAddr: array[8]of Text[50];
    CompanyAddr: array[8]of Text[50];
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
    DimText: Text[120];
    OldDimText: Text[75];
    ShowInternalInfo: Boolean;
    Continue: Boolean;
    ArchiveDocument: Boolean;
    LogInteraction: Boolean;
    VATAmount: Decimal;
    VATBaseAmount: Decimal;
    VATDiscountAmount: Decimal;
    TotalAmountInclVAT: Decimal;
    Text007: Label 'Do you want to create a follow-up to-do?';
    NoOfRecords: Integer;
    VALVATBaseLCY: Decimal;
    VALVATAmountLCY: Decimal;
    VALSpecLCYHeader: Text[80];
    VALExchRate: Text[50];
    Text008: Label 'VAT Amount Specification in ';
    Text009: Label 'Local Currency';
    Text010: Label 'Exchange rate: %1/%2';
    OutputNo: Integer;
    Print: Boolean;
    Text1100000: Label 'Total %1 Incl. IVA';
    Text1100001: Label 'Total %1 Excl. IVA';
    VATPostingSetup: Record 325;
    PaymentMethod: Record 289;
    ArchiveDocumentEnable: Boolean;
    LogInteractionEnable: Boolean;
    VATIdentifierCaptionLbl: Label 'Identific. IVA';
    PhoneNoCaptionLbl: Label 'Nº teléfono';
    VATRegNoCaptionLbl: Label 'CIF/NIF';
    GiroNoCaptionLbl: Label 'Nº giro postal';
    BankNameCaptionLbl: Label 'Banco';
    BankAccountNoCaptionLbl: Label 'Nº cuenta';
    ShipmentDateCaptionLbl: Label 'Fecha envío';
    QuoteNoCaptionLbl: Label 'Nº oferta';
    HomepageCaptionLbl: Label 'Página Web';
    EMailCaptionLbl: Label 'Correo electrónico';
    HeaderDimensionsCaptionLbl: Label 'Header Dimensions';
    UnitPriceCaptionLbl: Label 'Precio venta';
    DiscountPercentCaptionLbl: Label 'Discount %';
    AmountCaptionLbl: Label 'Importe';
    InvDiscAmtCaptionLbl: Label 'Invoice Discount Amount';
    SubtotalCaptionLbl: Label 'Subtotal';
    PmtDiscGivenAmtLbl: Label 'Payment Discount Given Amount';
    PmtDiscVATCaptionLbl: Label 'Descuento P.P. sobre IVA';
    LineDimensionsCaptionLbl: Label 'Line Dimensions';
    VATPercentCaptionLbl: Label '% IVA';
    VATECBaseCaptionLbl: Label 'Base IVA +RE';
    VATAmtCaptionLbl: Label 'Importe IVA';
    VATAmountSpecCaptionLbl: Label 'Especificación importe IVA';
    LineAmtCaptionLbl: Label 'Importe línea';
    InvDiscBaseAmtCaptionLbl: Label 'Importe base descuento factura';
    InvPmtDiscCaptionLbl: Label 'Descuentos facturas y pagos';
    ECCaptionLbl: Label 'EC %';
    ECAmountCaptionLbl: Label 'EC Amount';
    TotalCaptionLbl: Label 'Total';
    VATBaseCaptionLbl: Label 'VAT Base';
    ShiptoAddressCaptionLbl: Label 'Ship-to Address';
    PaymentTermsCaptionLbl: Label 'Términos pago';
    ShipmentMethodCaptionLbl: Label 'Condiciones envío';
    PaymentMethodCaptionLbl: Label 'Forma pago';
    DocumentDateCaptionLbl: Label 'Fecha emisión documento';
    AllowInvDiscCaptionLbl: Label 'Allow Invoice Discount';
    gb_tieneRE: Boolean;
    TextIVASinRE: Label 'Total %1 Incl. IVA';
    gb_MuestraDescuento: Boolean;
    gb_MuestraNotaInformativa: Boolean;
    procedure InitializeRequest(NoOfCopiesFrom: Integer; ShowInternalInfoFrom: Boolean; ArchiveDocumentFrom: Boolean; LogInteractionFrom: Boolean; PrintFrom: Boolean)
    begin
        NoOfCopies:=NoOfCopiesFrom;
        ShowInternalInfo:=ShowInternalInfoFrom;
        ArchiveDocument:=ArchiveDocumentFrom;
        LogInteraction:=LogInteractionFrom;
        Print:=PrintFrom;
    end;
}
