table 50027 "Template Cost Header"
{
    // #9862 - Se crea la tabla nueva
    Caption = 'Template Cost Header';
    DrillDownPageID = 50056;
    LookupPageID = 50056;

    fields
    {
        field(1; "No."; Code[10])
        {
            Caption = 'Nº';
        }
        field(2; Description; Text[50])
        {
            Caption = 'Descripción';
        }
        field(3; "Create Date"; Date)
        {
            Caption = 'Fecha Creación';
            Editable = false;
        }
        field(4; Comment; Text[250])
        {
            Caption = 'Comentario';
        }
        field(5; TipoPlantilla; Option)
        {
            OptionCaption = ' ,Coste,Venta';
            OptionMembers = " ", Coste, Venta;
            Caption = 'Tipo de Plantilla';
        }
    }
    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        "Create Date":=WORKDATE;
    end;
}
