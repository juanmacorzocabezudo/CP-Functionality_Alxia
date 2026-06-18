page 50121 "Tabla Productos"
{
    PageType = List;
    ApplicationArea = Basic, Siote;
    UsageCategory = Lists;
    SourceTable = Item;
    Caption = 'TABLA PRODUCTOS';
    Description = 'GAP00050';
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    LinksAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Control50000)
            {
                ShowCaption = false;

                field("N°"; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Descripción; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Inventario; Rec.Inventory)
                {
                    ApplicationArea = All;
                }
                field("Stock disponible"; _stockDisponible)
                {
                    ApplicationArea = All;
                }
                field("Stock de seguridad"; Rec."Safety Stock Quantity")
                {
                    ApplicationArea = All;
                }
                field("Coste unitario"; Rec."Unit Cost")
                {
                    ApplicationArea = All;
                }
                field("Coste estándar"; Rec."Standard Cost")
                {
                    ApplicationArea = All;
                }
                field("Último coste directo"; Rec."Last Direct Cost")
                {
                    ApplicationArea = All;
                }
                field("Diferencia"; Abs(Rec."Last Direct Cost" - Rec."Standard Cost"))
                {
                    ApplicationArea = All;
                    DecimalPlaces = 0: 5;
                    ToolTip = 'último coste directo - Coste estándar';
                }
                field("Nombre Proveedor"; Proveedor.Name)
                {
                    ApplicationArea = All;
                }
                field("N° proveedor"; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Último proveedor"; UltProveedor.Name)
                {
                    ApplicationArea = All;
                }
                field("Fecha ultima factura compra"; Rec."Fecha ultima factura compra")
                {
                    ApplicationArea = All;
                }
                field("Unidad medida base"; Rec."Base Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field("T° Conservación"; Rec.AGRALATempConservacion)
                {
                    ApplicationArea = All;
                }
                field("Sandach"; Rec.AGRALASandach)
                {
                    ApplicationArea = All;
                }
                field(Crítico; Rec.Critico)
                {
                    ApplicationArea = All;
                }
                field(Bloqueado; Rec.Blocked)
                {
                    ApplicationArea = All;
                }
                field("Ubicación 1"; Ubicacion."Bin Code")
                {
                    ApplicationArea = All;
                }
                field("Nombre familia"; Rec."Nombre Familia")
                {
                    ApplicationArea = All;
                }
                field("Nombre sub familia"; SubFamilia2.Description)
                {
                    ApplicationArea = All;
                }
                field("Familia producto"; Rec."Item Category Code")
                {
                    ApplicationArea = All;
                }
                field("Sub familia producto"; SubFamilia2.Code)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    var Proveedor: Record Vendor;
    UltProveedor: Record Vendor;
    Ubicacion: Record "Bin Content";
    Factura: Record "Purch. Inv. Line";
    SubFamilia: Record "Item Category";
    SubFamilia2: Record "Item Category";
    _StockDisponible: Decimal;
    trigger OnAfterGetRecord()
    begin
        if Rec."Vendor No." <> '' then begin
            if not Proveedor.Get(Rec."Vendor No.")then Clear(Proveedor);
        end
        else
            Clear(Proveedor);
        Factura.Reset();
        Factura.SetRange("No.", Rec."No.");
        if not Factura.FindLast()then Clear(Factura);
        if Factura."Buy-from Vendor No." <> '' then UltProveedor.Get(Factura."Buy-from Vendor No.")
        else
            Clear(UltProveedor);
        Ubicacion.Reset();
        Ubicacion.SetRange("Item No.", Rec."No.");
        if not Ubicacion.FindFirst()then Clear(Ubicacion);
        SubFamilia.Reset();
        SubFamilia.SetRange(Code, Rec."Item Category Code");
        if not SubFamilia.FindFirst()then Clear(SubFamilia);
        if SubFamilia."Parent Category" <> '' then if not SubFamilia2.Get(SubFamilia."Parent Category")then Clear(SubFamilia2);
        CalcularStockDisponible();
    end;
    local procedure CalcularStockDisponible()
    begin
        Clear(_StockDisponible);
        Rec.CalcFields(Inventory);
        Rec.CalcFields(AGRALAQtyAssemblyOrderLine);
        Rec.CalcFields(AGRALAQtyOnSalesOrder);
        _StockDisponible:=Rec.Inventory - Rec.AGRALAQtyAssemblyOrderLine - Rec.AGRALAQtyOnSalesOrder;
    end;
}
