pageextension 50028 AlxItemVariants extends "Item Variants"
{
    layout
    {
        addafter(Description)
        {
            field(_FechaUltimaCompra; _FechaUltimaCompra)
            {
                Caption = 'Fecha ultima compra';
                ApplicationArea = All;
            }
        }
    }
    var _FechaUltimaCompra: Date;
    trigger OnAfterGetRecord()
    var
        RecPIL: Record "Purch. Inv. Line";
    begin
        Clear(_FechaUltimaCompra);
        RecPIL.Reset();
        RecPIL.SetRange("No.", Rec."Item No.");
        recPIL.SetRange("Variant Code", Rec.Code);
        if RecPIL.FindFirst()then _FechaUltimaCompra:=RecPIL."Posting Date";
    end;
}
