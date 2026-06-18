page 50067 "Subform Evento Comp Recurso"
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
    Caption = 'Assembly BOM Resource';
    DataCaptionFields = "Parent Item No.";
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Componentes Evento";
    SourceTableView = SORTING("Codigo Evento", "Linea Evento", "Parent Item No.", "Line No.")ORDER(Ascending)WHERE(Type=FILTER(' '|Resource));

    layout
    {
        area(content)
        {
            repeater(rep)
            {
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
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
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
                    //Visible = false;
                    BlankZero = true;
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
            action(WorkCente2r)
            {
                Caption = 'Seleccionar Centro Trabajo';
                ApplicationArea = All;
                Image = WorkCenter;

                trigger OnAction()
                var
                    WorkcenterHeader: Record 50022;
                    BomComp: Record "BOM Component";
                begin
                    WorkcenterHeader.RESET;
                    IF PAGE.RUNMODAL(50046, WorkcenterHeader) = ACTION::LookupOK THEN BEGIN
                        //BomComp.InsertLinesFromWorkCenter(Rec."Parent Item No.", WorkcenterHeader."No.");
                        BomComp.InsertLinesFromWorkCenterEvento(Rec."Parent Item No.", WorkcenterHeader."No.", Rec."Codigo Evento", Rec."Linea Evento");
                    END;
                end;
            }
            action(acc_Escalados)
            {
                ApplicationArea = All;
                Caption = 'Escalados';
                Enabled = false;
                Image = AnalysisView;
                RunObject = Page 50036;
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
            action(SupplyByResource)
            {
                ApplicationArea = All;
                Caption = 'Suministros por recursos';
                Image = ResourceCosts;

                trigger OnAction()
                var
                    SupplyByResource: Record 50021;
                begin
                    //-- #9804
                    CASE Rec.Type OF Rec.Type::Resource: BEGIN
                        SupplyByResource.RESET;
                        SupplyByResource.SETRANGE(Resource, Rec."No.");
                        SupplyByResource.FINDSET;
                        PAGE.RUN(50043, SupplyByResource);
                    END;
                    END;
                //++ #9804
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        Rcd_Resource: Record Resource;
        Rcd_Vendor: Record Vendor;
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
    end;
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //-- #9862
        VarFormato:='';
        VarFormatoImportanciaCoste:='';
        Rec.Type:=Rec.Type::Resource;
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
    end;
}
