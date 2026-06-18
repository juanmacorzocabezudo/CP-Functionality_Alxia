report 50013 "Factura Imp. por Capitulo Dtl"
{
    ApplicationArea = Basic, Suite;
    Caption = 'Factura - Impresión por Capitulo Detallado';
    DefaultRenderingLayout = ImpresionPorCapituloDetallado;

    dataset
    {
        dataitem(CompanyInfo; "Company Information")
        {
            DataItemTableView = sorting("Primary Key");

            column(CompanyInfoPicture; CompanyInfo.Picture)
            {
            }
            column(CompanyAddr1; CompanyAddr[1])
            {
            }
            column(CompanyAddr2; CompanyAddr[2])
            {
            }
            column(CompanyAddr3; CompanyAddr[3])
            {
            }
            column(CompanyAddr4; CompanyAddr[4])
            {
            }
            column(CompanyAddr5; CompanyAddr[5])
            {
            }
            column(CompanyAddr6; CompanyAddr[6])
            {
            }
            column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfoVATRegistrationNo; CompanyInfo."VAT Registration No.")
            {
            }
            column(CompanyInfoEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyInfoFaxNo; CompanyInfo."Fax No.")
            {
            }
            column(NumerarPaginas; NumerarPaginasLbl)
            {
            }
            column(Fact_CIFNIF; Factura."VAT Registration No.")
            {
            }
            column(Fact_Referencia; Factura."Your Reference")
            {
            }
            column(Fact_No_; Factura."No.")
            {
            }
            column(Fact_NroDocumentoExterno; Factura."External Document No.")
            {
            }
            column(Fact_FechaVencimiento; Factura."Due Date")
            {
            }
            column(Fact_FechaEmision; Factura."Document Date")
            {
            }
            column(Fact_TerminoPago; DescripcionTerminoPago(Factura."Payment Terms Code"))
            {
            }
            column(Fact_MetodoPago; DescripcionMetodoPago(Factura."Payment Method Code"))
            {
            }
            column(Fact_CriterioCaja; MostrarCriteriosDeCaja(Factura."No."))
            {
            }
            column(Fact_Cobrado; Factura.Cobrado)
            {
            }
            column(Fact_CuentaBanco; NroCuentaBanco(Factura))
            {
            }
            column(DirecCliente1; DirecCliente[1])
            {
            }
            column(DirecCliente2; DirecCliente[2])
            {
            }
            column(DirecCliente3; DirecCliente[3])
            {
            }
            column(DirecCliente4; DirecCliente[4])
            {
            }
            column(DirecCliente5; DirecCliente[5])
            {
            }
            column(DirecCliente6; DirecCliente[6])
            {
            }
            column(DirecCliente7; DirecCliente[7])
            {
            }
            column(DirecCliente8; DirecCliente[8])
            {
            }
            column(Evento_Nro; Factura.NoEvento)
            {
            }
            column(Ivas_Total; IvaTotal)
            {
            }
            column(Ivas_ImportePendiente; ImportePendiente)
            {
            }
            column(Ivas_EsSenalizado; EsSenalizado)
            {
            }
            column(TotalFactura_SubTotalImporte; TotFact_ImpBase)
            {
            }
            column(TotalFactura_IVA; TotFact_ImpIva)
            {
            }
            column(TotalFactura_TotalImporte; TotFact_ImpInclIva)
            {
            }
            column(TotalFactura_ImpPdte; TotFact_ImpPdte)
            {
            }
            column(InfoEmp_TextoClausula; Clausula_alx)
            {
            }
            column(InfoEmp_TextoBusinessRegister; Business_Register_Text_alx)
            {
            }
            trigger OnAfterGetRecord()
            begin
                CompanyInfo.CALCFIELDS(Picture);
                FormatAddr.Company(CompanyAddr, CompanyInfo);
                ObtenerDireccionCliente(Factura."Sell-to Customer No.");
            end;
        }
        dataitem(Extras; "Lineas Evento")
        {
            DataItemTableView = sorting("Codigo Evento", Linea)where(Tipo=filter(Otros));

            column(Extras_Capitulo; ImprCapitulo)
            {
            }
            column(Extras_No_; "No.")
            {
            }
            column(Extras_Descripcion; Descripcion)
            {
            }
            column(Extras_Cantidad; Cantidad)
            {
            }
            column(Extras_Importe; Importe)
            {
            }
            column(Extras_Mostrar; Evento."Oferta Mes Sin IVA")
            {
            }
            trigger OnPreDataItem()
            begin
                if Filtro_NroEvento <> '' then SetRange("Codigo Evento", Filtro_NroEvento);
            end;
        }
        dataitem(Capitulo; "Lineas Evento")
        {
            DataItemTableView = sorting("Codigo Evento");

            column(LineaEvento_Capitulo; ImprCapitulo)
            {
            }
            column(EventoCapitulo_Importe; CalcularImportes(ImprCapitulo))
            {
            }
            dataitem(SubCapitulo; "Lineas Evento")
            {
                DataItemLinkReference = Capitulo;
                DataItemLink = "Codigo Evento"=field("Codigo Evento"), ImprCapitulo=field(ImprCapitulo);
                DataItemTableView = sorting("Codigo Evento");

                column(LineaEvento_Linea; Linea)
                {
                }
                column(LineaEvento_SubCapitulo; DescripCapitulo)
                {
                }
                dataitem(Lineas; "Lineas Evento")
                {
                    DataItemLinkReference = SubCapitulo;
                    DataItemLink = "Codigo Evento"=field("Codigo Evento"), ImprCapitulo=field(ImprCapitulo), DescripCapitulo=field(DescripCapitulo), Linea=field(Linea);
                    DataItemTableView = sorting("Codigo Evento", Linea);

                    column(LineasEvento_No; "No.")
                    {
                    }
                    column(LineasEvento_Descripcion; Descripcion)
                    {
                    }
                    column(LineasEvento_Cantidad; Cantidad)
                    {
                    }
                    column(LineasEvento_PrecioReal; "Precio Real")
                    {
                    DecimalPlaces = 2: 3;
                    }
                    column(LineasEvento_Importe; Importe)
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        IvaTotal:=0;
                    end;
                }
                dataitem(LineasComentarios; "Lineas Evento")
                {
                    DataItemLinkReference = SubCapitulo;
                    DataItemLink = "Codigo Evento"=field("Codigo Evento"), ImprCapitulo=field(ImprCapitulo), DescripCapitulo=field(DescripCapitulo);
                    DataItemTableView = sorting("Codigo Evento", Linea);

                    column(LineasEvento_Comentario; Comentarios)
                    {
                    }
                    trigger OnPreDataItem()
                    begin
                        if not Filtro_MostrarCom then CurrReport.Break();
                    end;
                    trigger OnAfterGetRecord()
                    begin
                        IvaTotal:=0;
                    end;
                }
            }
            trigger OnPreDataItem()
            begin
                if Filtro_NroEvento <> '' then SetRange("Codigo Evento", Filtro_NroEvento);
            end;
        }
        dataitem(Pan; "Productos Evento")
        {
            DataItemTableView = sorting("Codigo Evento", Tipo, Linea);

            column(Pan_Capitulo; ImprCapitulo)
            {
            }
            dataitem(LineasPan; "Productos Evento")
            {
                DataItemLinkReference = Pan;
                DataItemLink = "Codigo Evento"=field("Codigo Evento"), Tipo=field(Tipo);
                DataItemTableView = sorting("Codigo Evento", Tipo, Linea);

                column(LineaPan_Producto; Producto)
                {
                }
                column(LineaPan_Descripcion; Descripcion)
                {
                }
                column(LineaPan_Cantidad; Cantidad)
                {
                }
                column(LineaPan_PrecioReal; "Precio Real")
                {
                }
                column(LineaPan_Importe; Importe)
                {
                }
            }
            dataitem(ComentariosPan; "Productos Evento")
            {
                DataItemLinkReference = Pan;
                DataItemLink = "Codigo Evento"=field("Codigo Evento"), Tipo=field(Tipo);
                DataItemTableView = sorting("Codigo Evento", Tipo, Linea);

                column(ComentarioPan_Comentarios; Comentarios)
                {
                }
                trigger OnPreDataItem()
                begin
                    if not Filtro_MostrarCom then CurrReport.Break();
                end;
            }
            trigger OnPreDataItem()
            begin
                SetRange(Tipo, Tipo::Pan);
                SetRange("Codigo Evento", Filtro_NroEvento);
            end;
        }
        dataitem(Menaje; "Productos Evento")
        {
            DataItemTableView = sorting("Codigo Evento", Tipo, Linea);

            column(Menaje_Capitulo; ImprCapitulo)
            {
            }
            dataitem(LineasMenaje; "Productos Evento")
            {
                DataItemLinkReference = Menaje;
                DataItemLink = "Codigo Evento"=field("Codigo Evento"), Tipo=field(Tipo);
                DataItemTableView = sorting("Codigo Evento", Tipo, Linea);

                column(LineaMenaje_Producto; Producto)
                {
                }
                column(LineaMenaje_Descripcion; Descripcion)
                {
                }
                column(LineaMenaje_Cantidad; Cantidad)
                {
                }
                column(LineaMenaje_PrecioReal; "Precio Real")
                {
                }
                column(LineaMenaje_Importe; Importe)
                {
                }
            }
            dataitem(ComentariosMenaje; "Productos Evento")
            {
                DataItemLinkReference = Menaje;
                DataItemLink = "Codigo Evento"=field("Codigo Evento"), Tipo=field(Tipo);
                DataItemTableView = sorting("Codigo Evento", Tipo, Linea);

                column(ComentarioMenaje_Comentarios; Comentarios)
                {
                }
                trigger OnPreDataItem()
                begin
                    if not Filtro_MostrarCom then CurrReport.Break();
                end;
            }
            trigger OnPreDataItem()
            begin
                SetRange(Tipo, Tipo::Menaje);
                SetRange("Codigo Evento", Filtro_NroEvento);
            end;
        }
        dataitem(Personal; "Recursos Evento")
        {
            DataItemTableView = sorting("Codigo Evento", Tipo, Linea);

            column(Personal_Capitulo; ImprCapitulo)
            {
            }
            dataitem(LineasPersonal; "Recursos Evento")
            {
                DataItemLinkReference = Personal;
                DataItemLink = "Codigo Evento"=field("Codigo Evento"), Tipo=field(Tipo);
                DataItemTableView = sorting("Codigo Evento", Tipo, Linea);

                column(LineasPersonal_Recurso; "Codigo Recurso")
                {
                }
                column(LineasPersonal_Descripcion; Descripcion)
                {
                }
                column(LineasPersonal_Cantidad; Cantidad)
                {
                }
                column(LineasPersonal_PrecioReal; "Precio Real")
                {
                }
                column(LineasPersonal_Importe; Importe)
                {
                }
            }
            dataitem(ComentariosPersonal; "Recursos Evento")
            {
                DataItemLinkReference = Personal;
                DataItemLink = "Codigo Evento"=field("Codigo Evento"), Tipo=field(Tipo);
                DataItemTableView = sorting("Codigo Evento", Tipo, Linea);

                column(ComentariosPersonal_Comentarios; Comentarios)
                {
                }
                trigger OnPreDataItem()
                begin
                    if not Filtro_MostrarCom then CurrReport.Break();
                end;
            }
            trigger OnPreDataItem()
            begin
                SetRange(Tipo, Tipo::Personal);
                SetRange("Codigo Evento", Filtro_NroEvento);
            end;
        }
        dataitem(Transporte; "Recursos Evento")
        {
            DataItemTableView = sorting("Codigo Evento", Tipo, Linea);

            column(Transporte_Capitulo; ImprCapitulo)
            {
            }
            dataitem(LineasTransporte; "Recursos Evento")
            {
                DataItemLinkReference = Transporte;
                DataItemLink = "Codigo Evento"=field("Codigo Evento"), Tipo=field(Tipo);
                DataItemTableView = sorting("Codigo Evento", Tipo, Linea);

                column(LineasTransporte_Recurso; "Codigo Recurso")
                {
                }
                column(LineasTransporte_Descripcion; Descripcion)
                {
                }
                column(LineasTransporte_Cantidad; Cantidad)
                {
                }
                column(LineasTransporte_PrecioReal; "Precio Real")
                {
                }
                column(LineasTransporte_Importe; Importe)
                {
                }
            }
            dataitem(ComentariosTransporte; "Recursos Evento")
            {
                DataItemLinkReference = Transporte;
                DataItemLink = "Codigo Evento"=field("Codigo Evento"), Tipo=field(Tipo);
                DataItemTableView = sorting("Codigo Evento", Tipo, Linea);

                column(ComentariosTransporte_Comentarios; Comentarios)
                {
                }
                trigger OnPreDataItem()
                begin
                    if not Filtro_MostrarCom then CurrReport.Break();
                end;
            }
            trigger OnPreDataItem()
            begin
                SetRange(Tipo, Tipo::Otros);
                SetRange("Codigo Evento", Filtro_NroEvento);
            end;
        }
        dataitem(Suplementos; "Productos Evento")
        {
            DataItemTableView = sorting("Codigo Evento", Tipo, Linea);

            column(Suplementos_Capitulo; ImprCapitulo)
            {
            }
            dataitem(LineasSuplementos; "Productos Evento")
            {
                DataItemLinkReference = Suplementos;
                DataItemLink = "Codigo Evento"=field("Codigo Evento"), Tipo=field(Tipo);
                DataItemTableView = sorting("Codigo Evento", Tipo, Linea);

                column(LineaSuplementos_Producto; Producto)
                {
                }
                column(LineaSuplementos_Descripcion; Descripcion)
                {
                }
                column(LineaSuplementos_Cantidad; Cantidad)
                {
                }
                column(LineaSuplementos_PrecioReal; "Precio Real")
                {
                }
                column(LineaSuplementos_Importe; Importe)
                {
                }
            }
            dataitem(ComentariosSuplementos; "Productos Evento")
            {
                DataItemLinkReference = Suplementos;
                DataItemLink = "Codigo Evento"=field("Codigo Evento"), Tipo=field(Tipo);
                DataItemTableView = sorting("Codigo Evento", Tipo, Linea);

                column(ComentarioSuplementos_Comentarios; Comentarios)
                {
                }
                trigger OnPreDataItem()
                begin
                    if not Filtro_MostrarCom then CurrReport.Break();
                end;
            }
            trigger OnPreDataItem()
            begin
                SetRange(Tipo, Tipo::Suplementos);
                SetRange("Codigo Evento", Filtro_NroEvento);
            end;
        }
        dataitem(Totales; "Lineas Evento")
        {
            DataItemTableView = sorting("Codigo Evento", Linea);

            column(Totales_Capitulo; ImprCapitulo)
            {
            }
            column(Totales_Importe; StrSubstNo(TotalDetalleLbl, Format(TotalPorMenu + CalcularTotalImportesExtras(), 0, '<Precision,2:2><Standard Format,0>'), TotalIva))
            {
            }
            trigger OnPreDataItem()
            begin
                SetRange("Codigo Evento", Filtro_NroEvento);
            end;
            trigger OnAfterGetRecord()
            begin
                TotalPorMenu:=0;
                TotalIva:=0;
                if CalcularTotalMenu(ImprCapitulo) <> 0 then begin
                    if Totales.CantidadComensales <> 0 then TotalPorMenu:=(CalcularTotalMenu(ImprCapitulo) / Totales.CantidadComensales);
                end;
                if not Evento."Oferta Mes Sin IVA" then TotalIva:="% IVA";
            end;
        }
        dataitem(TotalIvas; Integer)
        {
            DataItemTableView = sorting(Number)order(descending);

            column(TotalIvas_Identificador; TempTotalIvas."VAT Identifier")
            {
            }
            column(TotalIvas_Iva_; TempTotalIvas."VAT %")
            {
            }
            column(TotalIvas_RE_; TempTotalIvas."EC %")
            {
            }
            column(TotalIvas_ImporteLinea; TempTotalIvas."Line Amount")
            {
            }
            column(TotalIvas_DsctoBaseFactura; TempTotalIvas."Inv. Disc. Base Amount")
            {
            }
            column(TotalIvas_DsctoFactura; TempTotalIvas."Invoice Discount Amount")
            {
            }
            column(TotalIvas_BaseIva; TempTotalIvas."VAT Base")
            {
            }
            column(TotalIvas_ImporteIva; TempTotalIvas."VAT Amount")
            {
            }
            column(TotalIvas_ImporteRe; TempTotalIvas."EC Amount")
            {
            }
            trigger OnPreDataItem()
            begin
                TempTotalIvas.Reset();
                TempTotalIvas.SetCurrentKey("VAT %", "EC %");
                SetRange(Number, 1, TempTotalIvas.Count());
            end;
            trigger OnAfterGetRecord()
            begin
                if Number = 1 then TempTotalIvas.FindSet()
                else
                    TempTotalIvas.Next();
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Control50000)
                {
                    Caption = 'Opciones';

                    field("Mostrar Comentario"; Filtro_MostrarCom)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Mostrar comentario';
                    }
                }
                group(Control50001)
                {
                    Caption = 'Filtro: Evento';

                    field("Nro. Evento"; Filtro_NroEvento)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'N° evento';
                        TableRelation = Evento;
                    }
                }
            }
        }
        actions
        {
        }
    }
    rendering
    {
        layout(ImpresionPorCapituloDetallado)
        {
            Type = RDLC;
            Caption = 'Factura - Impresión por Capitulo Detallado';
            LayoutFile = './src/Layout/50013.FacturaImpresionPorCapituloDetallado.rdl';
            Summary = './src/Layout/50013.FacturaImpresionPorCapituloDetallado.rdl';
        }
    }
    labels
    {
    Lbl_Pedido='Pedido';
    Lbl_Presupuesto='Presupuesto';
    CifNif_Caption='CIF/NIF: ';
    NroTelefono_Caption='N° teléfono: ';
    NroFax_Caption='N° fax: ';
    EMail_Caption='E-Mail: ';
    // Etiquetas de la cabecera
    Factura_Caption='Factura';
    CIFNIFFact_Caption='CIF/NIF';
    SuNtraRef_Caption='Su/Ntra. ref.';
    NroFactura_Caption='N° Factura';
    NroDocExt_Caption='N° documento externo';
    FecVenc_Caption='Fecha vencimiento';
    FecEmiDoc_Caption='Fecha emisión documento';
    TermPago_Caption='Condiciones pago';
    FormaPago_Caption='Forma pago';
    NroCuenta_Caption='N° Cuenta';
    // Títulos del detalle
    EventoNro_Caption='Evento N°';
    LblReferencia='Marca / Referencia';
    LblDescripcion='Descripción';
    LblCantidad='Cantidad';
    LblPrecio='Precio';
    LblImporte='Importe';
    // Títulos del total
    Lbl_Base='Base Imponible';
    Lbl_IVA='% IVA';
    Lbl_ImporteIVA='Importe IVA';
    Lbl_TotalParcial='Total Parcial';
    Lbl_ImpPendiente='Importe Pendiente';
    // Etiquetas del total del detalle
    SubTotal_Caption='Total EUR IVA+RE excl.';
    ImpIVA_Caption='Importe IVA';
    Total_Caption='Total EUR IVA';
    Texto_Caption='Especificaciones importe IVA';
    IVA_Caption='IVA';
    pIVA_Caption='% IVA';
    pRE_Caption='% RE';
    ImpLinea_Caption='Importe línea';
    ImpBseDtoFact_Caption='Importe base dto. factura';
    DsctosFactPag_Caption='Descuentos factura y pagos';
    BseIvaRe_Caption='Base IVA + RE';
    ImpRE_Caption='Importe RE';
    ImportePendiente='Importe pendiente';
    // Pie de página
    Lbl_Numeracion='Página %1 de %2', Locked = true;
    TextoPiePagina='LA FALTA DE PAGO DE ESTA FACTURA EN EL PLAZO DE VENCIMIENTO ESTABLECIDO GENERARA UN 2% MENSUAL EN CONCEPTO DE INTERESES DE DEMORA.';
    }
    trigger OnPreReport()
    begin
        IvaTotal:=0;
        ImportePendiente:=0;
        Factura.Get(Filtro_NroFactura);
        LlenarTotalIVAs();
        Calcular_TotalFactura();
        ObtenerEvento(Filtro_NroEvento);
    end;
    procedure ConfigurarFiltros(NuevoNroFactura: Code[20]; NuevoNroEvento: Code[20]; NuevoMostrarCom: Boolean)
    begin
        Filtro_NroFactura:=NuevoNroFactura;
        Filtro_NroEvento:=NuevoNroEvento;
        Filtro_MostrarCom:=NuevoMostrarCom;
    end;
    var // Filtros
    Filtro_MostrarCom: Boolean;
    Filtro_NroEvento: Code[20];
    Filtro_NroFactura: Code[20];
    // Variables
    Factura: Record "Sales Invoice Header";
    Evento: Record Evento;
    #pragma warning disable AL0432
    TempTotalIvas: Record "VAT Amount Line" temporary;
    #pragma warning restore AL0432
    FormatAddr: Codeunit "Format Address";
    TotFact_ImpBase: Decimal;
    TotFact_ImpIva: Decimal;
    TotFact_ImpInclIva: Decimal;
    TotFact_ImpPdte: Decimal;
    IvaTotal: Decimal;
    ImportePendiente: Decimal;
    TotalPorMenu: Decimal;
    TotalIva: Decimal;
    EsSenalizado: Boolean;
    NumerarPaginasLbl: Label 'Página %1 of %2', Locked = true;
    TotalDetalleLbl: Label '%1 € + %2% IVA', Locked = true;
    CompanyAddr: array[8]of Text[50];
    DirecCliente: array[8]of Text[50];
    local procedure DescripcionTerminoPago(CodTermPago: Code[10]): Text var
        Termino: Record "Payment Terms";
    begin
        if Termino.Get(CodTermPago)then exit(Termino.Description);
        exit('');
    end;
    local procedure DescripcionMetodoPago(CodMetPago: Code[10]): Text var
        Metodo: Record "Payment Method";
    begin
        if Metodo.Get(CodMetPago)then exit(Metodo.Description);
        exit('');
    end;
    local procedure ObtenerDireccionCliente(NroCliente: Code[20])
    var
        Formato: Codeunit "Format Address";
        Cliente: Record Customer;
    begin
        Cliente.Get(NroCliente);
        Formato.Customer(DirecCliente, Cliente);
    end;
    local procedure MostrarCriteriosDeCaja(NroFactura: Code[20]): Text var
        MovIVA: Record "VAT Entry";
        ConfCont: Record "General Ledger Setup";
        TieneCriterio: Boolean;
        Criterio: Label 'Special cash basis accounting regime', Comment = 'ESP="Régimen especial del criterio de caja"';
    begin
        ConfCont.Get();
        if not ConfCont."Unrealized VAT" then exit;
        TieneCriterio:=false;
        MovIVA.SetRange("Document No.", NroFactura);
        MovIVA.SetRange("Document Type", MovIVA."Document Type"::Invoice);
        if MovIVA.FindSet()then repeat if MovIVA."VAT Cash Regime" then TieneCriterio:=true;
            until MovIVA.Next() = 0;
        if TieneCriterio then exit(Criterio);
        exit('');
    end;
    local procedure NroCuentaBanco(Rec: Record "Sales Invoice Header"): Text var
        Metodo: Record "Payment Method";
        Banco: Record "Bank Account";
    begin
        if Metodo.Get(Rec."Payment Method Code")then if Metodo.BancoImpresionVentasMigr = Metodo.BancoImpresionVentasMigr::Empresa then if Rec.CodBancoEmpresaMigr <> '' then begin
                    if Banco.Get(Rec.CodBancoEmpresaMigr)then exit(Banco.IBAN + '-' + Banco."SWIFT Code");
                end
                else
                begin
                    if Banco.Get(Rec."Company Bank Account Code")then exit(Banco.IBAN + '-' + Banco."SWIFT Code");
                end;
        exit('');
    end;
    local procedure CalcularImportes(Capitulo: Code[20]): Decimal var
        Menus: Record "Lineas Evento";
    begin
        Menus.Reset();
        Menus.SetRange("Codigo Evento", Filtro_NroEvento);
        Menus.SetRange(ImprCapitulo, Capitulo);
        Menus.CalcSums(Importe);
        exit(Menus.Importe);
    end;
    local procedure CalcularTotalMenu(Capitulo: Code[20]): Decimal var
        Menus: Record "Lineas Evento";
    begin
        Menus.Reset();
        Menus.SetRange("Codigo Evento", Filtro_NroEvento);
        Menus.SetRange(ImprCapitulo, Capitulo);
        Menus.CalcSums(Importe);
        exit(Menus.Importe);
    end;
    local procedure LlenarTotalIVAs()
    var
        ConfCont: Record "General Ledger Setup";
        LineasFact: Record "Sales Invoice Line";
        LineasEvnt: Record "Lineas Evento";
        ConfVnta: Record "Sales & Receivables Setup";
        ConfIVA: Record "VAT Posting Setup";
    begin
        LineasFact.Reset();
        LineasFact.SetRange("Document No.", Factura."No.");
        LineasFact.SetFilter("Line Amount", '<>%1', 0);
        if LineasFact.FindSet()then repeat if ConfIVA.Get(LineasFact."VAT Bus. Posting Group", LineasFact."VAT Prod. Posting Group")then begin
                    TempTotalIvas.Reset();
                    TempTotalIvas.SetRange("VAT Identifier", LineasFact."VAT Identifier");
                    TempTotalIvas.SetRange("VAT Calculation Type", LineasFact."VAT Calculation Type");
                    TempTotalIvas.SetRange("Tax Group Code", LineasFact."Tax Group Code");
                    if not TempTotalIvas.FindFirst()then begin
                        TempTotalIvas.Init();
                        TempTotalIvas."VAT Identifier":=LineasFact."VAT Identifier";
                        TempTotalIvas."VAT Calculation Type":=LineasFact."VAT Calculation Type";
                        TempTotalIvas."Tax Group Code":=LineasFact."Tax Group Code";
                        TempTotalIvas."VAT %":=ConfIVA."VAT %";
                        TempTotalIvas."EC %":=ConfIVA."EC %";
                        TempTotalIvas."VAT Base":=LineasFact.Amount;
                        TempTotalIvas."Amount Including VAT":=LineasFact."Amount Including VAT";
                        TempTotalIvas."Line Amount":=LineasFact."Line Amount";
                        TempTotalIvas."Pmt. Discount Amount":=LineasFact."Pmt. Discount Amount";
                        if LineasFact."Allow Invoice Disc." then TempTotalIvas."Inv. Disc. Base Amount":=LineasFact."Line Amount";
                        TempTotalIvas."Invoice Discount Amount":=LineasFact."Inv. Discount Amount";
                        TempTotalIvas.SetCurrencyCode(Factura."Currency Code");
                        TempTotalIvas."VAT Difference":=LineasFact."VAT Difference";
                        TempTotalIvas."EC Difference":=LineasFact."EC Difference";
                        if Factura."Prices Including VAT" then TempTotalIvas."Prices Including VAT":=true;
                        TempTotalIvas."VAT Clause Code":=LineasFact."VAT Clause Code";
                        TempTotalIvas.Insert();
                    end
                    else
                    begin
                        TempTotalIvas."VAT Base"+=LineasFact.Amount;
                        TempTotalIvas."Amount Including VAT"+=LineasFact."Amount Including VAT";
                        TempTotalIvas."VAT Amount"+=TempTotalIvas."Amount Including VAT" - TempTotalIvas."VAT Base";
                        TempTotalIvas."Line Amount"+=LineasFact."Line Amount";
                        TempTotalIvas."Pmt. Discount Amount"+=LineasFact."Pmt. Discount Amount";
                        if LineasFact."Allow Invoice Disc." then TempTotalIvas."Inv. Disc. Base Amount"+=LineasFact."Line Amount";
                        TempTotalIvas."Invoice Discount Amount"+=LineasFact."Inv. Discount Amount";
                        TempTotalIvas."VAT Difference"+=LineasFact."VAT Difference";
                        TempTotalIvas."EC Difference"+=LineasFact."EC Difference";
                        TempTotalIvas.Modify();
                    end;
                end;
            until LineasFact.Next() = 0;
        if Evento."Oferta Mes Sin IVA" then begin
            ConfVnta.Get();
            ConfVnta.TestField("Producto Oferta Mes sin IVA");
            LineasEvnt.Reset();
            LineasEvnt.SetRange("Codigo Evento", Filtro_NroEvento);
            LineasEvnt.SetRange("No.", ConfVnta."Producto Oferta Mes sin IVA");
            if LineasEvnt.FindFirst()then begin
                ConfIVA.Get('NAC', 'IVA00');
                TempTotalIvas.Init();
                TempTotalIvas."VAT Identifier":=ConfIVA."VAT Identifier";
                TempTotalIvas."VAT Calculation Type":=ConfIVA."VAT Calculation Type";
                TempTotalIvas."Tax Group Code":='';
                TempTotalIvas."VAT %":=ConfIVA."VAT %";
                TempTotalIvas."EC %":=ConfIVA."EC %";
                TempTotalIvas."VAT Base":=LineasEvnt.Importe;
                TempTotalIvas."Amount Including VAT":=LineasEvnt."Importe IVA Incl.";
                TempTotalIvas."Line Amount":=LineasEvnt.Importe;
                TempTotalIvas."Pmt. Discount Amount":=0;
                TempTotalIvas.Insert();
            end;
        end;
        TempTotalIvas.Reset();
        if TempTotalIvas.FindSet()then repeat TempTotalIvas."VAT Amount":=TempTotalIvas."VAT Base" * (TempTotalIvas."VAT %" / 100);
                TempTotalIvas."EC Amount":=TempTotalIvas."VAT Base" * (TempTotalIvas."EC %" / 100);
                TempTotalIvas.Modify();
            until TempTotalIvas.Next() = 0;
    end;
    local procedure Calcular_TotalFactura()
    begin
        TotFact_ImpBase:=0;
        TotFact_ImpIva:=0;
        TotFact_ImpInclIva:=0;
        TotFact_ImpPdte:=0;
        Factura.CalcFields(Amount, "Amount Including VAT", "Remaining Amount");
        TotFact_ImpBase:=Factura.Amount;
        TotFact_ImpIva:=Factura."Amount Including VAT" - Factura.Amount;
        TotFact_ImpInclIva:=Factura."Amount Including VAT";
        TotFact_ImpPdte:=Factura."Remaining Amount";
        if Evento."Oferta Mes Sin IVA" then begin
            TotFact_ImpIva:=0;
            TotFact_ImpInclIva:=Factura.Amount;
            TotFact_ImpPdte:=Factura."Remaining Amount" - (Factura."Amount Including VAT" - Factura.Amount);
        end;
    end;
    local procedure CalcularTotalImportesExtras(): Decimal var
        Comensales: Record "Lineas Evento";
        Recursos: Record "Recursos Evento";
        Productos: Record "Productos Evento";
        CapituloAnt: Code[20];
        TotalComensales: Integer;
        ImporteExtra: Decimal;
    begin
        CapituloAnt:='';
        TotalComensales:=0;
        Comensales.Reset();
        Comensales.SetRange("Codigo Evento", Filtro_NroEvento);
        if Comensales.FindSet()then repeat if CapituloAnt <> Comensales.ImprCapitulo then begin
                    TotalComensales:=TotalComensales + Comensales.CantidadComensales;
                    CapituloAnt:=Comensales.ImprCapitulo;
                end;
            until Comensales.Next() = 0;
        Productos.Reset();
        Productos.SetRange("Codigo Evento", Filtro_NroEvento);
        Productos.CalcSums(Importe);
        Recursos.Reset();
        Recursos.SetRange("Codigo Evento", Filtro_NroEvento);
        Recursos.CalcSums(Importe);
        ImporteExtra:=Productos.Importe + Recursos.Importe;
        if TotalComensales > 0 then begin
            if ImporteExtra > 0 then exit(ImporteExtra / TotalComensales)
            else
                exit(0)end
        else
            exit(ImporteExtra / 1)end;
    local procedure ObtenerEvento(NroEvento: Code[20])
    begin
        Evento.Get(NroEvento);
    end;
}
