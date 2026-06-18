pageextension 50008 AlxiaResourcesSetup extends "Resources Setup"
{
    layout
    {
        addafter("Time Sheet First Weekday")
        {
            field(CodigoCalendarioFestivos; Rec.CodigoCalendarioFestivos)
            {
                ApplicationArea = All;
            }
        }
    }
}
