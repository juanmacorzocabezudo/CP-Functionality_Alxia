page 50103 AlxConsultaLineasFacturas
{
    ApplicationArea = All;
    Caption = 'AlxConsultaLineasFacturas';
    PageType = List;
    SourceTable = "Sales Invoice Line";
    UsageCategory = Lists;
    SourceTableView = order(ascending)where(Type=const(Item));

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                ShowCaption = false;

                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the document number.';
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the line number.';
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field(NombreCliente; Rec.NombreCliente)
                {
                    ApplicationArea = All;
                }
                field("TelefonoCliente"; Rec."TelefonoCliente")
                {
                    ApplicationArea = All;
                }
                field("EmailCliente"; Rec."EmailCliente")
                {
                    ApplicationArea = All;
                }
                field("ContactoCliente"; Rec."ContactoCliente")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of entity that will be posted for this sales line, such as Item, Resource, or G/L Account.';
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies what you are selling, such as a product or a fixed asset. You’ll see different lists of things to choose from depending on your choice in the Type field.';
                }
                field("Item Reference No."; Rec."Item Reference No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a reference to the item number as defined by the vendor or customer, or the item''s barcode.';
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the variant of the item on the line.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a description of what you are selling. Based on your choices in the Type and No. fields, the field may show suggested text that you can change it for this document. To add a comment, set the Type field to Comment and write the comment itself here.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the inventory location from which the items sold should be picked and where the inventory decrease is registered.';
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the bin where the items are picked or put away.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    ToolTip = 'Specifies how many units are being sold.';
                }
                /* field("Qty. to Assemble to Order"; Rec."Qty. to Assemble to Order")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    ToolTip = 'Specifies how many units of the sales line quantity that you want to supply by assembly.';
                }
                field("Reserved Quantity"; Rec."Reserved Quantity")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    ToolTip = 'Specifies how many units of the item on the line have been reserved.';
                } */
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies how each unit of the item or resource is measured, such as in pieces or hours. By default, the value in the Base Unit of Measure field on the item or resource card is inserted.';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    ToolTip = 'Specifies the price for one unit on the sales line.';
                }
                field("Tax Area Code"; Rec."Tax Area Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the tax area that is used to calculate and post sales tax.';
                }
                field("Tax Group Code"; Rec."Tax Group Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the tax group that is used to calculate and post sales tax.';
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    ToolTip = 'Specifies the discount percentage that is granted for the item on the line.';
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = All;
                    BlankZero = false;
                    ToolTip = 'Specifies the net amount, excluding any invoice discount amount, that must be paid for products on the line.';
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the discount amount that is granted for the item on the line.';
                }
                /* field("Qty. to Ship"; Rec."Qty. to Ship")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    ToolTip = 'Specifies the quantity of items that remain to be shipped.';
                }
                field("Quantity Shipped"; Rec."Quantity Shipped")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    ToolTip = 'Specifies how many units of the item on the line have been posted as shipped.';
                }
                field("Qty. to Invoice"; Rec."Qty. to Invoice")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    ToolTip = 'Specifies the quantity that remains to be invoiced. It is calculated as Quantity - Qty. Invoiced.';
                }
                field("Quantity Invoiced"; Rec."Quantity Invoiced")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    ToolTip = 'Specifies how many units of the item on the line have been posted as invoiced.';
                } */
                field("Special Scheme Code"; Rec."Special Scheme Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the special scheme code.';
                }
                /*  field("Qty. to Assign"; Rec."Qty. to Assign")
                 {
                     ApplicationArea = All;
                     ToolTip = 'Specifies how many units of the item charge are assigned to the line originally.';
                 }
                 field("Item Charge Qty. to Handle"; Rec."Item Charge Qty. to Handle")
                 {
                     ApplicationArea = All;
                     ToolTip = 'Specifies how many items the item charge will be assigned to on the line. It can be either equal to Qty. to Assign or to zero. If it is zero, the item charge will not be assigned to the line.';
                 } */
                /*  field("Qty. Assigned"; Rec."Qty. Assigned")
                 {
                     ApplicationArea = All;
                     BlankZero = true;
                     ToolTip = 'Specifies the quantity of the item charge that was assigned to a specified item when you posted this sales line.';
                 } */
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the vendor''s or customer''s trade type to link transactions made for this business partner with the appropriate general ledger account according to the general posting setup.';
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the item''s product type to link transactions made for this item with the appropriate general ledger account according to the general posting setup.';
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the vendor''s VAT specification to link transactions made for this vendor with the appropriate general ledger account according to the VAT posting setup.';
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the VAT product posting group. Links business transactions made for the item, resource, or G/L account with the general ledger, to account for VAT amounts resulting from trade with that record.';
                }
                /* field("Planned Delivery Date"; Rec."Planned Delivery Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the planned date that the shipment will be delivered at the customer''s address. If the customer requests a delivery date, the program calculates whether the items will be available for delivery on this date. If the items are available, the planned delivery date will be the same as the requested delivery date. If not, the program calculates the date that the items are available for delivery and enters this date in the Planned Delivery Date field.';
                }
                field("Planned Shipment Date"; Rec."Planned Shipment Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date that the shipment should ship from the warehouse. If the customer requests a delivery date, the program calculates the planned shipment date by subtracting the shipping time from the requested delivery date. If the customer does not request a delivery date or the requested delivery date cannot be met, the program calculates the content of this field by adding the shipment time to the shipping date.';
                } */
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when items on the document are shipped or were shipped. A shipment date is usually calculated from a requested delivery date plus lead time.';
                }
                /* field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code for the shipping agent who is transporting the items.';
                } */
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                }
                field("Gross Weight"; Rec."Gross Weight")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the gross weight of one unit of the item. In the sales statistics window, the gross weight on the line is included in the total gross weight of all the lines for the particular sales document.';
                }
                field("Net Weight"; Rec."Net Weight")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the net weight of one unit of the item. In the sales statistics window, the net weight on the line is included in the total net weight of all the lines for the particular sales document.';
                }
                field("Unit Volume"; Rec."Unit Volume")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the volume of one unit of the item. In the sales statistics window, the volume of one unit of the item on the line is included in the total volume of all the lines for the particular sales document.';
                }
                field(Inventory; Rec.Inventory)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies how many units, such as pieces, boxes, or cans, of the item are in inventory.';
                }
                field("Qty. on Purch. Order"; Rec."Qty. on Purch. Order")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies how many units of the item are inbound on purchase orders, meaning listed on outstanding purchase order lines.';
                }
                field("Qty. on Prod. Order"; Rec."Qty. on Prod. Order")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies how many units of the item are allocated to production orders, meaning listed on outstanding production order lines.';
                }
                field("Qty. on Sales Order"; Rec."Qty. on Sales Order")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies how many units of the item are allocated to sales orders, meaning listed on outstanding sales orders lines.';
                }
                /*   field(_StockSeguridad; _StockSeguridad)
                  {
                      ApplicationArea = All;
                      Caption = 'Stock de seguridad';
                  } */
                field(_CantidadEnvios; _CantidadEnvios)
                {
                    ApplicationArea = All;
                    Caption = 'Cantidad en envios almacen';
                }
                field(_FechaCreacion; _FechaCreacion)
                {
                    ApplicationArea = All;
                    Caption = 'Fecha creación';
                }
                field(_FechaDocumento; _FechaDocumento)
                {
                    ApplicationArea = All;
                    Caption = 'Fecha Documento';
                }
                field(_CosteRealUnitario; _CosteRealUnitario)
                {
                    ApplicationArea = All;
                    Caption = 'Coste real unitario';
                }
                field(_CosteReal; _CosteRealTotal)
                {
                    ApplicationArea = All;
                    Caption = 'Coste total';
                }
                field(_ImporteRealUnitario; _ImporteRealUnitario)
                {
                    ApplicationArea = All;
                    Caption = 'Importe real unitario';
                }
                field(_ImporteVenta; _ImporteVenta)
                {
                    ApplicationArea = All;
                    Caption = 'Importe venta DL';
                }
                field("Shipment No."; Rec."Shipment No.")
                {
                    ApplicationArea = All;
                    Caption = 'Nº Envio';
                    Visible = false;
                }
            }
        }
    }
    var _StockSeguridad: Integer;
    _CantidadEnvios: Integer;
    _FechaCreacion: Date;
    _FechaDocumento: Date;
    _CosteRealTotal: Decimal;
    _CosteRealUnitario: Decimal;
    _ImporteVenta: Decimal;
    _ImporteRealUnitario: Decimal;
    _CostAmountActual: Decimal;
    _CostAmountExpected: Decimal;
    _SalesAmountActual: Decimal;
    //_InvoicedQuantity: Decimal;
    trigger OnAfterGetRecord()
    var
        rItem: Record Item;
        rSalesInvHeader: Record "Sales invoice Header";
        rWseShipmentLine: Record "Warehouse Shipment Line";
        rStockkeepingUnit: Record "Stockkeeping Unit";
        rILE: Record "Item Ledger Entry";
        rILEEns: Record "Item Ledger Entry";
        rILEAju: Record "Item Ledger Entry";
        rILEAux: Record "Item Ledger Entry";
        Item: Record Item;
        rWseSetup: Record "Warehouse Setup";
    begin
        ClearAll();
        /*  rItem.Reset();
         rItem.SetRange("No.", Rec."No.");
         if rItem.FindFirst() then begin
             rItem.CalcFields("Stockkeeping Unit Exists");
             if rItem."Stockkeeping Unit Exists" then begin
                 rStockkeepingUnit.Reset();
                 rStockkeepingUnit.SetRange("Item No.", Rec."No.");
                 rStockkeepingUnit.SetRange("Location Code", Rec."Location Code");
                 if rStockkeepingUnit.FindFirst() then
                     _StockSeguridad := rStockkeepingUnit."Safety Stock Quantity";
             end
             else
                 _StockSeguridad := rItem."Safety Stock Quantity";
         end; */
        rWseShipmentLine.Reset();
        rWseShipmentLine.SetRange("Source No.", Rec."Document No.");
        rWseShipmentLine.SetRange("Item No.", Rec."No.");
        if rWseShipmentLine.FindFirst()then begin
            rWseShipmentLine.CalcSums("Qty. Picked");
            _CantidadEnvios:=rWseShipmentLine."Qty. Picked";
        end;
        rSalesInvHeader.Reset();
        rSalesInvHeader.SetRange("No.", Rec."Document No.");
        if rSalesInvHeader.FindFirst()then begin
            _FechaCreacion:=rSalesInvHeader."Order Date";
            _FechaDocumento:=rSalesInvHeader."Document Date";
            if rSalesInvHeader."Currency Factor" <> 0 then _ImporteVenta:=Rec."Line Amount" * rSalesInvHeader."Currency Factor"
            else
                _ImporteVenta:=Rec."Line Amount";
        end;
        rILE.Reset();
        rILE.SetRange("Entry Type", rILE."Entry Type"::Sale);
        rILE.SetRange("Document No.", Rec."Shipment No.");
        rILE.SetRange("Item No.", Rec."No.");
        if rILE.FindFirst()then begin
            //Primero busco por salida de ensamblado
            rILEEns.Reset();
            rILEEns.SetRange("Entry Type", rILEEns."Entry Type"::"Assembly Output");
            rILEEns.SetRange("Lot No.", rILE."Lot No.");
            rILEEns.SetRange("Item No.", rILE."Item No.");
            if rILEEns.FindFirst()then begin
                repeat rILEEns.CalcFields("Cost Amount (Actual)", "Cost Amount (Expected)", "Sales Amount (Actual)");
                    _CostAmountActual:=_CostAmountActual + Abs(rILEEns."Cost Amount (Actual)");
                    _CostAmountExpected:=_CostAmountExpected + Abs(rILEEns."Cost Amount (Expected)");
                    _SalesAmountActual:=_SalesAmountActual + Abs(rILEEns."Sales Amount (Actual)");
                //_InvoicedQuantity := _InvoicedQuantity + Abs(rILEEns."Invoiced Quantity");
                until rILEEns.Next() = 0;
                if _CostAmountActual <> 0 then begin
                    if Abs(rILEEns.Quantity) <> 0 then begin
                        _CosteRealUnitario:=Abs(_CostAmountActual) / rILEEns.Quantity;
                        _CosteRealTotal:=Abs(_CosteRealUnitario) * Rec.Quantity;
                    end;
                end
                else
                begin
                    if rILEEns.Quantity <> 0 then begin
                        _CosteRealUnitario:=Abs(_CostAmountExpected) / rILEEns.Quantity;
                        _CosteRealTotal:=Abs(_CosteRealUnitario * Rec.Quantity);
                    end;
                end;
                if(Abs(Rec.Quantity) <> 0) and (_SalesAmountActual <> 0)then _ImporteRealUnitario:=Abs(_SalesAmountActual / Rec.Quantity)
                else
                begin
                    if Abs(Rec.Quantity) <> 0 then begin
                        rILE.CalcFields("Sales Amount (Actual)");
                        _ImporteRealUnitario:=Abs(rILE."Sales Amount (Actual)" / Rec.Quantity);
                        if _ImporteRealUnitario = 0 then begin
                            _ImporteRealUnitario:=Rec."Line Amount" / Rec.Quantity;
                        end;
                    end;
                end;
            end
            else
            begin
                //Segundo por ajuste positivo
                rILEAju.Reset();
                rILEAju.SetRange("Entry Type", rILEAju."Entry Type"::"Positive Adjmt.");
                rILEAju.SetRange("Lot No.", rILE."Lot No.");
                rILEAju.SetRange("Item No.", rILE."Item No.");
                if rILEAju.FindFirst()then begin
                    repeat rILEAju.CalcFields("Cost Amount (Actual)", "Cost Amount (Expected)", "Sales Amount (Actual)");
                        _CostAmountActual:=_CostAmountActual + Abs(rILEAju."Cost Amount (Actual)");
                        _CostAmountExpected:=_CostAmountExpected + Abs(rILEAju."Cost Amount (Expected)");
                        _SalesAmountActual:=_SalesAmountActual + Abs(rILEAju."Sales Amount (Actual)");
                    // _InvoicedQuantity := _InvoicedQuantity + Abs(rILEAju."Invoiced Quantity");
                    until rILEEns.Next() = 0;
                    if _CostAmountActual <> 0 then begin
                        if Abs(rILEEns.Quantity) <> 0 then begin
                            _CosteRealUnitario:=Abs(_CostAmountActual) / rILEEns.Quantity;
                            _CosteRealTotal:=Abs(_CosteRealUnitario) * Rec.Quantity;
                        end;
                    end
                    else
                    begin
                        if Abs(rILEEns.Quantity) <> 0 then begin
                            _CosteRealUnitario:=Abs(_CostAmountExpected) / rILEEns.Quantity;
                            _CosteRealTotal:=Abs(_CosteRealUnitario * Rec.Quantity);
                        end;
                    end;
                    if(Abs(Rec.Quantity) <> 0) and (_SalesAmountActual <> 0)then _ImporteRealUnitario:=Abs(_SalesAmountActual / Rec.Quantity)
                    else
                    begin
                        rILE.CalcFields("Sales Amount (Actual)");
                        _ImporteRealUnitario:=Abs(rILE."Sales Amount (Actual)" / Rec.Quantity);
                        if _ImporteRealUnitario = 0 then begin
                            _ImporteRealUnitario:=Rec."Line Amount" / Rec.Quantity;
                        end;
                    end;
                end;
            end;
        end
        else
        begin
            //SL si aun no tengo coste unitario caso Productos CATERING busco por fecha de salida de ensambaldo
            Clear(rILE);
            rILE.SetRange("Entry Type", rILE."Entry Type"::Sale);
            rILE.SetRange("Item No.", Rec."No.");
            if rILE.FindFirst()then begin
                //Primero busco por salida de ensamblado
                rILEEns.Reset();
                rILEEns.SetRange("Entry Type", rILEEns."Entry Type"::"Assembly Output");
                rILEEns.SetRange("Posting Date", rILE."Posting Date");
                rILEEns.SetRange("Item No.", rILE."Item No.");
                if rILEEns.FindFirst()then begin
                    repeat rILEEns.CalcFields("Cost Amount (Actual)", "Cost Amount (Expected)", "Sales Amount (Actual)");
                        _CostAmountActual:=_CostAmountActual + Abs(rILEEns."Cost Amount (Actual)");
                        _CostAmountExpected:=_CostAmountExpected + Abs(rILEEns."Cost Amount (Expected)");
                        _SalesAmountActual:=_SalesAmountActual + Abs(rILEEns."Sales Amount (Actual)");
                    //_InvoicedQuantity := _InvoicedQuantity + Abs(rILEEns."Invoiced Quantity");
                    until rILEEns.Next() = 0;
                    if _CostAmountActual <> 0 then begin
                        if Abs(rILEEns.Quantity) <> 0 then begin
                            _CosteRealUnitario:=Abs(_CostAmountActual) / rILEEns.Quantity;
                            _CosteRealTotal:=Abs(_CosteRealUnitario) * Rec.Quantity;
                        end;
                    end
                    else
                    begin
                        if rILEEns.Quantity <> 0 then begin
                            _CosteRealUnitario:=Abs(_CostAmountExpected) / rILEEns.Quantity;
                            _CosteRealTotal:=Abs(_CosteRealUnitario * Rec.Quantity);
                        end;
                    end;
                    if(Abs(Rec.Quantity) <> 0) and (_SalesAmountActual <> 0)then _ImporteRealUnitario:=Abs(_SalesAmountActual / Rec.Quantity)
                    else
                    begin
                        if Abs(Rec.Quantity) <> 0 then begin
                            rILE.CalcFields("Sales Amount (Actual)");
                            _ImporteRealUnitario:=Abs(rILE."Sales Amount (Actual)" / Rec.Quantity);
                            if _ImporteRealUnitario = 0 then begin
                                _ImporteRealUnitario:=Rec."Line Amount" / Rec.Quantity;
                            end;
                        end;
                    end;
                end
                else
                begin
                    //Segundo por ajuste positivo
                    rILEAju.Reset();
                    rILEAju.SetRange("Entry Type", rILEAju."Entry Type"::"Positive Adjmt.");
                    rILEAju.SetRange("Posting Date", rILE."Posting Date");
                    rILEAju.SetRange("Item No.", rILE."Item No.");
                    if rILEAju.FindFirst()then begin
                        repeat rILEAju.CalcFields("Cost Amount (Actual)", "Cost Amount (Expected)", "Sales Amount (Actual)");
                            _CostAmountActual:=_CostAmountActual + Abs(rILEAju."Cost Amount (Actual)");
                            _CostAmountExpected:=_CostAmountExpected + Abs(rILEAju."Cost Amount (Expected)");
                            _SalesAmountActual:=_SalesAmountActual + Abs(rILEAju."Sales Amount (Actual)");
                        // _InvoicedQuantity := _InvoicedQuantity + Abs(rILEAju."Invoiced Quantity");
                        until rILEEns.Next() = 0;
                        if _CostAmountActual <> 0 then begin
                            if Abs(rILEEns.Quantity) <> 0 then begin
                                _CosteRealUnitario:=Abs(_CostAmountActual) / rILEEns.Quantity;
                                _CosteRealTotal:=Abs(_CosteRealUnitario) * Rec.Quantity;
                            end;
                        end
                        else
                        begin
                            if Abs(rILEEns.Quantity) <> 0 then begin
                                _CosteRealUnitario:=Abs(_CostAmountExpected) / rILEEns.Quantity;
                                _CosteRealTotal:=Abs(_CosteRealUnitario * Rec.Quantity);
                            end;
                        end;
                        if(Abs(Rec.Quantity) <> 0) and (_SalesAmountActual <> 0)then _ImporteRealUnitario:=Abs(_SalesAmountActual / Rec.Quantity)
                        else
                        begin
                            rILE.CalcFields("Sales Amount (Actual)");
                            _ImporteRealUnitario:=Abs(rILE."Sales Amount (Actual)" / Rec.Quantity);
                            if _ImporteRealUnitario = 0 then begin
                                _ImporteRealUnitario:=Rec."Line Amount" / Rec.Quantity;
                            end;
                        end;
                    end;
                end;
            end;
        end;
        if _CosteRealUnitario = 0 then begin
            rItem.Reset();
            rItem.SetRange("No.", Rec."No.");
            if rItem.FindFirst()then begin
                //rItem.CalcFields("Unit Cost");
                _CostAmountActual:=rItem."Unit Cost";
                if _CostAmountActual <> 0 then begin
                    if Abs(Rec.Quantity) <> 0 then begin
                        _CosteRealUnitario:=Abs(_CostAmountActual);
                        _CosteRealTotal:=Abs(_CosteRealUnitario) * Rec.Quantity;
                    end;
                end;
            end;
        end;
    end;
}
