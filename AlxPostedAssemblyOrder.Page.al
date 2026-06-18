page 50097 AlxPostedAssemblyOrder
{
    ApplicationArea = All;
    Caption = 'Seguimiento lineas pedidos S/C';
    PageType = List;
    SourceTable = "Posted Assembly Line";
    UsageCategory = Lists;
    SourceTableView = SORTING("Document No.")ORDER(Ascending)WHERE(Type=filter(<>''));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Comentario; AssemblyHeader.Comment)
                {
                    ApplicationArea = All;
                }
                field("Nº Documento"; Rec."Document No.")
                {
                }
                field("Producto Ensamblado"; AssemblyHeader."Item No.")
                {
                    Caption = 'Producto Ensamblado';
                }
                field("Nº linea"; Rec."Line No.")
                {
                    Caption = 'Nº linea';
                }
                field("Descripción Producto Ensamblado"; Item.Description)
                {
                    Caption = 'Descripción Producto Ensamblado';
                }
                field("Fecha Registro"; AssemblyHeader."Posting Date")
                {
                    Caption = 'Fecha Registro';
                }
                field("Cantidad Ensamblada"; AssemblyHeader.Quantity)
                {
                    Caption = 'Cantidad Ensamblada';
                }
                field("UD Medida"; AssemblyHeader."Unit of Measure Code")
                {
                    Caption = 'UD Medida';
                }
                field("Cantidad Ensamblar Original"; AssemblyHeader."Cantidad Original")
                {
                    Caption = 'Cantidad Ensamblar Original';
                }
                field(Tipo; Rec.Type)
                {
                }
                field("Nº"; Rec."No.")
                {
                }
                field(Descripción; Rec.Description)
                {
                }
                field("Marca"; Rec."Variant Code")
                {
                    Caption = 'Marca';
                }
                field("Cód. almacén"; Rec."Location Code")
                {
                    Caption = 'Cód. almacén';
                }
                field("Cód. unidad medida"; Rec."Unit of Measure Code")
                {
                }
                field(Cantidad; Rec.Quantity)
                {
                }
                field("Cantidad por"; Rec."Quantity per")
                {
                    Caption = 'Cantidad por';
                }
                field("Linea de negocio"; _LineaNegocio)
                {
                    Visible = true;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    Visible = false;
                }
                field("Grupo_contable"; Rec."Inventory Posting Group")
                {
                    Visible = false;
                }
                field("Cdad. por unidad medida"; Rec."Qty. per Unit of Measure")
                {
                    Caption = 'Cdad. por unidad medida';
                }
                field("Tipo uso recursos"; Rec."Resource Usage Type")
                {
                    Caption = 'Tipo uso recursos';
                }
                field("Cantidad Original"; Rec."Cantidad Original")
                {
                    Caption = 'Cantidad Original';
                }
                field("Cantidad Por Original"; Rec."Cantidad Por Original")
                {
                    Caption = 'Cantidad Por Original';
                }
                field(Diferencia; Rec.Diferencia)
                {
                    StyleExpr = StyleTextDiferencia;
                }
                field("Diferencia%"; Rec."Diferencia%")
                {
                    StyleExpr = StyleTextDiferencia;
                }
                field(Nivel; Rec.AGRALANivel)
                {
                    Caption = 'Nivel';
                }
                field("Receta Madre"; Rec.AGRALARecetaMadre)
                {
                    Caption = 'Receta Madre';
                }
                field(Nro_Pedido_Original; _NroPedidoOriginal)
                {
                    Caption = 'Nº Pedido Original';
                    ApplicationArea = All;
                }
                field(PedidoAsociado; AssemblyHeader."Associated Order No.")
                {
                    ApplicationArea = All;
                }
                field(PrimerPedidoAsociado; AssemblyHeader."Associated First Order No.")
                {
                    ApplicationArea = All;
                }
                field(CentroCoste; Rec.AGRALACentroCoste)
                {
                    ApplicationArea = All;
                }
                field("Centro_trabajo"; Rec."Related Work Center")
                {
                    ApplicationArea = All;
                }
                field("NIVEL + PRODUCTO ENSAMBLADO"; Rec.AGRALANivel + '-' + Item.Description)
                {
                    Caption = 'NIVEL + PRODUCTO ENSAMBLADO';
                    ApplicationArea = All;
                }
                field("%_Merma"; Rec."Perc. Loss")
                {
                    ApplicationArea = All;
                }
                field(Responsable; Rec.AGRALAResponsable)
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
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;

                action(Dimensions)
                {
                    AccessByPermission = TableData 348=R;
                    Caption = 'Dimensiones';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        Rec.ShowDimensions;
                    end;
                }
                action("Item &Tracking Lines")
                {
                    Caption = 'Líns. seguim. prod.';
                    Image = ItemTrackingLines;
                    ShortCutKey = 'Shift+Ctrl+I';

                    trigger OnAction()
                    begin
                        Rec.ShowItemTrackingLines;
                    end;
                }
                action(Comments)
                {
                    Caption = 'Comentarios';
                    Image = ViewComments;
                    RunObject = Page 907;
                    RunPageLink = "Document Type"=CONST("Posted Assembly"), "Document No."=FIELD("Document No."), "Document Line No."=FIELD("Line No.");
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.SetCurrentKey("Document No.");
        Rec.Ascending(false);
    end;
    trigger OnAfterGetRecord()
    begin
        ClearAll();
        Evaluate(_Fecha, '01/11/2024');
        IF(Rec."Document No." <> AssemblyHeader."No.")THEN if AssemblyHeader.GET(Rec."Document No.")then _NroPedidoOriginal:=AssemblyHeader."Order No.";
        IF AssemblyHeader."Item No." <> Item."No." THEN begin
            Item.GET(AssemblyHeader."Item No.");
            _LineaNegocio:=Item."Global Dimension 1 Code";
        end;
        if(Rec.AGRALANivel = '') and (AssemblyHeader."Posting Date" >= _Fecha)then begin
            Rec.AGRALANivel:='00-Receta madre';
            Rec.AGRALARecetaMadre:=_NroPedidoOriginal;
        end;
        IF Rec.Diferencia = 0 THEN StyleTextDiferencia:='Standard'
        ELSE IF Rec.Diferencia > 0 THEN StyleTextDiferencia:='Unfavorable'
            ELSE IF Rec.Diferencia < 0 THEN StyleTextDiferencia:='Favorable';
    end;
    var AssemblyHeader: Record 910;
    Item: Record 27;
    StyleTextDiferencia: Text;
    _NroPedidoOriginal: Code[20];
    _LineaNegocio: Code[20];
    _Fecha: Date;
}
