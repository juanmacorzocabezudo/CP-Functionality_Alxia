page 50022 "Libro Facturas recibidas"
{
    // 
    // ADVANCE - Log de cambios
    // -----------------------------------------------------
    //   ADVANCE
    //   Fecha: 13-04-2016
    //   Técnico: JMAP
    //   Presupuesto: Proyecto I002433 - Modificación informes
    //   Modificación: Nueva page
    //   Etiqueta: ADV001
    // -----------------------------------------------------
    Editable = false;
    PageType = List;
    SourceTable = "G/L Entry";
    SourceTableView = WHERE("Document Type"=FILTER(Invoice|"Credit Memo"), "Gen. Posting Type"=CONST(Purchase));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field("G/L Account No."; Rec."G/L Account No.")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("VAT Amount"; Rec."VAT Amount")
                {
                    ApplicationArea = All;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Source Type"; Rec."Source Type")
                {
                    ApplicationArea = All;
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = All;
                }
                field(VendorName; VendorName)
                {
                    ApplicationArea = All;
                    Caption = 'Nombre';
                }
                field(VendorVATNo; VendorVATNo)
                {
                    ApplicationArea = All;
                    Caption = 'CIF/NIF';
                }
            }
        }
    }
    actions
    {
    }
    trigger OnAfterGetRecord()
    var
        Rcd_Vendor: Record Vendor;
    begin
        CLEAR(VendorName);
        CLEAR(VendorVATNo);
        IF Rec."Source Type" = Rec."Source Type"::Vendor THEN IF Rcd_Vendor.GET(Rec."Source No.")THEN BEGIN
                VendorName:=Rcd_Vendor.Name;
                VendorVATNo:=Rcd_Vendor."VAT Registration No.";
            END;
    end;
    var VendorVATNo: Text[20];
    VendorName: Text[50];
}
