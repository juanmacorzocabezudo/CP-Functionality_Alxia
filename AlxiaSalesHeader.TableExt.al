tableextension 50018 AlxiaSalesHeader extends "Sales Header"
{
    fields
    {
        field(50000; AlbaranValorado; Boolean)
        {
            Caption = 'Albaran Valorado';
            DataClassification = CustomerContent;

            ;
        }
        field(50010; CodBancoEmpresaMigr; Code[20])
        {
            Caption = 'Cód. banco empresa';
            Description = 'ADV001';
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
            Caption = 'E-Mail Cliente';
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
            Description = 'ADV004';
        }
        field(50020; EquipoVendedor; Code[10])
        {
            FieldClass = FlowField;
            CalcFormula = Min("Team Salesperson"."Team Code" WHERE("Salesperson Code"=FIELD("Salesperson Code")));
            Editable = false;
        }
        field(50030; "Waranty Lot Date"; Date)
        {
            Caption = 'Fecha garantía lote';
            Description = '#9949';
        }
        field(50031; "TelefonoPedido"; Text[100])
        {
            Caption = 'Nº teléfono';
            Description = '#9949';
            FieldClass = FlowField;
            CalcFormula = lookup(Customer."Phone No." where("No."=field("Sell-to Customer No.")));
        }
        field(50032; "ContactoPedido"; Text[100])
        {
            Caption = 'Contacto';
            Description = '#9949';
            FieldClass = FlowField;
            CalcFormula = lookup(Customer.AGRALAOrderPerson where("No."=field("Sell-to Customer No.")));
        }
        field(50050; "Fecha Servicio"; Date)
        {
            Caption = 'Fecha Servicio';
        }
        field(50051; "Importe total evento"; Decimal)
        {
            Caption = 'Importe total evento';
        }
        field(50052; "Importe Rechazado"; Decimal)
        {
            Caption = 'Importe rechazado';
            ToolTip = 'Servicio desestimado por el cliente';
        }
        field(50053; "Importe Contratado"; Decimal)
        {
            Caption = 'Importe contratado';
            ToolTip = 'Servicio Contratado';
        }
        field(50054; "Tipo de Impresión";Enum AlxiaEventoTipodeImpresion)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo de impresión';
        }
        field(50055; "No Impresion Comentarios"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'No imprimir comentarios';
        }
        modify("Bill-to Customer No.")
        {
        trigger OnAfterValidate()
        begin
            //INICIO ADV001
            //GetCust("Sell-to Customer No.");
            CodBancoEmpresaMigr:=Customer.CodBancoEmpresa;
        //FIN ADV001
        end;
        }
        modify("Sell-to Customer No.")
        {
        trigger OnAfterValidate()
        begin
            //GetCust("Sell-to Customer No.");
            "Customer E-Mail":=Customer."E-Mail"; //ADV002
            HorarioAperturaRecepcion:=Customer.HorarioAperturaRecepcion; //ADV004
            //ADV003 Inicio
            IF("Document Type" = "Document Type"::Invoice) AND Cust."Facturacion Mensual" THEN MESSAGE(Text10000FM, Cust."No.");
        //ADV003 Fin
        end;
        }
        modify("Shipping Agent Code")
        {
        trigger OnAfterValidate()
        begin
            //inicio adv0001
            gt_transport.RESET;
            IF gt_transport.GET(Cust."Shipping Agent Code")THEN Rec.AlbaranValorado:=gt_transport."Albaran Valorado";
        //fin adv0001
        end;
        }
    }
    var Cust: Record 18;
    gt_transport: Record 291;
    Text10000FM: Label 'El cliente Nº %1 tiene facturación mensual.';
}
