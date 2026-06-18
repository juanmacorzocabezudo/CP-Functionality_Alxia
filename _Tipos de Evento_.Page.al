page 50002 "Tipos de Evento"
{
    PageType = List;
    SourceTable = "Tipo de Evento";

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
        area(navigation)
        {
            group("Tipo Evento")
            {
                Caption = 'Tipo Evento';

                action(CalculoPan)
                {
                    Caption = 'Cálculo Pan';
                    ApplicationArea = All;
                    Image = Calculate;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page "Calculo Pan Ficha";
                    RunPageLink = Codigo=FIELD(Codigo);
                }
            }
        }
    }
}
