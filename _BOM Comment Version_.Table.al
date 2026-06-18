table 50026 "BOM Comment Version"
{
    // #9862 - Se crea la tabla nueva
    Caption = 'BOM Comment Version';

    fields
    {
        field(1; "Table Name"; Option)
        {
            Caption = 'Table Name';
            OptionMembers = Receta;
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(4; "BOM Version"; Integer)
        {
            Caption = 'BOM Version';
        }
        field(6; Comment; Text[250])
        {
            Caption = 'Comment';
        }
        field(7; "Imprime Rojo"; Boolean)
        {
        }
        field(8; "Subrayado amarillo"; Boolean)
        {
        }
        field(10; "Format Line"; Option)
        {
            Caption = 'Format Line';
            OptionCaption = ' ,StandardAccent,Unfavorable,Strong';
            OptionMembers = " ", StandardAccent, Unfavorable, Strong;
        }
        field(11; "Comment 2"; Text[250])
        {
            Caption = 'Comment 3';
        }
        field(12; "Format Line 2"; Option)
        {
            Caption = 'Format Line 2 2';
            OptionCaption = ' ,StandardAccent,Unfavorable,Strong';
            OptionMembers = " ", StandardAccent, Unfavorable, Strong;
        }
    }
    keys
    {
        key(Key1; "Table Name", "No.", "BOM Version", "Line No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
