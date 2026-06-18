report 50008 "Cuadrante Eventos"
{
    // 
    // ADVANCE - Log de cambios
    // -----------------------------------------------------
    //   ADVANCE
    //   Fecha: 10-05-2016
    //   Técnico: JMAP
    //   Presupuesto: Proyecto I002380 - Ajuste de documentos de ventas
    //   Modificación:
    // 
    //   Etiqueta: ADV001
    // -----------------------------------------------------
    //   ADVANCE
    //   Fecha: 30-05-2017
    //   Técnico: JAB
    //   Presupuesto: Proyecto I004535 - Incluir la gestión de la tabla 50016
    // 
    //   Etiqueta: ADV002
    // -----------------------------------------------------
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layout/CuadranteEventos.rdlc';

    dataset
    {
        dataitem(Evento;50004)
        {
            DataItemTableView = SORTING("Fecha Evento", "Hora Evento")ORDER(Ascending);
            RequestFilterFields = "Fecha Evento";

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
            column(CambiaFecha; CambiaFecha)
            {
            }
            column(muestra; muestra)
            {
            }
            column(HoraEvento; Evento."Hora Evento")
            {
            }
            column(FechaReport; FORMAT(WORKDATE, 0, 4))
            {
            }
            column(Evento_FechaEvento; Evento."Fecha Evento")
            {
            }
            column(Hora; Evento."Franja horaria")
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
                    #pragma warning disable AL0432
                    column(CompanyInfoHomePage; CompanyInfo."Home Page")
                    {
                    }
                    #pragma warning restore AL0432
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
                    column(TipoEvento; TipoEvento)
                    {
                    }
                    column(Evento_Descripcion; Evento.Descripcion)
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
                    column(Evento_Telefono; Evento."Telefono 2")
                    {
                    }
                    column(Evento_Email; Evento."E-Mail 2")
                    {
                    }
                    column(Evento_TotalAdultos; Evento."Total Adultos")
                    {
                    }
                    column(Evento_TotalNinos; Evento."Total Ninos")
                    {
                    }
                    column(Evento_Barras; Evento.Barras)
                    {
                    }
                    column(Evento_Gallegas; Evento.Gallegas)
                    {
                    }
                    column(Evento_Colines; Evento.Colines)
                    {
                    }
                    column(Evento_Alcachofas; Evento.Alcachofas)
                    {
                    }
                    column(NoClienteCaption; NoClienteCaptionLbl)
                    {
                    }
                    column(NoContactoCaption; NoContactoCaptionLbl)
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
                    column(Evento_Pedido; gb_Pedido)
                    {
                    }
                    column(Evento_Comentarios; txtComentarios)
                    {
                    }
                    dataitem("Lineas Evento";50002)
                    {
                        DataItemLink = "Codigo Evento"=FIELD("Codigo Evento");
                        DataItemLinkReference = Evento;
                        DataItemTableView = SORTING("Codigo Evento", Linea)ORDER(Ascending);

                        column(Linea_LineasEvento; "Lineas Evento".Linea)
                        {
                        }
                        column(Tipo_LineasEvento; "Lineas Evento".Tipo)
                        {
                        }
                        column(No_LineasEvento; "Lineas Evento"."No.")
                        {
                        }
                        column(Descripcion_LineasEvento; "Lineas Evento".Descripcion)
                        {
                        }
                        column(Cantidad_LineasEvento; "Lineas Evento".Cantidad)
                        {
                        }
                        column(Comentarios_LineasEvento; "Lineas Evento".Comentarios)
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            //Se cambia el Tipo para ordenar por este campo y que salga primero el menú otros
                            IF "Lineas Evento".Tipo = "Lineas Evento".Tipo::Otros THEN "Lineas Evento".Tipo:=90
                            ELSE
                                "Lineas Evento".Tipo:="Lineas Evento".Tipo + 100;
                        end;
                        trigger OnPreDataItem()
                        var
                            lt_VATPostingSetup: Record 325;
                            GLAccount: Record 15;
                            GrupoRegIVANeg: Code[20];
                            lt_Customer: Record 18;
                            lt_CustTemplate: Record "Customer Templ.";
                        begin
                        end;
                    }
                    dataitem(DataItem1000000014;2000000026)
                    {
                        DataItemLinkReference = Evento;
                        DataItemTableView = SORTING(Number);

                        column(CodigoRecurso_RecursosEvento; ColumnaSuplementosTMP."Codigo Recurso")
                        {
                        }
                        column(Tipo_RecursosEvento; ColumnaSuplementosTMP.Tipo)
                        {
                        }
                        column(Linea_RecursosEvento; ColumnaSuplementosTMP.Linea)
                        {
                        }
                        column(Descripcion_RecursosEvento; ColumnaSuplementosTMP.Descripcion)
                        {
                        }
                        column(Cantidad_RecursosEvento; ColumnaSuplementosTMP.Cantidad)
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN BEGIN
                                ColumnaSuplementosTMP.FINDSET END
                            ELSE
                                ColumnaSuplementosTMP.NEXT;
                        end;
                        trigger OnPreDataItem()
                        var
                            Rcd_RecursosEvento: Record 50003;
                            NoLinea: Integer;
                            Rcd_ProductosEvento: Record 50016;
                        begin
                            // ADV002 SETRANGE(Tipo,"Recursos Evento".Tipo::Otros);
                            // Inicio ADV002
                            ColumnaSuplementosTMP.RESET;
                            ColumnaSuplementosTMP.DELETEALL;
                            NoLinea:=0;
                            // Recorro la tabla Recursos Evento (50003)
                            Rcd_RecursosEvento.RESET;
                            Rcd_RecursosEvento.SETRANGE("Codigo Evento", Evento."Codigo Evento");
                            Rcd_RecursosEvento.SETRANGE(Tipo, Rcd_RecursosEvento.Tipo::Otros);
                            IF Rcd_RecursosEvento.FINDSET THEN REPEAT ColumnaSuplementosTMP.INIT;
                                    ColumnaSuplementosTMP."Codigo Evento":=Rcd_RecursosEvento."Codigo Evento";
                                    ColumnaSuplementosTMP.Tipo:=Rcd_RecursosEvento.Tipo;
                                    NoLinea:=NoLinea + 1;
                                    ColumnaSuplementosTMP.Linea:=NoLinea;
                                    ColumnaSuplementosTMP."Codigo Recurso":=Rcd_RecursosEvento."Codigo Recurso";
                                    ColumnaSuplementosTMP.Descripcion:=Rcd_RecursosEvento.Descripcion;
                                    ColumnaSuplementosTMP.Cantidad:=Rcd_RecursosEvento.Cantidad;
                                    ColumnaSuplementosTMP.INSERT;
                                UNTIL Rcd_RecursosEvento.NEXT = 0;
                            // Recorro la tabla Productos Evento (50016)
                            Rcd_ProductosEvento.RESET;
                            Rcd_ProductosEvento.SETRANGE("Codigo Evento", Evento."Codigo Evento");
                            IF Rcd_ProductosEvento.FINDSET THEN REPEAT ColumnaSuplementosTMP.INIT;
                                    ColumnaSuplementosTMP."Codigo Evento":=Rcd_ProductosEvento."Codigo Evento";
                                    ColumnaSuplementosTMP.Tipo:=Rcd_ProductosEvento.Tipo;
                                    NoLinea:=NoLinea + 1;
                                    ColumnaSuplementosTMP.Linea:=NoLinea;
                                    ColumnaSuplementosTMP.Descripcion:=Rcd_ProductosEvento.Descripcion;
                                    ColumnaSuplementosTMP.Cantidad:=Rcd_ProductosEvento.Cantidad;
                                    ColumnaSuplementosTMP.INSERT;
                                UNTIL Rcd_ProductosEvento.NEXT = 0;
                            ColumnaSuplementosTMP.RESET;
                            SETRANGE(Number, 1, ColumnaSuplementosTMP.COUNT);
                        // Fin ADV002
                        end;
                    }
                    dataitem(PersonalEvento;2000000026)
                    {
                        DataItemLinkReference = Evento;
                        DataItemTableView = SORTING(Number)ORDER(Ascending);

                        column(LineaRecursoEvento_AsignacionRecursosEventos; RecursosEventoTMP.Linea)
                        {
                        }
                        column(CodigoRecurso_AsignacionRecursosEventos; RecursosEventoTMP."Codigo Recurso")
                        {
                        }
                        column(Cantidad_AsignacionRecursosEventos; RecursosEventoTMP.Cantidad)
                        {
                        }
                        column(Descripcion_AsignacionRecursosEventos; RecursosEventoTMP.Descripcion)
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN BEGIN
                                RecursosEventoTMP.FINDSET END
                            ELSE
                                RecursosEventoTMP.NEXT;
                        end;
                        trigger OnPreDataItem()
                        var
                            Rcd_RecursosEvento: Record 50003;
                            NoLinea: Integer;
                            Rcd_AsignacionRecurso: Record 50005;
                        begin
                            RecursosEventoTMP.RESET;
                            RecursosEventoTMP.DELETEALL;
                            NoLinea:=0;
                            Rcd_RecursosEvento.RESET;
                            Rcd_RecursosEvento.SETRANGE("Codigo Evento", Evento."Codigo Evento");
                            Rcd_RecursosEvento.SETRANGE(Tipo, Rcd_RecursosEvento.Tipo::Personal);
                            IF Rcd_RecursosEvento.FINDSET THEN REPEAT Rcd_AsignacionRecurso.RESET;
                                    Rcd_AsignacionRecurso.SETRANGE("Codigo Evento", Rcd_RecursosEvento."Codigo Evento");
                                    Rcd_AsignacionRecurso.SETRANGE("Linea Recurso Evento", Rcd_RecursosEvento.Linea);
                                    Rcd_AsignacionRecurso.SETFILTER("Codigo Recurso", '<>%1', '');
                                    IF Rcd_AsignacionRecurso.FINDSET THEN BEGIN
                                        REPEAT RecursosEventoTMP.INIT;
                                            RecursosEventoTMP."Codigo Evento":=Rcd_AsignacionRecurso."Codigo Evento";
                                            NoLinea:=NoLinea + 1;
                                            RecursosEventoTMP.Linea:=NoLinea;
                                            RecursosEventoTMP."Codigo Recurso":=Rcd_AsignacionRecurso."Codigo Recurso";
                                            RecursosEventoTMP.Descripcion:=Rcd_AsignacionRecurso.Descripcion;
                                            RecursosEventoTMP.Cantidad:=0; //Si es asignacion no se muestra cantidad
                                            RecursosEventoTMP.INSERT;
                                        UNTIL Rcd_AsignacionRecurso.NEXT = 0;
                                    END
                                    ELSE
                                    BEGIN
                                        RecursosEventoTMP.INIT;
                                        RecursosEventoTMP."Codigo Evento":=Rcd_RecursosEvento."Codigo Evento";
                                        NoLinea:=NoLinea + 1;
                                        RecursosEventoTMP.Linea:=NoLinea;
                                        RecursosEventoTMP."Codigo Recurso":=Rcd_RecursosEvento."Codigo Recurso";
                                        RecursosEventoTMP.Descripcion:=Rcd_RecursosEvento.Descripcion;
                                        RecursosEventoTMP.Cantidad:=Rcd_RecursosEvento.Cantidad;
                                        RecursosEventoTMP.INSERT;
                                    END;
                                UNTIL Rcd_RecursosEvento.NEXT = 0;
                            RecursosEventoTMP.RESET;
                            SETRANGE(Number, 1, RecursosEventoTMP.COUNT);
                        end;
                    }
                }
                trigger OnAfterGetRecord()
                begin
                    IF Number > 1 THEN BEGIN
                        CopyText:=Text003;
                        OutputNo+=1;
                    END;
                    #pragma warning disable AL0667
                    CurrReport.PAGENO:=1;
                #pragma warning restore AL0667
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
            var
                Rcd_TipodeEvento: Record 50001;
                Rcd_Resource: Record 156;
                espacio: Char;
                retorno: Char;
                Rcd_LineasEvento: Record 50002;
                Rcd_RecursosEvento: Record 50003;
                Rcd_AsignacionRecursos: Record 50005;
                Rcd_ProductosEvento: Record 50016;
            begin
                GLSetup.GET;
                SalesReceivablesSetup.GET;
                IF Evento."Concepto Generico Facturacion" = '' THEN SalesReceivablesSetup.TESTFIELD("Cuenta Eventos");
                FormatAddr.Company(CompanyAddr, CompanyInfo);
                IF "Cod Teminos Pago" = '' THEN PaymentTerms.INIT
                ELSE
                    PaymentTerms.GET("Cod Teminos Pago");
                IF "Cod Forma Pago" = '' THEN PaymentMethod.INIT
                ELSE
                    PaymentMethod.GET("Cod Forma Pago");
                LineEventoNo:=0;
                gb_Pedido:=(Evento.Estado = Evento.Estado::Aceptado) OR (Evento.Estado = Evento.Estado::Archivado) OR (Evento.Estado = Evento.Estado::Realizado);
                CLEAR(TipoEvento);
                IF Rcd_TipodeEvento.GET(Evento."Tipo Evento")THEN TipoEvento:=Rcd_TipodeEvento.Descripcion;
                IF AuxCambiaFecha = Evento."Fecha Evento" THEN BEGIN
                    muestra:=FALSE;
                //CambiaFecha:=0D;
                END
                ELSE
                BEGIN
                    muestra:=TRUE;
                    AuxCambiaFecha:=Evento."Fecha Evento";
                END;
                IF b_SaltoPagina THEN CambiaFecha:=AuxCambiaFecha;
                CLEAR(txtComentarios);
                txtComentarios:=Evento.Comentario;
                IF Evento.Comentario2 <> '' THEN txtComentarios:=txtComentarios + ' ' + Evento.Comentario2;
                espacio:=10;
                retorno:=13;
                Rcd_RecursosEvento.RESET;
                Rcd_RecursosEvento.SETCURRENTKEY("Codigo Evento", Tipo, Linea);
                Rcd_RecursosEvento.SETRANGE("Codigo Evento", Evento."Codigo Evento");
                Rcd_RecursosEvento.SETFILTER(Comentarios, '<>%1', '');
                IF Rcd_RecursosEvento.FINDSET THEN REPEAT IF txtComentarios <> '' THEN txtComentarios:=txtComentarios + FORMAT(espacio) + FORMAT(retorno);
                        txtComentarios:=txtComentarios + Rcd_RecursosEvento.Comentarios;
                    UNTIL Rcd_RecursosEvento.NEXT = 0;
                Rcd_AsignacionRecursos.RESET;
                Rcd_AsignacionRecursos.SETRANGE("Codigo Evento", Evento."Codigo Evento");
                Rcd_AsignacionRecursos.SETFILTER(Comentarios, '<>%1', '');
                IF Rcd_AsignacionRecursos.FINDSET THEN REPEAT IF txtComentarios <> '' THEN txtComentarios:=txtComentarios + FORMAT(espacio) + FORMAT(retorno);
                        txtComentarios:=txtComentarios + Rcd_AsignacionRecursos.Comentarios;
                    UNTIL Rcd_AsignacionRecursos.NEXT = 0;
                // Inicio ADV002
                Rcd_ProductosEvento.RESET;
                Rcd_ProductosEvento.SETRANGE("Codigo Evento", Evento."Codigo Evento");
                Rcd_ProductosEvento.SETFILTER(Comentarios, '<>%1', '');
                IF Rcd_ProductosEvento.FINDSET THEN REPEAT IF txtComentarios <> '' THEN txtComentarios:=txtComentarios + FORMAT(espacio) + FORMAT(retorno);
                        txtComentarios:=txtComentarios + Rcd_ProductosEvento.Comentarios;
                    UNTIL Rcd_ProductosEvento.NEXT = 0;
            // Fin ADV002
            end;
            trigger OnPreDataItem()
            begin
                CambiaFecha:=0D;
                AuxCambiaFecha:=0D;
                SETFILTER(Estado, '%1|%2', Evento.Estado::Presupuesto, Evento.Estado::Aceptado);
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
                group(Options)
                {
                    Caption = 'Options';

                    field(b_SaltoPagina; b_SaltoPagina)
                    {
                        ApplicationArea = all;
                        Caption = 'Salto pagina por Fecha';
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
    LblClienteContacto='Cliente / Contacto';
    LbConceptos='Conceptos';
    LblNum='Nº';
    LblHora='Hora';
    LblBarra='Barra:';
    lblGallego='Gallego:';
    lblAlcachofa='Alcachofa:';
    lblPicos='Colines:';
    lblComentarios='Comentarios';
    lblTitulo='CUADRANTE DE EVENTOS DE CATERING';
    lblPersonal='PERSONAL';
    lblMobiliario='SUPLEMENTOS';
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
    Text003: Label 'COPY';
    PageCaptionCap: Label 'Página %1 de %2';
    PhoneNoCaptionLbl: Label 'Phone No.';
    VATRegNoCaptionLbl: Label 'VAT Registration No.';
    HomePageCaptionCap: Label 'Home Page';
    EmailCaptionLbl: Label 'E-Mail';
    PaymentMethod: Record 289;
    PaymentTerms: Record 3;
    CompanyInfo: Record 79;
    FormatAddr: Codeunit 365;
    CompanyAddr: array[8]of Text[50];
    PmtTermsDescCaptionLbl: Label 'Payment Terms';
    PmtMethodDescCaptionLbl: Label 'Payment Method';
    LineEventoNo: Integer;
    FaxNoCaptionLbl: Label 'Phone No.';
    PresupuestoCaptionLbl: Label 'Presupuesto';
    PedidoCaptionLbl: Label 'Pedido';
    NoClienteCaptionLbl: Label 'Nº cliente';
    NoContactoCaptionLbl: Label 'Nº contacto';
    FechaEventoCaptionLbl: Label 'Fecha evento';
    NoEventoCaptionLbl: Label 'Nº evento';
    FechaAltaCaptionLbl: Label 'Fecha alta';
    TotalCaptionlbl: Label 'Total';
    SalesReceivablesSetup: Record 311;
    GLSetup: Record 98;
    gb_Pedido: Boolean;
    CambiaFecha: Date;
    muestra: Boolean;
    TipoEvento: Text[50];
    txtComentarios: Text;
    RecursosEventoTMP: Record 50003 temporary;
    b_SaltoPagina: Boolean;
    AuxCambiaFecha: Date;
    ColumnaSuplementosTMP: Record 50003 temporary;
}
