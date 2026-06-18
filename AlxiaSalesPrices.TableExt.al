tableextension 50024 AlxiaSalesPrices extends "Sales Price"
#pragma warning restore AL0432
{
    fields
    {
        field(50000; NombreCliente; Text[250])
        {
            Caption = 'NombreCliente';
            FieldClass = FlowField;
            CalcFormula = lookup(Customer.Name where("No."=field("Sales Code")));
        }
    }
}
