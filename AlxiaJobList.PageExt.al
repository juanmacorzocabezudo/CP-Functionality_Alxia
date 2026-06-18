pageextension 50003 AlxiaJobList extends "Job List"
{
    layout
    {
        addafter("No.")
        {
            field(Estado; Rec.Estado)
            {
                ApplicationArea = All;
                StyleExpr = StyleText;
            }
        }
        addafter(Description)
        {
            field("Persona de Contacto 2"; Rec."Persona de Contacto 2")
            {
                ApplicationArea = All;
            }
            field("Total Adultos"; Rec."Total Adultos")
            {
                ApplicationArea = All;
            }
            field("Total Ninos"; Rec."Total Ninos")
            {
                ApplicationArea = All;
            }
            field("Importe Total Evento"; Rec."Importe Total Evento")
            {
                ApplicationArea = All;
            }
            field("Importe Total IVA Incluido"; Rec."Importe Total IVA Incluido")
            {
                ApplicationArea = All;
            }
            field(FechaAlta; Rec.FechaAlta)
            {
                ApplicationArea = All;
            }
            field("Fecha Evento"; Rec."Fecha Evento")
            {
                ApplicationArea = All;
            }
            field("Franja horaria"; Rec."Franja horaria")
            {
                ApplicationArea = All;
            }
            field("Telefono 2"; Rec."Telefono 2")
            {
                ApplicationArea = All;
            }
            /*  field(Telefono; Rec.Telefono)
             {
                 ApplicationArea = All;
             } */
            field("E-Mail 2"; Rec."E-Mail 2")
            {
                ApplicationArea = All;
            }
            /*   field("E-Mail"; Rec."E-Mail")
              {
                  ApplicationArea = All;
              } */
            field(Comentario; Rec.Comentario)
            {
                ApplicationArea = All;
            }
            field("Motivo Anulacion"; Rec."Motivo Anulacion")
            {
                ApplicationArea = All;
            }
            field("Tipo Evento"; Rec."Tipo Evento")
            {
                ApplicationArea = All;
            }
            field("Variedad Evento"; Rec."Variedad Evento")
            {
                ApplicationArea = All;
            }
            field(Contratado; Rec.Contratado)
            {
                ApplicationArea = All;
            }
            field(Senalizado; Rec.Senalizado)
            {
                ApplicationArea = All;
            }
            field("Imp Senal"; Rec."Imp Senal")
            {
                ApplicationArea = All;
            }
            field("Direccion 2"; Rec."Direccion 2")
            {
                ApplicationArea = All;
            }
            field("Codigo Postal 2"; Rec."Codigo Postal 2")
            {
                ApplicationArea = All;
            }
            field("Poblacion 2"; Rec."Poblacion 2")
            {
                ApplicationArea = All;
            }
            field("Provincia 2"; Rec."Provincia 2")
            {
                ApplicationArea = All;
            }
            field(CreadoEnsamblado; Rec.CreadoEnsamblado)
            {
                ApplicationArea = All;
            }
        }
        modify("Bill-to Customer No.")
        {
            Visible = false;
        }
        modify(Status)
        {
            Visible = false;
        }
        modify("Search Description")
        {
            Visible = false;
        }
    }
    trigger OnAfterGetRecord()
    begin
        StyleText:=SetStyle;
    end;
    var StyleText: Text[30];
    procedure SetStyle(): Text[30]begin
        CASE Rec.Estado OF Rec.Estado::Aceptado, Rec.Estado::Realizado: EXIT('Favorable');
        Rec.Estado::Anulado, Rec.Estado::Rechazado: EXIT('Unfavorable');
        Rec.Estado::Archivado: EXIT('Ambiguous');
        Rec.Estado::Presupuesto: EXIT('StrongAccent');
        ELSE
            EXIT('Standard');
        END;
    end;
}
