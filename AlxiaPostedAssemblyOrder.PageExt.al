pageextension 50019 AlxiaPostedAssemblyOrder extends "Posted Assembly Order"
{
    layout
    {
        addafter(Description)
        {
            field(NoEvento; Rec.NoEvento)
            {
                ApplicationArea = All;
            }
            field(AGRALAFechaProduccion; Rec.AGRALAFechaProduccion)
            {
                ApplicationArea = All;
            }
        }
        addafter(Reversed)
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
        }
        addafter(Control22)
        {
            part("Seg. receta niveles registrada";50081)
            {
                ApplicationArea = All;
                Caption = 'Seg. receta niveles registrada';
                SubPageLink = AGRALARecetaMadre=FIELD("Associated First Order No.");
            }
            part("Seg. receta madre registrada";50081)
            {
                ApplicationArea = All;
                Caption = 'Seg. receta madre registrada';
                SubPageLink = AGRALARecetaMadre=FIELD("Order No.");
            }
        }
    }
    actions
    {
        addafter("Undo Post")
        {
            action(AGRALAInfoCalidadCabecera)
            {
                ApplicationArea = All;
                Caption = 'Info Calidad';
                Image = QualificationOverview;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

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
            action("_ACT")
            {
                Caption = '_ACT';
                Image = UpdateXML;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = _devAction;

                trigger OnAction()
                begin
                    ActualizarPedido();
                end;
            }
        }
    }
    var _devAction: Boolean;
    trigger OnOpenPage()
    begin
        if UserId = 'BC' then _devAction:=true;
    end;
    procedure ActualizarPedido()
    var
        rHeader: Record "Posted Assembly Header";
        rLine: Record "Posted Assembly Line";
    begin
        rLine.Reset();
        rLine.SetRange("Document No.", 'PT24/0004001');
        if rLine.FindFirst()then rLine.ModifyAll("Order No.", 'P24/00006562');
        rHeader.Reset();
        rHeader.SetRange("No.", 'PT24/0004001');
        if rHeader.FindFirst()then begin
            rHeader.AGRALARecetaMadre:='P24/00006562';
            rHeader."Order No.":='P24/00006562';
            rHeader.Modify();
        end;
        Clear(rHeader);
        rHeader.Reset();
        rHeader.SetRange("No.", 'PT24/0004000');
        if rHeader.FindFirst()then begin
            rHeader.AGRALARecetaMadre:='P24/00006562';
            rHeader."Associated Order No.":='P24/00006562';
            rHeader."Associated First Order No.":='P24/00006562';
            rHeader.Modify();
        end;
    end;
}
