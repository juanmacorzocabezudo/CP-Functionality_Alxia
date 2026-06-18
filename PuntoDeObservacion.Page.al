page 50109 PuntoDeObservacion
{
    PageType = Card;
    Caption = 'Punto de Observación';
    ApplicationArea = Basic, Suite;
    SourceTable = PuntosdeObservaciones;

    layout
    {
        area(Content)
        {
            group(Control50000)
            {
                Caption = 'General';

                field("Codigo Punto Observacion"; Rec."Codigo Punto Observacion")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            part(Lineas; LineasPuntosDeObservacion)
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Codigo Punto Observacion"=field("Codigo Punto Observacion");
                UpdatePropagation = Both;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                Visible = false;

                trigger OnAction()
                begin
                end;
            }
        }
    }
    var myInt: Integer;
}
