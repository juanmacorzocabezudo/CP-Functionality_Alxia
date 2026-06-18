pageextension 50020 AlxiaPurchasePrices extends "Purchase Prices"
#pragma warning restore AL0432
{
    layout
    {
        modify("Variant Code")
        {
            Caption = 'Marca';
        }
        addbefore("Item No.")
        {
            field(AGRALAVendorName; Rec.AGRALAVendorName)
            {
                ApplicationArea = All;
            }
        }
        addafter("Variant Code")
        {
            field(_FechaUltimaCompra; _FechaUltimaCompra)
            {
                Caption = 'Fecha ultima compra';
                ApplicationArea = All;
            }
            field(AGRALADescription; Rec.AGRALADescription)
            {
                ApplicationArea = All;
                Editable = false;
                Visible = true;
            }
            field("Mejor Proveedor"; Rec."Mejor Proveedor")
            {
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    currpage.Update(false);
                end;
            }
        }
        addafter("Ending Date")
        {
            field(Definicion; Rec.Definicion)
            {
                ApplicationArea = All;
                Visible = true;
            }
            field(AGRALALineDiscount; Rec.AGRALALineDiscount)
            {
                ApplicationArea = All;
            }
            field(AGRALAImporteDescontado; Rec.AGRALAImporteDescontado)
            {
                ApplicationArea = All;
                DecimalPlaces = 4: 4;
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
        RecPIL.SetCurrentKey("Posting Date");
        RecPIL.SetRange("No.", Rec."Item No.");
        recPIL.SetRange("Variant Code", Rec."Variant Code");
        if RecPIL.FindLast()then _FechaUltimaCompra:=RecPIL."Posting Date";
    end;
}
