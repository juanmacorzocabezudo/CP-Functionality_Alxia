page 50081 AGRALASeguimientoRecetasReg
{
    PageType = ListPart;
    SourceTable = 910;

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field(AGRALANivel; Rec.AGRALANivel)
                {
                    ApplicationArea = All;
                    Caption = 'Nivel';
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean var
                        rlAssemblyHeader: Record 900;
                    begin
                        //rlAssemblyHeader.SETRANGE("Document Type", Rec."Document Type");
                        rlAssemblyHeader.SETRANGE("No.", Rec."No.");
                        PAGE.RUN(920, rlAssemblyHeader);
                    end;
                }
            }
        }
    }
    actions
    {
    }
}
