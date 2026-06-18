page 50069 "Lineas Eventos"
{
    Editable = false;
    PageType = List;
    SourceTable = "Lineas Evento";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Codigo Evento"; Rec."Codigo Evento")
                {
                    ApplicationArea = All;
                }
                field(Linea; Rec.Linea)
                {
                    ApplicationArea = All;
                }
                field(Tipo; Rec.Tipo)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
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
                field(Imprime; Rec.Imprime)
                {
                    ApplicationArea = All;
                }
                field(Comentarios; Rec.Comentarios)
                {
                    ApplicationArea = All;
                }
                field("Coste Directo"; Rec."Coste Directo")
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
                field("Coste Indirecto Recursos"; Rec."Coste Indirecto Recursos")
                {
                    ApplicationArea = All;
                }
                field("Precio Venta Recursos"; Rec."Precio Venta Recursos")
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
                field("Precio IVA Incl."; Rec."Precio IVA Incl.")
                {
                    ApplicationArea = All;
                }
                field("Coste Total"; Rec."Coste Total")
                {
                    ApplicationArea = All;
                }
                field("Coste Indirecto Pan"; Rec."Coste Indirecto Pan")
                {
                    ApplicationArea = All;
                }
                field("Coste Total Unitario"; Rec."Coste Total Unitario")
                {
                    ApplicationArea = All;
                }
                field(Bocados; Rec.Bocados)
                {
                    ApplicationArea = All;
                }
                field(ImportePorPersona; Rec.ImportePorPersona)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}
