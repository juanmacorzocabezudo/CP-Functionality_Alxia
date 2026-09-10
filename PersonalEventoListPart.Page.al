page 50035 PersonalEventoListPart
{
    PageType = ListPart;
    AutoSplitKey = true;
    Caption = 'Personal Eventos';
    //DelayedInsert = true;
    SourceTable = "Recursos Evento";
    SourceTableView = SORTING("Codigo Evento", Tipo, Linea) ORDER(Ascending) WHERE(Tipo = CONST(Personal));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Tipo; Rec.ImprCapitulo)
                {
                    ApplicationArea = All;
                    Caption = 'Tipo Capítulo';
                }
                field(DescripCapitulo; Rec.DescripCapitulo)
                {
                    ApplicationArea = All;
                    Caption = 'Impresion Capítulo';
                    ToolTip = 'Capítulo al que pertenece.';
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
                field("Unidad de medida"; Rec."Unidad de medida")
                {
                    ApplicationArea = All;
                }
                field("Precio Real"; Rec."Precio Real")
                {
                    ApplicationArea = All;
                }
                field("Coste Unitario"; Rec."Coste Unitario")
                {
                    ApplicationArea = All;
                }
                field("Coste Total"; Rec."Coste Total")
                {
                    ApplicationArea = All;
                }
                field(Precio; Rec.Precio)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Valor Margen"; Rec."Valor Margen")
                {
                    ApplicationArea = All;
                }
                field("Tipo Margen"; Rec."Tipo Margen")
                {
                    ApplicationArea = All;
                }
                field("Precio Propuesto"; Rec."Precio Propuesto")
                {
                    ApplicationArea = All;
                }
                /*  field(Importe; Rec.Importe)
                 {
                     ApplicationArea = All;
                     Visible = false;
                 } */
                field("Tipo Recurso"; Rec."Tipo Recurso")
                {
                    ApplicationArea = All;
                }
                field(Comentarios; Rec.Comentarios)
                {
                    ApplicationArea = All;
                }
                field(Importe; Rec.Importe)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(IVA; Rec."% IVA")
                {
                    ApplicationArea = All;
                    Caption = '% IVA';
                    Visible = false;
                }
                field("Importe IVA"; Rec."Importe IVA Incl.")
                {
                    ApplicationArea = All;
                    Caption = 'Importe IVA Incl.';
                    Visible = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Asignación Recursos a Evento")
            {
                Caption = 'Asignación Recursos a Evento';
                ApplicationArea = All;
                Image = ResourceRegisters;
                RunObject = Page 50013;
                RunPageLink = "Codigo Evento" = FIELD("Codigo Evento");
            }
        }
    }
    trigger OnOpenPage()
    var
        ltEvento: Record Evento;
    begin
        IF Rec."Codigo Evento" <> '' THEN BEGIN
            ltEvento.GET(Rec."Codigo Evento");
            IF ltEvento.Estado = ltEvento.Estado::Realizado THEN CurrPage.EDITABLE := FALSE;
        END;
    end;
}
