page 50095 AlxiaComonosconociste
{
    ApplicationArea = All;
    Caption = 'Como nos conociste';
    PageType = List;
    SourceTable = AlxiaComonosconociste;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(id; Rec.id)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the id field.';
                }
                field(Valor; Rec.Valor)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Valor field.';
                }
            }
        }
    }
}
