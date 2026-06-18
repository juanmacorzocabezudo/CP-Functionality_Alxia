codeunit 50015 "CPF Procesos Automaticos"
{
    TableNo = "Job Queue Entry";

    trigger OnRun()
    begin
        Case Rec.Description of // GAP00040 >>>
        'ActualizarTablaProductosClientes': begin
            ActualizarTablaProductosClientes();
        end;
        // GAP00040 <<<
        '': exit;
        end;
    end;
    var myInt: Integer;
    // GAP00040 >>>
    local procedure ActualizarTablaProductosClientes()
    var
        ConfVentas: Record "Sales & Receivables Setup";
        LinFactVenta: Record "Sales Invoice Line";
        Prodclie: Record "Productos Clientes";
        Producto: Record Item;
        Cliente: Record Customer;
        Inventario: Record "Item Ledger Entry";
        Componentes: Record "BOM Component";
    begin
        ConfVentas.Get();
        LinFactVenta.Reset();
        LinFactVenta.SetRange("Posting Date", ConfVentas."Periodo Inicial Cal Clientes", Today());
        LinFactVenta.SetRange(Type, Enum::"Sales Line Type"::Item);
        if LinFactVenta.FindSet()then repeat Prodclie.Reset();
                Prodclie.SetRange("Nro. Producto", LinFactVenta."No.");
                Prodclie.SetRange("Nro. Cliente", LinFactVenta."Sell-to Customer No.");
                if not Prodclie.FindFirst()then begin
                    Prodclie.Init();
                    Prodclie."Nro. Producto":=LinFactVenta."No.";
                    Prodclie."Descripción Producto":=LinFactVenta.Description;
                    Prodclie.Validate("Nro. Cliente", LinFactVenta."Sell-to Customer No.");
                    Prodclie.Insert();
                end;
                Componentes.Reset();
                Componentes.SetRange(Type, Enum::"BOM Component Type"::Item);
                Componentes.SetRange("Parent Item No.", LinFactVenta."No.");
                if Componentes.FindSet()then repeat Inventario.Reset();
                        Inventario.SetRange("Item No.", Componentes."No.");
                        Inventario.CalcSums(Quantity);
                        Componentes."Inventory Item No.":=Inventario.Quantity;
                        Componentes.Modify();
                    until Componentes.Next() = 0;
                if Producto.Get(LinFactVenta."No.")then begin
                    Producto."Tiene Cliente Asociado":=true;
                    Producto.Modify();
                end;
                if Cliente.Get(LinFactVenta."Sell-to Customer No.")then begin
                    Cliente."Tiene Producto Asociado":=true;
                    Cliente.Modify();
                end;
            until LinFactVenta.Next() = 0;
    end;
// GAP00040 <<<
}
