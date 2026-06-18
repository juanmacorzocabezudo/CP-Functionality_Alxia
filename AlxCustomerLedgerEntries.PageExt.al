pageextension 50038 AlxCustomerLedgerEntries extends "Customer Ledger Entries"
{
    layout
    {
        modify("Global Dimension 1 Code")
        {
            Visible = true;
        }
        modify("Global Dimension 2 Code")
        {
            Visible = false;
        }
        /*  addafter("Document No.")
         {
             field("Líneas de Negocio"; Rec."Líneas de Negocio")
             {
                 ApplicationArea = All;
                 Editable = false;
                 Visible = false;
             }
         } */
        addafter(Description)
        {
            field("Alias"; _Alias)
            {
                ApplicationArea = All;
                Caption = 'Alias cliente';
                ToolTip = 'Alias del cliente';
            }
        }
        addafter("Payment Method Code")
        {
            field("Payment Terms Code"; Rec."Payment Terms Code")
            {
                ApplicationArea = All;
            }
            field(emailCliente; Rec.emailCliente)
            {
                ApplicationArea = All;
                Caption = 'Email Cliente';
            }
            field(IBAN; Rec.IBAN)
            {
                ApplicationArea = All;
            }
        }
    }
    var _Alias: Code[100];
    trigger OnAfterGetRecord()
    var
        recCust: Record customer;
    begin
        Clear(_Alias);
        if Rec."Global Dimension 1 Code" = '' then begin
            recCust.Reset();
            recCust.SetRange("No.", Rec."Customer No.");
            if recCust.FindFirst()then if recCust."Global Dimension 1 Code" <> '' then Rec."Global Dimension 1 Code":=recCust."Global Dimension 1 Code";
        end;
        recCust.Reset();
        recCust.SetRange("No.", Rec."Customer No.");
        if recCust.FindFirst()then begin
            _Alias:=recCust."Search Name";
        end;
    end;
}
