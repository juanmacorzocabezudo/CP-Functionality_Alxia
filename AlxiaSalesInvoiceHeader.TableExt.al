tableextension 50012 AlxiaSalesInvoiceHeader extends "Sales Invoice Header"
{
    fields
    {
        field(50010; CodBancoEmpresaMigr; Code[20])
        {
            Caption = 'Cód. Banco Empresa';
            Description = 'ADV001';
            //Editable = false;
            TableRelation = "Bank Account"."No.";
        }
        field(50011; NoEvento; Code[20])
        {
            Caption = 'Nº Evento';
            Description = 'ADV001';
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
        field(50020; EquipoVendedor; Code[10])
        {
            CalcFormula = Min("Team Salesperson"."Team Code" WHERE("Salesperson Code"=FIELD("Salesperson Code")));
            Description = 'ADV003';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50030; "Waranty Lot Date"; Date)
        {
            Caption = 'Waranty Lot Date';
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
        //SL Fix para el transfer field
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
        field(50056; "Tipo de Impresión Ajustada"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo de Impresión Ajustada';
        }
    }
}
