page 50100 AlxLineasPedidoCompra
{
    ApplicationArea = All;
    Caption = 'Lineas Pedido Compra';
    PageType = List;
    SourceTable = "Purchase Line";
    UsageCategory = Lists;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                }
                field("Order Date"; Rec."Order Date")
                {
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                }
                field(NombreProv; NombreProv)
                {
                    Caption = 'Nombre proveedor';
                }
                field(Type; Rec.Type)
                {
                }
                field("No."; Rec."No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Location Code"; Rec."Location Code")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                }
                field("Quantity Received"; Rec."Quantity Received")
                {
                }
                field("Line Amount"; Rec."Line Amount")
                {
                }
                field(Observaciones; Rec.Observaciones)
                {
                }
                field(Ubicación; Rec.Ubicación)
                {
                    Editable = false;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnAfterGetRecord()
    var
        Rcd_Vendor: Record 23;
    begin
        CLEAR(NombreProv);
        IF Rcd_Vendor.GET(Rec."Buy-from Vendor No.")THEN NombreProv:=Rcd_Vendor.Name;
    end;
    var NombreProv: Text[50];
}
