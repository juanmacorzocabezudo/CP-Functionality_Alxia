page 50085 AGRALAUbicacionList
{
    Caption = 'Ubicaciones';
    PageType = List;
    SourceTable = 50008;
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Ubicacion; Rec.Ubicacion)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}
