page 50108 AlxWSAsigRecEventos
{
    ApplicationArea = All;
    Caption = 'AlxWSAsigRecEventos';
    PageType = List;
    SourceTable = "Asignacion Recursos Eventos";
    UsageCategory = Administration;
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Codigo Evento"; Rec."Codigo Evento")
                {
                }
                field(Descripcion_Evento; _DescripEvento)
                {
                    Caption = 'Descripción Evento';
                }
                field("Fecha Evento"; _FechaEvento)
                {
                    Caption = 'Fecha Evento';
                }
                field("Linea Recurso Evento"; Rec."Linea Recurso Evento")
                {
                }
                field("Codigo Recurso"; Rec."Codigo Recurso")
                {
                }
                field(Cantidad; Rec.Cantidad)
                {
                }
                field("Unidad de Medida"; Rec."Unidad de Medida")
                {
                }
                field("Coste Unitario"; Rec."Coste Unitario")
                {
                }
                field("Tarea Realizada"; Rec."Tarea Realizada")
                {
                }
                field(Comentarios; Rec.Comentarios)
                {
                }
                field(Descripcion; Rec.Descripcion)
                {
                }
            }
        }
    }
    var _DescripEvento: Text;
    _FechaEvento: Date;
    trigger OnAfterGetRecord()
    var
        rEvento: Record "Evento";
    begin
        ClearAll();
        if Rec."Codigo Evento" <> '' then if rEvento.Get(Rec."Codigo Evento")then begin
                _DescripEvento:=rEvento.Descripcion;
                _FechaEvento:=rEvento."Fecha Evento";
            end;
    end;
}
