report 50056 AGRALAActualizarStock
{
    ProcessingOnly = true;
    UseRequestPage = false;

    dataset
    {
        dataitem(Item;27)
        {
            trigger OnAfterGetRecord()
            begin
                Item.CALCFIELDS(Item.Inventory, Item.AGRALAQtyAssemblyOrderLine, Item.AGRALAQtyOnSalesOrder);
                Item.AGRALAStockDisponible:=Item.Inventory - Item.AGRALAQtyAssemblyOrderLine - Item.AGRALAQtyOnSalesOrder;
                Item.MODIFY();
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
}
