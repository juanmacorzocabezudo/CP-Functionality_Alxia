tableextension 50019 AlxiaAssemblyLine extends "Assembly Line"
{
    fields
    {
        /*  modify("Quantity to Consume")
         {
             trigger OnBeforeValidate()
             begin
                 "Quantity to Consume" := Quantity;
                 "Quantity to Consume (Base)" := Quantity;
             end;
         } */
        field(50000; "Cantidad por Lote"; Decimal)
        {
            Caption = 'Cantidad por Lote';
            DataClassification = CustomerContent;
            DecimalPlaces = 0: 6;
            Description = '#9993';
            Editable = false;

            trigger OnValidate()
            var
                lt_producto: Record 27;
            begin
            end;
        }
        field(50001; Comentario; Text[250])
        {
            Caption = 'Comentario';
            DataClassification = CustomerContent;
        }
        field(50002; CantidadEscalado; Decimal)
        {
            Caption = 'CantidadEscalado';
            DataClassification = CustomerContent;
        }
        field(50003; "Cod Proveedor"; Code[20])
        {
            Caption = 'Cod Proveedor';
            CalcFormula = Lookup(Item."Vendor No." WHERE("No."=FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50004; "Nombre Proveedor"; Text[150])
        {
            Caption = 'Nombre Proveedor';
            CalcFormula = Lookup(Vendor.Name WHERE("No."=FIELD("Cod Proveedor")));
            FieldClass = FlowField;
        }
        field(50005; AGRALACentroCoste; Text[250])
        {
            Caption = 'Centro de coste';
            DataClassification = CustomerContent;
            Description = '#22003';
        }
        field(50015; "Related Work Center"; Code[20])
        {
            Caption = 'Centro Trabajo Relacionado';
            DataClassification = CustomerContent;
            Description = '#9785';
            Editable = false;
            TableRelation = "Work center Header"."No.";
        }
        field(50020; "Perc. Loss"; Decimal)
        {
            Caption = '% Merma';
            DataClassification = CustomerContent;
            Description = '#9969';

            trigger OnValidate()
            begin
                //-- #9969
                VALIDATE("Net Amount");
            //++ #9969
            end;
        }
        field(50021; "Net Amount"; Decimal)
        {
            Caption = 'Cantidad Neta';
            DataClassification = CustomerContent;
            Description = '#9969';
            Editable = false;

            trigger OnValidate()
            begin
                //-- #9969
                "Net Amount":=Rec.Quantity - (Rec.Quantity * Rec."Perc. Loss") / 100;
            //++ #9969
            end;
        }
        field(50030; AGRALAResponsable; Text[30])
        {
            Caption = 'Responsable';
            DataClassification = CustomerContent;
            Description = '#22003';
        }
        field(50040; AGRALANivel; Text[30])
        {
            CalcFormula = Lookup("Assembly Header".AGRALANivel WHERE("Document Type"=FIELD("Document Type"), "No."=FIELD("Document No.")));
            Caption = 'Nivel';
            Description = '#22003';
            FieldClass = FlowField;
        }
        field(50041; AGRALARecetaMadre; Text[50])
        {
            CalcFormula = Lookup("Assembly Header".AGRALARecetaMadre WHERE("Document Type"=FIELD("Document Type"), "No."=FIELD("Document No.")));
            Caption = 'Receta Madre';
            Description = '#22003';
            FieldClass = FlowField;
            TableRelation = "Assembly Header"."No.";

            trigger OnLookup()
            var
                rlAssemblyHeader: Record 900;
            begin
                rlAssemblyHeader.SETRANGE("Document Type", Rec."Document Type");
                rlAssemblyHeader.SETRANGE("No.", Rec."No.");
                PAGE.RUN(900, rlAssemblyHeader);
            end;
        }
        field(60000; "Cantidad Original"; Decimal)
        {
            DecimalPlaces = 0: 5;
            Description = 'KR';
            Editable = false;
        }
        field(60001; "Cantidad Por Original"; Decimal)
        {
            DecimalPlaces = 0: 5;
            Description = 'KR';
            Editable = false;
        }
        field(60002; Diferencia; Decimal)
        {
            DecimalPlaces = 0: 5;
            Description = 'KR';
            Editable = false;
        }
        field(60003; "Diferencia%"; Decimal)
        {
            Description = 'KR';
            Editable = false;
        }
        field(80000; "Standard Cost"; Decimal)
        {
            Caption = 'Standard Cost';
            Description = '#9766';
            Editable = false;
        }
        field(80001; "Cost Std Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost Standard Amount';
            Description = '#9766';
            Editable = false;
        }
        modify("Location Code")
        {
        trigger OnAfterValidate()
        begin
            //-- #9766
            "Standard Cost":=GetUnitStdCost;
            "Cost Std Amount":=CalcCostAmount(Quantity, "Standard Cost");
        //++ #9766
        end;
        }
        modify("Quantity per")
        {
        trigger OnAfterValidate()
        begin
            //++ KR
            // Inicio ADV001
            gfu_CalcularEscalado;
            // Fin ADV001
            //--
            // Inicio ADV001
            // Línea modificada   VALIDATE(Quantity,CalcQuantity("Quantity per",AssemblyHeader.Quantity));
            VALIDATE(Quantity, CalcQuantity("Quantity per", gd_CantidadCabecera));
            // Fin ADV001
            VALIDATE("Quantity to Consume", MinValue(MaxQtyToConsume, CalcQuantity("Quantity per", AssemblyHeader."Quantity to Assemble")));
            // Inicio ADV001
            RoundQty(Quantity);
            // Fin ADV001
            //-- #11552
            IF(Rec."Cantidad Por Original" = 0) AND (Rec."Quantity per" <> 0)THEN Rec."Cantidad Por Original":=Rec."Quantity per";
        //++ #11552
        end;
        }
        modify("Quantity to Consume (Base)")
        {
        trigger OnAfterValidate()
        begin
            //-- #9627
            IF(CurrFieldNo <> 0) AND (CurrFieldNo <> FIELDNO(Quantity))THEN BEGIN
                CLEAR(FuncionesVarias);
                FuncionesVarias.ModAssamblyOrders(Rec);
            END;
        //++ #9627
        end;
        }
        modify("Resource Usage Type")
        {
        trigger OnAfterValidate()
        begin
            // Inicio ADV001
            // Línea modificada   VALIDATE(Quantity,CalcQuantity("Quantity per",AssemblyHeader.Quantity));
            VALIDATE(Quantity, CalcQuantity("Quantity per", gd_CantidadCabecera));
        // Fin ADV001
        end;
        }
        modify("Variant Code")
        {
        trigger OnAfterValidate()
        begin
            //-- #9766
            "Standard Cost":=GetUnitStdCost;
            "Cost Std Amount":=CalcCostAmount(Quantity, "Standard Cost");
        //++ #9766
        end;
        }
        modify(Quantity)
        {
        trigger OnAfterValidate()
        var
            rlItem: Record 27;
        begin
            //WhseValidateSourceLine.AssemblyLineVerifyChange(Rec, xRec);
            //++ KR
            IF Rec."Position 2" <> '2' THEN BEGIN
                IF(gd_CantidadCabecera = 0)THEN BEGIN
                    AssemblyHeader.GET(Rec."Document Type", Rec."Document No.");
                    IF AssemblyHeader.Quantity <> 0 THEN "Quantity per":=Quantity / AssemblyHeader.Quantity;
                END
                ELSE
                BEGIN
                    "Quantity per":=Quantity / gd_CantidadCabecera;
                END;
            END;
            //--
            //++ KR 25/10/21
            IF(Rec.Type = Rec.Type::Item) AND (Rec."Position 2" = '2')THEN BEGIN
                Quantity:=ROUND(Quantity, 1, '>');
                //++ KR
                IF(gd_CantidadCabecera = 0)THEN BEGIN
                    AssemblyHeader.GET(Rec."Document Type", Rec."Document No.");
                    IF AssemblyHeader.Quantity <> 0 THEN "Quantity per":=Quantity / AssemblyHeader.Quantity;
                END
                ELSE
                BEGIN
                    "Quantity per":=Quantity / gd_CantidadCabecera;
                END;
            //--
            END;
            //--
            //++ KR
            /********************* COMENTADO ********************
                AssemblyHeader.GET(Rec."Document Type", Rec."Document No.");
                IF AssemblyHeader.Quantity <> 0 THEN
                "Quantity per" := Quantity / AssemblyHeader.Quantity;
                ******************* FIN COMENTADO *******************/
            //--
            //RoundQty(Quantity);
            "Quantity (Base)":=Quantity;
            "Quantity to Consume":=Quantity;
            "Quantity to Consume (Base)":=Quantity;
            //InitRemainingQty;
            //InitQtyToConsume;
            //CheckItemAvailable(FIELDNO(Quantity));
            //VerifyReservationQuantity(Rec, xRec);
            "Cost Amount":=CalcCostAmount(Quantity, "Unit Cost");
            "Cost Std Amount":=CalcCostAmount(Quantity, "Standard Cost"); //** #9766
            //-- #9627
            IF(CurrFieldNo = FIELDNO(Quantity))THEN BEGIN
                CLEAR(FuncionesVarias);
                FuncionesVarias.ModAssamblyOrders(Rec);
            END;
            //++ #9627
            //-- #9969
            VALIDATE("Net Amount");
            //++ #9969
            //-- #11552
            IF(Rec."Cantidad Original" = 0) AND (Rec.Quantity <> 0)THEN Rec."Cantidad Original":=Rec.Quantity;
            Rec.Diferencia:=Rec.Quantity - Rec."Cantidad Original";
            Rec."Diferencia%":=0;
            IF Rec."Cantidad Original" <> 0 THEN Rec."Diferencia%":=Rec.Diferencia / Rec."Cantidad Original" * 100;
            //++ #11552
            //++AGRALA 862
            IF xRec.Quantity <> Rec.Quantity THEN BEGIN
                IF Rec.Type = Rec.Type::Item THEN IF rlItem.GET(Rec."No.")THEN BEGIN
                        rlItem.CALCFIELDS(rlItem.Inventory, rlItem.AGRALAQtyAssemblyOrderLine, rlItem.AGRALAQtyOnSalesOrder);
                        rlItem.AGRALAStockDisponible:=rlItem.Inventory - (rlItem.AGRALAQtyAssemblyOrderLine - xRec.Quantity + Rec.Quantity) - rlItem.AGRALAQtyOnSalesOrder;
                        rlItem.MODIFY();
                    END;
            END;
        //--AGRALA 862
        end;
        }
    }
    trigger OnAfterDelete()
    var
        //WhseAssemblyRelease: Codeunit 904;
        //AssemblyLineReserve: Codeunit 926;
        rlItem: Record 27;
    begin
        //TestStatusOpen;
        //WhseValidateSourceLine.AssemblyLineDelete(Rec);
        //WhseAssemblyRelease.DeleteLine(Rec);
        //AssemblyLineReserve.DeleteLine(Rec);
        //CALCFIELDS("Reserved Qty. (Base)");
        //TESTFIELD("Reserved Qty. (Base)", 0);
        //++AGRALA 862
        IF Rec.Type = Rec.Type::Item THEN IF rlItem.GET(Rec."No.")THEN BEGIN
                rlItem.CALCFIELDS(rlItem.Inventory, rlItem.AGRALAQtyAssemblyOrderLine, rlItem.AGRALAQtyOnSalesOrder);
                rlItem.AGRALAStockDisponible:=rlItem.Inventory - (rlItem.AGRALAQtyAssemblyOrderLine - Rec.Quantity) - rlItem.AGRALAQtyOnSalesOrder;
                rlItem.MODIFY();
            END;
    //--AGRALA 862
    end;
    trigger OnAfterInsert()
    var
        rlItem: Record 27;
    begin
        //TestStatusOpen;
        //VerifyReservationQuantity(Rec, xRec);
        //++AGRALA 862
        IF xRec.Quantity <> Rec.Quantity THEN BEGIN
            IF Rec.Type = Rec.Type::Item THEN IF rlItem.GET(Rec."No.")THEN BEGIN
                    rlItem.CALCFIELDS(rlItem.Inventory, rlItem.AGRALAQtyAssemblyOrderLine, rlItem.AGRALAQtyOnSalesOrder);
                    rlItem.AGRALAStockDisponible:=rlItem.Inventory - (rlItem.AGRALAQtyAssemblyOrderLine + Rec.Quantity) - rlItem.AGRALAQtyOnSalesOrder;
                    rlItem.MODIFY();
                END;
        END;
    //--AGRALA 862
    end;
    trigger OnAfterModify()
    var
        rlItem: Record 27;
    begin
        //WhseValidateSourceLine.AssemblyLineVerifyChange(Rec, xRec);
        //VerifyReservationChange(Rec, xRec);
        //++AGRALA 862
        IF xRec.Quantity <> Rec.Quantity THEN BEGIN
            IF Rec.Type = Rec.Type::Item THEN IF rlItem.GET(Rec."No.")THEN BEGIN
                    rlItem.CALCFIELDS(rlItem.Inventory, rlItem.AGRALAQtyAssemblyOrderLine, rlItem.AGRALAQtyOnSalesOrder);
                    rlItem.AGRALAStockDisponible:=rlItem.Inventory - (rlItem.AGRALAQtyAssemblyOrderLine - xRec.Quantity + Rec.Quantity) - rlItem.AGRALAQtyOnSalesOrder;
                    rlItem.MODIFY();
                END;
        END;
        //--AGRALA 862
        //SL Net
        Rec.Validate("Net Amount");
    end;
    var Item: Record 27;
    Resource: Record 156;
    WhseValidateSourceLine: Codeunit "Assembly Warehouse Mgt.";
    AssemblyLineReserve: Codeunit 926;
    AssemblyHeader: Record 900;
    StockkeepingUnit: Record 5700;
    GLSetup: Record 98;
    gt_Escalados: Record 50017;
    gd_CantidadCabecera: Decimal;
    gd_CantidadBaseCabecera: Decimal;
    gd_CantidadPendienteCabecera: Decimal;
    gd_CantidadPendienteBaseCabecera: Decimal;
    gd_CantidadEnsamblarCabecera: Decimal;
    gd_CantidadEnsamblarBaseCabecera: Decimal;
    gb_FijarCantidadCabecera: Boolean;
    FuncionesVarias: Codeunit 50003;
    GLSetupRead: Boolean;
    ERROR001: Label 'There is no scaling section for product %1 for quantity %2. Review the list of scales for that product';
    local procedure Refresh(NewQuantity: Decimal)
    begin
        VALIDATE(Quantity, NewQuantity);
    end;
    local procedure FindLine(OrderType: Option Quote, "Assembly Order", , , "Blanket Order"; OrderNo: Code[20]; LineType: Option " ", Item, Resource; Number: Code[20]): Boolean begin
        SETRANGE("Document Type", OrderType);
        SETRANGE("Document No.", OrderNo);
        SETRANGE(Type, LineType);
        SETRANGE("No.", Number);
        EXIT(FINDFIRST);
    end;
    procedure InsertLinesFromWorkCenter(ParentItemNo: Code[20]; WorkCenterNo: Code[20])
    var
        WorkcenterHeader: Record 50022;
        WorkCenterLine: Record 50023;
        BOMComponent: Record 90;
        TextInsWorkCenter: Label '¿Quiere cargar las lineas del centro de trabajo %1 en la LM del producto %2?';
        VarLineNo: Integer;
    begin
        //-- #9785
        IF CONFIRM(TextInsWorkCenter, TRUE, WorkCenterNo, ParentItemNo)THEN BEGIN
            WorkCenterLine.RESET;
            WorkCenterLine.SETRANGE("Work Center No.", WorkCenterNo);
            IF WorkCenterLine.FINDSET THEN BEGIN
                //** Se introduce la linea de descripción del centro de trabajo
                WorkcenterHeader.GET(WorkCenterLine."Work Center No.");
                CLEAR(VarLineNo);
                VarLineNo:=GetLasLineBomComponent(ParentItemNo);
                VarLineNo:=VarLineNo + 10000;
                BOMComponent.INIT;
                BOMComponent.VALIDATE("Parent Item No.", ParentItemNo);
                BOMComponent.VALIDATE("Line No.", VarLineNo);
                BOMComponent.VALIDATE(Type, BOMComponent.Type::" ");
                BOMComponent.VALIDATE(Description, WorkcenterHeader.Description);
                BOMComponent.VALIDATE("Related Work Center", WorkCenterNo);
                BOMComponent.INSERT(TRUE);
                REPEAT //** Se introduce las lineas del centro de trabajo
                    CLEAR(VarLineNo);
                    VarLineNo:=GetLasLineBomComponent(ParentItemNo);
                    VarLineNo:=VarLineNo + 10000;
                    BOMComponent.INIT;
                    BOMComponent.VALIDATE("Parent Item No.", ParentItemNo);
                    BOMComponent.VALIDATE("Line No.", VarLineNo);
                    BOMComponent.VALIDATE(Type, BOMComponent.Type::Resource);
                    BOMComponent.VALIDATE("No.", WorkCenterLine."No.");
                    BOMComponent.VALIDATE("Unit of Measure Code", WorkCenterLine."Unit of Mesaruement");
                    BOMComponent.VALIDATE("Related Work Center", WorkCenterNo);
                    BOMComponent.VALIDATE("Cantidad por Lote", WorkCenterLine."Quantity per"); //** #9993
                    BOMComponent.VALIDATE(CosteUnitario, WorkCenterLine."Resource Cost");
                    BOMComponent."Coste Calculado":=WorkCenterLine."Quantity per" * WorkCenterLine."Resource Cost";
                    BOMComponent.INSERT(TRUE);
                UNTIL WorkCenterLine.NEXT = 0;
            END;
        END;
    //++ #9785
    end;
    local procedure GetLasLineBomComponent(ParentItemNo: Code[20])ReturnLineNo: Integer var
        BOMComponent: Record 90;
    begin
        //-- #9785
        CLEAR(ReturnLineNo);
        BOMComponent.RESET;
        BOMComponent.SETRANGE("Parent Item No.", ParentItemNo);
        IF BOMComponent.FINDLAST THEN ReturnLineNo:=BOMComponent."Line No.";
        EXIT(ReturnLineNo);
    //++ #9785
    end;
    local procedure CalcCostAmount(Qty: Decimal; UnitCost: Decimal): Decimal begin
        EXIT(ROUND(Qty * UnitCost));
    end;
    local procedure CheckItemAvailable(CalledByFieldNo: Integer)
    var
        AssemblySetup: Record 905;
        ItemCheckAvail: Codeunit 311;
    begin
        IF NOT UpdateAvailWarning THEN EXIT;
        IF "Document Type" <> "Document Type"::Order THEN EXIT;
        AssemblySetup.GET;
        IF NOT AssemblySetup."Stockout Warning" THEN EXIT;
        IF Reserve = Reserve::Always THEN EXIT;
        IF(CalledByFieldNo = CurrFieldNo) OR ((CalledByFieldNo = FIELDNO("No.")) AND (CurrFieldNo <> 0)) OR ((CalledByFieldNo = FIELDNO(Quantity)) AND (CurrFieldNo = FIELDNO("Quantity per")))THEN IF ItemCheckAvail.AssemblyLineCheck(Rec)THEN ItemCheckAvail.RaiseUpdateInterruptedError;
    end;
    local procedure CalcBaseQty(Qty: Decimal): Decimal var
        UOMMgt: Codeunit 5402;
    begin
        EXIT(UOMMgt.CalcBaseQty(Qty, "Qty. per Unit of Measure"));
    end;
    local procedure CalcQtyFromBase(QtyBase: Decimal): Decimal var
        UOMMgt: Codeunit 5402;
    begin
        EXIT(UOMMgt.CalcQtyFromBase(QtyBase, "Qty. per Unit of Measure"));
    end;
    /*  local procedure GetItemResource()
     begin
         IF Type = Type::Item THEN
             IF Item."No." <> "No." THEN
                 Item.GET("No.");
         IF Type = Type::Resource THEN
             IF Resource."No." <> "No." THEN
                 Resource.GET("No.");
     end; */
    /* local procedure GetGLSetup()
    begin
        IF NOT GLSetupRead THEN BEGIN
            GLSetup.GET;
            GLSetupRead := TRUE
        END
    end; */
    local procedure GetLocation(var Location: Record 14; LocationCode: Code[10])
    begin
        IF LocationCode = '' THEN CLEAR(Location)
        ELSE IF Location.Code <> LocationCode THEN Location.GET(LocationCode);
    end;
    /*  procedure CalcQuantityPer(Qty: Decimal): Decimal
     begin
         GetHeader;
         AssemblyHeader.TESTFIELD(Quantity);

         IF FixedUsage THEN
             EXIT(Qty);

         // Inicio ADV001
         EXIT(Qty / gd_CantidadCabecera);
         // Fin ADV001
     end; */
    procedure CalcQuantityFromBOM(LineType: Option; QtyPer: Decimal; HeaderQty: Decimal; HeaderQtyPerUOM: Decimal; LineResourceUsageType: Option): Decimal begin
        IF FixedUsage2(LineType, LineResourceUsageType)THEN EXIT(QtyPer);
        EXIT(QtyPer * HeaderQty * HeaderQtyPerUOM);
    end;
    local procedure FixedUsage2(LineType: Option; LineResourceUsageType: Option): Boolean begin
        IF(LineType = Type::Resource) AND (LineResourceUsageType = "Resource Usage Type"::Fixed)THEN EXIT(TRUE);
        EXIT(FALSE);
    end;
    local procedure CalcQuantity(LineQtyPer: Decimal; HeaderQty: Decimal): Decimal begin
        EXIT(CalcQuantityFromBOM(Type, LineQtyPer, HeaderQty, 1, "Resource Usage Type"));
    end;
    /* procedure CalcAvailToAssemble(AssemblyHeader: Record 900; var Item: Record 27; var GrossRequirement: Decimal; var ScheduledReceipt: Decimal; var ExpectedInventory: Decimal; var AvailableInventory: Decimal; var EarliestDate: Date; var AbleToAssemble: Decimal)
    var
        UOMMgt: Codeunit 5402;
    begin
        TESTFIELD("Quantity per");

        CalcAvailQuantities(
          Item,
          GrossRequirement,
          ScheduledReceipt,
          ExpectedInventory,
          AvailableInventory,
          EarliestDate);

        IF ExpectedInventory < "Remaining Quantity (Base)" THEN BEGIN
            IF ExpectedInventory < 0 THEN
                AbleToAssemble := 0
            ELSE
                AbleToAssemble := ROUND(ExpectedInventory / "Quantity per", UOMMgt.QtyRndPrecision, '<')
        END ELSE BEGIN
            // Inicio ADV001
            // Línea modificada   AbleToAssemble := AssemblyHeader."Remaining Quantity";
            AbleToAssemble := gd_CantidadPendienteCabecera;
            // Fin ADV001
            EarliestDate := 0D;
        END;
    end; */
    procedure gfu_CalcularEscalado()
    var
        li_DifActual: Decimal;
        li_DifAnterior: Decimal;
        li_CantTramoAnterior: Decimal;
        li_Cantidad: Decimal;
        lb_SalirRepeat: Boolean;
        lb_ExisteEscalado: Boolean;
        lb_ExisteEscaladoSuperior: Boolean;
        lt_Componente: Record 90;
    begin
        // Inicio ADV001
        GetHeader;
        li_DifActual:=0;
        li_DifAnterior:=10000;
        li_CantTramoAnterior:=0;
        lb_SalirRepeat:=FALSE;
        lb_ExisteEscalado:=FALSE;
        lb_ExisteEscaladoSuperior:=FALSE;
        IF NOT gb_FijarCantidadCabecera THEN BEGIN
            gd_CantidadCabecera:=AssemblyHeader."Quantity to Assemble";
            ;
            gd_CantidadBaseCabecera:=AssemblyHeader."Quantity (Base)";
            gd_CantidadPendienteCabecera:=AssemblyHeader."Remaining Quantity";
            gd_CantidadPendienteBaseCabecera:=AssemblyHeader."Remaining Quantity (Base)";
            gd_CantidadEnsamblarCabecera:=AssemblyHeader.Quantity;
            gd_CantidadEnsamblarBaseCabecera:=AssemblyHeader."Quantity to Assemble (Base)" END;
        gt_Escalados.RESET;
        gt_Escalados.SETRANGE(gt_Escalados.NumeroLM, AssemblyHeader."Item No.");
        //gt_Escalados.SETRANGE(gt_Escalados.Tipo, Type);
        gt_Escalados.SETRANGE(gt_Escalados.Numero, "No.");
        gt_Escalados.SETRANGE(gt_Escalados.CodigoUnidadMedida, "Unit of Measure Code");
        IF gt_Escalados.FINDSET THEN REPEAT lb_ExisteEscalado:=TRUE;
                CASE gt_Escalados.TipoTramo OF 0: BEGIN
                    lb_ExisteEscaladoSuperior:=TRUE;
                    IF gt_Escalados.LoteReceta <= gd_CantidadEnsamblarCabecera THEN IF gt_Escalados.CalculoProporcional THEN BEGIN
                            Quantity:=(gt_Escalados.CantidadLoteReceta / gt_Escalados.LoteReceta) * gd_CantidadEnsamblarCabecera;
                            // Inicio ADV002
                            IF Type = gt_Escalados.Tipo::Recurso THEN BEGIN
                                lt_Componente.RESET;
                                IF lt_Componente.GET(gt_Escalados.NumeroLM, gt_Escalados.NumeroLinea)THEN IF lt_Componente.TipoRecurso = lt_Componente.TipoRecurso::Machine THEN Quantity:=ROUND(Quantity, 1, '>')END;
                            // Fin ADV002
                            li_CantTramoAnterior:=Quantity END
                        ELSE
                            Quantity:=gt_Escalados.CantidadLoteReceta
                    ELSE // Compruebo si el resultado del cálculo es mayor a la cantidad configurada en el tramo superior
                        IF li_CantTramoAnterior <> 0 THEN IF gt_Escalados.CantidadLoteReceta <= li_CantTramoAnterior THEN BEGIN
                                Quantity:=gt_Escalados.CantidadLoteReceta;
                                CantidadEscalado:=li_CantTramoAnterior END;
                END;
                1: BEGIN
                    lb_ExisteEscaladoSuperior:=TRUE;
                    li_DifActual:=ABS(gd_CantidadEnsamblarCabecera - gt_Escalados.LoteReceta);
                    IF li_DifActual < li_DifAnterior THEN IF gt_Escalados.CalculoProporcional THEN BEGIN
                            Quantity:=(gt_Escalados.CantidadLoteReceta / gt_Escalados.LoteReceta) * gd_CantidadEnsamblarCabecera;
                            // Inicio ADV002
                            IF Type = gt_Escalados.Tipo::Recurso THEN BEGIN
                                lt_Componente.RESET;
                                IF lt_Componente.GET(gt_Escalados.NumeroLM, gt_Escalados.NumeroLinea)THEN IF lt_Componente.TipoRecurso = lt_Componente.TipoRecurso::Machine THEN Quantity:=ROUND(Quantity, 1, '>')END;
                            // Fin ADV002
                            li_CantTramoAnterior:=Quantity;
                            li_DifAnterior:=li_DifActual END
                        ELSE
                        BEGIN
                            Quantity:=gt_Escalados.CantidadLoteReceta;
                            li_DifAnterior:=li_DifActual END
                    ELSE // Compruebo si el resultado del cálculo es mayor a la cantidad configurada en el tramo superior
                        IF li_CantTramoAnterior <> 0 THEN IF gt_Escalados.CantidadLoteReceta <= li_CantTramoAnterior THEN BEGIN
                                Quantity:=gt_Escalados.CantidadLoteReceta;
                                CantidadEscalado:=li_CantTramoAnterior END;
                END;
                2: IF gt_Escalados.LoteReceta >= gd_CantidadEnsamblarCabecera THEN IF gt_Escalados.CalculoProporcional THEN BEGIN
                            Quantity:=(gt_Escalados.CantidadLoteReceta / gt_Escalados.LoteReceta) * gd_CantidadEnsamblarCabecera;
                            // Inicio ADV002
                            IF Type = gt_Escalados.Tipo::Recurso THEN BEGIN
                                lt_Componente.RESET;
                                IF lt_Componente.GET(gt_Escalados.NumeroLM, gt_Escalados.NumeroLinea)THEN IF lt_Componente.TipoRecurso = lt_Componente.TipoRecurso::Machine THEN Quantity:=ROUND(Quantity, 1, '>')END;
                            // Fin ADV002
                            li_CantTramoAnterior:=Quantity;
                            lb_ExisteEscaladoSuperior:=TRUE END
                        ELSE
                        BEGIN
                            Quantity:=gt_Escalados.CantidadLoteReceta;
                            lb_SalirRepeat:=TRUE;
                            lb_ExisteEscaladoSuperior:=TRUE END;
                ELSE // Compruebo si el resultado del cálculo es mayor a la cantidad configurada en el tramo superior
                    IF li_CantTramoAnterior <> 0 THEN IF gt_Escalados.CantidadLoteReceta <= li_CantTramoAnterior THEN BEGIN
                            Quantity:=gt_Escalados.CantidadLoteReceta;
                            CantidadEscalado:=li_CantTramoAnterior END;
                END;
                "Quantity per":=Quantity / gd_CantidadEnsamblarCabecera;
            UNTIL(gt_Escalados.NEXT = 0) OR lb_SalirRepeat;
        IF(lb_ExisteEscalado) AND (NOT lb_ExisteEscaladoSuperior)THEN ERROR(ERROR001, "No.", gd_CantidadEnsamblarCabecera);
    // Fin ADV001
    end;
    procedure gfu_CalcularEscalado2()
    var
        li_DifActual: Integer;
        li_DifAnterior: Integer;
        li_CantTramoAnterior: Decimal;
        li_Cantidad: Decimal;
        lb_SalirRepeat: Boolean;
        lt_Componente: Record 90;
    begin
        // Inicio ADV001
        li_DifActual:=0;
        li_DifAnterior:=10000;
        li_CantTramoAnterior:=0;
        lb_SalirRepeat:=FALSE;
        IF NOT gb_FijarCantidadCabecera THEN BEGIN
            gd_CantidadCabecera:=AssemblyHeader.Quantity;
            gd_CantidadBaseCabecera:=AssemblyHeader."Quantity (Base)";
            gd_CantidadPendienteCabecera:=AssemblyHeader."Remaining Quantity";
            gd_CantidadPendienteBaseCabecera:=AssemblyHeader."Remaining Quantity (Base)";
            gd_CantidadEnsamblarCabecera:=AssemblyHeader."Quantity to Assemble";
            gd_CantidadEnsamblarBaseCabecera:=AssemblyHeader."Quantity to Assemble (Base)" END;
        gt_Escalados.RESET;
        gt_Escalados.SETRANGE(gt_Escalados.NumeroLM, AssemblyHeader."Item No.");
        //gt_Escalados.SETRANGE(gt_Escalados.Tipo, Type);
        gt_Escalados.SETRANGE(gt_Escalados.Numero, "No.");
        gt_Escalados.SETRANGE(gt_Escalados.CodigoUnidadMedida, "Unit of Measure Code");
        IF gt_Escalados.FINDSET THEN REPEAT CASE gt_Escalados.TipoTramo OF 0: IF gt_Escalados.LoteReceta <= gd_CantidadCabecera THEN IF gt_Escalados.CalculoProporcional THEN BEGIN
                            "Quantity to Consume":=(gt_Escalados.CantidadLoteReceta / gt_Escalados.LoteReceta) * gd_CantidadCabecera;
                            // Inicio ADV002
                            IF Type = gt_Escalados.Tipo::Recurso THEN BEGIN
                                lt_Componente.RESET;
                                IF lt_Componente.GET(gt_Escalados.NumeroLM, gt_Escalados.NumeroLinea)THEN IF lt_Componente.TipoRecurso = lt_Componente.TipoRecurso::Machine THEN "Quantity to Consume":=ROUND("Quantity to Consume", 1, '>')END;
                            // Fin ADV002
                            li_CantTramoAnterior:="Quantity to Consume" END
                        ELSE
                            "Quantity to Consume":=gt_Escalados.CantidadLoteReceta
                    ELSE // Compruebo si el resultado del cálculo es mayor a la cantidad configurada en el tramo superior
                        IF li_CantTramoAnterior <> 0 THEN IF gt_Escalados.CantidadLoteReceta <= li_CantTramoAnterior THEN BEGIN
                                "Quantity to Consume":=gt_Escalados.CantidadLoteReceta;
                                CantidadEscalado:=li_CantTramoAnterior END;
                1: BEGIN
                    li_DifActual:=ABS(gd_CantidadCabecera - gt_Escalados.LoteReceta);
                    IF li_DifActual < li_DifAnterior THEN IF gt_Escalados.CalculoProporcional THEN BEGIN
                            "Quantity to Consume":=(gt_Escalados.CantidadLoteReceta / gt_Escalados.LoteReceta) * gd_CantidadCabecera;
                            // Inicio ADV002
                            IF Type = gt_Escalados.Tipo::Recurso THEN BEGIN
                                lt_Componente.RESET;
                                IF lt_Componente.GET(gt_Escalados.NumeroLM, gt_Escalados.NumeroLinea)THEN IF lt_Componente.TipoRecurso = lt_Componente.TipoRecurso::Machine THEN "Quantity to Consume":=ROUND("Quantity to Consume", 1, '>')END;
                            // Fin ADV002
                            li_CantTramoAnterior:="Quantity to Consume";
                            li_DifAnterior:=li_DifActual END
                        ELSE
                        BEGIN
                            "Quantity to Consume":=gt_Escalados.CantidadLoteReceta;
                            li_DifAnterior:=li_DifActual END
                    ELSE // Compruebo si el resultado del cálculo es mayor a la cantidad configurada en el tramo superior
                        IF li_CantTramoAnterior <> 0 THEN IF gt_Escalados.CantidadLoteReceta <= li_CantTramoAnterior THEN BEGIN
                                "Quantity to Consume":=gt_Escalados.CantidadLoteReceta;
                                CantidadEscalado:=li_CantTramoAnterior END;
                END;
                2: IF gt_Escalados.LoteReceta >= gd_CantidadCabecera THEN IF gt_Escalados.CalculoProporcional THEN BEGIN
                            "Quantity to Consume":=(gt_Escalados.CantidadLoteReceta / gt_Escalados.LoteReceta) * gd_CantidadCabecera;
                            // Inicio ADV002
                            IF Type = gt_Escalados.Tipo::Recurso THEN BEGIN
                                lt_Componente.RESET;
                                IF lt_Componente.GET(gt_Escalados.NumeroLM, gt_Escalados.NumeroLinea)THEN IF lt_Componente.TipoRecurso = lt_Componente.TipoRecurso::Machine THEN "Quantity to Consume":=ROUND("Quantity to Consume", 1, '>')END;
                            // Fin ADV002
                            li_CantTramoAnterior:="Quantity to Consume" END
                        ELSE
                        BEGIN
                            "Quantity to Consume":=gt_Escalados.CantidadLoteReceta;
                            lb_SalirRepeat:=TRUE END;
                ELSE // Compruebo si el resultado del cálculo es mayor a la cantidad configurada en el tramo superior
                    IF li_CantTramoAnterior <> 0 THEN IF gt_Escalados.CantidadLoteReceta <= li_CantTramoAnterior THEN BEGIN
                            "Quantity to Consume":=gt_Escalados.CantidadLoteReceta;
                            CantidadEscalado:=li_CantTramoAnterior END;
                END;
                Quantity:="Quantity to Consume";
                "Quantity (Base)":=CalcBaseQty(Quantity);
                "Remaining Quantity (Base)":=CalcBaseQty("Remaining Quantity");
                "Quantity to Consume (Base)":=CalcBaseQty("Quantity to Consume");
                "Consumed Quantity (Base)":=CalcBaseQty("Consumed Quantity");
                "Remaining Quantity (Base)":=CalcBaseQty("Remaining Quantity");
            UNTIL(gt_Escalados.NEXT = 0) OR lb_SalirRepeat;
    // Fin ADV001
    end;
    procedure gfu_SetCantidadCabecera(pd_Cantidad: Decimal; pd_CantidadBase: Decimal; pd_CantidadPendiente: Decimal; pd_CantidadPendienteBase: Decimal; pd_CantidadEnsamblar: Decimal; pd_CantidadEnsamblarBase: Decimal; pb_Fijar: Boolean)
    begin
        // Inicio ADV001
        gd_CantidadCabecera:=pd_Cantidad;
        gd_CantidadBaseCabecera:=pd_CantidadBase;
        gd_CantidadPendienteCabecera:=pd_CantidadPendiente;
        gd_CantidadPendienteBaseCabecera:=pd_CantidadPendienteBase;
        gd_CantidadEnsamblarCabecera:=pd_CantidadEnsamblar;
        gd_CantidadEnsamblarBaseCabecera:=pd_CantidadEnsamblarBase;
        gb_FijarCantidadCabecera:=pb_Fijar;
    // Fin ADV001
    end;
    local procedure "//++ KR"()
    begin
    end;
    procedure ShowAssocietedOrder(AssemblyLine: Record 901)
    var
        AssemblyHeader: Record 900;
        ErrorAssocietedOrder: Label 'La línea %1 del documento %2 no tiene ninguna orden asociada';
    begin
        //-- #9627
        TESTFIELD(Type, Type::Item);
        AssemblyHeader.RESET;
        AssemblyHeader.SETRANGE("Document Type", AssemblyLine."Document Type");
        AssemblyHeader.SETRANGE("Associated Order No.", AssemblyLine."Document No.");
        AssemblyHeader.SETRANGE("Associated Order Line", AssemblyLine."Line No.");
        IF AssemblyHeader.FINDFIRST THEN PAGE.RUN(PAGE::"Assembly Order", AssemblyHeader)
        ELSE
            ERROR(ErrorAssocietedOrder, AssemblyLine."Line No.", AssemblyLine."Document No.");
    //++ #9627
    end;
    procedure ShowAssocietedOrderList(AssemblyLine: Record 901)Numero: Text var
        AssemblyHeader: Record 900;
        ErrorAssocietedOrder: Label 'La línea %1 del documento %2 no tiene ninguna orden asociada';
    begin
        TESTFIELD(Type, Type::Item);
        AssemblyHeader.RESET;
        AssemblyHeader.SETRANGE("Document Type", AssemblyLine."Document Type");
        AssemblyHeader.SETRANGE("Associated Order No.", AssemblyLine."Document No.");
        AssemblyHeader.SETRANGE("Associated Order Line", AssemblyLine."Line No.");
        IF AssemblyHeader.FINDFIRST THEN Numero:=AssemblyHeader."No."
        ELSE
            Numero:='';
    end;
    procedure ShowHasTracking(): Boolean var
        ReservationEntry: Record 337;
    begin
        ReservationEntry.RESET;
        //ReservationEntry.SETCURRENTKEY("Source ID","Source Ref. No.","Source Type","Source Subtype","Source Batch Name","Source Prod. Order Line","Reservation Status","Shipment Date","Expected Receipt Date");
        ReservationEntry.SETRANGE("Source ID", Rec."Document No.");
        ReservationEntry.SETRANGE("Source Ref. No.", "Line No.");
        ReservationEntry.SETRANGE("Source Type", DATABASE::"Assembly Line");
        ReservationEntry.SETRANGE("Source Subtype", "Document Type");
        ReservationEntry.SETRANGE("Source Batch Name", '');
        ReservationEntry.SETRANGE("Source Prod. Order Line", 0);
        ReservationEntry.SETRANGE("Item No.", "No.");
        ReservationEntry.SETRANGE("Variant Code", "Variant Code");
        EXIT(ReservationEntry.FINDFIRST);
    end;
    local procedure GetItemResource()
    begin
        IF Type = Type::Item THEN IF Item."No." <> "No." THEN Item.GET("No.");
        IF Type = Type::Resource THEN IF Resource."No." <> "No." THEN Resource.GET("No.");
    end;
    local procedure GetUnitStdCost(): Decimal var
        UnitCost: Decimal;
    begin
        //-- #9766
        GetItemResource;
        CASE Type OF Type::Item: IF GetSKU THEN UnitCost:=StockkeepingUnit."Standard Cost" * "Qty. per Unit of Measure"
            ELSE
                UnitCost:=Item."Standard Cost" * "Qty. per Unit of Measure";
        Type::Resource: UnitCost:=Resource."Unit Cost" * "Qty. per Unit of Measure";
        END;
        EXIT(RoundUnitAmount(UnitCost));
    //++ #9766
    end;
    local procedure RoundUnitAmount(UnitAmount: Decimal): Decimal begin
        GetGLSetup;
        EXIT(ROUND(UnitAmount, GLSetup."Unit-Amount Rounding Precision"));
    end;
    local procedure GetGLSetup()
    begin
        IF NOT GLSetupRead THEN BEGIN
            GLSetup.GET;
            GLSetupRead:=TRUE END end;
    local procedure GetSKU(): Boolean begin
        IF Type = Type::Item THEN IF(StockkeepingUnit."Location Code" = "Location Code") AND (StockkeepingUnit."Item No." = "No.") AND (StockkeepingUnit."Variant Code" = "Variant Code")THEN EXIT(TRUE);
        IF StockkeepingUnit.GET("Location Code", "No.", "Variant Code")THEN EXIT(TRUE);
        EXIT(FALSE);
    end;
    local procedure MinValue(Value: Decimal; Value2: Decimal): Decimal begin
        IF Value < Value2 THEN EXIT(Value);
        EXIT(Value2);
    end;
}
