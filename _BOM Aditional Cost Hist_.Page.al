page 50060 "BOM Aditional Cost Hist"
{
    ApplicationArea = All;
    Caption = 'BOM Aditional Cost Hist';
    PageType = List;
    SourceTable = "BOM Aditional Cost";
    UsageCategory = Administration;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No. Cost"; Rec."No. Cost")
                {
                }
                field("Description Cost"; Rec."Description Cost")
                {
                }
                field("Type Coste"; Rec."Type Coste")
                {
                }
                field(Value; Rec.Value)
                {
                }
                field("Apply on all cost"; Rec."Apply on all cost")
                {
                }
                field("Aditional fixed cost"; Rec."Aditional fixed cost")
                {
                    Caption = 'Costes Generales (FIJADO)';
                }
                field("Aditional standard cost"; Rec."Aditional standard cost")
                {
                    Caption = 'Costes Generales (RECETA)';
                    Style = Attention;
                    StyleExpr = TRUE;
                }
                field(AditionalCost; AsmInfoPaneMgt.CalcAditionalUnitCoste(Rec, TRUE))
                {
                    Caption = 'Costes Generales (PRODUCTO)';
                    Editable = false;
                    Style = StandardAccent;
                    StyleExpr = TRUE;
                }
                field(BenefitActualize; AsmInfoPaneMgt.CalcBeneficioActualizado(Rec))
                {
                    BlankZero = true;
                    Caption = 'Benefit Actualize';
                    StyleExpr = VarFormatBeneficio;
                }
                field(PerBenefitActualize; AsmInfoPaneMgt.CalcPerBeneficioActualizado(Rec))
                {
                    BlankZero = true;
                    Caption = '% Benefit Actualize';
                    StyleExpr = VarFormatBeneficio;
                }
                field("Aditional unit cost"; Rec."Aditional unit cost")
                {
                    Caption = 'Aditional unit cost (ORIGINAL)';
                    Style = Attention;
                    StyleExpr = TRUE;
                    Visible = false;
                }
                field(AditionalUnitCost; AsmInfoPaneMgt.CalcAditionalItemUnitCoste(Rec))
                {
                    Caption = 'Aditional unit cost (ACTUAL)';
                    Editable = false;
                    Style = StandardAccent;
                    StyleExpr = TRUE;
                    Visible = false;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnAfterGetRecord()
    begin
        //-- #9993
        GetFormatBeneficio;
    //++ #9993
    end;
    trigger OnDeleteRecord(): Boolean begin
        //-- #9993
        GetFormatBeneficio;
    //++ #9993
    end;
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean begin
        //-- #9993
        GetFormatBeneficio;
    //++ #9993
    end;
    trigger OnModifyRecord(): Boolean begin
        //-- #9993
        GetFormatBeneficio;
    //++ #9993
    end;
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //-- #9993
        GetFormatBeneficio;
    //++ #9993
    end;
    var AsmInfoPaneMgt: Codeunit AlxiaAssemblyInfoManagement;
    VarPerBeneficion: Decimal;
    VarFormatBeneficio: Text;
    local procedure GetFormatBeneficio()
    begin
        //-- #9993
        CLEAR(VarPerBeneficion);
        VarPerBeneficion:=AsmInfoPaneMgt.CalcPerBeneficioActualizado(Rec);
        VarFormatBeneficio:='';
        IF VarPerBeneficion <= 15 THEN VarFormatBeneficio:='UnFavorable'
        ELSE
        BEGIN
            IF(VarPerBeneficion <= 25)THEN VarFormatBeneficio:='Ambiguous'
            ELSE
                VarFormatBeneficio:='Favorable';
        END;
    //++ #9993
    end;
}
