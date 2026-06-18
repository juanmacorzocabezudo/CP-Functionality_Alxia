pageextension 50000 AlxiaItemList extends "Item List"
{
    layout
    {
        modify("Last Direct Cost")
        {
            Caption = 'Último coste directo';
            Visible = false;
        }
        modify("Item Category Code")
        {
            Caption = 'Familia producto';
            Visible = true;
        }
        addafter("Item Category Code")
        {
            field("Nombre Familia"; Rec."Nombre Familia")
            {
                ApplicationArea = All;
                Visible = true;
            }
            field(subCategoria; subCategoria)
            {
                ApplicationArea = All;
                Caption = 'Sub familia producto';
                Visible = true;
            }
            field(_NombreSubFamilia; _NombreSubFamilia)
            {
                Caption = 'Nombre sub familia';
                Editable = false;
                ApplicationArea = All;
            }
        }
        addbefore("Last Direct Cost")
        {
            field("Last Diret Cost2"; xgLastDirectCostDiscount)
            {
                ApplicationArea = All;
                DecimalPlaces = 2: 3;
                Caption = 'Último coste directo';
                Editable = false;
                Visible = true;

                trigger OnDrillDown()
                var
                    rlPurchaseInvLine: Record 123;
                    recPurHeader: Record "Purch. Inv. Header";
                begin
                    rlPurchaseInvLine.RESET();
                    rlPurchaseInvLine.SETRANGE(rlPurchaseInvLine.Type, rlPurchaseInvLine.Type::Item);
                    rlPurchaseInvLine.SETRANGE(rlPurchaseInvLine."No.", Rec."No.");
                    IF rlPurchaseInvLine.FINDLAST()THEN BEGIN
                        recPurHeader.Reset();
                        recPurHeader.SetRange("No.", rlPurchaseInvLine."Document No.");
                        if recPurHeader.FindFirst()then PAGE.RUN(146, recPurHeader);
                    end end;
            }
        }
        addafter("Vendor No.")
        {
            field("Nombre Prov"; Rec."Nombre Prov")
            {
                ApplicationArea = All;
                Caption = 'Nombre Proveedor';
            }
        }
        addafter("Default Deferral Template Code")
        {
            field("Tiene EAN"; Rec."Tiene EAN")
            {
                ApplicationArea = All;
            }
            field("Tiene Ref Prov."; Rec."Tiene Ref Prov.")
            {
                ApplicationArea = All;
            }
            field(ultimoProveedor; gc_ultimoProveedor)
            {
                Caption = 'Último Proveedor';
                ApplicationArea = All;
                Editable = false;
            }
            field(_Diferencia; _Diferencia)
            {
                ApplicationArea = All;
                Caption = 'Diferencia';
                StyleExpr = StyleTextDiferencia;
            }
            field("Fecha ultima factura compra"; Rec."Fecha ultima factura compra")
            {
                ApplicationArea = All;
            }
            field("Mail Proveedor"; Rec."Mail Proveedor")
            {
                ApplicationArea = All;
            }
            field(FichaTecnicaSolicitada; Rec.FichaTecnicaSolicitada)
            {
                ApplicationArea = All;
            }
            field(FichaTecnicaRecibida; Rec.FichaTecnicaRecibida)
            {
                ApplicationArea = All;
            }
            field(AGRALAInfoMarcas; Rec.AGRALAInfoMarcas)
            {
                ApplicationArea = All;
            }
            field("Net Weight"; Rec."Net Weight")
            {
                ApplicationArea = All;
            }
            field("Gross Weight"; Rec."Gross Weight")
            {
                ApplicationArea = All;
            }
            field(AGRALATempConservacion; Rec.AGRALATempConservacion)
            {
                ApplicationArea = All;
            }
            field(Critico; Rec.Critico)
            {
                ApplicationArea = All;
            }
            field(AGRALASandach; Rec.AGRALASandach)
            {
                ApplicationArea = All;
            }
            /*   field(AGRALAStockDisponible; Rec.AGRALAStockDisponible)
              {
                  ApplicationArea = All;
              } */
            field(_StockDisponible; _StockDisponible)
            {
                ApplicationArea = All;
                Caption = 'Stock disponible';
            }
            field("Safety Stock Quantity"; Rec."Safety Stock Quantity")
            {
                ApplicationArea = All;
            }
            field(AGRALAUbicacion1; Rec.AGRALAUbicacion1)
            {
                ApplicationArea = All;
            //Visible = true;
            }
            field(AGRALAUbicacion2; Rec.AGRALAUbicacion2)
            {
                ApplicationArea = All;
            }
            field(Formato; Rec.Formato)
            {
                ApplicationArea = all;
                Visible = true;
            }
        }
    }
    actions
    {
        addafter("Unit of Measure")
        {
            action(RECETA)
            {
                Caption = 'Receta';
                ApplicationArea = All;
                Enabled = true;
                Image = BOM;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 50000;
                RunPageLink = "No."=FIELD("No.");
                RunPageView = SORTING("No.")ORDER(Ascending);
            }
            action("Duplicar Producto")
            {
                Caption = 'Duplicar Producto';
                Image = Add;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.DuplicarProducto;
                end;
            }
            action("_ACT")
            {
                Caption = '_ACT';
                Image = UpdateXML;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = _devAction;

                trigger OnAction()
                begin
                    Rec.ActualizarTodos();
                end;
            }
        }
        addafter("Duplicar Producto")
        {
            action("Va&riants2")
            {
                ApplicationArea = All;
                Caption = 'Ingredientes';
                Enabled = Rec.AGRALAIngrediente;
                Image = ItemVariant;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 50076;
                RunPageLink = "Item No."=FIELD("No.");
            }
            action(AGRALAContactoalimentos)
            {
                ApplicationArea = All;
                Caption = 'Material contacto alimentos';
                Enabled = Rec.AGRALAMaterialContacto;
                Image = PrintVoucher;
                RunObject = Page 50072;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunPageLink = "Item No."=FIELD("No.");
            }
            action(AGRALABotonProductoQuimico)
            {
                ApplicationArea = All;
                Caption = 'Producto químico';
                Enabled = Rec.AGRALAProductoQuimico;
                Image = Find;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 50073;
                RunPageLink = "Item No."=FIELD("No.");
            }
            action(AGRALAInfoCalidad)
            {
                ApplicationArea = All;
                Caption = 'Info Calidad';
                Image = QualificationOverview;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 50075;
                RunPageLink = "Item No."=FIELD("No.");

                trigger OnAction()
                var
                    rlItemVariant: Record 5401;
                    rlBOMComponent: Record 90;
                    xlFiltros: Text;
                    pl: Page 50075;
                begin
                    CLEAR(xlFiltros);
                    rlBOMComponent.SETRANGE("Parent Item No.", Rec."No.");
                    rlBOMComponent.SETRANGE(Type, rlBOMComponent.Type::Item);
                    if rlBOMComponent.FINDSET then begin
                        REPEAT xlFiltros+='|' + rlBOMComponent."No.";
                        UNTIL rlBOMComponent.NEXT() = 0;
                        xlFiltros:=COPYSTR(xlFiltros, 2);
                        rlItemVariant.SETFILTER("Item No.", xlFiltros);
                        PAGE.RUN(50075, rlItemVariant);
                    end;
                end;
            }
        }
    }
    var gc_ultimoProveedor: Code[10];
    _StockDisponible: Decimal;
    _Diferencia: Decimal;
    StyleTextDiferencia: Text;
    xgLastDirectCostDiscount: Decimal;
    _devAction: Boolean;
    subCategoria: Code[20];
    _nombreSubFamilia: Text[100];
    trigger OnOpenPage()
    begin
        if UserId = 'BC' then _devAction:=true;
    end;
    trigger OnAfterGetRecord()
    var
        ItemCat: Record "Item Category";
    begin
        Clear(subCategoria);
        Clear(_nombreSubFamilia);
        //ADV001 Añadir ultimo proveedor
        BuscarUltimoProveedor;
        //ADV001 Fin
        BuscarUltimoCosteUMB();
        //SL Calculo nuevo del stock disponible
        CalcularStockDisponible();
        //SL Se agrega el campo de diferencia
        _Diferencia:=(Rec."Standard Cost" - Rec."Last Direct Cost");
        StyleTextDiferencia:='Standard';
        if _Diferencia < 0 then StyleTextDiferencia:='Unfavorable';
        itemCat.Reset();
        itemCat.SetRange(Code, Rec."Item Category Code");
        if ItemCat.FindFirst()then begin
            subCategoria:=ItemCat."Parent Category";
            _nombreSubFamilia:=ItemCat.Description;
        end;
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
        /*  recVendor.Reset();
             recVendor.SetRange("No.", lt_valueEntry."Source No.");
             if recVendor.FindFirst() then
                 _NombreProv := recVendor.Name; */
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
