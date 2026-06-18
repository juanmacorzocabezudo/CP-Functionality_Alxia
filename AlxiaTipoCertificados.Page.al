page 50092 AlxiaTipoCertificados
{
    ApplicationArea = All;
    Caption = 'Tipo de Certificados';
    PageType = List;
    SourceTable = AlxiaTipoCertificado;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Codigo; Rec."Código")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Codigo field.';
                }
                field(Certificado; Rec.Certificado)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Certificado field.';
                }
            }
        }
    }
}
