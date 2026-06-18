page 50014 "Lista de Eventos Realizados"
{
    // -----------------------------------------------------
    //   ADVANCE
    //   Fecha: 29-07-2020
    //   Técnico: CPL
    //   Presupuesto: I015245 - No mostrar en eve. realizados los archivados.
    //   Modificación:
    //   Etiqueta: ADV001
    // -----------------------------------------------------
    CardPageID = "Ficha Evento Realizado";
    Editable = false;
    PageType = List;
    SourceTable = Evento;
    SourceTableView = SORTING("Codigo Evento")ORDER(Ascending)WHERE(Estado=FILTER(Realizado|Archivado));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Codigo Evento"; Rec."Codigo Evento")
                {
                    ApplicationArea = All;
                }
                field(Estado; Rec.Estado)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleText;
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                }
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
                field("Hora Evento"; Rec."Hora Evento")
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
                field("E-Mail 2"; Rec."E-Mail 2")
                {
                    ApplicationArea = All;
                }
                field(Telefono; Rec.Telefono)
                {
                    ApplicationArea = All;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                }
                field("Persona de Contacto"; Rec."Persona de Contacto")
                {
                    ApplicationArea = All;
                }
                field(Comentario; Rec.Comentario)
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
            }
        }
    }
    actions
    {
        area(reporting)
        {
            action(Imprimir)
            {
                ApplicationArea = All;
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Rcd_Eventos: Record Evento;
                begin
                    Rcd_Eventos.RESET;
                    Rcd_Eventos.SETRANGE("Codigo Evento", Rec."Codigo Evento");
                    REPORT.RUNMODAL(50007, TRUE, FALSE, Rcd_Eventos)end;
            }
            action("Cuadrante Eventos")
            {
                ApplicationArea = All;
                Image = PrintReport;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    REPORT.RUNMODAL(50008);
                end;
            }
        }
        area(navigation)
        {
            action("Movs. comisiones")
            {
                ApplicationArea = All;
                Image = ActivateDiscounts;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 50025;
                RunPageView = SORTING("Entry No.")ORDER(Ascending)WHERE(NoEvento=CONST('<>"''"'));
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        StyleText:=SetStyle;
    end;
    trigger OnOpenPage()
    begin
        //ADV001 Inicio
        //SETFILTER(Estado,'%1|%2',Estado::Realizado,Estado::Archivado);
        Rec.SETFILTER(Estado, '%1', Rec.Estado::Realizado);
    //ADV001 Fin
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
