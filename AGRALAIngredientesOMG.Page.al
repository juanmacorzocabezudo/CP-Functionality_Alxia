page 50070 AGRALAIngredientesOMG
{
    ApplicationArea = All;
    Caption = 'AGRALAIngredientesOMG';
    PageType = List;
    SourceTable = AGRALAIngredientes;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(AGRALADescripcion; Rec.AGRALADescripcion)
                {
                    ApplicationArea = All;
                    Caption = 'Descripción ingrediente OMG';
                }
            }
        }
    }
    actions
    {
    }
    trigger OnClosePage()
    var
        rlAGRALAIngredientes: Record 50018;
        rlItemVariant: Record 5401;
    begin
        rlItemVariant.GET(Rec.AGRALACodProducto, Rec.AGRALACodVariante);
        rlItemVariant.AGRALAingredientesOMGText:='';
        rlAGRALAIngredientes.SETRANGE(AGRALACodProducto, Rec.AGRALACodProducto);
        rlAGRALAIngredientes.SETRANGE(AGRALACodVariante, Rec.AGRALACodVariante);
        rlAGRALAIngredientes.SETRANGE(AGRALATipo, Rec.AGRALATipo::OMG);
        IF rlAGRALAIngredientes.FINDSET THEN BEGIN
            REPEAT rlItemVariant.AGRALAingredientesOMGText+=rlAGRALAIngredientes.AGRALADescripcion + ',' + ' ';
            UNTIL rlAGRALAIngredientes.NEXT = 0;
            rlItemVariant.AGRALAOMG:=TRUE;
        END
        ELSE
        BEGIN
            rlItemVariant.AGRALAOMG:=FALSE;
        END;
        rlItemVariant.MODIFY();
    end;
}
