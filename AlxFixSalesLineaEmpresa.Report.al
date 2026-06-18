report 50152 AlxFixSalesLineaEmpresa
{
    ApplicationArea = All;
    UsageCategory = Tasks;
    Caption = 'AlxFixSalesLineaEmpresa';
    Permissions = TableData 113=rimd;
    ProcessingOnly = true;

    dataset
    {
        dataitem(SalesInvoiceLine; "Sales Invoice Line")
        {
            DataItemTableView = SORTING("Document No.")WHERE("Document No."=filter('VF24_09/000170|VF24_09/000092|VF24_09/000017|VF24_09/000001|VF24_08/000047|VF24_07/000127|VF24_07/000079|VF24_07/000078|VF24_07/000067|VF24_07/000031'));
            RequestFilterFields = "Document No.";

            trigger OnAfterGetRecord();
            var
                rSIL: Record "Sales Invoice Line";
            begin
                DocNo:=SalesInvoiceLine."Document No.";
                rSIL.Reset();
                rSIL.SetRange("Document No.", DocNo);
                if rSIL.FindFirst()then repeat if rSIL."Shortcut Dimension 2 Code" = '00101' then begin
                            rSIL."Shortcut Dimension 2 Code":='P_TERMINADO';
                            rSIL.Modify();
                        end;
                        if rSIL."Shortcut Dimension 2 Code" = '00011' then begin
                            rSIL."Shortcut Dimension 2 Code":='CATERING';
                            rSIL.Modify();
                        end;
                    until rSIL.Next() = 0;
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
    var DocNo: Code[20];
}
