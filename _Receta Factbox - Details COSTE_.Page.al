page 50062 "Receta Factbox - Details COSTE"
{
    // #9785 - Se introduce el coste unitario
    Caption = 'Receta - Detalles Costos';
    PageType = CardPart;
    SourceTable = Item;

    layout
    {
        area(content)
        {
            group(ItemInf)
            {
                Caption = 'Informacion Producto';

                field("Standard Cost"; Rec."Standard Cost")
                {
                    ApplicationArea = All;
                    Caption = 'Costo estándar';
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    Caption = 'Costo unitario';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}
