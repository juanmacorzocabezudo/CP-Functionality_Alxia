report 50151 AlxFixLineaNegocioCust
{
    //ApplicationArea = All;
    Caption = 'AlxFixLineaNegocioCust';
    //UsageCategory = Tasks;
    Permissions = TableData 21=rimd,
        tabledata 112=rimd;
    ProcessingOnly = true;

    dataset
    {
        dataitem(CustLedgerEntry; "Cust. Ledger Entry")
        {
            RequestFilterFields = "Customer No.";

            trigger OnAfterGetRecord();
            var
                recCust: Record Customer;
                recCLE: Record "Cust. Ledger Entry";
                recSIH: Record "Sales Invoice Header";
            begin
                CustoNo:=CustLedgerEntry."Customer No.";
                if(CustoNo <> '')then begin
                    recCust.Reset();
                    recCust.SetRange("No.", CustoNo);
                    if recCust.FindFirst()then begin
                        if recCust."Global Dimension 1 Code" <> '' then CustLineaNegocio:=recCust."Global Dimension 1 Code";
                    end;
                end;
                if CustLedgerEntry."Global Dimension 1 Code" = '' then begin
                    if CustLineaNegocio <> '' then begin
                        CustLedgerEntry."Global Dimension 1 Code":=CustLineaNegocio;
                        CustLedgerEntry.Modify();
                        recSIH.Reset();
                        recSIH.SetRange("No.", CustLedgerEntry."Document No.");
                        if recSIH.FindFirst()then repeat recSIH."Shortcut Dimension 1 Code":=CustLineaNegocio;
                                recSIH.Modify();
                            until recSIH.Next() = 0;
                    end;
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    var CustoNo: Code[20];
    CustLineaNegocio: Code[20];
}
