page 50021 "MenuNiñoListPart"
{
    Caption = 'Menu Niño';
    PageType = ListPart;
    SourceTable = "Lineas Evento";

    //AutoSplitKey = true;
    //DelayedInsert = false;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Codigo Evento"; Rec."Codigo Evento")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field(Tipo; Rec.ImprCapitulo)
                {
                    ApplicationArea = All;
                    Caption = 'Tipo Capítulo';
                }
                field(DescripCapitulo; Rec.DescripCapitulo)
                {
                    ApplicationArea = All;
                    Caption = 'Impresion Capítulo';
                    ToolTip = 'Capítulo al que pertenece.';
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE(TRUE);
                    end;
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                }
                field(Cantidad; Rec.Cantidad)
                {
                    ApplicationArea = All;
                }
                field("Precio Real"; Rec."Precio Real")
                {
                    ApplicationArea = All;
                    DecimalPlaces = 2: 3;
                }
                field("Coste Directo"; Rec."Coste Directo")
                {
                    ApplicationArea = All;
                    Caption = 'Coste Directo Receta';
                }
                field("Coste Indirecto Recursos"; Rec."Coste Indirecto Recursos")
                {
                    ApplicationArea = All;
                    Caption = 'Coste Indirecto';
                }
                field("Precio Venta Recursos"; Rec."Precio Venta Recursos")
                {
                    ApplicationArea = All;
                }
                field("Coste Total"; Rec."Coste Total")
                {
                    ApplicationArea = All;
                }
                field("Coste Total Unitario"; Rec."Coste Total Unitario")
                {
                    ApplicationArea = All;
                    Caption = 'Coste Plato';
                }
                field("Valor Margen"; Rec."Valor Margen")
                {
                    ApplicationArea = All;
                }
                field("Tipo Margen"; Rec."Tipo Margen")
                {
                    ApplicationArea = All;
                }
                field("Precio Propuesto"; Rec."Precio Propuesto")
                {
                    ApplicationArea = All;
                }
                field(Importe; Rec.Importe)
                {
                    ApplicationArea = All;
                }
                field("% IVA"; Rec."% IVA")
                {
                    ApplicationArea = All;
                }
                field("Importe IVA Incl."; Rec."Importe IVA Incl.")
                {
                    ApplicationArea = All;
                }
                field(Imprime; Rec.Imprime)
                {
                    ApplicationArea = All;
                }
                field(Comentarios; Rec.Comentarios)
                {
                    ApplicationArea = All;
                }
                field("Coste Indirecto Pan"; Rec."Coste Indirecto Pan")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Componentes Receta")
            {
                Caption = 'Componentes Receta';
                ApplicationArea = All;
                Image = BOM;
                RunObject = Page 50015;
                RunPageLink = "Codigo Evento"=FIELD("Codigo Evento"), "Linea Evento"=FIELD(Linea), "Parent Item No."=FIELD("No.");
            }
            action(Imprimir)
            {
                Caption = 'Imprimir Hoja Producción';
                ApplicationArea = All;
                Image = Print;

                trigger OnAction()
                var
                    Rcd_Eventos: Record Evento;
                begin
                    // Inicio ADV001
                    gr_lineaevento.RESET;
                    gr_lineaevento.SETRANGE("Codigo Evento", Rec."Codigo Evento");
                    gr_lineaevento.SETRANGE(Linea, Rec.Linea);
                    CLEAR(gr_imprimirreport);
                    gr_imprimirreport.fijafiltros(Rec."Codigo Evento", Rec.Linea);
                    gr_imprimirreport.USEREQUESTPAGE(FALSE);
                    gr_imprimirreport.RUNMODAL;
                // Fin ADV001
                end;
            }
            action(AGRALAInfoCalidadCabecera)
            {
                Caption = 'Info Calidad';
                ApplicationArea = All;
                Image = QualificationOverview;

                trigger OnAction()
                var
                    rlItemVariant: Record 5401;
                    rlComponentesEvento: Record "Lineas Evento";
                    xlFiltros: Text;
                    pl: Page 50075;
                    rlBOMComponent2: Record "Componentes Evento";
                    rlBOMComponent3: Record "Componentes Evento";
                    rlBOMComponent4: Record "Componentes Evento";
                    rlBOMComponent5: Record "Componentes Evento";
                begin
                    CLEAR(xlFiltros);
                    rlComponentesEvento.SETRANGE("Codigo Evento", Rec."Codigo Evento");
                    rlComponentesEvento.SETRANGE(Tipo, rlComponentesEvento.Tipo::Niño);
                    rlComponentesEvento.FINDSET;
                    REPEAT IF rlComponentesEvento."No." <> '' THEN BEGIN
                            xlFiltros+='|' + rlComponentesEvento."No.";
                            CLEAR(rlBOMComponent2);
                            rlBOMComponent2.SETRANGE("Parent Item No.", rlComponentesEvento."No.");
                            rlBOMComponent2.SETRANGE(Type, rlBOMComponent2.Type::Item);
                            rlBOMComponent2.SETRANGE("Codigo Evento", rlComponentesEvento."Codigo Evento");
                            rlBOMComponent2.SETRANGE("Linea Evento", rlComponentesEvento.Linea);
                            IF rlBOMComponent2.FINDSET THEN REPEAT xlFiltros+='|' + rlBOMComponent2."No.";
                                    CLEAR(rlBOMComponent3);
                                    rlBOMComponent3.SETRANGE("Parent Item No.", rlBOMComponent2."No.");
                                    rlBOMComponent3.SETRANGE(Type, rlBOMComponent2.Type::Item);
                                    rlBOMComponent3.SETRANGE("Codigo Evento", rlBOMComponent2."Codigo Evento");
                                    rlBOMComponent3.SETRANGE("Linea Evento", rlBOMComponent2."Linea Evento");
                                    IF rlBOMComponent3.FINDSET THEN REPEAT xlFiltros+='|' + rlBOMComponent3."No.";
                                            CLEAR(rlBOMComponent4);
                                            rlBOMComponent4.SETRANGE("Parent Item No.", rlBOMComponent3."No.");
                                            rlBOMComponent4.SETRANGE(Type, rlBOMComponent2.Type::Item);
                                            rlBOMComponent4.SETRANGE("Codigo Evento", rlBOMComponent3."Codigo Evento");
                                            rlBOMComponent4.SETRANGE("Linea Evento", rlBOMComponent3."Linea Evento");
                                            IF rlBOMComponent4.FINDSET THEN REPEAT xlFiltros+='|' + rlBOMComponent4."No.";
                                                    CLEAR(rlBOMComponent5);
                                                    rlBOMComponent5.SETRANGE("Parent Item No.", rlBOMComponent4."No.");
                                                    rlBOMComponent5.SETRANGE(Type, rlBOMComponent2.Type::Item);
                                                    rlBOMComponent5.SETRANGE("Codigo Evento", rlBOMComponent4."Codigo Evento");
                                                    rlBOMComponent5.SETRANGE("Linea Evento", rlBOMComponent4."Linea Evento");
                                                    IF rlBOMComponent5.FINDSET THEN REPEAT xlFiltros+='|' + rlBOMComponent5."No.";
                                                        UNTIL rlBOMComponent4.NEXT = 0;
                                                UNTIL rlBOMComponent4.NEXT = 0;
                                        UNTIL rlBOMComponent3.NEXT = 0;
                                UNTIL rlBOMComponent2.NEXT = 0;
                        END;
                    UNTIL rlComponentesEvento.NEXT() = 0;
                    xlFiltros:=COPYSTR(xlFiltros, 2);
                    rlItemVariant.SETFILTER("Item No.", xlFiltros);
                    PAGE.RUN(50075, rlItemVariant);
                end;
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Tipo:=Rec.Tipo::Niño;
    end;
    trigger OnOpenPage()
    var
        ltEvento: Record Evento;
    begin
        IF Rec."Codigo Evento" <> '' THEN BEGIN
            ltEvento.GET(Rec."Codigo Evento");
            IF ltEvento.Estado = ltEvento.Estado::Realizado THEN CurrPage.EDITABLE:=FALSE;
        END;
    end;
    var gr_lineaevento: Record "Lineas Evento";
    gr_componenteevento: Record "Componentes Evento";
    gr_imprimirreport: Report 50018;
}
