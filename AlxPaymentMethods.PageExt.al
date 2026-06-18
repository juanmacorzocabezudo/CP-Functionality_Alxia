pageextension 50026 AlxPaymentMethods extends "Payment Methods"
{
    layout
    {
        addlast(Control1)
        {
            field(BancoImpresionVentas; Rec.BancoImpresionVentasMigr)
            {
                Caption = 'Banco impresión venta';
                ApplicationArea = All;
            }
        }
    }
}
