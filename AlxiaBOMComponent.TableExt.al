tableextension 50003 AlxiaBOMComponent extends "BOM Component"
{
    fields
    {
        field(50000; "Cantidad por Lote"; Decimal)
        {
            Caption = 'Cantidad por Lote';
            DecimalPlaces = 0: 6;

            trigger OnValidate()
            var
                lt_producto: Record Item;
            begin
                lt_producto.RESET;
                lt_producto.GET("Parent Item No.");
                lt_producto.TESTFIELD(lt_producto."Lote Receta");
                IF(Type = Type::Resource) AND ("Resource Usage Type" = "Resource Usage Type"::Fixed)THEN BEGIN
                    VALIDATE("Quantity per", "Cantidad por Lote");
                //  VALIDATE("Cantidad por Bandeja","Quantity per");
                END
                ELSE
                BEGIN
                    // lt_producto.TESTFIELD("Lote Unitario");
                    VALIDATE("Quantity per", "Cantidad por Lote" / lt_producto."Lote Receta");
                // VALIDATE("Cantidad por Bandeja","Quantity per" * lt_producto."Lote Unitario");
                END;
                //-- #9862
                VALIDATE("Net Amount");
            //++ #9862
            end;
        }
        field(50001; "Importancia en Coste"; Decimal)
        {
            Caption = 'Importancia en Coste';
            Editable = false;

            trigger OnValidate()
            var
                ItemLocal: Record Item;
                AssemblyInfoPaneManagement: Codeunit AlxiaFuncionesImportadas;
                CosteProducto: Decimal;
            begin
                //-- #9993
                ItemLocal.RESET;
                ItemLocal.SETRANGE("No.", Rec."Parent Item No.");
                IF ItemLocal.FINDFIRST THEN BEGIN
                    //IF (ItemLocal."Lote Receta" <> 0) AND (ItemLocal."Standard Cost" <> 0) THEN BEGIN
                    CosteProducto:=AssemblyInfoPaneManagement.CalcItemCosteCalculado(ItemLocal, FALSE);
                    IF(CosteProducto <> 0)THEN BEGIN
                        CASE Type OF Type::Item: "Importancia en Coste":="Quantity per" * CosteUnitario / CosteProducto * 100;
                        Type::Resource: "Importancia en Coste":="Quantity per" * CosteUnitario / CosteProducto * 100;
                        ELSE
                            "Importancia en Coste":=0;
                        END;
                    END
                    ELSE
                    BEGIN
                        "Importancia en Coste":=0;
                    END;
                END
                ELSE
                BEGIN
                    "Importancia en Coste":=0;
                END;
            //++ #9993
            end;
        }
        field(50002; "Cantidad por Bandeja"; Decimal)
        {
            Enabled = false;
        }
        field(50003; "Proveedor por Defecto"; Code[20])
        {
            CalcFormula = Lookup(Item."Vendor No." WHERE("No."=FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50004; CosteUnitario; Decimal)
        {
            Caption = 'Coste Unitario';
            Description = '#9993 Se cambia el nombre en ESP';
            Editable = false;

            trigger OnValidate()
            begin
                //-- #9993
                VALIDATE("Importancia en Coste");
            //++ #9993
            end;
        }
        field(50005; Comentario; Text[80])
        {
        }
        field(50007; "Coste Calculado"; Decimal)
        {
            Editable = false;
        }
        field(50010; TipoRecurso; Option)
        {
            Caption = 'Tipo Recurso';
            Editable = false;
            OptionCaption = ' ,Persona,Maquina';
            OptionMembers = " ", Person, Machine;
        }
        field(50015; "Related Work Center"; Code[20])
        {
            Caption = 'No. Centro trabajo';
            Description = '#9785';
            Editable = false;
            TableRelation = "Work center Header"."No.";
        }
        field(50016; Maquila; Boolean)
        {
            Caption = 'Maquila';
        }
        field(50020; "Perc. Loss"; Decimal)
        {
            Caption = '% Loss';
            Description = '#9862';

            trigger OnValidate()
            begin
                //-- #9862
                VALIDATE("Net Amount");
            //++ #9862
            end;
        }
        field(50021; "Net Amount"; Decimal)
        {
            Caption = 'Net Amount';
            Description = '#9862';
            Editable = false;

            trigger OnValidate()
            begin
                //-- #9862
                "Net Amount":=Rec."Cantidad por Lote" - (Rec."Cantidad por Lote" * Rec."Perc. Loss") / 100;
            //++ #9862
            end;
        }
        field(50030; "Parent Item Desciption"; Text[100])
        {
            CalcFormula = Lookup(Item.Description WHERE("No."=FIELD("Parent Item No.")));
            Caption = 'Parent Item Description';
            Description = '#9993';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50110; CentroTrabajo; Code[20])
        {
            Caption = 'Centro de trabajo';
            TableRelation = "Work center Header"."No.";
        }
        field(50111; "Codigo Punto Observacion"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Código punto de Observación';
            TableRelation = PuntosdeObservaciones;
        }
        field(50112; "Codigo Punto Control"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Código punto de control';
            TableRelation = PuntosdeControl;
        }
        field(50113; "Inventory Item No."; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Inventory item no.', comment = 'ESP="Inventario n° artículo"';
            Editable = false;
            Description = 'GAP00040';
        }
        field(50114; "Critical Item No."; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Critical item no.', comment = 'ESP="N° artículo crítico"';
            Editable = false;
            Description = 'GAP00040';
        }
        modify("No.")
        {
        trigger OnAfterValidate()
        begin
            TESTFIELD(Type);
            "Variant Code":='';
            TipoRecurso:=TipoRecurso::" "; //ADV001
            IF "No." = '' THEN EXIT;
            CASE Type OF Type::Item: BEGIN
                Item.GET("No.");
                ValidateAgainstRecursion("No.");
                Item.CALCFIELDS("Assembly BOM");
                "Assembly BOM":=Item."Assembly BOM";
                Description:=Item.Description;
                "Unit of Measure Code":=Item."Base Unit of Measure";
                //-- #9766
                //CosteUnitario := Item."Unit Cost";        //ADV001
                //-- #10652
                //CosteUnitario := Item."Standard Cost";
                CosteUnitario:=Item."Standard Cost" * GetUnitOfMeasurmentPer(Rec."No.", Rec."Unit of Measure Code");
                //++ #10652
                //++ #9766
                //-- #9993
                VALIDATE("Importancia en Coste");
                //++ #9993
                //-- #9862
                VALIDATE("Perc. Loss", Item."Perc. Loss");
                //++ #9862
                ParentItem.GET("Parent Item No.");
                CalcLowLevelCode.SetRecursiveLevelsOnItem(Item, ParentItem."Low-Level Code" + 1, TRUE);
                Item.FIND;
                ParentItem.FIND;
                IF ParentItem."Low-Level Code" >= Item."Low-Level Code" THEN ERROR(Text001, "No.");
            END;
            Type::Resource: BEGIN
                Res.GET("No.");
                "Assembly BOM":=FALSE;
                Description:=Res.Name;
                "Unit of Measure Code":=Res."Base Unit of Measure";
                #pragma warning disable AL0603
                TipoRecurso:=Res.Type + 1; //ADV001
                #pragma warning restore AL0603
                CosteUnitario:=Res."Unit Cost"; //ADV001
                //-- #9993
                VALIDATE("Importancia en Coste");
            //++ #9993
            END;
            END;
            //++ KR
            ActualizarCosteCalculado();
        //--
        end;
        }
        modify("Quantity per")
        {
        trigger OnAfterValidate()
        begin
            //-- #9993
            ActualizarCosteCalculado();
            VALIDATE("Importancia en Coste");
        //++ #9993
        end;
        }
        modify("Unit of Measure Code")
        {
        trigger OnAfterValidate()
        var
            ItemLocal: Record Item;
        begin
            //-- #10652
            CASE Type OF Type::Item: BEGIN
                ItemLocal.GET("No.");
                CosteUnitario:=ItemLocal."Standard Cost" * GetUnitOfMeasurmentPer(Rec."No.", Rec."Unit of Measure Code");
            END;
            END;
            ActualizarCosteCalculado();
            VALIDATE("Importancia en Coste");
        //++ #10652
        end;
        }
        modify("Variant Code")
        {
        Caption = 'Marca';
        TableRelation = if(Type=const(Item))"Item Variant".Code where("Item No."=field("No."), Blocked=const(false));
        }
    }
    procedure GetUnitOfMeasurmentPer(VarItemNo: Code[20]; VarUnitOfMeasurmentCode: Code[10])ReturnFactor: Decimal var
        ItemUnitofMeasure: Record "Item Unit of Measure";
    begin
        //-- #10652
        CLEAR(ReturnFactor);
        ItemUnitofMeasure.RESET;
        ItemUnitofMeasure.SETRANGE("Item No.", VarItemNo);
        ItemUnitofMeasure.SETRANGE(Code, VarUnitOfMeasurmentCode);
        IF ItemUnitofMeasure.FINDFIRST THEN ReturnFactor:=ItemUnitofMeasure."Qty. per Unit of Measure"
        ELSE
            ReturnFactor:=1;
    //++ #10652
    end;
    procedure CalcItemUnitCost(BOMComponent: Record "BOM Component"): Decimal var
        Item: Record Item;
        Resource: Record Resource;
    begin
        //-- #9766
        CASE BOMComponent.Type OF BOMComponent.Type::Item: BEGIN
            Item.RESET;
            IF Item.GET(BOMComponent."No.")THEN EXIT(Item."Unit Cost");
        END;
        BOMComponent.Type::Resource: BEGIN
            Resource.RESET;
            IF Resource.GET(BOMComponent."No.")THEN EXIT(Resource."Unit Cost");
        END;
        END;
        EXIT(0);
    //++ #9766
    end;
    procedure ReturnFormat(BOMComponent: Record "BOM Component")ReturnText: Text var
        ItemLocal: Record Item;
    begin
        //-- #9804
        CLEAR(ReturnText);
        CASE BOMComponent.Type OF BOMComponent.Type::Item: BEGIN
            IF ItemLocal.GET(BOMComponent."No.")THEN BEGIN
                ItemLocal.CALCFIELDS("Assembly BOM");
                IF ItemLocal."Assembly BOM" THEN ReturnText:='StrongAccent';
            END;
        END;
        BOMComponent.Type::" ": BEGIN
            IF "Related Work Center" <> '' THEN ReturnText:='Strong';
        END;
        END;
    //++ #9804
    end;
    procedure ReturnFormatImportanciaCoste(BOMComponent: Record "BOM Component")ReturnText: Text var
        TotalImportanciaCoste: Decimal;
        CalcImportanciaCoste: Decimal;
        BOMComponentCheck: Record "BOM Component";
    begin
        //-- #9804
        CLEAR(ReturnText);
        CLEAR(TotalImportanciaCoste);
        CLEAR(CalcImportanciaCoste);
        IF BOMComponent.Type <> BOMComponent.Type::" " THEN BEGIN
            /*BOMComponentCheck.RESET;
            BOMComponentCheck.SETRANGE("Parent Item No.", BOMComponent."Parent Item No.");
            IF BOMComponentCheck.FINDSET THEN BEGIN
               REPEAT
                 TotalImportanciaCoste := TotalImportanciaCoste + BOMComponentCheck."Importancia en Coste";
               UNTIL BOMComponentCheck.NEXT = 0;
            END;

            IF TotalImportanciaCoste <> 0 THEN BEGIN
               CalcImportanciaCoste := ROUND(((BOMComponent."Importancia en Coste") / TotalImportanciaCoste),0.01);
            END;*/
            CalcImportanciaCoste:=BOMComponent."Importancia en Coste" / 100;
            IF CalcImportanciaCoste >= 0.66 THEN BEGIN
                ReturnText:='Unfavorable';
            END
            ELSE
            BEGIN
                IF CalcImportanciaCoste >= 0.33 THEN ReturnText:='Ambiguous'
                ELSE
                    ReturnText:='Favorable';
            END;
        END;
    //++ #9804
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
    local procedure GetLasLineBomEvento(ParentItemNo: Code[20]; CodigoEvento: Code[20])ReturnLineNo: Integer var
        EveComponent: Record "Componentes Evento";
    begin
        //-- #9785
        CLEAR(ReturnLineNo);
        EveComponent.RESET;
        EveComponent.SETRANGE("Parent Item No.", ParentItemNo);
        EveComponent.SetRange("Codigo Evento", CodigoEvento);
        IF EveComponent.FINDLAST THEN ReturnLineNo:=EveComponent."Line No.";
        EXIT(ReturnLineNo);
    //++ #9785
    end;
    procedure InsertLinesFromWorkCenterEvento(ParentItemNo: Code[20]; WorkCenterNo: Code[20]; CodigoEvento: Code[20]; LineaEvento: Integer)
    var
        WorkcenterHeader: Record 50022;
        WorkCenterLine: Record 50023;
        BOMComponent: Record "Componentes Evento";
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
                VarLineNo:=GetLasLineBomEvento(ParentItemNo, CodigoEvento);
                VarLineNo:=VarLineNo + 10000;
                BOMComponent.INIT;
                BOMComponent.VALIDATE("Parent Item No.", ParentItemNo);
                BOMComponent."Codigo Evento":=CodigoEvento;
                BOMComponent."Linea Evento":=LineaEvento;
                BOMComponent.VALIDATE("Line No.", VarLineNo);
                BOMComponent.VALIDATE(Type, BOMComponent.Type::" ");
                BOMComponent.VALIDATE(Description, WorkcenterHeader.Description);
                BOMComponent.VALIDATE("Related Work Center", WorkCenterNo);
                BOMComponent.INSERT(TRUE);
                REPEAT //** Se introduce las lineas del centro de trabajo
                    //CLEAR(VarLineNo);
                    //VarLineNo := GetLasLineBomEvento(ParentItemNo, CodigoEvento);
                    VarLineNo:=VarLineNo + 10000;
                    BOMComponent.INIT;
                    BOMComponent.VALIDATE("Parent Item No.", ParentItemNo);
                    BOMComponent.VALIDATE("Line No.", VarLineNo);
                    BOMComponent."Codigo Evento":=CodigoEvento;
                    BOMComponent."Linea Evento":=LineaEvento;
                    BOMComponent.VALIDATE(Type, BOMComponent.Type::Resource);
                    BOMComponent.VALIDATE("No.", WorkCenterLine."No.");
                    BOMComponent."Unit of Measure Code":=WorkCenterLine."Unit of Mesaruement";
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
    local procedure ActualizarCosteCalculado()
    begin
        "Coste Calculado":="Quantity per" * CosteUnitario;
    end;
    var Item: Record Item;
    ParentItem: Record Item;
    CalcLowLevelCode: Codeunit 99000793;
    Res: Record 156;
    Text001: Label 'No puede insertar el elemento %1 como un componente de ensamblaje de sí mismo.';
}
