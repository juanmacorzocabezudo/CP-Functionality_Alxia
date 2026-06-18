page 50079 "Lista Componentes Eventos"
{
    ApplicationArea = All;
    Caption = 'Lista Componentes Eventos';
    PageType = List;
    SourceTable = "Componentes Evento";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Parent Item No."; Rec."Parent Item No.")
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Assembly BOM"; Rec."Assembly BOM")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Quantity per"; Rec."Quantity per")
                {
                    ApplicationArea = All;
                }
                field(Position; Rec.Position)
                {
                    ApplicationArea = All;
                }
                field("Position 2"; Rec."Position 2")
                {
                    ApplicationArea = All;
                }
                field("Position 3"; Rec."Position 3")
                {
                    ApplicationArea = All;
                }
                field("Machine No."; Rec."Machine No.")
                {
                    ApplicationArea = All;
                }
                field("Lead-Time Offset"; Rec."Lead-Time Offset")
                {
                    ApplicationArea = All;
                }
                field("BOM Description"; Rec."BOM Description")
                {
                    ApplicationArea = All;
                }
                field("Resource Usage Type"; Rec."Resource Usage Type")
                {
                    ApplicationArea = All;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                }
                field("Installed in Line No."; Rec."Installed in Line No.")
                {
                    ApplicationArea = All;
                }
                field("Installed in Item No."; Rec."Installed in Item No.")
                {
                    ApplicationArea = All;
                }
                field("Cantidad por Lote"; Rec."Cantidad por Lote")
                {
                    ApplicationArea = All;
                }
                field("Importancia en Coste"; Rec."Importancia en Coste")
                {
                    ApplicationArea = All;
                }
                field("Proveedor por Defecto"; Rec."Proveedor por Defecto")
                {
                    ApplicationArea = All;
                }
                field(CosteUnitario; Rec.CosteUnitario)
                {
                    ApplicationArea = All;
                }
                field(Comentario; Rec.Comentario)
                {
                    ApplicationArea = All;
                }
                field("Alias Proveedor"; Rec."Alias Proveedor")
                {
                    ApplicationArea = All;
                }
                field("Coste Calculado"; Rec."Coste Calculado")
                {
                    ApplicationArea = All;
                }
                field("Codigo Evento"; Rec."Codigo Evento")
                {
                    ApplicationArea = All;
                }
                field("Linea Evento"; Rec."Linea Evento")
                {
                    ApplicationArea = All;
                }
                field(TipoRecurso; Rec.TipoRecurso)
                {
                    ApplicationArea = All;
                }
                field("Coste Lote"; Rec."Coste Lote")
                {
                    ApplicationArea = All;
                }
                field(Bocados; Rec.Bocados)
                {
                    ApplicationArea = All;
                }
                field(Huérfano; Rec.Huérfano)
                {
                    ApplicationArea = All;
                }
                field(CantidadEscalado; Rec.CantidadEscalado)
                {
                    ApplicationArea = All;
                }
                field("Related Work Center"; Rec."Related Work Center")
                {
                    ApplicationArea = All;
                }
                field(CantidadPorLoteAnterior; Rec.CantidadPorLoteAnterior)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
