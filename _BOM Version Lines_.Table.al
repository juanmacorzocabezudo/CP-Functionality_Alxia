table 50025 "BOM Version Lines"
{
    // #9862 - Se crea la tabla nueva
    Caption = 'BOM Version Lines';

    fields
    {
        field(1; "Parent Item No."; Code[20])
        {
            Caption = 'Parent Item No.';
            NotBlank = true;
            TableRelation = Item WHERE(Type=CONST(Inventory));
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,Item,Resource';
            OptionMembers = " ", Item, Resource;
        }
        field(4; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = IF(Type=CONST(Item))Item WHERE(Type=CONST(Inventory))
            ELSE IF(Type=CONST(Resource))Resource;
        }
        field(5; "Assembly BOM"; Boolean)
        {
            CalcFormula = Exist("BOM Component" WHERE(Type=CONST(Item), "Parent Item No."=FIELD("No.")));
            Caption = 'Assembly BOM';
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(7; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = IF(Type=CONST(Item))"Item Unit of Measure".Code WHERE("Item No."=FIELD("No."))
            ELSE IF(Type=CONST(Resource))"Resource Unit of Measure".Code WHERE("Resource No."=FIELD("No."));
        }
        field(8; "Quantity per"; Decimal)
        {
            Caption = 'Quantity per';
            DecimalPlaces = 0: 5;
            MinValue = 0;
        }
        field(9; Position; Code[10])
        {
            Caption = 'Position';
        }
        field(10; "Position 2"; Code[10])
        {
            Caption = 'Position 2';
        }
        field(11; "Position 3"; Code[10])
        {
            Caption = 'Position 3';
        }
        field(12; "Machine No."; Code[10])
        {
            Caption = 'Machine No.';
        }
        field(13; "Lead-Time Offset"; DateFormula)
        {
            Caption = 'Lead-Time Offset';
        }
        field(14; "BOM Description"; Text[100])
        {
            CalcFormula = Lookup(Item.Description WHERE("No."=FIELD("Parent Item No.")));
            Caption = 'BOM Description';
            Editable = false;
            FieldClass = FlowField;
        }
        field(20; "Resource Usage Type"; Option)
        {
            Caption = 'Resource Usage Type';
            OptionCaption = 'Direct,Fixed';
            OptionMembers = Direct, "Fixed";
        }
        field(5402; "Variant Code"; Code[50])
        {
            Caption = 'Variant Code';
            TableRelation = IF(Type=CONST(Item))"Item Variant".Code WHERE("Item No."=FIELD("No."));
        }
        field(5900; "Installed in Line No."; Integer)
        {
            Caption = 'Installed in Line No.';
        }
        field(5901; "Installed in Item No."; Code[20])
        {
            Caption = 'Installed in Item No.';
            TableRelation = IF(Type=CONST(Item))Item;
        }
        field(50000; "Cantidad por Lote"; Decimal)
        {
            Caption = 'Cantidad por Lote';
            DecimalPlaces = 0: 6;

            trigger OnValidate()
            var
                lt_producto: Record Item;
            begin
            end;
        }
        field(50001; "Importancia en Coste"; Decimal)
        {
            Caption = 'Importancia en Coste';
            Editable = false;
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
            OptionCaption = ' ,Person,Machine';
            OptionMembers = " ", Person, Machine;
        }
        field(50015; "Related Work Center"; Code[20])
        {
            Caption = 'Related Work Center';
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
        }
        field(50021; "Net Amount"; Decimal)
        {
            Caption = 'Net Amount';
            Description = '#9862';
            Editable = false;
        }
        field(90000; "BOM Version"; Integer)
        {
            Caption = 'BOM Version';
        }
    }
    keys
    {
        key(Key1; "Parent Item No.", "BOM Version", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; Type, "No.")
        {
        }
        key(Key3; "Parent Item No.", Type, TipoRecurso, Position)
        {
            SumIndexFields = "Coste Calculado";
        }
    }
    fieldgroups
    {
    }
    var Text000: Label '%1 cannot be component of itself.';
    Text001: Label 'You cannot insert item %1 as an assembly component of itself.';
    procedure CalcItemUnitCost(BOMComponent: Record "BOM Version Lines")ReturnItemUnitCost: Decimal var
        Item: Record Item;
        Resource: Record Resource;
    begin
        //-- #9862
        CLEAR(ReturnItemUnitCost);
        CASE BOMComponent.Type OF BOMComponent.Type::Item: BEGIN
            Item.RESET;
            IF Item.GET(BOMComponent."No.")THEN ReturnItemUnitCost:=Item."Unit Cost";
        END;
        BOMComponent.Type::Resource: BEGIN
            Resource.RESET;
            IF Resource.GET(BOMComponent."No.")THEN ReturnItemUnitCost:=Resource."Unit Cost";
        END;
        END;
        EXIT(ReturnItemUnitCost);
    //++ #9862
    end;
    procedure ReturnFormat(BOMVersionLines: Record "BOM Version Lines")ReturnText: Text var
        ItemLocal: Record Item;
    begin
        //-- #9804
        CLEAR(ReturnText);
        CASE BOMVersionLines.Type OF BOMVersionLines.Type::Item: BEGIN
            IF ItemLocal.GET(BOMVersionLines."No.")THEN BEGIN
                ItemLocal.CALCFIELDS("Assembly BOM");
                IF ItemLocal."Assembly BOM" THEN ReturnText:='Ambiguous';
            END;
        END;
        BOMVersionLines.Type::" ": BEGIN
            IF "Related Work Center" <> '' THEN ReturnText:='Strong';
        END;
        END;
    //++ #9804
    end;
    procedure ReturnFormatImportanciaCoste(BOMVersionLines: Record "BOM Version Lines")ReturnText: Text var
        TotalImportanciaCoste: Decimal;
        CalcImportanciaCoste: Decimal;
        BOMVersionLinesCheck: Record "BOM Version Lines";
    begin
        //-- #9804
        CLEAR(ReturnText);
        CLEAR(TotalImportanciaCoste);
        CLEAR(CalcImportanciaCoste);
        IF BOMVersionLines.Type <> BOMVersionLines.Type::" " THEN BEGIN
            BOMVersionLinesCheck.RESET;
            BOMVersionLinesCheck.SETRANGE("Parent Item No.", BOMVersionLines."Parent Item No.");
            IF BOMVersionLinesCheck.FINDSET THEN BEGIN
                REPEAT TotalImportanciaCoste:=TotalImportanciaCoste + BOMVersionLinesCheck."Importancia en Coste";
                UNTIL BOMVersionLinesCheck.NEXT = 0;
            END;
            IF TotalImportanciaCoste <> 0 THEN BEGIN
                CalcImportanciaCoste:=ROUND(((BOMVersionLines."Importancia en Coste" * 100) / TotalImportanciaCoste), 0.01);
            END;
            IF CalcImportanciaCoste > 10 THEN BEGIN
                ReturnText:='Unfavorable';
            END
            ELSE
            BEGIN
                IF CalcImportanciaCoste >= 5 THEN ReturnText:='Ambiguous'
                ELSE
                    ReturnText:='Favorable';
            END;
        END;
    //++ #9804
    end;
}
