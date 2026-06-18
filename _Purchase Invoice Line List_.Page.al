page 50041 "Purchase Invoice Line List"
{
    Caption = 'Lineas Facturas Compras Registradas';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 123;
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                }
                field("Buy-from Vendor Name"; PurchInvHeader."Buy-from Vendor Name")
                {
                    Caption = 'Nombre Proveedor';
                }
                field("Document No."; Rec."Document No.")
                {
                }
                field("Line No."; Rec."Line No.")
                {
                }
                field(Type; Rec.Type)
                {
                }
                field("No."; Rec."No.")
                {
                }
                field("Location Code"; Rec."Location Code")
                {
                }
                field("Posting Group"; Rec."Posting Group")
                {
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Description 2"; Rec."Description 2")
                {
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                }
                field("VAT %"; Rec."VAT %")
                {
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                }
                field("Unit Price (LCY)"; Rec."Unit Price (LCY)")
                {
                }
                field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
                {
                }
                field("Gross Weight"; Rec."Gross Weight")
                {
                }
                field("Net Weight"; Rec."Net Weight")
                {
                }
                field("Units per Parcel"; Rec."Units per Parcel")
                {
                }
                field("Unit Volume"; Rec."Unit Volume")
                {
                }
                field("Appl.-to Item Entry"; Rec."Appl.-to Item Entry")
                {
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                }
                field("Job No."; Rec."Job No.")
                {
                }
                field("Indirect Cost %"; Rec."Indirect Cost %")
                {
                }
                field("Receipt No."; Rec."Receipt No.")
                {
                }
                field("Receipt Line No."; Rec."Receipt Line No.")
                {
                }
                field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                {
                }
                field("Inv. Discount Amount"; Rec."Inv. Discount Amount")
                {
                }
                field("Vendor Item No."; Rec."Vendor Item No.")
                {
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                }
                field("VAT Calculation Type"; Rec."VAT Calculation Type")
                {
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                }
                field("Transport Method"; Rec."Transport Method")
                {
                }
                field("Attached to Line No."; Rec."Attached to Line No.")
                {
                }
                field("Entry Point"; Rec."Entry Point")
                {
                }
                field(Areaa; Rec.Area)
                {
                }
                field("Transaction Specification"; Rec."Transaction Specification")
                {
                }
                field("Tax Area Code"; Rec."Tax Area Code")
                {
                }
                field("Tax Liable"; Rec."Tax Liable")
                {
                }
                field("Tax Group Code"; Rec."Tax Group Code")
                {
                }
                field("Use Tax"; Rec."Use Tax")
                {
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                }
                field("Blanket Order No."; Rec."Blanket Order No.")
                {
                }
                field("Blanket Order Line No."; Rec."Blanket Order Line No.")
                {
                }
                field("VAT Base Amount"; Rec."VAT Base Amount")
                {
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                }
                field("System-Created Entry"; Rec."System-Created Entry")
                {
                }
                field("Line Amount"; Rec."Line Amount")
                {
                }
                field("VAT Difference"; Rec."VAT Difference")
                {
                }
                field("VAT Identifier"; Rec."VAT Identifier")
                {
                }
                field("IC Partner Ref. Type"; Rec."IC Partner Ref. Type")
                {
                }
                field("IC Partner Reference"; Rec."IC Partner Reference")
                {
                }
                field("Prepayment Line"; Rec."Prepayment Line")
                {
                }
                field("IC Partner Code"; Rec."IC Partner Code")
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                }
                field("Job Task No."; Rec."Job Task No.")
                {
                }
                field("Job Line Type"; Rec."Job Line Type")
                {
                }
                field("Job Unit Price"; Rec."Job Unit Price")
                {
                }
                field("Job Total Price"; Rec."Job Total Price")
                {
                }
                field("Job Line Amount"; Rec."Job Line Amount")
                {
                }
                field("Job Line Discount Amount"; Rec."Job Line Discount Amount")
                {
                }
                field("Job Line Discount %"; Rec."Job Line Discount %")
                {
                }
                field("Job Unit Price (LCY)"; Rec."Job Unit Price (LCY)")
                {
                }
                field("Job Total Price (LCY)"; Rec."Job Total Price (LCY)")
                {
                }
                field("Job Line Amount (LCY)"; Rec."Job Line Amount (LCY)")
                {
                }
                field("Job Line Disc. Amount (LCY)"; Rec."Job Line Disc. Amount (LCY)")
                {
                }
                field("Job Currency Factor"; Rec."Job Currency Factor")
                {
                }
                field("Job Currency Code"; Rec."Job Currency Code")
                {
                }
                field("Deferral Code"; Rec."Deferral Code")
                {
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                }
                field("Variant Code"; Rec."Variant Code")
                {
                }
                field("Bin Code"; Rec."Bin Code")
                {
                }
                field("Qty. per Unit of Measure"; Rec."Qty. per Unit of Measure")
                {
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                }
                field("Quantity (Base)"; Rec."Quantity (Base)")
                {
                }
                field("FA Posting Date"; Rec."FA Posting Date")
                {
                }
                field("FA Posting Type"; Rec."FA Posting Type")
                {
                }
                field("Depreciation Book Code"; Rec."Depreciation Book Code")
                {
                }
                field("Salvage Value"; Rec."Salvage Value")
                {
                }
                field("Depr. until FA Posting Date"; Rec."Depr. until FA Posting Date")
                {
                }
                field("Depr. Acquisition Cost"; Rec."Depr. Acquisition Cost")
                {
                }
                field("Maintenance Code"; Rec."Maintenance Code")
                {
                }
                field("Insurance No."; Rec."Insurance No.")
                {
                }
                field("Budgeted FA No."; Rec."Budgeted FA No.")
                {
                }
                field("Duplicate in Depreciation Book"; Rec."Duplicate in Depreciation Book")
                {
                }
                field("Use Duplication List"; Rec."Use Duplication List")
                {
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                }
                field("Cross-Reference No."; Rec."Item Reference No.")
                {
                }
                /*    field("Unit of Measure (Cross Ref.)"; "Unit of Measure (Cross Ref.)")
                   {
                   }
                   field("Cross-Reference Type"; "Cross-Reference Type")
                   {
                   }
                   field("Cross-Reference Type No."; "Cross-Reference Type No.")
                   {
                   } */
                field("Item Category Code"; Rec."Item Category Code")
                {
                }
                field(Nonstock; Rec.Nonstock)
                {
                }
                field("Purchasing Code"; Rec."Purchasing Code")
                {
                }
                field("Product Group Code"; Rec."Item Category Code")
                {
                }
                field("Return Reason Code"; Rec."Return Reason Code")
                {
                }
                field("Pmt. Disc. Rcd. Amount"; Rec."Pmt. Discount Amount")
                {
                }
                field("EC %"; Rec."EC %")
                {
                }
                field("EC Difference"; Rec."EC Difference")
                {
                }
                field("Routing No."; Rec."Routing No.")
                {
                }
                field("Operation No."; Rec."Operation No.")
                {
                }
                field("Work Center No."; Rec."Work Center No.")
                {
                }
                field("Prod. Order Line No."; Rec."Prod. Order Line No.")
                {
                }
                field("Overhead Rate"; Rec."Overhead Rate")
                {
                }
                field("Routing Reference No."; Rec."Routing Reference No.")
                {
                }
                /*   field(AGRALALineasNegocio; Rec.AGRALALineasNegocio)
                  {
                      Caption = '<Líneas de negocio>';
                  } */
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Caption = 'Línea de negocio';
                }
            }
        }
    }
    actions
    {
        area(navigation)
        {
            action("&Navigate")
            {
                ApplicationArea = All;
                Caption = '&Navegar';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;
                Scope = Repeater;

                trigger OnAction()
                var
                    Navigate: Page 344;
                begin
                    Navigate.SetDoc(Rec."Posting Date", Rec."Document No.");
                    Navigate.RUN;
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        IF PurchInvHeader."No." <> Rec."Document No." THEN PurchInvHeader.GET(Rec."Document No.");
    end;
    var PurchInvHeader: Record 122;
}
