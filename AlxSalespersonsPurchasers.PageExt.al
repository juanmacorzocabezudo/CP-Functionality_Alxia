pageextension 50041 AlxSalespersonsPurchasers extends "Salespersons/Purchasers"
{
    layout
    {
        addafter("Commission %")
        {
            /*  field("Líneas de Negocio"; Rec."Líneas de Negocio")
             {
                 ApplicationArea = All;
             } */
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;
                Caption = 'Líneas de Negocio';
            }
        }
    }
}
