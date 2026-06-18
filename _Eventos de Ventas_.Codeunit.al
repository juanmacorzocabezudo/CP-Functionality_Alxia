codeunit 50014 "Eventos de Ventas"
{
    Permissions = tabledata "Sales Invoice Header"=rimd;

    trigger OnRun()
    begin
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeInsertInvoiceHeader', '', false, false)]
    local procedure C80_OnBeforeInsertInvoiceHeader(var SalesInvHeader: Record "Sales Invoice Header"; SalesHeader: Record "Sales Header")
    begin
        SalesInvHeader."Tipo de Impresión":=SalesHeader."Tipo de Impresión";
        SalesInvHeader."No Impresion Comentarios":=SalesHeader."No Impresion Comentarios";
    //SL Fix, da error porque no tiene numero de factura, el modify se hace en el OnAfter
    //SalesInvHeader.Modify();
    end;
    var myInt: Integer;
}
