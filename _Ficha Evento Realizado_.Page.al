page 50012 "Ficha Evento Realizado"
{
    // ADVANCE - Log de cambios
    // -----------------------------------------------------
    //   ADVANCE
    //   Fecha: 27-06-2016
    //   Técnico: JMAP
    //   Presupuesto: I002815 - Ampliación y nuevos campos en Eventos
    //   Modificación:
    //   Etiqueta: ADV001
    // -----------------------------------------------------
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = true;
    RefreshOnActivate = true;
    SourceTable = Evento;
    SourceTableView = SORTING("Codigo Evento")ORDER(Ascending)WHERE(Estado=FILTER(Realizado|Archivado));

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
                group(g1)
                {
                    Visible = Rec.Estado = Rec.Estado::Anulado;

                    field("Motivo Anulacion"; Rec."Motivo Anulacion")
                    {
                        ApplicationArea = All;
                    }
                }
                group(g2)
                {
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
                group(g3)
                {
                    Visible = Rec.Estado = Rec.Estado::Archivado;

                    field("Evento Origen"; Rec."Evento Origen")
                    {
                        ApplicationArea = All;
                    }
                }
                field("Oferta Mes Sin IVA"; Rec."Oferta Mes Sin IVA")
                {
                    ApplicationArea = All;
                }
                field("Tipo Evento"; Rec."Tipo Evento")
                {
                    ApplicationArea = All;
                }
                field("Variedad Evento"; Rec."Variedad Evento")
                {
                    ApplicationArea = All;
                }
                field("Doble Pan"; Rec."Doble Pan")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Nada Pan"; Rec."Nada Pan")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
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
                }
                field(CodVendedor; Rec.CodVendedor)
                {
                    ApplicationArea = All;
                }
                field("Commission %"; Rec."Commission %")
                {
                    ApplicationArea = All;
                }
                field(ComoNosConociste; Rec.ComoNosConocisteText)
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
                    ApplicationArea = All;
                }
                field("Cod Forma Pago"; Rec."Cod Forma Pago")
                {
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
                }
                field("Coste Menu Nino"; Rec."Coste Menu Nino")
                {
                    ApplicationArea = All;
                }
                field("Coste Menu Otros"; Rec."Coste Menu Otros")
                {
                    ApplicationArea = All;
                }
                field("Coste Total Elaboracion"; Rec."Coste Total Elaboracion")
                {
                    ApplicationArea = All;
                }
                field("Coste Total Recursos"; Rec."Coste Total Recursos")
                {
                    ApplicationArea = All;
                }
                field("Coste Total"; Rec."Coste Total")
                {
                    ApplicationArea = All;
                }
                field("% Beneficio"; Rec."% Beneficio")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Precio Menu Adulto"; Rec."Precio Menu Adulto")
                {
                    ApplicationArea = All;
                }
                field("Precio Menu Nino"; Rec."Precio Menu Nino")
                {
                    ApplicationArea = All;
                }
                field("Precio Otros Menus"; Rec."Precio Otros Menus")
                {
                    ApplicationArea = All;
                }
                field("Importe Total Evento"; Rec."Importe Total Evento")
                {
                    ApplicationArea = All;
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
                field(PorcBeneficio; rec.gfu_PorcBeneficio)
                {
                    ApplicationArea = All;
                    Caption = '% Beneficio Real';
                }
            }
            group(Pan)
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
            }
        }
    }
    actions
    {
        area(navigation)
        {
            action("Menú Adultos")
            {
                Caption = 'Menú Adultos';
                ApplicationArea = All;
                Image = SalesPurchaseTeam;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 50007;
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
                RunObject = Page 50008;
                RunPageLink = "Codigo Evento"=FIELD("Codigo Evento"), Tipo=FILTER(Niño);
                RunPageView = SORTING("Codigo Evento", Linea)ORDER(Ascending)WHERE(Tipo=FILTER(Niño));
            }
            action("Menú Especial")
            {
                Caption = 'Menú Especial';
                ApplicationArea = All;
                Image = SocialSecurityLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 50009;
                RunPageLink = "Codigo Evento"=FIELD("Codigo Evento"), Tipo=FILTER(Otros);
                RunPageView = SORTING("Codigo Evento", Linea)ORDER(Ascending)WHERE(Tipo=FILTER(Otros));
            }
            action("Personal Evento")
            {
                Caption = 'Personal Evento';
                ApplicationArea = All;
                Image = ResourceSkills;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 50010;
                RunPageLink = "Codigo Evento"=FIELD("Codigo Evento"), Tipo=CONST(Personal);
                RunPageView = SORTING("Codigo Evento", Linea)ORDER(Ascending)WHERE(Tipo=FILTER(Personal));
            }
            action(RecursosEvento)
            {
                Caption = 'Mobiliario, Transp., Menaje Evento';
                ApplicationArea = All;
                Image = ResourceSetup;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 50018;
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
                RunObject = Page 50032;
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
                RunObject = Page 50033;
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
                RunObject = Page 50034;
                RunPageLink = "Codigo Evento"=FIELD("Codigo Evento"), Tipo=CONST(Pan);
                RunPageView = SORTING("Codigo Evento", Tipo, Linea)ORDER(Ascending)WHERE(Tipo=CONST(Pan));
            }
            action("Componentes Evento")
            {
                Caption = 'Componentes Evento';
                ApplicationArea = All;
                Image = BOM;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 50015;
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
                //rpt_copiarevento: Report "50000";
                begin
                    IF CONFIRM('¿Desea duplicar este evento?')THEN BEGIN
                        /*     CLEAR(rpt_copiarevento);
                            rpt_copiarevento.USEREQUESTPAGE(FALSE);
                            rpt_copiarevento.SetEventos(Rec."Codigo Evento");
                            rpt_copiarevento.RUNMODAL; */
                        MESSAGE('Copiado Finalizado');
                    END;
                end;
            }
            action("Calcular Costes y Precios")
            {
                Caption = 'Calcular Costes y Precios';
                ApplicationArea = All;
                Enabled = true;
                Image = CalculateCost;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = true;

                trigger OnAction()
                begin
                    IF Rec.Estado = Rec.Estado::Archivado THEN BEGIN
                        Rec.gfu_CalculoCostesPrecios;
                        Rec.gfu_CalculoCostesPrecios;
                        CurrPage.UPDATE;
                    END
                    ELSE
                        ERROR(Text10000, Rec.Estado);
                end;
            }
            action("Cambiar Estado")
            {
                Caption = 'Cambiar Estado';
                ApplicationArea = All;
                Enabled = true;
                Image = ChangeStatus;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = true;

                trigger OnAction()
                begin
                    IF Rec.Estado = Rec.Estado::Archivado THEN ERROR('No se puede mover un evento de estado cuando se ha archivado');
                    Rec.gfu_CambiarEstado;
                end;
            }
            action("Crear Cliente/Contacto")
            {
                Caption = 'Crear Cliente/Contacto';
                ApplicationArea = All;
                Enabled = false;
                Image = NewCustomer;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    Rec.gfu_CrearClienteContacto;
                end;
            }
            group(gr)
            {
                action(Imprimir)
                {
                    Caption = 'Imprimir';
                    ApplicationArea = All;
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        Rcd_Eventos: Record Evento;
                    begin
                        Rcd_Eventos.RESET;
                        Rcd_Eventos.SETRANGE("Codigo Evento", Rec."Codigo Evento");
                        REPORT.RUNMODAL(50007, TRUE, FALSE, Rcd_Eventos)end;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        StyleText:=SetStyle;
    end;
    trigger OnOpenPage()
    begin
        IF Rec.Estado = Rec.Estado::Realizado THEN CurrPage.EDITABLE:=FALSE;
    end;
    var StyleText: Text[30];
    Text10000: Label 'No se puede recalcular precios en Eventos con estado %1.';
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
