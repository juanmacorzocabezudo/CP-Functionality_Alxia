report 50023 AGRALAPlanificadorHDem
{
    ApplicationArea = All;
    Caption = 'Lanzar hoja de demanda';
    Description = 'Lanzar hoja de demanda';
    ProcessingOnly = true;
    ShowPrintStatus = true;
    UsageCategory = Administration;

    dataset
    {
        dataitem("Origen de pedido de venta";37)
        {
            DataItemTableView = WHERE("Document Type"=CONST(Order));

            column(Obtenerdatosdepedidos; AGRALAOrigenPedidos)
            {
            }
            column(Fechadeenvio; "Origen de pedido de venta"."Shipment Date")
            {
            }
            trigger OnAfterGetRecord()
            var
                rlCustomer: Record 18;
            begin
                IF AGRALAOrigenPedidos THEN IF("Origen de pedido de venta".Type = "Origen de pedido de venta".Type::Item)THEN BEGIN
                        rlCustomer.GET("Origen de pedido de venta"."Sell-to Customer No.");
                        AGRALAInsertarItemOrResourceHDPedidos("Origen de pedido de venta"."No.", 'Pedido venta', "Origen de pedido de venta"."Document No.", "Origen de pedido de venta".Quantity, "Origen de pedido de venta"."Shipment Date", rlCustomer."No.", "Origen de pedido de venta".Description);
                    END;
            end;
            trigger OnPreDataItem()
            begin
                if _Producto <> '' then "Origen de pedido de venta".SetRange("No.", _Producto);
                "Origen de pedido de venta".SETFILTER("Shipment Date", '%1..%2', AGRALAFiltroFechaDesde, AGRALAFiltroFechaHasta);
            end;
        }
        dataitem("Origen de evento";50004)
        {
            column(Obtenerdatosdeeventos; AGRALAOrgenEventos)
            {
            }
            column(Fechaevento; "Origen de evento"."Fecha Evento")
            {
            }
            dataitem("Lineas componente evento";50002)
            {
                DataItemLink = "Codigo Evento"=FIELD("Codigo Evento");

                trigger OnAfterGetRecord()
                var
                    rlItem: Record 27;
                begin
                    IF AGRALAOrgenEventos THEN BEGIN
                        //rlItem.GET("Lineas componente evento"."Parent Item No.");
                        AGRALAInsertarItemOrResourceHDComponente("Lineas componente evento"."No.", 'Evento', "Lineas componente evento".Linea, "Lineas componente evento"."Codigo Evento", ("Lineas componente evento".Cantidad), "Origen de evento"."Fecha Evento", ("Origen de evento"."Codigo Cliente"), "Lineas componente evento".Descripcion);
                    END;
                end;
                trigger OnPreDataItem()
                begin
                    if _Producto <> '' then "Lineas componente evento".SetRange("No.", _Producto);
                end;
            }
            dataitem("Recursos Evento";50003)
            {
                DataItemLink = "Codigo Evento"=FIELD("Codigo Evento");

                trigger OnAfterGetRecord()
                begin
                    IF AGRALAOrgenEventos THEN BEGIN
                        //rlItem.GET("Lineas componente evento"."Parent Item No.");
                        AGRALAInsertarItemOrResourceHDComponente("Recursos Evento"."Codigo Recurso", 'Evento', "Recursos Evento".Linea, "Recursos Evento"."Codigo Evento", ("Recursos Evento".Cantidad), "Origen de evento"."Fecha Evento", "Origen de evento"."Codigo Cliente", "Recursos Evento".Descripcion);
                    END;
                end;
            }
            dataitem("Productos Evento";50016)
            {
                DataItemLink = "Codigo Evento"=FIELD("Codigo Evento");

                trigger OnAfterGetRecord()
                begin
                    IF AGRALAOrgenEventos THEN BEGIN
                        //rlItem.GET("Lineas componente evento"."Parent Item No.");
                        AGRALAInsertarItemOrResourceHDComponente("Productos Evento".Producto, 'Evento', "Productos Evento".Linea, "Productos Evento"."Codigo Evento", ("Productos Evento".Cantidad), "Origen de evento"."Fecha Evento", "Origen de evento"."Codigo Cliente", "Productos Evento".Descripcion);
                    END;
                end;
                trigger OnPreDataItem()
                begin
                    if _Producto <> '' then "Productos Evento".SetRange("Codigo Producto", _Producto);
                end;
            }
            trigger OnPreDataItem()
            begin
                "Origen de evento".SETFILTER("Fecha Evento", '%1..%2', AGRALAFiltroFechaDesde, AGRALAFiltroFechaHasta);
            end;
        }
        dataitem("Assembly Header";900)
        {
            dataitem("Origen de ensamblados";901)
            {
                DataItemLink = "Document Type"=FIELD("Document Type"), "Document No."=FIELD("No.");

                column(Obtenerdatosdeensamblado; AGRALAOrigenEnsamblado)
                {
                }
                column(Fechavencimiento; "Origen de ensamblados"."Due Date")
                {
                }
                trigger OnAfterGetRecord()
                var
                    rlAssemblyHeader: Record 900;
                begin
                    IF AGRALAOrigenEnsamblado THEN BEGIN
                        rlAssemblyHeader.SETRANGE("No.", "Origen de ensamblados"."Document No.");
                        //++ AGRALA 863
                        //rlAssemblyHeader.SETFILTER("Starting Date", '%1..%2', AGRALAFiltroFechaDesde, AGRALAFiltroFechaHasta);
                        rlAssemblyHeader.SETFILTER(rlAssemblyHeader.AGRALAFechaProduccion, '%1..%2', AGRALAFiltroFechaDesde, AGRALAFiltroFechaHasta);
                        //-- AGRALA 863
                        IF rlAssemblyHeader.FINDFIRST THEN //IF ("Origen de pedido de venta".Type = "Origen de pedido de venta".Type::Item) THEN
                        BEGIN
                            //++ AGRALA 863
                            //AGRALAInsertarItemOrResourceHD("Origen de ensamblados"."No.",'Pedido Ensambado',"Origen de ensamblados"."Document No.","Origen de ensamblados".Quantity,rlAssemblyHeader."Starting Date", '', "Origen de ensamblados".Description);
                            AGRALAInsertarItemOrResourceHD("Origen de ensamblados"."No.", 'Pedido Ensambado', "Origen de ensamblados"."Document No.", "Origen de ensamblados".Quantity, rlAssemblyHeader.AGRALAFechaProduccion, '', "Origen de ensamblados".Description);
                        //-- AGRALA 863
                        //AGRALAInsertarItemOrResourceHDComponente("Origen de ensamblados"."No.",'Pedido Ensambado',"Origen de ensamblados"."Line No.","Origen de ensamblados"."Document No.",rlAssemblyHeader.Quantity,rlAssemblyHeader."Starting Date", '',
                        //"Origen de ensamblados".Description);
                        END;
                    END end;
            }
            trigger OnAfterGetRecord()
            var
                xlOrigen: Option "00 - Receta madre", "01 - Nivel", "02 - Nivel", "03 - Nivel", "04 - Nivel", "05 - Nivel";
            begin
                //AGRALAInsertarItemOrResourceHD("Assembly Header"."Item No." ,'Pedido Ensambado',"Assembly Header"."No.","Assembly Header".Quantity, "Assembly Header"."Starting Date", '', "Assembly Header".Description);
                IF AGRALAOrigenEnsamblado THEN BEGIN
                    //++ AGRALA 863
                    //AGRALAInsertarHD("Assembly Header"."Item No.",xlOrigen::"00 - Receta madre","Assembly Header"."No.","Assembly Header".Quantity,"Assembly Header"."Starting Date",'',"Assembly Header"."No.", "Assembly Header".Description);
                    AGRALAInsertarHD("Assembly Header"."Item No.", xlOrigen::"00 - Receta madre", "Assembly Header"."No.", "Assembly Header".Quantity, "Assembly Header".AGRALAFechaProduccion, '', "Assembly Header"."No.", "Assembly Header".Description);
                //-- AGRALA 863
                END;
            end;
            trigger OnPreDataItem()
            begin
                //++ AGRALA 863
                //"Assembly Header".SETFILTER("Starting Date", '%1..%2', AGRALAFiltroFechaDesde, AGRALAFiltroFechaHasta);
                if _Producto <> '' then "Assembly Header".SETRANGE("Item No.", _Producto);
                "Assembly Header".SETFILTER(AGRALAFechaProduccion, '%1..%2', AGRALAFiltroFechaDesde, AGRALAFiltroFechaHasta);
            //-- AGRALA 863
            //"Assembly Header".SETRANGE("Associated Order", FALSE);
            end;
        }
    }
    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group("Obtener recursos")
                {
                    field("Obtener datos de recursos"; AGRALAObtenerRecursos)
                    {
                        ApplicationArea = All;
                    }
                }
                group("Obtener pedidos")
                {
                    field("Obtener datos de pedidos"; AGRALAOrigenPedidos)
                    {
                        ApplicationArea = All;
                    }
                }
                group("Obtener eventos")
                {
                    field("Obetener datos de Eventos"; AGRALAOrgenEventos)
                    {
                        ApplicationArea = All;
                    }
                }
                group("Obtener Ensamblado")
                {
                    field("Obtener datos de Ensamblado"; AGRALAOrigenEnsamblado)
                    {
                        ApplicationArea = All;
                    }
                }
                group("Nombre usuario")
                {
                    Caption = 'Nombre usuario';

                    field(AGRALALibro; AGRALALibro)
                    {
                        ApplicationArea = All;
                        Caption = 'Nombre usuario';
                        TableRelation = "Requisition Wksh. Name".Name where("Worksheet Template Name"=const('APROV.'));
                    }
                }
                group(Fecha)
                {
                    field("Filtrar fecha desde"; AGRALAFiltroFechaDesde)
                    {
                        ApplicationArea = All;
                    }
                    field("Filtro fecha hasta"; AGRALAFiltroFechaHasta)
                    {
                        ApplicationArea = All;
                    }
                }
                group(Producto)
                {
                    Caption = 'Producto';

                    field(_Producto; _Producto)
                    {
                        ApplicationArea = All;
                        Caption = 'Nº Producto';
                        TableRelation = Item."No.";
                    }
                }
                group(Niveles)
                {
                    field("0 Receta madre"; AGRALAInsertar0RecetaMadre)
                    {
                        ApplicationArea = All;
                    }
                    field("1 Nivel"; AGRALAInsertar1Nivel)
                    {
                        ApplicationArea = All;
                    }
                    field("2 Nivel"; AGRALAInsertar2Nivel)
                    {
                        ApplicationArea = All;
                    }
                    field("3 Nivel"; AGRALAInsertar3Nivel)
                    {
                        ApplicationArea = All;
                    }
                    field("4 Nivel"; AGRALAInsertar4Nivel)
                    {
                        ApplicationArea = All;
                    }
                    field("5 Nivel"; AGRALAInsertar5Nivel)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }
        actions
        {
        }
    }
    labels
    {
    }
    trigger OnInitReport()
    begin
        AGRALAInsertar0RecetaMadre:=TRUE;
    end;
    trigger OnPostReport()
    begin
        //PAGE.RUN(291);
        Ventana.CLOSE;
    end;
    trigger OnPreReport()
    begin
        rgRequisitionLine.SETRANGE("Journal Batch Name", AGRALALibro);
        IF rgRequisitionLine.FINDSET THEN rgRequisitionLine.DELETEALL;
        Ventana.OPEN('El proceso se esta ejecutando por favor no cierre y mantengase a la espera.');
    end;
    var AGRALAOrigenPedidos: Boolean;
    AGRALAOrgenEventos: Boolean;
    AGRALAOrigenEnsamblado: Boolean;
    AGRALAObtenerRecursos: Boolean;
    AGRALAInsertar1Nivel: Boolean;
    rgBOMComponent: Record 90;
    rgRequisitionLine: Record 246;
    AGRALAInsertar2Nivel: Boolean;
    AGRALAInsertar3Nivel: Boolean;
    AGRALAInsertar4Nivel: Boolean;
    AGRALAInsertar5Nivel: Boolean;
    Ventana: Dialog;
    AGRALAInsertar0RecetaMadre: Boolean;
    AGRALAFiltroFechaDesde: Date;
    AGRALAFiltroFechaHasta: Date;
    AGRALALibro: Code[20];
    prequisitionline: Record 24;
    _Producto: Code[20];
    local procedure AGRALAInsertarItemOrResourceHD(pItemResourceNo: Code[20]; pOrigen: Text[20]; pNumeroOrigen: Text; pCantidad: Decimal; pfecha: Date; pCliente: Code[20]; pDescripcion: Text[250])
    var
        rlItem: Record 27;
        rlResource: Record 156;
        rlBOMComponent: Record 90;
        rlBOMComponent2: Record 90;
        rlBOMComponent3: Record 90;
        rlBOMComponent4: Record 90;
        rlBOMComponent5: Record 90;
        xlOrigen: Option "00 - Receta madre", "01 - Nivel", "02 - Nivel", "03 - Nivel", "04 - Nivel", "05 - Nivel";
    begin
        rgBOMComponent.RESET;
        rlItem.RESET;
        rlResource.RESET;
        IF rlItem.GET(pItemResourceNo)THEN BEGIN
            AGRALAInsertarHD(pItemResourceNo, xlOrigen::"01 - Nivel", pNumeroOrigen, pCantidad, pfecha, pCliente, pNumeroOrigen, pDescripcion);
            //Se pone que no calcule con BOM - andrés 22122208
            IF FALSE THEN BEGIN
                //IF AGRALAInsertar1Nivel THEN BEGIN
                rlBOMComponent.SETRANGE("Parent Item No.", rlItem."No.");
                IF rlBOMComponent.FINDSET THEN BEGIN
                    REPEAT AGRALAInsertarHD(rlBOMComponent."No.", xlOrigen::"02 - Nivel", rlBOMComponent."Parent Item No.", rlBOMComponent."Quantity per" * pCantidad, pfecha, pCliente, pNumeroOrigen, rlBOMComponent.Description);
                        IF AGRALAInsertar2Nivel THEN BEGIN
                            rlBOMComponent2.SETRANGE("Parent Item No.", rlBOMComponent."No.");
                            IF rlBOMComponent2.FINDSET THEN REPEAT AGRALAInsertarHD(rlBOMComponent2."No.", xlOrigen::"03 - Nivel", rlBOMComponent2."Parent Item No.", rlBOMComponent2."Quantity per" * rlBOMComponent."Quantity per" * pCantidad, pfecha, pCliente, pNumeroOrigen, rlBOMComponent2.Description);
                                    IF AGRALAInsertar3Nivel THEN BEGIN
                                        rlBOMComponent3.SETRANGE("Parent Item No.", rlBOMComponent2."No.");
                                        IF rlBOMComponent3.FINDSET THEN REPEAT AGRALAInsertarHD(rlBOMComponent3."No.", xlOrigen::"04 - Nivel", rlBOMComponent3."Parent Item No.", rlBOMComponent3."Quantity per" * rlBOMComponent2."Quantity per" * pCantidad, pfecha, pCliente, pNumeroOrigen, rlBOMComponent3.Description);
                                                IF AGRALAInsertar4Nivel THEN BEGIN
                                                    rlBOMComponent4.SETRANGE("Parent Item No.", rlBOMComponent3."No.");
                                                    IF rlBOMComponent4.FINDSET THEN REPEAT AGRALAInsertarHD(rlBOMComponent4."No.", xlOrigen::"05 - Nivel", rlBOMComponent4."Parent Item No.", rlBOMComponent4."Quantity per" * rlBOMComponent3."Quantity per" * pCantidad, pfecha, pCliente, pNumeroOrigen, rlBOMComponent4.Description);
                                                            IF AGRALAInsertar5Nivel THEN BEGIN
                                                                rlBOMComponent5.SETRANGE("Parent Item No.", rlBOMComponent4."No.");
                                                                IF rlBOMComponent5.FINDSET THEN REPEAT UNTIL rlBOMComponent5.NEXT() = 0;
                                                            END;
                                                        UNTIL rlBOMComponent4.NEXT() = 0;
                                                END;
                                            UNTIL rlBOMComponent3.NEXT() = 0;
                                    END;
                                UNTIL rlBOMComponent2.NEXT() = 0;
                        END;
                    UNTIL rlBOMComponent.NEXT() = 0;
                END;
            END;
        END;
    end;
    local procedure AGRALAInsertarHD(pItemResourceNo: Code[20]; pOrigen: Option "00 - Receta madre", " 01 - Nivel", "02 - Nivel", "03 - Nivel", "04 - Nivel", "05 - Nivel"; pNumeroOrigen: Text; pCantidad: Decimal; pFecha: Date; pCliente: Code[20]; pOrigenDemanda: Code[20]; pDescripcionLineas: Text[250])psalida: Boolean var
        rlItem: Record 27;
        rlResource: Record 156;
        rlBOMComponent: Record 90;
        xlResource: Boolean;
        xlItem: Boolean;
        rlRequsitionLine: Record 246;
        rlRequsitionLine2: Record 246;
        rlVendor: Record 23;
        rlCustomer: Record 18;
        rlsalesHeader: Record 36;
        rlEvento: Record 50004;
        rlAssamblyHeader: Record 900;
        blNoInsertar: Boolean;
        rlAssamblyHeader2: Record 900;
        rlAssamblyHeader3: Record 900;
        rlAssamblyHeader4: Record 900;
        recAssembleSetup: Record "Assembly Setup";
        recAssemblyLine: Record "Assembly Line";
        recCompEventos: Record "Componentes Evento";
        _StockDisponible: Decimal;
    begin
        recAssembleSetup.Reset();
        recAssembleSetup.Get();
        rgBOMComponent.RESET;
        rlItem.RESET;
        rlAssamblyHeader.RESET;
        rlResource.RESET;
        xlItem:=FALSE;
        xlResource:=FALSE;
        //Cuando proviene del primer nivel se pasa en NOrigen el producto padre.
        IF rlItem.GET(pItemResourceNo)THEN xlItem:=TRUE;
        IF rlResource.GET(pItemResourceNo)THEN IF AGRALAObtenerRecursos THEN xlResource:=TRUE
            ELSE
                EXIT(TRUE);
        rlRequsitionLine2.RESET;
        rlRequsitionLine2.SETRANGE("Journal Batch Name", AGRALALibro);
        IF rlRequsitionLine2.FINDLAST THEN;
        rlRequsitionLine.RESET;
        rlRequsitionLine.INIT;
        rlRequsitionLine."Worksheet Template Name":='APROV.';
        IF AGRALALibro = '' THEN ERROR('Por favor, debe elegir un usuario valido para lanzar la hoja de demanda');
        rlRequsitionLine.VALIDATE("Journal Batch Name", AGRALALibro);
        rlRequsitionLine."Line No.":=10000 + rlRequsitionLine2."Line No.";
        IF xlItem THEN BEGIN
            rlRequsitionLine.Type:=rlRequsitionLine.Type::Item;
        END;
        IF xlResource THEN rlRequsitionLine.Type:=rlRequsitionLine.Type::" ";
        rlRequsitionLine."No.":=pItemResourceNo;
        IF xlItem THEN BEGIN
            rlRequsitionLine.Description:=pDescripcionLineas;
            rlRequsitionLine."Unit of Measure Code":=rlItem."Base Unit of Measure";
            rlItem.CALCFIELDS(Inventory, "Qty. on Purch. Order");
            rlItem.CalcFields(AGRALAQtyAssemblyOrderLine);
            rlItem.CalcFields(AGRALAQtyOnSalesOrder);
            _StockDisponible:=rlItem.Inventory - rlItem.AGRALAQtyAssemblyOrderLine - rlItem.AGRALAQtyOnSalesOrder;
            rlRequsitionLine.AGRALAStock:=_StockDisponible;
            rlRequsitionLine.AGRALACantidadPedidosCompra:=rlItem."Qty. on Purch. Order";
            //SL Cantidad necesario segun Javier:
            //rlRequsitionLine.AGRALACantidadNecesaria := pCantidad - _StockDisponible - rlRequsitionLine.AGRALACantidadPedidosCompra;
            rlRequsitionLine.AGRALACantidadNecesaria:=((_StockDisponible - rlItem."Safety Stock Quantity") + rlRequsitionLine.AGRALACantidadPedidosCompra) - pCantidad;
            //SL end
            rlRequsitionLine.AGRALACosteEstandar:=rlItem."Standard Cost";
            rlRequsitionLine.AGRALACosteUnitario:=rlItem."Unit Cost";
            rlRequsitionLine.AGRALADiferencia:=rlItem."Standard Cost" - rlItem."Unit Cost";
            //SL Cambios Word Damian
            rlRequsitionLine."Location Code":=recAssembleSetup."Default Location for Orders";
            rlRequsitionLine.AlxDiferencia:=rlItem."Standard Cost" - rlItem."Last Direct Cost";
            rlRequsitionLine.AlxSafetyStockQuantity:=rlItem."Safety Stock Quantity";
            rlRequsitionLine.AlxLastDirectCost:=rlItem."Last Direct Cost";
            //SL Agrego la dimension global del producto
            rlRequsitionLine.AlxLineaNegocio:=rlItem."Global Dimension 1 Code";
            rlRequsitionLine."Shortcut Dimension 1 Code":=rlItem."Global Dimension 1 Code";
        //SL End
        END;
        IF xlResource THEN BEGIN
            rlRequsitionLine.Description:=rlResource.Name;
        END;
        IF(STRPOS(pOrigenDemanda, 'EV') = 1)THEN BEGIN
            rlRequsitionLine.AGRALALineaNegocio:=rlRequsitionLine.AGRALALineaNegocio::CATERING;
            rlEvento.GET(pOrigenDemanda);
            rlRequsitionLine.AGRALANombreEvenClieEns:=rlEvento.Descripcion;
            rlRequsitionLine.AGRALAProcedencia:=rlRequsitionLine.AGRALAProcedencia::EVENTO;
            //SL Marca en eventos.
            recCompEventos.Reset();
            recCompEventos.SetRange("Codigo Evento", pOrigenDemanda);
            recCompEventos.SetRange("No.", pItemResourceNo);
            if recCompEventos.FindFirst()then rlRequsitionLine."Variant Code":=COPYSTR(recCompEventos."Variant Code", 1, 10);
        END;
        IF(STRPOS(pOrigenDemanda, 'P2') = 1)THEN BEGIN
            rlAssamblyHeader.SETRANGE("No.", pOrigenDemanda);
            rlAssamblyHeader.FINDFIRST;
            IF rlAssamblyHeader.NoEvento <> '' THEN BEGIN
                rlRequsitionLine.AGRALALineaNegocio:=rlRequsitionLine.AGRALALineaNegocio::CATERING;
                rlRequsitionLine.AGRALANombreEvenClieEns:='Pedido ensamblado evento';
                rlRequsitionLine.AGRALAProcedencia:=rlRequsitionLine.AGRALAProcedencia::"PED. ENSAMBLADO EVENTO";
            END
            ELSE
            BEGIN
                rlRequsitionLine.AGRALALineaNegocio:=rlRequsitionLine.AGRALALineaNegocio::ALIMENTACIÓN;
                rlRequsitionLine.AGRALANombreEvenClieEns:='Pedido ensamblado sin evento';
                rlRequsitionLine.AGRALAProcedencia:=rlRequsitionLine.AGRALAProcedencia::"PED. ENSAMBLADO SIN ENVENTO";
            END;
            //SL Marca en pedidos ensamblados
            recAssemblyLine.Reset();
            recAssemblyLine.SetRange("Document No.", pOrigenDemanda);
            recAssemblyLine.SetRange("No.", pItemResourceNo);
            if recAssemblyLine.FindFirst()then rlRequsitionLine."Variant Code":=recAssemblyLine."Variant Code";
        END;
        IF(STRPOS(pOrigenDemanda, 'VP') = 1)THEN BEGIN
            rlRequsitionLine.AGRALALineaNegocio:=rlRequsitionLine.AGRALALineaNegocio::ALIMENTACIÓN;
            rlsalesHeader.SETRANGE("No.", pOrigenDemanda);
            rlsalesHeader.FINDFIRST;
            //SL 
            rlRequsitionLine.AGRALANombreEvenClieEns:=rlsalesHeader."Sell-to Customer Name";
            rlRequsitionLine.AGRALAProcedencia:=rlRequsitionLine.AGRALAProcedencia::"PED. VENTA";
        END;
        rlRequsitionLine.VALIDATE(Quantity, pCantidad);
        rlRequsitionLine."Vendor No.":=rlItem."Vendor No.";
        rlVendor.RESET;
        IF rlVendor.GET(rlItem."Vendor No.")THEN rlRequsitionLine.AGRALANombreProveedor:=rlVendor.Name;
        rlRequsitionLine."Due Date":=pFecha;
        IF rlCustomer.GET(pCliente)THEN rlRequsitionLine.AGRALANombreCliente:=rlCustomer.Name;
        rlRequsitionLine.AGRALATipo:=pOrigen;
        rlRequsitionLine.AGRALACodProcedencia:=pNumeroOrigen;
        rlRequsitionLine.AGRALAOrigenDemanda:=pOrigenDemanda;
        //++ Cambiamos niveles
        IF(STRPOS(pOrigenDemanda, 'P2') = 1)THEN BEGIN
            IF rlAssamblyHeader."Associated First Order No." <> '' THEN rlRequsitionLine.AGRALACodProcedencia:=rlAssamblyHeader."Associated First Order No."
            ELSE
                rlRequsitionLine.AGRALACodProcedencia:=rlRequsitionLine.AGRALAOrigenDemanda;
            IF rlAssamblyHeader."Associated Order" = TRUE THEN BEGIN
                IF rlRequsitionLine.AGRALATipo = rlRequsitionLine.AGRALATipo::"00 - Receta madre" THEN BEGIN
                    blNoInsertar:=TRUE;
                END;
                IF rlAssamblyHeader."Associated First Order No." = rlAssamblyHeader."Associated Order No." THEN BEGIN
                    AGRALASubirNiveles(rlRequsitionLine);
                END
                ELSE
                BEGIN
                    CLEAR(rlAssamblyHeader2);
                    rlAssamblyHeader2.SETRANGE("No.", rlAssamblyHeader."Associated Order No.");
                    IF rlAssamblyHeader2.FINDFIRST THEN;
                    IF rlAssamblyHeader2."Associated First Order No." = rlAssamblyHeader2."Associated Order No." THEN BEGIN
                        AGRALASubirNiveles(rlRequsitionLine);
                        AGRALASubirNiveles(rlRequsitionLine);
                    END
                    ELSE
                    BEGIN
                        CLEAR(rlAssamblyHeader3);
                        rlAssamblyHeader3.SETRANGE("No.", rlAssamblyHeader2."Associated Order No.");
                        IF rlAssamblyHeader3.FINDFIRST THEN;
                        IF rlAssamblyHeader3."Associated First Order No." = rlAssamblyHeader3."Associated Order No." THEN BEGIN
                            AGRALASubirNiveles(rlRequsitionLine);
                            AGRALASubirNiveles(rlRequsitionLine);
                            AGRALASubirNiveles(rlRequsitionLine);
                        END
                        ELSE
                        BEGIN
                            CLEAR(rlAssamblyHeader4);
                            rlAssamblyHeader4.SETRANGE("No.", rlAssamblyHeader."Associated Order No.");
                            IF rlAssamblyHeader4.FINDFIRST THEN;
                            IF rlAssamblyHeader4."Associated First Order No." = rlAssamblyHeader4."Associated Order No." THEN BEGIN
                                AGRALASubirNiveles(rlRequsitionLine);
                                AGRALASubirNiveles(rlRequsitionLine);
                                AGRALASubirNiveles(rlRequsitionLine);
                                AGRALASubirNiveles(rlRequsitionLine);
                            END;
                        END;
                    END;
                END;
            END;
        END;
        //-- cambiamos niveles
        IF rlRequsitionLine.AGRALACantidadNecesaria > 0 THEN BEGIN
            //rlRequsitionLine."Action Message" = rlRequsitionLine."Action Message"::New;
            rlRequsitionLine."Accept Action Message":=TRUE;
        END;
        IF rlRequsitionLine.AGRALATipo = rlRequsitionLine.AGRALATipo::"00 - Receta madre" THEN IF AGRALAInsertar0RecetaMadre = FALSE THEN blNoInsertar:=TRUE;
        IF rlRequsitionLine.AGRALATipo = rlRequsitionLine.AGRALATipo::"01 - Nivel" THEN IF AGRALAInsertar1Nivel = FALSE THEN blNoInsertar:=TRUE;
        IF rlRequsitionLine.AGRALATipo = rlRequsitionLine.AGRALATipo::"02 - Nivel" THEN IF AGRALAInsertar2Nivel = FALSE THEN blNoInsertar:=TRUE;
        IF rlRequsitionLine.AGRALATipo = rlRequsitionLine.AGRALATipo::"03 - Nivel" THEN IF AGRALAInsertar3Nivel = FALSE THEN blNoInsertar:=TRUE;
        IF rlRequsitionLine.AGRALATipo = rlRequsitionLine.AGRALATipo::"04 - Nivel" THEN IF AGRALAInsertar4Nivel = FALSE THEN blNoInsertar:=TRUE;
        IF rlRequsitionLine.AGRALATipo = rlRequsitionLine.AGRALATipo::"05 - Nivel" THEN IF AGRALAInsertar5Nivel = FALSE THEN blNoInsertar:=TRUE;
        IF xlResource OR xlItem THEN IF(blNoInsertar = FALSE)THEN rlRequsitionLine.INSERT;
    end;
    local procedure AGRALAInsertarItemOrResourceHDComponente(pItemResourceNo: Code[20]; pOrigen: Text[20]; pLinea: Integer; pNumeroOrigen: Text; pCantidad: Decimal; pfecha: Date; pCliente: Code[20]; pDescripcion: Text[250])
    var
        rlItem: Record 27;
        rlResource: Record 156;
        rlBOMComponent: Record 50014;
        rlBOMComponent2: Record 50014;
        rlBOMComponent3: Record 50014;
        rlBOMComponent4: Record 50014;
        rlBOMComponent5: Record 50014;
        xlOrigen: Option "00 - Receta madre", "01 - Nivel", "02 - Nivel", "03 - Nivel", "04 - Nivel", "05 - Nivel";
    begin
        rgBOMComponent.RESET;
        rlItem.RESET;
        rlResource.RESET;
        IF rlItem.GET(pItemResourceNo)THEN BEGIN
            AGRALAInsertarHD(pItemResourceNo, xlOrigen::"00 - Receta madre", pNumeroOrigen, pCantidad, pfecha, pCliente, pNumeroOrigen, pDescripcion);
            IF AGRALAInsertar1Nivel THEN BEGIN
                rlBOMComponent.SETRANGE("Parent Item No.", rlItem."No.");
                rlBOMComponent.SETRANGE("Codigo Evento", pNumeroOrigen);
                rlBOMComponent.SETRANGE("Linea Evento", pLinea);
                IF rlBOMComponent.FINDSET THEN BEGIN
                    REPEAT AGRALAInsertarHD(rlBOMComponent."No.", xlOrigen::"01 - Nivel", rlBOMComponent."Parent Item No.", rlBOMComponent."Quantity per" * pCantidad, pfecha, pCliente, pNumeroOrigen, rlBOMComponent.Description);
                        IF(AGRALAInsertar2Nivel)THEN BEGIN
                            rlBOMComponent2.SETRANGE("Parent Item No.", rlBOMComponent."No.");
                            rlBOMComponent2.SETRANGE("Codigo Evento", pNumeroOrigen);
                            rlBOMComponent2.SETRANGE("Linea Evento", pLinea);
                            IF rlBOMComponent2.FINDSET THEN REPEAT AGRALAInsertarHD(rlBOMComponent2."No.", xlOrigen::"02 - Nivel", rlBOMComponent2."Parent Item No.", rlBOMComponent2."Quantity per" * rlBOMComponent."Quantity per" * pCantidad, pfecha, pCliente, pNumeroOrigen, rlBOMComponent2.Description);
                                    IF(AGRALAInsertar3Nivel)THEN BEGIN
                                        rlBOMComponent3.SETRANGE("Parent Item No.", rlBOMComponent2."No.");
                                        rlBOMComponent3.SETRANGE("Codigo Evento", pNumeroOrigen);
                                        rlBOMComponent3.SETRANGE("Linea Evento", pLinea);
                                        IF rlBOMComponent3.FINDSET THEN REPEAT AGRALAInsertarHD(rlBOMComponent3."No.", xlOrigen::"03 - Nivel", rlBOMComponent3."Parent Item No.", rlBOMComponent3."Quantity per" * rlBOMComponent2."Quantity per" * pCantidad, pfecha, pCliente, pNumeroOrigen, rlBOMComponent3.Description);
                                                IF(AGRALAInsertar4Nivel)THEN BEGIN
                                                    rlBOMComponent4.SETRANGE("Parent Item No.", rlBOMComponent3."No.");
                                                    rlBOMComponent4.SETRANGE("Codigo Evento", pNumeroOrigen);
                                                    rlBOMComponent4.SETRANGE("Linea Evento", pLinea);
                                                    IF rlBOMComponent4.FINDSET THEN REPEAT AGRALAInsertarHD(rlBOMComponent4."No.", xlOrigen::"04 - Nivel", rlBOMComponent4."Parent Item No.", rlBOMComponent4."Quantity per" * rlBOMComponent3."Quantity per" * pCantidad, pfecha, pCliente, pNumeroOrigen, rlBOMComponent4.Description);
                                                            IF(AGRALAInsertar5Nivel)THEN BEGIN
                                                                rlBOMComponent5.SETRANGE("Parent Item No.", rlBOMComponent4."No.");
                                                                rlBOMComponent5.SETRANGE("Codigo Evento", pNumeroOrigen);
                                                                rlBOMComponent5.SETRANGE("Linea Evento", pLinea);
                                                                IF rlBOMComponent5.FINDSET THEN REPEAT AGRALAInsertarHD(rlBOMComponent5."No.", xlOrigen::"05 - Nivel", rlBOMComponent5."Parent Item No.", rlBOMComponent5."Quantity per" * rlBOMComponent4."Quantity per" * pCantidad, pfecha, pCliente, pNumeroOrigen, rlBOMComponent5.Description);
                                                                    UNTIL rlBOMComponent5.NEXT() = 0;
                                                            END;
                                                        UNTIL rlBOMComponent4.NEXT() = 0;
                                                END;
                                            UNTIL rlBOMComponent3.NEXT() = 0;
                                    END;
                                UNTIL rlBOMComponent2.NEXT() = 0;
                        END;
                    UNTIL rlBOMComponent.NEXT() = 0;
                END;
            END;
        END;
    end;
    local procedure AGRALAInsertarItemOrResourceHDPedidos(pItemResourceNo: Code[20]; pOrigen: Text[20]; pNumeroOrigen: Text; pCantidad: Decimal; pfecha: Date; pCliente: Code[20]; pDescripcion: Text[250])
    var
        rlItem: Record 27;
        rlResource: Record 156;
        rlBOMComponent: Record 90;
        rlBOMComponent2: Record 90;
        rlBOMComponent3: Record 90;
        rlBOMComponent4: Record 90;
        rlBOMComponent5: Record 90;
        xlOrigen: Option "00 - Receta madre", "01 - Nivel", "02 - Nivel", "03 - Nivel", "04 - Nivel", "05 - Nivel";
    begin
        rgBOMComponent.RESET;
        rlItem.RESET;
        rlResource.RESET;
        IF rlItem.GET(pItemResourceNo)THEN BEGIN
            AGRALAInsertarHD(pItemResourceNo, xlOrigen::"00 - Receta madre", pNumeroOrigen, pCantidad, pfecha, pCliente, pNumeroOrigen, pDescripcion);
            IF AGRALAInsertar1Nivel THEN BEGIN
                rlBOMComponent.SETRANGE("Parent Item No.", rlItem."No.");
                IF rlBOMComponent.FINDSET THEN BEGIN
                    REPEAT AGRALAInsertarHD(rlBOMComponent."No.", xlOrigen::"01 - Nivel", rlBOMComponent."Parent Item No.", rlBOMComponent."Quantity per" * pCantidad, pfecha, pCliente, pNumeroOrigen, rlBOMComponent.Description);
                        IF AGRALAInsertar2Nivel THEN BEGIN
                            rlBOMComponent2.SETRANGE("Parent Item No.", rlBOMComponent."No.");
                            IF rlBOMComponent2.FINDSET THEN REPEAT AGRALAInsertarHD(rlBOMComponent2."No.", xlOrigen::"02 - Nivel", rlBOMComponent2."Parent Item No.", rlBOMComponent2."Quantity per" * rlBOMComponent."Quantity per" * pCantidad, pfecha, pCliente, pNumeroOrigen, rlBOMComponent2.Description);
                                    IF AGRALAInsertar3Nivel THEN BEGIN
                                        rlBOMComponent3.SETRANGE("Parent Item No.", rlBOMComponent2."No.");
                                        IF rlBOMComponent3.FINDSET THEN REPEAT AGRALAInsertarHD(rlBOMComponent3."No.", xlOrigen::"03 - Nivel", rlBOMComponent3."Parent Item No.", rlBOMComponent3."Quantity per" * rlBOMComponent2."Quantity per" * pCantidad, pfecha, pCliente, pNumeroOrigen, rlBOMComponent3.Description);
                                                IF AGRALAInsertar4Nivel THEN BEGIN
                                                    rlBOMComponent4.SETRANGE("Parent Item No.", rlBOMComponent3."No.");
                                                    IF rlBOMComponent4.FINDSET THEN REPEAT AGRALAInsertarHD(rlBOMComponent4."No.", xlOrigen::"04 - Nivel", rlBOMComponent4."Parent Item No.", rlBOMComponent4."Quantity per" * rlBOMComponent3."Quantity per" * pCantidad, pfecha, pCliente, pNumeroOrigen, rlBOMComponent4.Description);
                                                            IF AGRALAInsertar5Nivel THEN BEGIN
                                                                rlBOMComponent5.SETRANGE("Parent Item No.", rlBOMComponent4."No.");
                                                                IF rlBOMComponent5.FINDSET THEN REPEAT AGRALAInsertarHD(rlBOMComponent5."No.", xlOrigen::"05 - Nivel", rlBOMComponent5."Parent Item No.", rlBOMComponent5."Quantity per" * rlBOMComponent5."Quantity per" * pCantidad, pfecha, pCliente, pNumeroOrigen, rlBOMComponent5.Description);
                                                                    UNTIL rlBOMComponent5.NEXT() = 0;
                                                            END;
                                                        UNTIL rlBOMComponent4.NEXT() = 0;
                                                END;
                                            UNTIL rlBOMComponent3.NEXT() = 0;
                                    END;
                                UNTIL rlBOMComponent2.NEXT() = 0;
                        END;
                    UNTIL rlBOMComponent.NEXT() = 0;
                END;
            END;
        END;
    end;
    local procedure AGRALASubirNiveles(var rlRequisitionLine: Record 246)
    begin
        IF rlRequisitionLine.AGRALATipo = rlRequisitionLine.AGRALATipo::"04 - Nivel" THEN rlRequisitionLine.AGRALATipo:=rlRequisitionLine.AGRALATipo::"05 - Nivel";
        IF rlRequisitionLine.AGRALATipo = rlRequisitionLine.AGRALATipo::"03 - Nivel" THEN rlRequisitionLine.AGRALATipo:=rlRequisitionLine.AGRALATipo::"04 - Nivel";
        IF rlRequisitionLine.AGRALATipo = rlRequisitionLine.AGRALATipo::"02 - Nivel" THEN rlRequisitionLine.AGRALATipo:=rlRequisitionLine.AGRALATipo::"03 - Nivel";
        IF rlRequisitionLine.AGRALATipo = rlRequisitionLine.AGRALATipo::"01 - Nivel" THEN rlRequisitionLine.AGRALATipo:=rlRequisitionLine.AGRALATipo::"02 - Nivel";
        IF rlRequisitionLine.AGRALATipo = rlRequisitionLine.AGRALATipo::"00 - Receta madre" THEN rlRequisitionLine.AGRALATipo:=rlRequisitionLine.AGRALATipo::"01 - Nivel";
    end;
}
