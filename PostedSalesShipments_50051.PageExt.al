pageextension 50051 PostedSalesShipments_50051 extends "Posted Sales Shipments"
{
    // GAP00041 >>>
    trigger OnAfterGetRecord()
    begin
        // Se define un proceso para alimentar todas las líneas de albaranes históricos.
        Commit();
        Funciones.ActualizarLineasDeAlbaranDeVenta(Rec."No.");
    end;
    // GAP00041 <<<
    var Funciones: Codeunit FuncionesVarias;
}
