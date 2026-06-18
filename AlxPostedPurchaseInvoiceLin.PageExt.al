pageextension 50031 AlxPostedPurchaseInvoiceLin extends "Posted Purchase Invoice Lines"
{
    layout
    {
        addafter("Buy-from Vendor No.")
        {
            field(_NombreProv; _NombreProv)
            {
                ApplicationArea = All;
                Caption = 'Nombre Proveedor';
            }
        }
        addafter("No.")
        {
            field(_NombreCuenta; _NombreCuenta)
            {
                ApplicationArea = All;
                Caption = 'Nombre de la cuenta';
            }
        }
    }
    var _NombreCuenta: Text;
    _NombreProv: Text;
    trigger OnAfterGetRecord()
    var
        recGL: Record "G/L Account";
        recVendor: Record Vendor;
    begin
        Clear(_NombreCuenta);
        Clear(_NombreProv);
        if Rec.Type = Rec.Type::"G/L Account" then begin
            recGL.Reset();
            recGL.SetRange("No.", Rec."No.");
            if recGL.FindFirst()then _NombreCuenta:=recGL.Name end;
        if Rec."Buy-from Vendor No." <> '' then begin
            recVendor.Reset();
            recVendor.SetRange("No.", Rec."Buy-from Vendor No.");
            if recVendor.FindFirst()then _NombreProv:=recVendor.Name;
        end;
    end;
}
