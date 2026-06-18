page 50114 ListaPuntosDeControl
{
    PageType = List;
    Caption = 'Puntos de Control';
    ApplicationArea = Basic, Suite;
    UsageCategory = Tasks;
    SourceTable = PuntosDeControl;
    CardPageId = PuntoDeControl;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Control50000)
            {
                ShowCaption = false;

                field("Codigo Punto Control"; Rec."Codigo Punto Control")
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
