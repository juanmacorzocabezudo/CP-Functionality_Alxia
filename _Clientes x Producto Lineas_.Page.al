page 50118 "Clientes x Producto Lineas"
{
    PageType = ListPart;
    SourceTable = "Productos Clientes";

    layout
    {
        area(Content)
        {
            repeater(Control50000)
            {
                ShowCaption = false;

                field("Nro. Cliente"; Rec."Nro. Cliente")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Nombre Cliente"; Rec."Nombre Cliente")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        Editable(true);
    end;
    var myInt: Integer;
}
