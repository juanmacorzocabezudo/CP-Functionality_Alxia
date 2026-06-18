page 50111 PuntoDeControl
{
    PageType = Card;
    Caption = 'Punto de Control';
    ApplicationArea = Basic, Suite;
    SourceTable = PuntosDeControl;

    layout
    {
        area(Content)
        {
            group(Control50000)
            {
                Caption = 'General';

                field("Codigo Punto Control"; Rec."Codigo Punto Control")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            part(Lineas; LineasPuntosDeControl)
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Codigo Punto Control"=field("Codigo Punto Control");
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
