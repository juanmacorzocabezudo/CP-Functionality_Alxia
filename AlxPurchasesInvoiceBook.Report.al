report 50141 AlxPurchasesInvoiceBook
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layout/AlxPurchasesInvoiceBook.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Libro facturas recibidas - CP';

    dataset
    {
        dataitem("<Integer3>";2000000026)
        {
            DataItemTableView = SORTING(Number)WHERE(Number=CONST(1));

            column(USERID; USERID)
            {
            }
            /*   column(CurrReport_PAGENO; CurrReport.PAGENO)
              {
              } */
            column(CompanyAddr_7_; CompanyAddr[7])
            {
            }
            column(CompanyAddr_4_; CompanyAddr[4])
            {
            }
            column(CompanyAddr_5_; CompanyAddr[5])
            {
            }
            column(CompanyAddr_6_; CompanyAddr[6])
            {
            }
            column(CompanyAddr_3_; CompanyAddr[3])
            {
            }
            column(CompanyAddr_2_; CompanyAddr[2])
            {
            }
            column(CompanyAddr_1_; CompanyAddr[1])
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(SortPostDate; SortPostDate)
            {
            }
            column(PrintAmountsInAddCurrency; PrintAmountsInAddCurrency)
            {
            }
            column(HeaderText; HeaderText)
            {
            }
            column(AuxVatEntry; AuxVatEntry)
            {
            }
            column(Integer3__Number; Number)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Purchases_Invoice_BookCaption; Purchases_Invoice_BookCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(EC_Caption; EC_CaptionLbl)
            {
            }
            column(VAT_Caption; VAT_CaptionLbl)
            {
            }
            column(BaseCaption; BaseCaptionLbl)
            {
            }
            column(VAT_RegistrationCaption; VAT_RegistrationCaptionLbl)
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(VendorNoCaption; VendorNoCaptionLbl)
            {
            }
            column(External_Document_No_Caption; External_Document_No_CaptionLbl)
            {
            }
            column(Posting_DateCaption; Posting_DateCaptionLbl)
            {
            }
            column(Document_No_Caption; Document_No_CaptionLbl)
            {
            }
            column(Epedition_DateCaption; Epedition_DateCaptionLbl)
            {
            }
            dataitem(VATEntry;254)
            {
                DataItemTableView = SORTING("No. Series", "Posting Date")WHERE(Type=CONST(Purchase));
                RequestFilterFields = "Posting Date", "Document Type", "Document No.";

                column(Base_TotalBaseImport; Base - TotalBaseImport)
                {
                }
                column(AmountVatReverse3; AmountVatReverse3)
                {
                }
                column(Base_AmountVatReverse3; Base + AmountVatReverse3)
                {
                }
                column(Additional_Currency_Base__TotalBaseImport; "Additional-Currency Base" - TotalBaseImport)
                {
                }
                column(AmountVatReverse3_Control30; AmountVatReverse3)
                {
                }
                column(Additional_Currency_Base__AmountVatReverse3; "Additional-Currency Base" + AmountVatReverse3)
                {
                }
                column(Base_Base2__TotalBaseImport;(Base + Base2) - TotalBaseImport)
                {
                }
                column(AmountVatReverse3_Amount2; AmountVatReverse3 + Amount2)
                {
                }
                column(Base_Base2___AmountVatReverse3_Amount2_;(Base + Base2) + (AmountVatReverse3 + Amount2))
                {
                }
                column(Additional_Currency_Base__Base2__TotalBaseImport;("Additional-Currency Base" + Base2) - TotalBaseImport)
                {
                }
                column(AmountVatReverse3___Amount2; AmountVatReverse3 + Amount2)
                {
                }
                column(Additional_Currency_Base__Base2___AmountVatReverse3_Amount2_;("Additional-Currency Base" + Base2) + (AmountVatReverse3 + Amount2))
                {
                }
                column(VATEntry__No__Series_; "No. Series")
                {
                }
                column(Base_AmountVatReverse; Base + AmountVatReverse)
                {
                }
                column(AmountVatReverse; AmountVatReverse)
                {
                }
                column(Base_TotalBaseImport_Control74; Base - TotalBaseImport)
                {
                }
                column(VATEntry__No__Series__Control75; "No. Series")
                {
                }
                column(VATEntry__No__Series__Control80; "No. Series")
                {
                }
                column(Additional_Currency_Base__TotalBaseImport_Control84; "Additional-Currency Base" - TotalBaseImport)
                {
                }
                column(AmountVatReverse_Control85; AmountVatReverse)
                {
                }
                column(Additional_Currency_Base__AmountVatReverse; "Additional-Currency Base" + AmountVatReverse)
                {
                }
                column(Base_TotalBaseImport_Control23; Base - TotalBaseImport)
                {
                }
                column(AmountVatReverse3_Control40; AmountVatReverse3)
                {
                }
                column(Base_AmountVatReverse3_Control65; Base + AmountVatReverse3)
                {
                }
                column(Additional_Currency_Base__TotalBaseImport_Control33; "Additional-Currency Base" - TotalBaseImport)
                {
                }
                column(AmountVatReverse3_Control34; AmountVatReverse3)
                {
                }
                column(Additional_Currency_Base__AmountVatReverse3_Control35; "Additional-Currency Base" + AmountVatReverse3)
                {
                }
                column(Base_Base2__TotalBaseImport_Control131;(Base + Base2) - TotalBaseImport)
                {
                }
                column(AmountVatReverse3_Amount2_Control132; AmountVatReverse3 + Amount2)
                {
                }
                column(Base_Base2___AmountVatReverse3_Amount2__Control133;(Base + Base2) + (AmountVatReverse3 + Amount2))
                {
                }
                column(Additional_Currency_Base__TotalBaseImport_Control135; "Additional-Currency Base" - TotalBaseImport)
                {
                }
                column(AmountVatReverse3_Control136; AmountVatReverse3)
                {
                }
                column(Additional_Currency_Base__AmountVatReverse3_Control137; "Additional-Currency Base" + AmountVatReverse3)
                {
                }
                column(Base_Base2__TotalBaseImport_Control57;(Base + Base2) - TotalBaseImport)
                {
                }
                column(AmountVatReverse_Amount2; AmountVatReverse + Amount2)
                {
                }
                column(Base_Base2___AmountVatReverse_Amount2_;(Base + Base2) + (AmountVatReverse + Amount2))
                {
                }
                column(Additional_Currency_Base__Base2__TotalBaseImport_Control124;("Additional-Currency Base" + Base2) - TotalBaseImport)
                {
                }
                column(AmountVatReverse___Amount2; AmountVatReverse + Amount2)
                {
                }
                column(Additional_Currency_Base__Base2___AmountVatReverse_Amount2_;("Additional-Currency Base" + Base2) + (AmountVatReverse + Amount2))
                {
                }
                column(VATEntry_Entry_No_; "Entry No.")
                {
                }
                column(VATEntry_Type; Type)
                {
                }
                column(VATEntry_Posting_Date; "Posting Date")
                {
                }
                column(VATEntry_Document_Type; "Document Type")
                {
                }
                column(VATEntry_Document_No_; "Document No.")
                {
                }
                column(ContinuedCaption; ContinuedCaptionLbl)
                {
                }
                column(ContinuedCaption_Control28; ContinuedCaption_Control28Lbl)
                {
                }
                column(ContinuedCaption_Control48; ContinuedCaption_Control48Lbl)
                {
                }
                column(ContinuedCaption_Control49; ContinuedCaption_Control49Lbl)
                {
                }
                column(VATEntry__No__Series_Caption; FIELDCAPTION("No. Series"))
                {
                }
                column(VATEntry__No__Series__Control75Caption; FIELDCAPTION("No. Series"))
                {
                }
                column(TotalCaption_Control77; TotalCaption_Control77Lbl)
                {
                }
                column(TotalCaption_Control78; TotalCaption_Control78Lbl)
                {
                }
                column(VATEntry__No__Series__Control80Caption; FIELDCAPTION("No. Series"))
                {
                }
                column(ContinuedCaption_Control18; ContinuedCaption_Control18Lbl)
                {
                }
                column(ContinuedCaption_Control32; ContinuedCaption_Control32Lbl)
                {
                }
                column(ContinuedCaption_Control130; ContinuedCaption_Control130Lbl)
                {
                }
                column(ContinuedCaption_Control134; ContinuedCaption_Control134Lbl)
                {
                }
                column(TotalCaption_Control54; TotalCaption_Control54Lbl)
                {
                }
                column(TotalCaption_Control127; TotalCaption_Control127Lbl)
                {
                }
                dataitem(VATEntry6;254)
                {
                    DataItemTableView = SORTING(Type, "Posting Date", "Document Type", "Document No.", "Bill-to/Pay-to No.")WHERE(Type=CONST(Purchase));

                    column(VATEntry6_Entry_No_; "Entry No.")
                    {
                    }
                    column(VATEntry6_Type; Type)
                    {
                    }
                    column(VATEntry6_Posting_Date; "Posting Date")
                    {
                    }
                    column(VATEntry6_Document_Type; "Document Type")
                    {
                    }
                    column(VATEntry6_Document_No_; "Document No.")
                    {
                    }
                    dataitem(VATEntry7;254)
                    {
                        DataItemLink = Type=FIELD(Type), "Posting Date"=FIELD("Posting Date"), "Document Type"=FIELD("Document Type"), "Document No."=FIELD("Document No.");
                        DataItemTableView = SORTING(Type, "Posting Date", "Document Type", "Document No.", "Bill-to/Pay-to No.");

                        trigger OnAfterGetRecord()
                        begin
                            VATBuffer3."VAT %":="VAT %";
                            VATBuffer3."EC %":="EC %";
                            IF "VAT Calculation Type" = "VAT Calculation Type"::"Reverse Charge VAT" THEN BEGIN
                                IF NOT PrintAmountsInAddCurrency THEN IF VATBuffer3.FIND THEN BEGIN
                                        VATBuffer3.Base:=VATBuffer3.Base + Base;
                                        VATBuffer3.Amount:=VATBuffer3.Amount + Amount;
                                        VATBuffer3.MODIFY;
                                    END
                                    ELSE
                                    BEGIN
                                        VATBuffer3.Base:=Base;
                                        VATBuffer3.Amount:=Amount;
                                        VATBuffer3.INSERT;
                                    END
                                ELSE IF VATBuffer3.FIND THEN BEGIN
                                        VATBuffer3.Base:=VATBuffer3.Base + "Additional-Currency Base";
                                        VATBuffer3.Amount:=VATBuffer3.Amount + "Additional-Currency Amount";
                                        VATBuffer3.MODIFY;
                                    END
                                    ELSE
                                    BEGIN
                                        VATBuffer3.Base:="Additional-Currency Base";
                                        VATBuffer3.Amount:="Additional-Currency Amount";
                                        VATBuffer3.INSERT;
                                    END END;
                            IF "VAT Calculation Type" = "VAT Calculation Type"::"Reverse Charge VAT" THEN BEGIN
                                NotBaseReverse:=NotBaseReverse + VATBuffer3.Base;
                                NotAmountReverse:=NotAmountReverse + VATBuffer3.Amount;
                            END;
                        end;
                        trigger OnPostDataItem()
                        begin
                            VATEntry6:=VATEntry7;
                        end;
                        trigger OnPreDataItem()
                        begin
                            CLEAR(PurchCrMemoHeader);
                            CLEAR(PurchInvHeader);
                            CLEAR(Vendor);
                            PurchInvHeader.RESET;
                            PurchCrMemoHeader.RESET;
                            Vendor.RESET;
                            VendLedgEntry.SETCURRENTKEY("Document No.", "Document Type", "Vendor No.");
                            CASE VATEntry6."Document Type" OF "Document Type"::"Credit Memo": IF PurchCrMemoHeader.GET(VATEntry6."Document No.")THEN BEGIN
                                    Vendor.Name:=PurchCrMemoHeader."Pay-to Name";
                                    Vendor."VAT Registration No.":=PurchCrMemoHeader."VAT Registration No.";
                                    VendLedgEntry.SETRANGE("Document No.", VATEntry6."Document No.");
                                    VendLedgEntry.SETRANGE("Document Type", "Document Type"::"Credit Memo");
                                    IF VendLedgEntry.FINDFIRST THEN AutoDocNo:=VendLedgEntry."Autodocument No.";
                                    EXIT;
                                END;
                            "Document Type"::Invoice: IF PurchInvHeader.GET(VATEntry6."Document No.")THEN BEGIN
                                    Vendor.Name:=PurchInvHeader."Pay-to Name";
                                    Vendor."VAT Registration No.":=PurchInvHeader."VAT Registration No.";
                                    VendLedgEntry.SETRANGE("Document No.", VATEntry6."Document No.");
                                    VendLedgEntry.SETRANGE("Document Type", "Document Type"::Invoice);
                                    IF VendLedgEntry.FINDFIRST THEN AutoDocNo:=VendLedgEntry."Autodocument No.";
                                    EXIT;
                                END;
                            END;
                            IF NOT Vendor.GET(VATEntry6."Bill-to/Pay-to No.")THEN Vendor.Name:=Text1100003;
                            VendLedgEntry.SETCURRENTKEY("Document No.", "Document Type", "Vendor No.");
                            VendLedgEntry.SETRANGE("Document No.", VATEntry6."Document No.");
                            VendLedgEntry.SETFILTER("Document Type", Text1100004);
                            IF VendLedgEntry.FINDFIRST THEN;
                        end;
                    }
                    dataitem("<Integer4>";2000000026)
                    {
                        DataItemTableView = SORTING(Number);

                        column(VATBuffer4_Base_VATBuffer4_Amount; VATBuffer4.Base + VATBuffer4.Amount)
                        {
                        }
                        column(VATBuffer4_Amount; VATBuffer4.Amount)
                        {
                        }
                        column(VATBuffer4_Base; VATBuffer4.Base)
                        {
                        }
                        column(CompanyInfo_Name; CompanyInfo.Name)
                        {
                        }
                        column(VATEntry7__Document_No__; VATEntry7."Document No.")
                        {
                        }
                        column(VATEntry7__Posting_Date_; FORMAT(VATEntry7."Posting Date"))
                        {
                        }
                        column(AutoDocNo; AutoDocNo)
                        {
                        }
                        column(DocType; DocType)
                        {
                        }
                        column(CompanyInfo__VAT_Registration_No__; CompanyInfo."VAT Registration No.")
                        {
                        }
                        column(VATBuffer4__VAT___; VATBuffer4."VAT %")
                        {
                        }
                        column(VATBuffer4__EC___; VATBuffer4."EC %")
                        {
                        }
                        column(FORMAT_VATEntry7__Document_Date__; FORMAT(VATEntry7."Document Date"))
                        {
                        }
                        column(VATBuffer4_Base_VATBuffer4_Amount_Control43; VATBuffer4.Base + VATBuffer4.Amount)
                        {
                        }
                        column(VATBuffer4_Amount_Control44; VATBuffer4.Amount)
                        {
                        }
                        column(VATBuffer4_Base_Control47; VATBuffer4.Base)
                        {
                        }
                        column(VATBuffer4__VAT____Control10; VATBuffer4."VAT %")
                        {
                        }
                        column(VATBuffer4__EC____Control19; VATBuffer4."EC %")
                        {
                        }
                        column(Integer4__Number; Number)
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            IF Fin THEN CurrReport.BREAK;
                            VATBuffer4:=VATBuffer3;
                            Fin:=VATBuffer3.NEXT = 0;
                        end;
                        trigger OnPreDataItem()
                        begin
                            VATBuffer3.FIND('-');
                            //CurrReport.CREATETOTALS(VATBuffer4.Base, VATBuffer4.Amount);
                            Fin:=FALSE;
                            LineNo:=0;
                        end;
                    }
                    trigger OnAfterGetRecord()
                    begin
                        IF NOT Show THEN CurrReport.BREAK;
                        VATBuffer3.DELETEALL;
                        NoSeriesAuxPrev:=NoSeriesAux;
                        IF "Document Type" = "Document Type"::"Credit Memo" THEN BEGIN
                            GLSetup.GET;
                            NoSeriesAux:=GLSetup."Autocredit Memo Nos.";
                        END;
                        IF "Document Type" = "Document Type"::Invoice THEN BEGIN
                            GLSetup.GET;
                            NoSeriesAux:=GLSetup."Autoinvoice Nos.";
                        END;
                        IF NoSeriesAux <> NoSeriesAuxPrev THEN BEGIN
                            NotBaseReverse:=0;
                            NotAmountReverse:=0;
                        END;
                    end;
                    trigger OnPostDataItem()
                    begin
                        PrevData:=VATEntry."Posting Date" + 1;
                    end;
                    trigger OnPreDataItem()
                    begin
                        IF NOT SortPostDate OR NOT ShowAutoInvCred THEN CurrReport.BREAK;
                        SETRANGE("Generated Autodocument", TRUE);
                        IF FIND('-')THEN;
                        IF i = 1 THEN BEGIN
                            REPEAT VatEntryTemporary.INIT;
                                VatEntryTemporary.COPY(VATEntry6);
                                VatEntryTemporary.INSERT;
                                VatEntryTemporary.NEXT;
                            UNTIL NEXT = 0;
                            IF FIND('-')THEN;
                            i:=0;
                        END;
                        SETFILTER("Posting Date", '%1..%2', PrevData, VATEntry."Posting Date");
                        SETFILTER("Document No.", VATEntry.GETFILTER("Document No."));
                        SETFILTER("Document Type", VATEntry.GETFILTER("Document Type"));
                        IF VatEntryTemporary.FIND('-')THEN;
                        VatEntryTemporary.SETRANGE("Generated Autodocument", TRUE);
                        VatEntryTemporary.SETFILTER("Posting Date", '%1..%2', PrevData, VATEntry."Posting Date");
                        IF VatEntryTemporary.FIND('-')THEN BEGIN
                            Show:=TRUE;
                            VatEntryTemporary.DELETEALL;
                        END
                        ELSE
                            Show:=FALSE;
                    end;
                }
                dataitem(VATEntry2;254)
                {
                    DataItemLink = Type=FIELD(Type), "Posting Date"=FIELD("Posting Date"), "Document Type"=FIELD("Document Type"), "Document No."=FIELD("Document No.");
                    DataItemTableView = SORTING("No. Series", "Posting Date");

                    trigger OnAfterGetRecord()
                    begin
                        IF ShowAutoInvCred AND ("VAT Calculation Type" = "VAT Calculation Type"::"Reverse Charge VAT")THEN BEGIN
                            VATBuffer."VAT %":=0;
                            VATBuffer."EC %":=0;
                        END
                        ELSE
                        BEGIN
                            VATBuffer."VAT %":="VAT %";
                            VATBuffer."EC %":="EC %";
                        END;
                        IF NOT PrintAmountsInAddCurrency THEN BEGIN
                            IF "VAT Calculation Type" = "VAT Calculation Type"::"Full VAT" THEN Base:=0;
                            IF VATBuffer.FIND THEN BEGIN
                                VATBuffer.Base:=VATBuffer.Base + Base;
                                IF "VAT Calculation Type" = "VAT Calculation Type"::"Full VAT" THEN BaseImport:=BaseImport + Base;
                                IF(NOT ShowAutoInvCred) OR ("VAT Calculation Type" <> "VAT Calculation Type"::"Reverse Charge VAT")THEN BEGIN
                                    VATBuffer.Amount:=VATBuffer.Amount + Amount;
                                    AmountVatReverse:=AmountVatReverse + Amount;
                                END;
                                VATBuffer.MODIFY;
                            END
                            ELSE
                            BEGIN
                                VATBuffer.Base:=Base;
                                IF "VAT Calculation Type" = "VAT Calculation Type"::"Full VAT" THEN BaseImport:=Base;
                                IF(NOT ShowAutoInvCred) OR ("VAT Calculation Type" <> "VAT Calculation Type"::"Reverse Charge VAT")THEN BEGIN
                                    VATBuffer.Amount:=Amount;
                                    AmountVatReverse:=AmountVatReverse + Amount;
                                END
                                ELSE
                                    VATBuffer.Amount:=0;
                                VATBuffer.INSERT;
                            END;
                        END
                        ELSE
                        BEGIN
                            IF "VAT Calculation Type" = "VAT Calculation Type"::"Full VAT" THEN "Additional-Currency Base":=0;
                            IF VATBuffer.FIND THEN BEGIN
                                VATBuffer.Base:=VATBuffer.Base + "Additional-Currency Base";
                                IF "VAT Calculation Type" = "VAT Calculation Type"::"Full VAT" THEN BaseImport:=BaseImport + "Additional-Currency Base";
                                IF(NOT ShowAutoInvCred) OR ("VAT Calculation Type" <> "VAT Calculation Type"::"Reverse Charge VAT")THEN BEGIN
                                    VATBuffer.Amount:=VATBuffer.Amount + "Additional-Currency Amount";
                                    AmountVatReverse:=AmountVatReverse + "Additional-Currency Amount";
                                END;
                                VATBuffer.MODIFY;
                            END
                            ELSE
                            BEGIN
                                VATBuffer.Base:="Additional-Currency Base";
                                IF "VAT Calculation Type" = "VAT Calculation Type"::"Full VAT" THEN BaseImport:="Additional-Currency Base";
                                IF(NOT ShowAutoInvCred) OR ("VAT Calculation Type" <> "VAT Calculation Type"::"Reverse Charge VAT")THEN BEGIN
                                    VATBuffer.Amount:="Additional-Currency Amount";
                                    AmountVatReverse:=AmountVatReverse + "Additional-Currency Amount";
                                END
                                ELSE
                                    VATBuffer.Amount:=0;
                                VATBuffer.INSERT;
                            END;
                        END;
                        IF "VAT Calculation Type" = "VAT Calculation Type"::"Full VAT" THEN TotalBaseImport:=TotalBaseImport + BaseImport;
                        TempVATEntry:=VATEntry2;
                        IF NOT TempVATEntry.FIND THEN TempVATEntry.INSERT;
                    end;
                    trigger OnPreDataItem()
                    begin
                        IF SortPostDate THEN SETCURRENTKEY(Type, "Posting Date", "Document Type", "Document No.", "Bill-to/Pay-to No.")
                        ELSE
                            SETCURRENTKEY("No. Series", "Posting Date");
                        SETRANGE("No. Series", VATEntry."No. Series");
                        CLEAR(PurchCrMemoHeader);
                        CLEAR(PurchInvHeader);
                        CLEAR(Vendor);
                        IF NOT PrintAmountsInAddCurrency THEN GLSetup.GET
                        ELSE
                        BEGIN
                            GLSetup.GET;
                            Currency.GET(GLSetup."Additional Reporting Currency");
                        END;
                        CASE VATEntry."Document Type" OF "Document Type"::"Credit Memo": IF PurchCrMemoHeader.GET(VATEntry."Document No.")THEN BEGIN
                                Vendor."No.":=PurchCrMemoHeader."Pay-to Vendor No."; //ADV001
                                Vendor.Name:=PurchCrMemoHeader."Pay-to Name";
                                Vendor."VAT Registration No.":=PurchCrMemoHeader."VAT Registration No.";
                                EXIT;
                            END;
                        "Document Type"::Invoice: IF PurchInvHeader.GET(VATEntry."Document No.")THEN BEGIN
                                Vendor."No.":=PurchCrMemoHeader."Pay-to Vendor No."; //ADV001
                                Vendor.Name:=PurchInvHeader."Pay-to Name";
                                Vendor."VAT Registration No.":=PurchInvHeader."VAT Registration No.";
                                EXIT;
                            END;
                        END;
                        IF NOT Vendor.GET(VATEntry."Bill-to/Pay-to No.")THEN Vendor.Name:=Text1100003;
                    end;
                }
                dataitem(DataItem5444;2000000026)
                {
                    DataItemTableView = SORTING(Number);

                    column(VATEntry2__Document_No__; VATEntry2."Document No.")
                    {
                    }
                    column(VATBuffer2_Base; VATBuffer2.Base)
                    {
                    }
                    column(VATEntry2__Posting_Date_; FORMAT(VATEntry2."Posting Date"))
                    {
                    }
                    column(Vendor_Name; Vendor.Name)
                    {
                    }
                    column(DocType_Control11; DocType)
                    {
                    }
                    column(VATBuffer2_Amount; VATBuffer2.Amount)
                    {
                    }
                    column(VATBuffer2_Base_VATBuffer2_Amount; VATBuffer2.Base + VATBuffer2.Amount)
                    {
                    }
                    column(VATEntry2__External_Document_No__; VATEntry2."External Document No.")
                    {
                    }
                    column(Vendor__VAT_Registration_No__; Vendor."VAT Registration No.")
                    {
                    }
                    column(Vendor_No; Vendor."No.")
                    {
                    }
                    column(VATBuffer2__VAT___; VATBuffer2."VAT %")
                    {
                    }
                    column(VATBuffer2__EC___; VATBuffer2."EC %")
                    {
                    }
                    column(FORMAT_VATEntry2__Document_Date__; FORMAT(VATEntry2."Document Date"))
                    {
                    }
                    column(VATBuffer2_Base_VATBuffer2_Amount_Control53; VATBuffer2.Base + VATBuffer2.Amount)
                    {
                    }
                    column(VATBuffer2_Amount_Control58; VATBuffer2.Amount)
                    {
                    }
                    column(VATBuffer2_Base_Control61; VATBuffer2.Base)
                    {
                    }
                    column(VATBuffer2__VAT____Control59; VATBuffer2."VAT %")
                    {
                    }
                    column(VATBuffer2__EC____Control60; VATBuffer2."EC %")
                    {
                    }
                    column(VATBuffer2_Base_Control62; VATBuffer2.Base)
                    {
                    }
                    column(VATBuffer2_Amount_Control63; VATBuffer2.Amount)
                    {
                    }
                    column(VATBuffer2_Base_VATBuffer2_Amount_Control64; VATBuffer2.Base + VATBuffer2.Amount)
                    {
                    }
                    column(Integer_Number; Number)
                    {
                    }
                    column(TotalCaption_Control26; TotalCaption_Control26Lbl)
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        IF Fin THEN CurrReport.BREAK;
                        VATBuffer2:=VATBuffer;
                        Fin:=VATBuffer.NEXT = 0;
                    end;
                    trigger OnPreDataItem()
                    begin
                        VATBuffer.FIND('-');
                        //CurrReport.CREATETOTALS(VATBuffer2.Base, VATBuffer2.Amount);
                        Fin:=FALSE;
                        LineNo:=0;
                    end;
                }
                trigger OnAfterGetRecord()
                begin
                    VATBuffer.DELETEALL;
                    TempVATEntry:=VATEntry;
                    IF TempVATEntry.FIND THEN CurrReport.SKIP;
                    AmountVatReverse3:=AmountVatReverse;
                    DocType:=FORMAT("Document Type");
                    IF "Document Type" = "Document Type"::"Credit Memo" THEN DocType:=Text1100005;
                end;
                trigger OnPreDataItem()
                begin
                    IF GETFILTER("Posting Date") = '' THEN PrevData:=0D
                    ELSE
                        PrevData:=GETRANGEMIN("Posting Date");
                    i:=1;
                    IF SortPostDate THEN SETCURRENTKEY(Type, "Posting Date", "Document Type", "Document No.", "Bill-to/Pay-to No.")
                    ELSE
                        SETCURRENTKEY("No. Series", "Posting Date", "Document No.");
                    if OnlyIncludeSIIDocuments then SetRange("Do Not Send To SII", false);
                    TempVATEntry.RESET;
                    TempVATEntry.DELETEALL;
                end;
            }
            dataitem(VATEntry3;254)
            {
                DataItemTableView = SORTING("Document Type", "No. Series", "Posting Date")WHERE(Type=CONST(Purchase));

                column(VarNotAmountReverse; VarNotAmountReverse)
                {
                }
                column(VarNotBaseReverse; VarNotBaseReverse)
                {
                }
                column(VarNotBaseReverse_VarNotAmountReverse; VarNotBaseReverse + VarNotAmountReverse)
                {
                }
                column(No_SeriesAux_; NoSeriesAux)
                {
                }
                column(No_SeriesAux__Control107; NoSeriesAux)
                {
                }
                column(NotBaseReverse; NotBaseReverse)
                {
                }
                column(NotAmountReverse; NotAmountReverse)
                {
                }
                column(NotBaseReverse_NotAmountReverse; NotBaseReverse + NotAmountReverse)
                {
                }
                column(VarNotBaseReverse_Control120; VarNotBaseReverse)
                {
                }
                column(VarNotAmountReverse_Control156; VarNotAmountReverse)
                {
                }
                column(VarNotBaseReverse_VarNotAmountReverse_Control159; VarNotBaseReverse + VarNotAmountReverse)
                {
                }
                column(VATEntry3_Entry_No_; "Entry No.")
                {
                }
                column(VATEntry3_Document_Type; "Document Type")
                {
                }
                column(VATEntry3_Type; Type)
                {
                }
                column(VATEntry3_Posting_Date; "Posting Date")
                {
                }
                column(VATEntry3_Document_No_; "Document No.")
                {
                }
                column(ContinuedCaption_Control103; ContinuedCaption_Control103Lbl)
                {
                }
                column(No_SerieCaption; No_SerieCaptionLbl)
                {
                }
                column(TotalCaption_Control96; TotalCaption_Control96Lbl)
                {
                }
                column(No_SerieCaption_Control97; No_SerieCaption_Control97Lbl)
                {
                }
                column(ContinuedCaption_Control119; ContinuedCaption_Control119Lbl)
                {
                }
                dataitem(VATEntry4;254)
                {
                    DataItemLink = Type=FIELD(Type), "Posting Date"=FIELD("Posting Date"), "Document Type"=FIELD("Document Type"), "Document No."=FIELD("Document No.");
                    DataItemTableView = SORTING("No. Series", "Posting Date");

                    column(VATEntry4_Type; Type)
                    {
                    }
                    column(VATEntry4_Entry_No_; "Entry No.")
                    {
                    }
                    column(VATEntry4_Posting_Date; "Posting Date")
                    {
                    }
                    column(VATEntry4_Document_Type; "Document Type")
                    {
                    }
                    column(VATEntry4_Document_No_; "Document No.")
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        VATBuffer."VAT %":="VAT %";
                        VATBuffer."EC %":="EC %";
                        IF "VAT Calculation Type" = "VAT Calculation Type"::"Reverse Charge VAT" THEN BEGIN
                            IF NOT PrintAmountsInAddCurrency THEN IF VATBuffer.FIND THEN BEGIN
                                    VarBase2:=(VATBuffer.Base + Base) - VATBuffer.Base;
                                    VarAmount2:=(VATBuffer.Amount + Amount) - VATBuffer.Amount;
                                    VATBuffer.Base:=VATBuffer.Base + Base;
                                    VATBuffer.Amount:=VATBuffer.Amount + Amount;
                                    VATBuffer.MODIFY;
                                END
                                ELSE
                                BEGIN
                                    VarBase2:=Base;
                                    VarAmount2:=Amount;
                                    VATBuffer.Base:=Base;
                                    VATBuffer.Amount:=Amount;
                                    VATBuffer.INSERT;
                                END
                            ELSE IF VATBuffer.FIND THEN BEGIN
                                    VATBuffer.Base:=VATBuffer.Base + "Additional-Currency Base";
                                    VATBuffer.Amount:=VATBuffer.Amount + "Additional-Currency Amount";
                                    VATBuffer.MODIFY;
                                END
                                ELSE
                                BEGIN
                                    VATBuffer.Base:="Additional-Currency Base";
                                    VATBuffer.Amount:="Additional-Currency Amount";
                                    VATBuffer.INSERT;
                                END END;
                        IF "VAT Calculation Type" = "VAT Calculation Type"::"Reverse Charge VAT" THEN BEGIN
                            IF NOT PrintAmountsInAddCurrency THEN BEGIN
                                NotBaseReverse:=NotBaseReverse + VarBase2;
                                NotAmountReverse:=NotAmountReverse + VarAmount2;
                            END
                            ELSE
                            BEGIN
                                NotBaseReverse:=NotBaseReverse + VATBuffer.Base;
                                NotAmountReverse:=NotAmountReverse + VATBuffer.Amount;
                            END;
                        END;
                    end;
                    trigger OnPostDataItem()
                    begin
                        VATEntry3:=VATEntry4;
                    end;
                    trigger OnPreDataItem()
                    begin
                        CLEAR(PurchCrMemoHeader);
                        CLEAR(PurchInvHeader);
                        CLEAR(Vendor);
                        PurchInvHeader.RESET;
                        PurchCrMemoHeader.RESET;
                        Vendor.RESET;
                        VendLedgEntry.SETCURRENTKEY("Document No.", "Document Type", "Vendor No.");
                        CASE VATEntry3."Document Type" OF "Document Type"::"Credit Memo": IF PurchCrMemoHeader.GET(VATEntry3."Document No.")THEN BEGIN
                                Vendor.Name:=PurchCrMemoHeader."Pay-to Name";
                                Vendor."VAT Registration No.":=PurchCrMemoHeader."VAT Registration No.";
                                VendLedgEntry.SETRANGE("Document No.", VATEntry3."Document No.");
                                VendLedgEntry.SETRANGE("Document Type", "Document Type"::"Credit Memo");
                                IF VendLedgEntry.FINDFIRST THEN AutoDocNo:=VendLedgEntry."Autodocument No.";
                                EXIT;
                            END;
                        "Document Type"::Invoice: IF PurchInvHeader.GET(VATEntry3."Document No.")THEN BEGIN
                                Vendor.Name:=PurchInvHeader."Pay-to Name";
                                Vendor."VAT Registration No.":=PurchInvHeader."VAT Registration No.";
                                VendLedgEntry.SETRANGE("Document No.", VATEntry3."Document No.");
                                VendLedgEntry.SETRANGE("Document Type", "Document Type"::Invoice);
                                IF VendLedgEntry.FINDFIRST THEN AutoDocNo:=VendLedgEntry."Autodocument No.";
                                EXIT;
                            END;
                        END;
                        IF NOT Vendor.GET(VATEntry3."Bill-to/Pay-to No.")THEN Vendor.Name:=Text1100003;
                        VendLedgEntry.SETCURRENTKEY("Document No.", "Document Type", "Vendor No.");
                        VendLedgEntry.SETRANGE("Document No.", VATEntry3."Document No.");
                        VendLedgEntry.SETFILTER("Document Type", Text1100004);
                        IF VendLedgEntry.FINDFIRST THEN;
                    end;
                }
                dataitem("<Integer2>";2000000026)
                {
                    DataItemTableView = SORTING(Number);

                    column(VATBuffer2_Base_VATBuffer2_Amount_Control81; VATBuffer2.Base + VATBuffer2.Amount)
                    {
                    }
                    column(VATBuffer2_Amount_Control82; VATBuffer2.Amount)
                    {
                    }
                    column(VATBuffer2__EC____Control83; VATBuffer2."EC %")
                    {
                    }
                    column(VATBuffer2__VAT____Control87; VATBuffer2."VAT %")
                    {
                    }
                    column(VATBuffer2_Base_Control88; VATBuffer2.Base)
                    {
                    }
                    column(CompanyInfo__VAT_Registration_No___Control89; CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(CompanyInfo_Name_Control90; CompanyInfo.Name)
                    {
                    }
                    column(VATEntry4__Document_No__; VATEntry4."Document No.")
                    {
                    }
                    column(VATEntry4__Document_Type_; VATEntry4."Document Type")
                    {
                    }
                    column(AutoDocNo_Control93; AutoDocNo)
                    {
                    }
                    column(VATEntry4__Posting_Date_; FORMAT(VATEntry4."Posting Date"))
                    {
                    }
                    column(FORMAT_VATEntry4__Document_Date__; FORMAT(VATEntry4."Document Date"))
                    {
                    }
                    column(VATBuffer2_Base_Control98; VATBuffer2.Base)
                    {
                    }
                    column(VATBuffer2__VAT____Control99; VATBuffer2."VAT %")
                    {
                    }
                    column(VATBuffer2__EC____Control100; VATBuffer2."EC %")
                    {
                    }
                    column(VATBuffer2_Amount_Control101; VATBuffer2.Amount)
                    {
                    }
                    column(VATBuffer2_Base_VATBuffer2_Amount_Control102; VATBuffer2.Base + VATBuffer2.Amount)
                    {
                    }
                    column(VATBuffer2_Base_Control22; VATBuffer2.Base)
                    {
                    }
                    column(VATBuffer2_Amount_Control24; VATBuffer2.Amount)
                    {
                    }
                    column(VATBuffer2_Base_VATBuffer2_Amount_Control27; VATBuffer2.Base + VATBuffer2.Amount)
                    {
                    }
                    column(Integer2__Number; Number)
                    {
                    }
                    column(TotalCaption_Control21; TotalCaption_Control21Lbl)
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        IF Fin THEN CurrReport.BREAK;
                        VATBuffer2:=VATBuffer;
                        Fin:=VATBuffer.NEXT = 0;
                    end;
                    trigger OnPreDataItem()
                    begin
                        VATBuffer.FIND('-');
                        //CurrReport.CREATETOTALS(VATBuffer2.Base, VATBuffer2.Amount);
                        Fin:=FALSE;
                        LineNo:=0;
                    end;
                }
                trigger OnAfterGetRecord()
                begin
                    VATBuffer.DELETEALL;
                    NoSeriesAuxPrev:=NoSeriesAux;
                    IF "Document Type" = "Document Type"::"Credit Memo" THEN BEGIN
                        GLSetup.GET;
                        NoSeriesAux:=GLSetup."Autocredit Memo Nos.";
                    END;
                    IF "Document Type" = "Document Type"::Invoice THEN BEGIN
                        GLSetup.GET;
                        NoSeriesAux:=GLSetup."Autoinvoice Nos.";
                    END;
                    IF NoSeriesAux <> NoSeriesAuxPrev THEN BEGIN
                        NotBaseReverse:=0;
                        NotAmountReverse:=0;
                        VarNotBaseReverse:=0;
                        VarNotAmountReverse:=0;
                    END;
                end;
                trigger OnPreDataItem()
                begin
                    IF SortPostDate OR NOT ShowAutoInvCred THEN CurrReport.BREAK;
                    SETRANGE("Generated Autodocument", TRUE);
                    IF FIND('-')THEN;
                    SETFILTER("Posting Date", VATEntry.GETFILTER("Posting Date"));
                    SETFILTER("Document No.", VATEntry.GETFILTER("Document No."));
                    SETFILTER("Document Type", VATEntry.GETFILTER("Document Type"));
                    NotBaseReverse:=0;
                    NotAmountReverse:=0;
                end;
            }
            trigger OnPreDataItem()
            begin
                GLSetup.GET;
                IF PrintAmountsInAddCurrency THEN HeaderText:=STRSUBSTNO(Text1100002, GLSetup."Additional Reporting Currency")
                ELSE
                BEGIN
                    GLSetup.TESTFIELD("LCY Code");
                    HeaderText:=STRSUBSTNO(Text1100002, GLSetup."LCY Code");
                END;
                CompanyInfo.GET;
                CompanyAddr[1]:=CompanyInfo.Name;
                CompanyAddr[2]:=CompanyInfo."Name 2";
                CompanyAddr[3]:=CompanyInfo.Address;
                CompanyAddr[4]:=CompanyInfo."Address 2";
                CompanyAddr[5]:=CompanyInfo.City;
                CompanyAddr[6]:=CompanyInfo."Post Code" + ' ' + CompanyInfo.County;
                IF CompanyInfo."VAT Registration No." <> '' THEN CompanyAddr[7]:=Text1100000 + CompanyInfo."VAT Registration No."
                ELSE
                    ERROR(Text1100001);
                COMPRESSARRAY(CompanyAddr);
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field(PrintAmountsInAddCurrency; PrintAmountsInAddCurrency)
                    {
                        ApplicationArea = All;
                        Caption = 'Muestra importes en divisa adicional';
                    }
                    field(SortPostDate; SortPostDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Ordena por fecha regis.';
                    }
                    field(ShowAutoInvCred; ShowAutoInvCred)
                    {
                        ApplicationArea = All;
                        Caption = 'Muestra autofacturas/autoabonos';
                    }
                    field(OnlyIncludeSIIDocumentsOption; OnlyIncludeSIIDocuments)
                    {
                        ApplicationArea = All;
                        Caption = 'Incluir solo documentos SII';
                        ToolTip = 'Specifies if only the documents to send to SII will be present in the report.';
                    }
                }
            }
        }
        actions
        {
        }
        trigger OnOpenPage()
        begin
            ShowAutoInvCred:=FALSE;
        end;
    }
    labels
    {
    }
    trigger OnPreReport()
    begin
        AuxVatEntry:=VATEntry.GETFILTERS;
        MaxLines:=52;
    end;
    var Text1100000: Label 'CIF/NIF';
    Text1100001: Label 'Please, specify the VAT Registration Nº of your Company in the Company information Window';
    Text1100002: Label 'Importes en %1';
    Text1100003: Label 'UNKNOWN';
    Text1100004: Label 'Factura|Abono';
    PurchInvHeader: Record 122;
    PurchCrMemoHeader: Record 124;
    Vendor: Record 23;
    CompanyInfo: Record 79;
    VATBuffer: Record 10704 temporary;
    VATBuffer2: Record 10704;
    VATBuffer3: Record 10704 temporary;
    VATBuffer4: Record 10704 temporary;
    GLSetup: Record 98;
    Currency: Record 4;
    VendLedgEntry: Record 25;
    VatEntryTemporary: Record 254 temporary;
    HeaderText: Text[250];
    CompanyAddr: array[7]of Text[150];
    LineNo: Decimal;
    Fin: Boolean;
    PrintAmountsInAddCurrency: Boolean;
    NoSeriesAux: Code[20];
    AutoDocNo: Code[20];
    AmountVatReverse: Decimal;
    NotBaseReverse: Decimal;
    NotAmountReverse: Decimal;
    NoSeriesAuxPrev: Code[20];
    AuxVatEntry: Text[250];
    SortPostDate: Boolean;
    Show: Boolean;
    i: Integer;
    PrevData: Date;
    Base2: Decimal;
    Amount2: Decimal;
    ShowAutoInvCred: Boolean;
    VarBase2: Decimal;
    VarAmount2: Decimal;
    VarNotBaseReverse: Decimal;
    VarNotAmountReverse: Decimal;
    AmountVatReverse3: Decimal;
    BaseImport: Decimal;
    TotalBaseImport: Decimal;
    MaxLines: Integer;
    Text1100005: Label 'Corrective Invoice';
    DocType: Text[30];
    CurrReport_PAGENOCaptionLbl: Label 'Pág';
    Purchases_Invoice_BookCaptionLbl: Label 'Libro facturas recibidas';
    TotalCaptionLbl: Label 'Total';
    AmountCaptionLbl: Label 'Importe';
    EC_CaptionLbl: Label '% RE';
    VAT_CaptionLbl: Label '% IVA';
    BaseCaptionLbl: Label 'Base';
    VAT_RegistrationCaptionLbl: Label 'CIF/NIF';
    NameCaptionLbl: Label 'Nombre';
    External_Document_No_CaptionLbl: Label 'Nº documento externo';
    Posting_DateCaptionLbl: Label 'Fecha registro';
    Document_No_CaptionLbl: Label 'Nº documuento';
    Epedition_DateCaptionLbl: Label 'Fecha expedición';
    ContinuedCaptionLbl: Label 'Continued';
    ContinuedCaption_Control28Lbl: Label 'Continued';
    ContinuedCaption_Control48Lbl: Label 'Continued';
    ContinuedCaption_Control49Lbl: Label 'Continued';
    TotalCaption_Control77Lbl: Label 'Total';
    TotalCaption_Control78Lbl: Label 'Total';
    ContinuedCaption_Control18Lbl: Label 'Continued';
    ContinuedCaption_Control32Lbl: Label 'Continued';
    ContinuedCaption_Control130Lbl: Label 'Continued';
    ContinuedCaption_Control134Lbl: Label 'Continued';
    TotalCaption_Control54Lbl: Label 'Total';
    TotalCaption_Control127Lbl: Label 'Total';
    TotalCaption_Control26Lbl: Label 'Total';
    ContinuedCaption_Control103Lbl: Label 'Continued';
    No_SerieCaptionLbl: Label 'No.Serie';
    TotalCaption_Control96Lbl: Label 'Total';
    No_SerieCaption_Control97Lbl: Label 'No.Serie';
    ContinuedCaption_Control119Lbl: Label 'Continued';
    TotalCaption_Control21Lbl: Label 'Total';
    TempVATEntry: Record 254 temporary;
    VendorNoCaptionLbl: Label 'Nº proveedor';
    OnlyIncludeSIIDocuments: Boolean;
}
