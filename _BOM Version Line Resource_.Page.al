page 50052 "BOM Version Line Resource"
{
    Caption = 'BOM Version Line Resource';
    PageType = ListPart;
    SourceTable = "BOM Version Lines";
    AutoSplitKey = true;
    DataCaptionFields = "Parent Item No.";
    MultipleNewLines = true;
    SourceTableView = SORTING("Parent Item No.", Type, TipoRecurso, Position)ORDER(Ascending)WHERE(Type=FILTER(' '|Resource));

    layout
    {
        area(content)
        {
            repeater(reper)
            {
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
                field("Assembly BOM"; Rec."Assembly BOM")
                {
                    ApplicationArea = All;
                }
                field("Cantidad por Lote"; Rec."Cantidad por Lote")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                }
                field("Importancia en Coste"; Rec."Importancia en Coste")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    StyleExpr = VarFormatoImportanciaCoste;
                }
                field("Quantity per"; Rec."Quantity per")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Installed in Item No."; Rec."Installed in Item No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Position; Rec.Position)
                {
                    ApplicationArea = All;
                    Visible = true;
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
                field(CosteUnitario; Rec.CosteUnitario)
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    Editable = false;
                }
                field(CalcCost; Rec.CalcItemUnitCost(Rec))
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    Caption = 'Actual Item Cost';
                    Editable = false;
                }
                field("Coste Calculado"; Rec."Coste Calculado")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    Caption = 'Coste Calculado por UMB';
                }
                field(Maquila; Rec.Maquila)
                {
                    ApplicationArea = All;
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
            group(Navegate)
            {
                Caption = 'Navegar';

                action(PageCard)
                {
                    ApplicationArea = All;
                    Caption = 'Card';

                    trigger OnAction()
                    var
                        Item: Record 27;
                        Resource: Record 156;
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
                    Caption = 'Supply by resource';
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
    end;
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //-- #9862
        VarFormato:='';
        VarFormatoImportanciaCoste:='';
    //++ #9862
    end;
    var IsResource: Boolean;
    txtNombreProveedor: Text[50];
    VarFormato: Text;
    VarFormatoImportanciaCoste: Text;
}
