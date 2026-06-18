page 50036 Escalados
{
    // -----------------------------------------------------
    //   ADVANCE
    //   Fecha: 12-11-2018
    //   Técnico: JAB
    //   Presupuesto: I009029 - Gestión de escalados
    //   Modificación: Mostrar el campo de Tipo Recurso
    //   Etiqueta: ADV001
    // -----------------------------------------------------
    PageType = List;
    SourceTable = Escalados;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(NumeroLM; Rec.NumeroLM)
                {
                    ApplicationArea = All;
                }
                field(NumeroLinea; Rec.NumeroLinea)
                {
                    ApplicationArea = All;
                }
                field(Tipo; Rec.Tipo)
                {
                    ApplicationArea = All;
                }
                field(gtxt_TipoRecurso; gtxt_TipoRecurso)
                {
                    ApplicationArea = All;
                    Caption = 'Tipo Recurso';
                }
                field(Numero; Rec.Numero)
                {
                    ApplicationArea = All;
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                }
                field(CodigoUnidadMedida; Rec.CodigoUnidadMedida)
                {
                    ApplicationArea = All;
                }
                field(LoteReceta; Rec.LoteReceta)
                {
                    ApplicationArea = All;
                }
                field(CantidadLoteReceta; Rec.CantidadLoteReceta)
                {
                    ApplicationArea = All;
                }
                field(TipoTramo; Rec.TipoTramo)
                {
                    ApplicationArea = All;
                }
                field(CalculoProporcional; Rec.CalculoProporcional)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        lt_Componente: Record "BOM Component";
    begin
        // Inicio ADV001
        gt_Componente.RESET;
        IF gt_Componente.GET(Rec.NumeroLM, Rec.NumeroLinea)THEN gtxt_TipoRecurso:=FORMAT(gt_Componente.TipoRecurso);
    // Fin ADV001
    end;
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        // Inicio ADV001
        gt_Componente.RESET;
        IF gt_Componente.GET(Rec.NumeroLM, Rec.NumeroLinea)THEN gtxt_TipoRecurso:=FORMAT(gt_Componente.TipoRecurso);
        Rec.CalculoProporcional:=TRUE;
    // Fin ADV001
    end;
    var gtxt_TipoRecurso: Text;
    gt_Componente: Record "BOM Component";
    trigger OnClosePage()
    begin
        if Rec.FindFirst()then repeat if Rec.LoteReceta = 0 then Error('El campo Lote Receta no puede ser 0 en la línea' + ' ' + Format(Rec.NumeroLinea));
            until Rec.Next() = 0;
    end;
}
