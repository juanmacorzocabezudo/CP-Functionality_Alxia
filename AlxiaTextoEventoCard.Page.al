page 50087 AlxiaTextoEventoCard
{
    Caption = 'Ficha Textos Eventos';
    PageType = Card;
    SourceTable = AlxiaTextoEventos;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

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
            }
            group(Textos)
            {
                group("TextoSaludo")
                {
                    Caption = 'Texto Saludo';

                    field("Texto Saludo"; Rec."Texto Saludo")
                    {
                        ApplicationArea = All;
                        Importance = Additional;
                        MultiLine = true;
                        ShowCaption = false;
                    }
                }
                group("TextoOtrasopciones")
                {
                    Caption = 'Texto Otras opciones';

                    field("Texto Otras opciones"; Rec."Texto Otras opciones")
                    {
                        ApplicationArea = All;
                        Importance = Additional;
                        MultiLine = true;
                        ShowCaption = false;
                    }
                }
                group("TextoDirectrices")
                {
                    Caption = 'Texto Directrices';

                    field("Texto Directrices"; Rec."Texto Directrices")
                    {
                        ApplicationArea = All;
                        Importance = Additional;
                        MultiLine = true;
                        ShowCaption = false;
                    }
                }
                group("TextoClienteaportaparasi")
                {
                    Caption = 'Texto Cliente aporta para si';

                    field("Texto Cliente aporta para si"; Rec."Texto Cliente aporta para si")
                    {
                        ApplicationArea = All;
                        Importance = Additional;
                        MultiLine = true;
                        ShowCaption = false;
                    }
                }
                group("TextoClienteaportacatering")
                {
                    Caption = 'Texto Cliente aporta catering';

                    field("Texto Cliente aporta catering"; Rec."Texto Cliente aporta catering")
                    {
                        ApplicationArea = All;
                        Importance = Additional;
                        MultiLine = true;
                        ShowCaption = false;
                    }
                }
                group("TextoDoc.obligatoria")
                {
                    Caption = 'Texto Documentación obligatoria';

                    field("Texto Doc. obligatoria"; Rec."Texto Doc. obligatoria")
                    {
                        ApplicationArea = All;
                        Importance = Additional;
                        MultiLine = true;
                        ShowCaption = false;
                    }
                }
                group("TextoFormasdepago")
                {
                    Caption = 'Texto Formas de pago';

                    field("Texto Formas de pago"; Rec."Texto Formas de pago")
                    {
                        ApplicationArea = All;
                        Importance = Additional;
                        MultiLine = true;
                        ShowCaption = false;
                    }
                }
                group("TextoCondicionescontratación")
                {
                    Caption = 'Texto Condiciones contratación';

                    field("Texto Condiciones contratación"; Rec."Texto Condiciones contratación")
                    {
                        ApplicationArea = All;
                        Importance = Additional;
                        MultiLine = true;
                        ShowCaption = false;
                    }
                }
                group("TextoDespedida")
                {
                    Caption = 'Texto Despedida';

                    field("Texto Despedida"; Rec."Texto Despedida")
                    {
                        ApplicationArea = All;
                        Importance = Additional;
                        MultiLine = true;
                        ShowCaption = false;
                    }
                }
            }
        }
    }
}
