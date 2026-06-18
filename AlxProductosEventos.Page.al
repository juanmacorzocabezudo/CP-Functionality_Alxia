page 50146 AlxProductosEventos
{
    ApplicationArea = All;
    Caption = 'Productos Eventos';
    PageType = ListPart;
    SourceTable = "Productos Evento";
    UsageCategory = Documents;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Linea; Rec.Linea)
                {
                    ApplicationArea = All;
                }
                field("Codigo Producto"; Rec."Codigo Producto")
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
                }
                field(Comentarios; Rec.Comentarios)
                {
                    ApplicationArea = All;
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
                field(Tipo; Rec.Tipo)
                {
                    ApplicationArea = All;
                }
                field(Importe; Rec.Importe)
                {
                    ApplicationArea = All;
                }
                field("% IVA"; Rec."% IVA")
                {
                    ApplicationArea = All;
                }
                field("Importe IVA Incl."; Rec."Importe IVA Incl.")
                {
                    ApplicationArea = All;
                }
                field("Precio IVA Incl."; Rec."Precio IVA Incl.")
                {
                    ApplicationArea = All;
                }
                field(Imprime; Rec.Imprime)
                {
                    ApplicationArea = All;
                }
                field(Producto; Rec.Producto)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
