report 50001 AlxInformeHistFactVntaCapitulo
{
    ApplicationArea = Basic, Suite;
    Caption = 'Informe Hist. Factura Venta - Impresión por Capítulo';
    DefaultRenderingLayout = ImpresionPorCapitulo;

    dataset
    {
        dataitem(InformacionEmpresa; Integer)
        {
            DataItemTableView = sorting(Number)where(Number=const(1));

            column(InfEmp_logo; InfoEmpresa.Picture)
            {
            }
            column(InfEmp_Direccion1; DirecEmpresa[1])
            {
            }
            column(InfEmp_Direccion2; DirecEmpresa[2])
            {
            }
            column(InfEmp_Direccion3; DirecEmpresa[3])
            {
            }
            column(InfEmp_Direccion4; DirecEmpresa[4])
            {
            }
            column(InfEmp_Direccion5; DirecEmpresa[5])
            {
            }
            column(InfEmp_Direccion6; DirecEmpresa[6])
            {
            }
            column(InfoEmp_CIFNIF; InfoEmpresa."VAT Registration No.")
            {
            }
            column(InfoEmp_NroTelefono; InfoEmpresa."Phone No.")
            {
            }
            column(InfoEmp_NroFax; InfoEmpresa."Fax No.")
            {
            }
            column(InfoEmp_EMail; InfoEmpresa."E-Mail")
            {
            }
            column(NumerarPaginas; NumerarPaginasLbl)
            {
            }
            column(InfoEmp_TextoClausula; InfoEmpresa.Clausula_alx)
            {
            }
            column(InfoEmp_TextoBusinessRegister; InfoEmpresa.Business_Register_Text_alx)
            {
            }
            trigger OnAfterGetRecord()
            begin
                ObtenerDireccionEmpresa();
            end;
        }
        dataitem(Factura; "Sales Invoice Header")
        {
            DataItemTableView = sorting("No.");

            column(Factura_NoEvento; NoEvento)
            {
            }
            column(Fact_CIFNIF; "VAT Registration No.")
            {
            }
            column(Fact_Referencia; "Your Reference")
            {
            }
            column(Fact_No_; "No.")
            {
            }
            column(Fact_NroDocumentoExterno; "External Document No.")
            {
            }
            column(Fact_FechaVencimiento; "Due Date")
            {
            }
            column(Fact_FechaEmision; "Document Date")
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
            column(Fact_Cobrado; Factura.Cobrado)
            {
            }
            column(Fact_CuentaBanco; NroCuentaBanco(Factura))
            {
            }
            column(Fact_SubTotalImporte; TotalImporte)
            {
            }
            column(Fact_IVA; TotalImporte * (PorcentajeIVA / 100))
            {
            }
            column(Fact_TotalImporte; TotalImporte + (TotalImporte * (PorcentajeIVA / 100)))
            {
            }
            column(Cabecera_ImpPdte; ImpPdte)
            {
            }
            dataitem(MenuAdulto; "Lineas Evento")
            {
                DataItemLinkReference = Factura;
                DataItemLink = "Codigo Evento"=field(NoEvento);
                DataItemTableView = sorting("Codigo Evento", Linea)order(ascending)where(Tipo=filter(Adulto));

                column(MenuAdulto_Linea; Linea)
                {
                }
                column(MenuAdulto_ImprCapitulo; ImprCapitulo)
                {
                }
                column(MenuAdulto_DescripCapitulo; DescripCapitulo)
                {
                }
                column(MenuAdulto_No_; "No.")
                {
                }
                column(MenuAdulto_Descripcion; Descripcion)
                {
                }
                column(MenuAdulto_Cantidad; Cantidad)
                {
                }
                column(MenuAdulto_PrecioReal; "Precio Real")
                {
                }
                column(MenuAdulto_Importe; Importe)
                {
                }
                column(MenuAdulto_MostrarComentario; MostrarCom)
                {
                }
                dataitem(Comentarios_MenuAdulto; Integer)
                {
                    DataItemTableView = sorting(Number)where(Number=const(1));

                    column(MenuAdulto_Comentario; Comentario)
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        if MostrarCom then Comentario:=MenuAdulto.Comentarios
                        else
                            Comentario:='';
                    end;
                }
                trigger OnPreDataItem()
                begin
                    if not MostrarCom then SetFilter("No.", '<>%1', '');
                end;
                trigger OnAfterGetRecord()
                begin
                    Orden:=1;
                    TotalImporte:=TotalImporte + Importe;
                    TotalAdulto:=TotalAdulto + Importe;
                    PorcentajeIVA:="% IVA";
                end;
            }
            dataitem(MenuNinno; "Lineas Evento")
            {
                DataItemLinkReference = Factura;
                DataItemLink = "Codigo Evento"=field(NoEvento);
                DataItemTableView = sorting("Codigo Evento", Linea)order(ascending)where(Tipo=filter("Niño"));

                column(MenuNinno_Linea; Linea)
                {
                }
                column(MenuNinno_ImprCapitulo; ImprCapitulo)
                {
                }
                column(MenuNinno_DescripCapitulo; DescripCapitulo)
                {
                }
                column(MenuNinno_No_; "No.")
                {
                }
                column(MenuNinno_Descripcion; Descripcion)
                {
                }
                column(MenuNinno_Cantidad; Cantidad)
                {
                }
                column(MenuNinno_PrecioReal; "Precio Real")
                {
                }
                column(MenuNinno_Importe; Importe)
                {
                }
                column(MenuNinno_MostrarComentario; MostrarCom)
                {
                }
                dataitem(Comentarios_MenuNinno; Integer)
                {
                    DataItemTableView = sorting(Number)where(Number=const(1));

                    column(MenuNinno_Comentario; Comentario)
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        if MostrarCom then Comentario:=MenuNinno.Comentarios
                        else
                            Comentario:='';
                    end;
                }
                trigger OnPreDataItem()
                begin
                    if not MostrarCom then SetFilter("No.", '<>%1', '');
                end;
                trigger OnAfterGetRecord()
                begin
                    Orden:=2;
                    TotalImporte:=TotalImporte + Importe;
                    TotalNinno:=TotalNinno + Importe;
                end;
            }
            dataitem(Pan; "Productos Evento")
            {
                DataItemLinkReference = Factura;
                DataItemLink = "Codigo Evento"=field(NoEvento);
                DataItemTableView = sorting("Codigo Evento", Linea)order(ascending)where(Tipo=filter(Pan));

                column(Pan_Linea; Linea)
                {
                }
                column(Pan_ImprCapitulo; ImprCapitulo)
                {
                }
                column(Pan_DescripCapitulo; DescripCapitulo)
                {
                }
                column(Pan_Producto; Producto)
                {
                }
                column(Pan_Descripcion; Descripcion)
                {
                }
                column(Pan_Cantidad; Cantidad)
                {
                }
                column(Pan_PrecioReal; "Precio Real")
                {
                }
                column(Pan_Importe; Importe)
                {
                }
                column(Pan_MostrarComentario; MostrarCom)
                {
                }
                dataitem(Comentarios_Pan; Integer)
                {
                    DataItemTableView = sorting(Number)where(Number=const(1));

                    column(Pan_Comentario; Comentario)
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        if MostrarCom then Comentario:=Pan.Comentarios
                        else
                            Comentario:='';
                    end;
                }
                trigger OnPreDataItem()
                begin
                    if not MostrarCom then SetFilter(Producto, '<>%1', '');
                end;
                trigger OnAfterGetRecord()
                begin
                    Orden:=3;
                    TotalImporte:=TotalImporte + Importe;
                end;
            }
            dataitem(Menaje; "Productos Evento")
            {
                DataItemLinkReference = Factura;
                DataItemLink = "Codigo Evento"=field(NoEvento);
                DataItemTableView = sorting("Codigo Evento", Linea)order(ascending)where(Tipo=filter(Menaje));

                column(Menaje_Linea; Linea)
                {
                }
                column(Menaje_ImprCapitulo; ImprCapitulo)
                {
                }
                column(Menaje_DescripCapitulo; DescripCapitulo)
                {
                }
                column(Menaje_Producto; Producto)
                {
                }
                column(Menaje_Descripcion; Descripcion)
                {
                }
                column(Menaje_Cantidad; Cantidad)
                {
                }
                column(Menaje_PrecioReal; "Precio Real")
                {
                }
                column(Menaje_Importe; Importe)
                {
                }
                column(Menaje_MostrarComentario; MostrarCom)
                {
                }
                dataitem(Comentarios_Menaje; Integer)
                {
                    DataItemTableView = sorting(Number)where(Number=const(1));

                    column(Menaje_Comentario; Comentario)
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        if MostrarCom then Comentario:=Menaje.Comentarios
                        else
                            Comentario:='';
                    end;
                }
                trigger OnPreDataItem()
                begin
                    if not MostrarCom then SetFilter(Producto, '<>%1', '');
                end;
                trigger OnAfterGetRecord()
                begin
                    Orden:=4;
                    TotalImporte:=TotalImporte + Importe;
                end;
            }
            dataitem(Personal; "Recursos Evento")
            {
                DataItemLinkReference = Factura;
                DataItemLink = "Codigo Evento"=field(NoEvento);
                DataItemTableView = sorting("Codigo Evento", Linea)order(ascending)where(Tipo=filter(Personal));

                column(Personal_Linea; Linea)
                {
                }
                column(Personal_ImprCapitulo; ImprCapitulo)
                {
                }
                column(Personal_DescripCapitulo; DescripCapitulo)
                {
                }
                column(Personal_Codigo; "Codigo Recurso")
                {
                }
                column(Personal_Descripcion; Descripcion)
                {
                }
                column(Personal_Cantidad; Cantidad)
                {
                }
                column(Personal_PrecioReal; "Precio Real")
                {
                }
                column(Personal_Importe; Importe)
                {
                }
                column(Personal_MostrarComentario; MostrarCom)
                {
                }
                dataitem(Comentarios_Personal; Integer)
                {
                    DataItemTableView = sorting(Number)where(Number=const(1));

                    column(Personal_Comentario; Comentario)
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        if MostrarCom then Comentario:=Personal.Comentarios
                        else
                            Comentario:='';
                    end;
                }
                trigger OnPreDataItem()
                begin
                    if not MostrarCom then SetFilter("Codigo Recurso", '<>%1', '');
                end;
                trigger OnAfterGetRecord()
                begin
                    Orden:=5;
                    TotalImporte:=TotalImporte + Importe;
                end;
            }
            dataitem(Transporte; "Recursos Evento")
            {
                DataItemLinkReference = Factura;
                DataItemLink = "Codigo Evento"=field(NoEvento);
                DataItemTableView = sorting("Codigo Evento", Linea)order(ascending)where(Tipo=filter(Otros));

                column(Transporte_Linea; Linea)
                {
                }
                column(Transporte_ImprCapitulo; ImprCapitulo)
                {
                }
                column(Transporte_DescripCapitulo; DescripCapitulo)
                {
                }
                column(Transporte_Codigo; "Codigo Recurso")
                {
                }
                column(Transporte_Descripcion; Descripcion)
                {
                }
                column(Transporte_Cantidad; Cantidad)
                {
                }
                column(Transporte_PrecioReal; "Precio Real")
                {
                }
                column(Transporte_Importe; Importe)
                {
                }
                column(Transporte_MostrarComentario; MostrarCom)
                {
                }
                dataitem(Comentarios_Transporte; Integer)
                {
                    DataItemTableView = sorting(Number)where(Number=const(1));

                    column(Transporte_Comentario; Comentario)
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        if MostrarCom then Comentario:=Transporte.Comentarios
                        else
                            Comentario:='';
                    end;
                }
                trigger OnPreDataItem()
                begin
                    if not MostrarCom then SetFilter("Codigo Recurso", '<>%1', '');
                end;
                trigger OnAfterGetRecord()
                begin
                    Orden:=6;
                    TotalImporte:=TotalImporte + Importe;
                end;
            }
            dataitem(Suplementos; "Productos Evento")
            {
                DataItemLinkReference = Factura;
                DataItemLink = "Codigo Evento"=field(NoEvento);
                DataItemTableView = sorting("Codigo Evento", Tipo, Linea)order(ascending)where(Tipo=filter(Suplementos));

                column(Suplementos_Linea; Linea)
                {
                }
                column(Suplementos_ImprCapitulo; ImprCapitulo)
                {
                }
                column(Suplementos_DescripCapitulo; DescripCapitulo)
                {
                }
                column(Suplementos_Codigo; "Codigo Producto")
                {
                }
                column(Suplementos_Descripcion; Descripcion)
                {
                }
                column(Suplementos_Cantidad; Cantidad)
                {
                }
                column(Suplementos_PrecioReal; "Precio Real")
                {
                }
                column(Suplementos_Importe; Importe)
                {
                }
                dataitem(Comentarios_Suplementos; Integer)
                {
                    DataItemTableView = sorting(Number)where(Number=const(1));

                    column(Suplementos_Comentario; Comentario)
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        if MostrarCom then Comentario:=Suplementos.Comentarios
                        else
                            Comentario:='';
                    end;
                }
                trigger OnPreDataItem()
                begin
                    if not MostrarCom then SetFilter("Codigo Producto", '<>%1', '');
                end;
                trigger OnAfterGetRecord()
                begin
                    Orden:=7;
                    TotalImporte:=TotalImporte + Importe;
                end;
            }
            dataitem(FacturaComentarios; "Sales Invoice Line")
            {
                DataItemLinkReference = Factura;
                DataItemLink = "Document No."=field("No.");
                DataItemTableView = sorting("Document No.", "Line No.")order(ascending)where(Type=filter(" "));

                column(FactComm_Description; Description)
                {
                }
            }
            dataitem(TotalMenu; Integer)
            {
                DataItemTableView = sorting(Number);

                column(TotalMenuDescripcion; TotalMenuDesc)
                {
                }
                column(TotalMenuImporte; StrSubstNo(TotalDetalleLbl, Format(TotalMenuImp / CantComensales, 0, '<Precision,2:2><Standard Format,0>'), PorcentajeIVA))
                {
                }
                trigger OnPreDataItem()
                begin
                    SetRange(Number, 1, CantidadTotales(Factura.NoEvento));
                end;
                trigger OnAfterGetRecord()
                begin
                    Evento.Get(Factura.NoEvento);
                    CantComensales:=0;
                    if CantidadTotales(Factura.NoEvento) = 1 then begin
                        TotalMenuDesc:=TotalMenuLbl;
                        TotalMenuImp:=TotalImporte;
                        CantComensales:=Evento."Total Adultos";
                    end
                    else
                        case Number of 1: begin
                            TotalMenuDesc:=TotalAdultoLbl;
                            TotalMenuImp:=TotalAdulto;
                            CantComensales:=Evento."Total Adultos";
                        end;
                        2: begin
                            TotalMenuDesc:=TotalNinnoLbl;
                            TotalMenuImp:=TotalNinno;
                            CantComensales:=Evento."Total Ninos";
                        end;
                        end;
                end;
            }
            dataitem(TotalIvas; Integer)
            {
                DataItemTableView = sorting(Number);

                column(Iva_Identificador; TempTotalIvas."VAT Identifier")
                {
                }
                column(Iva_Iva_; TempTotalIvas."VAT %")
                {
                }
                column(Iva_RE_; TempTotalIvas."EC %")
                {
                }
                column(Iva_ImporteLinea; TempTotalIvas."Line Amount")
                {
                }
                column(Iva_DsctoBaseFactura; TempTotalIvas."Inv. Disc. Base Amount")
                {
                }
                column(Iva_DsctoFactura; TempTotalIvas."Invoice Discount Amount")
                {
                }
                column(Iva_BaseIva; TempTotalIvas."VAT Base")
                {
                }
                column(Iva_ImporteIva; TempTotalIvas."VAT Amount")
                {
                }
                column(Iva_ImporteRe; TempTotalIvas."EC Amount")
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
            trigger OnPreDataItem()
            begin
                SetRange("No.", FacturaNro);
            end;
            trigger OnAfterGetRecord()
            var
                lt_MovsCliente: Record 21;
            begin
                ObtenerDireccionCliente("Sell-to Customer No.");
                TotalImporte:=0;
                TotalAdulto:=0;
                TotalNinno:=0;
                TempTotalIvas.Reset();
                TempTotalIvas.DeleteAll();
                LlenarTotalIVAs();
                ImpPdte:=0;
                lt_MovsCliente.RESET;
                lt_MovsCliente.SETRANGE("Document No.", Factura."No.");
                lt_MovsCliente.SETRANGE("Posting Date", Factura."Posting Date");
                lt_MovsCliente.SETRANGE("Customer No.", Factura."Bill-to Customer No.");
                IF lt_MovsCliente.FINDSET THEN REPEAT lt_MovsCliente.CALCFIELDS("Remaining Amount");
                        ImpPdte:=lt_MovsCliente."Remaining Amount";
                    UNTIL lt_MovsCliente.NEXT = 0;
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

                    field(CantCopias; CantCopias)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'N° de copias';
                        Visible = false;
                    }
                    field(FacturaNro; FacturaNro)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'N° factura';
                        Editable = false;
                    }
                    field(TipoImpresion; TipoImpresion)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Tipo de impresión';
                        Editable = false;
                    }
                    field(MostrarCom; MostrarCom)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Mostrar comentarios';
                    }
                }
            }
        }
    }
    rendering
    {
        layout(ImpresionPorCapitulo)
        {
            Type = RDLC;
            Caption = 'Informe Hist. Factura Venta - Impresión por capítulo';
            LayoutFile = './src/Layout/50001.InformeHistFactVntaCapitulo2.rdl';
            Summary = './src/Layout/50001.InformeHistFactVntaCapitulo2.rdl';
        }
    }
    labels
    {
    // Etiquetas de cabecera del informe.
    CIFNIFEmp_Caption='CIF/NIF: ';
    NroTelefono_Caption='N° Teléfono: ';
    NroFax_Caption='N° Fax: ';
    EMail_Caption='E-Mail: ';
    Factura_Caption='Factura';
    CIFNIFFact_Caption='CIF/NIF';
    SuNtraRef_Caption='Su/Ntra. ref.';
    NroFactura_Caption='N° Factura';
    NroDocExt_Caption='N° documento externo';
    FecVenc_Caption='Fecha vencimiento';
    FecEmiDoc_Caption='Fecha emisión documento';
    TermPago_Caption='Términos pago';
    FormaPago_Caption='Forma pago';
    NroCuenta_Caption='N° Cuenta';
    // Etiquetas de cabecera del detalle.
    Referencia_Caption='Marca / Referencia';
    Descripcion_Caption='Descripción';
    Cantidad_Caption='Cantidad';
    Precio_Caption='Precio';
    Importe_Caption='Importe';
    EventoNro_Caption='Evento Nro.';
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
    // Texto en el pie de página
    TextoPiePagina='LA FALTA DE PAGO DE ESTA FACTURA EN EL PLAZO DE VENCIMIENTO ESTABLECIDO GENERARA UN 2% MENSUAL EN CONCEPTO DE INTERESES DE DEMORA.';
    }
    procedure ConfigurarFiltros(NuevoFacturaNro: Code[20]; NuevoTipoImpresion: Enum AlxiaEventoTipodeImpresion; NuevoMostrarCom: Boolean)
    begin
        FacturaNro:=NuevoFacturaNro;
        TipoImpresion:=NuevoTipoImpresion;
        MostrarCom:=NuevoMostrarCom;
    end;
    var InfoEmpresa: Record "Company Information";
    Cliente: Record Customer;
    Evento: Record Evento;
    #pragma warning disable AL0432
    TempTotalIvas: Record "VAT Amount Line" temporary;
    #pragma warning restore AL0432
    TipoImpresion: Enum AlxiaEventoTipodeImpresion;
    FacturaNro: Code[20];
    Orden: Integer;
    CantCopias: Integer;
    CantComensales: Integer;
    TotalImporte: Decimal;
    TotalAdulto: Decimal;
    TotalNinno: Decimal;
    TotalMenuImp: Decimal;
    PorcentajeIVA: Decimal;
    MostrarCom: Boolean;
    TotalMenuDesc: Text;
    Comentario: Text;
    DirecEmpresa: array[8]of Text[50];
    DirecCliente: array[8]of Text[50];
    NumerarPaginasLbl: Label 'Página %1 of %2', Locked = true;
    TotalDetalleLbl: Label '%1 € + %2% IVA', Locked = true;
    // Etiquetas de los totales del detalle
    TotalMenuLbl: Label 'TOTAL MENU', Locked = true;
    TotalAdultoLbl: Label 'TOTAL MENU ADULTO', Locked = true;
    TotalNinnoLbl: Label 'TOTAL MENU NIÑO', Locked = true;
    ImpPdte: Decimal;
    local procedure ObtenerDireccionEmpresa()
    var
        Formato: Codeunit "Format Address";
    begin
        InfoEmpresa.Get();
        InfoEmpresa.CalcFields(Picture);
        Formato.Company(DirecEmpresa, InfoEmpresa);
    end;
    local procedure ObtenerDireccionCliente(NroCliente: Code[20])
    var
        Formato: Codeunit "Format Address";
    begin
        Cliente.Get(NroCliente);
        Formato.Customer(DirecCliente, Cliente);
    end;
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
    local procedure MostrarCriteriosDeCaja(NroFactura: Code[20]): Text var
        MovIVA: Record "VAT Entry";
        ConfCont: Record "General Ledger Setup";
        TieneCriterio: Boolean;
        Criterio: Label 'Régimen especial del criterio de caja';
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
    local procedure CantidadTotales(NroEvento: Code[20]): Integer var
        Evento2: Record Evento;
        i: Integer;
    begin
        i:=0;
        Evento2.Get(NroEvento);
        if Evento2."Total Adultos" <> 0 then i:=1;
        if Evento2."Total Ninos" <> 0 then i:=2;
        exit(i)end;
    local procedure LlenarTotalIVAs()
    var
        ConfCont: Record "General Ledger Setup";
        LineasFact: Record "Sales Invoice Line";
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
                        //TempTotalIvas."VAT Amount" := Round(TempTotalIvas."VAT Base" * (TempTotalIvas."VAT %" / 100), ConfCont."Amount Rounding Precision");
                        //TempTotalIvas."EC Amount" := Round(TempTotalIvas."VAT Base" * (TempTotalIvas."EC %" / 100), ConfCont."Amount Rounding Precision");
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
                        //TempTotalIvas."VAT Amount" += Round(TempTotalIvas."VAT Base" * (TempTotalIvas."VAT %" / 100), ConfCont."Amount Rounding Precision");
                        //TempTotalIvas."EC Amount" += Round(TempTotalIvas."VAT Base" * (TempTotalIvas."EC %" / 100), ConfCont."Amount Rounding Precision");
                        TempTotalIvas.Modify();
                    end;
                end;
            until LineasFact.Next() = 0;
        TempTotalIvas.Reset();
        if TempTotalIvas.FindSet()then repeat TempTotalIvas."VAT Amount":=TempTotalIvas."VAT Base" * (TempTotalIvas."VAT %" / 100);
                TempTotalIvas."EC Amount":=TempTotalIvas."VAT Base" * (TempTotalIvas."EC %" / 100);
                TempTotalIvas.Modify();
            until TempTotalIvas.Next() = 0;
    end;
    local procedure IniciarTotale()
    begin
    //
    end;
}
