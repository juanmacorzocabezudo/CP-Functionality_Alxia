page 50144 AlxCosteTotalIndirecto
{
    Caption = 'Coste Total Indirecto';
    PageType = Card;
    SourceTable = Evento;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    Editable = false;

    layout
    {
        area(Content)
        {
            part(Productos; AlxProductosEventos)
            {
                ApplicationArea = All;
                Caption = 'Productos Eventos';
                SubPageLink = "Codigo Evento"=FIELD("Codigo Evento");
                SubPageView = SORTING("Codigo Evento", Linea);
            }
            part(Recursos; AlxRecursosEvento)
            {
                ApplicationArea = All;
                Caption = 'Recursos Eventos';
                SubPageLink = "Codigo Evento"=FIELD("Codigo Evento");
                SubPageView = SORTING("Codigo Evento", Linea);
            }
        }
    }
}
