table 50023 "Work Center Line"
{
    Caption = 'Work Center Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Work Center No."; Code[20])
        {
            Caption = 'Nº Centro Trabajo';
            TableRelation = "Work center Header"."No.";
        }
        field(2; Line; Integer)
        {
            Caption = 'Linea';
            AutoIncrement = true;
        }
        field(3; Type; Option)
        {
            Caption = 'Tipo';
            OptionCaption = 'Persona,Maquina';
            OptionMembers = Person, Machine;
        }
        field(4; "No."; Code[20])
        {
            Caption = 'Nº';
            TableRelation = Resource."No." WHERE(Type=FIELD(Type));

            trigger OnValidate()
            var
                Resource: Record 156;
            begin
                Resource.RESET;
                Resource.SETRANGE(Type, Type);
                Resource.SETRANGE("No.", "No.");
                IF Resource.FINDFIRST THEN BEGIN
                    VALIDATE("Unit of Mesaruement", Resource."Base Unit of Measure");
                    VALIDATE("Resource Cost", Resource."Direct Unit Cost");
                    VALIDATE("Resource Name", Resource.Name);
                END
                ELSE
                BEGIN
                    VALIDATE("Unit of Mesaruement", '');
                    VALIDATE("Resource Cost", 0);
                END;
            end;
        }
        field(5; "Quantity per"; Decimal)
        {
            Caption = 'Cantidad por';
            InitValue = 1;

            trigger OnValidate()
            begin
                VALIDATE(Cost);
            end;
        }
        field(6; "Unit of Mesaruement"; Code[10])
        {
            Caption = 'Unidad Medida';
            Editable = false;
            TableRelation = "Unit of Measure".Code;
        }
        field(7; "Resource Cost"; Decimal)
        {
            Caption = 'Coste Recurso';
            Editable = false;

            trigger OnValidate()
            begin
                VALIDATE(Cost);
            end;
        }
        field(8; Cost; Decimal)
        {
            Caption = 'Coste Total';
            Editable = false;

            trigger OnValidate()
            begin
                Cost:="Quantity per" * "Resource Cost";
            end;
        }
        field(9; "Resource Name"; Text[50])
        {
            Caption = 'Nombre Recurso';
        }
    }
    keys
    {
        key(Key1; "Work Center No.", Line)
        {
            Clustered = true;
        }
    }
}
