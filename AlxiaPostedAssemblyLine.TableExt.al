tableextension 50026 AlxiaPostedAssemblyLine extends "Posted Assembly Line"
{
    fields
    {
        field(50000; "Cantidad por Lote"; Decimal)
        {
            Caption = 'Cantidad por Lote';
            DecimalPlaces = 0: 6;
            Description = '#9993';
            Editable = false;
        /* 
                        trigger OnValidate()
                        var
                            lt_producto: Record 27;
                        begin
                        end; */
        }
        field(50001; Comentario; Text[250])
        {
        }
        field(50005; AGRALACentroCoste; Text[250])
        {
            Caption = 'Centro de coste';
            Description = '#22003';
        }
        field(50015; "Related Work Center"; Code[20])
        {
            Caption = 'No. Centro trabajo';
            Description = '#9785';
            Editable = false;
        }
        field(50020; "Perc. Loss"; Decimal)
        {
            Caption = '% Merma';
            Description = '#9969';
        }
        field(50021; "Net Amount"; Decimal)
        {
            Caption = 'Net Amount';
            Description = '#9969';
            Editable = false;
        }
        field(50030; AGRALAResponsable; Text[30])
        {
            Caption = 'Responsable';
            Description = '#22003';
        }
        field(50040; AGRALANivel; Text[30])
        {
            CalcFormula = Lookup("Posted Assembly Header".AGRALANivel WHERE("No."=FIELD("Document No.")));
            Caption = 'Nivel';
            Description = '#22003';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50041; AGRALARecetaMadre; Text[50])
        {
            CalcFormula = Lookup("Posted Assembly Header".AGRALARecetaMadre WHERE("No."=FIELD("Document No.")));
            Caption = 'Receta madre';
            Description = '#22003';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Assembly Header"."No.";

            trigger OnLookup()
            var
                rlAssemblyHeader: Record 910;
            begin
                //rlAssemblyHeader.SETRANGE("Document Type", Rec."Document Type");
                rlAssemblyHeader.SETRANGE("Associated Order No.", Rec.AGRALARecetaMadre);
                IF rlAssemblyHeader.FINDSET THEN PAGE.RUN(920, rlAssemblyHeader)
                ELSE
                BEGIN
                    rlAssemblyHeader.RESET;
                    rlAssemblyHeader.SETRANGE("Order No.", Rec.AGRALARecetaMadre);
                    PAGE.RUN(920, rlAssemblyHeader);
                END;
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
    }
}
