page 50113 ListaPuntosDeObservaciones
{
    PageType = List;
    Caption = 'Puntos de Observaciones';
    ApplicationArea = Basic, Suite;
    UsageCategory = Tasks;
    SourceTable = PuntosdeObservaciones;
    CardPageId = PuntoDeObservacion;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Control50000)
            {
                ShowCaption = false;

                field("Codigo Punto Observacion"; Rec."Codigo Punto Observacion")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = Basic, Suite;
                }
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
