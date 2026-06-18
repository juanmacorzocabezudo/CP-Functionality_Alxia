tableextension 50015 AlxiaSalesShipmentHeader extends "Sales Shipment Header"
{
    fields
    {
        field(50000; AlbaranValorado; Boolean)
        {
            Caption = 'Albaran Valorado';
            Description = 'ADV001';
        }
        field(50001; Est_Importe1; Decimal)
        {
            Description = 'ADV001';
        }
        field(50002; Est_ImporteDtoFactura; Decimal)
        {
            Description = 'ADV001';
        }
        field(50003; Est_DtoPP; Decimal)
        {
            Description = 'ADV001';
        }
        field(50004; Est_Total1; Decimal)
        {
            Description = 'ADV001';
        }
        field(50005; Est_ImporteIVA; Decimal)
        {
            Description = 'ADV001';
        }
        field(50006; Est_Total2; Decimal)
        {
            Description = 'ADV001';
        }
        field(50007; Est_TextoIVA; Text[30])
        {
            Description = 'ADV001';
        }
        field(50008; Est_SumaDescuentos; Decimal)
        {
            Description = 'ADV001';
        }
        field(50010; CodBancoEmpresa; Code[20])
        {
            Caption = 'Company bank code';
            Description = 'ADV001';
            Editable = false;
            TableRelation = "Bank Account"."No.";
        }
        field(50011; NoEvento; Code[20])
        {
            Caption = 'Nº Evento';
            Description = 'ADV002';
            TableRelation = Evento;
        }
        field(50012; "Customer E-Mail"; Text[80])
        {
            Caption = 'Customer E-Mail';
            Description = 'ADV002';
            ExtendedDatatype = EMail;
        }
        field(50013; Cobrado; Boolean)
        {
            Description = 'ADV002';
        }
        field(50014; HorarioAperturaRecepcion; Text[50])
        {
            Caption = 'Horario apertura / recepción mercancias';
            Description = 'ADV003';
        }
        field(50015; FacturadoCompletamente; Boolean)
        {
            CalcFormula = -Exist("Sales Shipment Line" WHERE("Document No."=FIELD("No."), Type=CONST(Item), "Qty. Shipped Not Invoiced"=FILTER(<>0)));
            Caption = 'Facturado completamente';
            Description = 'ADV004';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50020; EquipoVendedor; Code[10])
        {
            CalcFormula = Min("Team Salesperson"."Team Code" WHERE("Salesperson Code"=FIELD("Salesperson Code")));
            Description = 'ADV005';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50030; "Waranty Lot Date"; Date)
        {
            Caption = 'Waranty Lot Date';
            Description = '#9949';
        }
    }
}
