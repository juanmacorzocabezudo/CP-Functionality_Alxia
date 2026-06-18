page 50112 LineasPuntosDeControl
{
    PageType = ListPart;
    ApplicationArea = Basic, Suite;
    SourceTable = LineasPuntosDeControl;
    Caption = 'Líneas';

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
                    Editable = false;
                }
                field("Nro. Linea"; Rec."Nro. Linea")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
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
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean begin
        Rec."Nro. Linea":=Rec.NextLineNo();
    end;
}
