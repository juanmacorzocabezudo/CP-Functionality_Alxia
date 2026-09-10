table 50005 "Asignacion Recursos Eventos"
{
    fields
    {
        field(1; "Codigo Evento"; Code[20])
        {
            Editable = false;
            TableRelation = Evento;

            trigger OnValidate()
            begin
                gt_evento.GET("Codigo Evento");
                //"Hora Evento" := gt_evento."Hora Evento";
            end;
        }
        field(2; "Linea Recurso Evento"; Integer)
        {
            TableRelation = "Recursos Evento".Linea WHERE("Codigo Evento" = FIELD("Codigo Evento"));
        }
        field(3; "Codigo Recurso"; Code[20])
        {
            TableRelation = Resource;

            trigger OnValidate()
            begin
                IF "Codigo Recurso" <> '' THEN BEGIN
                    gt_recurso.GET("Codigo Recurso");
                    "Unidad de Medida" := gt_recurso."Base Unit of Measure";
                    "Coste Unitario" := gt_recurso."Unit Cost";
                    Descripcion := gt_recurso.Name;
                END
                ELSE BEGIN
                    Descripcion := '';
                    "Unidad de Medida" := '';
                    "Coste Unitario" := 0;
                END;
            end;
        }
        field(4; Cantidad; Decimal)
        {
            InitValue = 1;
        }
        field(5; "Unidad de Medida"; Code[20])
        {
            TableRelation = "Unit of Measure".Code;
        }
        field(6; "Coste Unitario"; Decimal)
        {
        }
        field(7; "Hora Evento"; Time)
        {
            Editable = false;
            Enabled = false;
        }
        field(8; "Tarea Realizada"; Code[10])
        {
            TableRelation = "Work Type";
        }
        field(9; Comentarios; Text[80])
        {
        }
        field(10; Descripcion; Text[50])
        {
            Caption = 'Descripción';
            Editable = false;
        }
        field(11; Orden; Integer)
        {
            Caption = 'Orden';
        }
    }
    keys
    {
        key(Key1; "Codigo Evento", "Linea Recurso Evento", "Codigo Recurso")
        {
            Clustered = true;
        }
        key(Key2; "Codigo Evento", Orden)
        {
        }
    }
    fieldgroups
    {
    }
    var
        gt_evento: Record Evento;
        gt_recurso: Record Resource;
}
