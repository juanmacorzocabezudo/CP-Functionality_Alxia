table 50008 AGRALAUbicacion
{
    Caption = 'AGRALAUbicacion';
    DataClassification = CustomerContent;
    DrillDownPageID = 50085;
    LookupPageID = 50085;

    fields
    {
        field(1; Ubicacion; Code[30])
        {
            Caption = 'Ubicacion';
        }
    }
    keys
    {
        key(PK; Ubicacion)
        {
            Clustered = true;
        }
    }
}
