table 50043 "Productos Clientes"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Nro. Producto"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Item no.', comment = 'ESP="N° producto"';
            TableRelation = Item;
        }
        field(2; "Nro. Cliente"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Customer no.', comment = 'ESP="N° cliente"';
            TableRelation = Customer;

            trigger OnValidate()
            begin
                if Cliente.Get("Nro. Cliente")then "Nombre Cliente":=Cliente.Name
                else
                    "Nombre Cliente":='';
            end;
        }
        field(3; "Descripción Producto"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Item description', comment = 'ESP="Descripción del producto"';
            Editable = false;
        }
        field(4; "Nombre Cliente"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Customer name', comment = 'ESP="Nombre del cliente"';
            Editable = false;
        }
    }
    keys
    {
        key(Key1; "Nro. Producto", "Nro. Cliente")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    // Add changes to field groups here
    }
    var Cliente: Record Customer;
    Producto: Record Item;
    trigger OnInsert()
    begin
        if Producto.Get("Nro. Producto")then "Descripción Producto":=Producto.Description;
    end;
    trigger OnModify()
    begin
    end;
    trigger OnDelete()
    begin
    end;
    trigger OnRename()
    begin
    end;
}
