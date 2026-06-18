table 50034 AlxiaTipoCertificado
{
    Caption = 'AlxiaTipoCertificado';
    DataClassification = CustomerContent;
    LookupPageId = AlxiaTipoCertificados;

    fields
    {
        field(1; "Código"; Code[20])
        {
            Caption = 'Codigo';
        }
        field(2; Certificado; Text[150])
        {
            Caption = 'Certificado';
        }
    }
    keys
    {
        key(PK; Código)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Código", Certificado)
        {
        }
        fieldgroup(Brick; "Código", Certificado)
        {
        }
    }
}
