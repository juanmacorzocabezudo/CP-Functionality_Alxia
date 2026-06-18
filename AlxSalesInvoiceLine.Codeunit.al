codeunit 50009 AlxSalesInvoiceLine
{
    TableNo = "Sales Invoice Line";
    Permissions = TableData 113=rimd,
        Tabledata 115=rimd;

    procedure Update()
    var
        rSalesInvoiceLine: Record "Sales Invoice Line";
        rSalesCrMemo: Record "Sales Cr.Memo Line";
        rItem: Record Item;
    begin
        rSalesInvoiceLine.SetFilter("Document No.", 'VF25_03/000068|VF25_02/000085|VF24_12/000093|VF25_01/000066|VF24_12/000074|VF24_12/000069|VF24_11/000096|VF24_11/000059|VF24_11/000059|VF24_11/000058|VF24_11/000058|VF24_09/000034|VF24_12/000024');
        rSalesInvoiceLine.SetRange(Type, rSalesInvoiceLine.Type::Item);
        rSalesInvoiceLine.SetRange("Gross Weight", 0);
        if rSalesInvoiceLine.FindFirst()then begin
            repeat rItem.Reset();
                rItem.SetRange("No.", rSalesInvoiceLine."No.");
                if rItem.FindFirst()then begin
                    rSalesInvoiceLine."Net Weight":=rItem."Net Weight";
                    rSalesInvoiceLine."Gross Weight":=rItem."Gross Weight";
                    rSalesInvoiceLine.Modify(false);
                end;
            until rSalesInvoiceLine.Next() = 0;
        end;
        rSalesCrMemo.SetFilter("Document No.", 'VA2411/00020|VA2411/00019');
        rSalesCrMemo.SetRange(Type, rSalesCrMemo.Type::Item);
        rSalesCrMemo.SetRange("Gross Weight", 0);
        if rSalesCrMemo.FindFirst()then begin
            repeat rItem.Reset();
                rItem.SetRange("No.", rSalesCrMemo."No.");
                if rItem.FindFirst()then begin
                    rSalesCrMemo."Net Weight":=rItem."Net Weight";
                    rSalesCrMemo."Gross Weight":=rItem."Gross Weight";
                    rSalesCrMemo.Modify(false);
                end;
            until rSalesCrMemo.Next() = 0;
        end;
    end;
}
