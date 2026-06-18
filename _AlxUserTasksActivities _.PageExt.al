pageextension 50050 "AlxUserTasksActivities " extends "User Tasks Activities"
{
    layout
    {
        addafter("My User Tasks")
        {
            cuegroup(StockDisponbile)
            {
                Caption = 'Stock disponible negativo';

                field(StockNegativo; cantItem)
                {
                    Caption = 'Cantidad de productos';
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        DrillStock();
                    end;
                }
            }
        }
    }
    trigger OnOpenPage()
    var
        rItem: Record Item;
    //cantItem: Integer;
    begin
        rItem.Reset();
        rItem.SetFilter("No.", 'MP*|MA*|PI*');
        rItem.SetRange(Blocked, false);
        rItem.FindSet();
        rItemAux.DeleteAll();
        repeat rItem.CalcFields(Inventory);
            rItem.CalcFields(AGRALAQtyAssemblyOrderLine);
            rItem.CalcFields(AGRALAQtyOnSalesOrder);
            if(rItem.Inventory - rItem.AGRALAQtyAssemblyOrderLine - rItem.AGRALAQtyOnSalesOrder) < 0 then begin
                cantItem:=cantItem + 1;
                rItemAux.TransferFields(rItem);
                rItemAux.Insert();
            end;
        until rItem.Next() = 0;
        Rec.StockNegativo:=cantItem;
        if not Rec.Insert()then Rec.Modify(false);
    end;
    procedure DrillStock()
    var
        pageGA: Page "Item List";
    begin
        PAGE.RUN(31, rItemAux);
    end;
    var rItemAux: Record Item temporary;
    cantItem: Integer;
}
