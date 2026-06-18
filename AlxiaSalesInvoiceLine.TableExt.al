tableextension 50013 AlxiaSalesInvoiceLine extends "Sales Invoice Line"
{
    fields
    {
        field(50000; NoEvento; Code[20])
        {
            Caption = 'Nº Evento';
            Description = 'ADV001';
            TableRelation = Evento;
        }
        field(50001; LineaEvento; Integer)
        {
            Caption = 'Linea Evento';
            Description = 'ADV001';
        }
        field(50002; "Tabla Evento"; Integer)
        {
            Caption = 'Tabla Evento';
            Description = 'ADV001';
        }
        field(50003; Imprime; Boolean)
        {
            Description = 'ADV001';
        }
        field(50004; AGRALALastDirectCost; Decimal)
        {
            Caption = 'Last Direct Cost';
        }
        field(50005; AGRALALineasNegocio;Enum AlxiaLineasNegocio)
        {
            Caption = 'Líneas Negocio';
        }
        field(50006; NombreCliente; Text[100])
        {
            Caption = 'Nombre cliente';
            FieldClass = FlowField;
            CalcFormula = lookup(Customer."Name" where("No."=field("Sell-to Customer No.")));
        }
        field(50007; Inventory; Decimal)
        {
            CalcFormula = sum("Item Ledger Entry".Quantity where("Item No."=field("No.")));
            Caption = 'Inventario';
            DecimalPlaces = 0: 5;
            FieldClass = FlowField;
        }
        field(50008; "Qty. on Purch. Order"; Decimal)
        {
            AccessByPermission = TableData "Purch. Rcpt. Header"=R;
            Caption = 'Cant. en pedidos compra';
            CalcFormula = sum("Purchase Line"."Outstanding Qty. (Base)" where("Document Type"=const(Order), Type=const(Item), "No."=field("No.")));
            DecimalPlaces = 0: 5;
            FieldClass = FlowField;
        }
        field(50009; "Qty. on Prod. Order"; Decimal)
        {
            Caption = 'Cant. en orden producc.';
            CalcFormula = sum("Prod. Order Line"."Remaining Qty. (Base)" where(Status=filter(Planned..Released), "Item No."=field("No.")));
            DecimalPlaces = 0: 5;
            FieldClass = FlowField;
        }
        field(50010; "Qty. on Sales Order"; Decimal)
        {
            AccessByPermission = TableData "Sales Shipment Header"=R;
            CalcFormula = sum("Sales Line"."Outstanding Qty. (Base)" where("Document Type"=const(Order), Type=const(Item), "No."=field("No.")));
            Caption = 'Cant. en pedidos venta';
            DecimalPlaces = 0: 5;
            FieldClass = FlowField;
        }
        field(50011; TelefonoCliente; Text[30])
        {
            Caption = 'Teléfono cliente';
            FieldClass = FlowField;
            CalcFormula = lookup(Customer."Phone No." where("No."=field("Sell-to Customer No.")));
        }
        field(50012; EmailCliente; Text[80])
        {
            Caption = 'Email cliente';
            FieldClass = FlowField;
            CalcFormula = lookup(Customer."E-Mail" where("No."=field("Sell-to Customer No.")));
        }
        field(50013; ContactoCliente; Text[100])
        {
            Caption = 'Nombre contacto cliente';
            FieldClass = FlowField;
            CalcFormula = lookup(Customer."Contact" where("No."=field("Sell-to Customer No.")));
        }
        field(50014; "Pedido origen albaran"; Code[20])
        {
            Caption = 'Pedido origen de la línea de albarán';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Shipment Line"."Order No." where("Order Line No."=field("Shipment Line No.")));
        }
        field(50015; "No. Factura"; Code[20])
        {
            Caption = 'Nº Factura';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Shipment Line"."Order No." where("Order Line No."=field("Shipment Line No.")));
        }
        field(50016; "No. Envio Reg. Almacen"; Code[20])
        {
            Caption = 'Nº envío registrado almacén';
            FieldClass = FlowField;
            CalcFormula = lookup("Posted Whse. Shipment Line"."Whse. Shipment No." where("Source No."=field("No.")));
        }
        field(50017; "Fecha Reg. Envio Almacen"; Date)
        {
            Caption = 'Fecha registro envío almacén';
            FieldClass = FlowField;
            CalcFormula = lookup("Posted Whse. Shipment Line"."Posting Date" where("Source No."=field("No.")));
        }
    }
}
