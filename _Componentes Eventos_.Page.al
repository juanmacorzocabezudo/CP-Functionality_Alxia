page 50068 "Componentes Eventos"
{
    PageType = List;
    UsageCategory = None;
    SourceTable = 50014;

    layout
    {
        area(content)
        {
            repeater(rep)
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
                field("Cantidad por Lote"; Rec."Cantidad por Lote")
                {
                    ApplicationArea = All;
                }
                field("Importancia en Coste"; Rec."Importancia en Coste")
                {
                    ApplicationArea = All;
                }
                field("Cantidad por Bandeja"; Rec."Cantidad por Bandeja")
                {
                    ApplicationArea = All;
                }
                field(CosteUnitario; Rec.CosteUnitario)
                {
                    ApplicationArea = All;
                    Caption = 'Coste Estandar';
                }
                field("Coste Calculado"; Rec."Coste Calculado")
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
            }
        }
    }
    actions
    {
    }
}
