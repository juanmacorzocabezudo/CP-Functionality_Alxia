tableextension 50030 AlxActivitiesCue extends "Activities Cue"
{
    fields
    {
        field(50000; FormPresupuestado; Integer)
        {
            Caption = 'FormPresupuestado';
            DataClassification = CustomerContent;
        }
        field(50001; FormAceptado; Integer)
        {
            Caption = 'FormAceptado';
            DataClassification = CustomerContent;
        }
        field(50002; FormRechazado; Integer)
        {
            Caption = 'FormRechazado';
            DataClassification = CustomerContent;
        }
        field(50003; FormAnulado; Integer)
        {
            Caption = 'FormAnulado';
            DataClassification = CustomerContent;
        }
        field(50004; FormRealizado; Integer)
        {
            Caption = 'FormRealizado';
            DataClassification = CustomerContent;
        }
        field(50005; FormArchivado; Integer)
        {
            Caption = 'FormArchivado';
            DataClassification = CustomerContent;
        }
        field(50006; FormEnProceso; Integer)
        {
            Caption = 'FormArcFormEnProcesohivado';
            DataClassification = CustomerContent;
        }
        field(50007; FormPedidoEns; Integer)
        {
            Caption = 'Pedidos ensamblado';
            DataClassification = CustomerContent;
        }
        field(50008; StockNegativo; Integer)
        {
            Caption = 'Stock disponible negativo';
        }
    }
}
