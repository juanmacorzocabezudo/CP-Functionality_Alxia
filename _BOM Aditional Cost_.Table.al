table 50029 "BOM Aditional Cost"
{
    // #9862 - Se crea la tabla nueva
    Caption = 'BOM Aditional Cost';

    fields
    {
        field(1; "No. Template"; Code[10])
        {
            Caption = 'No. Template';
            TableRelation = "Template Cost Header";
        }
        field(2; "No. Cost"; Code[10])
        {
            Caption = 'No. Cost';
        }
        field(3; "Item No"; Code[20])
        {
            Caption = 'Item No';
            TableRelation = Item;
        }
        field(4; "BOM Version"; Integer)
        {
            Caption = 'BOM Version';
        }
        field(10; "Description Cost"; Text[30])
        {
            Caption = 'Description Cost';
        }
        field(11; "Type Coste"; Option)
        {
            Caption = 'Type Coste';
            OptionCaption = '%,Eur';
            OptionMembers = "%", Eur;

            trigger OnValidate()
            begin
                VALIDATE("Aditional standard cost");
                VALIDATE("Aditional unit cost");
                VALIDATE("Aditional fixed cost");
            end;
        }
        field(12; Value; Decimal)
        {
            Caption = 'Value';

            trigger OnValidate()
            begin
                VALIDATE("Aditional standard cost");
                VALIDATE("Aditional unit cost");
                VALIDATE("Aditional fixed cost");
            end;
        }
        field(13; "Apply on all cost"; Boolean)
        {
            Caption = 'Apply on all cost';

            trigger OnValidate()
            var
                BOMAditionalCost: Record 50029;
                TextApplyControl: Label 'The cost %1 for the item %2 already has this field marked, ther is only one cost for template';
            begin
                IF "Apply on all cost" THEN BEGIN
                    BOMAditionalCost.RESET;
                    BOMAditionalCost.SETRANGE("Item No", Rec."Item No");
                    BOMAditionalCost.SETRANGE("BOM Version", Rec."BOM Version");
                    BOMAditionalCost.SETFILTER("No. Cost", '<>%1', Rec."No. Cost");
                    BOMAditionalCost.SETRANGE("Apply on all cost", TRUE);
                    IF BOMAditionalCost.FINDFIRST THEN ERROR(TextApplyControl, BOMAditionalCost."No. Cost", BOMAditionalCost."Item No");
                END;
                VALIDATE("Aditional standard cost");
                VALIDATE("Aditional unit cost");
                VALIDATE("Aditional fixed cost");
            end;
        }
        field(14; "Amount Item Cost"; Decimal)
        {
            Caption = 'Amount Item Cost';
        }
        field(15; "Amount Unit Cost"; Decimal)
        {
            Caption = 'Amount Unit Cost';
        }
        field(20; "Aditional standard cost"; Decimal)
        {
            Caption = 'Aditional standard cost';
            Editable = false;

            trigger OnValidate()
            begin
                "Aditional standard cost":=AsmInfoPaneMgt.CalcAditionalUnitCoste(Rec, FALSE);
            end;
        }
        field(21; "Aditional unit cost"; Decimal)
        {
            Caption = 'Aditional unit cost';
            Editable = false;

            trigger OnValidate()
            begin
                "Aditional unit cost":=AsmInfoPaneMgt.CalcAditionalItemUnitCoste(Rec);
            end;
        }
        field(22; "Aditional fixed cost"; Decimal)
        {
            trigger OnValidate()
            begin
                "Aditional fixed cost":=AsmInfoPaneMgt.CalcAditionalFixedCoste(Rec);
            end;
        }
    }
    keys
    {
        key(Key1; "Item No", "BOM Version", "No. Cost")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnDelete()
    begin
        Item.GET("Item No");
        IF Item."Status LM" <> Item."Status LM"::"Under Construction" THEN ERROR('Solo se permiten borrar lineas en LM en construccion');
    end;
    trigger OnInsert()
    begin
        Item.GET("Item No");
        IF Item."Status LM" <> Item."Status LM"::"Under Construction" THEN ERROR('Solo se permiten intrudicir lineas en LM en construccion');
    end;
    trigger OnModify()
    begin
        Item.GET("Item No");
        IF Item."Status LM" <> Item."Status LM"::"Under Construction" THEN ERROR('Solo se permiten modificar LM en construccion');
    end;
    var AsmInfoPaneMgt: Codeunit AlxiaAssemblyInfoManagement;
    Text001: Label '&Top level,&All levels';
    Item: Record 27;
    procedure ActualicyCostOld(VarItemNo: Code[20]; VarBOMVersion: Integer)
    var
        BOMAditionalCost: Record 50029;
        TextActualicyCost: Label 'Do you want to update the lines?';
        BOMComponent: Record 90;
        estado: Integer;
        CalculateStdCost: Codeunit AlxiaCalculateStandardCost;
        VarItemLocal: Record 27;
        VarDepth: Integer;
        VarAssemblyContainsProdBOM: Boolean;
        VarNewCalcMultiLevel: Boolean;
        VarInstruction: Text[1024];
    begin
        //++ KR 06/07/21
        Item.GET(VarItemNo);
        estado:=Item."Status LM";
        IF Item."Status LM" <> Item."Status LM"::"Under Construction" THEN BEGIN
            Item."Status LM":=Item."Status LM"::"Under Construction";
            Item.MODIFY;
        END;
        /*BOMComponent.RESET;
        BOMComponent.SETRANGE("Parent Item No.", VarItemNo);
        IF BOMComponent.FINDFIRST THEN
        REPEAT
          BOMComponent.VALIDATE(CosteUnitario, BOMComponent.CalcItemStandardCost(BOMComponent));
          BOMComponent.MODIFY(TRUE);
        UNTIL BOMComponent.NEXT = 0;*/
        //-- #10777
        CLEAR(VarDepth);
        CLEAR(VarAssemblyContainsProdBOM);
        CLEAR(VarNewCalcMultiLevel);
        CLEAR(VarInstruction);
        //++ #10777
        //-- #9804
        CLEAR(CalculateStdCost);
        //-- #10777
        VarItemLocal.GET(VarItemNo);
        VarDepth:=2;
        /*VarInstruction := CalculateStdCost.PrepareAssemblyCalculation(VarItemLocal, VarDepth, 1, VarAssemblyContainsProdBOM);
        IF (VarDepth > 1) THEN
           CASE STRMENU(Text001,1, VarInstruction) OF
            0:
              EXIT;
            1:
              VarNewCalcMultiLevel := FALSE;
            2:
              VarNewCalcMultiLevel := TRUE;
          END;*/
        VarNewCalcMultiLevel:=FALSE;
        CalculateStdCost.GetCalcItemParameters(TRUE, VarDepth, VarAssemblyContainsProdBOM, VarNewCalcMultiLevel);
        //++ #10777
        CalculateStdCost.CalcItem(VarItemNo, TRUE);
        //++ #9804
        Item.GET(VarItemNo);
        IF Item."Status LM" <> estado THEN BEGIN
            Item."Status LM":=estado;
            Item.MODIFY;
        END;
        //--
        //Item.GET(Rec."Item No");
        Item.SetFijarCosteLMRecetaEnFichaArticulo;
        BOMAditionalCost.RESET;
        BOMAditionalCost.SETRANGE("Item No", VarItemNo);
        BOMAditionalCost.SETRANGE("BOM Version", VarBOMVersion);
        IF BOMAditionalCost.FINDSET THEN BEGIN
            REPEAT BOMAditionalCost.VALIDATE(Value);
                BOMAditionalCost.MODIFY;
            UNTIL BOMAditionalCost.NEXT = 0;
        END;
        //AGRALAMO - 412
        /*IF VarNewCalcMultiLevel THEN BEGIN
        BOMComponent.RESET;
        BOMComponent.SETRANGE("Parent Item No.",Item."No.");
        BOMComponent.SETFILTER(Type,'<>%1',BOMComponent.Type::" ");
        BOMComponent.SETRANGE(Maquila, FALSE);
        IF BOMComponent.FINDSET THEN BEGIN
        Item.GET(BOMComponent."No.");
        Item.SetFijarCosteLMRecetaEnFichaArticulo;
        END;
        END;*/
        //AGRALAMO - 412
        //-- #9804 // Castañada, hay que recalcular para que actualice los costes generales
        CLEAR(CalculateStdCost);
        //-- #10777
        CalculateStdCost.GetCalcItemParameters(TRUE, VarDepth, VarAssemblyContainsProdBOM, VarNewCalcMultiLevel);
        //++ #10777
        CalculateStdCost.CalcItem(VarItemNo, TRUE);
    //++ #9804
    end;
    procedure ActualicyCost(VarItemNo: Code[20]; VarBOMVersion: Integer)
    var
        BOMAditionalCost: Record 50029;
        TextActualicyCost: Label 'Do you want to update the lines?';
        BOMComponent: Record 90;
        estado: Enum AlxiaStatusLM;
        CalculateStdCost2: Codeunit AlxiaCalculateStandardCost;
        VarItemLocal: Record 27;
        VarDepth: Integer;
        VarAssemblyContainsProdBOM: Boolean;
        VarNewCalcMultiLevel: Boolean;
        VarInstruction: Text[1024];
    begin
        //++ KR 06/07/21
        Item.GET(VarItemNo);
        estado:=Item."Status LM";
        IF Item."Status LM" <> Item."Status LM"::"Under Construction" THEN BEGIN
            Item."Status LM":=Item."Status LM"::"Under Construction";
            Item.MODIFY;
        END;
        /*BOMComponent.RESET;
        BOMComponent.SETRANGE("Parent Item No.", VarItemNo);
        IF BOMComponent.FINDFIRST THEN
        REPEAT
          BOMComponent.VALIDATE(CosteUnitario, BOMComponent.CalcItemStandardCost(BOMComponent));
          BOMComponent.MODIFY(TRUE);
        UNTIL BOMComponent.NEXT = 0;*/
        //-- #10777
        CLEAR(VarDepth);
        CLEAR(VarAssemblyContainsProdBOM);
        CLEAR(VarNewCalcMultiLevel);
        CLEAR(VarInstruction);
        //++ #10777
        //-- #9804
        CLEAR(CalculateStdCost2);
        //-- #10777
        VarItemLocal.GET(VarItemNo);
        VarDepth:=2;
        /*VarInstruction := CalculateStdCost.PrepareAssemblyCalculation(VarItemLocal, VarDepth, 1, VarAssemblyContainsProdBOM);
        IF (VarDepth > 1) THEN
           CASE STRMENU(Text001,1, VarInstruction) OF
            0:
              EXIT;
            1:
              VarNewCalcMultiLevel := FALSE;
            2:
              VarNewCalcMultiLevel := TRUE;
          END;*/
        VarNewCalcMultiLevel:=FALSE;
        CalculateStdCost2.GetCalcItemParameters(TRUE, VarDepth, VarAssemblyContainsProdBOM, VarNewCalcMultiLevel);
        //++ #10777
        CalculateStdCost2.CalcItem(VarItemNo, TRUE);
        //++ #9804
        Item.GET(VarItemNo);
        IF Item."Status LM" <> estado THEN BEGIN
            Item."Status LM":=estado;
            Item.MODIFY;
        END;
        //--
        //Item.GET(Rec."Item No");
        Item.SetFijarCosteLMRecetaEnFichaArticulo;
        BOMAditionalCost.RESET;
        BOMAditionalCost.SETRANGE("Item No", VarItemNo);
        BOMAditionalCost.SETRANGE("BOM Version", VarBOMVersion);
        IF BOMAditionalCost.FINDSET THEN BEGIN
            REPEAT BOMAditionalCost.VALIDATE(Value);
                BOMAditionalCost.MODIFY;
            UNTIL BOMAditionalCost.NEXT = 0;
        END;
        //AGRALAMO - 412
        /*IF VarNewCalcMultiLevel THEN BEGIN
        BOMComponent.RESET;
        BOMComponent.SETRANGE("Parent Item No.",Item."No.");
        BOMComponent.SETFILTER(Type,'<>%1',BOMComponent.Type::" ");
        BOMComponent.SETRANGE(Maquila, FALSE);
        IF BOMComponent.FINDSET THEN BEGIN
        Item.GET(BOMComponent."No.");
        Item.SetFijarCosteLMRecetaEnFichaArticulo;
        END;
        END;*/
        //AGRALAMO - 412
        //-- #9804 // Castañada, hay que recalcular para que actualice los costes generales
        CLEAR(CalculateStdCost2);
        //-- #10777
        CalculateStdCost2.GetCalcItemParameters(TRUE, VarDepth, VarAssemblyContainsProdBOM, VarNewCalcMultiLevel);
        //++ #10777
        CalculateStdCost2.CalcItem(VarItemNo, TRUE);
    //++ #9804
    end;
}
