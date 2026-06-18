pageextension 50029 AlxItemLedgerEntries extends "Item Ledger Entries"
{
    layout
    {
        modify("Variant Code")
        {
            Caption = 'Marca';
        }
        addbefore(Description)
        {
            field("Descripción Producto"; Rec."Descripción Producto")
            {
                ApplicationArea = All;
                Caption = 'Descripción Producto';
            }
            field("Alias cliente"; Cliente."Search Name")
            {
                ApplicationArea = All;
                Caption = 'Alias cliente';
            }
            field(PersonaRecibe; Rec.PersonaRecibe)
            {
                ApplicationArea = All;
            }
            field(TemperaturaRecepcion; Rec.TemperaturaRecepcion)
            {
                ApplicationArea = All;
            }
            field(AspectoCorrecto; Rec.AspectoCorrecto)
            {
                ApplicationArea = All;
            }
            field(HigieneTranspCorrecta; Rec.HigieneTranspCorrecta)
            {
                ApplicationArea = All;
            }
            field(Observaciones; Rec.Observaciones)
            {
                ApplicationArea = All;
            }
            field(Proveedor; Rec.Proveedor)
            {
                ApplicationArea = All;
            }
            field(gn_CosteUd; gn_CosteUd)
            {
                ApplicationArea = All;
                Caption = 'Coste Ud (Real)';
            }
            field(gn_VentaUd; gn_VentaUd)
            {
                ApplicationArea = All;
                Caption = 'Venta Ud (Real)';
            }
            field(gn_CantidadOriginal; gn_CantidadOriginal)
            {
                ApplicationArea = All;
                Caption = 'Quantity UM Transaction';
            }
            field("Ud. medida Base"; Rec."Ud. medida Base")
            {
                ApplicationArea = All;
            }
            field(AGRALASandach; Rec.AGRALASandach)
            {
                ApplicationArea = All;
            }
        }
    }
    var Producto: Record Item;
    Cliente: Record Customer;
    gn_CosteUd: Decimal;
    gn_VentaUd: Decimal;
    gn_CantidadOriginal: Decimal;
    // _Alias: Code[100];
    trigger OnAfterGetRecord()
    var
        rCust: Record "Customer";
    begin
        //Clear(_Alias);
        //ADV001 Inicio
        gn_CosteUd:=0;
        gn_VentaUd:=0;
        gn_CantidadOriginal:=0;
        IF Rec."Invoiced Quantity" <> 0 THEN BEGIN
            Rec.CalcFields("Cost Amount (Actual)", "Sales Amount (Actual)");
            gn_CosteUd:=Rec."Cost Amount (Actual)" / Rec."Invoiced Quantity";
            gn_VentaUd:=Rec."Sales Amount (Actual)" / Rec."Invoiced Quantity";
        END;
        IF Rec."Qty. per Unit of Measure" <> 0 THEN gn_CantidadOriginal:=Rec.Quantity / Rec."Qty. per Unit of Measure";
        //ADV001 Fin   
        /* Rec.DescProducto := Rec."Descripción Producto";
        Rec.Modify(false); */
        /*  if (Rec."Entry Type" = Rec."Entry Type"::Sale) and (Rec."Source No." <> '') then begin
             if rCust.Get(Rec."Source No.") then
                 _Alias := rCust."Search Name";
         end; */
        if Producto.Get(Rec."Item No.")then begin
            if Rec."Source Type" = Rec."Source Type"::Customer then Cliente.Get(Rec."Source No.")
            else
                Clear(Cliente);
        end
        else
            Clear(Producto);
    end;
}
