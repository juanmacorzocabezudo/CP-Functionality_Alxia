page 50020 "Calculo pan subform"
{
    // 
    // ADVANCE - Log de cambios
    // -----------------------------------------------------
    //   ADVANCE
    //   Fecha: 19-04-2016
    //   Técnico: JMAP
    //   Presupuesto: Proyecto I002478 - RQ700 Calculo del pan
    // 
    //   Etiqueta: ADV001
    // -----------------------------------------------------
    PageType = ListPart;
    SourceTable = "Calculo pan";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cod. Variedad Evento"; Rec."Cod. Variedad Evento")
                {
                    ApplicationArea = All;
                }
                field("Descripcion Variedad Evento"; Rec."Descripcion Variedad Evento")
                {
                    ApplicationArea = All;
                }
                field("Cantidad Barras"; Rec."Cantidad Barras")
                {
                    ApplicationArea = All;
                }
                field("Precio Barras"; Rec."Precio Barras")
                {
                    ApplicationArea = All;
                }
                field("Cantidad Pan Gallego"; Rec."Cantidad Pan Gallego")
                {
                    ApplicationArea = All;
                }
                field("Precio Pan Gallego"; Rec."Precio Pan Gallego")
                {
                    ApplicationArea = All;
                }
                field("Cantidad Colines"; Rec."Cantidad Colines")
                {
                    ApplicationArea = All;
                }
                field("Precio Colines"; Rec."Precio Colines")
                {
                    ApplicationArea = All;
                }
                field("Cantidad Alcachofas"; Rec."Cantidad Alcachofas")
                {
                    ApplicationArea = All;
                }
                field("Precio Alcachofas"; Rec."Precio Alcachofas")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}
