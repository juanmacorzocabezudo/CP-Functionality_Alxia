pageextension 50035 "AlxShiptoAddress " extends "Ship-to Address"
{
    layout
    {
        addafter("Last Date Modified")
        {
            field(HorarioEntrega; Rec.HorarioEntrega)
            {
                ApplicationArea = All;
            }
        }
    }
}
