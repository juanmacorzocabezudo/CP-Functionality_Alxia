page 50110 LineasPuntosDeObservacion
{
    PageType = ListPart;
    ApplicationArea = Basic, Suite;
    SourceTable = LineasPuntosDeObservacion;
    Caption = 'Líneas';

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
                    Editable = false;
                }
                field("Nro. Linea"; Rec."Nro. Linea")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Observacion; Rec.Observacion)
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
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean begin
        Rec."Nro. Linea":=Rec.NextLineNo();
    end;
}
