page 50015 "Componentes Evento"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Componentes Evento";
    SourceTableView = SORTING("Codigo Evento", Position, "Linea Evento")ORDER(Ascending);

    layout
    {
        area(content)
        {
            group(prueba)
            {
                Visible = false;

                repeater(Group)
                {
                    Visible = false;

                    field("Codigo Evento"; Rec."Codigo Evento")
                    {
                        ApplicationArea = All;
                    }
                    field("Linea Evento"; Rec."Linea Evento")
                    {
                        ApplicationArea = All;
                    }
                    field("Parent Item No."; Rec."Parent Item No.")
                    {
                        ApplicationArea = All;
                    }
                    field("Line No."; Rec."Line No.")
                    {
                        ApplicationArea = All;
                    }
                    field(Type; Rec.Type)
                    {
                        ApplicationArea = All;
                    }
                    field(Position; Rec.Position)
                    {
                        ApplicationArea = All;
                    }
                    field("No."; Rec."No.")
                    {
                        ApplicationArea = All;
                    }
                    field(Description; Rec.Description)
                    {
                        ApplicationArea = All;
                    }
                    field("Cantidad por Lote"; Rec."Cantidad por Lote")
                    {
                        ApplicationArea = All;
                    }
                    field("Quantity per"; Rec."Quantity per")
                    {
                        ApplicationArea = All;
                    }
                    field("Coste Calculado"; Rec."Coste Calculado")
                    {
                        ApplicationArea = All;
                    }
                    field(CosteUnitario; Rec.CosteUnitario)
                    {
                        ApplicationArea = All;
                    }
                    field("Coste Lote"; Rec."Coste Lote")
                    {
                        ApplicationArea = All;
                    }
                    field("Assembly BOM"; Rec."Assembly BOM")
                    {
                        ApplicationArea = All;
                    }
                    field(Comentario; Rec.Comentario)
                    {
                        ApplicationArea = All;
                    }
                    field("Unit of Measure Code"; Rec."Unit of Measure Code")
                    {
                        ApplicationArea = All;
                    }
                    field("BOM Description"; Rec."BOM Description")
                    {
                        ApplicationArea = All;
                    }
                    field("Importancia en Coste"; Rec."Importancia en Coste")
                    {
                        ApplicationArea = All;
                    }
                    field("Proveedor por Defecto"; Rec."Proveedor por Defecto")
                    {
                        ApplicationArea = All;
                    }
                    field("Alias Proveedor"; Rec."Alias Proveedor")
                    {
                        ApplicationArea = All;
                    }
                    field(CantidadEscalado; Rec.CantidadEscalado)
                    {
                        ApplicationArea = All;
                        Style = Unfavorable;
                        StyleExpr = TRUE;
                    }
                }
            }
            part(SubItems;50066)
            {
                Caption = 'L.M de ensamblado Producto';
                ApplicationArea = All;
                SubPageLink = "Codigo Evento"=FIELD("Codigo Evento"), "Linea Evento"=FIELD("Linea Evento"), "Parent Item No."=FIELD("Parent Item No.");
                SubPageView = SORTING("Parent Item No.", "Line No.")ORDER(Ascending);
            }
            part(SubRecursos;50067)
            {
                Caption = 'L.M. de ensamblado Recursos';
                ApplicationArea = All;
                SubPageLink = "Codigo Evento"=FIELD("Codigo Evento"), "Linea Evento"=FIELD("Linea Evento"), "Parent Item No."=FIELD("Parent Item No.");
                SubPageView = SORTING("Parent Item No.", "Line No.")ORDER(Ascending);
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Calcular Costes y Precios")
            {
                Caption = 'Calcular Costes y Precios';
                ApplicationArea = All;
                Image = CalculateCost;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Item: Record Item;
                    recEvento: Record Evento;
                begin
                    //-- #9804
                    Item.GET(Rec."Parent Item No.");
                    Item.ActualizarImportanciaEnCosteEventos(Rec."Codigo Evento", Rec."Linea Evento", Rec."Parent Item No.");
                    //++ #9804
                    recEvento.Reset();
                    recEvento.SetRange("Codigo Evento", rec."Codigo Evento");
                    recEvento.FindSet();
                    //recEvento.gfu_CalculoCostesPrecios;
                    //recEvento.gfu_CalculoCostesPrecios;
                    recEvento.gfu_CalculoCostesPrecios;
                //CurrPage.UPDATE(true);
                end;
            }
            /*  action("Actualizar Importancia en coste")
             {
                 ApplicationArea = All;
                 Promoted = true;
                 PromotedCategory = Process;
                 PromotedIsBig = true;
                 AccessByPermission = TableData 90 = R;
                 Caption = 'Actualizar Importancia en coste';
                 Image = CalculateDiscount;


             } */
            group("Info Calidad")
            {
                Caption = 'Info Calidad';
                Image = Confirm;

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
                        rlComponentesEvento: Record "Componentes Evento";
                        xlFiltros: Text;
                        pl: Page 50075;
                        rlBOMComponent2: Record "Componentes Evento";
                        rlBOMComponent3: Record "Componentes Evento";
                        rlBOMComponent4: Record "Componentes Evento";
                        rlBOMComponent5: Record "Componentes Evento";
                    begin
                        CLEAR(xlFiltros);
                        rlComponentesEvento.SETRANGE("Codigo Evento", Rec."Codigo Evento");
                        rlComponentesEvento.SETRANGE(Type, rlComponentesEvento.Type::Item);
                        rlComponentesEvento.FINDSET;
                        REPEAT IF rlComponentesEvento."No." <> '' THEN BEGIN
                                xlFiltros+='|' + rlComponentesEvento."No.";
                                CLEAR(rlBOMComponent2);
                                rlBOMComponent2.SETRANGE("Parent Item No.", rlComponentesEvento."No.");
                                rlBOMComponent2.SETRANGE(Type, rlBOMComponent2.Type::Item);
                                rlBOMComponent2.SETRANGE("Codigo Evento", rlComponentesEvento."Codigo Evento");
                                rlBOMComponent2.SETRANGE("Linea Evento", rlComponentesEvento."Linea Evento");
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
    trigger OnAfterGetRecord()
    begin
        CurrPage.SubItems.PAGE.SetParameters(Rec."Codigo Evento", Rec."Linea Evento", Rec."Parent Item No.");
        CurrPage.SubRecursos.PAGE.SetParameters(Rec."Codigo Evento", Rec."Linea Evento", Rec."Parent Item No.");
    end;
    trigger OnOpenPage()
    var
        ltEvento: Record Evento;
    begin
        IF Rec."Codigo Evento" <> '' THEN BEGIN
            ltEvento.GET(Rec."Codigo Evento");
            IF ltEvento.Estado = ltEvento.Estado::Realizado THEN CurrPage.EDITABLE:=FALSE;
        END;
        CurrPage.SubItems.PAGE.SetParameters(Rec."Codigo Evento", Rec."Linea Evento", Rec."Parent Item No.");
        CurrPage.SubRecursos.PAGE.SetParameters(Rec."Codigo Evento", Rec."Linea Evento", Rec."Parent Item No.");
    end;
}
