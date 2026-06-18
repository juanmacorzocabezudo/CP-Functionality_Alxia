tableextension 50005 AlxiaPurchaseLine extends "Purchase Line"
{
    fields
    {
        field(50000; "Último Coste Directo"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = Lookup(Item."Last Direct Cost" WHERE("No."=FIELD("No.")));
            Caption = 'Último Coste Directo';
            Editable = false;
            FieldClass = FlowField;
            MinValue = 0;
        }
        field(50001; "Compra a nombre"; Text[150])
        {
            CalcFormula = Lookup("Purchase Header"."Buy-from Vendor Name" WHERE("Document Type"=FIELD("Document Type"), "No."=FIELD("Document No."), "Buy-from Vendor No."=FIELD("Buy-from Vendor No.")));
            FieldClass = FlowField;
        }
        field(50002; TemperaturaRecepcion; Decimal)
        {
            Caption = 'Temperatura recepción';
            Description = 'ADV002';
        }
        field(50003; AspectoCorrecto; Option)
        {
            Caption = 'Aspecto correcto';
            Description = 'ADV002';
            OptionMembers = " ", "Sí", No;
        }
        field(50004; HigieneTranspCorrecta; Option)
        {
            Caption = 'Higiene transp. correcta';
            Description = 'ADV002';
            OptionMembers = " ", "Sí", No;
        }
        field(50005; Observaciones; Text[100])
        {
            Description = 'ADV002';
        }
        field(50006; "Ubicación"; Code[10])
        {
            CalcFormula = Lookup(Item."Shelf No." WHERE("No."=FIELD("No.")));
            Description = 'ADV003';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50007; AGRALAStatus; Option)
        {
            CalcFormula = Lookup("Purchase Header".Status WHERE("Document Type"=FIELD("Document Type"), "No."=FIELD("Document No.")));
            Caption = 'Estado';
            Description = '862';
            FieldClass = FlowField;
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment';
            OptionMembers = Open, Released, "Pending Approval", "Pending Prepayment";
        }
        field(50008; PrecioPropuesto; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = Lookup(Item.PrecioPropuesto WHERE("No."=FIELD("No.")));
            Caption = 'Último Coste Directo';
            Editable = false;
            FieldClass = FlowField;
            MinValue = 0;
        }
        modify("No.")
        {
        trigger OnAfterValidate()
        var
            RecPurchasePrice: Record "Purchase Price";
        begin
            RecPurchasePrice.Reset();
            RecPurchasePrice.SetRange("Item No.", Rec."No.");
            RecPurchasePrice.SetRange("Mejor Proveedor", true);
            if RecPurchasePrice.FindFirst()then Validate(Rec."Line Discount %", RecPurchasePrice.AGRALALineDiscount);
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
                rlItemVendorAux.SETRANGE("Item No.", Rec."No.");
                rlItemVendorAux.SETRANGE("Variant Code", Rec."Variant Code");
                IF(NOT(rlItemVendor.GET(Rec."Buy-from Vendor No.", Rec."No.", Rec."Variant Code"))) AND (NOT(rlItemVendorAux.FINDSET))THEN BEGIN
                    rlItemVendor.INIT();
                    rlItemVendor.VALIDATE("Vendor No.", Rec."Buy-from Vendor No.");
                    rlItemVendor.VALIDATE("Item No.", Rec."No.");
                    rlItemVendor.VALIDATE("Variant Code", Rec."Variant Code");
                    rlItemVendor.INSERT(TRUE);
                END;
            END;
        //-- AGRALA 932
        end;
        }
        modify(Quantity)
        {
        trigger OnAfterValidate()
        var
            RecPurchasePrice: Record "Purchase Price";
        begin
            RecPurchasePrice.Reset();
            RecPurchasePrice.SetRange("Item No.", Rec."No.");
            RecPurchasePrice.SetRange("Mejor Proveedor", true);
            if RecPurchasePrice.FindFirst()then Validate(Rec."Line Discount %", RecPurchasePrice.AGRALALineDiscount);
        end;
        }
    }
}
