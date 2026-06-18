pageextension 50048 AlxItemTrackingSummary extends "Item Tracking Summary"
{
    layout
    {
        addafter("Lot No.")
        {
            field(_FechaCompraLote; _FechaCompraLote)
            {
                ApplicationArea = All;
                Caption = 'Fecha Compra';
                Editable = false;
            }
        }
    }
    var _FechaCompraLote: Date;
    trigger OnAfterGetRecord()
    var
        rILE: Record "Item Ledger Entry";
    begin
        ClearAll();
        rILE.SetCurrentKey("Posting Date");
        rILE.SetRange(rILE."Entry Type", rILE."Entry Type"::Purchase);
        rILE.SetRange("Lot No.", Rec."Lot No.");
        rILE.SetRange("Expiration Date", Rec."Expiration Date");
        if rILE.FindLast()then begin
            //rILE.SetTrackingFilterFromItemLedgEntry(rILE);
            _FechaCompraLote:=rILE."Posting Date";
        end;
    end;
}
