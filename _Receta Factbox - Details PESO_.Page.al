page 50065 "Receta Factbox - Details PESO"
{
    // #9785 - Se introduce el coste unitario
    Caption = 'Receta - Detalle';
    PageType = CardPart;
    SourceTable = Item;

    layout
    {
        area(content)
        {
            group(Pesos)
            {
                Caption = 'Pesos y Mermas';

                field(PesoBruto; AsmInfoPaneMgt.CalcPesoBrutoNetoReceta(Rec, TRUE, FALSE))
                {
                    ApplicationArea = All;
                    Caption = 'Peso Bruto';
                }
                field(PesoNeto; AsmInfoPaneMgt.CalcPesoBrutoNetoReceta(Rec, FALSE, TRUE))
                {
                    ApplicationArea = All;
                    Caption = 'Peso Neto';
                }
                field("%Merma"; AsmInfoPaneMgt.CalcPerMermaReceta(Rec))
                {
                    ApplicationArea = All;
                    Caption = '% Merma';
                }
            }
        }
    }
    actions
    {
    }
    var AsmInfoPaneMgt: Codeunit AlxiaFuncionesImportadas;
}
