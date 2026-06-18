page 50074 AGRALAAlergenos
{
    Caption = 'Alergenos';
    PageType = List;
    SourceTable = "Extended Text Header";
    PopulateAllFields = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(AGRALAAlergeno; Rec.AGRALAAlergeno)
                {
                    ApplicationArea = All;
                }
                field(AGRALAContiene; Rec.AGRALAContiene)
                {
                    ApplicationArea = All;
                }
                field(AGRALAPuedeContener; Rec.AGRALAPuedeContener)
                {
                    ApplicationArea = All;
                }
            /*  field(marca; Rec.AGRALAMarca)
                 {
                     ApplicationArea = All;
                     //Editable = false;
                 }
                 field("No."; Rec."No.")
                 {
                     ApplicationArea = All;
                     Editable = false;
                 }
                 field("Table Name"; Rec."Table Name")
                 {
                     ApplicationArea = All;
                     Editable = false;
                 } */
            }
        }
    }
    actions
    {
        area(creation)
        {
            action(RepartoCorrecto)
            {
                ApplicationArea = All;
                Promoted = true;

                trigger OnAction()
                var
                    rlItem: Record 27;
                    rlBOMComponent: Record 90;
                    rlBOMComponent2: Record 90;
                begin
                // IF rlBOMComponent.FINDSET THEN
                // REPEAT
                //     rlItem.GET(rlBOMComponent."Parent Item No.");
                //    IF rlItem."Lote Receta" <> 0 THEN BEGIN
                //     rlBOMComponent.VALIDATE("Cantidad por Lote",  rlBOMComponent."Cantidad por Lote");
                //     rlBOMComponent.MODIFY;
                //     END;
                // UNTIL rlBOMComponent.NEXT=0;
                end;
            }
        }
    }
    trigger OnClosePage()
    var
        rlExtendedTextHeader: Record 279;
        rlItemVariant: Record 5401;
        AGRALAAlergenosTrazasText: Text;
        AGRALAAlergenosContieneText: Text;
    begin
        rlItemVariant.SETRANGE("Item No.", Rec."No.");
        rlItemVariant.SETRANGE(Code, Rec.AGRALAMarca);
        IF rlItemVariant.FINDSET THEN REPEAT rlItemVariant.AGRALAAlergenosContenidoText:='';
                rlItemVariant.AGRALAAlergenosTrazasText:='';
                rlExtendedTextHeader.SETRANGE("No.", Rec."No.");
                rlExtendedTextHeader.SETRANGE(AGRALAMarca, Rec.AGRALAMarca);
                IF rlExtendedTextHeader.FINDSET THEN BEGIN
                    REPEAT IF rlExtendedTextHeader.AGRALAContiene = TRUE THEN AGRALAAlergenosContieneText+=FORMAT(rlExtendedTextHeader.AGRALAAlergeno) + ',' + ' ';
                        IF rlExtendedTextHeader.AGRALAPuedeContener = TRUE THEN AGRALAAlergenosTrazasText+=FORMAT(rlExtendedTextHeader.AGRALAAlergeno) + ',' + ' ';
                    UNTIL rlExtendedTextHeader.NEXT = 0;
                    rlItemVariant.AGRALAAlergenos:=TRUE;
                END
                ELSE
                BEGIN
                    rlItemVariant.AGRALAAlergenos:=FALSE;
                END;
                rlItemVariant.AGRALAAlergenosContenidoText:=COPYSTR(AGRALAAlergenosContieneText, 1, 250);
                rlItemVariant.AGRALAAlergenosTrazasText:=COPYSTR(AGRALAAlergenosTrazasText, 1, 250);
                rlItemVariant.MODIFY;
            UNTIL rlItemVariant.NEXT() = 0;
    end;
}
