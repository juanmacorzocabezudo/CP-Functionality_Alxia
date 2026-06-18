pageextension 50009 AlxiaAssemblyOrders extends "Assembly Orders"
{
    layout
    {
        modify("No.")
        {
            StyleExpr = StyleTextAsociado;
        }
        addafter("No.")
        {
            field("Associated Order No."; Rec."Associated Order No.")
            {
                ApplicationArea = All;
            }
            field("Associated First Order No."; Rec."Associated First Order No.")
            {
                ApplicationArea = All;
            }
        }
        addbefore("Remaining Quantity")
        {
            field(NoEvento; Rec.NoEvento)
            {
                ApplicationArea = All;
            }
            field("Cantidad Original"; Rec."Cantidad Original")
            {
                ApplicationArea = All;
            }
            field(Diferencia; Rec.Diferencia)
            {
                ApplicationArea = All;
                StyleExpr = StyleTextDiferencia;
            }
            field("Diferencia%"; Rec."Diferencia%")
            {
                ApplicationArea = All;
                StyleExpr = StyleTextDiferencia;
            }
            field(AGRALAFechaProduccion; Rec.AGRALAFechaProduccion)
            {
                ApplicationArea = All;
            //Visible = false;
            }
            field(AGRALAFechaEntrega; Rec.AGRALAFechaEntrega)
            {
                ApplicationArea = All;
            //Visible = false;
            }
            field(AGRALAFechaUltimaFabricación; Rec.AGRALAFechaUltimaFabricación)
            {
                ApplicationArea = All;
            //Visible = false;
            }
            field(AGRALASemana; Rec.AGRALASemana)
            {
                ApplicationArea = All;
            //Visible = false;
            }
            field(AGRALAParteReceta; Rec.AGRALAParteReceta)
            {
                Visible = false;
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    //++ AGRALA 863
                    CASE Rec.AGRALAParteReceta OF Rec.AGRALAParteReceta::Impresa: xgStyleParteReceta:='ambiguous';
                    Rec.AGRALAParteReceta::Cronograma: xgStyleParteReceta:='favorable';
                    END;
                //-- AGRALA 863
                end;
            }
            field(AGRALAObservaciones; Rec.AGRALAObservaciones)
            {
                ApplicationArea = All;
                Visible = false;
            }
            field(AGRALAObservacionesIntern; Rec.AGRALAObservacionesIntern)
            {
                ApplicationArea = All;
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        //++ AGRALA 863
        CASE Rec.AGRALAParteReceta OF Rec.AGRALAParteReceta::Impresa: xgStyleParteReceta:='ambiguous';
        Rec.AGRALAParteReceta::Cronograma: xgStyleParteReceta:='favorable';
        END;
    //-- AGRALA 863
    end;
    trigger OnAfterGetRecord()
    var
        /*  xlrecetamadre: Boolean;
         xlNivel: Text;
         xlPedidoEnsNivel: Code[50];
         rlAssemblyHeaderMADRE: Record 900;
         rlAssemblyLine01: Record 901;
         rlAssemblyLine02: Record 901;
         rlAssemblyLine03: Record 901;
         rlAssemblyLine04: Record 901;
         rlAssemblyLine05: Record 901;
         rlAssemblyHeader: Record 900;
         rlAssemblyHeader01: Record 900;
         rlAssemblyHeader02: Record 900;
         rlAssemblyHeader03: Record 900;
         rlAssemblyHeader04: Record 900;
         rlAssemblyHeader05: Record 900; */
        RecAssHdr: Record "Assembly Header";
    begin
        //++ KR
        StyleTextDiferencia:='Standard';
        IF Rec.Diferencia > 0 THEN StyleTextDiferencia:='Unfavorable'
        ELSE IF Rec.Diferencia < 0 THEN StyleTextDiferencia:='Favorable';
        RecAssHdr.Reset();
        RecAssHdr.SetRange("Document Type", Rec."Document Type"::Order);
        RecAssHdr.SetRange(Simulacion, false);
        RecAssHdr.SetRange("Associated Order No.", Rec."No.");
        if RecAssHdr.FindFirst()then StyleTextAsociado:='Strong'
        else
            StyleTextAsociado:='Standard';
    end;
    trigger OnOpenPage()
    begin
        Rec.SETRANGE(Simulacion, FALSE);
    end;
    var ItemAvailFormsMgt: Codeunit 353;
    //"//++ KR": Integer;
    StyleTextDiferencia: Text;
    xgStyleParteReceta: Text[50];
    StyleTextAsociado: Text;
}
