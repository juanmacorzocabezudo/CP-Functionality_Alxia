tableextension 50008 AlxiPurchRcptHeader extends "Purch. Rcpt. Header"
{
    fields
    {
        field(50000; ImporteBaseIVA; Decimal)
        {
            CalcFormula = Sum("Purch. Rcpt. Line"."VAT Base Amount" WHERE("Document No."=FIELD("No.")));
            Caption = 'Importe Base IVA';
            Description = 'ADV001';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50001; PersonaRecibe; Text[50])
        {
            Caption = 'Persona que recibe';
            Description = 'ADV001';
        }
    }
}
