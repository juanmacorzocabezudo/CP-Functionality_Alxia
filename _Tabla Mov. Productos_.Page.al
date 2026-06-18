page 50120 "Tabla Mov. Productos"
{
    PageType = List;
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;
    SourceTable = "Item Ledger Entry";
    Caption = 'TABLA MOV. PRODUCTOS';
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

                field("N° mov."; Rec."Entry No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Fecha registro"; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("N° producto"; Rec."Item No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Descripción Producto"; Producto.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Marca"; Producto.MarcaProveedor)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("N° lote"; Rec."Lot No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Remaining Quantity"; Rec."Remaining Quantity")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Ud. medida Base"; Producto."Base Unit of Measure")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Fecha caducidad"; Rec."Expiration Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Sandach"; Rec.AGRALASandach)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Alias cliente"; Cliente."Search Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("N° documento"; Rec."Document No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Tipo movimiento"; Rec."Entry Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Cód. procedencia mov."; Rec."Source No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Familia Código"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Linea de Negocio"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Coste Ud (Real)"; Producto."Unit Cost")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Cantidad facturada"; Rec."Invoiced Quantity")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Importe coste (Real)"; Rec."Cost Amount (Actual)")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        if Producto.Get(Rec."Item No.")then begin
            if Rec."Source Type" = Rec."Source Type"::Customer then Cliente.Get(Rec."Source No.")
            else
                Clear(Cliente);
        end
        else
            Clear(Producto);
    end;
    var Producto: Record Item;
    Cliente: Record Customer;
}
