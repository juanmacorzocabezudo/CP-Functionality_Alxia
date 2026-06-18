page 50078 "Recalculo de lote Wizard"
{
    PageType = NavigatePage;
    SourceTable = Item;

    layout
    {
        area(content)
        {
            group(StandardBanner)
            {
                Caption = 'Baner';
            }
            group(FinishedBanner)
            {
                Caption = 'Finalizar';
            }
            group(Step1)
            {
                Caption = 'Paso 1 Bienvenido al del recalculo de lotes';

                group(Welcome)
                {
                    Caption = 'Bienvenido';
                    InstructionalText = 'Para continuar debe seleccionar la cantidad del lote que con la que desea recalcular recuerde (Cantidad por Lote / Lote receta) x Cantidad Lote recalculado';
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Nº';
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Descripción';
                    Editable = false;
                }
                field("Lote Receta"; Rec."Lote Receta")
                {
                    ApplicationArea = All;
                    Caption = 'Lote receta';
                    Editable = false;
                }
                field(xlLoteParaRecalcular; xlLoteParaRecalcular)
                {
                    ApplicationArea = All;
                    Caption = 'Lote para recalculo';
                }
            }
            group(Step2)
            {
                Caption = 'Paso 2 del recalculo de lotes';
                InstructionalText = 'Si desea realizar el recalculo a todos los niveles por favor marque el campo';

                field(xlNiveles; xlNiveles)
                {
                    ApplicationArea = All;
                    Caption = 'Niveles (Si/No)';
                }
            }
            group(Step3)
            {
                Caption = 'Paso 3 del recalculo de lotes';
                InstructionalText = '¿Qué lote desea mantener? Tenga en cuenta que el recalculo se ha procesado de todos modos.';

                field(xlLoteMantener; xlLoteMantener)
                {
                    ApplicationArea = All;
                    Caption = 'Lote para mantener';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(ActionBack)
            {
                ApplicationArea = All;
                Caption = 'Anterior';
                Image = PreviousRecord;
                InFooterBar = true;
            }
            action(ActionNext)
            {
                ApplicationArea = All;
            }
            action(ActionFinish)
            {
                ApplicationArea = All;
            }
        }
    }
    trigger OnClosePage()
    var
        rlBOMComponent: Record "BOM Component";
        rlBOMComponent1: Record "BOM Component";
        rlBOMComponent2: Record "BOM Component";
        rlBOMComponent3: Record "BOM Component";
        rlBOMComponent4: Record "BOM Component";
        rlBOMComponent5: Record "BOM Component";
        xlCantidadNivel1: Decimal;
        xlCantidadNivel2: Decimal;
        xlCantidadNivel3: Decimal;
        xlCantidadNivel4: Decimal;
        xlCantidadNivel5: Decimal;
    begin
        IF CONFIRM('Si desea lanzar el proceso accepte el mensaje con "SI" si desea abortar pulse cancelar en "NO", tenga en cuenta que debe rellenar toda la información si acepta el proceso')THEN BEGIN
            IF xlLoteMantener = 0 THEN ERROR('Lote mantener sin rellenar, este campo es obligatorio');
            IF xlLoteParaRecalcular = 0 THEN ERROR('Lote para recalcular sin rellenar, este campo es obligatorio');
            rlBOMComponent.SETRANGE("Parent Item No.", Rec."No.");
            rlBOMComponent.SETRANGE(Type, rlBOMComponent.Type::Item);
            rlBOMComponent.SETFILTER("No.", '%1', 'MP' + '*');
            //rlBOMComponent.SETFILTER("No.",'%1', 'PT'+'*');
            IF rlBOMComponent.FINDSET THEN REPEAT xlCantidadNivel1:=rlBOMComponent."Cantidad por Lote";
                    rlBOMComponent.VALIDATE("Cantidad por Lote", ((rlBOMComponent."Cantidad por Lote" / Rec."Lote Receta") * xlLoteParaRecalcular));
                    rlBOMComponent.MODIFY;
                    IF xlNiveles THEN BEGIN
                        rlBOMComponent1.SETRANGE("Parent Item No.", rlBOMComponent."No.");
                        rlBOMComponent1.SETRANGE(Type, rlBOMComponent.Type::Item);
                        rlBOMComponent1.SETFILTER("No.", '%1', 'MP' + '*');
                        IF rlBOMComponent1.FINDSET THEN REPEAT xlCantidadNivel2:=rlBOMComponent1."Cantidad por Lote";
                                rlBOMComponent1.VALIDATE("Cantidad por Lote", ((xlCantidadNivel1 / rlBOMComponent1."Cantidad por Lote") * rlBOMComponent."Cantidad por Lote"));
                                rlBOMComponent1.MODIFY;
                                IF xlNiveles THEN BEGIN
                                    rlBOMComponent2.SETRANGE("Parent Item No.", rlBOMComponent1."No.");
                                    rlBOMComponent2.SETRANGE(Type, rlBOMComponent1.Type::Item);
                                    rlBOMComponent2.SETFILTER("No.", '%1', 'MP' + '*');
                                    IF rlBOMComponent2.FINDSET THEN REPEAT xlCantidadNivel3:=rlBOMComponent2."Cantidad por Lote";
                                            rlBOMComponent2.VALIDATE("Cantidad por Lote", ((xlCantidadNivel2 / rlBOMComponent2."Cantidad por Lote") * rlBOMComponent1."Cantidad por Lote"));
                                            rlBOMComponent2.MODIFY;
                                            IF xlNiveles THEN BEGIN
                                                rlBOMComponent3.SETRANGE("Parent Item No.", rlBOMComponent2."No.");
                                                rlBOMComponent3.SETRANGE(Type, rlBOMComponent2.Type::Item);
                                                rlBOMComponent3.SETFILTER("No.", '%1', 'MP' + '*');
                                                IF rlBOMComponent3.FINDSET THEN REPEAT xlCantidadNivel4:=rlBOMComponent3."Cantidad por Lote";
                                                        rlBOMComponent3.VALIDATE("Cantidad por Lote", ((xlCantidadNivel3 / rlBOMComponent3."Cantidad por Lote") * rlBOMComponent2."Cantidad por Lote"));
                                                        rlBOMComponent3.MODIFY;
                                                        IF xlNiveles THEN BEGIN
                                                            rlBOMComponent4.SETRANGE("Parent Item No.", rlBOMComponent3."No.");
                                                            rlBOMComponent4.SETRANGE(Type, rlBOMComponent3.Type::Item);
                                                            rlBOMComponent4.SETFILTER("No.", '%1', 'MP' + '*');
                                                            IF rlBOMComponent4.FINDSET THEN REPEAT xlCantidadNivel4:=rlBOMComponent4."Cantidad por Lote";
                                                                    rlBOMComponent4.VALIDATE("Cantidad por Lote", ((xlCantidadNivel4 / rlBOMComponent4."Cantidad por Lote") * rlBOMComponent3."Cantidad por Lote"));
                                                                    rlBOMComponent4.MODIFY;
                                                                    IF xlNiveles THEN BEGIN
                                                                        rlBOMComponent5.SETRANGE("Parent Item No.", rlBOMComponent4."No.");
                                                                        rlBOMComponent5.SETRANGE(Type, rlBOMComponent3.Type::Item);
                                                                        rlBOMComponent5.SETFILTER("No.", '%1', 'MP' + '*');
                                                                        IF rlBOMComponent5.FINDSET THEN REPEAT xlCantidadNivel5:=rlBOMComponent4."Cantidad por Lote";
                                                                                rlBOMComponent5.VALIDATE("Cantidad por Lote", ((xlCantidadNivel4 / rlBOMComponent5."Cantidad por Lote") * rlBOMComponent4."Cantidad por Lote"));
                                                                                rlBOMComponent5.MODIFY;
                                                                            UNTIL rlBOMComponent5.NEXT = 0;
                                                                    END;
                                                                UNTIL rlBOMComponent4.NEXT = 0;
                                                        END;
                                                    UNTIL rlBOMComponent3.NEXT = 0;
                                            END;
                                        UNTIL rlBOMComponent2.NEXT = 0;
                                END;
                            UNTIL rlBOMComponent1.NEXT = 0;
                    END;
                UNTIL rlBOMComponent.NEXT = 0;
            Rec."Lote Receta":=xlLoteMantener;
            Rec.MODIFY;
        END;
    end;
    trigger OnOpenPage()
    begin
        Step:=Step::Start;
        EnableControls();
    end;
    var xlNiveles: Boolean;
    xlLoteMantener: Decimal;
    xlLoteParaRecalcular: Decimal;
    Step1Visible: Boolean;
    Step2Visible: Boolean;
    Step3Visible: Boolean;
    Step4Visible: Boolean;
    Step: Option Start, Step2, Step3, Finish;
    BackActionEnabled: Boolean;
    FinishActionEnabled: Boolean;
    NextActionEnabled: Boolean;
    TopBannerVisible: Boolean;
    MediaRepositoryDone: Boolean;
    MediaRepositoryStandard: Boolean;
    MediaResourcesDone: Boolean;
    GlobalGuid: Guid;
    local procedure EnableControls()
    begin
        ResetControls();
        CASE Step OF Step::Start: ShowStep1();
        Step::Step2: ShowStep2();
        Step::Step3: ShowStep3();
        Step::Finish: ShowStep4();
        END;
    end;
    local procedure ResetControls()
    begin
        FinishActionEnabled:=FALSE;
        BackActionEnabled:=TRUE;
        NextActionEnabled:=TRUE;
        Step1Visible:=FALSE;
        Step2Visible:=FALSE;
        Step3Visible:=FALSE;
        Step4Visible:=FALSE;
    end;
    local procedure ShowStep4()
    begin
        Step4Visible:=TRUE;
        NextActionEnabled:=FALSE;
        FinishActionEnabled:=TRUE;
    end;
    local procedure ShowStep3()
    begin
        Step3Visible:=TRUE;
    end;
    local procedure ShowStep2()
    begin
        Step2Visible:=TRUE;
    end;
    local procedure ShowStep1()
    begin
        Step1Visible:=TRUE;
        FinishActionEnabled:=FALSE;
        BackActionEnabled:=FALSE;
    end;
    local procedure FinishAction()
    begin
        CurrPage.CLOSE();
    end;
    local procedure NextStep(Backwards: Boolean)
    begin
        IF Backwards THEN Step:=Step - 1
        ELSE
            Step:=Step + 1;
        EnableControls();
    end;
}
