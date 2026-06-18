report 50011 "InformeEvento - ImpCapituloDtl"
{
    Caption = 'Informe Evento - Impresión por Capítulo Detallado';
    Description = 'GAP00045';
    DefaultRenderingLayout = ImpresionPorCapituloDtl;

    dataset
    {
        dataitem(Evento; Evento)
        {
            RequestFilterFields = "Codigo Evento";

            column(CodigoEvento_Evento; Evento."Codigo Evento")
            {
            }
            column(PaymentTermsDescription; PaymentTerms.Description)
            {
            }
            column(PaymentMethodDescription; PaymentMethod.Description)
            {
            }
            column(PmtTermsDescCaption; PmtTermsDescCaptionLbl)
            {
            }
            column(PmtMethodDescCaption; PmtMethodDescCaptionLbl)
            {
            }
            column(HomePageCaption; HomePageCaptionCap)
            {
            }
            column(EmailCaption; EmailCaptionLbl)
            {
            }
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);

                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = SORTING(Number)WHERE(Number=CONST(1));

                    column(OutputNo; OutputNo)
                    {
                    }
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
                    column(CompanyInfoHomePage;'') //CompanyInfo."Home Page") no se utiliza
                    {
                    }
                    column(CompanyInfoEmail; CompanyInfo."E-Mail")
                    {
                    }
                    column(CompanyInfoFaxNo; CompanyInfo."Fax No.")
                    {
                    }
                    column(PageCaption; PageCaptionCap)
                    {
                    }
                    column(PhoneNoCaption; PhoneNoCaptionLbl)
                    {
                    }
                    column(VATRegNoCaption; VATRegNoCaptionLbl)
                    {
                    }
                    column(FaxNoCaption; FaxNoCaptionLbl)
                    {
                    }
                    column(Evento_Description; Evento.Descripcion)
                    {
                    }
                    column(Evento_HoraEvento; Evento."Hora Evento")
                    {
                    }
                    column(Evento_CodCliente; Evento."Codigo Cliente")
                    {
                    }
                    column(Evento_CodContacto; Evento."Codigo Contacto")
                    {
                    }
                    column(Evento_PersonaContacto; Evento."Persona de Contacto 2")
                    {
                    }
                    column(Evento_Direccion; Evento."Direccion 2")
                    {
                    }
                    column(Evento_CodPostal; Evento."Codigo Postal 2")
                    {
                    }
                    column(Evento_Poblacion; Evento."Poblacion 2")
                    {
                    }
                    column(Evento_Provincia; Evento."Provincia 2")
                    {
                    }
                    column(Evento_CIF; Evento."CIF/NIF")
                    {
                    }
                    column(LugarEvento; Evento."Lugar Evento 2")
                    {
                    }
                    column(Evento_Telefono; Evento."Telefono 2")
                    {
                    }
                    column(Evento_Email2; Evento."E-Mail 2")
                    {
                    }
                    column(Listado_Titulo; TituloReport)
                    {
                    }
                    column(Evento_Senalizado; Evento.Senalizado)
                    {
                    }
                    column(Evento_ImpSenal; Evento."Imp Senal")
                    {
                    }
                    column(TotalCaption; TxtTotal)
                    {
                    }
                    column(NoClienteCaption; NoClienteCaptionLbl)
                    {
                    }
                    column(NoContactoCaption; NoContactoCaptionLbl)
                    {
                    }
                    column(FechaEvento_Evento; Evento."Fecha Evento")
                    {
                    }
                    column(FechaAlta_Evento; Evento.FechaAlta)
                    {
                    }
                    column(FechaEventoCaption; FechaEventoCaptionLbl)
                    {
                    }
                    column(NoEventoCaption; NoEventoCaptionLbl)
                    {
                    }
                    column(FechaAltaCaption; FechaAltaCaptionLbl)
                    {
                    }
                    column(Evento_Comentario; txtComentarioEvento)
                    {
                    }
                    column(Evento_Pedido; gb_Pedido)
                    {
                    }
                    dataitem("Lineas Evento"; "Lineas Evento")
                    {
                        DataItemLink = "Codigo Evento"=FIELD("Codigo Evento");
                        DataItemLinkReference = Evento;
                        DataItemTableView = SORTING("Codigo Evento", Tipo, Linea)ORDER(Ascending);

                        trigger OnAfterGetRecord()
                        begin
                            TotalImporte:=TotalImporte + Importe;
                            IF "Lineas Evento".Linea > LineEventoNo THEN LineEventoNo:="Lineas Evento".Linea;
                            IF "Lineas Evento".Imprime THEN BEGIN
                                LineasEventoTMP.INIT;
                                LineasEventoTMP.TRANSFERFIELDS("Lineas Evento");
                                // Con el cambio de agrupar por descripcion de capitulo, el orden ya no sirve.
                                IF "Lineas Evento".Tipo = "Lineas Evento".Tipo::Otros THEN LineasEventoTMP.Tipo:=99
                                ELSE
                                    LineasEventoTMP.Tipo:="Lineas Evento".Tipo + 100; //Para ordenar
                                //Los comentarios ahora son una línea nueva con valor vacío en el campo "No."
                                IF gb_MostrarComentarios = FALSE THEN LineasEventoTMP.Comentarios:='';
                                LineasEventoTMP.ImprCapitulo:=ImprCapitulo;
                                LineasEventoTMP.DescripCapitulo:=DescripCapitulo;
                                LineasEventoTMP.INSERT;
                            END;
                            case "Lineas Evento".Tipo of "Lineas Evento".Tipo::Adulto: begin
                                TotalImporteAdulto:=TotalImporteAdulto + Importe;
                                ContarTotales:=1;
                            end;
                            "Lineas Evento".Tipo::"Niño": begin
                                TotalImporteNinno:=TotalImporteNinno + Importe;
                                ContarTotales:=2;
                            end;
                            end;
                            VATAmountLineTMP.RESET;
                            VATAmountLineTMP.SETRANGE("VAT %", "Lineas Evento"."% IVA");
                            IF VATAmountLineTMP.FINDFIRST THEN BEGIN
                                VATAmountLineTMP."VAT Base":=VATAmountLineTMP."VAT Base" + "Lineas Evento".Importe;
                                VATAmountLineTMP."Amount Including VAT":=ROUND(VATAmountLineTMP."VAT Base" * (1 + VATAmountLineTMP."VAT %" / 100), GLSetup."Amount Rounding Precision");
                                VATAmountLineTMP."VAT Amount":=VATAmountLineTMP."Amount Including VAT" - VATAmountLineTMP."VAT Base";
                                VATAmountLineTMP.MODIFY;
                            END
                            ELSE
                            BEGIN
                                VATAmountLineTMP.INIT;
                                VATAmountLineTMP."VAT Identifier":=FORMAT("Lineas Evento"."% IVA");
                                VATAmountLineTMP."VAT %":="Lineas Evento"."% IVA";
                                VATAmountLineTMP."VAT Base":="Lineas Evento".Importe;
                                VATAmountLineTMP."Amount Including VAT":=ROUND(VATAmountLineTMP."VAT Base" * (1 + VATAmountLineTMP."VAT %" / 100), GLSetup."Amount Rounding Precision");
                                VATAmountLineTMP."VAT Amount":=VATAmountLineTMP."Amount Including VAT" - VATAmountLineTMP."VAT Base";
                                VATAmountLineTMP.INSERT;
                            END;
                        end;
                        trigger OnPreDataItem()
                        var
                            lt_VATPostingSetup: Record 325;
                            GLAccount: Record 15;
                            GrupoRegIVANeg: Code[20];
                            lt_Customer: Record 18;
                            lt_CustTemplate: Record "Customer Templ.";
                            EventLns: Record "Lineas Evento";
                            NroLineaComm: Integer;
                        begin
                            LineasEventoTMP.RESET;
                            LineasEventoTMP.DELETEALL;
                            VATAmountLineTMP.RESET;
                            VATAmountLineTMP.DELETEALL;
                            CLEAR(GrupoRegIVANeg);
                            // GAP00045 >>>
                            case "Lineas Evento".Tipo of "Lineas Evento".Tipo::Adulto: LineasEventoTMP.Orden:=1;
                            "Lineas Evento".Tipo::"Niño": LineasEventoTMP.Orden:=2;
                            end;
                            // GAP00045 <<<
                            if not ImprimirComentarios then SetFilter("No.", '<>%1', '');
                        end;
                    }
                    dataitem("Recursos Evento"; "Recursos Evento")
                    {
                        DataItemLink = "Codigo Evento"=FIELD("Codigo Evento");
                        DataItemLinkReference = Evento;
                        DataItemTableView = SORTING("Codigo Evento", Tipo, Linea)ORDER(Ascending);

                        trigger OnAfterGetRecord()
                        begin
                            TotalImporte:=TotalImporte + Importe;
                            IF "Recursos Evento".Imprime THEN BEGIN
                                LineEventoNo:=LineEventoNo + 10000;
                                LineasEventoTMP.INIT;
                                LineasEventoTMP."Codigo Evento":="Recursos Evento"."Codigo Evento";
                                LineasEventoTMP.Tipo:="Recursos Evento".Tipo + 200; //Para ordenar
                                LineasEventoTMP.Linea:=LineEventoNo;
                                LineasEventoTMP."No.":="Recursos Evento"."Codigo Recurso";
                                LineasEventoTMP.Descripcion:="Recursos Evento".Descripcion;
                                LineasEventoTMP.Cantidad:="Recursos Evento".Cantidad;
                                LineasEventoTMP."Precio Real":="Recursos Evento"."Precio Real";
                                LineasEventoTMP.Importe:="Recursos Evento".Importe;
                                LineasEventoTMP.Comentarios:="Recursos Evento".Comentarios;
                                LineasEventoTMP."Importe IVA Incl.":="Recursos Evento"."Importe IVA Incl.";
                                LineasEventoTMP."% IVA":="Recursos Evento"."% IVA";
                                IF gb_MostrarComentarios = FALSE THEN LineasEventoTMP.Comentarios:='';
                                LineasEventoTMP.ImprCapitulo:=ImprCapitulo;
                                LineasEventoTMP.DescripCapitulo:=DescripCapitulo;
                                LineasEventoTMP.Orden:=6;
                                LineasEventoTMP.INSERT;
                            END;
                            VATAmountLineTMP.RESET;
                            VATAmountLineTMP.SETRANGE("VAT %", "Recursos Evento"."% IVA");
                            IF VATAmountLineTMP.FINDFIRST THEN BEGIN
                                VATAmountLineTMP."VAT Base":=VATAmountLineTMP."VAT Base" + "Recursos Evento".Importe;
                                VATAmountLineTMP."Amount Including VAT":=ROUND(VATAmountLineTMP."VAT Base" * (1 + VATAmountLineTMP."VAT %" / 100), GLSetup."Amount Rounding Precision");
                                VATAmountLineTMP."VAT Amount":=VATAmountLineTMP."Amount Including VAT" - VATAmountLineTMP."VAT Base";
                                VATAmountLineTMP.MODIFY;
                            END
                            ELSE
                            BEGIN
                                VATAmountLineTMP.INIT;
                                VATAmountLineTMP."VAT Identifier":=FORMAT("Recursos Evento"."% IVA");
                                VATAmountLineTMP."VAT %":="Recursos Evento"."% IVA";
                                VATAmountLineTMP."VAT Base":="Recursos Evento".Importe;
                                VATAmountLineTMP."Amount Including VAT":=ROUND(VATAmountLineTMP."VAT Base" * (1 + VATAmountLineTMP."VAT %" / 100), GLSetup."Amount Rounding Precision");
                                VATAmountLineTMP."VAT Amount":=VATAmountLineTMP."Amount Including VAT" - VATAmountLineTMP."VAT Base";
                                VATAmountLineTMP.INSERT;
                            END;
                        end;
                    }
                    dataitem("Productos Evento"; "Productos Evento")
                    {
                        DataItemLink = "Codigo Evento"=FIELD("Codigo Evento");
                        DataItemLinkReference = Evento;
                        DataItemTableView = SORTING("Codigo Evento", Tipo, Linea)ORDER(Ascending);

                        trigger OnAfterGetRecord()
                        begin
                            TotalImporte:=TotalImporte + Importe;
                            // Inicio ADV001
                            IF "Productos Evento".Imprime THEN BEGIN
                                LineEventoNo:=LineEventoNo + 10000;
                                LineasEventoTMP.INIT;
                                LineasEventoTMP."Codigo Evento":="Productos Evento"."Codigo Evento";
                                // Inicio ADV002
                                CASE "Productos Evento".Tipo OF // Para ordenar
 0: begin
                                    LineasEventoTMP.Tipo:="Productos Evento".Tipo + 300; //Personal
                                    LineasEventoTMP.Orden:=5;
                                end;
                                1: begin
                                    LineasEventoTMP.Tipo:="Productos Evento".Tipo + 300; //Otros
                                    // ADV002 2:  LineasEventoTMP.Tipo := "Productos Evento".Tipo + 250; //Menaje Desechable
                                    LineasEventoTMP.Orden:=99;
                                end;
                                2: begin
                                    LineasEventoTMP.Tipo:="Productos Evento".Tipo + 199; //Menaje Desechable
                                    LineasEventoTMP.Orden:=4;
                                end;
                                3: begin
                                    LineasEventoTMP.Tipo:="Productos Evento".Tipo + 300; //Suplementos
                                    LineasEventoTMP.Orden:=7;
                                end;
                                4: begin
                                    LineasEventoTMP.Tipo:="Productos Evento".Tipo + 150; //Pan
                                    LineasEventoTMP.Orden:=3;
                                end;
                                END;
                                // Fin ADV002
                                LineasEventoTMP.Linea:=LineEventoNo;
                                LineasEventoTMP."No.":="Productos Evento".Producto;
                                LineasEventoTMP.Descripcion:="Productos Evento".Descripcion;
                                LineasEventoTMP.Cantidad:="Productos Evento".Cantidad;
                                LineasEventoTMP."Precio Real":="Productos Evento"."Precio Real";
                                LineasEventoTMP.Importe:="Productos Evento".Importe;
                                LineasEventoTMP.Comentarios:="Productos Evento".Comentarios;
                                LineasEventoTMP."Importe IVA Incl.":="Productos Evento"."Importe IVA Incl.";
                                LineasEventoTMP."% IVA":="Productos Evento"."% IVA";
                                IF gb_MostrarComentarios = FALSE THEN LineasEventoTMP.Comentarios:='';
                                LineasEventoTMP.ImprCapitulo:=ImprCapitulo;
                                LineasEventoTMP.DescripCapitulo:=DescripCapitulo;
                                LineasEventoTMP.INSERT;
                            END;
                            VATAmountLineTMP.RESET;
                            VATAmountLineTMP.SETRANGE("VAT %", "Productos Evento"."% IVA");
                            IF VATAmountLineTMP.FINDFIRST THEN BEGIN
                                VATAmountLineTMP."VAT Base":=VATAmountLineTMP."VAT Base" + Importe;
                                VATAmountLineTMP."Amount Including VAT":=ROUND(VATAmountLineTMP."VAT Base" * (1 + VATAmountLineTMP."VAT %" / 100), GLSetup."Amount Rounding Precision");
                                VATAmountLineTMP."VAT Amount":=VATAmountLineTMP."Amount Including VAT" - VATAmountLineTMP."VAT Base";
                                VATAmountLineTMP.MODIFY;
                            END
                            ELSE
                            BEGIN
                                VATAmountLineTMP.INIT;
                                VATAmountLineTMP."VAT Identifier":=FORMAT("Productos Evento"."% IVA");
                                VATAmountLineTMP."VAT %":="Productos Evento"."% IVA";
                                VATAmountLineTMP."VAT Base":="Productos Evento".Importe;
                                VATAmountLineTMP."Amount Including VAT":=ROUND(VATAmountLineTMP."VAT Base" * (1 + VATAmountLineTMP."VAT %" / 100), GLSetup."Amount Rounding Precision");
                                VATAmountLineTMP."VAT Amount":=VATAmountLineTMP."Amount Including VAT" - VATAmountLineTMP."VAT Base";
                                VATAmountLineTMP.INSERT;
                            END;
                        // Fin ADV001
                        end;
                    }
                    dataitem(LineasEventoTemp; Integer)
                    {
                        DataItemLinkReference = Evento;
                        DataItemTableView = SORTING(Number);
                        PrintOnlyIfDetail = false;
                        UseTemporary = false;

                        column(LineasEvento_Tipo; LineasEventoTMP.Tipo)
                        {
                        }
                        column(LineasEvento_Linea; LineasEventoTMP.Linea)
                        {
                        }
                        column(LineasEvento_No; LineasEventoTMP."No.")
                        {
                        }
                        column(LineasEvento_Descripcion; LineasEventoTMP.Descripcion)
                        {
                        }
                        column(LineasEvento_Cantidad; LineasEventoTMP.Cantidad)
                        {
                        }
                        column(LineasEvento_PrecioReal; LineasEventoTMP."Precio Real")
                        {
                        DecimalPlaces = 2: 3;
                        }
                        column(LineasEvento_Importe; LineasEventoTMP.Importe)
                        {
                        }
                        column(LineasEvento_Comentario; LineasEventoTMP.Comentarios)
                        {
                        }
                        column(LineasEvento_Capitulo; LineasEventoTMP.DescripCapitulo)
                        {
                        }
                        column(LineasEvento_TipoDeImpresion; TipoDeImpresion)
                        {
                        }
                        column(LineasEvento_Orden; LineasEventoTMP.Orden)
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN BEGIN
                                LineasEventoTMP.FINDSET END
                            ELSE
                                LineasEventoTMP.NEXT;
                        end;
                        trigger OnPreDataItem()
                        begin
                            LineasEventoTMP.RESET;
                            LineasEventoTMP.SETCURRENTKEY("Codigo Evento", Tipo, Linea);
                            SETRANGE(Number, 1, LineasEventoTMP.COUNT);
                        end;
                    }
                    dataitem(TotalMenu; Integer)
                    {
                        DataItemLinkReference = Evento;
                        DataItemTableView = sorting(Number);
                        PrintOnlyIfDetail = false;
                        UseTemporary = false;

                        column(TotalMenu_Caption; TotalMenuDesc)
                        {
                        }
                        column(TotalMenu_Importe; StrSubstNo(TotalDetalleLbl, Format(TotalMenuImp, 0, '<Precision,2:2><Standard Format,0>'), "Lineas Evento"."% IVA"))
                        {
                        }
                        column(TotalMenu_IVA; TotalMenuIVA)
                        {
                        }
                        trigger OnPreDataItem()
                        begin
                            SetRange(Number, 1, ContarTotales);
                        end;
                        trigger OnAfterGetRecord()
                        begin
                            if ContarTotales = 1 then begin
                                TotalMenuDesc:='TOTAL MENU';
                                TotalMenuImp:=TotalImporte / Evento."Total Adultos";
                            end
                            else
                            begin
                                case Number of 1: begin
                                    TotalMenuDesc:='TOTAL MENU ADULTO';
                                    TotalMenuImp:=(TotalImporte - TotalImporteNinno) / Evento."Total Adultos";
                                end;
                                2: begin
                                    TotalMenuDesc:='TOTAL MENU NIÑO';
                                    TotalMenuImp:=TotalImporteNinno / Evento."Total Ninos";
                                end;
                                end;
                            end;
                        end;
                    }
                    dataitem(VATCounter; Integer)
                    {
                        DataItemTableView = SORTING(Number);

                        column(VAT_VATPorc; VATAmountLineTMP."VAT %")
                        {
                        }
                        column(VAT_Base; VATAmountLineTMP."VAT Base")
                        {
                        }
                        column(VAT_AmounIncVAT; VATAmountLineTMP."Amount Including VAT")
                        {
                        }
                        column(VAT_VATAmount; VATAmountLineTMP."VAT Amount")
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN BEGIN
                                VATAmountLineTMP.FINDSET END
                            ELSE
                                VATAmountLineTMP.NEXT;
                        end;
                        trigger OnPreDataItem()
                        begin
                            VATAmountLineTMP.RESET;
                            VATAmountLineTMP.SETCURRENTKEY("VAT %", "EC %");
                            SETRANGE(Number, 1, VATAmountLineTMP.COUNT);
                        end;
                    }
                }
                trigger OnAfterGetRecord()
                begin
                    IF Number > 1 THEN BEGIN
                        CopyText:=Text003;
                        OutputNo+=1;
                    END;
                end;
                trigger OnPreDataItem()
                begin
                    NoOfLoops:=ABS(NoOfCopies) + 1;
                    IF NoOfLoops <= 0 THEN NoOfLoops:=1;
                    CopyText:='';
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo:=1;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                GLSetup.GET;
                SalesReceivablesSetup.GET;
                FormatAddr.Company(CompanyAddr, CompanyInfo);
                IF "Cod Teminos Pago" = '' THEN PaymentTerms.INIT
                ELSE
                    PaymentTerms.GET("Cod Teminos Pago");
                IF "Cod Forma Pago" = '' THEN PaymentMethod.INIT
                ELSE
                    PaymentMethod.GET("Cod Forma Pago");
                LineEventoNo:=0;
                IF gb_MostrarComentarios = FALSE THEN Comentario:='';
                IF Evento.Estado IN[Evento.Estado::Realizado, Evento.Estado::Aceptado]THEN BEGIN
                    TituloReport:=PedidoCaptionLbl;
                    TxtTotal:=TotalCaptionlbl + ' ' + PedidoCaptionLbl;
                    gb_Pedido:=TRUE;
                END
                ELSE
                BEGIN
                    TituloReport:=PresupuestoCaptionLbl;
                    TxtTotal:=TotalCaptionlbl + ' ' + PresupuestoCaptionLbl;
                END;
                CLEAR(txtComentarioEvento);
                txtComentarioEvento:=Evento.Comentario;
                IF Evento.Comentario2 <> '' THEN txtComentarioEvento:=txtComentarioEvento + ' ' + Evento.Comentario2;
                IniciarTotales();
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field(NoOfCopies; NoOfCopies)
                    {
                        ApplicationArea = All;
                        Caption = 'No. of Copies';
                        Visible = false;
                    }
                    field(gb_MostrarComentarios; gb_MostrarComentarios)
                    {
                        ApplicationArea = All;
                        Caption = 'Mostrar comentarios';
                    }
                }
            }
        }
        actions
        {
        }
        trigger OnOpenPage()
        begin
            gb_MostrarComentarios:=TRUE;
        end;
    }
    rendering
    {
        layout(ImpresionPorCapituloDtl)
        {
            Type = RDLC;
            Caption = 'Informe Evento - Impresión por Capítulo Detallado';
            LayoutFile = './src/Layout/50011.InformeEventoImpresionPorCapituloDtl.rdl';
            Summary = './src/Layout/50011.InformeEventoImpresionPorCapituloDtl.rdl';
        }
    }
    labels
    {
    // Etiquetas de la cabecera
    Lbl_NroEvento='N° evento';
    Lbl_FechaEvento='Fecha evento';
    Lbl_HoraEvento='Hora evento';
    Lbl_TerminoPago='Términos de pago';
    Lbl_FormaPago='Forma de pago';
    Lbl_CIF='CIF';
    Lbl_Contacto='Contacto';
    Lbl_NroTelefono='N° teléfono';
    Lbl_Email='Email';
    Lbl_LugarEvento='Lugar evento';
    Lbl_Direccion='Dirección';
    Lbl_CpLocalidad='CP. localidad';
    Lbl_Provincia='Provincia';
    // Etiquetas del cuerpo
    LblReferencia='Marca / Referencia';
    LblDescripcion='Descripción';
    LblCantidad='Cantidad';
    LblPrecio='Precio';
    LblImporte='Importe';
    lblBase='Base Imponible';
    lblIVA='% IVA';
    lblImporteIVA='Importe IVA';
    lblTotalParcial='Total Parcial';
    lblSenalizado='SEÑALIZADO';
    lblImpSenal='Importe Señal';
    lblImpPendiente='Importe Pendiente';
    }
    trigger OnInitReport()
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);
    end;
    procedure ModificarFiltrosDelEvento(NewTipoDeImpresion: Enum AlxiaEventoTipodeImpresion; NewImprimirComentarios: Boolean)
    begin
        ImprimirComentarios:=NewImprimirComentarios;
        TipoDeImpresion:=NewTipoDeImpresion;
    end;
    var PaymentMethod: Record 289;
    PaymentTerms: Record 3;
    CompanyInfo: Record 79;
    SalesReceivablesSetup: Record 311;
    GLSetup: Record 98;
    LineasEventoTMP: Record "Lineas Evento" temporary;
    #pragma warning disable AL0432
    VATAmountLineTMP: Record 290 temporary;
    #pragma warning restore AL0432
    FormatAddr: Codeunit 365;
    NoOfCopies: Integer;
    NoOfLoops: Integer;
    CopyText: Text[30];
    OutputNo: Integer;
    CompanyAddr: array[8]of Text[50];
    LineEventoNo: Integer;
    TituloReport: Text[100];
    TxtTotal: Text[200];
    gb_Pedido: Boolean;
    gb_MostrarComentarios: Boolean;
    txtComentarioEvento: Text[550];
    ImprimirComentarios: Boolean;
    ContarTotales: Integer;
    TotalImporteAdulto: Decimal;
    TotalImporteNinno: Decimal;
    TotalImporte: Decimal;
    TotalMenuDesc: Text;
    TotalMenuImp: Decimal;
    TotalMenuIVA: Text;
    TipoDeImpresion: Enum AlxiaEventoTipodeImpresion;
    Text003: Label 'COPIA';
    PageCaptionCap: Label 'Página %1 de %2';
    PhoneNoCaptionLbl: Label 'Nº teléfono';
    VATRegNoCaptionLbl: Label 'CIF/NIF';
    HomePageCaptionCap: Label 'Home Page';
    EmailCaptionLbl: Label 'E-Mail';
    PmtTermsDescCaptionLbl: Label 'Términos pago';
    PmtMethodDescCaptionLbl: Label 'Forma pago';
    FaxNoCaptionLbl: Label 'Nº fax';
    PresupuestoCaptionLbl: Label 'Presupuesto';
    PedidoCaptionLbl: Label 'Pedido';
    NoClienteCaptionLbl: Label 'Nº cliente';
    NoContactoCaptionLbl: Label 'Nº contacto';
    FechaEventoCaptionLbl: Label 'Fecha evento';
    NoEventoCaptionLbl: Label 'Nº evento';
    FechaAltaCaptionLbl: Label 'Fecha alta';
    TotalCaptionlbl: Label 'Total';
    TotalDetalleLbl: Label '%1 € + %2% IVA', Locked = true;
    local procedure IniciarTotales()
    begin
        ContarTotales:=0;
        TotalImporteAdulto:=0;
        TotalImporteNinno:=0;
        TotalMenuDesc:='';
        TotalMenuImp:=0;
        TotalMenuIVA:='';
    end;
}
