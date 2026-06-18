page 50086 AlxiaTipoServicio
{
    ApplicationArea = All;
    Caption = 'Tipo Servicio';
    PageType = List;
    SourceTable = AlxiaTipoServicio;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Código "; Rec."Código")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Código  field.';
                }
                field("Descripción "; Rec."Descripción")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Descripción  field.';
                }
                field("Requiere Info calidad"; Rec."Requiere Info calidad")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Requiere Info calidad field.';
                }
            }
        }
    }
}
