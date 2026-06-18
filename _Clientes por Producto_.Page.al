page 50117 "Clientes por Producto"
{
    PageType = Card;
    SourceTable = Item;
    LinksAllowed = false;

    layout
    {
        area(Content)
        {
            group(Contorl50000)
            {
                ShowCaption = false;
                Visible = false;

                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part(Clientes; "Clientes x Producto Lineas")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Customers', comment = 'ESP="Clientes"';
                SubPageLink = "Nro. Producto"=field("No.");
                Editable = true;
            }
        }
    }
    var myInt: Integer;
}
