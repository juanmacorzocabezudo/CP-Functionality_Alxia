codeunit 50007 AGRALAChargeDataDeliveryNote
{
    Permissions = TableData 113=rimd;

    trigger OnRun()
    begin
    //Procedimiento encargado de mapear todos los datos desde pedidos y facturas a albaranes de compra y venta
    end;
    procedure ChargeDataDeliveryNote()
    var
        SalesDeliveryNote: Record 111;
        SalesInvoiceLine: Record 113;
        SalesLine: Record 37;
        SalesInvoiceHeader: Record 112;
        Product: Record 27;
        SalesHeader: Record 36;
        PurchDeliveryNote: Record 121;
        PurchOrderHeader: Record 38;
        PurchaseOrderLines: Record 39;
        PurchInvHeader: Record 122;
        PurchInvLine: Record 123;
    begin
        //Albaranes de venta
        SalesDeliveryNote.RESET();
        IF SalesDeliveryNote.FINDSET()THEN REPEAT SalesInvoiceHeader.RESET();
                SalesInvoiceHeader.SETRANGE(SalesInvoiceHeader."Order No.", SalesDeliveryNote."Order No.");
                IF SalesInvoiceHeader.FINDFIRST()THEN BEGIN
                    SalesInvoiceLine.RESET();
                    SalesInvoiceLine.SETRANGE(SalesInvoiceLine."Document No.", SalesInvoiceHeader."No.");
                    SalesInvoiceLine.SETRANGE(SalesInvoiceLine."No.", SalesDeliveryNote."No.");
                    IF SalesInvoiceLine.FINDFIRST()THEN BEGIN
                        SalesInvoiceLine.SETRANGE(SalesInvoiceLine."No.", SalesDeliveryNote."No.");
                        SalesDeliveryNote.AGRADALineAmount:=SalesInvoiceLine."Line Amount";
                        SalesDeliveryNote.AGRALADirectUnitCost:=SalesInvoiceLine."Unit Price";
                        Product.RESET();
                        Product.SETRANGE(Product."No.", SalesDeliveryNote."No.");
                        IF Product.FINDFIRST()THEN BEGIN
                            SalesDeliveryNote.AGRALALastDirectCost:=Product."Last Direct Cost";
                        END;
                        SalesDeliveryNote.MODIFY();
                    END;
                END
                ELSE
                BEGIN
                    SalesHeader.RESET();
                    SalesHeader.SETRANGE(SalesHeader."No.", SalesDeliveryNote."Order No.");
                    IF SalesHeader.FINDFIRST()THEN BEGIN
                        SalesLine.RESET();
                        SalesLine.SETRANGE(SalesLine."Document No.", SalesHeader."No.");
                        SalesLine.SETRANGE(SalesLine."No.", SalesDeliveryNote."No.");
                        IF SalesLine.FINDFIRST()THEN BEGIN
                            SalesDeliveryNote.AGRADALineAmount:=SalesLine."Line Amount";
                            SalesDeliveryNote.AGRALADirectUnitCost:=SalesLine."Unit Price";
                            Product.RESET();
                            Product.SETRANGE(Product."No.", SalesDeliveryNote."No.");
                            IF Product.FINDFIRST()THEN BEGIN
                                SalesDeliveryNote.AGRALALastDirectCost:=Product."Last Direct Cost";
                            END;
                            SalesDeliveryNote.MODIFY();
                        END;
                    END;
                END;
            UNTIL SalesDeliveryNote.NEXT = 0;
        //Albaranes de compra
        PurchDeliveryNote.RESET();
        IF PurchDeliveryNote.FINDSET()THEN REPEAT PurchOrderHeader.RESET();
                PurchOrderHeader.SETRANGE(PurchOrderHeader."No.", PurchDeliveryNote."Order No.");
                IF PurchOrderHeader.FINDFIRST()THEN BEGIN
                    PurchaseOrderLines.RESET();
                    PurchaseOrderLines.SETRANGE(PurchaseOrderLines."Document No.", PurchOrderHeader."No.");
                    PurchaseOrderLines.SETRANGE(PurchaseOrderLines."Line No.", PurchDeliveryNote."Line No.");
                    IF PurchaseOrderLines.FINDFIRST()THEN BEGIN
                        PurchDeliveryNote.AGRADALineAmount:=PurchaseOrderLines."Line Amount";
                        PurchDeliveryNote.AGRALADirectUnitCost:=PurchaseOrderLines."Unit Cost";
                        PurchDeliveryNote."Variant Code":=PurchaseOrderLines."Variant Code";
                        Product.RESET();
                        Product.SETRANGE(Product."No.", PurchDeliveryNote."No.");
                        IF Product.FINDFIRST()THEN BEGIN
                            PurchDeliveryNote.AGRALALastDirectCost:=Product."Last Direct Cost";
                        END;
                        PurchDeliveryNote.MODIFY();
                    END;
                END
                ELSE
                BEGIN
                    PurchInvHeader.RESET();
                    PurchInvHeader.SETRANGE(PurchInvHeader."Order No.", PurchDeliveryNote."Order No.");
                    IF PurchInvHeader.FINDFIRST()THEN BEGIN
                        PurchInvLine.RESET();
                        PurchInvLine.SETRANGE(PurchInvLine."Document No.", PurchInvHeader."No.");
                        PurchInvLine.SETRANGE(PurchInvLine."Line No.", PurchDeliveryNote."Line No.");
                        IF PurchInvLine.FINDFIRST()THEN BEGIN
                            PurchDeliveryNote.AGRADALineAmount:=PurchInvLine."Line Amount";
                            PurchDeliveryNote.AGRALADirectUnitCost:=PurchInvLine."Unit Cost";
                            PurchDeliveryNote."Variant Code":=PurchInvLine."Variant Code";
                            Product.RESET();
                            Product.SETRANGE(Product."No.", PurchDeliveryNote."No.");
                            IF Product.FINDFIRST()THEN BEGIN
                                PurchDeliveryNote.AGRALALastDirectCost:=Product."Last Direct Cost";
                            END;
                            PurchDeliveryNote.MODIFY();
                        END;
                    END;
                END;
            UNTIL PurchDeliveryNote.NEXT = 0;
    //Método encargado de mapear el campo Líneas de negocio desde el cliente a la línea de fac venta registrada correspondiente
    end;
    procedure ChargeLineasNegocioVentas()
    var
        AGRALACustomer: Record 18;
        AGRALASalesInvoiceLine: Record 113;
    begin
    //AGRALASalesInvoiceLine.RESET();
    //IF AGRALASalesInvoiceLine.FINDSET()
    //THEN
    //REPEAT
    //AGRALACustomer.RESET();
    //AGRALACustomer.SETRANGE(AGRALACustomer."No.",AGRALASalesInvoiceLine."Bill-to Customer No.");
    //IF AGRALACustomer.FINDFIRST()
    //THEN
    //BEGIN
    //AGRALASalesInvoiceLine.AGRALALineasNegocio := AGRALACustomer."Líneas de Negocio";
    //AGRALASalesInvoiceLine.MODIFY();
    //END;
    //UNTIL AGRALASalesInvoiceLine.NEXT() = 0;
    end;
}
