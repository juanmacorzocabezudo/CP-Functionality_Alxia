report 50153 AlxAjustarFechaMovProducto
{
    ApplicationArea = All;
    UsageCategory = Tasks;
    Caption = 'AlxAjustarFechaMovProducto';
    Permissions = TableData 32=rimd,
        tabledata 5802=rimd;
    ProcessingOnly = true;

    dataset
    {
        dataitem(movproducto; "Item Ledger Entry")
        {
        /*   DataItemTableView = SORTING("Document No.")
              WHERE("Document No." = filter('REGU. STOCK 25|REGU. STOCK 20|CTRL INVENTARIO 39'));

              RequestFilterFields = "Document No."; */
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
                    field(DocumentNo; DocNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Document No.', Comment = 'ESP="Document No.';
                    }
                    field(PostingDate; PostingDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Fecha de registro', Comment = 'ESP="Fecha de registro"';
                    }
                }
            }
        }
    }
    trigger OnPostReport();
    var
        rILE: Record "Item Ledger Entry";
        rVE: Record "Value Entry";
        rVEAux: Record "Value Entry";
    begin
        rILE.Reset();
        rILE.SetRange("Document No.", DocNo);
        if rILE.FindFirst()then repeat rVE.Reset();
                rVE.SetRange("Posting Date", rILE."Posting Date");
                rVE.SetRange("Document No.", rILE."Document No.");
                if rVE.FindFirst()then repeat rVEAux.Reset();
                        rVEAux.SetRange("Entry No.", rVE."Entry No.");
                        if rVEAux.FindFirst()then begin
                            rVEAux."Posting Date":=PostingDate;
                            rVEAux."Document No.":='CTRL INV. 2024 - 1';
                            rVEAux.Modify(false);
                        end;
                    until rVE.Next() = 0;
                rILE."Posting Date":=PostingDate;
                rILE."Document No.":='CTRL INV. 2024 - 1';
                rILE.Modify(false);
            until rILE.Next() = 0;
    end;
    var DocNo: Code[20];
    PostingDate: Date;
}
