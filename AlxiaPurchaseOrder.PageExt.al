pageextension 50021 AlxiaPurchaseOrder extends "Purchase Order"
{
    layout
    {
        addafter("Posting Description")
        {
            field(PersonaRecibe; Rec.PersonaRecibe)
            {
                ApplicationArea = All;
                ShowMandatory = true;
            }
        }
    }
    trigger OnDeleteRecord(): Boolean var
        Confirmed: Boolean;
    begin
        //AGRALAMO - Mensaje de confirmación borrado pedidos lanzados
        IF Rec.Status = Rec.Status::Released THEN BEGIN
            Confirmed:=CONFIRM('¿Deseas eliminar el pedido de compra lanzado?');
            IF NOT Confirmed THEN BEGIN
                MESSAGE('El pedido de compra no ha sido eliminado.');
                EXIT(FALSE);
            END;
        END;
    //AGRALAMO - Mensaje de confirmación borrado pedidos lanzados
    end;
}
