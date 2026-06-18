table 50009 "Receta Comentarios"
{
    // ADVANCE - Log de cambios
    // -----------------------------------------------------
    //   ADVANCE
    //   Fecha: 23-05-2016
    //   Técnico: JMAP
    //   Presupuesto: I002074 - Desarrollo funcionalidades Recetas
    //   Modificación:
    // 
    //   Etiqueta: ADV001
    // -----------------------------------------------------
    // #9862 - Se crea el campo nuevo
    // #9969 - Se crea el nuevo campo de subrayado 2
    Caption = 'Comment Line';
    DrillDownPageID = 125;
    LookupPageID = 125;

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
            Description = '#9862';
            OptionCaption = ' ,StandardAccent,Unfavorable,Strong';
            OptionMembers = " ", StandardAccent, Unfavorable, Strong;
        }
        field(11; "Comment 2"; Text[250])
        {
            Caption = 'Comment 3';
            Description = '#9862';
        }
        field(12; "Format Line 2"; Option)
        {
            Caption = 'Format Line 2 2';
            Description = '#9862';
            OptionCaption = ' ,StandardAccent,Unfavorable,Strong';
            OptionMembers = " ", StandardAccent, Unfavorable, Strong;
        }
        field(13; "Subrayado amarillo 2"; Boolean)
        {
            Description = '#9969';
        }
        field(14; ElaboracionText; Blob)
        {
            Caption = 'Elaboracion Text';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "Table Name", "No.", "Line No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
