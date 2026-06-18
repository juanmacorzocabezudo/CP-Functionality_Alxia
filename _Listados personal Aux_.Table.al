table 50013 "Listados personal Aux"
{
    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Codigo Evento"; Code[20])
        {
        }
        field(3; "Codigo Recurso"; Code[20])
        {
            TableRelation = Resource;
        }
        field(4; Fecha; Date)
        {
        }
        field(5; Hora; Time)
        {
        }
        field(6; "Franja horaria"; Option)
        {
            Editable = false;
            OptionMembers = " ", Desayuno, Almuerzo, Comida, Merienda, Cena, Recena, Madrugada;
        }
        field(7; "Tarea Realizada"; Code[10])
        {
            TableRelation = "Work Type";
        }
        field(8; Tipo; Option)
        {
            OptionMembers = Evento, Fichaje;
        }
        field(9; Extra; Boolean)
        {
        }
    }
    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
