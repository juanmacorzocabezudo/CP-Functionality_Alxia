page 50017 "Variedades de Evento"
{
    PageType = List;
    SourceTable = "Variedad de Evento";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Codigo; Rec.Codigo)
                {
                    ApplicationArea = All;
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                }
                field("Hora Inicio"; Rec."Hora Inicio")
                {
                    ApplicationArea = All;
                }
                field("Hora Fin"; Rec."Hora Fin")
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
