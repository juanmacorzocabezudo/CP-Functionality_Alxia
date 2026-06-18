page 50006 "Ficha Evento"
{
    // 
    // ADVANCE - Log de cambios
    // -----------------------------------------------------
    //   ADVANCE
    //   Fecha: 27-06-2016
    //   Técnico: JMAP
    //   Presupuesto: I002815 - Ampliación y nuevos campos en Eventos
    //   Modificación:
    //   Etiqueta: ADV001
    // -----------------------------------------------------
    //   ADVANCE
    //   Fecha: 28-02-2017
    //   Técnico: JAB
    //   Presupuesto: I003981 - Desglosar el actual botón de Mobiliario, Transporte y Menaje
    //                          en 3 nuevos botones que sean Menaje, Suplementos y Pan.
    //   Etiqueta: ADV002
    // -----------------------------------------------------
    //  ADVANCE
    //   Fecha: 16-09-2019
    //   Técnico: CPL
    //   Presupuesto: Informar si el evento tiene creado el pedido de ensamblado o no
    //   Etiqueta: ADV003
    // -----------------------------------------------------
    RefreshOnActivate = true;
    SourceTable = Evento;
    SourceTableView = SORTING("Codigo Evento")ORDER(Ascending);

    //WHERE(Estado = FILTER(Presupuesto | Aceptado | Rechazado | Anulado));
    layout
    {
        area(content)
        {
            group(Informacion)
            {
                field("Codigo Evento"; Rec."Codigo Evento")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec)THEN CurrPage.UPDATE;
                    end;
                }
                field(Estado; Rec.Estado)
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = StyleText;

                    trigger OnValidate()
                    begin
                        StyleText:=SetStyle;
                    end;
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                }
                field("Franja horaria"; Rec."Franja horaria")
                {
                    ApplicationArea = All;
                }
                field(FechaAlta; Rec.FechaAlta)
                {
                    ApplicationArea = All;
                }
                field(CreadoEnsamblado; Rec.CreadoEnsamblado)
                {
                    ApplicationArea = All;
                }
                group(Anulado)
                {
                    ShowCaption = false;

                    field("Motivo Anulacion"; Rec."Motivo Anulacion")
                    {
                        ApplicationArea = All;
                        //Visible = Rec.Estado = Rec.Estado::Anulado;
                        Visible = true;
                    }
                }
                group(Aceptado)
                {
                    ShowCaption = false;
                    Visible = Rec.Estado = Rec.Estado::Aceptado;

                    field(Contratado; Rec.Contratado)
                    {
                        ApplicationArea = All;
                    }
                    field(Senalizado; Rec.Senalizado)
                    {
                        ApplicationArea = All;
                    }
                    field("Imp Senal"; Rec."Imp Senal")
                    {
                        ApplicationArea = All;
                    }
                }
                field("Oferta Mes Sin IVA"; Rec."Oferta Mes Sin IVA")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        if Rec."Oferta Mes Sin IVA" then Rec.gfu_CalculoCostesPrecios();
                    /*begin
                            Rec."Concepto Generico Facturacion" := '';
                        end;*/
                    end;
                }
                field("Tipo Evento"; Rec."Tipo Evento")
                {
                    ApplicationArea = All;
                }
                field("Variedad Evento"; Rec."Variedad Evento")
                {
                    ApplicationArea = All;
                }
                /*   field("Doble Pan"; Rec."Doble Pan")
                  {
                      ApplicationArea = All;
                      trigger OnValidate()
                      begin
                          IF (Rec."Doble Pan") AND (Rec."Nada Pan") THEN
                              ERROR('No se puede seleccionar Doble de Pan y Nada de Pan a la vez');
                      end;
                  } */
                /*  field("Nada Pan"; Rec."Nada Pan")
                 {
                     ApplicationArea = All;
                     trigger OnValidate()
                     begin
                         IF (Rec."Doble Pan") AND (Rec."Nada Pan") THEN
                             ERROR('No se puede seleccionar Doble de Pan y Nada de Pan a la vez');
                     end;
                 } */
                field("Fecha Evento"; Rec."Fecha Evento")
                {
                    ApplicationArea = All;
                }
                field("Hora Evento"; Rec."Hora Evento")
                {
                    ApplicationArea = All;
                }
                field("Total Adultos"; Rec."Total Adultos")
                {
                    ApplicationArea = All;
                }
                field("Total Ninos"; Rec."Total Ninos")
                {
                    ApplicationArea = All;
                }
                field("Concepto Generico Facturacion"; Rec."Concepto Generico Facturacion")
                {
                    ApplicationArea = All;
                    Editable = not Rec."Oferta Mes Sin IVA";
                }
                field(CodVendedor; Rec.CodVendedor)
                {
                    ApplicationArea = All;
                }
                field("Commission %"; Rec."Commission %")
                {
                    Caption = 'Comisión';
                    ApplicationArea = All;
                }
                field(ComoNosConociste; Rec.ComoNosConocisteText)
                {
                    Caption = 'Como nos conociste';
                    ApplicationArea = All;
                }
                field("Tipo de Impresión"; Rec."Tipo de Impresión")
                {
                    ApplicationArea = All;
                }
                field(Comentario; Rec.Comentario)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field(Comentario2; Rec.Comentario2)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    Visible = false;
                }
            }
            group("Contacto / Cliente")
            {
                Caption = 'Contacto / Cliente';

                field("Codigo Cliente"; Rec."Codigo Cliente")
                {
                    ApplicationArea = All;
                }
                field("Codigo Contacto"; Rec."Codigo Contacto")
                {
                    ApplicationArea = All;
                }
                field("Plantilla Cliente"; Rec."Plantilla Cliente")
                {
                    ApplicationArea = All;
                }
                field("Persona de Contacto 2"; Rec."Persona de Contacto 2")
                {
                    ApplicationArea = All;
                }
                field("Telefono 2"; Rec."Telefono 2")
                {
                    ApplicationArea = All;
                }
                field("E-Mail 2"; Rec."E-Mail 2")
                {
                    ApplicationArea = All;
                }
                field("Lugar Evento 2"; Rec."Lugar Evento 2")
                {
                    ApplicationArea = All;
                    Description = 'GAP00057';
                // Se traspasó de la extensión CP - feature.
                }
                field("Direccion 2"; Rec."Direccion 2")
                {
                    ApplicationArea = All;
                }
                field("Codigo Postal 2"; Rec."Codigo Postal 2")
                {
                    ApplicationArea = All;
                }
                field("Poblacion 2"; Rec."Poblacion 2")
                {
                    ApplicationArea = All;
                }
                field("Provincia 2"; Rec."Provincia 2")
                {
                    ApplicationArea = All;
                }
                field("Cod Pais"; Rec."Cod Pais")
                {
                    ApplicationArea = All;
                }
                field("CIF/NIF"; Rec."CIF/NIF")
                {
                    ApplicationArea = All;
                }
                field("Cod Teminos Pago"; Rec."Cod Teminos Pago")
                {
                    Caption = 'Cód. términos pago';
                    ApplicationArea = All;
                }
                field("Cod Forma Pago"; Rec."Cod Forma Pago")
                {
                    Caption = 'Cód. forma pago';
                    ApplicationArea = All;
                }
                field("Persona de Contacto"; Rec."Persona de Contacto")
                {
                    ApplicationArea = All;
                }
                field(Telefono; Rec.Telefono)
                {
                    ApplicationArea = All;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                }
                field(Direccion; Rec.Direccion)
                {
                    ApplicationArea = All;
                }
                field("Codigo Postal"; Rec."Codigo Postal")
                {
                    ApplicationArea = All;
                }
                field(Poblacion; Rec.Poblacion)
                {
                    ApplicationArea = All;
                }
                field(Provincia; Rec.Provincia)
                {
                    ApplicationArea = All;
                }
                field("Observaciones Internas"; Rec."Observaciones Internas")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
            group("Costes e Importes")
            {
                field("Coste Menu Adulto"; Rec."Coste Menu Adulto")
                {
                    ApplicationArea = All;
                    ToolTip = '<Coste de cada menú adulto, incluyendo los costes de las recetas de todos los platos del menú adulto y la parte proporcional de costes de pan y recursos>';
                }
                field("Coste Menu Nino"; Rec."Coste Menu Nino")
                {
                    ApplicationArea = All;
                    ToolTip = 'Coste de cada menú infantil, incluyendo los costes de las recetas de todos los platos del menú infantil y la parte proporcional de costes de pan y recursos';
                }
                field("Coste Menu Otros"; Rec."Coste Menu Otros")
                {
                    ApplicationArea = All;
                    ToolTip = 'Coste de cada menú especial, incluyendo los costes de las recetas de todos los platos del menú especial y la parte proporcional de costes de pan y recursos';
                }
                field("Coste Total Elaboracion"; Rec."Coste Total Elaboracion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Coste total de las recetas necesarias para realizar el evento';
                }
                field(NuevoCosteTotalDirecto; Rec.NuevoCosteTotalDirecto)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                /*  field(CosteRecursosEvento; Rec.CosteRecursosEvento)
                 {
                     ApplicationArea = All;
                     ToolTip = 'Coste total de todos los recursos necesarios para realizar el evento';
                 }
                 field(CosteProductoEvento; Rec.CosteProductoEvento)
                 {
                     ApplicationArea = All;
                     ToolTip = 'Coste total de todos los productos necesarios para realizar el evento';
                 } */
                field("Coste Total Recursos"; Rec."Coste Total Recursos")
                {
                    ApplicationArea = All;
                    Caption = 'Coste Total Indirecto';
                    ToolTip = 'Coste total de todos los recursos y productos necesarios para realizar el evento';

                    trigger OnDrillDown()
                    var
                        recEventos: Record Evento;
                    begin
                        recEventos.Reset();
                        recEventos.SetRange("Codigo Evento", Rec."Codigo Evento");
                        PAGE.RUN(50144, recEventos);
                    end;
                }
                field("Coste Total Visualizado"; Rec."Coste Total Visualizado")
                {
                    ApplicationArea = All;
                    Caption = 'Coste Total';
                    Editable = false;
                }
                field("% Beneficio"; Rec."% Beneficio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Porcentaje de Beneficio resultante del evento. Antes de introducir ninguna línea, debemos indicar el porcentaje de beneficio deseado. Cuando se crean líneas, se les asigna automáticamente este porcentaje de beneficio, aunque se puede cambiar después para cada línea individualmente. ';
                    Visible = false;
                }
                field("Precio Menu Adulto"; Rec."Precio Menu Adulto")
                {
                    ApplicationArea = All;
                    ToolTip = 'Precio de cada menú adulto';
                }
                field("Precio Menu Nino"; Rec."Precio Menu Nino")
                {
                    ApplicationArea = All;
                    ToolTip = 'Precio de cada menú infantil';
                }
                field("Precio Otros Menus"; Rec."Precio Otros Menus")
                {
                    ApplicationArea = All;
                    ToolTip = 'Precio de cada menú especial';
                }
                field("Importe Total Evento"; Rec."Importe Total Evento")
                {
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    var
                        recEventosLinea: Record "Lineas Evento";
                    begin
                        recEventosLinea.Reset();
                        recEventosLinea.SetRange("Codigo Evento", Rec."Codigo Evento");
                        PAGE.RUN(50069, recEventosLinea);
                    end;
                }
                field("Importe Total IVA Incluido"; Rec."Importe Total IVA Incluido")
                {
                    ApplicationArea = All;
                }
                field(ImporteBeneficio; Rec.gfu_ImpBeneficio)
                {
                    ApplicationArea = All;
                    Caption = 'Importe Beneficio';
                }
                field(PorcBeneficio; Rec.gfu_PorcBeneficio)
                {
                    ApplicationArea = All;
                    Caption = '% Beneficio Real';
                }
                field(gfu_PorcBeneficioTeorico; Rec.gfu_PorcBeneficioTeorico())
                {
                    ApplicationArea = All;
                    Caption = '% Beneficio Teórico';
                }
                field("Importe Rechazado"; Rec."Importe Rechazado")
                {
                    ApplicationArea = All;
                    Caption = 'Importe rechazado';
                    ToolTip = 'Servicio desestimado por el cliente';
                    Editable = true;

                    trigger OnValidate()
                    var
                        ImportCalc: Decimal;
                    begin
                        if Rec.Estado <> Rec.Estado::Presupuesto then begin
                            ImportCalc:=Rec."Importe Total Evento" - Rec."Importe Rechazado";
                        // GAP00042 >>>
                        // Eliminar el campo "Importe contratado".
                        /*if ImportCalc < 0 then
                                Rec."Importe contratado" := 0
                            else
                                Rec."Importe contratado" := ImportCalc;*/
                        // GAP00042 <<<
                        end;
                    end;
                }
                // GAP00042 >>>
                // Eliminar el campo "Importe contratado".
                /*field("Importe contratado"; Rec."Importe contratado")
                {
                    ApplicationArea = All;
                    Caption = 'Importe contratado';
                    ToolTip = 'Servicio Contratado';
                    Editable = false;
                }*/
                // GAP00042 <<<
                field("Importe Pedido Venta"; Rec."Importe Pedido Venta")
                {
                    ApplicationArea = Basic, Suite;
                    Description = 'GAP00042';
                }
                field("Importe Factura Venta"; Rec."Importe Factura Venta")
                {
                    ApplicationArea = Basic, Suite;
                    Description = 'GAP00042';
                }
            }
            /*  group(Pan)
             {
                 Caption = 'Pan';
                 field(Barras; Rec.Barras)
                 {
                     ApplicationArea = All;
                 }
                 field(Gallegas; Rec.Gallegas)
                 {
                     ApplicationArea = All;
                 }
                 field(Colines; Rec.Colines)
                 {
                     ApplicationArea = All;
                 }
                 field(Alcachofas; Rec.Alcachofas)
                 {
                     ApplicationArea = All;
                 }
                 field("Importe Barras"; Rec."Importe Barras")
                 {
                     ApplicationArea = All;
                 }
                 field("Importe Pan Gallego"; Rec."Importe Pan Gallego")
                 {
                     ApplicationArea = All;
                 }
                 field("Importe Colines"; Rec."Importe Colines")
                 {
                     ApplicationArea = All;
                 }
                 field("Importe Alcachofas"; Rec."Importe Alcachofas")
                 {
                     ApplicationArea = All;
                 }
             } */
            group("Textos Evento")
            {
                Caption = 'Textos Evento';

                field("Código Texto"; Rec."Código Texto")
                {
                    ApplicationArea = All;
                }
                field("Descripción Texto"; Rec."Descripción Texto")
                {
                    ApplicationArea = All;
                }
                group("TextoSaludo")
                {
                    Caption = 'Texto Saludo';

                    field("Texto Saludo"; Rec."Texto Saludo")
                    {
                        ApplicationArea = All;
                        Importance = Additional;
                        MultiLine = true;
                        ShowCaption = false;
                    }
                }
                group("TextoOtrasopciones")
                {
                    Caption = 'Texto Otras opciones';

                    field("Texto Otras opciones"; Rec."Texto Otras opciones")
                    {
                        ApplicationArea = All;
                        Importance = Additional;
                        MultiLine = true;
                        ShowCaption = false;
                    }
                }
                group("TextoDirectrices")
                {
                    Caption = 'Texto Directrices';

                    field("Texto Directrices"; Rec."Texto Directrices")
                    {
                        ApplicationArea = All;
                        Importance = Additional;
                        MultiLine = true;
                        ShowCaption = false;
                    }
                }
                group("TextoClienteaportaparasi")
                {
                    Caption = 'Texto Cliente aporta para si';

                    field("Texto Cliente aporta para si"; Rec."Texto Cliente aporta para si")
                    {
                        ApplicationArea = All;
                        Importance = Additional;
                        MultiLine = true;
                        ShowCaption = false;
                    }
                }
                group("TextoClienteaportacatering")
                {
                    Caption = 'Texto Cliente aporta catering';

                    field("Texto Cliente aporta catering"; Rec."Texto Cliente aporta catering")
                    {
                        ApplicationArea = All;
                        Importance = Additional;
                        MultiLine = true;
                        ShowCaption = false;
                    }
                }
                group("TextoDoc.obligatoria")
                {
                    Caption = 'Texto Documentación obligatoria';

                    field("Texto Doc. obligatoria"; Rec."Texto Doc. obligatoria")
                    {
                        ApplicationArea = All;
                        Importance = Additional;
                        MultiLine = true;
                        ShowCaption = false;
                    }
                }
                group("TextoFormasdepago")
                {
                    Caption = 'Texto Formas de pago';

                    field("Texto Formas de pago"; Rec."Texto Formas de pago")
                    {
                        ApplicationArea = All;
                        Importance = Additional;
                        MultiLine = true;
                        ShowCaption = false;
                    }
                }
                group("TextoCondicionescontratación")
                {
                    Caption = 'Texto Condiciones contratación';

                    field("Texto Condiciones contratación"; Rec."Texto Condiciones contratación")
                    {
                        ApplicationArea = All;
                        Importance = Additional;
                        MultiLine = true;
                        ShowCaption = false;
                    }
                }
                group("TextoDespedida")
                {
                    Caption = 'Texto Despedida';

                    field("Texto Despedida"; Rec."Texto Despedida")
                    {
                        ApplicationArea = All;
                        Importance = Additional;
                        MultiLine = true;
                        ShowCaption = false;
                    }
                }
            }
        }
    }
    actions
    {
        area(navigation)
        {
            action("Menú Especial")
            {
                ApplicationArea = All;
                Caption = 'Menú Especial';
                Image = SocialSecurityLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Menu Especial";
                RunPageLink = "Codigo Evento"=FIELD("Codigo Evento"), Tipo=FILTER(Otros);
                RunPageView = SORTING("Codigo Evento", Linea)ORDER(Ascending)WHERE(Tipo=FILTER(Otros));
            }
            action("Menú Adultos")
            {
                Caption = 'Menú Adultos';
                Image = SalesPurchaseTeam;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Menu Adulto";
                RunPageLink = "Codigo Evento"=FIELD("Codigo Evento"), Tipo=FILTER(Adulto);
                RunPageView = SORTING("Codigo Evento", Linea)ORDER(Ascending)WHERE(Tipo=FILTER(Adulto));
            }
            action("Menú Niños")
            {
                Caption = 'Menú Niños';
                ApplicationArea = All;
                Image = SocialSecurity;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Menu Niño";
                RunPageLink = "Codigo Evento"=FIELD("Codigo Evento"), Tipo=FILTER(Niño);
                RunPageView = SORTING("Codigo Evento", Linea)ORDER(Ascending)WHERE(Tipo=FILTER(Niño));
            }
            action("Personal Evento")
            {
                Caption = 'Personal Evento';
                ApplicationArea = All;
                Image = ResourceSkills;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Personal Eventos";
                RunPageLink = "Codigo Evento"=FIELD("Codigo Evento"), Tipo=CONST(Personal);
                RunPageView = SORTING("Codigo Evento", Linea)ORDER(Ascending)WHERE(Tipo=FILTER(Personal));
            }
            action(RecursosEvento)
            {
                Caption = 'Mobiliario, Transporte, Menaje No Desechable';
                ApplicationArea = All;
                Image = ResourceSetup;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Recursos Eventos";
                RunPageLink = "Codigo Evento"=FIELD("Codigo Evento"), Tipo=CONST(Otros);
                RunPageView = SORTING("Codigo Evento", Tipo, Linea)ORDER(Ascending)WHERE(Tipo=CONST(Otros));
            }
            action("Menaje Desechable")
            {
                Caption = 'Menaje Desechable';
                ApplicationArea = All;
                Image = ResourceSetup;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Menaje Desechable";
                RunPageLink = "Codigo Evento"=FIELD("Codigo Evento"), Tipo=CONST(Menaje);
                RunPageView = SORTING("Codigo Evento", Tipo, Linea)ORDER(Ascending)WHERE(Tipo=CONST(Menaje));
            }
            action("Suplementos Evento")
            {
                Caption = 'Suplementos Evento';
                ApplicationArea = All;
                Image = ResourceSetup;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Suplementos Evento";
                RunPageLink = "Codigo Evento"=FIELD("Codigo Evento"), Tipo=CONST(Suplementos);
                RunPageView = SORTING("Codigo Evento", Tipo, Linea)ORDER(Ascending)WHERE(Tipo=CONST(Suplementos));
            }
            action("Pan Evento")
            {
                Caption = 'Pan Evento';
                ApplicationArea = All;
                Image = ResourceSetup;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Pan Evento";
                RunPageLink = "Codigo Evento"=FIELD("Codigo Evento"), Tipo=CONST(Pan);
                RunPageView = SORTING("Codigo Evento", Tipo, Linea)ORDER(Ascending)WHERE(Tipo=CONST(Pan));
            }
            action("Detalles")
            {
                Caption = 'Detalle de eventos';
                Image = ViewDetails;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page AlxiaMenuCard;
                RunPageLink = "Codigo Evento"=FIELD("Codigo Evento");
                RunPageView = SORTING("Codigo Evento")ORDER(Ascending);
            }
            action(Componentes)
            {
                Caption = 'Componentes';
                Image = BOM;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 50079;
                RunPageLink = "Codigo Evento"=FIELD("Codigo Evento");
            }
            action("Copiar Evento")
            {
                Caption = 'Copiar Evento';
                ApplicationArea = All;
                Image = CopyDocument;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    rpt_copiarevento: Report 50000;
                begin
                    IF CONFIRM('¿Desea duplicar este evento?')THEN BEGIN
                        CLEAR(rpt_copiarevento);
                        rpt_copiarevento.USEREQUESTPAGE(FALSE);
                        rpt_copiarevento.SetEventos(Rec."Codigo Evento");
                        rpt_copiarevento.RUNMODAL;
                        MESSAGE('Copiado Finalizado');
                    END;
                end;
            }
            action("Calcular Costes y Precios")
            {
                Caption = 'Calcular Costes y Precios';
                ApplicationArea = All;
                Image = CalculateCost;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.gfu_CalculoCostesPrecios;
                    Rec.gfu_CalculoCostesPrecios;
                    CurrPage.UPDATE(true);
                end;
            }
            action("Cambiar Estado")
            {
                Caption = 'Cambiar Estado';
                ApplicationArea = All;
                Image = ChangeStatus;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.gfu_CambiarEstadoList();
                //CurrPage.Update(true);
                end;
            }
            action("Crear Cliente/Contacto")
            {
                Caption = 'Crear Cliente/Contacto';
                ApplicationArea = All;
                Image = NewCustomer;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.gfu_CrearClienteContacto;
                end;
            }
            group(g5)
            {
                action(Imprimir)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Informe';
                    Description = 'GAP00045';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        GP_IMPRESION: Page "Imprimir Evento Opciones";
                    begin
                        CLEAR(GP_IMPRESION);
                        GP_IMPRESION.Get_Evento(Rec."Codigo Evento");
                        GP_IMPRESION.RUN;
                    end;
                }
                action(Control50000)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Informe evento';
                    ToolTip = 'Ejecuta el informe evento según el tipo de impresión.';
                    Visible = false;
                    Description = 'GAP00045';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Report;

                    trigger OnAction()
                    var
                        Evento: Record Evento;
                        InformeEvento: Report "Informe Evento";
                        InformeImpPorCapitulo: Report "Informe Evento - Imp. Capitulo";
                        InformeImpPorCapituloDtl: Report "InformeEvento - ImpCapituloDtl";
                    begin
                        Evento.Reset();
                        Evento.SetRange("Codigo Evento", Rec."Codigo Evento");
                        if Evento.FindFirst()then;
                        case Rec."Tipo de Impresión" of Rec."Tipo de Impresión"::"Impresion por Capitulo": begin
                            Clear(InformeImpPorCapitulo);
                            InformeImpPorCapitulo.ModificarFiltrosDelEvento(Rec."Tipo de Impresión"::"Impresion por Capitulo", false);
                            InformeImpPorCapitulo.SetTableView(Evento);
                            InformeImpPorCapitulo.Run();
                        end;
                        Rec."Tipo de Impresión"::"Imp. por Capitulo Dtl.": begin
                            Clear(InformeImpPorCapituloDtl);
                            InformeImpPorCapituloDtl.ModificarFiltrosDelEvento(Rec."Tipo de Impresión"::"Impresion por Capitulo", false);
                            InformeImpPorCapituloDtl.SetTableView(Evento);
                            InformeImpPorCapituloDtl.Run();
                        end;
                        Rec."Tipo de Impresión"::"Impresion Concepto Generico", Rec."Tipo de Impresión"::"Impresion Detallada": begin
                            Clear(InformeEvento);
                            InformeEvento.ModificarFiltrosDelEvento(Rec."Tipo de Impresión", false);
                            InformeEvento.SetTableView(Evento);
                            InformeEvento.Run();
                        end;
                        end;
                    end;
                }
                action(Control50001)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Imp. por Capitulo';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    var
                        ImprimirCapitulo: Report "Evento Impresion por Capitulo";
                    begin
                        Clear(ImprimirCapitulo);
                        ImprimirCapitulo.ConfigurarFiltros(Rec."Codigo Evento", true);
                        ImprimirCapitulo.Run();
                    end;
                }
                action("Crear ensamblado")
                {
                    Caption = 'Crear ensamblado';
                    ApplicationArea = All;
                    Image = Apply;
                    Promoted = true;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        IF NOT Rec.CreadoEnsamblado THEN BEGIN
                            gt_linevento.RESET;
                            gt_linevento.SETRANGE(gt_linevento."Codigo Evento", Rec."Codigo Evento");
                            IF gt_linevento.FINDSET THEN REPEAT gt_linevento.gfu_CreaRegPedEnsamblado;
                                UNTIL gt_linevento.NEXT = 0;
                            Rec.CreadoEnsamblado:=TRUE;
                            Rec.MODIFY;
                            MESSAGE('Se ha creado el pedido de ensamblado'); //ADV003
                        END
                        ELSE
                            MESSAGE('El evento ya tiene un pedido de ensamblado creado'); //ADV003
                    end;
                }
                action(Comisiones)
                {
                    Caption = 'Comisiones';
                    ApplicationArea = All;
                    Image = CashFlow;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                //RunObject = Page 50021;
                //RunPageLink = "Customer No." = FIELD("Codigo Cliente");
                //RunPageView = SORTING("Customer No.", "Item No.", Tramo);
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
    //Rec.gfu_CalculoCostesPrecios();
    end;
    trigger OnAfterGetCurrRecord()
    begin
        StyleText:=SetStyle;
        //SL Recalculo por estado.
        if(Rec.Estado = rec.Estado::Presupuesto) or (Rec.Estado = Rec.Estado::Aceptado)then if(Rec."Total Adultos" <> 0) or (Rec."Total Ninos" <> 0)then begin
                Rec.gfu_CalculoCostesPrecios();
            //CurrPage.UPDATE();
            end;
        if Rec.Estado <> Rec.Estado::Presupuesto then begin
            varEditable:=true;
        // GAP00042 >>>
        // Eliminar el campo "Importe contratado".
        /*Rec."Importe Contratado" := Rec."Importe Total Evento" - Rec."Importe Rechazado";
            if Rec."Importe Contratado" < 0 then begin
                Rec."Importe Contratado" := 0;
            end;
        end else begin
            Rec."Importe Contratado" := 0;*/
        // GAP00042 <<<
        end;
    end;
    var StyleText: Text[30];
    gt_linevento: Record "Lineas Evento";
    varEditable: Boolean;
    ImporteContratado: Decimal;
    procedure SetStyle(): Text[30]begin
        CASE Rec.Estado OF Rec.Estado::Aceptado, Rec.Estado::Realizado: EXIT('Favorable');
        Rec.Estado::Anulado, Rec.Estado::Rechazado: EXIT('Unfavorable');
        Rec.Estado::Archivado: EXIT('Ambiguous');
        Rec.Estado::Presupuesto: EXIT('StrongAccent');
        ELSE
            EXIT('Standard');
        END;
    end;
}
