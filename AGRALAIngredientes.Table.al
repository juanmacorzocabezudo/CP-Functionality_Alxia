table 50018 AGRALAIngredientes
{
    Caption = 'AGRALAIngredientes';
    DataClassification = CustomerContent;

    ;
    fields
    {
        field(1; AGRALACodProducto; Code[20])
        {
            Caption = 'Cód. Producto';
            Description = '#210021';
            TableRelation = Item."No.";
        }
        field(2; AGRALACodVariante; Code[50])
        {
            Caption = 'Marca';
            Description = '#210021';
            TableRelation = "Item Variant".Code WHERE("Item No."=FIELD(AGRALACodProducto));
        }
        field(3; AGRALATipo; Option)
        {
            Caption = 'Tipo';
            Description = '#210021';
            OptionCaption = 'OMG,Irradiado';
            OptionMembers = OMG, Irradiado;
        }
        field(4; AGRALALineNo; Integer)
        {
            AutoIncrement = true;
            Caption = 'N. Linea';
            Description = '#210021';
        }
        field(5; AGRALADescripcion; Text[150])
        {
            Caption = 'Descripcion';
            Description = '#210021';
        }
    }
    keys
    {
        key(Key1; AGRALACodProducto, AGRALACodVariante, AGRALATipo, AGRALALineNo)
        {
            Clustered = true;
        }
    }
}
