page 50151 WsListadodeProductoSC
{
    ApplicationArea = All;
    Caption = 'WsLista de ProductosSC';
    PageType = List;
    SourceTable = Item;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No"; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Bloqueado; Rec.Blocked)
                {
                    ApplicationArea = All;
                }
                field(Descripcion; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Inventario; Rec.Inventory)
                {
                    ApplicationArea = All;
                }
                field("Stock Disponible"; _StockDisponible)
                {
                    ApplicationArea = All;
                }
                field("Stock de seguridad"; Rec."Safety Stock Quantity")
                {
                    ApplicationArea = All;
                }
                field("Unidad medida base"; Rec."Base Unit of Measure")
                {
                    ApplicationArea = All;
                }
                /*    field("Coste estandar"; Rec."Standard Cost")
                   {
                       ApplicationArea = All;
                   }*/
                /*  field("Último Coste directo"; Rec."Last Direct Cost")
                 {
                     ApplicationArea = All;
                 } */
                /*  field(Diferencia; _Diferencia)
                 {
                     ApplicationArea = All;
                 } */
                /*   field("Coste unitario"; Rec."Unit Cost")
                  {
                      ApplicationArea = All;
                  } */
                /*  field("Ultimo Proveedor"; gc_ultimoProveedor)
                 {
                     Caption = 'Ultimo Proveedor';
                     ApplicationArea = All;
                 }
                 field("Fecha Ultima Fact Compra"; Rec.AGRALAFechaUltimaFactCompra)
                 {
                     ApplicationArea = All;
                 } */
                field("Unidad medida compra"; Rec."Purch. Unit of Measure")
                {
                    ApplicationArea = All;
                }
                /*  field("N Proveedor"; Rec."Vendor No.")
                 {
                     ApplicationArea = All;
                 }
                 field("Nombre Proveedor"; Rec."Nombre Prov")
                 {
                     ApplicationArea = All;
                 } */
                field("Precio venta"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                }
                field("Unidad medida venta"; Rec."Sales Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field("Mail Proveedor"; Rec."Mail Proveedor")
                {
                    ApplicationArea = All;
                }
                field("Ficha Tecnica Solicitada"; Rec.FichaTecnicaSolicitada)
                {
                    ApplicationArea = All;
                }
                field("Ficha Tecnica Recibida"; Rec.FichaTecnicaRecibida)
                {
                    ApplicationArea = All;
                }
                field("Marca registrada"; Rec.AGRALAInfoMarcas)
                {
                    ApplicationArea = All;
                }
                field("Peso neto"; Rec."Net Weight")
                {
                    ApplicationArea = All;
                }
                field("Peso bruto"; Rec."Gross Weight")
                {
                    ApplicationArea = All;
                }
                field("Tº Conservación"; Rec.AGRALATempConservacion)
                {
                    ApplicationArea = All;
                }
                field(Sandach; Rec.AGRALASandach)
                {
                    ApplicationArea = All;
                }
                field("Ubicacion 1"; Rec.AGRALAUbicacion1)
                {
                    ApplicationArea = All;
                }
                field("Ubicacion 2"; Rec.AGRALAUbicacion2)
                {
                    ApplicationArea = All;
                }
                /*   field(Ubicacion2; Rec.Ubicacion2)
                  {
                      ApplicationArea = All;
                  } */
                field(Tipo; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field(Critico; Rec.Critico)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    var _StockDisponible: Decimal;
    _Diferencia: Decimal;
    gc_ultimoProveedor: Text;
    xgLastDirectCostDiscount: Decimal;
    trigger OnAfterGetRecord()
    begin
        //ADV001 Añadir ultimo proveedor
        //BuscarUltimoProveedor;
        //ADV001 Fin
        //BuscarUltimoCosteUMB();
        //SL Calculo nuevo del stock disponible
        CalcularStockDisponible();
    //SL Se agrega el campo de diferencia
    // _Diferencia := (Rec."Standard Cost" - Rec."Last Direct Cost");
    end;
    local procedure BuscarUltimoProveedor()
    var
        lt_valueEntry: Record 5802;
    //recVendor: Record Vendor;
    begin
        Clear(gc_ultimoProveedor);
        //Clear(_NombreProv);
        lt_valueEntry.RESET;
        lt_valueEntry.SETCURRENTKEY("Item No.", "Posting Date", "Item Ledger Entry Type", "Entry Type", "Variance Type", "Item Charge No.", "Location Code", "Variant Code");
        lt_valueEntry.SETRANGE("Item No.", Rec."No.");
        lt_valueEntry.SETRANGE("Item Ledger Entry Type", lt_valueEntry."Item Ledger Entry Type"::Purchase);
        lt_valueEntry.SETRANGE("Entry Type", lt_valueEntry."Entry Type"::"Direct Cost");
        IF lt_valueEntry.FINDLAST THEN begin
            gc_ultimoProveedor:=lt_valueEntry."Source No.";
        end;
    end;
    local procedure CalcularStockDisponible()
    begin
        Clear(_StockDisponible);
        Rec.CalcFields(Inventory);
        Rec.CalcFields(AGRALAQtyAssemblyOrderLine);
        Rec.CalcFields(AGRALAQtyOnSalesOrder);
        _StockDisponible:=Rec.Inventory - Rec.AGRALAQtyAssemblyOrderLine - Rec.AGRALAQtyOnSalesOrder;
    end;
    procedure BuscarUltimoCosteUMB()
    var
        rlPurchaseInvLine: Record 123;
    begin
        Clear(xgLastDirectCostDiscount);
        rlPurchaseInvLine.RESET();
        rlPurchaseInvLine.SETRANGE(rlPurchaseInvLine.Type, rlPurchaseInvLine.Type::Item);
        rlPurchaseInvLine.SETRANGE(rlPurchaseInvLine."No.", Rec."No.");
        IF rlPurchaseInvLine.FINDLAST()THEN BEGIN
            xgLastDirectCostDiscount:=rlPurchaseInvLine."Unit Cost (LCY)";
        END;
    end;
}
