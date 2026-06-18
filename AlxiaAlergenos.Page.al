page 50088 AlxiaAlergenos
{
    ApplicationArea = All;
    Caption = 'Tipos de Alergenos';
    PageType = List;
    SourceTable = AlxiaAlergenos;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line No. field.';
                }
                field(Alergeno; Rec.Alergeno)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Alergeno field.';
                }
            }
        }
    }
}
