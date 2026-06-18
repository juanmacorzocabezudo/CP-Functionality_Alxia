page 50011 "Introduccion dato"
{
    // 
    // ADVANCE - Log de cambios
    // -----------------------------------------------------
    //   ADVANCE
    //   Fecha: 06-05-2016
    //   Técnico: JMAP
    //   Presupuesto: Proyecto I002483 - RQ600 - Creación de clientes y registro
    //   Modificación:
    // 
    //   Etiqueta: ADV001
    // -----------------------------------------------------
    PageType = StandardDialog;

    layout
    {
        area(content)
        {
            field(txt_Importe; gn_Importe)
            {
                ApplicationArea = All;
                CaptionClass = gfu_GetCaption;
                Caption = 'Importe';
                ToolTip = 'Servicio desestimado por el cliente';
                Visible = gb_MuestraImporte;
            }
        }
    }
    actions
    {
    }
    var gs_Texto: Text;
    gn_Importe: Decimal;
    gb_MuestraImporte: Boolean;
    procedure gfu_SetDialogoImporte(ps_Texto: Text)
    begin
        gb_MuestraImporte:=TRUE;
        gs_Texto:=ps_Texto;
    end;
    procedure gfu_GetDialogoImporte(): Decimal begin
        EXIT(gn_Importe);
    end;
    procedure gfu_GetCaption(): Text begin
        EXIT(gs_Texto);
    end;
}
