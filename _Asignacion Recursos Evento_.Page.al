page 50013 "Asignacion Recursos Evento"
{
    Caption = 'Asignación Recursos Evento';
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Asignacion Recursos Eventos";
    SourceTableView = SORTING("Codigo Evento", Orden) ORDER(Ascending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Orden; Rec.Orden)
                {
                    ApplicationArea = All;
                }
                field("Linea Recurso Evento"; Rec."Linea Recurso Evento")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Codigo Recurso"; Rec."Codigo Recurso")
                {
                    ApplicationArea = All;
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                }
                field(Cantidad; Rec.Cantidad)
                {
                    ApplicationArea = All;
                }
                field("Unidad de Medida"; Rec."Unidad de Medida")
                {
                    ApplicationArea = All;
                }
                field("Coste Unitario"; Rec."Coste Unitario")
                {
                    ApplicationArea = All;
                }
                field("Tarea Realizada"; Rec."Tarea Realizada")
                {
                    ApplicationArea = All;
                }
                field(Comentarios; Rec.Comentarios)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        AsigRecursosEvento: Record "Asignacion Recursos Eventos";
    begin
        AsigRecursosEvento.SetCurrentKey("Codigo Evento", Orden);
        AsigRecursosEvento.SetRange("Codigo Evento", Rec."Codigo Evento");
        if AsigRecursosEvento.FindLast() then
            Rec.Orden := AsigRecursosEvento.Orden + 1
        else
            Rec.Orden := 1;
    end;
}
