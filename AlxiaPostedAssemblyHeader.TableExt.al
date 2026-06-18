tableextension 50009 AlxiaPostedAssemblyHeader extends "Posted Assembly Header"
{
    fields
    {
        field(50000; NoEvento; Code[20])
        {
            Caption = 'Nº Evento';
            Description = 'ADV001';
            TableRelation = Evento;
        }
        field(50020; "Perc. Loss"; Decimal)
        {
            Caption = '% Loss';
            Description = '#9969';
        }
        field(50021; "Net Amount"; Decimal)
        {
            Caption = 'Net Amount';
            Description = '#9969';
            Editable = false;
        }
        field(50030; "Lot Quantity"; Decimal)
        {
            Caption = 'Lot Quantity';
            Description = '#9993';
            Editable = false;
        }
        field(50040; AGRALANivel; Text[30])
        {
            Description = '#22003';
        }
        field(50041; AGRALARecetaMadre; Text[50])
        {
            Description = '#22003';
            TableRelation = "Assembly Header"."No.";

            trigger OnLookup()
            var
                rlAssemblyHeader: Record "Assembly Header";
            begin
                //rlAssemblyHeader.SETRANGE("Document Type", Rec."Document Type");
                rlAssemblyHeader.SETRANGE("No.", Rec."No.");
                PAGE.RUN(900, rlAssemblyHeader);
            end;
        }
        field(50042; AGRALAFechaProduccion; Date)
        {
            Caption = 'Fecha producción';
            Description = '863';
        }
        field(50043; AGRALAFechaEntrega; Date)
        {
            Caption = 'Fecha entrega';
            Description = '863';
        }
        field(50044; "AGRALAFechaUltimaFabricación"; Date)
        {
            CalcFormula = Max("Posted Assembly Header"."Posting Date" WHERE("Item No."=FIELD("Item No.")));
            Caption = 'Fecha ultima fabricación';
            Description = '863';
            Editable = false;
            FieldClass = FlowField;

            trigger OnLookup()
            var
                rlPostedAssemblyHeader: Record "Posted Assembly Header";
                plPostedAssemblyOrders: Page "Posted Assembly Orders";
            begin
            end;
        }
        field(50045; AGRALASemana; Integer)
        {
            Caption = 'Semana';
            Description = '863';
            Editable = false;
        }
        field(50046; AGRALAParteReceta; Option)
        {
            Caption = 'Parte receta';
            Description = '863';
            OptionCaption = ' ,Impresa,En cronograma';
            OptionMembers = " ", Impresa, Cronograma;
        }
        field(50047; AGRALAObservaciones; Text[250])
        {
            Caption = 'Observaciones';
            Description = '863';
        }
        field(50048; AGRALAObservacionesIntern; Text[250])
        {
            Caption = 'Observaciones internas';
            Description = '915';
        }
        field(60000; "Cantidad Original"; Decimal)
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
        field(70000; "Associated Order"; Boolean)
        {
            Caption = 'Associated Order';
            Description = '#9627';
            Editable = false;
        }
        field(70001; "Associated Order No."; Code[20])
        {
            Caption = 'Asociado Pedido Nº';
            Description = '#9627';
            Editable = false;
        }
        field(70002; "Associated Order Line"; Integer)
        {
            Caption = 'Associated Order Line';
            Description = '#9627';
            Editable = false;
        }
        field(70004; "Associated Blocked"; Boolean)
        {
            Caption = 'Associated Blocked';
            Description = '#9627';
        }
        field(70005; "Associated First Order No."; Code[20])
        {
            Caption = 'Asociado Primer Pedido Nº';
            Description = '#9627';
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
    }
    var RowIdx: Option, MatCost, ResCost, ResOvhd, AsmOvhd, Total;
    procedure CalcTotalStdCost(var ExpCost: array[5]of Decimal): Decimal var
        GLSetup: Record 98;
        Resource: Record 156;
        PostedAssemblyLine: Record 911;
        DirectLineCost: Decimal;
    begin
        //-- #9766
        GLSetup.GET;
        PostedAssemblyLine.SETRANGE("Document No.", "No.");
        IF PostedAssemblyLine.FINDSET THEN REPEAT CASE PostedAssemblyLine.Type OF PostedAssemblyLine.Type::Item: ExpCost[RowIdx::MatCost]+=PostedAssemblyLine."Cost Std Amount";
                PostedAssemblyLine.Type::Resource: BEGIN
                    Resource.GET(PostedAssemblyLine."No.");
                    DirectLineCost:=ROUND(Resource."Direct Unit Cost" * PostedAssemblyLine."Quantity (Base)", GLSetup."Unit-Amount Rounding Precision");
                    ExpCost[RowIdx::ResCost]+=DirectLineCost;
                    ExpCost[RowIdx::ResOvhd]+=PostedAssemblyLine."Cost Std Amount" - DirectLineCost;
                END;
                END UNTIL PostedAssemblyLine.NEXT = 0;
        EXIT(ExpCost[RowIdx::MatCost] + ExpCost[RowIdx::ResCost] + ExpCost[RowIdx::ResOvhd]);
    //++ #9766
    end;
    procedure ShowAssemblyList()
    var
        BOMComponent: Record 90;
        Item: Record 27;
    begin
        TESTFIELD("Item No.");
        //BOMComponent.SETRANGE("Parent Item No.","Item No.");
        //PAGE.RUN(PAGE::"Assembly BOM",BOMComponent);
        Item.GET("Item No.");
        PAGE.RUN(50000, Item);
    end;
}
