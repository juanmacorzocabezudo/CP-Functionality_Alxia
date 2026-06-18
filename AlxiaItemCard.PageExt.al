pageextension 50001 AlxiaItemCard extends "Item Card"
{
    layout
    {
        modify("Last Direct Cost")
        {
            Editable = false;
            Visible = false;
        }
        addafter("Last Direct Cost")
        {
            field("Last Diret Cost"; xgLastDirectCostDiscount)
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
            field(xgDiscountPercentage; xgDiscountPercentage)
            {
                ApplicationArea = All;
                Caption = 'Porcentaje descuento';
                Editable = false;
            }
            field("Fecha ultima factura compra"; Rec."Fecha ultima factura compra")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field(AGRALAFechaUltimaFactCompra; Rec.AGRALAFechaUltimaFactCompra)
            {
                ApplicationArea = All;
            }
            field(gc_ultimoproveedor; gc_nombreUltimoProveedor)
            {
                ApplicationArea = All;
                Caption = 'Último Proveedor';
                Editable = false;
            }
        }
        addafter(Item)
        {
            group(COCKTAIL)
            {
                Caption = 'Cocktail';

                field("Bocados por bandeja"; Rec."Bocados por bandeja")
                {
                    ApplicationArea = All;
                }
                field("Bocados por comensal"; Rec."Bocados por comensal")
                {
                    ApplicationArea = All;
                }
            }
        }
        addafter("Vendor No.")
        {
            field(NombreProveedor; Rec.NombreProveedor)
            {
                ApplicationArea = All;
            }
            field(MarcaProveedor; Rec.MarcaProveedor)
            {
                ApplicationArea = All;
            }
            field(PrecioPropuesto; Rec.PrecioPropuesto)
            {
                ApplicationArea = All;
                DecimalPlaces = 4: 4;
                Editable = false;
            }
        }
        modify("Item Category Code")
        {
            Caption = 'Familia producto';
        }
        addafter("Item Category Code")
        {
            field("Nombre Familia"; Rec."Nombre Familia")
            {
                ApplicationArea = All;
            }
            field("Product Group Code"; subCategoria)
            {
                Caption = 'Sub familia producto';
                ApplicationArea = All;
                TableRelation = "Item Category".Code;

                trigger OnValidate()
                begin
                    BuscarNombreSubFamilia();
                end;
            }
            field(_NombreSubFamilia; _NombreSubFamilia)
            {
                Caption = 'Nombre sub familia';
                Editable = false;
                ApplicationArea = All;
            }
            field(AGRALAUbicacion1; Rec.AGRALAUbicacion1)
            {
                ApplicationArea = All;
            }
            field(AGRALAUbicacion2; Rec.AGRALAUbicacion2)
            {
                ApplicationArea = All;
            }
            field(Ubicacion2; Rec.Ubicacion2)
            {
                ApplicationArea = All;
                Visible = false;
            }
            /*   field(AGRALAStockDisponible; Rec.AGRALAStockDisponible)
              {
                  ApplicationArea = All;
                  Visible = true;
              } */
            field(_stockDisponible; _stockDisponible)
            {
                ApplicationArea = All;
                Caption = 'Stock disponible';
                Enabled = false;
                Editable = false;
            }
            field(AGRALAQtyOnPurchOrder; Rec.AGRALAQtyOnPurchOrder)
            {
                ApplicationArea = All;
            }
            field(AGRALAQtyAssemblyOrderLine; Rec.AGRALAQtyAssemblyOrderLine)
            {
                ApplicationArea = All;
            }
            field(AGRALAQtyOnSalesOrder; Rec.AGRALAQtyOnSalesOrder)
            {
                ApplicationArea = All;
            }
            field("Lote Receta"; Rec."Lote Receta")
            {
                ApplicationArea = All;
            }
            field("Perc. Loss"; Rec."Perc. Loss")
            {
                ApplicationArea = All;
            }
            field(Formato; Rec.Formato)
            {
                ApplicationArea = All;
            }
            field(AGRALATempConservacion; Rec.AGRALATempConservacion)
            {
                ApplicationArea = All;
            }
            field(Catalogo; Rec.Catalogo)
            {
                ApplicationArea = All;
            }
            field(Critico; Rec.Critico)
            {
                ApplicationArea = All;
                Description = 'GAP00040';
            }
            group("Info. Calidad")
            {
                Caption = 'Info. Calidad';

                field(AGRALASandach; Rec.AGRALASandach)
                {
                    ApplicationArea = All;
                }
                field(AGRALAIngrediente; Rec.AGRALAIngrediente)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF(Rec.AGRALAMaterialContacto = TRUE) OR (Rec.AGRALAProductoQuimico = TRUE)THEN ERROR('No se permite seleccionar mas de dos opciones de la información de calidad')end;
                }
                field(AGRALAMaterialContacto; Rec.AGRALAMaterialContacto)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF(Rec.AGRALAIngrediente = TRUE) OR (Rec.AGRALAProductoQuimico = TRUE)THEN ERROR('No se permite seleccionar mas de dos opciones de la información de calidad')end;
                }
                field(AGRALAProductoQuimico; Rec.AGRALAProductoQuimico)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF(Rec.AGRALAIngrediente = TRUE) OR (Rec.AGRALAMaterialContacto = TRUE)THEN ERROR('No se permite seleccionar mas de dos opciones de la información de calidad')end;
                }
            }
        }
    }
    actions
    {
        addafter(ApplyTemplate)
        {
            action(RECETA)
            {
                Caption = 'RECETA';
                ApplicationArea = All;
                Enabled = true;
                Image = BOM;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page Receta;
                RunPageLink = "No."=FIELD("No.");
                RunPageMode = Create;
                RunPageView = SORTING("No.")ORDER(Ascending);
            }
            action("Pedido de ensamblado")
            {
                Caption = 'Pedido de ensamblado';
                ApplicationArea = All;
                Image = BOM;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Assembly Order";
                RunPageLink = "Item No."=FIELD("No.");
                RunPageMode = Create;
                RunPageView = SORTING("Document Type", "No.")ORDER(Ascending);
            }
            action("Duplicar Producto")
            {
                Caption = 'Duplicar producto';
                ApplicationArea = All;
                Image = Add;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.DuplicarProducto;
                end;
            }
            action(CambiarCosteEstandar)
            {
                Caption = 'Modificar coste estándar';
                ApplicationArea = All;
                Image = PriceAdjustment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Enabled = _ModStandCost;
                RunObject = Page 50091;
                RunPageLink = "No."=FIELD("No.");
            }
            action("Variants")
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
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 50072;
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
        addlast(Navigation_Item)
        {
            action(Action50000)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Customers', comment = 'ESP="Clientes"';
                Image = CustomerList;
                ToolTip = 'Display a relationated customer list with the item.', comment = 'ESP="Muestra la lista de clientes relacionados al producto."';
                RunObject = page "Clientes por Producto";
                RunPageLink = "No."=field("No.");
            }
        }
    }
    var subCategoria: Code[20];
    _nombreSubFamilia: Text[100];
    _stockDisponible: Decimal;
    _ModStandCost: Boolean;
    trigger OnOpenPage()
    var
        ItemNo: Text;
    begin
        Evaluate(ItemNo, Rec."No.");
        if(ItemNo.Contains('MP')) or (ItemNo.Contains('MA'))then _ModStandCost:=true
        else
            _ModStandCost:=false;
        //++ AGRALA 519
        BuscarUltimoCosteUMB();
    //-- AGRALA 519
    end;
    var gc_ultimoProveedor: Code[10];
    gc_nombreUltimoProveedor: Text[150];
    Genproductposting: Record 251;
    EditarCampo: Boolean;
    xgLastDirectCostDiscount: Decimal;
    xgDiscountPercentage: Decimal;
    trigger OnAfterGetRecord()
    var
        ItemCat: Record "Item Category";
    begin
        itemCat.Reset();
        itemCat.SetRange(Code, Rec."Item Category Code");
        if ItemCat.FindFirst()then begin
            subCategoria:=ItemCat."Parent Category";
            _nombreSubFamilia:=ItemCat.Description;
        end;
        Clear(_stockDisponible);
        Rec.CalcFields(Inventory);
        Rec.CalcFields(AGRALAQtyAssemblyOrderLine);
        Rec.CalcFields(AGRALAQtyOnSalesOrder);
        _StockDisponible:=Rec.Inventory - Rec.AGRALAQtyAssemblyOrderLine - Rec.AGRALAQtyOnSalesOrder;
        //ADV002 Inicio
        BuscarUltimoProveedor;
        //ADV002 Fin
        BuscarUltimoCosteUMB();
    end;
    local procedure BuscarUltimoProveedor()
    var
        lt_valueEntry: Record 5802;
        recVendor: Record Vendor;
    begin
        //adv002 buscar el último proveedor.
        lt_valueEntry.RESET;
        lt_valueEntry.SETCURRENTKEY("Item No.", "Posting Date", "Item Ledger Entry Type", "Entry Type", "Variance Type", "Item Charge No.", "Location Code", "Variant Code");
        lt_valueEntry.SETRANGE("Item No.", Rec."No.");
        lt_valueEntry.SETRANGE("Item Ledger Entry Type", lt_valueEntry."Item Ledger Entry Type"::Purchase);
        lt_valueEntry.SETRANGE("Entry Type", lt_valueEntry."Entry Type"::"Direct Cost");
        IF lt_valueEntry.FINDLAST THEN begin
            gc_ultimoProveedor:=lt_valueEntry."Source No.";
            recVendor.Reset();
            recVendor.SetRange("No.", gc_ultimoProveedor);
            if recVendor.FindFirst()then gc_nombreUltimoProveedor:=recVendor.Name;
        end;
    end;
    procedure BuscarUltimoCosteUMB()
    var
        rlPurchaseInvLine: Record 123;
    begin
        rlPurchaseInvLine.RESET();
        rlPurchaseInvLine.SETRANGE(rlPurchaseInvLine.Type, rlPurchaseInvLine.Type::Item);
        rlPurchaseInvLine.SETRANGE(rlPurchaseInvLine."No.", Rec."No.");
        IF rlPurchaseInvLine.FINDLAST()THEN BEGIN
            xgLastDirectCostDiscount:=rlPurchaseInvLine."Unit Cost (LCY)";
            xgDiscountPercentage:=rlPurchaseInvLine."Line Discount %";
        //Rec.VALIDATE("Last Direct Cost",rlPurchaseLine."Direct Unit Cost");
        //Rec.MODIFY();
        END;
    end;
    procedure BuscarNombreSubFamilia()
    var
        ItemCat: Record "Item Category";
    begin
        itemCat.Reset();
        itemCat.SetRange(Code, subCategoria);
        if ItemCat.FindFirst()then begin
            _nombreSubFamilia:=ItemCat.Description;
        end;
    end;
}
