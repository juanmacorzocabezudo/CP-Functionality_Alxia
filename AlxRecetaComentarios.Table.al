table 50035 AlxRecetaComentarios
{
    Caption = 'AlxRecetaComentarios';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; ElaboracionText; Blob)
        {
            Caption = 'Elaboracion Text';
            DataClassification = CustomerContent;
        }
    }
}
