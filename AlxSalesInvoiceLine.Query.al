query 50000 AlxSalesInvoiceLine
{
    Caption = 'AlxSalesInvoiceLine';
    QueryType = Normal;

    //OrderBy = descending(PostingDate);
    elements
    {
        dataitem(SalesInvoiceLine;
            "Sales Invoice Line")
        {
            column(SelltoCustomerNo;
                "Sell-to Customer No.")
            {
            }
            column(DocumentNo;
                "Document No.")
            {
            }
            column(LineNo;
                "Line No.")
            {
            }
            column("Type";
                "Type")
            {
            }
            column(No;
                "No.")
            {
            }
            column(LocationCode;
                "Location Code")
            {
            }
            column(PostingGroup;
                "Posting Group")
            {
            }
            column(ShipmentDate;
                "Shipment Date")
            {
            }
            column(Description;
                Description)
            {
            }
            column(Description2;
                "Description 2")
            {
            }
            column(UnitofMeasure;
                "Unit of Measure")
            {
            }
            column(Quantity;
                Quantity)
            {
            }
            column(UnitPrice;
                "Unit Price")
            {
            }
            column(UnitCostLCY;
                "Unit Cost (LCY)")
            {
            }
            column(VAT;
                "VAT %")
            {
            }
            column(LineDiscount;
                "Line Discount %")
            {
            }
            column(LineDiscountAmount;
                "Line Discount Amount")
            {
            }
            column(Amount;
                Amount)
            {
            }
            column(AmountIncludingVAT;
                "Amount Including VAT")
            {
            }
            column(AllowInvoiceDisc;
                "Allow Invoice Disc.")
            {
            }
            column(GrossWeight;
                "Gross Weight")
            {
            }
            column(NetWeight;
                "Net Weight")
            {
            }
            column(UnitsperParcel;
                "Units per Parcel")
            {
            }
            column(UnitVolume;
                "Unit Volume")
            {
            }
            column(AppltoItemEntry;
                "Appl.-to Item Entry")
            {
            }
            column(ShortcutDimension1Code;
                "Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code;
                "Shortcut Dimension 2 Code")
            {
            }
            column(CustomerPriceGroup;
                "Customer Price Group")
            {
            }
            column(JobNo;
                "Job No.")
            {
            }
            column(WorkTypeCode;
                "Work Type Code")
            {
            }
            column(ShipmentNo;
                "Shipment No.")
            {
            }
            column(ShipmentLineNo;
                "Shipment Line No.")
            {
            }
            column(OrderNo;
                "Order No.")
            {
            }
            column(OrderLineNo;
                "Order Line No.")
            {
            }
            column(BilltoCustomerNo;
                "Bill-to Customer No.")
            {
            }
            column(InvDiscountAmount;
                "Inv. Discount Amount")
            {
            }
            column(DropShipment;
                "Drop Shipment")
            {
            }
            column(GenBusPostingGroup;
                "Gen. Bus. Posting Group")
            {
            }
            column(GenProdPostingGroup;
                "Gen. Prod. Posting Group")
            {
            }
            column(VATCalculationType;
                "VAT Calculation Type")
            {
            }
            column("TransactionType";
                "Transaction Type")
            {
            }
            column(TransportMethod;
                "Transport Method")
            {
            }
            column(AttachedtoLineNo;
                "Attached to Line No.")
            {
            }
            column(ExitPoint;
                "Exit Point")
            {
            }
            column("Area";
                "Area")
            {
            }
            column(TransactionSpecification;
                "Transaction Specification")
            {
            }
            column(TaxCategory;
                "Tax Category")
            {
            }
            column(TaxAreaCode;
                "Tax Area Code")
            {
            }
            column(TaxLiable;
                "Tax Liable")
            {
            }
            column(TaxGroupCode;
                "Tax Group Code")
            {
            }
            column(VATClauseCode;
                "VAT Clause Code")
            {
            }
            column(VATBusPostingGroup;
                "VAT Bus. Posting Group")
            {
            }
            column(VATProdPostingGroup;
                "VAT Prod. Posting Group")
            {
            }
            column(BlanketOrderNo;
                "Blanket Order No.")
            {
            }
            column(BlanketOrderLineNo;
                "Blanket Order Line No.")
            {
            }
            column(VATBaseAmount;
                "VAT Base Amount")
            {
            }
            column(UnitCost;
                "Unit Cost")
            {
            }
            column(SystemCreatedEntry;
                "System-Created Entry")
            {
            }
            column(LineAmount;
                "Line Amount")
            {
            }
            column(VATDifference;
                "VAT Difference")
            {
            }
            column(VATIdentifier;
                "VAT Identifier")
            {
            }
            column(ICPartnerRefType;
                "IC Partner Ref. Type")
            {
            }
            column(ICPartnerReference;
                "IC Partner Reference")
            {
            }
            column(PrepaymentLine;
                "Prepayment Line")
            {
            }
            column(ICPartnerCode;
                "IC Partner Code")
            {
            }
            column(PostingDate;
                "Posting Date")
            {
            }
            column(ICItemReferenceNo;
                "IC Item Reference No.")
            {
            }
            column(PmtDiscountAmount;
                "Pmt. Discount Amount")
            {
            }
            column(LineDiscountCalculation;
                "Line Discount Calculation")
            {
            }
            column(DimensionSetID;
                "Dimension Set ID")
            {
            }
            column(JobTaskNo;
                "Job Task No.")
            {
            }
            column(JobContractEntryNo;
                "Job Contract Entry No.")
            {
            }
            column(DeferralCode;
                "Deferral Code")
            {
            }
            column(AllocationAccountNo;
                "Allocation Account No.")
            {
            }
            column(VariantCode;
                "Variant Code")
            {
            }
            column(BinCode;
                "Bin Code")
            {
            }
            column(QtyperUnitofMeasure;
                "Qty. per Unit of Measure")
            {
            }
            column(UnitofMeasureCode;
                "Unit of Measure Code")
            {
            }
            column(QuantityBase;
                "Quantity (Base)")
            {
            }
            column(FAPostingDate;
                "FA Posting Date")
            {
            }
            column(DepreciationBookCode;
                "Depreciation Book Code")
            {
            }
            column(DepruntilFAPostingDate;
                "Depr. until FA Posting Date")
            {
            }
            column(DuplicateinDepreciationBook;
                "Duplicate in Depreciation Book")
            {
            }
            column(UseDuplicationList;
                "Use Duplication List")
            {
            }
            column(ResponsibilityCenter;
                "Responsibility Center")
            {
            }
            column(ItemCategoryCode;
                "Item Category Code")
            {
            }
            column(Nonstock;
                Nonstock)
            {
            }
            column(PurchasingCode;
                "Purchasing Code")
            {
            }
            column(ItemReferenceNo;
                "Item Reference No.")
            {
            }
            column(ItemReferenceUnitofMeasure;
                "Item Reference Unit of Measure")
            {
            }
            column(ItemReferenceType;
                "Item Reference Type")
            {
            }
            column(ItemReferenceTypeNo;
                "Item Reference Type No.")
            {
            }
            column(ApplfromItemEntry;
                "Appl.-from Item Entry")
            {
            }
            column(ReturnReasonCode;
                "Return Reason Code")
            {
            }
            column(PriceCalculationMethod;
                "Price Calculation Method")
            {
            }
            column(AllowLineDisc;
                "Allow Line Disc.")
            {
            }
            column(CustomerDiscGroup;
                "Customer Disc. Group")
            {
            }
            column(Pricedescription;
                "Price description")
            {
            }
            column(EC;
                "EC %")
            {
            }
            column(ECDifference;
                "EC Difference")
            {
            }
            column(SpecialSchemeCode;
                "Special Scheme Code")
            {
            }
            column(NoEvento;
                NoEvento)
            {
            }
            column(LineaEvento;
                LineaEvento)
            {
            }
            column(TablaEvento;
                "Tabla Evento")
            {
            }
            column(Imprime;
                Imprime)
            {
            }
            column(AGRALALastDirectCost;
                AGRALALastDirectCost)
            {
            }
            column(AGRALALineasNegocio;
                AGRALALineasNegocio)
            {
            }
            dataitem(SalesInvoiceHeader;
                "Sales Invoice Header")
            {
                DataItemLink = "No."=SalesInvoiceLine."Document No.";

                column(HSelltoCustomerNo;
                    "Sell-to Customer No.")
                {
                }
                column(HNo;
                    "No.")
                {
                }
                column(HBilltoCustomerNo;
                    "Bill-to Customer No.")
                {
                }
                column(HBilltoName;
                    "Bill-to Name")
                {
                }
                column(HBilltoName2;
                    "Bill-to Name 2")
                {
                }
                column(HBilltoAddress;
                    "Bill-to Address")
                {
                }
                column(HBilltoAddress2;
                    "Bill-to Address 2")
                {
                }
                column(HBilltoCity;
                    "Bill-to City")
                {
                }
                column(HBilltoContact;
                    "Bill-to Contact")
                {
                }
                column(HYourReference;
                    "Your Reference")
                {
                }
                column(HShiptoCode;
                    "Ship-to Code")
                {
                }
                column(HShiptoName;
                    "Ship-to Name")
                {
                }
                column(HShiptoName2;
                    "Ship-to Name 2")
                {
                }
                column(HShiptoAddress;
                    "Ship-to Address")
                {
                }
                column(HShiptoAddress2;
                    "Ship-to Address 2")
                {
                }
                column(HShiptoCity;
                    "Ship-to City")
                {
                }
                column(HShiptoContact;
                    "Ship-to Contact")
                {
                }
                column(OrderDate;
                    "Order Date")
                {
                }
                column(HPostingDate;
                    "Posting Date")
                {
                }
                column(HShipmentDate;
                    "Shipment Date")
                {
                }
                column(PostingDescription;
                    "Posting Description")
                {
                }
                column(PaymentTermsCode;
                    "Payment Terms Code")
                {
                }
                column(DueDate;
                    "Due Date")
                {
                }
                column(PaymentDiscount;
                    "Payment Discount %")
                {
                }
                column(PmtDiscountDate;
                    "Pmt. Discount Date")
                {
                }
                column(ShipmentMethodCode;
                    "Shipment Method Code")
                {
                }
                column(HLocationCode;
                    "Location Code")
                {
                }
                column(HShortcutDimension1Code;
                    "Shortcut Dimension 1 Code")
                {
                }
                column(HShortcutDimension2Code;
                    "Shortcut Dimension 2 Code")
                {
                }
                column(CustomerPostingGroup;
                    "Customer Posting Group")
                {
                }
                column(CurrencyCode;
                    "Currency Code")
                {
                }
                column(CurrencyFactor;
                    "Currency Factor")
                {
                }
                column(HCustomerPriceGroup;
                    "Customer Price Group")
                {
                }
                column(PricesIncludingVAT;
                    "Prices Including VAT")
                {
                }
                column(InvoiceDiscCode;
                    "Invoice Disc. Code")
                {
                }
                column(HCustomerDiscGroup;
                    "Customer Disc. Group")
                {
                }
                column(LanguageCode;
                    "Language Code")
                {
                }
                column(FormatRegion;
                    "Format Region")
                {
                }
                column(SalespersonCode;
                    "Salesperson Code")
                {
                }
                column(HOrderNo;
                    "Order No.")
                {
                }
                column(Comment;
                    Comment)
                {
                }
                column(NoPrinted;
                    "No. Printed")
                {
                }
                column(OnHold;
                    "On Hold")
                {
                }
                column(AppliestoDocType;
                    "Applies-to Doc. Type")
                {
                }
                column(AppliestoDocNo;
                    "Applies-to Doc. No.")
                {
                }
                column(BalAccountNo;
                    "Bal. Account No.")
                {
                }
                column(HAmount;
                    Amount)
                {
                }
                column(HAmountIncludingVAT;
                    "Amount Including VAT")
                {
                }
                column(VATRegistrationNo;
                    "VAT Registration No.")
                {
                }
                column(RegistrationNumber;
                    "Registration Number")
                {
                }
                column(ReasonCode;
                    "Reason Code")
                {
                }
                column(HGenBusPostingGroup;
                    "Gen. Bus. Posting Group")
                {
                }
                column(EU3PartyTrade;
                    "EU 3-Party Trade")
                {
                }
                column("HTransactionType";
                    "Transaction Type")
                {
                }
                column(HTransportMethod;
                    "Transport Method")
                {
                }
                column(VATCountryRegionCode;
                    "VAT Country/Region Code")
                {
                }
                column(SelltoCustomerName;
                    "Sell-to Customer Name")
                {
                }
                column(SelltoCustomerName2;
                    "Sell-to Customer Name 2")
                {
                }
                column(SelltoAddress;
                    "Sell-to Address")
                {
                }
                column(SelltoAddress2;
                    "Sell-to Address 2")
                {
                }
                column(SelltoCity;
                    "Sell-to City")
                {
                }
                column(SelltoContact;
                    "Sell-to Contact")
                {
                }
                column(BilltoPostCode;
                    "Bill-to Post Code")
                {
                }
                column(BilltoCounty;
                    "Bill-to County")
                {
                }
                column(BilltoCountryRegionCode;
                    "Bill-to Country/Region Code")
                {
                }
                column(SelltoPostCode;
                    "Sell-to Post Code")
                {
                }
                column(SelltoCounty;
                    "Sell-to County")
                {
                }
                column(SelltoCountryRegionCode;
                    "Sell-to Country/Region Code")
                {
                }
                column(ShiptoPostCode;
                    "Ship-to Post Code")
                {
                }
                column(ShiptoCounty;
                    "Ship-to County")
                {
                }
                column(ShiptoCountryRegionCode;
                    "Ship-to Country/Region Code")
                {
                }
                column(BalAccountType;
                    "Bal. Account Type")
                {
                }
                column(HExitPoint;
                    "Exit Point")
                {
                }
                column(Correction;
                    Correction)
                {
                }
                column(DocumentDate;
                    "Document Date")
                {
                }
                column(ExternalDocumentNo;
                    "External Document No.")
                {
                }
                column("HArea";
                    "Area")
                {
                }
                column(HTransactionSpecification;
                    "Transaction Specification")
                {
                }
                column(PaymentMethodCode;
                    "Payment Method Code")
                {
                }
                column(ShippingAgentCode;
                    "Shipping Agent Code")
                {
                }
                column(PackageTrackingNo;
                    "Package Tracking No.")
                {
                }
                column(PreAssignedNoSeries;
                    "Pre-Assigned No. Series")
                {
                }
                column(NoSeries;
                    "No. Series")
                {
                }
                column(OrderNoSeries;
                    "Order No. Series")
                {
                }
                column(PreAssignedNo;
                    "Pre-Assigned No.")
                {
                }
                column(UserID;
                    "User ID")
                {
                }
                column(SourceCode;
                    "Source Code")
                {
                }
                column(HTaxAreaCode;
                    "Tax Area Code")
                {
                }
                column(HTaxLiable;
                    "Tax Liable")
                {
                }
                column(HVATBusPostingGroup;
                    "VAT Bus. Posting Group")
                {
                }
                column(VATBaseDiscount;
                    "VAT Base Discount %")
                {
                }
                column(InvoiceDiscountCalculation;
                    "Invoice Discount Calculation")
                {
                }
                column(InvoiceDiscountValue;
                    "Invoice Discount Value")
                {
                }
                column(PrepaymentNoSeries;
                    "Prepayment No. Series")
                {
                }
                column(PrepaymentInvoice;
                    "Prepayment Invoice")
                {
                }
                column(PrepaymentOrderNo;
                    "Prepayment Order No.")
                {
                }
                column(QuoteNo;
                    "Quote No.")
                {
                }
                column(CompanyBankAccountCode;
                    "Company Bank Account Code")
                {
                }
                column(SelltoPhoneNo;
                    "Sell-to Phone No.")
                {
                }
                column(SelltoEMail;
                    "Sell-to E-Mail")
                {
                }
                column(VATReportingDate;
                    "VAT Reporting Date")
                {
                }
                column(PaymentReference;
                    "Payment Reference")
                {
                }
                column(WorkDescription;
                    "Work Description")
                {
                }
                column(HDimensionSetID;
                    "Dimension Set ID")
                {
                }
                column(PaymentServiceSetID;
                    "Payment Service Set ID")
                {
                }
                column(DocumentExchangeIdentifier;
                    "Document Exchange Identifier")
                {
                }
                column(DocumentExchangeStatus;
                    "Document Exchange Status")
                {
                }
                column(DocExchOriginalIdentifier;
                    "Doc. Exch. Original Identifier")
                {
                }
                column(CoupledtoDataverse;
                    "Coupled to Dataverse")
                {
                }
                column(DirectDebitMandateID;
                    "Direct Debit Mandate ID")
                {
                }
                column(Closed;
                    Closed)
                {
                }
                column(RemainingAmount;
                    "Remaining Amount")
                {
                }
                column(CustLedgerEntryNo;
                    "Cust. Ledger Entry No.")
                {
                }
                column(InvoiceDiscountAmount;
                    "Invoice Discount Amount")
                {
                }
                column(Cancelled;
                    Cancelled)
                {
                }
                column(Corrective;
                    Corrective)
                {
                }
                column(Reversed;
                    Reversed)
                {
                }
                column(DisputeStatus;
                    "Dispute Status")
                {
                }
                column(PromisedPayDate;
                    "Promised Pay Date")
                {
                }
                column(CampaignNo;
                    "Campaign No.")
                {
                }
                column(SelltoContactNo;
                    "Sell-to Contact No.")
                {
                }
                column(BilltoContactNo;
                    "Bill-to Contact No.")
                {
                }
                column(OpportunityNo;
                    "Opportunity No.")
                {
                }
                column(HResponsibilityCenter;
                    "Responsibility Center")
                {
                }
                column(HPriceCalculationMethod;
                    "Price Calculation Method")
                {
                }
                column(HAllowLineDisc;
                    "Allow Line Disc.")
                {
                }
                column(GetShipmentUsed;
                    "Get Shipment Used")
                {
                }
                column(DraftInvoiceSystemId;
                    "Draft Invoice SystemId")
                {
                }
                column(DisputeStatusId;
                    "Dispute Status Id")
                {
                }
                column(SIIStatus;
                    "SII Status")
                {
                }
                column(InvoiceType;
                    "Invoice Type")
                {
                }
                column(CrMemoType;
                    "Cr. Memo Type")
                {
                }
                column(HSpecialSchemeCode;
                    "Special Scheme Code")
                {
                }
                column(OperationDescription;
                    "Operation Description")
                {
                }
                column(OperationDescription2;
                    "Operation Description 2")
                {
                }
                column(SucceededCompanyName;
                    "Succeeded Company Name")
                {
                }
                column(SucceededVATRegistrationNo;
                    "Succeeded VAT Registration No.")
                {
                }
                column(IDType;
                    "ID Type")
                {
                }
                column(SenttoSII;
                    "Sent to SII")
                {
                }
                column(DoNotSendToSII;
                    "Do Not Send To SII")
                {
                }
                column(IssuedByThirdParty;
                    "Issued By Third Party")
                {
                }
                column(SIIFirstSummaryDocNo;
                    "SII First Summary Doc. No.")
                {
                }
                column(SIILastSummaryDocNo;
                    "SII Last Summary Doc. No.")
                {
                }
                column(CodBancoEmpresaMigr;
                    CodBancoEmpresaMigr)
                {
                }
                column(HNoEvento;
                    NoEvento)
                {
                }
                column(CustomerEMail;
                    "Customer E-Mail")
                {
                }
                column(Cobrado;
                    Cobrado)
                {
                }
                column(EquipoVendedor;
                    EquipoVendedor)
                {
                }
                column(WarantyLotDate;
                    "Waranty Lot Date")
                {
                }
                column(AppliestoBillNo;
                    "Applies-to Bill No.")
                {
                }
                column(CustBankAccCode;
                    "Cust. Bank Acc. Code")
                {
                }
                /* column(PayatCode; "Pay-at Code")
                {
                } */
                column(FechaServicio;
                    "Fecha Servicio")
                {
                }
                dataitem(Customer;
                    Customer)
                {
                    DataItemLink = "No."=SalesInvoiceHeader."Sell-to Customer No.";

                    column(Phone_No_;
                        "Phone No.")
                    {
                    }
                    column(E_Mail;
                        "E-Mail")
                    {
                    }
                    column(Contact;
                        Contact)
                    {
                    }
                    column(Search_Name;
                        "Search Name")
                    {
                    }
                    column(Credit_Limit__LCY_;
                        "Credit Limit (LCY)")
                    {
                    }
                    column(Last_Date_Modified;
                        "Last Date Modified")
                    {
                    }
                    column(Shipping_Agent_Code;
                        "Shipping Agent Code")
                    {
                    }
                    column(Shipping_Advice;
                        "Shipping Advice")
                    {
                    }
                    column(Blocked;
                        Blocked)
                    {
                    }
                    column(Shipping_Agent_Service_Code;
                        "Shipping Agent Service Code")
                    {
                    }
                }
            }
        }
    }
    trigger OnBeforeOpen()
    begin
        currQuery.SetFilter(type, '%1|%2|%3|%4|%5', Type::Item, Type::"G/L Account", Type::"Charge (Item)", Type::"Fixed Asset", Type::Resource);
    end;
}
