tableextension 50039 AlxReservationEntry extends "Reservation Entry"
{
    fields
    {
        field(50000; AlxMov; Integer)
        {
            Caption = 'AlxMov';
            DataClassification = ToBeClassified;
        }
    }
    procedure MarkMOV()
    var
        CDU: Codeunit FuncionesVarias;
    begin
        CDU.MarkMOV(Rec);
    end;
}
