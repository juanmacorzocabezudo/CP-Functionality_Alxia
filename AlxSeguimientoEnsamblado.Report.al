report 50024 AlxSeguimientoEnsamblado
{
    Permissions = TableData 910=rimd,
        TableData 911=rimd;
    ProcessingOnly = true;
    ShowPrintStatus = false;
    UseRequestPage = false;
    Caption = 'Actualizar Seguimiento Ensamblado';
    UsageCategory = History;
    ApplicationArea = All;

    dataset
    {
        dataitem("Assembly Header";900)
        {
            trigger OnAfterGetRecord()
            begin
                Header();
            end;
        }
        dataitem("Posted Assembly Header";910)
        {
            trigger OnAfterGetRecord()
            begin
            // Posted();
            end;
        }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    labels
    {
    }
    procedure Header()
    var
        xlrecetamadre: Boolean;
        xlNivel: Text;
        xlPedidoEnsNivel: Code[50];
        rlAssemblyHeaderMADRE: Record 900;
        rlAssemblyLine01: Record 901;
        rlAssemblyLine02: Record 901;
        rlAssemblyLine03: Record 901;
        rlAssemblyLine04: Record 901;
        rlAssemblyLine05: Record 901;
        rlAssemblyHeader01: Record 900;
        rlAssemblyHeader02: Record 900;
        rlAssemblyHeader03: Record 900;
        rlAssemblyHeader04: Record 900;
        rlAssemblyHeader05: Record 900;
        rlAssemblyLine: Record 901;
        xlCentroCoste: Text[250];
        i: Integer;
    begin
        //++ AGRALAMO 22003
        CLEAR(rlAssemblyLine);
        rlAssemblyLine.SETRANGE("Document Type", "Assembly Header"."Document Type");
        rlAssemblyLine.SETRANGE("Document No.", "Assembly Header"."No.");
        rlAssemblyLine.SetFilter("No.", '<>P24/00004810');
        IF rlAssemblyLine.FINDSET THEN REPEAT IF(rlAssemblyLine.Type = rlAssemblyLine.Type::" ") AND (rlAssemblyLine."No." = '')THEN BEGIN
                    xlCentroCoste:=rlAssemblyLine.Description;
                END;
                IF(xlCentroCoste <> '') AND NOT(rlAssemblyLine.Type = rlAssemblyLine.Type::" ")THEN BEGIN
                    rlAssemblyLine.AGRALACentroCoste:=xlCentroCoste;
                END;
                rlAssemblyLine.MODIFY;
            UNTIL rlAssemblyLine.NEXT = 0;
        //-- AGRALAMO 22003
        //++ AGRALAMO 22003
        CLEAR(xlPedidoEnsNivel);
        xlPedidoEnsNivel:="Assembly Header"."No.";
        Clear(i);
        REPEAT CLEAR(rlAssemblyHeaderMADRE);
            //IF xlPedidoEnsNivel <> '' THEN BEGIN
            IF NOT rlAssemblyHeaderMADRE.GET("Assembly Header"."Document Type", xlPedidoEnsNivel)THEN EXIT;
            //ERROR('Pedido de nivel superior o receta madre borrado, por lo que no es posible calcular seguimiento');
            IF NOT rlAssemblyHeaderMADRE."Associated Order" THEN BEGIN
                xlNivel:='00-Receta madre';
                xlrecetamadre:=TRUE;
                rlAssemblyHeaderMADRE.AGRALANivel:=xlNivel;
                rlAssemblyHeaderMADRE.AGRALARecetaMadre:=rlAssemblyHeaderMADRE."No.";
                rlAssemblyHeaderMADRE.MODIFY();
                COMMIT;
            END
            ELSE
            BEGIN
                xlPedidoEnsNivel:="Assembly Header"."Associated First Order No.";
            END;
            i:=i + 1;
        //END;
        UNTIL(xlrecetamadre = TRUE) or (i >= 5);
        CLEAR(rlAssemblyLine01);
        rlAssemblyLine01.SETRANGE(Type, rlAssemblyLine01.Type::Item);
        rlAssemblyLine01.SETRANGE("Document Type", rlAssemblyHeaderMADRE."Document Type");
        rlAssemblyLine01.SETRANGE("Document No.", xlPedidoEnsNivel);
        IF rlAssemblyLine01.FINDSET THEN REPEAT xlNivel:='01-Nivel';
                CLEAR(rlAssemblyHeader01);
                rlAssemblyHeader01.SETRANGE("Document Type", rlAssemblyLine01."Document Type");
                rlAssemblyHeader01.SETRANGE("Associated Order No.", rlAssemblyLine01."Document No.");
                rlAssemblyHeader01.SETRANGE("Associated Order Line", rlAssemblyLine01."Line No.");
                IF rlAssemblyHeader01.FINDFIRST THEN BEGIN
                    rlAssemblyHeader01.AGRALANivel:=xlNivel;
                    rlAssemblyHeader01.AGRALARecetaMadre:=rlAssemblyHeaderMADRE."No.";
                    rlAssemblyHeader01.MODIFY;
                    COMMIT;
                    CLEAR(rlAssemblyLine02);
                    rlAssemblyLine02.SETRANGE(Type, rlAssemblyLine01.Type::Item);
                    rlAssemblyLine02.SETRANGE("Document Type", rlAssemblyHeader01."Document Type");
                    rlAssemblyLine02.SETRANGE("Document No.", rlAssemblyHeader01."No.");
                    IF rlAssemblyLine02.FINDSET THEN REPEAT xlNivel:='02-Nivel';
                            CLEAR(rlAssemblyHeader02);
                            rlAssemblyHeader02.SETRANGE("Document Type", rlAssemblyLine02."Document Type");
                            rlAssemblyHeader02.SETRANGE("Associated Order No.", rlAssemblyLine02."Document No.");
                            rlAssemblyHeader02.SETRANGE("Associated Order Line", rlAssemblyLine02."Line No.");
                            IF rlAssemblyHeader02.FINDFIRST THEN BEGIN
                                rlAssemblyHeader02.AGRALANivel:=xlNivel;
                                rlAssemblyHeader02.AGRALARecetaMadre:=rlAssemblyHeaderMADRE."No.";
                                rlAssemblyHeader02.MODIFY;
                                COMMIT;
                                CLEAR(rlAssemblyLine03);
                                rlAssemblyLine03.SETRANGE(Type, rlAssemblyLine02.Type::Item);
                                rlAssemblyLine03.SETRANGE("Document Type", rlAssemblyHeader02."Document Type");
                                rlAssemblyLine03.SETRANGE("Document No.", rlAssemblyHeader02."No.");
                                IF rlAssemblyLine03.FINDSET THEN REPEAT xlNivel:='03-Nivel';
                                        CLEAR(rlAssemblyHeader03);
                                        rlAssemblyHeader03.SETRANGE("Document Type", rlAssemblyLine03."Document Type");
                                        rlAssemblyHeader03.SETRANGE("Associated Order No.", rlAssemblyLine03."Document No.");
                                        rlAssemblyHeader03.SETRANGE("Associated Order Line", rlAssemblyLine03."Line No.");
                                        IF rlAssemblyHeader03.FINDFIRST THEN BEGIN
                                            rlAssemblyHeader03.AGRALANivel:=xlNivel;
                                            rlAssemblyHeader03.AGRALARecetaMadre:=rlAssemblyHeaderMADRE."No.";
                                            rlAssemblyHeader03.MODIFY;
                                            COMMIT;
                                            CLEAR(rlAssemblyLine04);
                                            rlAssemblyLine04.SETRANGE(Type, rlAssemblyLine03.Type::Item);
                                            rlAssemblyLine04.SETRANGE("Document Type", rlAssemblyHeader03."Document Type");
                                            rlAssemblyLine04.SETRANGE("Document No.", rlAssemblyHeader03."No.");
                                            IF rlAssemblyLine04.FINDSET THEN REPEAT xlNivel:='04-Nivel';
                                                    CLEAR(rlAssemblyHeader04);
                                                    rlAssemblyHeader04.SETRANGE("Document Type", rlAssemblyLine04."Document Type");
                                                    rlAssemblyHeader04.SETRANGE("Associated Order No.", rlAssemblyLine04."Document No.");
                                                    rlAssemblyHeader04.SETRANGE("Associated Order Line", rlAssemblyLine04."Line No.");
                                                    IF rlAssemblyHeader04.FINDFIRST THEN BEGIN
                                                        rlAssemblyHeader04.AGRALANivel:=xlNivel;
                                                        rlAssemblyHeader04.AGRALARecetaMadre:=rlAssemblyHeaderMADRE."No.";
                                                        rlAssemblyHeader04.MODIFY;
                                                        COMMIT;
                                                        CLEAR(rlAssemblyLine05);
                                                        rlAssemblyLine05.SETRANGE(Type, rlAssemblyLine04.Type::Item);
                                                        rlAssemblyLine05.SETRANGE("Document Type", rlAssemblyHeader04."Document Type");
                                                        rlAssemblyLine05.SETRANGE("Document No.", rlAssemblyHeader04."No.");
                                                        IF rlAssemblyLine05.FINDSET THEN REPEAT xlNivel:='05-Nivel';
                                                                CLEAR(rlAssemblyHeader05);
                                                                rlAssemblyHeader05.SETRANGE("Document Type", rlAssemblyLine05."Document Type");
                                                                rlAssemblyHeader05.SETRANGE("Associated Order No.", rlAssemblyLine05."Document No.");
                                                                rlAssemblyHeader05.SETRANGE("Associated Order Line", rlAssemblyLine05."Line No.");
                                                                IF rlAssemblyHeader05.FINDFIRST THEN BEGIN
                                                                    rlAssemblyHeader05.AGRALANivel:=xlNivel;
                                                                    rlAssemblyHeader05.AGRALARecetaMadre:=rlAssemblyHeaderMADRE."No.";
                                                                    rlAssemblyHeader05.MODIFY;
                                                                    COMMIT;
                                                                END;
                                                            UNTIL rlAssemblyLine05.NEXT = 0;
                                                    END;
                                                UNTIL rlAssemblyLine04.NEXT = 0;
                                        END;
                                    UNTIL rlAssemblyLine03.NEXT = 0;
                            END;
                        UNTIL rlAssemblyLine02.NEXT = 0;
                END;
            UNTIL rlAssemblyLine01.NEXT = 0;
        COMMIT;
        EXIT;
    //-- AGRALAMO 22003
    end;
    procedure Posted()
    var
        xlrecetamadre: Boolean;
        xlNivel: Text;
        xlPedidoEnsNivel: Code[50];
        rlAssemblyHeaderMADRE: Record 910;
        rlAssemblyLine01: Record 911;
        rlAssemblyLine02: Record 911;
        rlAssemblyLine03: Record 911;
        rlAssemblyLine04: Record 911;
        rlAssemblyLine05: Record 911;
        rlAssemblyHeader01: Record 910;
        rlAssemblyHeader02: Record 910;
        rlAssemblyHeader03: Record 910;
        rlAssemblyHeader04: Record 910;
        rlAssemblyHeader05: Record 910;
        rlAssemblyLine: Record 911;
        xlCentroCoste: Text[250];
    begin
        ////++ AGRALAMO 22003
        CLEAR(rlAssemblyLine);
        ////rlAssemblyLine.SETRANGE("Document Type", "Posted Assembly Header"."Document Type");
        rlAssemblyLine.SETRANGE("Document No.", "Posted Assembly Header"."No.");
        IF rlAssemblyLine.FINDSET THEN REPEAT IF(rlAssemblyLine.Type = rlAssemblyLine.Type::" ") AND (rlAssemblyLine."No." = '')THEN BEGIN
                    xlCentroCoste:=rlAssemblyLine.Description;
                END;
                IF(xlCentroCoste <> '') AND NOT(rlAssemblyLine.Type = rlAssemblyLine.Type::" ")THEN BEGIN
                    rlAssemblyLine.AGRALACentroCoste:=xlCentroCoste;
                END;
                rlAssemblyLine.MODIFY;
            UNTIL rlAssemblyLine.NEXT = 0;
        ////-- AGRALAMO 22003
        //
        ////++ AGRALAMO 22003
        CLEAR(xlPedidoEnsNivel);
        xlPedidoEnsNivel:="Posted Assembly Header"."No.";
        REPEAT CLEAR(rlAssemblyHeaderMADRE);
            //IF xlPedidoEnsNivel <> '' THEN BEGIN
            IF NOT rlAssemblyHeaderMADRE.GET(xlPedidoEnsNivel)THEN EXIT;
            //ERROR('Pedido de nivel superior o receta madre borrado, por lo que no es posible calcular seguimiento');
            IF NOT rlAssemblyHeaderMADRE."Associated Order" THEN BEGIN
                xlNivel:='00-Receta madre';
                xlrecetamadre:=TRUE;
                rlAssemblyHeaderMADRE.AGRALANivel:=xlNivel;
                rlAssemblyHeaderMADRE.AGRALARecetaMadre:=rlAssemblyHeaderMADRE."No.";
                rlAssemblyHeaderMADRE.MODIFY();
                COMMIT;
            END
            ELSE
            BEGIN
                xlPedidoEnsNivel:="Posted Assembly Header"."Associated First Order No.";
            END;
        //END;
        UNTIL xlrecetamadre = TRUE;
        CLEAR(rlAssemblyLine01);
        rlAssemblyLine01.SETRANGE(Type, rlAssemblyLine01.Type::Item);
        ////rlAssemblyLine01.SETRANGE(rlAssemblyHeaderMADRE."Document Type");
        rlAssemblyLine01.SETRANGE("Document No.", xlPedidoEnsNivel);
        IF rlAssemblyLine01.FINDSET THEN REPEAT xlNivel:='01-Nivel';
                //
                CLEAR(rlAssemblyHeader01);
                //rlAssemblyHeader01.SETRANGE("Document Type", rlAssemblyLine01."Document Type");
                rlAssemblyHeader01.SETRANGE("Associated Order No.", rlAssemblyLine01."Order No.");
                rlAssemblyHeader01.SETRANGE("Associated Order Line", rlAssemblyLine01."Line No.");
                IF rlAssemblyHeader01.FINDFIRST THEN BEGIN
                    rlAssemblyHeader01.AGRALANivel:=xlNivel;
                    rlAssemblyHeader01.AGRALARecetaMadre:=rlAssemblyHeaderMADRE."No.";
                    rlAssemblyHeader01.MODIFY;
                    COMMIT;
                    //
                    CLEAR(rlAssemblyLine02);
                    rlAssemblyLine02.SETRANGE(Type, rlAssemblyLine01.Type::Item);
                    //      //rlAssemblyLine02.SETRANGE(rlAssemblyHeader01."Document Type");
                    rlAssemblyLine02.SETRANGE("Document No.", rlAssemblyHeader01."Order No.");
                    IF rlAssemblyLine02.FINDSET THEN REPEAT xlNivel:='02-Nivel';
                            CLEAR(rlAssemblyHeader02);
                            //        //rlAssemblyHeader02.SETRANGE( rlAssemblyLine02."Document Type");
                            rlAssemblyHeader02.SETRANGE("Associated Order No.", rlAssemblyLine02."Order No.");
                            rlAssemblyHeader02.SETRANGE("Associated Order Line", rlAssemblyLine02."Line No.");
                            IF rlAssemblyHeader02.FINDFIRST THEN BEGIN
                                rlAssemblyHeader02.AGRALANivel:=xlNivel;
                                rlAssemblyHeader02.AGRALARecetaMadre:=rlAssemblyHeaderMADRE."No.";
                                rlAssemblyHeader02.MODIFY;
                                COMMIT;
                                CLEAR(rlAssemblyLine03);
                                rlAssemblyLine03.SETRANGE(Type, rlAssemblyLine02.Type::Item);
                                //rlAssemblyLine03.SETRANGE("Document Type",  rlAssemblyHeader02."Document Type");
                                rlAssemblyLine03.SETRANGE("Document No.", rlAssemblyHeader02."Order No.");
                                IF rlAssemblyLine03.FINDSET THEN REPEAT xlNivel:='03-Nivel';
                                        CLEAR(rlAssemblyHeader03);
                                        //rlAssemblyHeader03.SETRANGE("Document Type", rlAssemblyLine03."Document Type");
                                        rlAssemblyHeader03.SETRANGE("Associated Order No.", rlAssemblyLine03."Order No.");
                                        rlAssemblyHeader03.SETRANGE("Associated Order Line", rlAssemblyLine03."Line No.");
                                        IF rlAssemblyHeader03.FINDFIRST THEN BEGIN
                                            rlAssemblyHeader03.AGRALANivel:=xlNivel;
                                            rlAssemblyHeader03.AGRALARecetaMadre:=rlAssemblyHeaderMADRE."No.";
                                            rlAssemblyHeader03.MODIFY;
                                            COMMIT;
                                            //
                                            CLEAR(rlAssemblyLine04);
                                            rlAssemblyLine04.SETRANGE(Type, rlAssemblyLine03.Type::Item);
                                            //rlAssemblyLine04.SETRANGE("Document Type",rlAssemblyHeader03."Document Type");
                                            rlAssemblyLine04.SETRANGE("Document No.", rlAssemblyHeader03."Order No.");
                                            IF rlAssemblyLine04.FINDSET THEN REPEAT xlNivel:='04-Nivel';
                                                    CLEAR(rlAssemblyHeader04);
                                                    //rlAssemblyHeader04.SETRANGE("Document Type", rlAssemblyLine04."Document Type");
                                                    rlAssemblyHeader04.SETRANGE("Associated Order No.", rlAssemblyLine04."Order No.");
                                                    rlAssemblyHeader04.SETRANGE("Associated Order Line", rlAssemblyLine04."Line No.");
                                                    IF rlAssemblyHeader04.FINDFIRST THEN BEGIN
                                                        rlAssemblyHeader04.AGRALANivel:=xlNivel;
                                                        rlAssemblyHeader04.AGRALARecetaMadre:=rlAssemblyHeaderMADRE."No.";
                                                        rlAssemblyHeader04.MODIFY;
                                                        COMMIT;
                                                        //
                                                        CLEAR(rlAssemblyLine05);
                                                        rlAssemblyLine05.SETRANGE(Type, rlAssemblyLine04.Type::Item);
                                                        //rlAssemblyLine05.SETRANGE("Document Type", rlAssemblyHeader04."Document Type");
                                                        rlAssemblyLine05.SETRANGE("Document No.", rlAssemblyHeader04."Order No.");
                                                        IF rlAssemblyLine05.FINDSET THEN REPEAT xlNivel:='05-Nivel';
                                                                CLEAR(rlAssemblyHeader05);
                                                                //rlAssemblyHeader05.SETRANGE("Document Type", rlAssemblyLine05."Document Type");
                                                                rlAssemblyHeader05.SETRANGE("Associated Order No.", rlAssemblyLine05."Order No.");
                                                                rlAssemblyHeader05.SETRANGE("Associated Order Line", rlAssemblyLine05."Line No.");
                                                                IF rlAssemblyHeader05.FINDFIRST THEN BEGIN
                                                                    rlAssemblyHeader05.AGRALANivel:=xlNivel;
                                                                    rlAssemblyHeader05.AGRALARecetaMadre:=rlAssemblyHeaderMADRE."No.";
                                                                    rlAssemblyHeader05.MODIFY;
                                                                    COMMIT;
                                                                END;
                                                            //
                                                            UNTIL rlAssemblyLine05.NEXT = 0;
                                                    END;
                                                UNTIL rlAssemblyLine04.NEXT = 0;
                                        END;
                                    UNTIL rlAssemblyLine03.NEXT = 0;
                            END;
                        UNTIL rlAssemblyLine02.NEXT = 0;
                END;
            //
            UNTIL rlAssemblyLine01.NEXT = 0;
        COMMIT;
        EXIT;
    ////-- AGRALAMO 22003
    end;
    trigger OnInitReport()
    begin
    //culAGRALAActualizaRecetas.RUN;
    end;
    var culAGRALAActualizaRecetas: Codeunit 50011;
}
