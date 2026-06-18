pageextension 50030 AlxItemLookup extends "Item Lookup"
{
    layout
    {
        modify(Description)
        {
            Width = 60;
        }
        addafter("Base Unit of Measure")
        {
            field("Standard Cost2"; Rec."Standard Cost")
            {
                ApplicationArea = All;
            }
            field(_nombreProveedor; _nombreProveedor)
            {
                Caption = 'Nombre Proveedor';
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter(ItemList)
        {
            action(Block)
            {
                ApplicationArea = All;
                Caption = 'Ver no bloqueado';
                Image = CustomerList;
                ToolTip = 'Open the Items page showing all possible columns.';

                trigger OnAction()
                var
                    ItemList: Page "Item List";
                    recItem: Record Item;
                begin
                    recItem.Reset();
                    recItem.SetRange(Blocked, false);
                    ItemList.SetTableView(recItem);
                    ItemList.SetRecord(recItem);
                    ItemList.LookupMode:=true;
                    Commit();
                    if ItemList.RunModal() = ACTION::LookupOK then begin
                        ItemList.GetRecord(Rec);
                        CurrPage.Close();
                    end;
                end;
            }
        }
    }
    var _nombreProveedor: Text;
    trigger OnAfterGetRecord()
    var
        recVendor: Record Vendor;
    begin
        Clear(_nombreProveedor);
        recVendor.Reset();
        recVendor.SetRange("No.", Rec."Vendor No.");
        if recVendor.FindFirst()then _nombreProveedor:=recVendor.Name end;
}
