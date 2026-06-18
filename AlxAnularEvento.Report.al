report 50140 AlxAnularEvento
{
    Caption = 'Anular Evento';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Cabfactura; Evento)
        {
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group("Anular Evento")
                {
                    field(MotivoAnulacion; MotivoAnulacion)
                    {
                        Caption = 'Motivo Anulacion';
                        ApplicationArea = all;
                    }
                }
            }
        }
    }
    trigger OnPostReport()
    var
        recEvento: Record Evento;
    begin
        if(MotivoAnulacion <> '')then begin
            recEvento.Reset();
            recEvento.SetRange("Codigo Evento", Evento);
            if recEvento.FindFirst()then begin
                recEvento."Motivo Anulacion":=MotivoAnulacion;
                recEvento.Estado:=recEvento.Estado::Anulado;
                recEvento.Modify();
            end;
        end;
    end;
    procedure SetEvento(setParameters: Text)
    begin
        Evento:=setParameters;
    end;
    var MotivoAnulacion: Text;
    Evento: Code[20];
}
