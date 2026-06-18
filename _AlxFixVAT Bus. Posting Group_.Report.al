report 50150 "AlxFixVAT Bus. Posting Group"
{
    ApplicationArea = All;
    Caption = 'AlxFixVAT Bus. Posting Group';
    UsageCategory = Tasks;
    ProcessingOnly = true;
    Permissions = TableData 110=rimd,
        tabledata 111=rimd;

    dataset
    {
        dataitem(SalesShipmentHeader; "Sales Shipment Header")
        {
            RequestFilterFields = "Sell-to Customer No.";

            trigger OnAfterGetRecord();
            var
                recCust: Record Customer;
                recSSL: Record "Sales Shipment Line";
            begin
                CustoNo:=SalesShipmentHeader."Sell-to Customer No.";
                if(CustoNo <> '')then begin
                    recCust.Reset();
                    recCust.SetRange("No.", CustoNo);
                    if recCust.FindFirst()then begin
                        if recCust."VAT Bus. Posting Group" <> '' then custVATPostingGroup:=recCust."VAT Bus. Posting Group";
                    end;
                end;
                if SalesShipmentHeader."VAT Bus. Posting Group" = '' then begin
                    if custVATPostingGroup <> '' then begin
                        SalesShipmentHeader.Validate("VAT Bus. Posting Group", custVATPostingGroup);
                        SalesShipmentHeader.Modify();
                        recSSL.Reset();
                        recSSL.SetRange("Document No.", SalesShipmentHeader."No.");
                        if recSSL.FindFirst()then repeat recSSL.Validate("VAT Bus. Posting Group", custVATPostingGroup);
                                recSSL.Modify();
                            until recSSL.Next() = 0;
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
                group(Cliente)
                {
                /*    field(CustoNo; CustoNo)
                       {
                           ApplicationArea = All;
                       } */
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
    /*  trigger OnPreReport()
     var
         recCust: Record Customer;
     begin
         CustoNo := SalesShipmentHeader."Sell-to Customer No.";
         if (CustoNo <> '') then begin
             recCust.Reset();
             recCust.SetRange("No.", CustoNo);
             if recCust.FindFirst() then begin
                 if recCust."VAT Bus. Posting Group" <> '' then
                     custVATPostingGroup := recCust."VAT Bus. Posting Group";
             end;
         end;
     end;
  */
    var CustoNo: Code[20];
    custVATPostingGroup: Code[20];
}
