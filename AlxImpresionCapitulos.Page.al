page 50115 AlxImpresionCapitulos
{
    ApplicationArea = All;
    Caption = 'AlxImpresionCapitulos';
    PageType = List;
    SourceTable = AlxImpresionCapitulos;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                }
                field(Descripcion; Rec.Descripcion)
                {
                }
            }
        }
    }
}
