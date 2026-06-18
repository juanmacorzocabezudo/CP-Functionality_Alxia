page 50047 "Subformulario Receta Item"
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
    Caption = 'L.M. de ensamblado Producto';
    DataCaptionFields = "Parent Item No.";
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "BOM Component";
    SourceTableView = SORTING("Parent Item No.", "Line No.")ORDER(Ascending)WHERE(Type=FILTER(Item));

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
                    Caption = 'Marca';
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
                    Caption = 'Cód. unidad medida';
                    ApplicationArea = All;
                }
                field("Perc. Loss"; Rec."Perc. Loss")
                {
                    Caption = '% Merma';
                    ApplicationArea = All;
                    BlankZero = true;
                }
                field("Net Amount"; Rec."Net Amount")
                {
                    Caption = 'Cantidad neta';
                    ApplicationArea = All;
                    BlankZero = true;
                }
                field(CosteUnitario; Rec.CosteUnitario)
                {
                    Caption = 'Coste Estandar Marcado';
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
                    BlankZero = true;
                }
                field(Rcal; Rec.CalcItemUnitCost(Rec))
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    Caption = 'Coste Unitario';
                    DecimalPlaces = 4: 4;
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
                field(TipoRecurso; Rec.TipoRecurso)
                {
                    ApplicationArea = All;
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
                Caption = '&Desplegar L.M.';
                ApplicationArea = All;
                Image = ExplodeBOM;
                //Promoted = true;
                //PromotedCategory = Process;
                RunObject = Codeunit 51;
            }
            action(accReceta)
            {
                Caption = 'Receta';
                ApplicationArea = All;
                Enabled = Rec."Assembly BOM";
                Image = BOM;
                RunObject = Page 50000;
                RunPageLink = "No."=FIELD("No.");
                RunPageMode = Edit;
                RunPageView = SORTING("No.")ORDER(Ascending);
            }
            action(acc_Escalados)
            {
                Caption = 'Escalados';
                ApplicationArea = All;
                Image = AnalysisView;
                RunObject = Page 50036;
                RunPageLink = NumeroLM=FIELD("Parent Item No."), NumeroLinea=FIELD("Line No."), 
                #pragma warning disable AL0603
                Tipo=FIELD(Type), 
                #pragma warning restore AL0603
                Numero=FIELD("No."), CodigoUnidadMedida=FIELD("Unit of Measure Code");
                #pragma warning disable AL0254
                RunPageView = SORTING(NumeroLM, NumeroLinea, Tipo, Numero, CodigoUnidadMedida, LoteReceta, CantidadLoteReceta)
                #pragma warning restore AL0254
                ORDER(Ascending);
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
            action("Where-Used")
            {
                Caption = 'Puntos de uso';
                ApplicationArea = All;
                Image = Track;
                RunObject = Page "Where-Used List";
                RunPageLink = Type=CONST(Item), "No."=FIELD("No.");
                RunPageView = SORTING(Type, "No.");
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
        Rec.Type:=Rec.Type::Item;
    //++ #9862
    end;
    // GAP00040 >>>
    procedure MarcarComponentesConStock()
    begin
        Rec.SetFilter("Inventory Item No.", '<>%1', 0);
        CurrPage.Update();
    end;
    // GAP00040 <<<
    // GAP00040 >>>
    procedure DesMarcarComponentesConStock()
    begin
        Rec.SetRange("Inventory Item No.");
        CurrPage.Update();
    end;
    // GAP00040 <<<
    // GAP00040 >>>
    procedure MarcarComponentesCriticos()
    begin
        Rec.SetRange("Critical Item No.", true);
        CurrPage.Update();
    end;
    // GAP00040 <<<
    // GAP00040 >>>
    procedure DesMarcarComponentesCriticos()
    begin
        Rec.SetRange("Critical Item No.");
        CurrPage.Update();
    end;
    // GAP00040 <<<
    var Producto: Record Item;
    IsResource: Boolean;
    txtNombreProveedor: Text[50];
    VarFormato: Text;
    VarFormatoImportanciaCoste: Text;
}
