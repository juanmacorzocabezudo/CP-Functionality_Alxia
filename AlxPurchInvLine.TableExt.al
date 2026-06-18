tableextension 50036 AlxPurchInvLine extends "Purch. Inv. Line"
{
    fields
    {
        field(50001; AGRALALineasNegocio; Option)
        {
            Caption = '<Líneas de negocio>';
            OptionCaption = ' ,Alimentación,Catering,Ambos';
            OptionMembers = " ", "Alimentación", Catering, Ambos;
        }
    }
}
