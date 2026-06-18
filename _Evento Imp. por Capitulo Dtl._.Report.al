report 50006 "Evento Imp. por Capitulo Dtl."
{
    ApplicationArea = Basic, Suite;
    Caption = 'Evento - Impresión por Capitulo Detallado';
    DefaultRenderingLayout = ImpresionPorCapituloDtl;

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
            column(Evento_Titulo; EventoInfo[15])
            {
            }
            column(Evento_Descripcion; EventoInfo[16])
            {
            }
            column(Evento_Nro; EventoInfo[1])
            {
            }
            column(Evento_Fecha; EventoInfo[2])
            {
            }
            column(Evento_Hora; EventoInfo[3])
            {
            }
            column(Evento_Terminos; EventoInfo[4])
            {
            }
            column(Evento_Forma; EventoInfo[5])
            {
            }
            column(Evento_CIF; EventoInfo[6])
            {
            }
            column(Evento_ImporteSeñal; EventoInfo[7])
            {
            }
            column(Evento_Contacto; EventoInfo[8])
            {
            }
            column(Evento_NroTelefono; EventoInfo[9])
            {
            }
            column(Evento_Email; EventoInfo[10])
            {
            }
            column(Evento_Lugar; EventoInfo[11])
            {
            }
            column(Evento_Direccion; EventoInfo[12])
            {
            }
            column(Evento_CpLocalidad; EventoInfo[13])
            {
            }
            column(Evento_Provincia; EventoInfo[14])
            {
            }
            column(Evento_Senalizado; Senalizado)
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
            column(Evento_TextoSaludo; Evento."Texto Saludo")
            {
            }
            column(Evento_TextoOtrasOpciones; Evento."Texto Otras opciones")
            {
            }
            column(Evento_TextoDirectrices; Evento."Texto Directrices")
            {
            }
            column(Evento_TextoClienteAportaParaSi; Evento."Texto Cliente aporta para si")
            {
            }
            column(Evento_TextoClienteAportaCatering; Evento."Texto Cliente aporta catering")
            {
            }
            column(Evento_TextoDocObligatoria; Evento."Texto Doc. obligatoria")
            {
            }
            column(Evento_TextoFormasdePago; Evento."Texto Formas de pago")
            {
            }
            column(Evento_TextoCondicionesContratacion; Evento."Texto Condiciones contratación")
            {
            }
            column(Evento_TextoDespedida; Evento."Texto Despedida")
            {
            }
            trigger OnAfterGetRecord()
            begin
                CompanyInfo.CALCFIELDS(Picture);
                FormatAddr.Company(CompanyAddr, CompanyInfo);
                EventoInformacion();
                CalcularTotalIva();
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
                    DataItemLink = "Codigo Evento"=field("Codigo Evento"), ImprCapitulo=field(ImprCapitulo), DescripCapitulo=field(DescripCapitulo), Linea=field(Linea);
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

            column(Pan_Linea; Linea)
            {
            }
            column(Pan_Capitulo; ImprCapitulo)
            {
            }
            dataitem(LineasPan; "Productos Evento")
            {
                DataItemLinkReference = Pan;
                DataItemLink = "Codigo Evento"=field("Codigo Evento"), Tipo=field(Tipo), Linea=field(Linea);
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
                DataItemLink = "Codigo Evento"=field("Codigo Evento"), Tipo=field(Tipo), Linea=field(Linea);
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

            column(Menaje_Linea; Linea)
            {
            }
            column(Menaje_Capitulo; ImprCapitulo)
            {
            }
            dataitem(LineasMenaje; "Productos Evento")
            {
                DataItemLinkReference = Menaje;
                DataItemLink = "Codigo Evento"=field("Codigo Evento"), Tipo=field(Tipo), Linea=field(Linea);
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
                DataItemLink = "Codigo Evento"=field("Codigo Evento"), Tipo=field(Tipo), Linea=field(Linea);
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

            column(Personal_Linea; Linea)
            {
            }
            column(Personal_Capitulo; ImprCapitulo)
            {
            }
            dataitem(LineasPersonal; "Recursos Evento")
            {
                DataItemLinkReference = Personal;
                DataItemLink = "Codigo Evento"=field("Codigo Evento"), Tipo=field(Tipo), Linea=field(Linea);
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
                DataItemLink = "Codigo Evento"=field("Codigo Evento"), Tipo=field(Tipo), Linea=field(Linea);
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

            column(Transporte_Linea; Linea)
            {
            }
            column(Transporte_Capitulo; ImprCapitulo)
            {
            }
            dataitem(LineasTransporte; "Recursos Evento")
            {
                DataItemLinkReference = Transporte;
                DataItemLink = "Codigo Evento"=field("Codigo Evento"), Tipo=field(Tipo), Linea=field(Linea);
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
                DataItemLink = "Codigo Evento"=field("Codigo Evento"), Tipo=field(Tipo), Linea=field(Linea);
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

            column(Suplementos_Linea; Linea)
            {
            }
            column(Suplementos_Capitulo; ImprCapitulo)
            {
            }
            dataitem(LineasSuplementos; "Productos Evento")
            {
                DataItemLinkReference = Suplementos;
                DataItemLink = "Codigo Evento"=field("Codigo Evento"), Tipo=field(Tipo), Linea=field(Linea);
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
                DataItemLink = "Codigo Evento"=field("Codigo Evento"), Tipo=field(Tipo), Linea=field(Linea);
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
        dataitem(Ivas; "Lineas Evento")
        {
            DataItemTableView = sorting("Codigo Evento", Linea);

            column(Ivas_Iva; "% IVA")
            {
            }
            column(Ivas_Base; IvaBase)
            {
            }
            column(Ivas_Importe; IvaImporte)
            {
            }
            column(Ivas_Subtotal; IvaSubTotal)
            {
            }
            column(Ivas_TotalCaption;'Total ' + EventoInfo[15])
            {
            }
            trigger OnPreDataItem()
            begin
                SetRange("Codigo Evento", Filtro_NroEvento);
            end;
            trigger OnAfterGetRecord()
            begin
                CalcularIvas("% IVA");
            end;
        }
        dataitem(Observaciones_1; Integer)
        {
            DataItemTableView = sorting(Number)where(Number=const(1));

            column(Observaciones1_Grupo; Number)
            {
            }
            column(Observaciones1_Observaciones; ObservacionesDelEvento())
            {
            }
            trigger OnPreDataItem()
            begin
                if not SeDebeMostrarObservaciones()then CurrReport.Break();
            end;
        }
        dataitem(Observaciones_2; Integer)
        {
            DataItemTableView = sorting(Number)where(Number=const(1));

            column(Observaciones2_Grupo; Number)
            {
            }
            column(Observaciones2_Observaciones; ObservacionesDelEvento())
            {
            }
            trigger OnPreDataItem()
            begin
                if SeDebeMostrarObservaciones()then CurrReport.Break();
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
        trigger OnOpenPage()
        begin
            Filtro_MostrarCom:=true;
        end;
    }
    rendering
    {
        layout(ImpresionPorCapituloDtl)
        {
            Type = RDLC;
            Caption = 'Evento - Impresión por Capitulo Detallado';
            LayoutFile = './src/Layout/50006.EventoImpresionPorCapituloDetallado.rdl';
            Summary = './src/Layout/50006.EventoImpresionPorCapituloDetallado.rdl';
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
    Lbl_NroEvento='N° evento';
    Lbl_FechaEvento='Fecha evento';
    Lbl_HoraEvento='Hora evento';
    Lbl_TerminoPago='Términos de pago';
    Lbl_FormaPago='Forma de pago';
    Lbl_CIF='CIF';
    Lbl_Senalizado='SEÑALIZADO';
    Lbl_ImpSenal='Importe Señal';
    Lbl_Contacto='Contacto';
    Lbl_NroTelefono='N° telf.';
    Lbl_Email='Email';
    Lbl_LugarEvento='Lugar evento';
    Lbl_Direccion='Dirección';
    Lbl_CpLocalidad='CP. localidad';
    Lbl_Provincia='Provincia';
    // Títulos del detalle
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
    // Observaciones
    Lbl_Observaciones='OBSERVACIONES';
    Lbl_ConformeCliente='CONFORME CLIENTE';
    Lbl_NombreyApellido='NOMBRE Y APELLIDO';
    Lbl_DNI='D.N.I.';
    Lbl_EnCalidadDe='EN CALIDAD DE:';
    Lbl_Firma='FIRMA:';
    // Pie de página
    Lbl_Numeracion='Página %1 de %2', Locked = true;
    }
    trigger OnPreReport()
    begin
        IvaTotal:=0;
        ImportePendiente:=0;
        ObtenerEvento(Filtro_NroEvento);
    end;
    procedure ConfigurarFiltros(NuevoNroEvento: Code[20]; NuevoMostrarCom: Boolean)
    begin
        Filtro_NroEvento:=NuevoNroEvento;
        Filtro_MostrarCom:=NuevoMostrarCom;
    end;
    var // Filtros
    Filtro_MostrarCom: Boolean;
    Filtro_NroEvento: Code[20];
    // Variables
    Evento: Record Evento;
    FormatAddr: Codeunit "Format Address";
    Senalizado: Boolean;
    IvaBase: Decimal;
    IvaImporte: Decimal;
    IvaSubTotal: Decimal;
    IvaTotal: Decimal;
    ImportePendiente: Decimal;
    TotalPorMenu: Decimal;
    TotalIva: Decimal;
    Observaciones: Text;
    EsSenalizado: Boolean;
    TotalDetalleLbl: Label '%1 € + %2% IVA', Locked = true;
    CompanyAddr: array[8]of Text[50];
    EventoInfo: array[16]of Text[80];
    local procedure EventoInformacion()
    var
        Evento: Record Evento;
    begin
        Clear(EventoInfo);
        if Evento.Get(Filtro_NroEvento)then begin
            Senalizado:=Evento.Senalizado;
            EventoInfo[1]:=Evento."Codigo Evento";
            EventoInfo[2]:=Format(Evento."Fecha Evento");
            EventoInfo[3]:=Format(Evento."Hora Evento");
            EventoInfo[4]:=TerminosDePago(Evento."Cod Teminos Pago");
            EventoInfo[5]:=FormasDePago(Evento."Cod Forma Pago");
            EventoInfo[6]:=Evento."CIF/NIF";
            EventoInfo[7]:=Format(Evento."Imp Senal");
            EventoInfo[8]:=Evento."Persona de Contacto 2";
            EventoInfo[9]:=Evento."Telefono 2";
            EventoInfo[10]:=Evento."E-Mail 2";
            EventoInfo[11]:=Evento."Lugar Evento 2";
            EventoInfo[12]:=Evento."Direccion 2";
            EventoInfo[13]:=Evento."Codigo Postal 2" + ' ' + Evento."Poblacion 2";
            EventoInfo[14]:=Evento."Provincia 2";
            if Evento.Estado in[Evento.Estado::Realizado, Evento.Estado::Aceptado]then EventoInfo[15]:='Pedido'
            else
                EventoInfo[15]:='Presupuesto';
            EventoInfo[16]:=Evento.Descripcion;
        end;
    end;
    local procedure TerminosDePago(Codigo: Code[10]): Text var
        Terminos: Record "Payment Terms";
    begin
        if Terminos.Get(Codigo)then exit(Terminos.Description);
        exit('');
    end;
    local procedure FormasDePago(Codigo: Code[10]): Text var
        Formas: Record "Payment Method";
    begin
        if Formas.Get(Codigo)then exit(Formas.Description);
        exit('')end;
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
    local procedure CalcularIvas(Iva: Decimal): Decimal var
        Menus: Record "Lineas Evento";
        Productos: Record "Productos Evento";
        Recursos: Record "Recursos Evento";
    begin
        IvaBase:=0;
        IvaImporte:=0;
        IvaSubTotal:=0;
        Menus.Reset();
        Menus.SetRange("Codigo Evento", Filtro_NroEvento);
        Menus.SetRange("% IVA", Iva);
        Menus.CalcSums(Importe, "Importe IVA Incl.");
        Productos.Reset();
        Productos.SetRange("Codigo Evento", Filtro_NroEvento);
        Productos.SetRange("% IVA", Iva);
        Productos.CalcSums(Importe, "Importe IVA Incl.");
        Recursos.Reset();
        Recursos.SetRange("Codigo Evento", Filtro_NroEvento);
        Recursos.SetRange("% IVA", Iva);
        Recursos.CalcSums(Importe, "Importe IVA Incl.");
        IvaBase:=Menus.Importe + Productos.Importe + Recursos.Importe;
        IvaImporte:=(Menus."Importe IVA Incl." + Productos."Importe IVA Incl." + Recursos."Importe IVA Incl.") - IvaBase;
        IvaSubTotal:=Menus."Importe IVA Incl." + Productos."Importe IVA Incl." + Recursos."Importe IVA Incl.";
    end;
    local procedure CalcularTotalIva()
    var
        Evento: Record Evento;
        Menus: Record "Lineas Evento";
        Productos: Record "Productos Evento";
        Recursos: Record "Recursos Evento";
    begin
        Menus.Reset();
        Menus.SetRange("Codigo Evento", Filtro_NroEvento);
        Menus.CalcSums("Importe IVA Incl.");
        Productos.Reset();
        Productos.SetRange("Codigo Evento", Filtro_NroEvento);
        Productos.CalcSums("Importe IVA Incl.");
        Recursos.Reset();
        Recursos.SetRange("Codigo Evento", Filtro_NroEvento);
        Recursos.CalcSums("Importe IVA Incl.");
        IvaTotal:=Menus."Importe IVA Incl." + Productos."Importe IVA Incl." + Recursos."Importe IVA Incl.";
        if Evento.Get(Filtro_NroEvento)then begin
            EsSenalizado:=Evento.Senalizado;
            ImportePendiente:=(Menus."Importe IVA Incl." + Productos."Importe IVA Incl." + Recursos."Importe IVA Incl.") - Evento."Imp Senal";
        end;
    end;
    local procedure ObservacionesDelEvento(): Text var
        Evento: Record Evento;
    begin
        if Evento.Get(Filtro_NroEvento)then exit(Evento.Comentario + ' ' + Evento.Comentario2);
        exit('');
    end;
    local procedure SeDebeMostrarObservaciones(): Boolean var
        Evento: Record Evento;
    begin
        if Evento.Get(Filtro_NroEvento)then exit(Evento.Estado IN[Evento.Estado::Realizado, Evento.Estado::Aceptado]);
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
