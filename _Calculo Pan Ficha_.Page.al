page 50019 "Calculo Pan Ficha"
{
    // 
    // ADVANCE - Log de cambios
    // -----------------------------------------------------
    //   ADVANCE
    //   Fecha: 19-04-2016
    //   Técnico: JMAP
    //   Presupuesto: Proyecto I002478 - RQ700 Calculo del pan
    // 
    //   Etiqueta: ADV001
    // -----------------------------------------------------
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = Card;
    SourceTable = "Tipo de Evento";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Codigo; Rec.Codigo)
                {
                    ApplicationArea = All;
                    Caption = 'Código Tipo Evento';
                    Editable = false;
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            part(CaclSub; "Calculo pan subform")
            {
                ApplicationArea = All;
                SubPageLink = "Cod. Tipo Evento"=FIELD(Codigo);
            }
        }
    }
    actions
    {
    }
}
