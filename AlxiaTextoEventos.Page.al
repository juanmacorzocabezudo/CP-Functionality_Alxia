page 50094 AlxiaTextoEventos
{
    Caption = 'Textos Eventos';
    PageType = List;
    SourceTable = AlxiaTextoEventos;
    UsageCategory = None;
    CardPageId = AlxiaTextoEventoCard;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Código Texto"; Rec."Código Texto")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Código Texto field.';
                }
                field("Descripción Texto"; Rec."Descripción Texto")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Descripción Texto field.';
                }
                field("Texto Saludo"; Rec."Texto Saludo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Texto Saludo field.';
                }
                field("Texto Otras opciones"; Rec."Texto Otras opciones")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Texto Otras opciones field.';
                }
                field("Texto Directrices"; Rec."Texto Directrices")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Texto Directrices field.';
                }
                field("Texto Cliente aporta para si"; Rec."Texto Cliente aporta para si")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Texto Cliente aporta para si field.';
                }
                field("Texto Cliente aporta catering"; Rec."Texto Cliente aporta catering")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Texto Cliente aporta catering field.';
                }
                field("Texto Doc. obligatoria"; Rec."Texto Doc. obligatoria")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Texto Documentación obligatoria field.';
                }
                field("Texto Formas de pago"; Rec."Texto Formas de pago")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Texto Formas de pago field.';
                }
                field("Texto Condiciones contratación"; Rec."Texto Condiciones contratación")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Texto Condiciones contratación field.';
                }
                field("Texto Despedida"; Rec."Texto Despedida")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Texto Despedida field.';
                }
            }
        }
    }
}
