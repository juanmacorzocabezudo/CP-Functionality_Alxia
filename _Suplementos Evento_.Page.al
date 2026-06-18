page 50033 "Suplementos Evento"
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
    SourceTableView = SORTING("Codigo Evento", Tipo, Linea)ORDER(Ascending)WHERE(Tipo=CONST(Suplementos));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
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
                    Visible = false;
                }
                field("Tipo Margen"; Rec."Tipo Margen")
                {
                    ApplicationArea = All;
                }
                field("Valor Margen"; Rec."Valor Margen")
                {
                    ApplicationArea = All;
                }
                field("Precio Propuesto"; Rec."Precio Propuesto")
                {
                    ApplicationArea = All;
                }
                field("Precio Real"; Rec."Precio Real")
                {
                    ApplicationArea = All;
                }
                field(Comentarios; Rec.Comentarios)
                {
                    ApplicationArea = All;
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
                    RecProEve: Record "Productos Evento";
                    RecProEveAux: Record "Productos Evento";
                    costeTotal: Decimal;
                begin
                    //SL: Inicio
                    /*      RecProEve.Reset();
                         RecProEve.SetRange(RecProEve."Codigo Evento", Rec."Codigo Evento");
                         if RecProEve.FindFirst() then
                             repeat
                                 RecProEveAux.Reset();
                                 RecProEveAux.SetRange("Codigo Evento", RecProEve."Codigo Evento");
                                 RecProEveAux.SetRange(Linea, RecProEve.Linea);
                                 RecProEveAux.SetRange(Producto, RecProEve.Producto);
                                 if RecProEveAux.FindFirst() then begin
                                     RecProEveAux.lfu_CalculaPreciosOut(RecProEveAux);
                                     RecProEveAux.Modify();
                                 end;
                             until RecProEve.Next() = 0;
                         //SL: Fin */
                    CurrPage.UPDATE;
                end;
            }
            action("Componentes Receta")
            {
                ApplicationArea = All;
                Image = BOM;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Page 50015;
                RunPageLink = "Codigo Evento"=FIELD("Codigo Evento"), "Linea Evento"=FIELD(Linea), "Parent Item No."=FIELD(Producto);
            }
        }
    }
}
