report 50063 AlxSales_Credit_Memo
{
    // ADVANCE - Log de cambios
    // -----------------------------------------------------
    //   ADVANCE
    //   Fecha: 21-04-2016
    //   Técnico: JMAP
    //   Presupuesto: Proyecto I002433 - Modificación de informes
    // 
    //   Etiqueta: ADV001
    // -----------------------------------------------------
    //DefaultLayout = RDLC;
    //RDLCLayout = './src/Layout/50063.AlxSales_Credit_Memo.rdl';
    Caption = 'Venta - Factura rectificativa';
    Permissions = TableData 7190=rimd;
    PreviewMode = PrintLayout;
    DefaultRenderingLayout = VentaFacturaRectificativa;

    dataset
    {
        dataitem("Sales Cr.Memo Header";114)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Posted Sales Credit Memo';

            column(No_SalesCrMemoHeader; "No.")
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
                    column(CompanyInfoPicture; CompanyInfo3.Picture)
                    {
                    }
                    column(SalesCorrectiveInvCopy; STRSUBSTNO(Text1100001, CopyText))
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
                    column(CompanyInfoEMail; CompanyInfo."E-Mail")
                    {
                    }
                    column(CompanyInfoFaxNo; CompanyInfo."Fax No.")
                    {
                    }
                    column(CompanyInfoVATRegNo; CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(CompanyInfoGiroNo; CompanyInfo."Giro No.")
                    {
                    }
                    column(CompanyInfoBankName; CompanyInfo."Bank Name")
                    {
                    }
                    column(CompanyInfoBankAccNo; CompanyInfo."Bank Account No.")
                    {
                    }
                    column(PhoneNoCaption; CompanyInfoPhoneNoCaptionLbl)
                    {
                    }
                    column(VATRegNoCaption; CompanyInfoVATRegistrationNoCaptionLbl)
                    {
                    }
                    column(EmailCaption; CompanyInfoEMailCaptionLbl)
                    {
                    }
                    column(BilltoCustNo_SalesCrMemoHeader; "Sales Cr.Memo Header"."Bill-to Customer No.")
                    {
                    }
                    column(PostDate_SalesCrMemoHeader; FORMAT("Sales Cr.Memo Header"."Posting Date", 0, 4))
                    {
                    }
                    column(VATNoText; VATNoText)
                    {
                    }
                    column(VATRegNo_SalesCrMemoHeader; "Sales Cr.Memo Header"."VAT Registration No.")
                    {
                    }
                    column(SalesPersonText; SalesPersonText)
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(AppliedToText; AppliedToText)
                    {
                    }
                    column(ReferenceText; ReferenceText)
                    {
                    }
                    column(YourRef_SalesCrMemoHeader; "Sales Cr.Memo Header"."Your Reference")
                    {
                    }
                    column(NoDocExtCaption; NoDocExternLbl)
                    {
                    }
                    column(ExternalDocNo_SalesCrMemoHdr; "Sales Cr.Memo Header"."External Document No.")
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
                    column(DocDate_SalesCrMemoHeader; FORMAT("Sales Cr.Memo Header"."Document Date", 0, 4))
                    {
                    }
                    column(PricIncVAT_SalesCrMemoHeader; "Sales Cr.Memo Header"."Prices Including VAT")
                    {
                    }
                    column(ReturnOrderNoText; ReturnOrderNoText)
                    {
                    }
                    column(RetOrderNo_SalesCrMemoHeader; "Sales Cr.Memo Header"."Return Order No.")
                    {
                    }
                    column(PageCaption; PageCaptionCap)
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(PricInclVAT1_SalesCrMemoHeader; FORMAT("Sales Cr.Memo Header"."Prices Including VAT"))
                    {
                    }
                    column(VATBaseDiscPct_SalesCrMemoHeader; "Sales Cr.Memo Header"."VAT Base Discount %")
                    {
                    }
                    column(CorrInvNo_SalesCrMemoHeader; "Sales Cr.Memo Header"."Corrected Invoice No.")
                    {
                    }
                    column(CompanyInfoPhoneNoCaption; CompanyInfoPhoneNoCaptionLbl)
                    {
                    }
                    column(CompanyInfoHomePageCaption; CompanyInfoHomePageCaptionLbl)
                    {
                    }
                    column(CompanyInfoEMailCaption; CompanyInfoEMailCaptionLbl)
                    {
                    }
                    column(CompanyInfoVATRegistrationNoCaption; CompanyInfoVATRegistrationNoCaptionLbl)
                    {
                    }
                    column(CompanyInfoGiroNoCaption; CompanyInfoGiroNoCaptionLbl)
                    {
                    }
                    column(CompanyInfoBankNameCaption; CompanyInfoBankNameCaptionLbl)
                    {
                    }
                    column(CompanyInfoBankAccountNoCaption; CompanyInfoBankAccountNoCaptionLbl)
                    {
                    }
                    column(SalesCrMemoHeaderNoCaption; SalesCrMemoHeaderNoCaptionLbl)
                    {
                    }
                    column(SalesCrMemoHeaderPostingDateCaption; SalesCrMemoHeaderPostingDateCaptionLbl)
                    {
                    }
                    column(CorrectedInvoiceNoCaption; CorrectedInvoiceNoCaptionLbl)
                    {
                    }
                    column(DocumentDateCaption; DocumentDateCaptionLbl)
                    {
                    }
                    column(BilltoCustNo_SalesCrMemoHeaderCaption; "Sales Cr.Memo Header".FIELDCAPTION("Bill-to Customer No."))
                    {
                    }
                    column(PricIncVAT_SalesCrMemoHeaderCaption; "Sales Cr.Memo Header".FIELDCAPTION("Prices Including VAT"))
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
                    column(TextoPieCaption; TextoPieLbl)
                    {
                    }
                    column(Cabecera_Banco; gs_BancoCabecera)
                    {
                    }
                    dataitem(DimensionLoop1;2000000026)
                    {
                        DataItemLinkReference = "Sales Cr.Memo Header";
                        DataItemTableView = SORTING(Number)WHERE(Number=FILTER(1..));

                        column(DimText; DimText)
                        {
                        }
                        column(Number_IntegerLine; Number)
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
                    dataitem("Sales Cr.Memo Line";115)
                    {
                        DataItemLink = "Document No."=FIELD("No.");
                        DataItemLinkReference = "Sales Cr.Memo Header";
                        DataItemTableView = SORTING("Document No.", "Line No.");

                        column(LineAmt_SalesCrMemoLine; "Line Amount")
                        {
                        AutoFormatExpression = "Sales Cr.Memo Line".GetCurrencyCode;
                        AutoFormatType = 1;
                        }
                        column(Desc_SalesCrMemoLine; Description)
                        {
                        }
                        column(No_SalesCrMemoLine; "No.")
                        {
                        }
                        column(Qty_SalesCrMemoLine; Quantity)
                        {
                        }
                        column(UOM_SalesCrMemoLine; "Unit of Measure")
                        {
                        }
                        column(UnitPrice_SalesCrMemoLine; "Unit Price")
                        {
                        AutoFormatExpression = "Sales Cr.Memo Line".GetCurrencyCode;
                        AutoFormatType = 2;
                        }
                        column(LineDisc_SalesCrMemoLine; "Line Discount %")
                        {
                        }
                        column(VATIdent_SalesCrMemoLine; "VAT Identifier")
                        {
                        }
                        column(PostedReceiptDate; FORMAT(PostedReceiptDate))
                        {
                        }
                        column(Type_SalesCrMemoLine; FORMAT(Type))
                        {
                        }
                        column(NNCTotalLineAmt; NNC_TotalLineAmount)
                        {
                        AutoFormatExpression = GetCurrencyCode;
                        AutoFormatType = 1;
                        }
                        column(NNCTotalAmtInclVat; NNC_TotalAmountInclVat)
                        {
                        AutoFormatExpression = GetCurrencyCode;
                        AutoFormatType = 1;
                        }
                        column(NNCTotalInvDiscAmt; NNC_TotalInvDiscAmount)
                        {
                        AutoFormatExpression = GetCurrencyCode;
                        AutoFormatType = 1;
                        }
                        column(NNCTotalAmt; NNC_TotalAmount)
                        {
                        AutoFormatExpression = GetCurrencyCode;
                        AutoFormatType = 1;
                        }
                        column(InvDiscAmt_SalesCrMemoLine;-"Inv. Discount Amount")
                        {
                        AutoFormatExpression = "Sales Cr.Memo Line".GetCurrencyCode;
                        AutoFormatType = 1;
                        }
                        column(PmtDiscAmt_SalesCrMemoLine;-"Pmt. Discount Amount")
                        {
                        AutoFormatExpression = "Sales Cr.Memo Line".GetCurrencyCode;
                        AutoFormatType = 1;
                        }
                        column(TotalExclVATText; TotalExclVATText)
                        {
                        }
                        column(TotalInclVATText; TotalInclVATText)
                        {
                        }
                        column(AmtIncVAT_SalesCrMemoLine; "Amount Including VAT")
                        {
                        AutoFormatExpression = "Sales Cr.Memo Line".GetCurrencyCode;
                        AutoFormatType = 1;
                        }
                        column(AmtIncVATAmt_SalesCrMemoLine; "Amount Including VAT" - Amount)
                        {
                        AutoFormatExpression = "Sales Cr.Memo Line".GetCurrencyCode;
                        AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmtText; VATAmountLine.VATAmountText)
                        {
                        }
                        column(Amt_SalesCrMemoLine; Amount)
                        {
                        AutoFormatExpression = "Sales Cr.Memo Line".GetCurrencyCode;
                        AutoFormatType = 1;
                        }
                        column(DocNo_SalesCrMemoLine; "Document No.")
                        {
                        }
                        column(LineNo_SalesCrMemoLine; "Line No.")
                        {
                        }
                        column(UnitPriceCaption; UnitPriceCaptionLbl)
                        {
                        }
                        column(SalesCrMemoLineLineDiscountCaption; SalesCrMemoLineLineDiscountCaptionLbl)
                        {
                        }
                        column(AmountCaption; AmountCaptionLbl)
                        {
                        }
                        column(PostedReceiptDateCaption; PostedReceiptDateCaptionLbl)
                        {
                        }
                        column(InvDiscountAmountCaption; InvDiscountAmountCaptionLbl)
                        {
                        }
                        column(SubtotalCaption; SubtotalCaptionLbl)
                        {
                        }
                        column(PmtDiscGivenAmountCaption; PmtDiscGivenAmountCaptionLbl)
                        {
                        }
                        column(Desc_SalesCrMemoLineCaption; FIELDCAPTION(Description))
                        {
                        }
                        column(No_SalesCrMemoLineCaption; FIELDCAPTION("No."))
                        {
                        }
                        column(Qty_SalesCrMemoLineCaption; FIELDCAPTION(Quantity))
                        {
                        }
                        column(UOM_SalesCrMemoLineCaption; FIELDCAPTION("Unit of Measure"))
                        {
                        }
                        column(VATIdent_SalesCrMemoLineCaption; FIELDCAPTION("VAT Identifier"))
                        {
                        }
                        dataitem("Sales Shipment Buffer";2000000026)
                        {
                            DataItemTableView = SORTING(Number);

                            column(SalesShptBufferPostDate; FORMAT(SalesShipmentBuffer."Posting Date"))
                            {
                            }
                            column(SalesShptBufferQuantity; SalesShipmentBuffer.Quantity)
                            {
                            DecimalPlaces = 0: 5;
                            }
                            column(ReturnReceiptCaption; ReturnReceiptCaptionLbl)
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
                                SETRANGE(Number, 1, SalesShipmentBuffer.COUNT);
                            end;
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
                                    IF NOT DimSetEntry2.FIND('-')THEN CurrReport.BREAK;
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
                                UNTIL(DimSetEntry2.NEXT = 0);
                            end;
                            trigger OnPreDataItem()
                            begin
                                IF NOT ShowInternalInfo THEN CurrReport.BREAK;
                                DimSetEntry2.SETRANGE("Dimension Set ID", "Sales Cr.Memo Line"."Dimension Set ID");
                            end;
                        }
                        trigger OnAfterGetRecord()
                        begin
                            NNC_TotalLineAmount+="Line Amount";
                            NNC_TotalAmountInclVat+="Amount Including VAT";
                            NNC_TotalInvDiscAmount+="Inv. Discount Amount";
                            NNC_TotalAmount+=Amount;
                            SalesShipmentBuffer.DELETEALL;
                            PostedReceiptDate:=0D;
                            IF Quantity <> 0 THEN PostedReceiptDate:=FindPostedShipmentDate;
                            IF(Type = Type::"G/L Account") AND (NOT ShowInternalInfo)THEN "No.":='';
                            IF VATPostingSetup.GET("Sales Cr.Memo Line"."VAT Bus. Posting Group", "Sales Cr.Memo Line"."VAT Prod. Posting Group")THEN BEGIN
                                VATAmountLine.INIT;
                                VATAmountLine."VAT Identifier":="VAT Identifier";
                                VATAmountLine."VAT Calculation Type":="VAT Calculation Type";
                                VATAmountLine."Tax Group Code":="Tax Group Code";
                                VATAmountLine."VAT %":=VATPostingSetup."VAT %";
                                VATAmountLine."EC %":=VATPostingSetup."EC %";
                                VATAmountLine."VAT Base":="Sales Cr.Memo Line".Amount;
                                VATAmountLine."Amount Including VAT":="Sales Cr.Memo Line"."Amount Including VAT";
                                VATAmountLine."Line Amount":="Line Amount";
                                VATAmountLine."Pmt. Discount Amount":="Pmt. Discount Amount";
                                VATAmountLine.SetCurrencyCode("Sales Cr.Memo Header"."Currency Code");
                                IF "Allow Invoice Disc." THEN VATAmountLine."Inv. Disc. Base Amount":="Line Amount";
                                VATAmountLine."Invoice Discount Amount":="Inv. Discount Amount";
                                VATAmountLine."VAT Difference":="VAT Difference";
                                VATAmountLine."EC Difference":="EC Difference";
                                IF "Sales Cr.Memo Header"."Prices Including VAT" THEN VATAmountLine."Prices Including VAT":=TRUE;
                                VATAmountLine."VAT Clause Code":="VAT Clause Code";
                                VATAmountLine.InsertLine;
                            END;
                        end;
                        trigger OnPreDataItem()
                        begin
                            VATAmountLine.DELETEALL;
                            SalesShipmentBuffer.RESET;
                            SalesShipmentBuffer.DELETEALL;
                            FirstValueEntryNo:=0;
                            MoreLines:=FIND('+');
                            WHILE MoreLines AND (Description = '') AND ("No." = '') AND (Quantity = 0) AND (Amount = 0)DO MoreLines:=NEXT(-1) <> 0;
                            IF NOT MoreLines THEN CurrReport.BREAK;
                            SETRANGE("Line No.", 0, "Line No.");
                        //CurrReport.CREATETOTALS(Amount, "Amount Including VAT", "Inv. Discount Amount", "Pmt. Discount Amount");
                        end;
                    }
                    dataitem(VATCounter;2000000026)
                    {
                        DataItemTableView = SORTING(Number);

                        column(VATAmtLineVATECBase; VATAmountLine."VAT Base")
                        {
                        AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmt; VATAmountLine."VAT Amount")
                        {
                        AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(VATAmtLineLineAmt; VATAmountLine."Line Amount")
                        {
                        AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscBaseAmt; VATAmountLine."Inv. Disc. Base Amount")
                        {
                        AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscAmtPmtDiscAmt; VATAmountLine."Invoice Discount Amount" + VATAmountLine."Pmt. Discount Amount")
                        {
                        AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(VATAmtLineECAmt; VATAmountLine."EC Amount")
                        {
                        AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(VATAmtLineVAT; VATAmountLine."VAT %")
                        {
                        DecimalPlaces = 0: 6;
                        }
                        column(VATAmtLineVATIdentifier; VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATAmtLineEC; VATAmountLine."EC %")
                        {
                        AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(VATAmountLineVATCaption; VATAmountLineVATCaptionLbl)
                        {
                        }
                        column(VATAmountLineVATECBaseControl105Caption; VATAmountLineVATECBaseControl105CaptionLbl)
                        {
                        }
                        column(VATAmountLineVATAmountControl106Caption; VATAmountLineVATAmountControl106CaptionLbl)
                        {
                        }
                        column(VATAmountSpecificationCaption; VATAmountSpecificationCaptionLbl)
                        {
                        }
                        column(VATAmountLineVATIdentifierCaption; VATAmountLineVATIdentifierCaptionLbl)
                        {
                        }
                        column(VATAmountLineInvDiscBaseAmountControl130Caption; VATAmountLineInvDiscBaseAmountControl130CaptionLbl)
                        {
                        }
                        column(VATAmountLineLineAmountControl135Caption; VATAmountLineLineAmountControl135CaptionLbl)
                        {
                        }
                        column(InvandPmtDiscountsCaption; InvandPmtDiscountsCaptionLbl)
                        {
                        }
                        column(ECCaption; ECCaptionLbl)
                        {
                        }
                        column(ECAmountCaption; ECAmountCaptionLbl)
                        {
                        }
                        column(VATAmountLineVATECBaseControl113Caption; VATAmountLineVATECBaseControl113CaptionLbl)
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                        end;
                        trigger OnPreDataItem()
                        begin
                            SETRANGE(Number, 1, VATAmountLine.COUNT);
                        // CurrReport.CREATETOTALS(
                        //   VATAmountLine."Line Amount", VATAmountLine."Inv. Disc. Base Amount",
                        //   VATAmountLine."Invoice Discount Amount", VATAmountLine."VAT Base", VATAmountLine."VAT Amount",
                        //   VATAmountLine."EC Amount", VATAmountLine."Pmt. Discount Amount");
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
                        AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(VATClausesCaption; VATClausesCap)
                        {
                        }
                        column(VATClauseVATIdentifierCaption; VATAmountLineVATIdentifierCaptionLbl)
                        {
                        }
                        column(VATClauseVATAmtCaption; VATAmountLineVATAmountControl106CaptionLbl)
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                            IF NOT VATClause.GET(VATAmountLine."VAT Clause Code")THEN CurrReport.SKIP;
                            VATClause.TranslateDescription("Sales Cr.Memo Header"."Language Code");
                        end;
                        trigger OnPreDataItem()
                        begin
                            CLEAR(VATClause);
                            SETRANGE(Number, 1, VATAmountLine.COUNT);
                        //CurrReport.CREATETOTALS(VATAmountLine."VAT Amount");
                        end;
                    }
                    dataitem(VATCounterLCY;2000000026)
                    {
                        DataItemTableView = SORTING(Number);

                        column(VALSpecLCYHeader; VALSpecLCYHeader)
                        {
                        }
                        column(VALExchRate; VALExchRate)
                        {
                        }
                        column(VALVATAmtLCY; VALVATAmountLCY)
                        {
                        AutoFormatType = 1;
                        }
                        column(VALVATBaseLCY; VALVATBaseLCY)
                        {
                        AutoFormatType = 1;
                        }
                        column(VATAmtLineVAT1; VATAmountLine."VAT %")
                        {
                        DecimalPlaces = 0: 5;
                        }
                        column(VATAmtLineVATIdentifier1; VATAmountLine."VAT Identifier")
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                            VALVATBaseLCY:=VATAmountLine.GetBaseLCY("Sales Cr.Memo Header"."Posting Date", "Sales Cr.Memo Header"."Currency Code", "Sales Cr.Memo Header"."Currency Factor");
                            VALVATAmountLCY:=VATAmountLine.GetAmountLCY("Sales Cr.Memo Header"."Posting Date", "Sales Cr.Memo Header"."Currency Code", "Sales Cr.Memo Header"."Currency Factor");
                        end;
                        trigger OnPreDataItem()
                        begin
                            IF(NOT GLSetup."Print VAT specification in LCY") OR ("Sales Cr.Memo Header"."Currency Code" = '')THEN CurrReport.BREAK;
                            SETRANGE(Number, 1, VATAmountLine.COUNT);
                            //CurrReport.CREATETOTALS(VALVATBaseLCY, VALVATAmountLCY);
                            IF GLSetup."LCY Code" = '' THEN VALSpecLCYHeader:=Text008 + Text009
                            ELSE
                                VALSpecLCYHeader:=Text008 + FORMAT(GLSetup."LCY Code");
                            CurrExchRate.FindCurrency("Sales Cr.Memo Header"."Posting Date", "Sales Cr.Memo Header"."Currency Code", 1);
                            CalculatedExchRate:=ROUND(1 / "Sales Cr.Memo Header"."Currency Factor" * CurrExchRate."Exchange Rate Amount", 0.000001);
                            VALExchRate:=STRSUBSTNO(Text010, CalculatedExchRate, CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem(Total;2000000026)
                    {
                        DataItemTableView = SORTING(Number)WHERE(Number=CONST(1));
                    }
                    dataitem(Total2;2000000026)
                    {
                        DataItemTableView = SORTING(Number)WHERE(Number=CONST(1));

                        column(SelltoCustNo_SalesCrMemoHeader; "Sales Cr.Memo Header"."Sell-to Customer No.")
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
                        column(SelltoCustNo_SalesCrMemoHeaderCaption; "Sales Cr.Memo Header".FIELDCAPTION("Sell-to Customer No."))
                        {
                        }
                        trigger OnPreDataItem()
                        begin
                            IF NOT ShowShippingAddr THEN CurrReport.BREAK;
                        end;
                    }
                }
                trigger OnAfterGetRecord()
                begin
                    //CurrReport.PAGENO := 1;
                    IF Number > 1 THEN BEGIN
                        CopyText:=Text004;
                        OutputNo+=1;
                    END;
                    NNC_TotalLineAmount:=0;
                    NNC_TotalAmountInclVat:=0;
                    NNC_TotalInvDiscAmount:=0;
                    NNC_TotalAmount:=0;
                end;
                trigger OnPostDataItem()
                begin
                    IF NOT CurrReport.PREVIEW THEN SalesCrMemoCountPrinted.RUN("Sales Cr.Memo Header");
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
                lt_LinFact: Record 113;
                lt_FormaPago: Record 289;
                lt_Banco: Record 270;
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
                //ADV001 IF "Return Order No." = '' THEN
                //ADV001   ReturnOrderNoText := ''
                //ADV001 ELSE
                ReturnOrderNoText:=FIELDCAPTION("Return Order No.");
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
                    TotalInclVATText:=STRSUBSTNO(Text002, GLSetup."LCY Code");
                    TotalExclVATText:=STRSUBSTNO(Text007, GLSetup."LCY Code");
                END
                ELSE
                BEGIN
                    TotalText:=STRSUBSTNO(Text001, "Currency Code");
                    TotalInclVATText:=STRSUBSTNO(Text002, "Currency Code");
                    TotalExclVATText:=STRSUBSTNO(Text007, "Currency Code");
                END;
                FormatAddr.SalesCrMemoBillTo(CustAddr, "Sales Cr.Memo Header");
                IF "Applies-to Doc. No." = '' THEN AppliedToText:=''
                ELSE
                    AppliedToText:=STRSUBSTNO(Text003, "Applies-to Doc. Type", "Applies-to Doc. No.");
                FormatAddr.SalesCrMemoShipTo(ShipToAddr, CustAddr, "Sales Cr.Memo Header");
                ShowShippingAddr:="Sell-to Customer No." <> "Bill-to Customer No.";
                FOR i:=1 TO ARRAYLEN(ShipToAddr)DO IF ShipToAddr[i] <> CustAddr[i]THEN ShowShippingAddr:=TRUE;
                ShowCashAccountingCriteria("Sales Cr.Memo Header");
                //ADV001 - Inicio
                lt_LinFact.RESET;
                lt_LinFact.SETRANGE("Document No.", "Sales Cr.Memo Header"."No.");
                lt_LinFact.SETFILTER("Line Discount %", '<>%1', 0);
                gb_MuestraDescuento:=(NOT lt_LinFact.ISEMPTY);
                gs_BancoCabecera:='';
                IF lt_FormaPago.GET("Sales Cr.Memo Header"."Payment Method Code")THEN IF lt_FormaPago.BancoImpresionVentasMigr = lt_FormaPago.BancoImpresionVentasMigr::Empresa THEN IF lt_Banco.GET("Sales Cr.Memo Header".CodBancoEmpresa)THEN gs_BancoCabecera:=lt_Banco.IBAN + '-' + lt_Banco."SWIFT Code";
                //ADV001 - Fin
                IF LogInteraction THEN IF NOT CurrReport.PREVIEW THEN IF "Bill-to Contact No." <> '' THEN SegManagement.LogDocument(6, "No.", 0, 0, DATABASE::Contact, "Bill-to Contact No.", "Salesperson Code", "Campaign No.", "Posting Description", '')
                        ELSE
                            SegManagement.LogDocument(6, "No.", 0, 0, DATABASE::Customer, "Sell-to Customer No.", "Salesperson Code", "Campaign No.", "Posting Description", '');
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
            //LogInteraction := SegManagement.FindInteractTmplCode(6) <> '';
            LogInteraction:=SegManagement.FindInteractionTemplateCode("Interaction Log Entry Document Type"::"Sales Cr. Memo") <> '';
            LogInteractionEnable:=LogInteraction;
        end;
    }
    rendering
    {
        layout(VentaFacturaRectificativa)
        {
            Type = RDLC;
            Caption = 'Sale - Corrective invoice', comment = 'ESP="Venta - Factura rectificativa"';
            LayoutFile = './src/Layout/50063.AlxSales_Credit_Memo.rdl';
            Summary = './src/Layout/50063.AlxSales_Credit_Memo.rdl';
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
    //  SalesSetup."Logo Position on Documents"::"No Logo":
    //    ;
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
    var Text000: Label 'Salesperson';
    Text001: Label 'Total %1';
    Text002: Label 'Total %1 IVA Incl.';
    Text003: Label '(Applies to %1 %2)';
    Text004: Label 'COPY';
    PageCaptionCap: Label 'Pagina %1 of %2';
    Text007: Label 'Total %1 Neto';
    GLSetup: Record 98;
    SalesSetup: Record 311;
    SalesPurchPerson: Record 13;
    CompanyInfo1: Record 79;
    CompanyInfo2: Record 79;
    CompanyInfo3: Record 79;
    CompanyInfo: Record 79;
    #pragma warning disable AL0432
    VATAmountLine: Record 290 temporary;
    #pragma warning restore AL0432
    VATClause: Record 560;
    DimSetEntry1: Record 480;
    DimSetEntry2: Record 480;
    //Language: Record "8";
    Language2: Codeunit Language;
    SalesShipmentBuffer: Record 7190 temporary;
    CurrExchRate: Record 330;
    SalesCrMemoCountPrinted: Codeunit 316;
    FormatAddr: Codeunit 365;
    SegManagement: Codeunit 5051;
    RespCenter: Record 5714;
    CustAddr: array[8]of Text[50];
    ShipToAddr: array[8]of Text[50];
    CompanyAddr: array[8]of Text[50];
    ReturnOrderNoText: Text[80];
    SalesPersonText: Text[30];
    VATNoText: Text[80];
    ReferenceText: Text[80];
    AppliedToText: Text;
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
    LogInteraction: Boolean;
    FirstValueEntryNo: Integer;
    PostedReceiptDate: Date;
    NextEntryNo: Integer;
    VALVATBaseLCY: Decimal;
    VALVATAmountLCY: Decimal;
    Text008: Label 'Especificación importe IVA';
    Text009: Label 'Local Currency';
    Text010: Label 'Exchange rate: %1/%2';
    VALSpecLCYHeader: Text[80];
    VALExchRate: Text[50];
    CalculatedExchRate: Decimal;
    OutputNo: Integer;
    NNC_TotalLineAmount: Decimal;
    NNC_TotalAmountInclVat: Decimal;
    NNC_TotalInvDiscAmount: Decimal;
    NNC_TotalAmount: Decimal;
    VATPostingSetup: Record 325;
    Text1100001: Label 'Venta - Factura rectificativa %1';
    LogInteractionEnable: Boolean;
    CompanyInfoPhoneNoCaptionLbl: Label 'Nº teléfono';
    CompanyInfoHomePageCaptionLbl: Label 'Home Page';
    CompanyInfoEMailCaptionLbl: Label 'Correo electrónico';
    CompanyInfoVATRegistrationNoCaptionLbl: Label 'CIF/NIF';
    CompanyInfoGiroNoCaptionLbl: Label 'Giro No.';
    CompanyInfoBankNameCaptionLbl: Label 'Bank';
    CompanyInfoBankAccountNoCaptionLbl: Label 'Account No.';
    SalesCrMemoHeaderNoCaptionLbl: Label 'Nº Abono';
    SalesCrMemoHeaderPostingDateCaptionLbl: Label 'Posting Date';
    CorrectedInvoiceNoCaptionLbl: Label 'N.º factura corregida';
    DocumentDateCaptionLbl: Label 'Fecha emisión';
    HeaderDimensionsCaptionLbl: Label 'Header Dimensions';
    UnitPriceCaptionLbl: Label 'Precio venta';
    SalesCrMemoLineLineDiscountCaptionLbl: Label 'Discount %';
    AmountCaptionLbl: Label 'Importe';
    PostedReceiptDateCaptionLbl: Label 'Posted Return Receipt Date';
    InvDiscountAmountCaptionLbl: Label 'Invoice Discount Amount';
    SubtotalCaptionLbl: Label 'Subtotal';
    PmtDiscGivenAmountCaptionLbl: Label 'Payment Discount Received Amount';
    ReturnReceiptCaptionLbl: Label 'Return Receipt';
    VATClausesCap: Label 'VAT Clause';
    LineDimensionsCaptionLbl: Label 'Line Dimensions';
    VATAmountLineVATCaptionLbl: Label '% IVA';
    VATAmountLineVATECBaseControl105CaptionLbl: Label 'Base IVA';
    VATAmountLineVATAmountControl106CaptionLbl: Label 'Importe IVA';
    VATAmountSpecificationCaptionLbl: Label 'Especificación importe IVA';
    VATAmountLineVATIdentifierCaptionLbl: Label 'Identific. IVA';
    VATAmountLineInvDiscBaseAmountControl130CaptionLbl: Label 'Importe base descuento factura';
    VATAmountLineLineAmountControl135CaptionLbl: Label 'Importe línea';
    InvandPmtDiscountsCaptionLbl: Label 'Descuentos facturas y pagos';
    ECCaptionLbl: Label '% RE';
    ECAmountCaptionLbl: Label 'Importe RE';
    VATAmountLineVATECBaseControl113CaptionLbl: Label 'Total';
    ShiptoAddressCaptionLbl: Label 'Dirección de envío';
    CACCaptionLbl: Text;
    CACTxt: Label 'RÚgimen especial del criterio de caja';
    FaxNoCaptionLbl: Label 'Nº Fax';
    ImportePdteLbl: Label 'Remaining Amount';
    TextoPieLbl: Label 'LA FALTA DE PAGO DE ESTA FACTURA EN EL PLAZO DE VENCIMIENTO ESTABLECIDO GENERARA UN 2% MENSUAL EN CONCEPTO DE INTERESES DE DEMORA.';
    gb_MuestraDescuento: Boolean;
    gs_BancoCabecera: Text[50];
    NoDocExternLbl: Label 'Nº documento externo';
    procedure InitLogInteraction()
    begin
        LogInteraction:=SegManagement.FindInteractionTemplateCode("Interaction Log Entry Document Type"::"Sales Cr. Memo") <> '';
    end;
    local procedure FindPostedShipmentDate(): Date var
        ReturnReceiptHeader: Record 6660;
        SalesShipmentBuffer2: Record 7190 temporary;
    begin
        NextEntryNo:=1;
        IF "Sales Cr.Memo Line"."Return Receipt No." <> '' THEN IF ReturnReceiptHeader.GET("Sales Cr.Memo Line"."Return Receipt No.")THEN EXIT(ReturnReceiptHeader."Posting Date");
        IF "Sales Cr.Memo Header"."Return Order No." = '' THEN EXIT("Sales Cr.Memo Header"."Posting Date");
        CASE "Sales Cr.Memo Line".Type OF "Sales Cr.Memo Line".Type::Item: GenerateBufferFromValueEntry("Sales Cr.Memo Line");
        "Sales Cr.Memo Line".Type::"G/L Account", "Sales Cr.Memo Line".Type::Resource, "Sales Cr.Memo Line".Type::"Charge (Item)", "Sales Cr.Memo Line".Type::"Fixed Asset": GenerateBufferFromShipment("Sales Cr.Memo Line");
        "Sales Cr.Memo Line".Type::" ": EXIT(0D);
        END;
        SalesShipmentBuffer.RESET;
        SalesShipmentBuffer.SETRANGE("Document No.", "Sales Cr.Memo Line"."Document No.");
        SalesShipmentBuffer.SETRANGE("Line No.", "Sales Cr.Memo Line"."Line No.");
        IF SalesShipmentBuffer.FIND('-')THEN BEGIN
            SalesShipmentBuffer2:=SalesShipmentBuffer;
            IF SalesShipmentBuffer.NEXT = 0 THEN BEGIN
                SalesShipmentBuffer.GET(SalesShipmentBuffer2."Document No.", SalesShipmentBuffer2."Line No.", SalesShipmentBuffer2."Entry No.");
                SalesShipmentBuffer.DELETE;
                EXIT(SalesShipmentBuffer2."Posting Date");
            END;
            SalesShipmentBuffer.CALCSUMS(Quantity);
            IF SalesShipmentBuffer.Quantity <> "Sales Cr.Memo Line".Quantity THEN BEGIN
                SalesShipmentBuffer.DELETEALL;
                EXIT("Sales Cr.Memo Header"."Posting Date");
            END;
        END
        ELSE
            EXIT("Sales Cr.Memo Header"."Posting Date");
    end;
    local procedure GenerateBufferFromValueEntry(SalesCrMemoLine2: Record 115)
    var
        ValueEntry: Record 5802;
        ItemLedgerEntry: Record 32;
        TotalQuantity: Decimal;
        Quantity: Decimal;
    begin
        TotalQuantity:=SalesCrMemoLine2."Quantity (Base)";
        ValueEntry.SETCURRENTKEY("Document No.");
        ValueEntry.SETRANGE("Document No.", SalesCrMemoLine2."Document No.");
        ValueEntry.SETRANGE("Posting Date", "Sales Cr.Memo Header"."Posting Date");
        ValueEntry.SETRANGE("Item Charge No.", '');
        ValueEntry.SETFILTER("Entry No.", '%1..', FirstValueEntryNo);
        IF ValueEntry.FIND('-')THEN REPEAT IF ItemLedgerEntry.GET(ValueEntry."Item Ledger Entry No.")THEN BEGIN
                    IF SalesCrMemoLine2."Qty. per Unit of Measure" <> 0 THEN Quantity:=ValueEntry."Invoiced Quantity" / SalesCrMemoLine2."Qty. per Unit of Measure"
                    ELSE
                        Quantity:=ValueEntry."Invoiced Quantity";
                    AddBufferEntry(SalesCrMemoLine2, -Quantity, ItemLedgerEntry."Posting Date");
                    TotalQuantity:=TotalQuantity - ValueEntry."Invoiced Quantity";
                END;
                FirstValueEntryNo:=ValueEntry."Entry No." + 1;
            UNTIL(ValueEntry.NEXT = 0) OR (TotalQuantity = 0);
    end;
    local procedure GenerateBufferFromShipment(SalesCrMemoLine: Record 115)
    var
        SalesCrMemoHeader: Record 114;
        SalesCrMemoLine2: Record 115;
        ReturnReceiptHeader: Record 6660;
        ReturnReceiptLine: Record 6661;
        TotalQuantity: Decimal;
        Quantity: Decimal;
    begin
        TotalQuantity:=0;
        SalesCrMemoHeader.SETCURRENTKEY("Return Order No.");
        SalesCrMemoHeader.SETFILTER("No.", '..%1', "Sales Cr.Memo Header"."No.");
        SalesCrMemoHeader.SETRANGE("Return Order No.", "Sales Cr.Memo Header"."Return Order No.");
        IF SalesCrMemoHeader.FIND('-')THEN REPEAT SalesCrMemoLine2.SETRANGE("Document No.", SalesCrMemoHeader."No.");
                SalesCrMemoLine2.SETRANGE("Line No.", SalesCrMemoLine."Line No.");
                SalesCrMemoLine2.SETRANGE(Type, SalesCrMemoLine.Type);
                SalesCrMemoLine2.SETRANGE("No.", SalesCrMemoLine."No.");
                SalesCrMemoLine2.SETRANGE("Unit of Measure Code", SalesCrMemoLine."Unit of Measure Code");
                IF SalesCrMemoLine2.FIND('-')THEN REPEAT TotalQuantity:=TotalQuantity + SalesCrMemoLine2.Quantity;
                    UNTIL SalesCrMemoLine2.NEXT = 0;
            UNTIL SalesCrMemoHeader.NEXT = 0;
        ReturnReceiptLine.SETCURRENTKEY("Return Order No.", "Return Order Line No.");
        ReturnReceiptLine.SETRANGE("Return Order No.", "Sales Cr.Memo Header"."Return Order No.");
        ReturnReceiptLine.SETRANGE("Return Order Line No.", SalesCrMemoLine."Line No.");
        ReturnReceiptLine.SETRANGE("Line No.", SalesCrMemoLine."Line No.");
        ReturnReceiptLine.SETRANGE(Type, SalesCrMemoLine.Type);
        ReturnReceiptLine.SETRANGE("No.", SalesCrMemoLine."No.");
        ReturnReceiptLine.SETRANGE("Unit of Measure Code", SalesCrMemoLine."Unit of Measure Code");
        ReturnReceiptLine.SETFILTER(Quantity, '<>%1', 0);
        IF ReturnReceiptLine.FIND('-')THEN REPEAT IF "Sales Cr.Memo Header"."Get Return Receipt Used" THEN CorrectShipment(ReturnReceiptLine);
                IF ABS(ReturnReceiptLine.Quantity) <= ABS(TotalQuantity - SalesCrMemoLine.Quantity)THEN TotalQuantity:=TotalQuantity - ReturnReceiptLine.Quantity
                ELSE
                BEGIN
                    IF ABS(ReturnReceiptLine.Quantity) > ABS(TotalQuantity)THEN ReturnReceiptLine.Quantity:=TotalQuantity;
                    Quantity:=ReturnReceiptLine.Quantity - (TotalQuantity - SalesCrMemoLine.Quantity);
                    SalesCrMemoLine.Quantity:=SalesCrMemoLine.Quantity - Quantity;
                    TotalQuantity:=TotalQuantity - ReturnReceiptLine.Quantity;
                    IF ReturnReceiptHeader.GET(ReturnReceiptLine."Document No.")THEN AddBufferEntry(SalesCrMemoLine, -Quantity, ReturnReceiptHeader."Posting Date");
                END;
            UNTIL(ReturnReceiptLine.NEXT = 0) OR (TotalQuantity = 0);
    end;
    local procedure CorrectShipment(var ReturnReceiptLine: Record 6661)
    var
        SalesCrMemoLine: Record 115;
    begin
        SalesCrMemoLine.SETCURRENTKEY("Return Receipt No.", "Return Receipt Line No.");
        SalesCrMemoLine.SETRANGE("Return Receipt No.", ReturnReceiptLine."Document No.");
        SalesCrMemoLine.SETRANGE("Return Receipt Line No.", ReturnReceiptLine."Line No.");
        IF SalesCrMemoLine.FIND('-')THEN REPEAT ReturnReceiptLine.Quantity:=ReturnReceiptLine.Quantity - SalesCrMemoLine.Quantity;
            UNTIL SalesCrMemoLine.NEXT = 0;
    end;
    local procedure AddBufferEntry(SalesCrMemoLine: Record 115; QtyOnShipment: Decimal; PostingDate: Date)
    begin
        SalesShipmentBuffer.SETRANGE("Document No.", SalesCrMemoLine."Document No.");
        SalesShipmentBuffer.SETRANGE("Line No.", SalesCrMemoLine."Line No.");
        SalesShipmentBuffer.SETRANGE("Posting Date", PostingDate);
        IF SalesShipmentBuffer.FIND('-')THEN BEGIN
            SalesShipmentBuffer.Quantity:=SalesShipmentBuffer.Quantity - QtyOnShipment;
            SalesShipmentBuffer.MODIFY;
            EXIT;
        END;
        SalesShipmentBuffer.INIT;
        SalesShipmentBuffer."Document No.":=SalesCrMemoLine."Document No.";
        SalesShipmentBuffer."Line No.":=SalesCrMemoLine."Line No.";
        SalesShipmentBuffer."Entry No.":=NextEntryNo;
        SalesShipmentBuffer.Type:=SalesCrMemoLine.Type;
        SalesShipmentBuffer."No.":=SalesCrMemoLine."No.";
        SalesShipmentBuffer.Quantity:=-QtyOnShipment;
        SalesShipmentBuffer."Posting Date":=PostingDate;
        SalesShipmentBuffer.INSERT;
        NextEntryNo:=NextEntryNo + 1 end;
    procedure ShowCashAccountingCriteria(SalesCrMemoHeader: Record 114): Text var
        VATEntry: Record 254;
    begin
        GLSetup.GET;
        IF NOT GLSetup."Unrealized VAT" THEN EXIT;
        CACCaptionLbl:='';
        VATEntry.SETRANGE("Document No.", SalesCrMemoHeader."No.");
        VATEntry.SETRANGE("Document Type", VATEntry."Document Type"::"Credit Memo");
        IF VATEntry.FINDSET THEN REPEAT IF VATEntry."VAT Cash Regime" THEN CACCaptionLbl:=CACTxt;
            UNTIL(VATEntry.NEXT = 0) OR (CACCaptionLbl <> '');
        EXIT(CACCaptionLbl);
    end;
    procedure InitializeRequest(NewNoOfCopies: Integer; NewShowInternalInfo: Boolean; NewLogInteraction: Boolean)
    begin
        NoOfCopies:=NewNoOfCopies;
        ShowInternalInfo:=NewShowInternalInfo;
        LogInteraction:=NewLogInteraction;
    end;
}
