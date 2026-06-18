codeunit 50004 "Cantidad Original"
{
    Permissions = TableData 910=rimd,
        TableData 911=rimd;

    trigger OnRun()
    begin
        RellenarPedidoEnsamblado;
        RellenarHistoricoEnsamblado;
    end;
    var UofMM: Codeunit 5402;
    local procedure RellenarHistoricoEnsamblado()
    var
        PostedAssemblyHeader: Record 910;
        PostedAssemblyLine: Record 911;
        BOMComponent: Record 90;
        BOMComponent2: Record 90;
        BOMComponent3: Record 90;
        Ventana: Dialog;
        intCont: Integer;
        intTotal: Integer;
    begin
        /*
        PostedAssemblyLine.MODIFYALL(PostedAssemblyLine."Cantidad Original", 0);
        PostedAssemblyLine.MODIFYALL(PostedAssemblyLine."Cantidad Por Original", 0);
        PostedAssemblyLine.MODIFYALL(PostedAssemblyLine.Diferencia, 0);
        PostedAssemblyLine.MODIFYALL(PostedAssemblyLine."Diferencia%", 0);
        */
        PostedAssemblyHeader.RESET;
        IF PostedAssemblyHeader.FINDFIRST THEN BEGIN
            intTotal:=PostedAssemblyHeader.COUNT;
            intCont:=0;
            Ventana.OPEN('Procesando @1@@@@@@@ #2##### de #3#####');
            Ventana.UPDATE(3, intTotal);
            REPEAT intCont+=1;
                Ventana.UPDATE(1, ROUND(intCont / intTotal * 10000, 1));
                Ventana.UPDATE(2, intCont);
                BOMComponent.RESET;
                BOMComponent.SETRANGE(BOMComponent."Parent Item No.", PostedAssemblyHeader."Item No.");
                IF BOMComponent.FINDFIRST THEN REPEAT PostedAssemblyLine.RESET;
                        PostedAssemblyLine.SETRANGE(PostedAssemblyLine."Document No.", PostedAssemblyHeader."No.");
                        PostedAssemblyLine.SETRANGE(PostedAssemblyLine.Type, BOMComponent.Type);
                        PostedAssemblyLine.SETRANGE(PostedAssemblyLine."No.", BOMComponent."No.");
                        PostedAssemblyLine.SETRANGE(PostedAssemblyLine."Unit of Measure Code", BOMComponent."Unit of Measure Code");
                        PostedAssemblyLine.SETRANGE(PostedAssemblyLine."Cantidad Original", 0);
                        IF PostedAssemblyLine.FINDFIRST THEN BEGIN
                            PostedAssemblyLine."Cantidad Original":=ROUND((ROUND(BOMComponent."Quantity per", 0.00001) * ROUND(PostedAssemblyHeader.Quantity, 0.00001)), 0.00001);
                            PostedAssemblyLine."Cantidad Por Original":=ROUND(BOMComponent."Quantity per", 0.00001);
                            PostedAssemblyLine.Diferencia:=PostedAssemblyLine.Quantity - PostedAssemblyLine."Cantidad Original";
                            IF PostedAssemblyLine."Cantidad Original" <> 0 THEN PostedAssemblyLine."Diferencia%":=PostedAssemblyLine.Diferencia / PostedAssemblyLine."Cantidad Original" * 100
                            ELSE IF PostedAssemblyLine.Diferencia > 0 THEN PostedAssemblyLine."Diferencia%":=100;
                            PostedAssemblyLine.MODIFY;
                        END;
                        IF BOMComponent.Type = BOMComponent.Type::Item THEN BEGIN
                            BOMComponent2.RESET;
                            BOMComponent2.SETRANGE(BOMComponent2."Parent Item No.", BOMComponent."No.");
                            IF BOMComponent2.FINDFIRST THEN REPEAT PostedAssemblyLine.RESET;
                                    PostedAssemblyLine.SETRANGE(PostedAssemblyLine."Document No.", PostedAssemblyHeader."No.");
                                    PostedAssemblyLine.SETRANGE(PostedAssemblyLine.Type, BOMComponent2.Type);
                                    PostedAssemblyLine.SETRANGE(PostedAssemblyLine."No.", BOMComponent2."No.");
                                    PostedAssemblyLine.SETRANGE(PostedAssemblyLine."Unit of Measure Code", BOMComponent2."Unit of Measure Code");
                                    PostedAssemblyLine.SETRANGE(PostedAssemblyLine."Cantidad Original", 0);
                                    IF PostedAssemblyLine.FINDFIRST THEN BEGIN
                                        PostedAssemblyLine."Cantidad Original":=ROUND((ROUND(BOMComponent2."Quantity per", 0.00001) * ROUND(PostedAssemblyHeader.Quantity, 0.00001)), 0.00001);
                                        PostedAssemblyLine."Cantidad Por Original":=ROUND(BOMComponent2."Quantity per", 0.00001);
                                        PostedAssemblyLine.Diferencia:=PostedAssemblyLine.Quantity - PostedAssemblyLine."Cantidad Original";
                                        IF PostedAssemblyLine."Cantidad Original" <> 0 THEN PostedAssemblyLine."Diferencia%":=PostedAssemblyLine.Diferencia / PostedAssemblyLine."Cantidad Original" * 100
                                        ELSE IF PostedAssemblyLine.Diferencia > 0 THEN PostedAssemblyLine."Diferencia%":=100;
                                        PostedAssemblyLine.MODIFY;
                                    END;
                                    IF BOMComponent2.Type = BOMComponent2.Type::Item THEN BEGIN
                                        BOMComponent3.RESET;
                                        BOMComponent3.SETRANGE(BOMComponent3."Parent Item No.", BOMComponent2."No.");
                                        IF BOMComponent3.FINDFIRST THEN REPEAT PostedAssemblyLine.RESET;
                                                PostedAssemblyLine.SETRANGE(PostedAssemblyLine."Document No.", PostedAssemblyHeader."No.");
                                                PostedAssemblyLine.SETRANGE(PostedAssemblyLine.Type, BOMComponent3.Type);
                                                PostedAssemblyLine.SETRANGE(PostedAssemblyLine."No.", BOMComponent3."No.");
                                                PostedAssemblyLine.SETRANGE(PostedAssemblyLine."Unit of Measure Code", BOMComponent3."Unit of Measure Code");
                                                PostedAssemblyLine.SETRANGE(PostedAssemblyLine."Cantidad Original", 0);
                                                IF PostedAssemblyLine.FINDFIRST THEN BEGIN
                                                    PostedAssemblyLine."Cantidad Original":=ROUND((ROUND(BOMComponent3."Quantity per", 0.00001) * ROUND(PostedAssemblyHeader.Quantity, 0.00001)), 0.00001);
                                                    PostedAssemblyLine."Cantidad Por Original":=ROUND(BOMComponent3."Quantity per", 0.00001);
                                                    PostedAssemblyLine.Diferencia:=PostedAssemblyLine.Quantity - PostedAssemblyLine."Cantidad Original";
                                                    IF PostedAssemblyLine."Cantidad Original" <> 0 THEN PostedAssemblyLine."Diferencia%":=PostedAssemblyLine.Diferencia / PostedAssemblyLine."Cantidad Original" * 100
                                                    ELSE IF PostedAssemblyLine.Diferencia > 0 THEN PostedAssemblyLine."Diferencia%":=100;
                                                    PostedAssemblyLine.MODIFY;
                                                END;
                                            UNTIL BOMComponent3.NEXT = 0;
                                    END;
                                UNTIL BOMComponent2.NEXT = 0;
                        END;
                    UNTIL BOMComponent.NEXT = 0;
                /*
                PostedAssemblyLine.RESET;
                PostedAssemblyLine.SETRANGE(PostedAssemblyLine."Document No.", PostedAssemblyHeader."No.");
                IF PostedAssemblyLine.FINDFIRST THEN
                REPEAT
                  PostedAssemblyLine.Diferencia := PostedAssemblyLine.Quantity - PostedAssemblyLine."Cantidad Original";
                  IF PostedAssemblyLine."Cantidad Original" <> 0 THEN
                    PostedAssemblyLine."Diferencia%" := PostedAssemblyLine.Diferencia / PostedAssemblyLine."Cantidad Original" * 100
                  ELSE IF PostedAssemblyLine.Diferencia > 0 THEN
                    PostedAssemblyLine."Diferencia%" := 100;
                  PostedAssemblyLine.MODIFY;
                UNTIL PostedAssemblyLine.NEXT = 0;
                */
                IF PostedAssemblyHeader."Cantidad Original" <> 0 THEN BEGIN
                    PostedAssemblyHeader."Cantidad Original":=PostedAssemblyHeader.Quantity;
                    PostedAssemblyHeader.MODIFY;
                END;
            UNTIL PostedAssemblyHeader.NEXT = 0;
            Ventana.CLOSE;
        END;
    end;
    local procedure RellenarPedidoEnsamblado()
    var
        PostedAssemblyHeader: Record 900;
        PostedAssemblyLine: Record 901;
        BOMComponent: Record 90;
        BOMComponent2: Record 90;
        BOMComponent3: Record 90;
        Ventana: Dialog;
        intCont: Integer;
        intTotal: Integer;
    begin
        /*
        PostedAssemblyLine.MODIFYALL(PostedAssemblyLine."Cantidad Original", 0);
        PostedAssemblyLine.MODIFYALL(PostedAssemblyLine."Cantidad Por Original", 0);
        PostedAssemblyLine.MODIFYALL(PostedAssemblyLine.Diferencia, 0);
        PostedAssemblyLine.MODIFYALL(PostedAssemblyLine."Diferencia%", 0);
        */
        PostedAssemblyHeader.RESET;
        IF PostedAssemblyHeader.FINDFIRST THEN BEGIN
            intTotal:=PostedAssemblyHeader.COUNT;
            intCont:=0;
            Ventana.OPEN('Procesando @1@@@@@@@ #2##### de #3#####');
            Ventana.UPDATE(3, intTotal);
            REPEAT intCont+=1;
                Ventana.UPDATE(1, ROUND(intCont / intTotal * 10000, 1));
                Ventana.UPDATE(2, intCont);
                BOMComponent.RESET;
                BOMComponent.SETRANGE(BOMComponent."Parent Item No.", PostedAssemblyHeader."Item No.");
                IF BOMComponent.FINDFIRST THEN REPEAT PostedAssemblyLine.RESET;
                        PostedAssemblyLine.SETRANGE(PostedAssemblyLine."Document No.", PostedAssemblyHeader."No.");
                        PostedAssemblyLine.SETRANGE(PostedAssemblyLine.Type, BOMComponent.Type);
                        PostedAssemblyLine.SETRANGE(PostedAssemblyLine."No.", BOMComponent."No.");
                        PostedAssemblyLine.SETRANGE(PostedAssemblyLine."Unit of Measure Code", BOMComponent."Unit of Measure Code");
                        PostedAssemblyLine.SETRANGE(PostedAssemblyLine."Cantidad Original", 0);
                        IF PostedAssemblyLine.FINDFIRST THEN BEGIN
                            PostedAssemblyLine."Cantidad Original":=ROUND((ROUND(BOMComponent."Quantity per", 0.00001) * ROUND(PostedAssemblyHeader.Quantity, 0.00001)), 0.00001);
                            PostedAssemblyLine."Cantidad Por Original":=ROUND(BOMComponent."Quantity per", 0.00001);
                            PostedAssemblyLine.Diferencia:=PostedAssemblyLine.Quantity - PostedAssemblyLine."Cantidad Original";
                            IF PostedAssemblyLine."Cantidad Original" <> 0 THEN PostedAssemblyLine."Diferencia%":=PostedAssemblyLine.Diferencia / PostedAssemblyLine."Cantidad Original" * 100
                            ELSE IF PostedAssemblyLine.Diferencia > 0 THEN PostedAssemblyLine."Diferencia%":=100;
                            PostedAssemblyLine.MODIFY;
                        END;
                        IF BOMComponent.Type = BOMComponent.Type::Item THEN BEGIN
                            BOMComponent2.RESET;
                            BOMComponent2.SETRANGE(BOMComponent2."Parent Item No.", BOMComponent."No.");
                            IF BOMComponent2.FINDFIRST THEN REPEAT PostedAssemblyLine.RESET;
                                    PostedAssemblyLine.SETRANGE(PostedAssemblyLine."Document No.", PostedAssemblyHeader."No.");
                                    PostedAssemblyLine.SETRANGE(PostedAssemblyLine.Type, BOMComponent2.Type);
                                    PostedAssemblyLine.SETRANGE(PostedAssemblyLine."No.", BOMComponent2."No.");
                                    PostedAssemblyLine.SETRANGE(PostedAssemblyLine."Unit of Measure Code", BOMComponent2."Unit of Measure Code");
                                    PostedAssemblyLine.SETRANGE(PostedAssemblyLine."Cantidad Original", 0);
                                    IF PostedAssemblyLine.FINDFIRST THEN BEGIN
                                        PostedAssemblyLine."Cantidad Original":=ROUND((ROUND(BOMComponent2."Quantity per", 0.00001) * ROUND(PostedAssemblyHeader.Quantity, 0.00001)), 0.00001);
                                        PostedAssemblyLine."Cantidad Por Original":=ROUND(BOMComponent2."Quantity per", 0.00001);
                                        PostedAssemblyLine.Diferencia:=PostedAssemblyLine.Quantity - PostedAssemblyLine."Cantidad Original";
                                        IF PostedAssemblyLine."Cantidad Original" <> 0 THEN PostedAssemblyLine."Diferencia%":=PostedAssemblyLine.Diferencia / PostedAssemblyLine."Cantidad Original" * 100
                                        ELSE IF PostedAssemblyLine.Diferencia > 0 THEN PostedAssemblyLine."Diferencia%":=100;
                                        PostedAssemblyLine.MODIFY;
                                    END;
                                    IF BOMComponent2.Type = BOMComponent2.Type::Item THEN BEGIN
                                        BOMComponent3.RESET;
                                        BOMComponent3.SETRANGE(BOMComponent3."Parent Item No.", BOMComponent2."No.");
                                        IF BOMComponent3.FINDFIRST THEN REPEAT PostedAssemblyLine.RESET;
                                                PostedAssemblyLine.SETRANGE(PostedAssemblyLine."Document No.", PostedAssemblyHeader."No.");
                                                PostedAssemblyLine.SETRANGE(PostedAssemblyLine.Type, BOMComponent3.Type);
                                                PostedAssemblyLine.SETRANGE(PostedAssemblyLine."No.", BOMComponent3."No.");
                                                PostedAssemblyLine.SETRANGE(PostedAssemblyLine."Unit of Measure Code", BOMComponent3."Unit of Measure Code");
                                                PostedAssemblyLine.SETRANGE(PostedAssemblyLine."Cantidad Original", 0);
                                                IF PostedAssemblyLine.FINDFIRST THEN BEGIN
                                                    PostedAssemblyLine."Cantidad Original":=ROUND((ROUND(BOMComponent3."Quantity per", 0.00001) * ROUND(PostedAssemblyHeader.Quantity, 0.00001)), 0.00001);
                                                    PostedAssemblyLine."Cantidad Por Original":=ROUND(BOMComponent3."Quantity per", 0.00001);
                                                    PostedAssemblyLine.Diferencia:=PostedAssemblyLine.Quantity - PostedAssemblyLine."Cantidad Original";
                                                    IF PostedAssemblyLine."Cantidad Original" <> 0 THEN PostedAssemblyLine."Diferencia%":=PostedAssemblyLine.Diferencia / PostedAssemblyLine."Cantidad Original" * 100
                                                    ELSE IF PostedAssemblyLine.Diferencia > 0 THEN PostedAssemblyLine."Diferencia%":=100;
                                                    PostedAssemblyLine.MODIFY;
                                                END;
                                            UNTIL BOMComponent3.NEXT = 0;
                                    END;
                                UNTIL BOMComponent2.NEXT = 0;
                        END;
                    UNTIL BOMComponent.NEXT = 0;
                /*
                PostedAssemblyLine.RESET;
                PostedAssemblyLine.SETRANGE(PostedAssemblyLine."Document No.", PostedAssemblyHeader."No.");
                IF PostedAssemblyLine.FINDFIRST THEN
                REPEAT
                  PostedAssemblyLine.Diferencia := PostedAssemblyLine.Quantity - PostedAssemblyLine."Cantidad Original";
                  IF PostedAssemblyLine."Cantidad Original" <> 0 THEN
                    PostedAssemblyLine."Diferencia%" := PostedAssemblyLine.Diferencia / PostedAssemblyLine."Cantidad Original" * 100
                  ELSE IF PostedAssemblyLine.Diferencia > 0 THEN
                    PostedAssemblyLine."Diferencia%" := 100;
                  PostedAssemblyLine.MODIFY;
                UNTIL PostedAssemblyLine.NEXT = 0;
                */
                IF PostedAssemblyHeader."Cantidad Original" <> 0 THEN BEGIN
                    PostedAssemblyHeader."Cantidad Original":=PostedAssemblyHeader.Quantity;
                    PostedAssemblyHeader.MODIFY;
                END;
            UNTIL PostedAssemblyHeader.NEXT = 0;
            Ventana.CLOSE;
        END;
    end;
    local procedure CertificarLM()
    var
        Item: Record 27;
    begin
        Item.RESET;
        Item.MODIFYALL("Status LM", Item."Status LM"::Certificated);
    end;
    local procedure RellenarNomRecursoWorkCenterLine()
    var
        WorkCenterLine: Record 50023;
    begin
        WorkCenterLine.RESET;
        IF WorkCenterLine.FINDFIRST THEN REPEAT WorkCenterLine.VALIDATE("No.");
                WorkCenterLine.MODIFY(TRUE);
            UNTIL WorkCenterLine.NEXT = 0;
    end;
    local procedure "RellenarNosSerieFichaArtículo"()
    var
        Item: Record 27;
    begin
        Item.RESET;
        Item.SETRANGE(Item."No. Series", '');
        IF Item.FINDFIRST THEN REPEAT IF Item."No." <> '' THEN BEGIN
                    CASE COPYSTR(Item."No.", 1, 2)OF 'CA': Item."No. Series":='M_CA';
                    'CI': Item."No. Series":='M_CI';
                    'DI': Item."No. Series":='M_DI';
                    'MA': Item."No. Series":='M_MA';
                    'MP': Item."No. Series":='M_MP';
                    'PI': Item."No. Series":='M_PI';
                    'PT': Item."No. Series":='M_PT';
                    END;
                    IF Item."No. Series" <> '' THEN Item.MODIFY;
                END;
            UNTIL Item.NEXT = 0;
    end;
}
