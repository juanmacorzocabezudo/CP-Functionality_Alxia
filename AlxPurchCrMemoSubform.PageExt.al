pageextension 50033 AlxPurchCrMemoSubform extends "Purch. Cr. Memo Subform"
{
    layout
    {
        modify("Variant Code")
        {
            Caption = 'Marca';
        }
        addafter(Description)
        {
            field("Marca"; Rec."Variant Code")
            {
                ApplicationArea = All;
                Caption = 'Marca';
            }
        }
    }
}
