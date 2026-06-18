table 50030 AGRALAHistoricoCosteGeneral
{
    Caption = 'AGRALAHistoricoCosteGeneral';
    DataClassification = CustomerContent;

    ;
    fields
    {
        field(1; AGRALAFechaModificacion; DateTime)
        {
            Caption = 'Fecha Modificacion';
        }
        field(2; AGRALACosteGeneral; Decimal)
        {
        }
        field(3; AGRALAIdProducto; Code[20])
        {
        }
        field(4; AGRALAComentario; Text[250])
        {
        }
        field(5; Proveedor; Code[20])
        {
            Caption = 'Proveedor';
            TableRelation = Vendor."No.";
        }
        field(6; Usuario; Code[20])
        {
            Caption = 'Usuario';
        }
    }
    keys
    {
        key(Key1; AGRALAFechaModificacion, AGRALAIdProducto)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    procedure SetItem(Item2: Record 27)
    var
        Item: Record 27;
    begin
        Item.COPY(Item2);
    end;
}
