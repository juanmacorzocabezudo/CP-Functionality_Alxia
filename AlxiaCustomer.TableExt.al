tableextension 50002 AlxiaCustomer extends Customer
{
    fields
    {
        field(50000; "Facturacion Mensual"; Boolean)
        {
            Caption = 'Facturacion Mensual';
        }
        field(50002; CodBancoEmpresa; Code[20])
        {
            Caption = 'Cód. banco empresa';
            Description = 'ADV001';
            TableRelation = "Bank Account"."No.";
        }
        field(50003; HorarioAperturaRecepcion; Text[50])
        {
            Caption = 'Horario apertura / recepción mercancias';
            Description = 'ADV002';
        }
        field(50004; EquipoVendedor; Code[10])
        {
            CalcFormula = Min("Team Salesperson"."Team Code" WHERE("Salesperson Code"=FIELD("Salesperson Code")));
            Description = 'ADV003';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50005; Contrato; Boolean)
        {
        }
        field(50006; Plantilla; Boolean)
        {
        }
        field(50007; "Líneas de Negocio";Enum AlxiaLineasNegocio)
        {
            Caption = 'Líneas de Negocio';
            DataClassification = CustomerContent;
        }
        field(50008; AGRALAContabilityPerson; Text[30])
        {
            Caption = 'Persona contacto Contabilidad';
            Description = '935';
        }
        field(50009; AGRALAContabilityPhone; Text[20])
        {
            Caption = 'Nº teléfono Contabilidad';
            Description = '935';
        }
        field(50010; AGRALAContabilityEmail; Text[80])
        {
            Caption = 'Correo electrónico Contabilidad';
            Description = '935';
        }
        field(50011; AGRALAQualityPerson; Text[20])
        {
            Caption = 'Persona contacto Calidad';
            Description = '935';
        }
        field(50012; AGRALAQualityPhone; Text[30])
        {
            Caption = 'Nº teléfono Calidad';
            Description = '935';
        }
        field(50013; AGRALAQualityEmail; Text[80])
        {
            Caption = 'Correo electrónico Calidad';
            Description = '935';
        }
        field(50014; AGRALACrisis24hPerson; Text[20])
        {
            Caption = 'Persona contacto 24h CRISIS';
            Description = '935';
        }
        field(50015; AGRALACrisis24hEmail; Text[80])
        {
            Caption = 'Correo electrónico 24h CRISIS';
            Description = '935';
        }
        field(50016; AGRALAOrderPerson; Text[30])
        {
            Caption = 'Persona contacto Pedidos';
            Description = '935';
        }
        field(50017; "Tiene Producto Asociado"; Boolean)
        {
            DataClassification = CustomerContent;
            Description = 'GAP00040';
        }
    }
}
