page 50026 "Lineas pedido compra"
{
    // 
    // ADVANCE - Log de cambios
    // -----------------------------------------------------
    //   ADVANCE
    //   Fecha: 02-06-2016
    //   Técnico: JMAP
    //   Presupuesto: I002682 - Nueva pagina pedido compra
    //   Modificación:
    // 
    //   Etiqueta: ADV001
    // -----------------------------------------------------
    Editable = false;
    PageType = List;
    SourceTable = "Purchase Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = All;
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = All;
                }
                field(NombreProv; NombreProv)
                {
                    ApplicationArea = All;
                    Caption = 'Nombre proveedor';
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Quantity Received"; Rec."Quantity Received")
                {
                    ApplicationArea = All;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = All;
                }
                field(Observaciones; Rec.Observaciones)
                {
                    ApplicationArea = All;
                }
                field(Ubicación; Rec."Ubicación")
                {
                    ApplicationArea = All;
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
        Rcd_Vendor: Record Vendor;
    begin
        CLEAR(NombreProv);
        IF Rcd_Vendor.GET(Rec."Buy-from Vendor No.")THEN NombreProv:=Rcd_Vendor.Name;
    end;
    var NombreProv: Text[50];
}
