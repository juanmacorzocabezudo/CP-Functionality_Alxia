table 50010 "Calendario festivos"
{
    fields
    {
        field(1; "Calendar Code"; Code[10])
        {
            Caption = 'Base Calendar Code';
            Editable = false;
            TableRelation = "Base Calendar";
        }
        field(2; Date; Date)
        {
            Caption = 'Date';
            Editable = true;

            trigger OnValidate()
            begin
            // UpdateDayName;
            end;
        }
        field(3; Day; Option)
        {
            Caption = 'Day';
            Editable = false;
            OptionCaption = ' ,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday';
            OptionMembers = " ", Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday;

            trigger OnValidate()
            begin
            //UpdateDayName;
            end;
        }
        field(4; Nonworking; Boolean)
        {
            Caption = 'Nonworking';
            InitValue = false;
        }
        field(5; Description; Text[30])
        {
            Caption = 'Description';
        }
    }
    keys
    {
        key(Key1; "Calendar Code", Date)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
