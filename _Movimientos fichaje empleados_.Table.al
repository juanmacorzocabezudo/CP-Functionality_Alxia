table 50012 "Movimientos fichaje empleados"
{
    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Resource No."; Code[20])
        {
        }
        field(3; "Fecha Fichaje"; Date)
        {
        }
        field(4; "Hora Fichaje"; Time)
        {
            trigger OnValidate()
            begin
                IF("Hora Fichaje" >= 070100T) AND ("Hora Fichaje" < 100100T)THEN "Franja horaria":="Franja horaria"::Desayuno
                ELSE IF("Hora Fichaje" >= 100100T) AND ("Hora Fichaje" < 130100T)THEN "Franja horaria":="Franja horaria"::Almuerzo
                    ELSE IF("Hora Fichaje" >= 130100T) AND ("Hora Fichaje" < 170100T)THEN "Franja horaria":="Franja horaria"::Comida
                        ELSE IF("Hora Fichaje" >= 170100T) AND ("Hora Fichaje" < 193100T)THEN "Franja horaria":="Franja horaria"::Merienda
                            ELSE IF("Hora Fichaje" >= 193100T) AND ("Hora Fichaje" < 223100T)THEN "Franja horaria":="Franja horaria"::Cena
                                ELSE IF(("Hora Fichaje" >= 223100T) AND ("Hora Fichaje" <= 235959T)) OR (("Hora Fichaje" >= 000000T) AND ("Hora Fichaje" <= 010100T))THEN "Franja horaria":="Franja horaria"::Recena
                                    ELSE IF("Hora Fichaje" >= 010100T) AND ("Hora Fichaje" <= 070100T)THEN "Franja horaria":="Franja horaria"::Madrugada
                                        ELSE
                                            "Franja horaria":="Franja horaria"::" ";
            end;
        }
        field(5; "Franja horaria"; Option)
        {
            Editable = false;
            OptionMembers = " ", Desayuno, Almuerzo, Comida, Merienda, Cena, Recena, Madrugada;
        }
        field(6; "Nombre recurso"; Text[100])
        {
            CalcFormula = Lookup(Resource.Name WHERE("No."=FIELD("Resource No.")));
            Editable = false;
            FieldClass = FlowField;
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
