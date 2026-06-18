page 50024 "Calendario festivos"
{
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
    PageType = List;
    SourceTable = "Calendario festivos";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field(Day; Rec.Day)
                {
                    ApplicationArea = All;
                }
                field(Nonworking; Rec.Nonworking)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";

                action("Generar calendario")
                {
                    ApplicationArea = All;
                    Caption = 'Generar calendario';
                    Image = CalcWorkCenterCalendar;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                //RunObject = Report 50011;
                }
            }
        }
    }
    trigger OnOpenPage()
    var
        Rcd_ResourcesSetup: Record 314;
    begin
        Rcd_ResourcesSetup.GET;
        Rcd_ResourcesSetup.TESTFIELD(CodigoCalendarioFestivos);
        Rec.FILTERGROUP:=6;
        Rec.SETFILTER("Calendar Code", Rcd_ResourcesSetup.CodigoCalendarioFestivos);
        Rec.FILTERGROUP:=0;
    end;
}
