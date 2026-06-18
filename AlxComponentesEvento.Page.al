page 50116 AlxComponentesEvento
{
    ApplicationArea = All;
    Caption = 'AlxComponentesEvento';
    PageType = List;
    SourceTable = "Componentes Evento";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Parent Item No."; Rec."Parent Item No.")
                {
                }
                field("Line No."; Rec."Line No.")
                {
                }
                field("Type"; Rec."Type")
                {
                }
                field("No."; Rec."No.")
                {
                }
                field("Assembly BOM"; Rec."Assembly BOM")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                }
                field("Quantity per"; Rec."Quantity per")
                {
                }
                field(Position; Rec.Position)
                {
                }
                field("Position 2"; Rec."Position 2")
                {
                }
                field("Position 3"; Rec."Position 3")
                {
                }
                field("Machine No."; Rec."Machine No.")
                {
                }
                field("Lead-Time Offset"; Rec."Lead-Time Offset")
                {
                }
                field("BOM Description"; Rec."BOM Description")
                {
                }
                field("Resource Usage Type"; Rec."Resource Usage Type")
                {
                }
                field("Variant Code"; Rec."Variant Code")
                {
                }
                field("Installed in Line No."; Rec."Installed in Line No.")
                {
                }
                field("Installed in Item No."; Rec."Installed in Item No.")
                {
                }
                field("Cantidad por Lote"; Rec."Cantidad por Lote")
                {
                }
                field("Importancia en Coste"; Rec."Importancia en Coste")
                {
                }
                field("Proveedor por Defecto"; Rec."Proveedor por Defecto")
                {
                }
                field(CosteUnitario; Rec.CosteUnitario)
                {
                }
                field(Comentario; Rec.Comentario)
                {
                }
                field("Alias Proveedor"; Rec."Alias Proveedor")
                {
                }
                field("Coste Calculado"; Rec."Coste Calculado")
                {
                }
                field("Codigo Evento"; Rec."Codigo Evento")
                {
                }
                field("Linea Evento"; Rec."Linea Evento")
                {
                }
                field(TipoRecurso; Rec.TipoRecurso)
                {
                }
                field("Coste Lote"; Rec."Coste Lote")
                {
                }
                field(Bocados; Rec.Bocados)
                {
                }
                field("Huérfano"; Rec."Huérfano")
                {
                }
                field(CantidadEscalado; Rec.CantidadEscalado)
                {
                }
                field("Related Work Center"; Rec."Related Work Center")
                {
                }
                field(Intermedio; Rec.Intermedio)
                {
                }
                field(CantidadPorLoteAnterior; Rec.CantidadPorLoteAnterior)
                {
                }
            }
        }
    }
}
