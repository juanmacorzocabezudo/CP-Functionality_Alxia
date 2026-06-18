report 50055 AGRALAActualizarUltimoCosteDir
{
    Caption = 'Actualizar último coste directo';
    ProcessingOnly = true;
    UseRequestPage = false;
    UsageCategory = Documents;
    ApplicationArea = All;

    dataset
    {
        dataitem(Item; Item)
        {
            trigger OnAfterGetRecord()
            begin
                BuscarUltimoCosteUMB();
            end;
        }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    labels
    {
    }
    procedure BuscarUltimoCosteUMB()
    var
        rlPurchaseInvLine: Record 123;
    begin
        /*rlPurchaseLine.RESET();
        rlPurchaseLine.SETRANGE(rlPurchaseLine."Document Type",rlPurchaseLine."Document Type"::Order);
        rlPurchaseLine.SETRANGE(rlPurchaseLine.Type,rlPurchaseLine.Type::Item);
        rlPurchaseLine.SETRANGE(rlPurchaseLine."No.",Item."No.");
        IF rlPurchaseLine.FINDLAST() THEN BEGIN
            Item.VALIDATE("Last Direct Cost",rlPurchaseLine."Direct Unit Cost");
            Item.MODIFY();
        END;*/
        rlPurchaseInvLine.RESET();
        rlPurchaseInvLine.SETRANGE(rlPurchaseInvLine.Type, rlPurchaseInvLine.Type::Item);
        rlPurchaseInvLine.SETRANGE(rlPurchaseInvLine."No.", Item."No.");
        IF rlPurchaseInvLine.FINDLAST()THEN BEGIN
            Item.VALIDATE("Last Direct Cost", rlPurchaseInvLine."Unit Cost (LCY)");
            Item.MODIFY();
        END
        else
        begin
            Item.Validate("Last Direct Cost", 0);
            Item.MODIFY();
        end;
    end;
}
