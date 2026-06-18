tableextension 50001 AlxiCustLedgerEntry extends "Cust. Ledger Entry"
{
    fields
    {
        field(50000; "Nombre Cliente"; Text[100])
        {
            CalcFormula = Lookup(Customer.Name WHERE("No."=FIELD("Customer No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50001; EquipoVendedor; Code[10])
        {
            CalcFormula = Min("Team Salesperson"."Team Code" WHERE("Salesperson Code"=FIELD("Salesperson Code")));
            Description = 'ADV002';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50002; "Receipt Bank IBAN"; Code[50])
        {
            CalcFormula = Lookup("Customer Bank Account".IBAN WHERE("Customer No."=FIELD("Customer No."), Code=FIELD("Recipient Bank Account")));
            Caption = 'Receipt Bank IBAN';
            Description = 'ADV003';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50003; "Líneas de Negocio";Enum AlxiaLineasNegocio)
        {
            Caption = 'N/A';
            CalcFormula = Lookup(Customer."Líneas de Negocio" WHERE("No."=FIELD("Customer No.")));
            FieldClass = FlowField;
        }
        field(50004; emailCliente; Text[80])
        {
            CalcFormula = Lookup(Customer."E-Mail" WHERE("No."=FIELD("Customer No.")));
            FieldClass = FlowField;
        }
        field(50005; IBAN; Text[50])
        {
            Caption = 'IBAN';
            CalcFormula = Lookup("Customer Bank Account".IBAN WHERE("Customer No."=FIELD("Customer No.")));
            FieldClass = FlowField;
        }
    }
}
