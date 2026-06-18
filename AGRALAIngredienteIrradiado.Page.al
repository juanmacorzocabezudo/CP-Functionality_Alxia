page 50071 AGRALAIngredienteIrradiado
{
    ApplicationArea = All;
    Caption = 'AGRALAIngredienteIrradiado';
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
                    Caption = 'Descripcion ingrediente irradiado';
                }
            }
        }
    }
    actions
    {
    }
    trigger OnClosePage()
    var
        rlItemVariant: Record 5401;
        rlAGRALAIngredientes: Record 50018;
    begin
        rlItemVariant.GET(Rec.AGRALACodProducto, Rec.AGRALACodVariante);
        rlItemVariant.AGRALAIrradiadoText:='';
        rlAGRALAIngredientes.SETRANGE(AGRALACodProducto, Rec.AGRALACodProducto);
        rlAGRALAIngredientes.SETRANGE(AGRALACodVariante, Rec.AGRALACodVariante);
        rlAGRALAIngredientes.SETRANGE(AGRALATipo, Rec.AGRALATipo::Irradiado);
        IF rlAGRALAIngredientes.FINDSET THEN BEGIN
            REPEAT rlItemVariant.AGRALAIrradiadoText+=rlAGRALAIngredientes.AGRALADescripcion + ',' + ' ';
            UNTIL rlAGRALAIngredientes.NEXT = 0;
            rlItemVariant.AGRALAIrradiado:=TRUE;
        END
        ELSE
        BEGIN
            rlItemVariant.AGRALAIrradiado:=FALSE;
        END;
        rlItemVariant.MODIFY;
    end;
}
