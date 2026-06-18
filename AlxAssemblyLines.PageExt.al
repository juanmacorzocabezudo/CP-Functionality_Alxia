pageextension 50049 AlxAssemblyLines extends "Assembly Lines"
{
    layout
    {
        addbefore("Due Date")
        {
            field(_FechaProduccion; _FechaProduccion)
            {
                ApplicationArea = All;
                Caption = 'Fecha producción';
            }
        }
    }
    var _FechaProduccion: Date;
    trigger OnAfterGetRecord()
    var
        rAssemblyHeader: Record "Assembly Header";
    begin
        Clear(_FechaProduccion);
        rAssemblyHeader.Reset();
        rAssemblyHeader.SetRange("No.", Rec."Document No.");
        if rAssemblyHeader.FindFirst()then _FechaProduccion:=rAssemblyHeader.AGRALAFechaProduccion;
    end;
}
