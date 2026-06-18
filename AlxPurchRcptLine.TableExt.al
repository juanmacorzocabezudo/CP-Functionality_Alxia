tableextension 50038 AlxPurchRcptLine extends "Purch. Rcpt. Line"
{
    fields
    {
        field(50000; "Numero Albaran Proveedor"; Code[35])
        {
            CalcFormula = Lookup("Purch. Rcpt. Header"."Vendor Shipment No." WHERE("No."=FIELD("Document No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50002; TemperaturaRecepcion; Decimal)
        {
            Caption = 'Temperatura recepción';
            Description = 'ADV002';
        }
        field(50003; AspectoCorrecto; Option)
        {
            Caption = 'Aspecto correcto';
            Description = 'ADV002';
            OptionMembers = " ", "Sí", No;
        }
        field(50004; HigieneTranspCorrecta; Option)
        {
            Caption = 'Higiene transp. correcta';
            Description = 'ADV002';
            OptionMembers = " ", "Sí", No;
        }
        field(50005; Observaciones; Text[100])
        {
            Description = 'ADV002';
        }
        field(50006; AGRALALastDirectCost; Decimal)
        {
            Caption = 'Last Direct Cost';
        }
        field(50007; AGRADALineAmount; Decimal)
        {
            Caption = 'Line Amount';
        }
        field(50008; AGRALADirectUnitCost; Decimal)
        {
            Caption = 'Direct Unit Cost';
        }
    }
}
