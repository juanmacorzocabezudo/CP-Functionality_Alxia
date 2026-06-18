table 50020 Supply
{
    Caption = 'Supply';
    DrillDownPageID = 50042;
    LookupPageID = 50042;
    DataClassification = CustomerContent;

    ;
    fields
    {
        field(1; Type; Option)
        {
            Caption = 'Tipo';
            OptionCaption = 'Persona,Maquina';
            OptionMembers = Person, Machine;
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(3; Description; Text[50])
        {
            Caption = 'Descripción';
        }
        field(4; "Unit of measurement"; Code[20])
        {
            Caption = 'Unidad medida';
            TableRelation = "Unit of Measure".Code;
        }
        field(5; Quantity; Decimal)
        {
            Caption = 'Cantidad';
        }
        field(6; Price; Decimal)
        {
            Caption = 'Precio';
        }
        field(10; Comment; Text[250])
        {
            Caption = 'Commentario';
        }
    }
    keys
    {
        key(Key1; Type, "No.")
        {
            Clustered = true;
        }
    }
}
