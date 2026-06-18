report 50009 "Informe Personal Eventos"
{
    // 
    // ADVANCE - Log de cambios
    // -----------------------------------------------------
    //   ADVANCE
    //   Fecha: 24-05-2016
    //   Técnico: JMAP
    //   Presupuesto: Proyecto I002642 - Gestión de calendarios
    //   Modificación:
    // 
    //   Etiqueta: ADV001
    // -----------------------------------------------------
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layout/InformePersonalEventos.rdlc';
    Caption = 'Informe Personal Eventos';
    Description = 'Informe Personal Eventos';
    ShowPrintStatus = true;
    UsageCategory = Administration;

    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = SORTING("No.")ORDER(Ascending)WHERE(Status=CONST(Active), "Resource No."=FILTER(<>''));
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin
                Rcd_ResourceTMP.INIT;
                Rcd_ResourceTMP."No.":=Employee."Resource No.";
                Rcd_ResourceTMP.INSERT;
            end;
            trigger OnPreDataItem()
            begin
                SETRANGE(Status, Employee.Status::Active);
                SETFILTER("Resource No.", '<>%1', '');
                Rcd_ResourceTMP.RESET;
                Rcd_ResourceTMP.DELETEALL;
            end;
        }
        dataitem(Evento;50004)
        {
            DataItemTableView = SORTING("Fecha Evento", "Hora Evento")ORDER(Ascending);
            PrintOnlyIfDetail = true;

            dataitem("Asignacion Recursos Eventos";50005)
            {
                DataItemLink = "Codigo Evento"=FIELD("Codigo Evento");
                DataItemTableView = SORTING("Codigo Evento", "Linea Recurso Evento", "Codigo Recurso")ORDER(Ascending);

                trigger OnAfterGetRecord()
                begin
                    IF NOT Rcd_ResourceTMP.GET("Codigo Recurso")THEN CurrReport.SKIP;
                    //Busca si existe
                    Rcd_ListPersonalAuxTMP.RESET;
                    Rcd_ListPersonalAuxTMP.SETRANGE("Codigo Evento", "Asignacion Recursos Eventos"."Codigo Evento");
                    Rcd_ListPersonalAuxTMP.SETRANGE("Codigo Recurso", "Asignacion Recursos Eventos"."Codigo Recurso");
                    IF Rcd_ListPersonalAuxTMP.ISEMPTY THEN BEGIN
                        CLEAR(Rcd_ListPersonalAuxTMP);
                        intEntryNo:=intEntryNo + 1;
                        Rcd_ListPersonalAuxTMP.INIT;
                        Rcd_ListPersonalAuxTMP."Entry No.":=intEntryNo;
                        Rcd_ListPersonalAuxTMP."Codigo Evento":="Asignacion Recursos Eventos"."Codigo Evento";
                        Rcd_ListPersonalAuxTMP."Codigo Recurso":="Asignacion Recursos Eventos"."Codigo Recurso";
                        Rcd_ListPersonalAuxTMP.Fecha:=Evento."Fecha Evento";
                        Rcd_ListPersonalAuxTMP.Hora:=Evento."Hora Evento";
                        Rcd_ListPersonalAuxTMP."Franja horaria":=Evento."Franja horaria";
                        Rcd_ListPersonalAuxTMP.Tipo:=Rcd_ListPersonalAuxTMP.Tipo::Evento;
                        Rcd_ListPersonalAuxTMP."Tarea Realizada":="Asignacion Recursos Eventos"."Tarea Realizada";
                        Rcd_ListPersonalAuxTMP.Extra:=lfu_EsExtra(Rcd_ListPersonalAuxTMP."Codigo Recurso", Rcd_ListPersonalAuxTMP.Fecha, Rcd_ListPersonalAuxTMP.Hora);
                        Rcd_ListPersonalAuxTMP.INSERT(TRUE);
                    END;
                end;
                trigger OnPreDataItem()
                begin
                    SETFILTER("Codigo Recurso", '<>%1', '');
                end;
            }
            trigger OnPreDataItem()
            begin
                SETRANGE("Fecha Evento", FechaDesde, FechaHasta);
            end;
        }
        dataitem("Movimientos fichaje empleados";50012)
        {
            DataItemTableView = SORTING("Entry No.")ORDER(Ascending);

            trigger OnAfterGetRecord()
            var
                lb_Extra: Boolean;
            begin
                IF NOT Rcd_ResourceTMP.GET("Resource No.")THEN CurrReport.SKIP;
                CLEAR(lb_Extra);
                lb_Extra:=lfu_EsExtra("Resource No.", "Fecha Fichaje", "Hora Fichaje");
                //Solo sacamos lineas de fichajes si son Extra
                IF lb_Extra THEN BEGIN
                    Rcd_ListPersonalAuxTMP.RESET;
                    Rcd_ListPersonalAuxTMP.SETRANGE("Codigo Recurso", "Resource No.");
                    Rcd_ListPersonalAuxTMP.SETRANGE(Fecha, "Fecha Fichaje");
                    //Rcd_ListPersonalAuxTMP.SETRANGE("Franja horaria","Franja horaria");
                    //Rcd_ListPersonalAuxTMP.SETRANGE(Tipo,Rcd_ListPersonalAuxTMP.Tipo::Fichaje);
                    Rcd_ListPersonalAuxTMP.SETRANGE(Extra, lb_Extra);
                    IF Rcd_ListPersonalAuxTMP.ISEMPTY THEN BEGIN
                        intEntryNo:=intEntryNo + 1;
                        CLEAR(Rcd_ListPersonalAuxTMP);
                        Rcd_ListPersonalAuxTMP.INIT;
                        Rcd_ListPersonalAuxTMP."Entry No.":=intEntryNo;
                        Rcd_ListPersonalAuxTMP."Codigo Evento":='PRESENCIA';
                        Rcd_ListPersonalAuxTMP."Codigo Recurso":="Movimientos fichaje empleados"."Resource No.";
                        Rcd_ListPersonalAuxTMP.Fecha:="Movimientos fichaje empleados"."Fecha Fichaje";
                        Rcd_ListPersonalAuxTMP.Hora:="Movimientos fichaje empleados"."Hora Fichaje";
                        Rcd_ListPersonalAuxTMP."Franja horaria":="Movimientos fichaje empleados"."Franja horaria";
                        Rcd_ListPersonalAuxTMP.Tipo:=Rcd_ListPersonalAuxTMP.Tipo::Fichaje;
                        Rcd_ListPersonalAuxTMP."Tarea Realizada":='';
                        Rcd_ListPersonalAuxTMP.Extra:=lb_Extra;
                        Rcd_ListPersonalAuxTMP.INSERT(TRUE);
                    END;
                END;
            end;
            trigger OnPreDataItem()
            begin
                SETRANGE("Fecha Fichaje", FechaDesde, FechaHasta);
            end;
        }
        dataitem(LineasPresencia;2000000026)
        {
            DataItemTableView = SORTING(Number)ORDER(Ascending);

            column(Evento_CodigoEvento; Rcd_ListPersonalAuxTMP."Codigo Evento")
            {
            }
            column(Evento_FechaEvento; Rcd_ListPersonalAuxTMP.Fecha)
            {
            }
            column(Evento_HoraEvento; Rcd_ListPersonalAuxTMP.Hora)
            {
            }
            column(Evento_Descripcion; txtDescripcion)
            {
            }
            column(Evento_FranjaHorario; Rcd_ListPersonalAuxTMP."Franja horaria")
            {
            }
            column(Evento_DiaSemana; DiaSemana)
            {
            }
            column(txtFiltro; txtFiltro)
            {
            }
            column(LineaTipo; Rcd_ListPersonalAuxTMP.Tipo)
            {
            }
            column(Recurso_Codigo; Rcd_ListPersonalAuxTMP."Codigo Recurso")
            {
            }
            column(Recurso_Nombre; NombreRecurso)
            {
            }
            column(Recurso_Tarea; Rcd_ListPersonalAuxTMP."Tarea Realizada")
            {
            }
            column(Recurso_Extra; Rcd_ListPersonalAuxTMP.Extra)
            {
            }
            trigger OnAfterGetRecord()
            var
                Rcd_Recurso: Record 156;
                lt_Evento: Record 50004;
            begin
                IF Number = 1 THEN BEGIN
                    Rcd_ListPersonalAuxTMP.FINDSET END
                ELSE
                    Rcd_ListPersonalAuxTMP.NEXT;
                CLEAR(NombreRecurso);
                CLEAR(txtDescripcion);
                CLEAR(DiaSemana);
                DiaSemana:=DATE2DWY(Rcd_ListPersonalAuxTMP.Fecha, 1);
                Rcd_Recurso.Reset();
                Rcd_Recurso.SetRange("No.", Rcd_ListPersonalAuxTMP."Codigo Recurso");
                if Rcd_Recurso.FindFirst()then NombreRecurso:=Rcd_Recurso.Name
                else
                    NombreRecurso:='Recurso eliminado';
                //Rcd_Recurso.GET(Rcd_ListPersonalAuxTMP."Codigo Recurso");
                //NombreRecurso := Rcd_Recurso.Name;
                IF Rcd_ListPersonalAuxTMP.Tipo = Rcd_ListPersonalAuxTMP.Tipo::Evento THEN BEGIN
                    lt_Evento.GET(Rcd_ListPersonalAuxTMP."Codigo Evento");
                    txtDescripcion:=lt_Evento.Descripcion;
                END
                ELSE
                    txtDescripcion:='Presencia registrada';
            end;
            trigger OnPreDataItem()
            begin
                Rcd_ListPersonalAuxTMP.RESET;
                SETRANGE(Number, 1, Rcd_ListPersonalAuxTMP.COUNT);
            end;
        }
    }
    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Filtros';

                    field(FechaDesde; FechaDesde)
                    {
                        ApplicationArea = All;
                        Caption = 'Fecha Desde';
                    }
                    field(FechaHasta; FechaHasta)
                    {
                        ApplicationArea = All;
                        Caption = 'Fecha Hasta';
                    }
                }
            }
        }
        actions
        {
        }
    }
    labels
    {
    lblCodigoEvento='Código evento';
    lblFecha='Fecha';
    lblHora='Hora';
    lblTarea='Tarea';
    lblNombre='Nombre / Empresa';
    lblTitulo='INFORME DE PERSONAL EN EVENTOS DE CATERING';
    lblNumEventos='Nº de eventos:';
    lblNumExtras='Nº de extras:';
    }
    trigger OnPreReport()
    begin
        Rcd_ResourcesSetup.GET;
        Rcd_ResourcesSetup.TESTFIELD(CodigoCalendarioFestivos);
        IF(FechaDesde = 0D) OR (FechaHasta = 0D)THEN ERROR(Text20000);
        txtFiltro:=STRSUBSTNO(Text30000, FechaDesde, FechaHasta);
        intEntryNo:=0;
    end;
    var DiaSemana: Option " ", Lunes, Martes, "Miércoles", Jueves, Viernes, "Sábado", Domingo;
    NombreRecurso: Text[50];
    Text10000: Label 'No existe ficha de empleado para el recurso %1.';
    FechaDesde: Date;
    FechaHasta: Date;
    Text20000: Label 'Debe introducir Fecha Desde y Fecha Hasta';
    Text30000: Label 'Entre el %1 y el %2';
    txtFiltro: Text[250];
    Rcd_ResourceTMP: Record 156 temporary;
    Rcd_ResourcesSetup: Record 314;
    Rcd_ListPersonalAuxTMP: Record 50013 temporary;
    txtDescripcion: Text[80];
    intEntryNo: Integer;
    local procedure lfu_EsExtra(_codRecurso: Code[20]; _fecha: Date; _hora: Time)LineaExtra: Boolean var
        lo_DiaSemana: Option " ", Lunes, Martes, "Miércoles", Jueves, Viernes, "Sábado", Domingo;
        Rcd_CalendarioFestivos: Record 50010;
        Rcd_Employee: Record 5200;
        Rcd_EmployeeAbsence: Record 5207;
    begin
        CLEAR(LineaExtra);
        CLEAR(lo_DiaSemana);
        lo_DiaSemana:=DATE2DWY(_fecha, 1);
        Rcd_CalendarioFestivos.RESET;
        Rcd_CalendarioFestivos.SETRANGE("Calendar Code", Rcd_ResourcesSetup.CodigoCalendarioFestivos);
        Rcd_CalendarioFestivos.SETRANGE(Date, _fecha);
        Rcd_CalendarioFestivos.SETRANGE(Nonworking, TRUE);
        IF Rcd_CalendarioFestivos.FINDFIRST THEN LineaExtra:=TRUE
        ELSE
        BEGIN
            Rcd_Employee.RESET;
            Rcd_Employee.SETRANGE("Resource No.", _codRecurso);
            IF NOT Rcd_Employee.FINDFIRST THEN ERROR(Text10000, _codRecurso);
            Rcd_EmployeeAbsence.RESET;
            Rcd_EmployeeAbsence.SETRANGE("Employee No.", Rcd_Employee."No.");
            Rcd_EmployeeAbsence.SETFILTER("From Date", '<=%1', _fecha);
            Rcd_EmployeeAbsence.SETFILTER("To Date", '>=%1', _fecha);
            IF Rcd_EmployeeAbsence.FINDFIRST THEN LineaExtra:=TRUE
            ELSE
            BEGIN
                CASE lo_DiaSemana OF lo_DiaSemana::Lunes: IF NOT((Rcd_Employee.HorarioIniLunes <= _hora) AND (Rcd_Employee.HorarioFinLunes >= _hora))THEN LineaExtra:=TRUE;
                lo_DiaSemana::Martes: IF NOT((Rcd_Employee.HorarioIniMartes <= _hora) AND (Rcd_Employee.HorarioFinMartes >= _hora))THEN LineaExtra:=TRUE;
                lo_DiaSemana::Miércoles: IF NOT((Rcd_Employee.HorarioIniMiercoles <= _hora) AND (Rcd_Employee.HorarioFinMiercoles >= _hora))THEN LineaExtra:=TRUE;
                lo_DiaSemana::Jueves: IF NOT((Rcd_Employee.HorarioIniJueves <= _hora) AND (Rcd_Employee.HorarioFinJueves >= _hora))THEN LineaExtra:=TRUE;
                lo_DiaSemana::Viernes: IF NOT((Rcd_Employee.HorarioIniViernes <= _hora) AND (Rcd_Employee.HorarioFinViernes >= _hora))THEN LineaExtra:=TRUE;
                lo_DiaSemana::Sábado: IF NOT((Rcd_Employee.HorarioIniSabado <= _hora) AND (Rcd_Employee.HorarioFinSabado >= _hora))THEN LineaExtra:=TRUE;
                lo_DiaSemana::Domingo: IF NOT((Rcd_Employee.HorarioIniDomingo <= _hora) AND (Rcd_Employee.HorarioFinDomingo >= _hora))THEN LineaExtra:=TRUE;
                END;
            END;
        END;
    end;
}
