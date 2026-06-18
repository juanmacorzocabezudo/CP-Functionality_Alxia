codeunit 50011 AGRALAActualizaRecetas
{
    trigger OnRun()
    var
        AGRALABOMAditionalCost: Record 50029;
        AGRALAItem: Record 27;
        BOMComponent: Record 90;
        BOMAditionalCost: Record 50029;
        AGRALAHistoricoCosteEstandar: Record 50030;
        rlItem: Record 27;
        Item: Record 27;
    begin
        //AGRALAMO - 413
        /*AGRALABOMAditionalCost.RESET;
        IF AGRALABOMAditionalCost.FINDSET THEN BEGIN
        REPEAT
        AGRALAHistoricoCosteEstandar.RESET;
        AGRALAHistoricoCosteEstandar.SETRANGE(AGRALAIdProducto,AGRALABOMAditionalCost."Item No");
        AGRALAHistoricoCosteEstandar.SETRANGE(AGRALACosteGeneral,Item."Standard Cost");
        IF NOT AGRALAHistoricoCosteEstandar.FINDFIRST THEN BEGIN
          AGRALAHistoricoCosteEstandar.INIT;
          AGRALAHistoricoCosteEstandar.AGRALAIdProducto := Item."No.";
          AGRALAHistoricoCosteEstandar.AGRALACosteGeneral := Item."Standard Cost";
          AGRALAHistoricoCosteEstandar.AGRALAFechaModificacion := CURRENTDATETIME;
          AGRALAHistoricoCosteEstandar.INSERT;
        END;
        AGRALABOMAditionalCost.ActualicyCost(AGRALABOMAditionalCost."Item No", AGRALABOMAditionalCost."BOM Version");
        BOMComponent.RESET;
        BOMComponent.SETRANGE("Parent Item No.",AGRALABOMAditionalCost."Item No");
        BOMComponent.SETRANGE(Maquila, FALSE);
        BOMComponent.SETRANGE("Assembly BOM",TRUE);
        IF BOMComponent.FINDSET THEN BEGIN
          BOMAditionalCost.SETRANGE("Item No",BOMComponent."No.");
          IF BOMAditionalCost.FINDFIRST THEN BEGIN
            AGRALABOMAditionalCost.ActualicyCost(BOMAditionalCost."Item No", BOMAditionalCost."BOM Version");
            END;
        END;
        AGRALABOMAditionalCost.ActualicyCost(AGRALABOMAditionalCost."Item No", AGRALABOMAditionalCost."BOM Version");
          UNTIL AGRALABOMAditionalCost.NEXT = 0;
        END;
        MESSAGE('Fin');*/
        //AGRALAMO - 413
        //+AGRALAMO - 412
        rlItem.RESET;
        //rlItem.SETFILTER(rlItem."No.",'CA*');
        IF rlItem.FINDSET THEN REPEAT rlItem.SetFijarCosteLMRecetaEnFichaArticulo;
                BOMAditionalCost.ActualicyCost(rlItem."No.", 0);
                BOMAditionalCost.RESET;
                BOMAditionalCost.SETRANGE(BOMAditionalCost."Item No", rlItem."No.");
                IF BOMAditionalCost.FINDFIRST THEN REPEAT BOMAditionalCost.ActualicyCost(BOMAditionalCost."Item No", BOMAditionalCost."BOM Version");
                        BOMAditionalCost.VALIDATE(Value);
                        BOMAditionalCost.MODIFY;
                    UNTIL BOMAditionalCost.NEXT = 0;
                BOMAditionalCost.ActualicyCost(rlItem."No.", 0);
            UNTIL rlItem.NEXT = 0;
    //-AGRALAMO - 412
    end;
}
