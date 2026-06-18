tableextension 50027 AlxiaPurchasePrice extends "Purchase Price"
{
    fields
    {
        field(50000; AGRALADescription; Text[150])
        {
            CalcFormula = Lookup(Item.Description WHERE("No."=FIELD("Item No.")));
            Caption = 'Descripción del producto';
            Description = '#210021';
            FieldClass = FlowField;
        }
        field(50001; Definicion; Text[50])
        {
            Caption = 'Definicion';
        }
        field(50002; AGRALAVendorName; Text[150])
        {
            CalcFormula = Lookup(Vendor.Name WHERE("No."=FIELD("Vendor No.")));
            Caption = 'Nombre proveedor';
            Description = '930';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50003; AGRALALineDiscount; Decimal)
        {
            Caption = '% Descuento linea';
            DecimalPlaces = 0: 5;
            Description = '931';
            MaxValue = 100;
            MinValue = 0;

            trigger OnValidate()
            begin
                AGRALACalcularDescuento()end;
        }
        field(50004; AGRALAImporteDescontado; Decimal)
        {
            Caption = 'Coste unit. direct. con descuento';
            Description = '931';
            Editable = false;
        }
        field(50005; "Mejor Proveedor"; Boolean)
        {
            Caption = 'Mejor Proveedor';

            trigger OnValidate()
            var
                RecItem: Record Item;
                RecPP: Record "Purchase Price";
            begin
                Validate("Direct Unit Cost");
                RecPP.Reset();
                RecPP.SetRange("Item No.", "Item No.");
                if RecPP.FindFirst()then repeat RecPP."Mejor Proveedor":=false;
                        RecPP.Modify();
                    until RecPP.Next() = 0;
                RecPP.Reset();
                RecPP.SetRange("Item No.", "Item No.");
                RecPP.SetRange(RecPP."Variant Code", "Variant Code");
                if RecPP.FindFirst()then repeat RecPP."Mejor Proveedor":=true;
                        RecPP.Modify();
                    until RecPP.Next() = 0;
                RecItem.Reset;
                RecItem.SetRange("No.", "Item No.");
                if RecItem.FindFirst()then begin
                    RecItem."Vendor No.":="Vendor No.";
                    CalcFields(AGRALAVendorName);
                    RecItem.NombreProveedor:=AGRALAVendorName;
                    RecItem.PrecioPropuesto:=AGRALAImporteDescontado;
                    RecItem.MarcaProveedor:="Variant Code";
                    RecItem.Modify();
                end;
                Commit();
                "Mejor Proveedor":=true;
            end;
        }
        modify("Direct Unit Cost")
        {
        trigger OnAfterValidate()
        begin
            AGRALACalcularDescuento();
        end;
        }
        modify("Variant Code")
        {
        trigger OnAfterValidate()
        var
            rlItemVendor: Record 99;
            rlItemVendorAux: Record 99;
        begin
            //++ AGRALA 932
            IF Rec."Variant Code" <> '' THEN BEGIN
                rlItemVendorAux.RESET();
                rlItemVendorAux.SETRANGE("Item No.", Rec."Item No.");
                rlItemVendorAux.SETRANGE("Variant Code", Rec."Variant Code");
                IF(NOT(rlItemVendor.GET(Rec."Vendor No.", Rec."Item No.", Rec."Variant Code"))) AND (NOT(rlItemVendorAux.FINDSET))THEN BEGIN
                    rlItemVendor.INIT();
                    rlItemVendor.VALIDATE("Vendor No.", Rec."Vendor No.");
                    rlItemVendor.VALIDATE("Item No.", Rec."Item No.");
                    rlItemVendor.VALIDATE("Variant Code", Rec."Variant Code");
                    rlItemVendor.INSERT(TRUE);
                END;
            END;
        //-- AGRALA 932
        end;
        }
    }
    local procedure AGRALACalcularDescuento()
    var
        RecItem: Record Item;
    begin
        Rec.AGRALAImporteDescontado:=Rec."Direct Unit Cost" - (Rec."Direct Unit Cost" * Rec.AGRALALineDiscount) / 100;
        if Rec."Mejor Proveedor" then begin
            RecItem.Reset;
            RecItem.SetRange("No.", "Item No.");
            if RecItem.FindFirst()then begin
                RecItem."Vendor No.":="Vendor No.";
                CalcFields(Rec.AGRALAVendorName);
                RecItem.NombreProveedor:=Rec.AGRALAVendorName;
                RecItem.PrecioPropuesto:=Rec.AGRALAImporteDescontado;
                RecItem.MarcaProveedor:=Rec."Variant Code";
                RecItem.Modify();
            end;
        end;
    end;
}
