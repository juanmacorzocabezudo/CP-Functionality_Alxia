page 50025 "Movimientos comisiones"
{
    // ADVANCE - Log de cambios
    // -----------------------------------------------------
    //   ADVANCE
    //   Fecha: 31-05-2016
    //   Técnico: JMAP
    //   Presupuesto: Proyecto I002670 - Cálculo de comisiones
    //   Modificación:
    // 
    //   Etiqueta: ADV001
    // -----------------------------------------------------
    Editable = false;
    PageType = List;
    SourceTable = "Movimientos comision";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = All;
                }
                field("Sales Person Name"; Rec."Sales Person Name")
                {
                    ApplicationArea = All;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = All;
                }
                field("Nombre Cliente"; Rec."Nombre Cliente")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Shipment No."; Rec."Shipment No.")
                {
                    ApplicationArea = All;
                }
                field("Shipment Line No."; Rec."Shipment Line No.")
                {
                    ApplicationArea = All;
                }
                field("Order No."; Rec."Order No.")
                {
                    ApplicationArea = All;
                }
                field("Order Line No."; Rec."Order Line No.")
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Descripción Producto"; Rec."Descripción Producto")
                {
                    ApplicationArea = All;
                }
                field(NoEvento; Rec.NoEvento)
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Commission %"; Rec."Commission %")
                {
                    ApplicationArea = All;
                }
                field("Comission Amount"; Rec."Comission Amount")
                {
                    ApplicationArea = All;
                }
                field(Deshecho; Rec.Deshecho)
                {
                    ApplicationArea = All;
                }
                field(ImporteCobradoLiq; Rec.ImporteCobradoLiq)
                {
                    ApplicationArea = All;
                }
                field(Liquidado; Rec.Liquidado)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(acc_CalcularImpLiqui)
            {
                ApplicationArea = All;
                Caption = 'Calcular imp. cobrado liquidable';
                Image = AmountByPeriod;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
            //RunObject = Report 50014;
            }
            action(acc_MarcarLiquidados)
            {
                ApplicationArea = All;
                Caption = 'Marcar Liquidado';
                Image = Approval;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    lfu_MarcarLiquidado(TRUE); //ADV001
                end;
            }
            action(acc_DescarMarcharLiquidados)
            {
                ApplicationArea = All;
                Caption = 'Descarmar Liquidado';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    lfu_MarcarLiquidado(FALSE); //ADV001
                end;
            }
        }
    }
    trigger OnInit()
    var
        lt_MovComision: Record "Movimientos comision";
    begin
    end;
    local procedure lfu_MarcarLiquidado(pb_ValorLiqu: Boolean)
    var
        lt_MovComision: Record "Movimientos comision";
    begin
        //ADV001 Inicio
        CurrPage.SETSELECTIONFILTER(lt_MovComision);
        IF lt_MovComision.FINDSET THEN REPEAT lt_MovComision.Liquidado:=pb_ValorLiqu;
                lt_MovComision.MODIFY;
            UNTIL lt_MovComision.NEXT = 0;
    //ADV001 Fin
    end;
}
