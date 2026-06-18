table 50006 "Variedad de Evento"
{
    DrillDownPageID = 50017;
    LookupPageID = 50017;

    fields
    {
        field(1; Codigo; Code[20])
        {
            Caption = 'Código';
        }
        field(2; Descripcion; Text[50])
        {
            Caption = 'Descripción';
        }
        field(3; "Hora Inicio"; Time)
        {
        }
        field(4; "Hora Fin"; Time)
        {
        }
    }
    keys
    {
        key(Key1; Codigo)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; Codigo, Descripcion)
        {
        }
    }
}
