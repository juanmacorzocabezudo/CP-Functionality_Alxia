page 50004 "Lista de Eventos"
{
    Caption = 'Lista Eventos';
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageID = "Ficha Evento";
    Editable = false;
    PageType = List;
    SourceTable = Evento;
    SourceTableView = SORTING("Codigo Evento") ORDER(Ascending);

    //WHERE(Estado = FILTER(Presupuesto | Aceptado | Rechazado | Anulado));
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
                field(Telefono; Rec.Telefono)
                {
                    ApplicationArea = All;
                }
                field("E-Mail 2"; Rec."E-Mail 2")
                {
                    ApplicationArea = All;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                }
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
                field("Importe Rechazado"; Rec."Importe Rechazado")
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
                Caption = 'Imprimir';
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
                    REPORT.RUNMODAL(50007, TRUE, FALSE, Rcd_Eventos)
                end;
            }
            action("Cuadrante Eventos")
            {
                Caption = 'Cuadrante Eventos';
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
            action("Informe Personal en Eventos")
            {
                Caption = 'Informe Personal en Eventos';
                ApplicationArea = All;
                Image = PeriodStatus;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    REPORT.RUNMODAL(50009);
                end;
            }
            action("Asignación Recursos a Evento")
            {
                Caption = 'Asignación Recursos a Evento';
                ApplicationArea = All;
                Image = ResourceRegisters;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                var
                    rRecEvento: Record "Recursos Evento";
                    rAsigEvento: Record "Asignacion Recursos Eventos";
                    pAsigRec: Page "Asignacion Recursos Evento";
                begin
                    rRecEvento.Reset();
                    rRecEvento.SetRange("Codigo Evento", Rec."Codigo Evento");
                    //JMC 17/08/26 Evitamos filtrar por código recurso
                    //rRecEvento.SetRange("Codigo Recurso", 'REC00005');
                    //rRecEvento.SetRange("Codigo Evento", Rec."Codigo Evento");
                    //rRecEvento.SetRange(Tipo, rRecEvento.Tipo::Personal);
                    if rRecEvento.FindFirst() then begin
                        rAsigEvento.Reset();
                        rAsigEvento.SetRange("Codigo Evento", Rec."Codigo Evento");
                        //JMC 17/08/26 Evitamos filtrar por Linea
                        //rAsigEvento.SetRange("Linea Recurso Evento", rRecEvento.Linea);
                        pAsigRec.SetTableView(rAsigEvento);
                        pAsigRec.Run();
                        /*       
                            RunObject = Page 50013;
                            RunPageLink = "Codigo Evento" = FIELD("Codigo Evento"),
                                       "Linea Recurso Evento" = const(10000); */
                    end;
                end;
                /*  trigger OnAction()
                     var
                         recRecursosEv: Record "Recursos Evento";
                         recAsigRecursos: Record "Asignacion Recursos Eventos";
                     begin
                         recRecursosEv.Reset();
                         recRecursosEv.SetRange("Codigo Evento", Rec."Codigo Evento");
                         recRecursosEv.SetRange("Codigo Recurso", 'REC00005');
                         if recRecursosEv.FindFirst() then begin
                             recAsigRecursos.Reset();
                             recAsigRecursos."Codigo Evento" := Rec."Codigo Evento";
                             recAsigRecursos."Linea Recurso Evento" := recRecursosEv.Linea;
                             recAsigRecursos.SetRange("Codigo Evento", Rec."Codigo Evento");
                             if recAsigRecursos.FindFirst() then
                                 //if recAsigRecursos.FindFirst() then
                                 PAGE.RUNMODAL(PAGE::"Asignacion Recursos Evento", recAsigRecursos);
                         end;

                     end; */
            }
            /*  action("Informe Personal Falta en Eventos")
                 {
                     Caption = 'Informe Personal Falta en Eventos';
                     ApplicationArea = All;
                     Image = Period;
                     Promoted = true;
                     PromotedCategory = "Report";
                     PromotedIsBig = true;

                     trigger OnAction()
                     begin
                         REPORT.RUNMODAL(50010);
                     end;
                 } */
        }
        area(navigation)
        {
            action("Cambiar Estado")
            {
                Caption = 'Cambiar Estado';
                ApplicationArea = All;
                Image = ChangeStatus;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.gfu_CambiarEstadoList;
                    CurrPage.Update(true);
                end;
            }
            action("Movs. comisiones")
            {
                Caption = 'Movs. comisiones';
                ApplicationArea = All;
                Image = ActivateDiscounts;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Movimientos comisiones";
                RunPageView = SORTING("Entry No.") ORDER(Ascending) WHERE(NoEvento = CONST('<>"''"'));
            }
            action("Movs. fichajes empleados")
            {
                Image = AbsenceCalendar;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 50027;
            }
            action(Comisiones)
            {
                Caption = 'Comisiones';
                ApplicationArea = All;
                Image = CashFlow;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                /*  RunObject = Page 50021;
                     RunPageLink = "Customer No." = FIELD("Codigo Cliente");
                     RunPageView = SORTING("Customer No.", "Item No.", Tramo); */
            }
            action("AjusProvincia")
            {
                Caption = 'Ajustar Poblacion y Provincia';
                ApplicationArea = All;
                Image = ChangeBatch;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    if Confirm('Esta seguro de actualizar los nombres de la poblacion y provincia?') then ValidadCP();
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.SetCurrentKey("Fecha Evento");
        Rec.Ascending(false);
    end;

    trigger OnAfterGetRecord()
    begin
        StyleText := SetStyle;
    end;

    var
        StyleText: Text[30];

    procedure SetStyle(): Text[30]
    begin
        CASE Rec.Estado OF
            Rec.Estado::Aceptado, Rec.Estado::Realizado:
                EXIT('Favorable');
            Rec.Estado::Anulado:
                EXIT('Unfavorable');
            Rec.Estado::Rechazado:
                EXIT('Ambiguous');
            Rec.Estado::Presupuesto:
                EXIT('StrongAccent');
            ELSE
                EXIT('Standard');
        END;
    end;

    procedure AjustarProvincia()
    var
        recEventos: Record Evento;
        recArea: Record "Area";
        recArea2: Record "Area";
        Update: Boolean;
    begin
        recEventos.Reset();
        recEventos.SetFilter(FechaAlta, '010124..130824');
        recEventos.FindFirst();
        repeat
            Update := false;
            if IsNumeric(recEventos.Provincia) then begin
                recArea.Reset();
                recArea.SetRange(Code, recEventos.Provincia);
                if recArea.FindFirst() then begin
                    recEventos.Provincia := recArea.Text;
                    Update := true;
                end;
            end;
            if IsNumeric(recEventos."Provincia 2") then begin
                recArea2.Reset();
                recArea2.SetRange(Code, recEventos."Provincia 2");
                if recArea2.FindFirst() then begin
                    recEventos."Provincia 2" := recArea.Text;
                    Update := true;
                end;
            end;
            if Update then recEventos.Modify();
        until recEventos.Next() = 0;
    end;

    local procedure IsNumeric(Value: Text): Boolean
    var
        i: Integer;
    begin
        for i := 1 to StrLen(Value) do if (Format(Value[i]) in ['0' .. '9']) or (Format(Value[i]) in ['.']) then
                if StrLen(DelChr(Value, '=', DelChr(Value, '=', '.'))) <= 1 then
                    exit(true)
                else
                    exit(false)
            else
                exit(false);
    end;

    procedure ValidadCP()
    var
        recEventos: Record Evento;
        recPostCode: Record "Post Code";
        Update: Boolean;
        Progress: Dialog;
        Text000: Label 'Analizando Evento ------ #1';
        nroEvento: Text;
    begin
        Progress.OPEN(Text000, nroEvento);
        recEventos.Reset();
        //recEventos.SetFilter(FechaAlta, '010124..130824');
        recEventos.FindFirst();
        repeat
            Update := false;
            nroEvento := recEventos."Codigo Evento";
            Progress.UPDATE();
            if recEventos."Codigo Postal" <> '' then begin
                recPostCode.Reset();
                recPostCode.SetRange(Code, recEventos."Codigo Postal");
                if recPostCode.FindFirst() then begin
                    recEventos.Validate("Codigo Postal");
                    Update := true;
                end;
            end;
            if recEventos."Codigo Postal 2" <> '' then begin
                recPostCode.Reset();
                recPostCode.SetRange(Code, recEventos."Codigo Postal 2");
                if recPostCode.FindFirst() then begin
                    recEventos.Validate("Codigo Postal 2");
                    Update := true;
                end;
            end;
            if Update then recEventos.Modify();
        until recEventos.Next() = 0;
        Progress.CLOSE();
    end;
}
