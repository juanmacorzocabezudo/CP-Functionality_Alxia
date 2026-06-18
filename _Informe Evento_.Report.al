report 50007 "Informe Evento"
{
    // ADVANCE - Log de cambios
    // -----------------------------------------------------
    //   ADVANCE
    //   Fecha: 24-03-2017
    //   Técnico: JAB
    //   Presupuesto: Proyecto I004157 - Añadir nuevo desglose
    //   Modificación: Incluir las líneas del nuevo desglose de Menaje Desechable, Suplementos Evento
    //                 y Pan Evento. (Table 50016 - Productos Evento)
    // 
    //   Etiqueta: ADV001
    // -----------------------------------------------------
    //   ADVANCE
    //   Fecha: 21-04-2017
    //   Técnico: JAB
    //   Presupuesto: Proyecto I004340 - Reordenación Líneas
    //   Modificación: Reordenar la ordenación en el que aparecen impresas las diferentes secciones
    //                 del informe, según lo indicado en un mail por Javier Ayuso.
    //                 El orden en el que deben mostrarse será:
    //                   1.Menú
    //                   2.Pan
    //                   3.Personal
    //                   4.Menajes, Mobiliario, Transporte: en este grupo debe pintar los 2 Menajes
    //                       internamente separados, en el mismo grupo.
    //                   5.Suplementos
    // 
    //   Etiqueta: ADV002
    // -----------------------------------------------------
    DefaultRenderingLayout = ImpresionInformeEvento;

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
            dataitem(CopyLoop;2000000026)
            {
                DataItemTableView = SORTING(Number);

                dataitem(PageLoop;2000000026)
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
                            if TipoDeImpresion = TipoDeImpresion::"Impresion Concepto Generico" then CurrReport.BREAK;
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
                            if TipoDeImpresion = TipoDeImpresion::"Impresion Concepto Generico" then begin
                                Evento.TestField("Concepto Generico Facturacion");
                                LineasEventoTMP.INIT;
                                LineasEventoTMP."Codigo Evento":=Evento."Codigo Evento";
                                LineasEventoTMP.Linea:=10000;
                                //valor no codificado en el layout, saldra en blanco.
                                LineasEventoTMP.Tipo:=50;
                                //Para que no se visualice el numero                              
                                LineasEventoTMP."No.":='';
                                LineasEventoTMP.Descripcion:=Evento."Concepto Generico Facturacion";
                                LineasEventoTMP.Cantidad:=1;
                                LineasEventoTMP."Precio Real":=Evento."Importe Total Evento";
                                LineasEventoTMP.Importe:=Evento."Importe Total Evento";
                                // GAP00045 >>>
                                case "Lineas Evento".Tipo of "Lineas Evento".Tipo::Adulto: LineasEventoTMP.Orden:=1;
                                "Lineas Evento".Tipo::"Niño": LineasEventoTMP.Orden:=2;
                                end;
                                // GAP00045 <<<
                                LineasEventoTMP.INSERT;
                                if ImprimirComentarios then begin
                                    EventLns.Reset();
                                    EventLns.SetRange("Codigo Evento", Evento."Codigo Evento");
                                    EventLns.SetRange("No.", '');
                                    if EventLns.FindSet()then begin
                                        NroLineaComm:=10000;
                                        repeat NroLineaComm:=NroLineaComm + 10000;
                                            LineasEventoTMP.Init();
                                            LineasEventoTMP."Codigo Evento":=Evento."Codigo Evento";
                                            LineasEventoTMP.Linea:=NroLineaComm;
                                            LineasEventoTMP.Tipo:=50;
                                            LineasEventoTMP.Comentarios:=EventLns.Descripcion;
                                            // GAP00045 >>>
                                            case "Lineas Evento".Tipo of "Lineas Evento".Tipo::Adulto: LineasEventoTMP.Orden:=1;
                                            "Lineas Evento".Tipo::"Niño": LineasEventoTMP.Orden:=2;
                                            end;
                                            // GAP00045 <<<
                                            LineasEventoTMP.Insert();
                                        until EventLns.Next() = 0;
                                    end;
                                end;
                                //end;
                                GLAccount.GET(SalesReceivablesSetup."Cuenta Eventos");
                                GLAccount.TESTFIELD("VAT Prod. Posting Group");
                                IF Evento."Codigo Cliente" <> '' THEN BEGIN
                                    lt_Customer.GET(Evento."Codigo Cliente");
                                    lt_Customer.TESTFIELD("VAT Bus. Posting Group");
                                    GrupoRegIVANeg:=lt_Customer."VAT Bus. Posting Group";
                                END
                                ELSE
                                BEGIN
                                    Evento.TESTFIELD("Plantilla Cliente");
                                    lt_CustTemplate.GET(Evento."Plantilla Cliente");
                                    lt_CustTemplate.TESTFIELD("VAT Bus. Posting Group");
                                    GrupoRegIVANeg:=lt_CustTemplate."VAT Bus. Posting Group";
                                END;
                                lt_VATPostingSetup.GET(GrupoRegIVANeg, GLAccount."VAT Prod. Posting Group");
                                VATAmountLineTMP.INIT;
                                VATAmountLineTMP."VAT Identifier":=FORMAT(lt_VATPostingSetup."VAT %");
                                IF Evento.Estado = Evento.Estado::Archivado THEN VATAmountLineTMP."VAT %":=0
                                ELSE
                                    VATAmountLineTMP."VAT %":=lt_VATPostingSetup."VAT %";
                                VATAmountLineTMP."VAT Base":=Evento."Importe Total Evento";
                                VATAmountLineTMP."Amount Including VAT":=ROUND(VATAmountLineTMP."VAT Base" * (1 + VATAmountLineTMP."VAT %" / 100), GLSetup."Amount Rounding Precision");
                                VATAmountLineTMP."VAT Amount":=VATAmountLineTMP."Amount Including VAT" - VATAmountLineTMP."VAT Base";
                                VATAmountLineTMP.INSERT;
                            END;
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
                            if TipoDeImpresion = TipoDeImpresion::"Impresion Concepto Generico" then CurrReport.Break();
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
                            if TipoDeImpresion = TipoDeImpresion::"Impresion Concepto Generico" then CurrReport.Break();
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
                                3: LineasEventoTMP.Tipo:="Productos Evento".Tipo + 300; //Suplementos
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
                                VATAmountLineTMP."VAT Base":=VATAmountLineTMP."VAT Base" + "Productos Evento".Importe;
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
                    dataitem(LineasEventoTemp;2000000026)
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
                    dataitem(VATCounter;2000000026)
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
                IF TipoDeImpresion = TipoDeImpresion::"Impresion Concepto Generico" THEN SalesReceivablesSetup.TESTFIELD("Cuenta Eventos");
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
        layout(ImpresionInformeEvento)
        {
            Type = RDLC;
            Caption = 'Informe Evento';
            LayoutFile = './src/Layout/50007.InformeEvento.rdl';
            Summary = './src/Layout/50007.InformeEvento.rdl';
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
    CifNif_Caption='CIF/NIF: ';
    NroTelefono_Caption='N° teléfono: ';
    NroFax_Caption='N° fax: ';
    EMail_Caption='E-Mail: ';
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
    var NoOfCopies: Integer;
    NoOfLoops: Integer;
    CopyText: Text[30];
    OutputNo: Integer;
    Text003: Label 'COPIA';
    PageCaptionCap: Label 'Página %1 de %2';
    PhoneNoCaptionLbl: Label 'Nº teléfono';
    VATRegNoCaptionLbl: Label 'CIF/NIF';
    HomePageCaptionCap: Label 'Home Page';
    EmailCaptionLbl: Label 'E-Mail';
    PaymentMethod: Record 289;
    PaymentTerms: Record 3;
    CompanyInfo: Record 79;
    FormatAddr: Codeunit 365;
    CompanyAddr: array[8]of Text[50];
    PmtTermsDescCaptionLbl: Label 'Términos pago';
    PmtMethodDescCaptionLbl: Label 'Forma pago';
    LineasEventoTMP: Record 50002 temporary;
    LineEventoNo: Integer;
    FaxNoCaptionLbl: Label 'Nº fax';
    TituloReport: Text[100];
    PresupuestoCaptionLbl: Label 'Presupuesto';
    PedidoCaptionLbl: Label 'Pedido';
    NoClienteCaptionLbl: Label 'Nº cliente';
    NoContactoCaptionLbl: Label 'Nº contacto';
    FechaEventoCaptionLbl: Label 'Fecha evento';
    NoEventoCaptionLbl: Label 'Nº evento';
    FechaAltaCaptionLbl: Label 'Fecha alta';
    #pragma warning disable AL0432
    VATAmountLineTMP: Record 290 temporary;
    #pragma warning restore AL0432
    TxtTotal: Text[200];
    TotalCaptionlbl: Label 'Total';
    SalesReceivablesSetup: Record 311;
    GLSetup: Record 98;
    gb_Pedido: Boolean;
    gb_MostrarComentarios: Boolean;
    txtComentarioEvento: Text[550];
    ImprimirComentarios: Boolean;
    TipoDeImpresion: Enum AlxiaEventoTipodeImpresion;
    procedure ModificarFiltrosDelEvento(NewTipoDeImpresion: Enum AlxiaEventoTipodeImpresion; NewImprimirComentarios: Boolean)
    begin
        ImprimirComentarios:=NewImprimirComentarios;
        TipoDeImpresion:=NewTipoDeImpresion;
    end;
}
