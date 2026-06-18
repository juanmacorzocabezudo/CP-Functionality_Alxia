tableextension 50011 AlxiaSalesCrMemoHeader extends "Sales Cr.Memo Header"
{
    fields
    {
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
            Description = 'ADV001';
            TableRelation = Evento;
        }
        field(50012; "Customer E-Mail"; Text[80])
        {
            Caption = 'Customer E-Mail';
            Description = 'ADV002';
            ExtendedDatatype = EMail;
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
        field(50050; "Fecha Servicio"; Date)
        {
            Caption = 'Fecha Servicio';
            NotBlank = true;
        }
    }
}
