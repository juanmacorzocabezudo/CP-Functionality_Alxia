pageextension 50023 "AlxiaReq.Worksheet" extends "Req. Worksheet"
{
    layout
    {
        modify("Variant Code")
        {
            Caption = 'Marca';
        }
        modify("Due Date")
        {
            Caption = 'Fecha producción';
        }
        addafter("Due Date")
        {
            field(AGRALANombreEvenClieEns; Rec.AGRALANombreEvenClieEns)
            {
                ApplicationArea = All;
            }
        }
        /*  addafter("No.")
         {
             field(AlxMarca; Rec.AlxMarca)
             {
                 ApplicationArea = All;
             }
         } */
        modify(Description)
        {
            Caption = 'Descripción producto';
        }
        addafter(Description)
        {
            field(AGRALATipo; Rec.AGRALATipo)
            {
                ApplicationArea = All;
                Caption = 'Nivel';
            //StyleExpr = AGRALAStyleText;
            }
        }
        addafter("Unit of Measure Code")
        {
            field(AGRALAStock; Rec.AGRALAStock)
            {
                ApplicationArea = All;
                StyleExpr = StyleTextAGRALAStock;
            }
            field(_StockMinino; Rec.AlxSafetyStockQuantity)
            {
                ApplicationArea = All;
                Caption = 'Stock de seguridad';
            }
            field(AGRALACantidadPedidosCompra; Rec.AGRALACantidadPedidosCompra)
            {
                ApplicationArea = All;
            }
            field(AGRALACantidadNecesaria; Rec.AGRALACantidadNecesaria)
            {
                ApplicationArea = All;
                StyleExpr = StyleTextAGRALACantidadNecesaria;
            }
            field(AGRALANombreProveedor; Rec.AGRALANombreProveedor)
            {
                ApplicationArea = All;
                Caption = 'Nombre proveedor';
            }
            field(AGRALAOrigenDemanda; Rec.AGRALAOrigenDemanda)
            {
                ApplicationArea = All;
            }
            field(AGRALACosteUnitario; Rec.AGRALACosteUnitario)
            {
                ApplicationArea = All;
                Visible = false;
            }
            field(_UtlimoCosteDirecto; Rec.AlxLastDirectCost)
            {
                ApplicationArea = All;
                Caption = 'Ultimo coste directo';
            }
            field(AGRALACosteEstandar; Rec.AGRALACosteEstandar)
            {
                ApplicationArea = All;
            }
            field(AGRALADiferencia; Rec.AGRALADiferencia)
            {
                ApplicationArea = All;
                //StyleExpr = StyleTextAGRALADiferencia;
                Visible = false;
            }
            field(_Diferencial; Rec.AlxDiferencia)
            {
                ApplicationArea = All;
                Caption = 'Diferencia';
                StyleExpr = StyleTextAGRALADiferencia;
            }
            field(AGRALALineaNegocio; Rec.AGRALALineaNegocio)
            {
                ApplicationArea = All;
            }
            field(LineaDeNegocio; Rec.AlxLineaNegocio)
            {
                ApplicationArea = All;
                Caption = 'Linea de Negocio';
            }
        }
        addafter("Accept Action Message")
        {
            field(AGRALAEstadoEvento; Rec.AGRALAEstadoEvento)
            {
                ApplicationArea = All;
            }
            field(AGRALAProcedencia; Rec.AGRALAProcedencia)
            {
                ApplicationArea = All;
            }
            field(_DescrEvento; _DescrEvento)
            {
                ApplicationArea = All;
                Caption = 'Descripción Evento';
            }
            field(AGRALACodProcedencia; Rec.AGRALACodProcedencia)
            {
                ApplicationArea = All;
                Caption = 'Cod. Procedencia';

                trigger OnLookup(var Text: Text): Boolean var
                    rlSalesHeader: Record 36;
                    rlAssemblyHeader: Record 900;
                    rlEvento: Record 50004;
                begin
                    IF Rec.AGRALAProcedencia = Rec.AGRALAProcedencia::EVENTO THEN BEGIN
                        rlEvento.SETRANGE("Codigo Evento", Rec.AGRALAOrigenDemanda);
                        PAGE.RUN(50006, rlEvento);
                    END;
                    IF(Rec.AGRALAProcedencia = Rec.AGRALAProcedencia::"PED. ENSAMBLADO EVENTO") OR (Rec.AGRALAProcedencia = Rec.AGRALAProcedencia::"PED. ENSAMBLADO SIN ENVENTO")THEN BEGIN
                        rlAssemblyHeader.SETRANGE("Document Type", rlAssemblyHeader."Document Type"::Order);
                        rlAssemblyHeader.SETRANGE("No.", Rec.AGRALAOrigenDemanda);
                        PAGE.RUN(900, rlAssemblyHeader);
                    END;
                    IF(Rec.AGRALAProcedencia = Rec.AGRALAProcedencia::"PED. VENTA")THEN BEGIN
                        rlSalesHeader.SETRANGE("Document Type", rlSalesHeader."Document Type"::Order);
                        rlSalesHeader.SETRANGE("No.", Rec.AGRALAOrigenDemanda);
                        PAGE.RUN(42, rlSalesHeader);
                    END;
                end;
            //StyleExpr = AGRALAStyleText;
            }
        }
    }
    actions
    {
        addafter(Reserve)
        {
            action(LanzarPlan)
            {
                ApplicationArea = All;
                Caption = 'Lanzar Plan';
                Ellipsis = true;
                Image = Calculate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report 50023;
            }
        }
    }
    var StyleTextAGRALAStock: Text;
    StyleTextAGRALADiferencia: Text;
    StyleTextAGRALACantidadNecesaria: Text;
    //_UtlimoCosteDirecto: Decimal;
    // _Diferencial: Decimal;
    //_StockMinino: Decimal;
    _DescrEvento: Text;
    trigger OnAfterGetRecord()
    var
        RecItem: Record Item;
        recEvento: Record Evento;
    begin
        StyleTextAGRALAStock:='Standard';
        IF Rec.AGRALAStock < 0 THEN StyleTextAGRALAStock:='Unfavorable';
        StyleTextAGRALACantidadNecesaria:='Standard';
        IF Rec.AGRALACantidadNecesaria < 0 THEN StyleTextAGRALACantidadNecesaria:='Unfavorable';
        //Clear(_UtlimoCosteDirecto);
        //Clear(_StockMinino);
        //Clear(_Diferencial);
        Clear(_DescrEvento);
        //RecItem.Reset();
        //RecItem.SetRange("No.", Rec."No.");
        //if RecItem.FindFirst() then begin
        //_UtlimoCosteDirecto := RecItem."Last Direct Cost";
        //_Diferencial := (Rec.AGRALACosteEstandar - _UtlimoCosteDirecto);
        //_StockMinino := RecItem."Safety Stock Quantity";
        //end;
        StyleTextAGRALADiferencia:='Standard';
        if Rec.AlxDiferencia < 0 then StyleTextAGRALADiferencia:='Unfavorable';
        if Rec.AGRALAProcedencia = Rec.AGRALAProcedencia::EVENTO then begin
            recEvento.Reset();
            recEvento.SetRange("Codigo Evento", Rec.AGRALAOrigenDemanda);
            if recEvento.FindFirst()then _DescrEvento:=recEvento.Descripcion;
        end;
    end;
}
