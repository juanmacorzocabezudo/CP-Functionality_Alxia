page 50034 "Pan Evento"
{
    // ADVANCE - Log de cambios
    // -----------------------------------------------------
    //   ADVANCE
    //   Fecha: 21-03-2017
    //   Técnico: JAB
    //   Presupuesto: Proyecto I004127 - Botón Componentes Receta
    //   Modificación: Incluir un nuevo botón que sea Componentes Receta
    // 
    //   Etiqueta: ADV001
    // -----------------------------------------------------
    AutoSplitKey = true;
    //DelayedInsert = true;
    PageType = List;
    SourceTable = "Productos Evento";
    SourceTableView = SORTING("Codigo Evento", Tipo, Linea)ORDER(Ascending)WHERE(Tipo=CONST(Pan));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
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
                field(Producto; Rec.Producto)
                {
                    ApplicationArea = All;
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                }
                field(Cantidad; Rec.Cantidad)
                {
                    ApplicationArea = All;
                }
                field("Unidad de medida"; Rec."Unidad de medida")
                {
                    ApplicationArea = All;
                }
                field("Precio Real"; Rec."Precio Real")
                {
                    ApplicationArea = All;
                }
                field("Coste Unitario"; Rec."Coste Unitario")
                {
                    ApplicationArea = All;
                }
                field("Coste Total"; Rec."Coste Total")
                {
                    ApplicationArea = All;
                }
                field(Precio; Rec.Precio)
                {
                    ApplicationArea = All;
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
                field(Comentarios; Rec.Comentarios)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Calcular Costes y Precios")
            {
                Caption = 'Calcular Costes';
                ApplicationArea = All;
                Image = CalculateCost;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    RecComp: Record "Componentes Evento";
                    RecProEve: Record "Productos Evento";
                    costeTotal: Decimal;
                begin
                    //SL: Inicio
                    RecProEve.Reset();
                    RecProEve.SetRange(RecProEve."Codigo Evento", Rec."Codigo Evento");
                    if RecProEve.FindFirst()then repeat RecProEve.lfu_CalculaPreciosOut(RecProEve);
                            RecProEve.Modify();
                        until RecProEve.Next() = 0;
                    //SL: Fin
                    CurrPage.UPDATE;
                end;
            }
            action("Componentes Receta")
            {
                ApplicationArea = All;
                Caption = 'Componentes';
                Image = BOM;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Page 50015;
                RunPageLink = "Codigo Evento"=FIELD("Codigo Evento"), "Linea Evento"=FIELD(Linea), "Parent Item No."=FIELD(Producto);
            }
            action(AGRALAInfoCalidadCabecera)
            {
                ApplicationArea = All;
                Caption = 'Info Calidad';
                Image = QualificationOverview;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    rlItemVariant: Record 5401;
                    rlComponentesEvento: Record "Productos Evento";
                    xlFiltros: Text;
                    pl: Page 50075;
                    rlBOMComponent2: Record "Componentes Evento";
                    rlBOMComponent3: Record "Componentes Evento";
                    rlBOMComponent4: Record "Componentes Evento";
                    rlBOMComponent5: Record "Componentes Evento";
                begin
                    CLEAR(xlFiltros);
                    rlComponentesEvento.SETRANGE("Codigo Evento", Rec."Codigo Evento");
                    rlComponentesEvento.FINDSET;
                    REPEAT IF rlComponentesEvento."Codigo Producto" <> '' THEN BEGIN
                            xlFiltros+='|' + rlComponentesEvento."Codigo Producto";
                            CLEAR(rlBOMComponent2);
                            rlBOMComponent2.SETRANGE("Parent Item No.", rlComponentesEvento."Codigo Producto");
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
}
