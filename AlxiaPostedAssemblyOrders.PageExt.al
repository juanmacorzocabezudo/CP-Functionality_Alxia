pageextension 50017 AlxiaPostedAssemblyOrders extends "Posted Assembly Orders"
{
    layout
    {
        modify("No.")
        {
            StyleExpr = StyleTextAsociado;
        }
        modify("Due Date")
        {
            Visible = false;
        }
        modify("Starting Date")
        {
            Visible = false;
        }
        modify("Ending Date")
        {
            Visible = false;
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
        addafter(Description)
        {
            field(AGRALAFechaProduccion; Rec.AGRALAFechaProduccion)
            {
                ApplicationArea = All;
            }
        }
        addafter("Posting Date")
        {
            field(AGRALAFechaEntrega; Rec.AGRALAFechaEntrega)
            {
                ApplicationArea = All;
            }
        }
        addafter("Unit Cost")
        {
            field("Unit of Measure Code"; Rec."Unit of Measure Code")
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
            field(Comment; Rec.Comment)
            {
                ApplicationArea = All;
            }
            field(AGRALASemana; Rec.AGRALASemana)
            {
                ApplicationArea = All;
                Visible = false;
            }
            field(AGRALAParteReceta; Rec.AGRALAParteReceta)
            {
                ApplicationArea = All;
                Visible = false;
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
        addlast(content)
        {
            part(Lines;921)
            {
                ApplicationArea = All;
                SubPageLink = "Document No."=FIELD("No.");
            }
        }
        addafter(Control12)
        {
            part("Seg. receta niveles registrada";50081)
            {
                ApplicationArea = All;
                Caption = 'Seg. receta niveles registrada';
                SubPageLink = AGRALARecetaMadre=FIELD("Associated First Order No.");
            }
            part("Seg. receta madre registrada";50081)
            {
                ApplicationArea = All;
                Caption = 'Seg. receta madre registrada';
                SubPageLink = AGRALARecetaMadre=FIELD("Order No.");
            }
        }
    }
    actions
    {
        addafter(Comments)
        {
            action("Assembly BOM")
            {
                ApplicationArea = All;
                Caption = 'Receta';
                Image = AssemblyBOM;
                Promoted = true;

                trigger OnAction()
                begin
                    Rec.ShowAssemblyList;
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        RecAssHdr: Record "Posted Assembly Header";
    begin
        StyleTextDiferencia:='Standard';
        IF Rec.Diferencia < 0 THEN StyleTextDiferencia:='Unfavorable'
        ELSE IF Rec.Diferencia >= 0 THEN StyleTextDiferencia:='Favorable';
        RecAssHdr.Reset();
        RecAssHdr.SetRange("Associated Order No.", Rec."No.");
        if RecAssHdr.FindFirst()then StyleTextAsociado:='Strong'
        else
            StyleTextAsociado:='Standard';
    end;
    var StyleTextDiferencia: Text;
    StyleTextAsociado: Text;
}
