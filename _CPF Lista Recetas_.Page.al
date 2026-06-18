page 50123 "CPF Lista Recetas"
{
    PageType = List;
    Caption = 'Recipes list', comment = 'ESP="Lista de recetas"';
    SourceTable = Item;
    SourceTableView = sorting("No.")order(ascending)where("Assembly BOM"=filter(true));
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Control50000)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
        }
    }
    var myInt: Integer;
}
