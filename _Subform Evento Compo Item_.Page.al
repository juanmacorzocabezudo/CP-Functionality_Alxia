page 50066 "Subform Evento Compo Item"
{
    // ADVANCE - Log de cambios
    // -----------------------------------------------------
    //   ADVANCE
    //   Fecha: 11-04-2016
    //   Técnico: JMAP
    //   Presupuesto: Proyecto I002074 - Desarrollo funcionalidades Recetas
    // 
    //   Etiqueta: ADV001
    // -----------------------------------------------------
    // #9766 - Se crea el formulario nuevo
    //       - Se hace visible el campo coste estandar
    // #9804 - Se crea el botón de navegar
    AutoSplitKey = true;
    Caption = 'L.M de ensamblado Producto';
    DataCaptionFields = "Parent Item No.";
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Componentes Evento";
    SourceTableView = SORTING("Codigo Evento", "Linea Evento", "Parent Item No.", "Line No.")ORDER(Ascending)WHERE(Type=FILTER(Item));

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field("Parent Item No."; Rec."Parent Item No.")
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field("Assembly BOM"; Rec."Assembly BOM")
                {
                    ApplicationArea = All;
                }
                field(Position; Rec.Position)
                {
                    ApplicationArea = All;
                    Visible = true;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IsResource:=Rec.Type = Rec.Type::Resource end;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    StyleExpr = VarFormato;
                }
                field("Cantidad por Lote"; Rec."Cantidad por Lote")
                {
                    ApplicationArea = All;
                    BlankZero = true;

                    trigger OnValidate()
                    begin
                    //ActualizarImportancia();
                    end;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                    //ActualizarImportancia();
                    end;
                }
                field(CosteUnitario; Rec.CosteUnitario)
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    Caption = 'Coste Estandar';
                    DecimalPlaces = 4: 4;
                    Editable = false;
                }
                field(CantidadCosteUnitario; Rec."Cantidad por Lote" * Rec.CosteUnitario)
                {
                    ApplicationArea = All;
                    Caption = 'Coste Total';
                    StyleExpr = VarFormatoImportanciaCoste;
                    Visible = false;
                }
                field("Quantity per"; Rec."Quantity per")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    Editable = false;
                }
                field("Coste Calculado"; Rec."Coste Calculado")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    Caption = 'Coste Calculado por UMB';
                }
                field("Coste Lote"; Rec."Coste Lote")
                {
                    ApplicationArea = All;
                    StyleExpr = VarFormatoImportanciaCoste;
                }
                field("Importancia en Coste"; Rec."Importancia en Coste")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    StyleExpr = VarFormatoImportanciaCoste;
                }
                field("Installed in Item No."; Rec."Installed in Item No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Position 2"; Rec."Position 2")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Position 3"; Rec."Position 3")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Machine No."; Rec."Machine No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Lead-Time Offset"; Rec."Lead-Time Offset")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Resource Usage Type"; Rec."Resource Usage Type")
                {
                    ApplicationArea = All;
                    Editable = IsResource;
                    HideValue = NOT IsResource;
                    Visible = false;
                }
                field("Proveedor por Defecto"; Rec."Proveedor por Defecto")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(txtNombreProveedor; txtNombreProveedor)
                {
                    ApplicationArea = All;
                    Caption = 'Alias Proveedor';
                    Editable = false;
                }
                field(Comentario; Rec.Comentario)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("E&xplode BOM")
            {
                ApplicationArea = All;
                Caption = 'Desplegar L.M.';
                Image = ExplodeBOM;
                RunObject = Codeunit 51;
            }
            action(accReceta)
            {
                ApplicationArea = All;
                Caption = 'Receta';
                Enabled = Rec."Assembly BOM";
                Image = BOM;
                RunObject = Page Receta;
                RunPageLink = "No."=FIELD("No.");
                RunPageMode = View;
                RunPageView = SORTING("No.")ORDER(Ascending);
            }
            action(acc_Escalados)
            {
                ApplicationArea = All;
                Caption = 'Escalados';
                Enabled = false;
                Image = AnalysisView;
                RunObject = Page Escalados;
                RunPageLink = NumeroLM=FIELD("Parent Item No."), NumeroLinea=FIELD("Line No."), Tipo=FIELD(Type), Numero=FIELD("No."), Descripcion=FIELD(Description), CodigoUnidadMedida=FIELD("Unit of Measure Code");
                RunPageView = SORTING(NumeroLM, NumeroLinea, Tipo, Numero, Descripcion, CodigoUnidadMedida, LoteReceta, CantidadLoteReceta)ORDER(Ascending);
                Visible = false;
            }
            action(PageCard)
            {
                ApplicationArea = All;
                Caption = 'Ficha';
                Image = Card;

                trigger OnAction()
                var
                    Item: Record Item;
                    Resource: Record Resource;
                begin
                    //-- #9804
                    CASE Rec.Type OF Rec.Type::Item: BEGIN
                        Item.RESET;
                        Item.SETRANGE("No.", Rec."No.");
                        Item.FINDSET;
                        PAGE.RUN(30, Item);
                    END;
                    Rec.Type::Resource: BEGIN
                        Resource.RESET;
                        Resource.SETRANGE("No.", Rec."No.");
                        Resource.FINDSET;
                        PAGE.RUN(76, Resource);
                    END;
                    END;
                //++ #9804
                end;
            }
            action("Where-Used")
            {
                ApplicationArea = All;
                Caption = 'Puntos-de-uso';
                Image = Track;
                RunObject = Page "Where-Used List";
                RunPageLink = Type=CONST(Item), "No."=FIELD("No.");
                RunPageView = SORTING(Type, "No.");
            }
            action("Componentes Receta")
            {
                ApplicationArea = All;
                Caption = 'Componentes Receta';
                Image = BOM;
                RunObject = Page "Componentes Evento";
                RunPageLink = "Codigo Evento"=FIELD("Codigo Evento"), "Linea Evento"=FIELD("Linea Evento"), "Parent Item No."=FIELD("No.");
            }
            group("Info Calidad")
            {
                Caption = 'Info Calidad';
                Image = Confirm;

                action(AGRALAInfoCalidad)
                {
                    ApplicationArea = All;
                    Caption = 'Info Calidad';
                    Image = QualificationOverview;

                    trigger OnAction()
                    var
                        rlItemVariant: Record 5401;
                        rlAssemblyLine: Record "Assembly Line";
                        xlFiltros: Text;
                        //pl: Page "50075";
                        rlBOMComponent: Record "BOM Component";
                        rlBOMComponent2: Record "BOM Component";
                        rlBOMComponent3: Record "BOM Component";
                        rlBOMComponent4: Record "BOM Component";
                    begin
                        xlFiltros+='|' + Rec."No.";
                        rlBOMComponent.SETRANGE("Parent Item No.", Rec."No.");
                        rlBOMComponent.SETRANGE(Type, rlBOMComponent.Type::Item);
                        IF rlBOMComponent.FINDSET THEN REPEAT xlFiltros+='|' + rlBOMComponent."No.";
                                CLEAR(rlBOMComponent2);
                                rlBOMComponent2.SETRANGE("Parent Item No.", rlBOMComponent."No.");
                                rlBOMComponent2.SETRANGE(Type, rlBOMComponent.Type::Item);
                                IF rlBOMComponent2.FINDSET THEN REPEAT xlFiltros+='|' + rlBOMComponent2."No.";
                                        CLEAR(rlBOMComponent3);
                                        rlBOMComponent3.SETRANGE("Parent Item No.", rlBOMComponent2."No.");
                                        rlBOMComponent3.SETRANGE(Type, rlBOMComponent.Type::Item);
                                        IF rlBOMComponent3.FINDSET THEN REPEAT xlFiltros+='|' + rlBOMComponent3."No.";
                                                CLEAR(rlBOMComponent4);
                                                rlBOMComponent4.SETRANGE("Parent Item No.", rlBOMComponent3."No.");
                                                rlBOMComponent4.SETRANGE(Type, rlBOMComponent.Type::Item);
                                                IF rlBOMComponent4.FINDSET THEN REPEAT xlFiltros+='|' + rlBOMComponent4."No.";
                                                    UNTIL rlBOMComponent4.NEXT = 0;
                                            UNTIL rlBOMComponent3.NEXT = 0;
                                    UNTIL rlBOMComponent2.NEXT = 0;
                            UNTIL rlBOMComponent.NEXT = 0;
                        xlFiltros:=COPYSTR(xlFiltros, 2);
                        rlItemVariant.SETFILTER("Item No.", xlFiltros);
                        PAGE.RUN(50075, rlItemVariant);
                    end;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        Rcd_Resource: Record 156;
        Rcd_Vendor: Record 23;
    begin
        IsResource:=Rec.Type = Rec.Type::Resource;
        //ADV001 Inicio
        CLEAR(txtNombreProveedor);
        IF Rcd_Vendor.GET(Rec."Proveedor por Defecto")THEN txtNombreProveedor:=Rcd_Vendor."Search Name";
        //ADV001 Fin
        //-- #9804
        VarFormato:=Rec.ReturnFormat(Rec);
        VarFormatoImportanciaCoste:=Rec.ReturnFormatImportanciaCoste(Rec);
        //++ #9804
        //SL INICIO
        Rec.ActualizarImportancia();
    //SL END
    end;
    trigger OnAfterGetCurrRecord()
    begin
        //SL INICIO
        Rec.ActualizarImportancia();
    //SL END
    end;
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //-- #9862
        VarFormato:='';
        VarFormatoImportanciaCoste:='';
        Rec.Type:=Rec.Type::Item;
        //++ #9862
        IF paramEvento <> '' THEN BEGIN
            Rec."Codigo Evento":=paramEvento;
            Rec."Linea Evento":=paramLinea;
            Rec."Parent Item No.":=paramParentItemNo;
        END;
    end;
    var IsResource: Boolean;
    txtNombreProveedor: Text[50];
    VarFormato: Text;
    VarFormatoImportanciaCoste: Text;
    paramEvento: Code[20];
    paramLinea: Decimal;
    paramParentItemNo: Code[20];
    procedure SetParameters(paramEvento2: Code[20]; paramLinea2: Decimal; paramParentItemNo2: Code[20])
    begin
        paramEvento:=paramEvento2;
        paramLinea:=paramLinea2;
        paramParentItemNo:=paramParentItemNo2;
    end;
}
