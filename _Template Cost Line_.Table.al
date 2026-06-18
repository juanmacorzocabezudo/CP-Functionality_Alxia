table 50028 "Template Cost Line"
{
    // #9862 - Se crea la tabla nueva
    Caption = 'Template Cost Line';

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
        field(10; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(11; "Type Coste"; Option)
        {
            Caption = 'Type Coste';
            OptionCaption = '%,Eur';
            OptionMembers = "%", Eur;
        }
        field(12; Value; Decimal)
        {
            Caption = 'Value';
        }
        field(13; "Apply on all cost"; Boolean)
        {
            Caption = 'Apply on all cost';

            trigger OnValidate()
            var
                TemplateCostLine: Record 50028;
                TextApplyControl: Label 'The cost %1 for the template %2 already has this field marked, ther is only one cost for template';
            begin
                IF "Apply on all cost" THEN BEGIN
                    TemplateCostLine.RESET;
                    TemplateCostLine.SETRANGE("No. Template", Rec."No. Template");
                    TemplateCostLine.SETFILTER("No. Cost", '<>%1', Rec."No. Cost");
                    TemplateCostLine.SETRANGE("Apply on all cost", TRUE);
                    IF TemplateCostLine.FINDFIRST THEN ERROR(TextApplyControl, TemplateCostLine."No. Cost", TemplateCostLine."No. Template");
                END;
            end;
        }
    }
    keys
    {
        key(Key1; "No. Template", "No. Cost")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
