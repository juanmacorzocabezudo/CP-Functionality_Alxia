tableextension 50032 AlxPaymentMethod extends "Payment Method"
{
    fields
    {
        /* field(50000; BancoImpresionVentasNew; Option)
        {
            Caption = 'Bank in sales print';
            Description = 'ADV001';
            OptionCaption = ' ,Empresa,Cliente';
            OptionMembers = " ",Empresa,Cliente;
        } */
        field(50001; BancoImpresionVentasMigr; Option)
        {
            Caption = 'Bank in sales print';
            Description = 'ADV001';
            OptionCaption = ' ,Empresa,Cliente';
            OptionMembers = " ", Empresa, Cliente;
        }
    }
}
