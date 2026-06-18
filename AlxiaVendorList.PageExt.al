pageextension 50016 AlxiaVendorList extends "Vendor List"
{
    layout
    {
        addbefore("Responsibility Center")
        {
            field("VAT Registration No."; Rec."VAT Registration No.")
            {
                ApplicationArea = All;
                Visible = true;
            }
        }
        addafter("Payments (LCY)")
        {
            field(LastPaymentDate; LastPaymentDate)
            {
                AccessByPermission = TableData "Vendor Ledger Entry"=R;
                ApplicationArea = All;
                Caption = 'Fecha último pago';

                //ToolTip = 'Specifies the posting date of the last payment paid to the vendor.';
                trigger OnDrillDown()
                var
                    VendorLedgerEntry: Record "Vendor Ledger Entry";
                    VendorLedgerEntries: Page "Vendor Ledger Entries";
                begin
                    Clear(VendorLedgerEntries);
                    SetFilterLastPaymentDateEntry(VendorLedgerEntry);
                    if VendorLedgerEntry.FindLast()then begin
                        VendorLedgerEntries.SetRecord(VendorLedgerEntry);
                        VendorLedgerEntries.SetTableView(VendorLedgerEntry);
                        VendorLedgerEntries.Run();
                    end;
                end;
            }
            field(LastInvoiceDate; LastInvoiceDate)
            {
                AccessByPermission = TableData "Vendor Ledger Entry"=R;
                ApplicationArea = All;
                Caption = 'Fecha última compra';
                Editable = false;

                trigger OnDrillDown()
                var
                    VendorLedgerEntry: Record "Vendor Ledger Entry";
                    VendorLedgerEntries: Page "Vendor Ledger Entries";
                begin
                    Clear(VendorLedgerEntries);
                    SetFilterLastInvoiceDateEntry(VendorLedgerEntry);
                    if VendorLedgerEntry.FindLast()then begin
                        VendorLedgerEntries.SetRecord(VendorLedgerEntry);
                        VendorLedgerEntries.SetTableView(VendorLedgerEntry);
                        VendorLedgerEntries.Run();
                    end;
                end;
            }
        }
    }
    actions
    {
        /*  modify("Co&mments")
         {
             Caption = 'Certificados';
             Promoted = true;
             PromotedCategory = Process;
             PromotedIsBig = true;
         } */
        addafter("Ven&dor")
        {
            group(Info)
            {
                action(AGRALAInfoProveedor)
                {
                    ApplicationArea = All;
                    Caption = 'Info proveedores';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = VendorBill;
                    RunObject = Page 50077;
                }
                action(Cert)
                {
                    ApplicationArea = All;
                    Caption = 'Certificados';
                    Image = ContactReference;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name"=const(Vendor), "No."=field("No.");
                }
            }
        }
    }
    local procedure SetFilterLastPaymentDateEntry(var VendorLedgerEntry: Record "Vendor Ledger Entry")
    begin
        VendorLedgerEntry.SetCurrentKey("Document Type", "Vendor No.", "Posting Date", "Currency Code");
        VendorLedgerEntry.SetRange("Vendor No.", Rec."No.");
        VendorLedgerEntry.SetRange("Document Type", VendorLedgerEntry."Document Type"::Payment);
        VendorLedgerEntry.SetRange(Reversed, false);
    end;
    local procedure SetFilterLastInvoiceDateEntry(var VendorLedgerEntry: Record "Vendor Ledger Entry")
    begin
        VendorLedgerEntry.SetCurrentKey("Document Type", "Vendor No.", "Posting Date", "Currency Code");
        VendorLedgerEntry.SetRange("Vendor No.", Rec."No.");
        VendorLedgerEntry.SetRange("Document Type", VendorLedgerEntry."Document Type"::Invoice);
        VendorLedgerEntry.SetRange(Reversed, false);
    end;
    local procedure SetLastInvoice()
    var
        VendorLedgerEntry: Record "Vendor Ledger Entry";
    begin
        Clear(LastInvoiceDate);
        VendorLedgerEntry.SetCurrentKey("Document Type", "Vendor No.", "Posting Date", "Currency Code");
        VendorLedgerEntry.SetRange("Vendor No.", Rec."No.");
        VendorLedgerEntry.SetRange("Document Type", VendorLedgerEntry."Document Type"::Invoice);
        VendorLedgerEntry.SetRange(Reversed, false);
        if VendorLedgerEntry.FindLast()then LastInvoiceDate:=VendorLedgerEntry."Posting Date";
    end;
    local procedure SetLastPayment()
    var
        VendorLedgerEntry: Record "Vendor Ledger Entry";
    begin
        Clear(LastPaymentDate);
        VendorLedgerEntry.SetCurrentKey("Document Type", "Vendor No.", "Posting Date", "Currency Code");
        VendorLedgerEntry.SetRange("Vendor No.", Rec."No.");
        VendorLedgerEntry.SetRange("Document Type", VendorLedgerEntry."Document Type"::Payment);
        VendorLedgerEntry.SetRange(Reversed, false);
        if VendorLedgerEntry.FindLast()then LastPaymentDate:=VendorLedgerEntry."Posting Date";
    end;
    trigger OnAfterGetRecord()
    begin
        SetLastInvoice();
        SetLastPayment end;
    var LastPaymentDate: Date;
    LastInvoiceDate: Date;
}
