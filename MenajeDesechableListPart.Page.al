page 50037 MenajeDesechableListPart
{
    Caption = 'Menaje Desechable';
    PageType = ListPart;
    AutoSplitKey = true;
    //DelayedInsert = true;
    SourceTable = "Productos Evento";
    SourceTableView = SORTING("Codigo Evento", Tipo, Linea)ORDER(Ascending)WHERE(Tipo=CONST(Menaje));

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
                    DecimalPlaces = 2: 3;
                }
                field("Coste Total"; Rec."Coste Total")
                {
                    ApplicationArea = All;
                    DecimalPlaces = 2: 3;
                }
                field(Precio; Rec.Precio)
                {
                    ApplicationArea = All;
                    Visible = false;
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
                field(Importe; Rec.Importe)
                {
                    ApplicationArea = All;
                    Caption = 'Importe';
                }
                field(IVA; Rec."% IVA")
                {
                    ApplicationArea = All;
                    Caption = '% IVA';
                }
                field("Importe IVA"; Rec."Importe IVA Incl.")
                {
                    ApplicationArea = All;
                    Caption = 'Importe IVA Incl.';
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
                RunPageLink = "Codigo Evento"=FIELD("Codigo Evento"), "Linea Evento"=FIELD(Linea), "Parent Item No."=FIELD(Producto);
            }
        }
    }
}
