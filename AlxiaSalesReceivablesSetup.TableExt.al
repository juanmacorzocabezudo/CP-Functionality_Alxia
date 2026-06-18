tableextension 50014 AlxiaSalesReceivablesSetup extends "Sales & Receivables Setup"
{
    fields
    {
        field(50000; "Serie Eventos"; Code[10])
        {
            Description = 'ADV001';
            TableRelation = "No. Series";
        }
        field(50001; "Cuenta Eventos"; Code[20])
        {
            Description = 'ADV001';
            TableRelation = "G/L Account" WHERE("Account Type"=CONST(Posting));
        }
        field(50002; "Producto Eventos Archivados"; Code[20])
        {
            Description = 'ADV001';
            TableRelation = Item;
        }
        field(50003; "Producto Oferta Mes sin IVA"; Code[20])
        {
            Description = 'ADV002';
            TableRelation = Item;
        }
        field(50010; FechaDesde; Date)
        {
            Caption = 'Fecha Desde';
            DataClassification = CustomerContent;
        }
        field(50011; FechaHasta; Date)
        {
            Caption = 'Fecha Hasta';
            DataClassification = CustomerContent;
        }
        field(50012; "Serie Centro Trabajo"; Code[10])
        {
            Caption = 'Serie Centro Trabajo';
            TableRelation = "No. Series";
        }
        field(50013; "Dimension Obligatoria"; Boolean)
        {
            Caption = 'No completar dimensiones obligatorias';
            DataClassification = CustomerContent;
        }
        field(50014; "Crea Nuevo Evento"; Boolean)
        {
            Caption = 'Crear nuevo evento';
            DataClassification = CustomerContent;
        }
        field(50015; "Linea Evento Adulto"; Text[80])
        {
            Caption = 'Línea evento adulto';
            DataClassification = CustomerContent;
            Description = 'GAP00037';
        }
        field(50016; "Linea Evento Ninno"; Text[80])
        {
            Caption = 'Línea evento niño';
            DataClassification = CustomerContent;
            Description = 'GAP00037';
        }
        field(50017; "Linea Evento Otros"; Text[80])
        {
            Caption = 'Línea evento otros';
            DataClassification = CustomerContent;
            Description = 'GAP00037';
        }
        field(50018; "Periodo Inicial Cal Clientes"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Periodo Inicial Cal Clientes';
            Description = 'GAP00040';
        }
        field(50019; CopyDim; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Copiar Dimensiones';
        }
        field(50020; "Calcular coste Cantidad"; boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Calcular coste cantidad';
        }
    }
}
