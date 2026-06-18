page 50027 "Mov. Fichajes Empleados"
{
    Editable = false;
    PageType = List;
    SourceTable = "Movimientos fichaje empleados";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Resource No."; Rec."Resource No.")
                {
                    ApplicationArea = All;
                }
                field("Nombre recurso"; Rec."Nombre recurso")
                {
                    ApplicationArea = All;
                }
                field("Fecha Fichaje"; Rec."Fecha Fichaje")
                {
                    ApplicationArea = All;
                }
                field("Hora Fichaje"; Rec."Hora Fichaje")
                {
                    ApplicationArea = All;
                }
                field("Franja horaria"; Rec."Franja horaria")
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
