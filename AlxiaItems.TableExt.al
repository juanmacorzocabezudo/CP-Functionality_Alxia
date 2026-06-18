tableextension 50006 AlxiaItems extends Item
{
    fields
    {
        field(50000; "Lote Receta"; Integer)
        {
            Caption = 'Lote Receta';

            trigger OnValidate()
            begin
                //++ 23/09/21
                ActualizarLoteRecetaLM;
            //--
            end;
        }
        field(50001; "Lote Unitario"; Decimal)
        {
            Caption = 'Lote Unitario';
            Enabled = false;
        }
        field(50002; Formato; Code[20])
        {
            Caption = 'Formato';
            TableRelation = "Formato Producto";
        }
        field(50003; "Bocados por bandeja"; Integer)
        {
        }
        field(50004; "Bocados por comensal"; Integer)
        {
        }
        field(50005; Catalogo; Boolean)
        {
            Description = 'I003600';
        }
        field(50010; "Tiene EAN"; Boolean)
        {
            Caption = 'Tiene EAN';
            CalcFormula = Exist("Item Reference" WHERE("Item No."=FIELD("No."), "Reference Type"=FILTER("Bar code")));
            FieldClass = FlowField;
        }
        field(50011; "Tiene Ref Prov."; Boolean)
        {
            CalcFormula = Exist("Item Reference" WHERE("Item No."=FIELD("No."), "Reference Type"=FILTER(Vendor)));
            FieldClass = FlowField;
        }
        field(50012; "Nombre Prov"; Text[100])
        {
            Caption = 'Nombre Proveedor';
            CalcFormula = Lookup(Vendor.Name WHERE("No."=FIELD("Vendor No.")));
            FieldClass = FlowField;
        }
        field(50013; Ubicacion2; Text[20])
        {
            Caption = 'Ubicación 2';
        }
        field(50014; "Fecha ultima factura compra"; Date)
        {
            CalcFormula = Max("Value Entry"."Posting Date" WHERE("Item No."=FIELD("No."), "Item Ledger Entry Type"=CONST(Purchase), "Entry Type"=CONST("Direct Cost")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50020; "Perc. Loss"; Decimal)
        {
            Caption = '% Merma';
            Description = '#9862';
        }
        field(50021; "Statistics Lot"; Decimal)
        {
            Caption = 'Lote Estadistico';
            Description = '#9862';
        }
        field(50022; "Statistics Unit of Measurement"; Code[10])
        {
            Caption = 'Unidad Medida Estadisticas';
            Description = '#9862';
            TableRelation = "Unit of Measure".Code;
        }
        field(50023; "Status LM";Enum AlxiaStatusLM)
        {
            Caption = 'Estado Receta';
            Description = '#9993';
        }
        field(50024; Receta_CosteLMFijado; Decimal)
        {
            Description = '#9993';
        }
        field(50025; "Mail Proveedor"; Text[80])
        {
            CalcFormula = Lookup(vendor."E-Mail" WHERE("No."=FIELD("Vendor No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50026; FichaTecnicaSolicitada; Date)
        {
            Caption = 'Ficha Tecnica Solicitada';
        }
        field(50027; FichaTecnicaRecibida; Date)
        {
            Caption = 'Ficha Tecnica Recibida';
        }
        field(50028; AGRALAIngrediente; Boolean)
        {
            Caption = 'Ingrediente';
            Description = '210021';
        }
        field(50029; AGRALAMaterialContacto; Boolean)
        {
            Caption = 'Material contacto';
            Description = '210021';
        }
        field(50030; AGRALAProductoQuimico; Boolean)
        {
            Caption = 'Producto químico';
            Description = '210021';
        }
        field(50031; AGRALAInfoMarcas; Integer)
        {
            CalcFormula = Count("Item Variant" WHERE("Item No."=FIELD("No.")));
            Caption = 'Marcas registradas (0=Falta)';
            Description = '210021';
            FieldClass = FlowField;
        }
        field(50032; AGRALATempConservacion; Option)
        {
            Caption = 'Tº Conservación';
            Description = '84';
            OptionCaption = 'AMBIENTE,REFRIGERADO,CONGELADO';
            OptionMembers = AMBIENTE, REFRIGERADO, CONGELADO;
        }
        field(50033; AGRALASandach; Boolean)
        {
            Caption = 'Sandach';
            Description = '292';

            trigger OnValidate()
            begin
                AGRALASandachFuncion(Rec."No.");
                IF NOT(Rec."Replenishment System" = Rec."Replenishment System"::Purchase)THEN ERROR('El producto no puede ser un producto intermedio o producto terminado, este producto su sistema de reposición es ensamblado');
            end;
        }
        field(50034; AGRALALastDirectCost; Decimal)
        {
            Caption = 'Ultimo Coste Directo';
            Description = '#519';
        }
        field(50035; AGRALAStockDisponible; Decimal)
        {
            Caption = 'Stock disponible';
            DecimalPlaces = 2: 2;
            Description = '862';
            Editable = false;
        }
        field(50036; AGRALAQtyOnPurchOrder; Decimal)
        {
            CalcFormula = Sum("Purchase Line".Quantity WHERE("No."=FIELD("No."), "Document Type"=CONST(Order), AGRALAStatus=CONST(Open)));
            Caption = 'Cdad. en pedidos compra';
            DecimalPlaces = 0: 0;
            Description = '862';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50037; AGRALAQtyAssemblyOrder; Decimal)
        {
            CalcFormula = Sum("Assembly Header".Quantity WHERE("Item No."=FIELD("No."), "Document Type"=CONST(Order), Status=CONST(Open)));
            Caption = 'Cdad. en ensamblado';
            DecimalPlaces = 0: 0;
            Description = '862';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50038; AGRALAQtyAssemblyOrderLine; Decimal)
        {
            CalcFormula = Sum("Assembly Line".Quantity WHERE("No."=FIELD("No."), "Document Type"=CONST(Order), "Remaining Quantity"=FILTER(<>0)));
            Caption = 'Cdad. en linea ensamblado';
            DecimalPlaces = 2: 2;
            Description = '862';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50039; AGRALAQtyOnSalesOrder; Decimal)
        {
            CalcFormula = Sum("Sales Line".Quantity WHERE("No."=FIELD("No."), "Document Type"=CONST(Order), "Qty. to Ship"=FILTER(<>0)));
            Caption = 'Cdad. en pedidos venta';
            DecimalPlaces = 0: 0;
            Description = '862';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50040; AGRALAUbicacion1; Code[30])
        {
            Caption = 'Ubicación 1';
            Description = '865';
            TableRelation = AGRALAUbicacion.Ubicacion;
        }
        field(50041; AGRALAUbicacion2; Code[30])
        {
            Caption = 'Ubicación 2';
            Description = '865';
            TableRelation = AGRALAUbicacion.Ubicacion;
        }
        field(50042; AGRALAFechaUltimaFactCompra; Date)
        {
            CalcFormula = Max("Value Entry"."Posting Date" WHERE("Item No."=FIELD("No."), "Item Ledger Entry Type"=CONST(Purchase), "Entry Type"=CONST("Direct Cost"), "Posting Date"=field("Fecha ultima factura compra")));
            Caption = 'Fecha última factura compra';
            Description = '863';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50043; AlxStockDisponible; Decimal)
        {
            Caption = 'Stock disponible';
            DecimalPlaces = 2: 2;
            Editable = false;
        //FieldClass = FlowField;
        //CalcFormula = sum(Item.Inventory - AGRALAQtyAssemblyOrderLine -)
        }
        field(50044; NombreProveedor; Text[150])
        {
            Caption = 'Nomber Proveedor';
        }
        field(50045; PrecioPropuesto; Decimal)
        {
            Caption = 'Precio Propuesto';
        }
        field(50046; MarcaProveedor; Code[20])
        {
            Caption = 'Marca';
        }
        field(50047; "Nombre Familia"; Text[100])
        {
            FieldClass = FlowField;
            Caption = 'Nombre famila';
            CalcFormula = lookup("Item Category".Description where(Code=FIELD("Item Category Code")));
        }
        /*  field(50048; "Nombre SubFamilia"; Text[100])
         {
             FieldClass = FlowField;
             Caption = 'Nombre subfamila';
             CalcFormula = lookup("Item Category".Description where(Code = FIELD("Item Category Code")));
         } */
        field(50048; Critico; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Critial', comment = 'ESP="Crítico"';
            Description = 'GAP00040';

            trigger OnValidate()
            var
                Componentes: Record "BOM Component";
            begin
                Componentes.Reset();
                Componentes.SetRange(Type, Enum::"BOM Component Type"::Item);
                Componentes.SetRange("No.", "No.");
                if Componentes.FindSet()then begin
                    Componentes."Critical Item No.":=Rec.Critico;
                    Componentes.Modify();
                end;
            end;
        }
        field(50049; "Tiene Cliente Asociado"; Boolean)
        {
            DataClassification = CustomerContent;
            Description = 'GAP00040';
        }
        modify(Description)
        {
        trigger OnAfterValidate()
        begin
            if(Rec."Description" <> xRec.Description)then ActualizarNombreReceta();
        end;
        }
    }
    fieldgroups
    {
    addlast(DropDown;
    "No.", Description, "Standard Cost")
    {
    }
    }
    procedure ActualizarLoteRecetaLM()
    var
        BOMComponent: Record "BOM Component";
    begin
        IF NOT CONFIRM('ATENCIÓN! Si modifica este dato se actualizará el campo "Cantidad por UMB", está seguro?')THEN EXIT;
        MODIFY;
        COMMIT;
        BOMComponent.RESET;
        BOMComponent.SETRANGE("Parent Item No.", Rec."No.");
        BOMComponent.SETFILTER(Type, '<>%1', BOMComponent.Type::" ");
        IF BOMComponent.FINDSET THEN REPEAT BOMComponent.VALIDATE("Cantidad por Lote");
                BOMComponent.MODIFY;
            UNTIL BOMComponent.NEXT = 0;
    end;
    local procedure AGRALASandachFuncion(pProducto: Code[20])
    var
        rlBOMComponent: Record "BOM Component";
        rlItem: Record Item;
        rlBOMComponent2: Record "BOM Component";
        rlItem2: Record Item;
    begin
        CLEAR(rlBOMComponent);
        rlBOMComponent.SETRANGE("No.", Rec."No.");
        IF rlBOMComponent.FINDSET THEN REPEAT CLEAR(rlItem);
                IF rlItem.GET(rlBOMComponent."Parent Item No.")THEN BEGIN
                    AGRALAModificaSandachPadre(Rec.AGRALASandach, rlBOMComponent."Parent Item No.");
                END;
            UNTIL rlBOMComponent.NEXT = 0;
    end;
    local procedure AGRALAModificaSandachPadre(pbool: Boolean; ppadre: Code[20])
    var
        rlItem: Record Item;
        rlBOMComponent: Record "BOM Component";
        il: Integer;
    begin
        //Modificar el padre
        CLEAR(rlItem);
        IF rlItem.GET(ppadre)THEN BEGIN
            IF pbool = TRUE THEN rlItem.AGRALASandach:=TRUE;
            IF pbool = FALSE THEN BEGIN
                rlItem.AGRALASandach:=FALSE;
            END;
            rlItem.MODIFY;
        //COMMIT;
        END;
        //Si encuentro alguno otro SANDACH en esa misma receta.
        CLEAR(rlBOMComponent);
        rlBOMComponent.SETRANGE("Parent Item No.", ppadre);
        IF rlBOMComponent.FINDSET THEN REPEAT CLEAR(rlItem);
                IF rlItem.GET(rlBOMComponent."No.")THEN BEGIN
                    il:=0;
                    IF rlItem.AGRALASandach THEN il+=1;
                    IF il >= 1 THEN pbool:=TRUE;
                END;
            UNTIL rlBOMComponent.NEXT = 0;
        //Subimos otros llamando recursivamene a esta llamada
        CLEAR(rlBOMComponent);
        rlBOMComponent.SETRANGE("No.", ppadre);
        IF rlBOMComponent.FINDSET THEN REPEAT AGRALAModificaSandachPadre(pbool, rlBOMComponent."Parent Item No.");
            UNTIL rlBOMComponent.NEXT = 0;
    end;
    procedure ActualizarImportanciaEnCosteEventos(eventoId: Code[10]; lineaId: Integer; productoId: Code[10])
    var
        BOMComponent: Record "Componentes Evento";
        CosteProductos: Decimal;
        AsmInfoPaneMgt: Codeunit AlxiaFuncionesImportadas;
    begin
        BOMComponent.RESET;
        BOMComponent.SETRANGE("Codigo Evento", eventoId);
        BOMComponent.SETRANGE("Linea Evento", lineaId);
        BOMComponent.SETRANGE("Parent Item No.", productoId);
        BOMComponent.SETRANGE(Type, BOMComponent.Type::Item);
        BOMComponent.CALCSUMS("Coste Lote");
        CosteProductos:=BOMComponent."Coste Lote";
        BOMComponent.RESET;
        BOMComponent.SETRANGE("Codigo Evento", eventoId);
        BOMComponent.SETRANGE("Linea Evento", lineaId);
        BOMComponent.SETRANGE("Parent Item No.", productoId);
        BOMComponent.SETRANGE(Type, BOMComponent.Type::Item);
        IF BOMComponent.FINDFIRST THEN REPEAT IF(CosteProductos <> 0)THEN BEGIN
                    BOMComponent."Importancia en Coste":=BOMComponent."Coste Lote" / CosteProductos * 100;
                END
                ELSE
                BEGIN
                    BOMComponent."Importancia en Coste":=0;
                END;
                BOMComponent.MODIFY(FALSE);
            UNTIL BOMComponent.NEXT = 0;
        BOMComponent.RESET;
        BOMComponent.SETRANGE("Codigo Evento", eventoId);
        BOMComponent.SETRANGE("Linea Evento", lineaId);
        BOMComponent.SETRANGE("Parent Item No.", productoId);
        BOMComponent.SETRANGE(Type, BOMComponent.Type::Resource);
        BOMComponent.CALCSUMS("Coste Lote");
        CosteProductos:=BOMComponent."Coste Lote";
        BOMComponent.RESET;
        BOMComponent.SETRANGE("Codigo Evento", eventoId);
        BOMComponent.SETRANGE(BOMComponent."Linea Evento", lineaId);
        BOMComponent.SETRANGE("Parent Item No.", productoId);
        BOMComponent.SETRANGE(BOMComponent.Type, BOMComponent.Type::Resource);
        IF BOMComponent.FINDFIRST THEN REPEAT IF(CosteProductos <> 0)THEN BEGIN
                    BOMComponent."Importancia en Coste":=BOMComponent."Coste Lote" / CosteProductos * 100;
                END
                ELSE
                BEGIN
                    BOMComponent."Importancia en Coste":=0;
                END;
                BOMComponent.MODIFY(FALSE);
            UNTIL BOMComponent.NEXT = 0;
    end;
    procedure DuplicarProducto()
    var
        Item: Record Item;
        ItemCopy: Record Item;
        BOMComponent: Record "BOM Component";
        BOMComponentCopy: Record "BOM Component";
        BOMAditionalCost: Record "BOM Aditional Cost";
        BOMAditionalCostCopy: Record "BOM Aditional Cost";
        DefaultDimension: Record 352;
        DefaultDimensionCopy: Record 352;
        ItemUnitofMeasure: Record 5404;
        ItemUnitofMeasureCopy: Record 5404;
    begin
        IF Rec."No." = '' THEN EXIT;
        IF NOT CONFIRM('Atención, se va a crear una nueva referencia copia de la actual, está seguro?')THEN EXIT;
        Item.GET(Rec."No.");
        ItemCopy.TRANSFERFIELDS(Item);
        ItemCopy."No.":='';
        ItemCopy.INSERT(TRUE);
        ItemCopy.VALIDATE("Global Dimension 1 Code");
        ItemCopy.VALIDATE("Global Dimension 2 Code");
        ItemCopy.VALIDATE("Unit Cost", 0);
        ItemCopy.VALIDATE("Standard Cost", 0);
        ItemCopy.VALIDATE("Last Direct Cost", 0);
        ItemCopy.VALIDATE("Status LM", ItemCopy."Status LM"::"Under Construction");
        ItemCopy.MODIFY(TRUE);
        DefaultDimension.RESET;
        DefaultDimension.SETRANGE(DefaultDimension."Table ID", DATABASE::Item);
        DefaultDimension.SETRANGE("No.", Item."No.");
        IF DefaultDimension.FINDFIRST THEN REPEAT DefaultDimensionCopy.TRANSFERFIELDS(DefaultDimension);
                DefaultDimensionCopy."No.":=ItemCopy."No.";
                DefaultDimensionCopy.INSERT(TRUE);
            UNTIL DefaultDimension.NEXT = 0;
        //-- KR 29/12/2021
        ItemCopy.VALIDATE("Global Dimension 1 Code", Item."Global Dimension 1 Code");
        ItemCopy.VALIDATE("Global Dimension 2 Code", Item."Global Dimension 2 Code");
        ItemCopy.MODIFY;
        //++ KR 29/12/2021
        ItemUnitofMeasure.RESET;
        ItemUnitofMeasure.SETRANGE("Item No.", Item."No.");
        IF ItemUnitofMeasure.FINDFIRST THEN REPEAT ItemUnitofMeasureCopy.TRANSFERFIELDS(ItemUnitofMeasure);
                ItemUnitofMeasureCopy."Item No.":=ItemCopy."No.";
                ItemUnitofMeasureCopy.INSERT(TRUE);
            UNTIL ItemUnitofMeasure.NEXT = 0;
        BOMComponent.RESET;
        BOMComponent.SETRANGE(BOMComponent."Parent Item No.", Item."No.");
        IF BOMComponent.FINDFIRST THEN REPEAT BOMComponentCopy.TRANSFERFIELDS(BOMComponent);
                BOMComponentCopy."Parent Item No.":=ItemCopy."No.";
                BOMComponentCopy.INSERT(TRUE);
            UNTIL BOMComponent.NEXT = 0;
        BOMAditionalCost.RESET;
        BOMAditionalCost.SETRANGE(BOMAditionalCost."Item No", Item."No.");
        IF BOMAditionalCost.FINDFIRST THEN REPEAT BOMAditionalCostCopy.TRANSFERFIELDS(BOMAditionalCost);
                BOMAditionalCostCopy."Item No":=ItemCopy."No.";
                BOMAditionalCostCopy.INSERT(TRUE);
            UNTIL BOMAditionalCost.NEXT = 0;
        ItemCopy.VALIDATE("Status LM", ItemCopy."Status LM"::"Under Construction");
        ItemCopy.MODIFY;
    end;
    procedure SetFijarCosteLMRecetaEnFichaArticulo()
    var
        AsmInfoPaneMgt: Codeunit AlxiaAssemblyInfoManagement;
    begin
        Receta_CosteLMFijado:=AsmInfoPaneMgt.CalcItemCosteCalculado(Rec, FALSE);
        MODIFY;
    end;
    procedure ActualizarImportanciaEnCoste()
    var
        BOMComponent: Record 90;
        CosteProductos: Decimal;
        AsmInfoPaneMgt: Codeunit AlxiaAssemblyInfoManagement;
        AuxItem: Record 27;
    begin
        //AGRALAMO
        //Productos
        BOMComponent.RESET;
        BOMComponent.SETRANGE("No.", Rec."No.");
        BOMComponent.SETRANGE(BOMComponent.Type, BOMComponent.Type::Item);
        IF BOMComponent.FINDSET THEN BEGIN
            REPEAT AuxItem.RESET;
                AuxItem.GET(BOMComponent."Parent Item No.");
                CosteProductos:=AsmInfoPaneMgt.CalcItemCostCalcItem(AuxItem);
                IF(CosteProductos <> 0)THEN BEGIN
                    BOMComponent."Importancia en Coste":=BOMComponent."Quantity per" * BOMComponent.CosteUnitario / CosteProductos * 100;
                END
                ELSE
                BEGIN
                    BOMComponent."Importancia en Coste":=0;
                END;
                BOMComponent.MODIFY(FALSE)UNTIL BOMComponent.NEXT = 0 END;
        //Recursos
        BOMComponent.RESET;
        BOMComponent.SETRANGE("No.", Rec."No.");
        BOMComponent.SETRANGE(BOMComponent.Type, BOMComponent.Type::Resource);
        IF BOMComponent.FINDSET THEN BEGIN
            REPEAT AuxItem.RESET;
                AuxItem.GET(BOMComponent."Parent Item No.");
                CosteProductos:=AsmInfoPaneMgt.CalcItemCostCalcResType(AuxItem, 1) + AsmInfoPaneMgt.CalcItemCostCalcResType(AuxItem, 2);
                IF(CosteProductos <> 0)THEN BEGIN
                    BOMComponent."Importancia en Coste":=BOMComponent."Quantity per" * BOMComponent.CosteUnitario / CosteProductos * 100;
                END
                ELSE
                BEGIN
                    BOMComponent."Importancia en Coste":=0;
                END;
                BOMComponent.MODIFY(FALSE);
            UNTIL BOMComponent.NEXT = 0 END;
    //AGRALAMO
    /*CosteProductos := AsmInfoPaneMgt.CalcItemCostCalcItem(Rec);
        BOMComponent.RESET;
        BOMComponent.SETRANGE("Parent Item No.", Rec."No.");
        BOMComponent.SETRANGE(BOMComponent.Type, BOMComponent.Type::Item);
        IF BOMComponent.FINDFIRST THEN
        REPEAT
          IF (CosteProductos <> 0) THEN
          BEGIN
            BOMComponent."Importancia en Coste" := BOMComponent."Quantity per" * BOMComponent.CosteUnitario / CosteProductos *100;
          END ELSE BEGIN
            BOMComponent."Importancia en Coste" := 0;
          END;
          BOMComponent.MODIFY(FALSE);
        UNTIL BOMComponent.NEXT = 0;

        CosteProductos := AsmInfoPaneMgt.CalcItemCostCalcResType(Rec, 1) + AsmInfoPaneMgt.CalcItemCostCalcResType(Rec, 2);

        BOMComponent.RESET;
        BOMComponent.SETRANGE("Parent Item No.", Rec."No.");
        BOMComponent.SETRANGE(BOMComponent.Type, BOMComponent.Type::Resource);
        IF BOMComponent.FINDFIRST THEN
        REPEAT
          IF (CosteProductos <> 0) THEN
          BEGIN
            BOMComponent."Importancia en Coste" := BOMComponent."Quantity per" * BOMComponent.CosteUnitario / CosteProductos *100;
          END ELSE BEGIN
            BOMComponent."Importancia en Coste" := 0;
          END;
          BOMComponent.MODIFY(FALSE);
        UNTIL BOMComponent.NEXT = 0;*/
    end;
    procedure ActualizarCosteEstandarLM()
    var
        BOMComponent: Record 90;
        LT_PRODUCTO: Record 27;
        LT_RECURSO: Record 156;
        AuxNo: Code[10];
        BOMComp: Record 90;
    begin
        IF Rec."No." = '' THEN EXIT;
        //AGRALAMO
        BOMComp.RESET;
        BOMComp.SETRANGE("No.", Rec."No.");
        BOMComp.SETFILTER(Type, '<>%1', BOMComp.Type::" ");
        IF BOMComp.FINDSET THEN BEGIN
            REPEAT IF BOMComp.Type = BOMComp.Type::Item THEN BEGIN
                    LT_PRODUCTO.GET(BOMComp."No.");
                    BOMComp.CosteUnitario:=LT_PRODUCTO."Standard Cost";
                END
                ELSE IF(BOMComp.Type = BOMComp.Type::Resource) AND (BOMComp."Resource Usage Type" = BOMComp."Resource Usage Type"::Direct)THEN BEGIN
                        LT_RECURSO.GET(BOMComp."No.");
                        BOMComp.CosteUnitario:=LT_RECURSO."Unit Cost";
                    END;
                BOMComp.VALIDATE(BOMComp."Quantity per");
                BOMComp.MODIFY;
            UNTIL BOMComp.NEXT = 0;
        END;
        ActualizarImportanciaEnCoste;
    //AGRALAMO
    /*BOMComp.RESET;
        BOMComp.SETRANGE("Parent Item No.",Rec."No.");
        BOMComp.SETFILTER(Type,'<>%1',BOMComp.Type::" ");
        IF BOMComp.FINDSET THEN
          REPEAT
        
            IF BOMComp.Type=BOMComp.Type::Item THEN BEGIN
              LT_PRODUCTO.GET(BOMComp."No.");
              //++ KR 06/07/21
              //BOMComp.CosteUnitario := LT_PRODUCTO."Unit Cost";     //ADV002
              //BOMComp."Importancia en Coste" := BOMComp."Quantity per" * LT_PRODUCTO."Unit Cost" / Item."Standard Cost" *100;
              BOMComp.CosteUnitario := LT_PRODUCTO."Standard Cost";     //ADV002
              //BOMComp."Importancia en Coste" := BOMComp."Quantity per" * BOMComp.CosteUnitario / Item."Standard Cost" *100;
              //--
            END ELSE IF (BOMComp.Type=BOMComp.Type::Resource) AND (BOMComp."Resource Usage Type"= BOMComp."Resource Usage Type"::Direct) THEN BEGIN
              LT_RECURSO.GET(BOMComp."No.");
              BOMComp.CosteUnitario := LT_RECURSO."Unit Cost";     //ADV002
              //BOMComp."Importancia en Coste" := BOMComp."Quantity per" * LT_RECURSO."Unit Cost"/ Item."Standard Cost" * 100;
            END;
            BOMComp.VALIDATE(BOMComp."Quantity per");
        
            //ADV002 Inicio
            //BOMComp."Coste Calculado" := BOMComp.CosteUnitario * BOMComp."Quantity per";
            BOMComp.MODIFY;
            //ADV002 Fin
        
          UNTIL BOMComp.NEXT=0;*/
    end;
    //SL Validar que no este en ningun evento
    trigger OnBeforeDelete()
    var
        RecLineaEv: Record "Lineas Evento";
        RecProductoEv: Record "Productos Evento";
        DondeEsta: Text[2048];
    begin
        RecLineaEv.Reset();
        RecLineaEv.SetRange("No.", Rec."No.");
        if RecLineaEv.FindFirst()then begin
            repeat DondeEsta:=COPYSTR(DondeEsta + ', ' + ReclineaEv."Codigo Evento", 1, 2048);
            until RecLineaEv.Next() = 0;
            Error('El producto se encuentra en/los eventos: ' + DondeEsta);
        end;
        RecProductoEv.Reset();
        RecProductoEv.SetRange("Codigo Producto", Rec."No.");
        if RecProductoEv.FindFirst()then begin
            repeat DondeEsta:=COPYSTR(DondeEsta + ', ' + RecProductoEv."Codigo Evento", 1, 2048);
            until RecProductoEv.Next() = 0;
            Error('El producto se encuentra en/los eventos: ' + DondeEsta);
        end;
    end;
    //SL BEGIN GAP00009 
    procedure ActualizarNombreReceta()
    var
        rBom: Record "BOM Component";
        rItemVariant: Record "Item Variant";
    begin
        rBom.Reset();
        rBom.SetRange(rBom."No.", "No.");
        if rBom.FindFirst()then rBom.ModifyAll(rBom.Description, Description);
        rItemVariant.Reset();
        rItemVariant.SetRange("Item No.", "No.");
        if ritemVariant.FindFirst()then rItemVariant.ModifyAll(rItemVariant.Description, Description);
    end;
    procedure ActualizarTodos()
    var
        rBom: Record "BOM Component";
        rItem: Record Item;
        rItemVariant: Record "Item Variant";
    begin
        rItem.Reset();
        if rItem.FindFirst()then repeat rBom.Reset();
                rBom.SetRange(rBom."No.", rItem."No.");
                if rBom.FindFirst()then rBom.ModifyAll(rBom.Description, rItem.Description);
                rItemVariant.Reset();
                rItemVariant.SetRange("Item No.", rItem."No.");
                if ritemVariant.FindFirst()then rItemVariant.ModifyAll(rItemVariant.Description, rItem.Description);
            until rItem.Next() = 0;
    end;
//SL END GAP00009 
}
