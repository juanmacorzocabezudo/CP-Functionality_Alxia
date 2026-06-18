page 50107 AlxSalesInvoiceLine
{
    ApplicationArea = All;
    Caption = 'AlxSalesInvoiceLine';
    PageType = List;
    SourceTable = "Sales Invoice Line";
    UsageCategory = Administration;
    Editable = true;
    ModifyAllowed = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Document No."; Rec."Document No.")
                {
                }
                field("Line No."; Rec."Line No.")
                {
                }
                field("Type"; Rec."Type")
                {
                }
                field("No."; Rec."No.")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Gross Weight"; Rec."Gross Weight")
                {
                }
                field("Net Weight"; Rec."Net Weight")
                {
                    Editable = true;
                }
                field("Net Weight (Kg)"; _PesoItem)
                {
                    ApplicationArea = All;
                    Caption = 'Peso Item * Cantidad';
                    Editable = false;
                }
                field("Net Weight (Calc)"; _PesoCalc)
                {
                    ApplicationArea = All;
                    Caption = 'Peso Neto a cambiar';
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            group("Actions")
            {
                action("Update")
                {
                    ApplicationArea = All;
                    Caption = 'Update';
                    Image = UpdateXML;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        rSalesInvoiceLine: Record "Sales Invoice Line";
                        CDU: Codeunit "AlxSalesInvoiceLine";
                    begin
                        CDU.Update();
                    end;
                }
            }
        }
    }
    var _PesoItem: Decimal;
    _PesoCalc: Decimal;
    trigger OnAfterGetRecord()
    var
        rItem: Record Item;
    begin
        ClearAll();
        rItem.SetRange("No.", Rec."No.");
        if ritem.FindFirst()then begin
            _PesoItem:=rItem."Net Weight" * Rec.Quantity;
        end;
    end;
}
