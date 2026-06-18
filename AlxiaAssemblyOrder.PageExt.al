pageextension 50010 AlxiaAssemblyOrder extends "Assembly Order"
{
    layout
    {
        //modify(qua)
        addafter("Ending Date")
        {
            field(AGRALAFechaProduccion; Rec.AGRALAFechaProduccion)
            {
                ApplicationArea = All;
            }
            field(AGRALAFechaEntrega; Rec.AGRALAFechaEntrega)
            {
                ApplicationArea = All;
            }
            field(AGRALAFechaUltimaFabricación; Rec.AGRALAFechaUltimaFabricación)
            {
                ApplicationArea = All;
            }
            field(AGRALASemana; Rec.AGRALASemana)
            {
                ApplicationArea = All;
            }
            field(AGRALAParteReceta; Rec.AGRALAParteReceta)
            {
                StyleExpr = xgStyleParteReceta;
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    //++ AGRALA 863
                    CASE Rec.AGRALAParteReceta OF Rec.AGRALAParteReceta::Impresa: xgStyleParteReceta:='ambiguous';
                    Rec.AGRALAParteReceta::Cronograma: xgStyleParteReceta:='favorable';
                    END;
                //-- AGRALA 863
                end;
            }
            field(AGRALAObservaciones; Rec.AGRALAObservaciones)
            {
                ApplicationArea = All;
                MultiLine = true;
            }
            field(AGRALAObservacionesIntern; Rec.AGRALAObservacionesIntern)
            {
                ApplicationArea = All;
                MultiLine = true;
            }
        }
        addafter("Assembled Quantity")
        {
            field("Cantidad Original"; Rec."Cantidad Original")
            {
                ApplicationArea = All;
            }
            field(Diferencia; Rec.Diferencia)
            {
                ApplicationArea = All;
            }
            field("Diferencia%"; Rec."Diferencia%")
            {
                ApplicationArea = All;
            }
            field("Reserved Quantity2"; Rec."Reserved Quantity")
            {
                ApplicationArea = All;
                Editable = false;
                Visible = false;
            }
            /*     field("Assemble to Order2"; Rec."Assemble to Order")
                {
                    ApplicationArea = All;
                    Caption = 'Ensamblar para pedido';
                    trigger OnDrillDown()
                    begin
                        Rec.ShowAsmToOrder;
                    end;
                } */
            field(Autoconsumo; Rec.Autoconsumo)
            {
                ApplicationArea = All;
                Caption = 'Autoconsumo';
            }
            field(NoEvento; Rec.NoEvento)
            {
                ApplicationArea = All;
            }
            field("Location Code2"; Rec."Location Code")
            {
                ApplicationArea = All;
                Caption = 'Cod. almacén';
                Editable = IsAsmToOrderEditable;
                Importance = Promoted;
                ShowMandatory = true;

                trigger OnValidate()
                begin
                    CurrPage.SAVERECORD;
                end;
            }
        }
    }
    actions
    {
        addafter(General)
        {
            action(RECETA)
            {
                Caption = 'RECETA';
                ApplicationArea = All;
                Image = BOM;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                RunObject = Page 50000;
                RunPageLink = "No."=FIELD("Item No.");
                RunPageView = SORTING("No.")ORDER(Ascending);
            }
            action(AGRALAInfoCalidadCabecera)
            {
                ApplicationArea = All;
                Caption = 'Info Calidad';
                Image = QualificationOverview;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    rlItemVariant: Record 5401;
                    rlAssemblyLine: Record 901;
                    xlFiltros: Text;
                    pl: Page 50075;
                    rlBOMComponent: Record 90;
                    rlBOMComponent2: Record 90;
                    rlBOMComponent3: Record 90;
                    rlBOMComponent4: Record 90;
                begin
                    CLEAR(xlFiltros);
                    rlAssemblyLine.SETRANGE("Document Type", rlAssemblyLine."Document Type"::Order);
                    rlAssemblyLine.SETRANGE("Document No.", Rec."No.");
                    rlAssemblyLine.SETRANGE(Type, rlAssemblyLine.Type::Item);
                    rlAssemblyLine.FINDSET;
                    REPEAT xlFiltros+='|' + rlAssemblyLine."No.";
                        rlBOMComponent.SETRANGE("Parent Item No.", rlAssemblyLine."No.");
                        rlBOMComponent.SETRANGE(Type, rlBOMComponent.Type::Item);
                        IF rlBOMComponent.FINDSET THEN REPEAT xlFiltros+='|' + rlBOMComponent."No.";
                                CLEAR(rlBOMComponent2);
                                rlBOMComponent2.SETRANGE("Parent Item No.", rlBOMComponent."No.");
                                rlBOMComponent2.SETRANGE(Type, rlBOMComponent.Type::Item);
                                IF rlBOMComponent2.FINDSET THEN REPEAT xlFiltros+='|' + rlBOMComponent2."No.";
                                        CLEAR(rlBOMComponent3);
                                        rlBOMComponent3.SETRANGE("Parent Item No.", rlBOMComponent2."No.");
                                        rlBOMComponent3.SETRANGE(Type, rlBOMComponent.Type::Item);
                                        IF rlBOMComponent3.FINDSET THEN REPEAT xlFiltros+='|' + rlBOMComponent3."No.";
                                                CLEAR(rlBOMComponent4);
                                                rlBOMComponent4.SETRANGE("Parent Item No.", rlBOMComponent3."No.");
                                                rlBOMComponent4.SETRANGE(Type, rlBOMComponent.Type::Item);
                                                IF rlBOMComponent4.FINDSET THEN REPEAT xlFiltros+='|' + rlBOMComponent4."No.";
                                                    UNTIL rlBOMComponent4.NEXT = 0;
                                            UNTIL rlBOMComponent3.NEXT = 0;
                                    UNTIL rlBOMComponent2.NEXT = 0;
                            UNTIL rlBOMComponent.NEXT = 0;
                    UNTIL rlAssemblyLine.NEXT() = 0;
                    xlFiltros:=COPYSTR(xlFiltros, 2);
                    rlItemVariant.SETFILTER("Item No.", xlFiltros);
                    PAGE.RUN(50075, rlItemVariant);
                end;
            }
        }
        addbefore(Order)
        {
            action(OrderNuevo)
            {
                ApplicationArea = All;
                Caption = 'Imprimir Hoja Producción';
                Image = Print;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category7;

                trigger OnAction()
                var
                    DocPrint: Codeunit 229;
                begin
                    //DocPrint.PrintAsmHeader(Rec);
                    gt_cabecera.RESET;
                    CLEAR(reportensamblado);
                    CurrPage.SETSELECTIONFILTER(gt_cabecera);
                    reportensamblado.SETTABLEVIEW(gt_cabecera);
                    reportensamblado.RUNMODAL;
                end;
            }
            action(ProductionReport)
            {
                ApplicationArea = All;
                Caption = 'Parte de Producción';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category7;

                trigger OnAction()
                begin
                    //-- #9969
                    gt_cabecera.RESET;
                    CLEAR(ProductionReport);
                    CurrPage.SETSELECTIONFILTER(gt_cabecera);
                    ProductionReport.SETTABLEVIEW(gt_cabecera);
                    ProductionReport.RUNMODAL;
                //++ #9969
                end;
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        //++ AGRALA 863
        CASE Rec.AGRALAParteReceta OF Rec.AGRALAParteReceta::Impresa: xgStyleParteReceta:='ambiguous';
        Rec.AGRALAParteReceta::Cronograma: xgStyleParteReceta:='favorable';
        END;
    //-- AGRALA 863
    end;
    trigger OnAfterGetRecord()
    begin
        IsUnitCostEditable:=NOT Rec.IsStandardCostItem;
        IsAsmToOrderEditable:=NOT Rec.IsAsmToOrder;
    end;
    trigger OnOpenPage()
    var
        rlAssemblyLine: Record 901;
        xlCentroCoste: Text[250];
    begin
        Rec.SETRANGE(Simulacion, FALSE);
        IsUnitCostEditable:=TRUE;
        IsAsmToOrderEditable:=TRUE;
        rec.UpdateWarningOnLines;
        //++ AGRALAMO 22003
        rlAssemblyLine.SETRANGE("Document Type", Rec."Document Type");
        rlAssemblyLine.SETRANGE("Document No.", Rec."No.");
        IF rlAssemblyLine.FINDSET THEN REPEAT IF(rlAssemblyLine.Type = rlAssemblyLine.Type::" ") AND (rlAssemblyLine."No." = '')THEN BEGIN
                    xlCentroCoste:=rlAssemblyLine.Description;
                END;
                IF(xlCentroCoste <> '') AND NOT(rlAssemblyLine.Type = rlAssemblyLine.Type::" ")THEN BEGIN
                    rlAssemblyLine.AGRALACentroCoste:=xlCentroCoste;
                END;
                rlAssemblyLine.MODIFY;
            UNTIL rlAssemblyLine.NEXT = 0;
    //-- AGRALAMO 22003
    end;
    var ItemAvailFormsMgt: Codeunit 353;
    IsUnitCostEditable: Boolean;
    IsAsmToOrderEditable: Boolean;
    reportensamblado: Report 50017;
    ProductionReport: Report 50051;
    gt_cabecera: Record 900;
    xgStyleParteReceta: Text[50];
}
