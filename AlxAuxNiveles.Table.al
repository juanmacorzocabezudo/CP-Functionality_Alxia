table 50037 AlxAuxNiveles
{
    Caption = 'AlxAuxNiveles';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; ProductoBase; Code[20])
        {
            Caption = 'ProductoBase';
        }
        field(2; ItemNo; Code[20])
        {
            Caption = 'ItemNo';
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No';
            AutoIncrement = true;
        }
        field(4; "Nivel"; Option)
        {
            Caption = 'Nivel';
            OptionCaption = '00 - Receta madre,01 - Nivel,02 - Nivel,03 - Nivel,04 - Nivel,05 - Nivel';
            OptionMembers = "00 - Receta madre", "01 - Nivel", "02 - Nivel", "03 - Nivel", "04 - Nivel", "05 - Nivel";
        }
    }
    keys
    {
        key(PK; ProductoBase, "Line No.")
        {
            Clustered = true;
        }
    }
}
