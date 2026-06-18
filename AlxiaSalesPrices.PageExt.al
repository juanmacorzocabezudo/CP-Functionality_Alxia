pageextension 50013 AlxiaSalesPrices extends "Sales Prices"
#pragma warning restore AL0432
{
    layout
    {
        /*  modify("Sales Code")
         {
             trigger OnBeforeValidate()
             var
                 recCustomer: Record Customer;
             begin
                 recCustomer.Reset();
                 recCustomer.SetRange("No.", rec."Sales Code");
                 if recCustomer.FindFirst() then
                     NombreCliente := recCustomer.Name;
             end;
         } */
        addafter("Sales Code")
        {
            field(NombreCliente; Rec.NombreCliente)
            {
                ApplicationArea = All;
                Caption = 'Nombre Cliente';
                Editable = false;
            }
        }
    }
    var NombreCliente: Text[250];
}
