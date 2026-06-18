tableextension 50037 AlxSalespersonPurchaser extends "Salesperson/Purchaser"
{
    fields
    {
        field(50007; "Líneas de Negocio";Enum AlxiaLineasNegocio)
        {
            Caption = 'Líneas de Negocio';
            DataClassification = CustomerContent;
        }
    }
}
