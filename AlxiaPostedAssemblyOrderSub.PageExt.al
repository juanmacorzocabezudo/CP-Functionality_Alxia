pageextension 50018 AlxiaPostedAssemblyOrderSub extends "Posted Assembly Order Subform"
{
    layout
    {
        modify("Order Line No.")
        {
            Caption = 'Nº linea pedido';
            Visible = true;
        }
        modify(Description)
        {
            StyleExpr = StyleTextLine;
        }
        addafter("Resource Usage Type")
        {
            field("Cantidad Original"; Rec."Cantidad Original")
            {
                ApplicationArea = All;
            }
            field("Cantidad Por Original"; Rec."Cantidad Por Original")
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
            field(AGRALACentroCoste; Rec.AGRALACentroCoste)
            {
                ApplicationArea = All;
            }
            field(AGRALAResponsable; Rec.AGRALAResponsable)
            {
                ApplicationArea = All;
            }
            field(Comentario; Rec.Comentario)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter(Comments)
        {
            action(RECETA)
            {
                ApplicationArea = All;
                Enabled = true;
                Image = BOM;
                RunObject = Page 50000;
                RunPageLink = "No."=FIELD("No.");
                RunPageView = SORTING("No.")ORDER(Ascending);
            }
            action("Cambiar Cantidad")
            {
                ApplicationArea = All;
                Enabled = true;
                Image = Edit;
                RunObject = Page 50083;
                RunPageLink = "Document No."=FIELD("Document No."), Type=CONST(Item);
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        IF(Rec.Type IN[Rec.Type::" ", Rec.Type::Item]) AND (COPYSTR(Rec."No.", 1, 2) = 'PI')THEN //StyleTextLine := 'Favorable'
            StyleTextLine:='Ambiguous'
        ELSE
            StyleTextLine:='Standard';
        IF Rec.Diferencia = 0 THEN StyleTextDiferencia:='Standard'
        ELSE IF Rec.Diferencia > 0 THEN StyleTextDiferencia:='Unfavorable'
            ELSE IF Rec.Diferencia < 0 THEN StyleTextDiferencia:='Favorable';
    end;
    var StyleTextLine: Text[20];
    StyleTextDiferencia: Text;
}
