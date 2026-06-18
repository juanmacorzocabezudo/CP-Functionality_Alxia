table 50024 "BOM Version Header"
{
    // #9862 - Se crea la tabla nueva
    // #9993 - Se crea el campo comentario
    Caption = 'BOM Version Header';

    fields
    {
        field(1; "Item No."; Code[20])
        {
            Caption = 'Item No.';

            trigger OnValidate()
            var
                Item: Record Item;
            begin
            end;
        }
        field(2; "BOM Version"; Integer)
        {
            Caption = 'BOM Version';
        }
        field(3; Description; Text[100])
        {
            Caption = 'Description';
            Editable = false;
        }
        field(4; "Base Unit of Measure"; Code[10])
        {
            Caption = 'Base Unit of Measure';
            TableRelation = "Unit of Measure";
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                UnitOfMeasure: Record "Unit of Measure";
            begin
            end;
        }
        field(5; "Lote Receta"; Integer)
        {
        }
        field(6; "Statistics Lot"; Decimal)
        {
            Caption = 'Statistics Lot';
            Description = '#9862';
        }
        field(7; "Statistics Unit of Measurement"; Code[10])
        {
            Caption = 'Statistics Unit of Measurement';
            Description = '#9862';
            TableRelation = "Unit of Measure".Code;
        }
        field(10; "Version Date"; Date)
        {
            Caption = 'Version Date';
        }
        field(20; Comment; Text[250])
        {
            Caption = 'Comment';
            Description = '#9993';
        }
        field(30; StandarCost; Decimal)
        {
        }
        field(40; UnitCost; Decimal)
        {
        }
        field(45; CosteLMFijado; Decimal)
        {
        }
        field(50; CostesGenerales; Decimal)
        {
        }
        field(60; ExWork; Decimal)
        {
        }
    }
    keys
    {
        key(Key1; "Item No.", "BOM Version")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
