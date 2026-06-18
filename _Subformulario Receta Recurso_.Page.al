page 50048 "Subformulario Receta Recurso"
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
    SourceTable = "BOM Component";
    SourceTableView = SORTING("Parent Item No.", "Line No.")ORDER(Ascending)WHERE(Type=FILTER(' '|Resource));

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field(TipoRecurso; Rec.TipoRecurso)
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
                field(CentroTrabajo; Rec.CentroTrabajo)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        LoadWorkCenter();
                        CurrPage.Update();
                    end;
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
                    DecimalPlaces = 4: 4;
                    Editable = false;
                }
                field(CantidadCosteUnitario; Rec."Cantidad por Lote" * Rec.CosteUnitario)
                {
                    ApplicationArea = All;
                    Caption = 'Coste Total';
                    StyleExpr = VarFormatoImportanciaCoste;
                }
                field(cacl; Rec.CalcItemUnitCost(Rec))
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    Caption = 'Coste Unitario';
                    //DecimalPlaces = 4 : 4;
                    Editable = false;
                }
                field("Quantity per"; Rec."Quantity per")
                {
                    Caption = 'Cantidad por UMB';
                    ApplicationArea = All;
                    BlankZero = true;
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
                field(Maquila; Rec.Maquila)
                {
                    ApplicationArea = All;
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
                field("Related Work Center"; Rec."Related Work Center")
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
            action(WorkCenter)
            {
                Caption = 'Seleccionar Centro Trabajo';
                ApplicationArea = All;
                Image = WorkCenter;

                trigger OnAction()
                var
                    WorkcenterHeader: Record 50022;
                begin
                    WorkcenterHeader.RESET;
                    IF PAGE.RUNMODAL(50046, WorkcenterHeader) = ACTION::LookupOK THEN BEGIN
                        Rec.InsertLinesFromWorkCenter(Rec."Parent Item No.", WorkcenterHeader."No.");
                    END;
                end;
            }
            action(acc_Escalados)
            {
                Caption = 'Escalados';
                ApplicationArea = All;
                Image = AnalysisView;
                RunObject = Page 50036;
                RunPageLink = NumeroLM=FIELD("Parent Item No."), NumeroLinea=FIELD("Line No."), Tipo=FIELD(Type), Numero=FIELD("No."), Descripcion=FIELD(Description), CodigoUnidadMedida=FIELD("Unit of Measure Code");
                RunPageView = SORTING(NumeroLM, NumeroLinea, Tipo, Numero, Descripcion, CodigoUnidadMedida, LoteReceta, CantidadLoteReceta)ORDER(Ascending);
            }
            action(PageCard)
            {
                Caption = 'Ficha';
                ApplicationArea = All;
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
        if Rec.CentroTrabajo = '' then Rec.CentroTrabajo:=Rec."Related Work Center";
    end;
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //-- #9862
        VarFormato:='';
        VarFormatoImportanciaCoste:='';
        Rec.Type:=Rec.Type::Resource;
    //++ #9862
    end;
    var IsResource: Boolean;
    txtNombreProveedor: Text[50];
    VarFormato: Text;
    VarFormatoImportanciaCoste: Text;
    procedure LoadWorkCenter()
    var
        WorkcenterHeader: Record 50022;
        WorkCenterLine: Record 50023;
        BOMComponent: Record 90;
        TextInsWorkCenter: Label '¿Quiere cargar las lineas del centro de trabajo %1 en la LM del producto %2?';
        VarLineNo: Integer;
        LineNo: Integer;
    begin
        //Rec.Insert();
        //-- #9785
        IF Confirm(TextInsWorkCenter, TRUE, Rec.CentroTrabajo, Rec."Parent Item No.")then Begin
            WorkCenterLine.Reset();
            WorkCenterLine.SetRange("Work Center No.", Rec.CentroTrabajo);
            IF WorkCenterLine.FindFirst()then begin
                //** Se introduce la linea de descripción del centro de trabajo
                WorkcenterHeader.Get(WorkCenterLine."Work Center No.");
                Clear(VarLineNo);
                VarLineNo:=Rec."Line No.";
                //BOMComponent.INIT;
                //BOMComponent."Line No." := Rec."Line No.";
                Rec.Validate("Parent Item No.", Rec."Parent Item No.");
                //BOMComponent.VALIDATE("Line No.", VarLineNo);
                Rec.Validate(Type, BOMComponent.Type::" ");
                Rec.Description:=WorkcenterHeader.Description;
                Rec.Validate("Related Work Center", Rec.CentroTrabajo);
                if not Rec.Insert()then Rec.Modify();
                LineNo:=VarLineNo + 10;
                REPEAT //** Se introduce las lineas del centro de trabajo
                    BOMComponent.INIT;
                    BOMComponent.VALIDATE("Parent Item No.", Rec."Parent Item No.");
                    BOMComponent.VALIDATE("Line No.", LineNo);
                    BOMComponent.VALIDATE(Type, BOMComponent.Type::Resource);
                    BOMComponent.VALIDATE("No.", WorkCenterLine."No.");
                    BOMComponent.VALIDATE("Unit of Measure Code", WorkCenterLine."Unit of Mesaruement");
                    BOMComponent.VALIDATE("Related Work Center", Rec.CentroTrabajo);
                    BOMComponent.CentroTrabajo:=Rec.CentroTrabajo;
                    BOMComponent.VALIDATE("Cantidad por Lote", WorkCenterLine."Quantity per"); //** #9993
                    BOMComponent.VALIDATE(CosteUnitario, WorkCenterLine."Resource Cost");
                    BOMComponent."Coste Calculado":=WorkCenterLine."Quantity per" * WorkCenterLine."Resource Cost";
                    if not BOMComponent.INSERT()then BOMComponent.Modify();
                    LineNo:=LineNo + 10;
                UNTIL WorkCenterLine.NEXT = 0;
            END;
        END;
    //++ #9785
    end;
}
