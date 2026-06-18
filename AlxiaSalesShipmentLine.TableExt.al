tableextension 50016 AlxiaSalesShipmentLine extends "Sales Shipment Line"
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
        field(50005; AGRADALineAmount; Decimal)
        {
            Caption = 'Line Amount';
        }
        field(50006; AGRALADirectUnitCost; Decimal)
        {
            Caption = 'Direct Unit Cost';
        }
        field(50007; "Unidad Logística en Vigor"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Unidad logística en vigor';
            Description = 'GAP00041';
            DecimalPlaces = 0: 5;
        }
        field(51000; NoShow; Boolean)
        {
        }
    }
    procedure MarkLine()
    var
        CDU: Codeunit FuncionesVarias;
    begin
        CDU.MarkLineSSL(Rec);
    end;
}
