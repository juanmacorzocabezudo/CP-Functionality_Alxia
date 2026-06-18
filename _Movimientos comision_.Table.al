table 50011 "Movimientos comision"
{
    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
        }
        field(2; "Salesperson Code"; Code[10])
        {
            Caption = 'Salesperson Code';
            TableRelation = "Salesperson/Purchaser";

            trigger OnValidate()
            var
                ApprovalEntry: Record "Approval Entry";
            begin
            end;
        }
        field(3; "Order No."; Code[20])
        {
            Caption = 'Order No.';
            TableRelation = IF("Document Type"=CONST("Sales Shipment"))"Sales Header"."No." WHERE("Document Type"=CONST(Order))
            ELSE IF("Document Type"=CONST("Sales Return Receipt"))"Sales Header"."No." WHERE("Document Type"=CONST("Return Order"));
        }
        field(4; "Order Line No."; Integer)
        {
            Caption = 'Order Line No.';
        }
        field(5; "Shipment No."; Code[20])
        {
            Caption = 'Shipment No.';
            Editable = false;
            TableRelation = IF("Document Type"=CONST("Sales Shipment"))"Sales Shipment Header"."No."
            ELSE IF("Document Type"=CONST("Sales Return Receipt"))"Return Receipt Header"."No.";
        }
        field(6; "Shipment Line No."; Integer)
        {
            Caption = 'Shipment Line No.';
            Editable = false;
        }
        field(7; NoEvento; Code[20])
        {
            Caption = 'Nº Evento';
            TableRelation = Evento;
        }
        field(8; Amount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount';
            Editable = false;
            FieldClass = Normal;
        }
        field(9; "Commission %"; Decimal)
        {
            Caption = 'Commission %';
            DecimalPlaces = 2: 2;
            MaxValue = 100;
            MinValue = 0;
        }
        field(10; "Comission Amount"; Decimal)
        {
            Caption = 'Importe comisión';
        }
        field(11; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(12; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
        }
        field(14; "Sales Person Name"; Text[50])
        {
            CalcFormula = Lookup("Salesperson/Purchaser".Name WHERE(Code=FIELD("Salesperson Code")));
            Caption = 'Nombre vendedor';
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; Deshecho; Boolean)
        {
            CalcFormula = Lookup("Sales Shipment Line".Correction WHERE("Document No."=FIELD("Shipment No."), "Line No."=FIELD("Shipment Line No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(16; ImporteCobradoLiq; Decimal)
        {
            Caption = 'Importe cobrado liquidable';
            Description = 'ADV002';
            Editable = false;
        }
        field(17; "Job Title"; Text[30])
        {
            CalcFormula = Lookup("Salesperson/Purchaser"."Job Title" WHERE(Code=FIELD("Salesperson Code")));
            Caption = 'Job Title';
            FieldClass = FlowField;
        }
        field(18; "Nombre Cliente"; Text[100])
        {
            CalcFormula = Lookup(Customer.Name WHERE("No."=FIELD("Customer No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(19; "Descripción Producto"; Text[100])
        {
            CalcFormula = Lookup(Item.Description WHERE("No."=FIELD("Item No.")));
            FieldClass = FlowField;
        }
        field(20; Liquidado; Boolean)
        {
        }
        field(21; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Sales Shipment,Sales Return Receipt';
            OptionMembers = "Sales Shipment", "Sales Return Receipt";
        }
        field(22; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;
        }
    }
    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
