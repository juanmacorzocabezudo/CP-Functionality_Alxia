page 50028 "Intro datos lote y seg prod"
{
    // ADVANCE - Log de cambios
    // -----------------------------------------------------
    //   ADVANCE
    //   Fecha: 15-11-2016
    //   Técnico: JMAP
    //   Presupuesto: Proyecto I003490 - Proceso completar Lotes y seguimientos
    //   Etiqueta: ADV001
    // -----------------------------------------------------
    PageType = StandardDialog;

    layout
    {
        area(content)
        {
            field(txt_CodSeg; gc_CodSeguimiento)
            {
                ApplicationArea = All;
                Caption = 'Item Tracking Code';
                TableRelation = "Item Tracking Code";
            }
            field(txt_LotNo; gc_LotNo)
            {
                ApplicationArea = All;
                Caption = 'Lot No.';
            }
        }
    }
    actions
    {
    }
    trigger OnQueryClosePage(CloseAction: Action): Boolean begin
        IF CloseAction IN[ACTION::OK, ACTION::LookupOK]THEN lfu_OKOnPush;
    end;
    var gc_CodSeguimiento: Code[10];
    gc_LotNo: Code[20];
    Text10000: Label 'Debe introducir un Cód. seguim. prod.';
    Text20000: Label 'Debe introducir un Nº lote';
    Text30000: Label 'El Cód. seguim. prod. introducido no existe.';
    procedure gfu_GetDatosLoteSeg(var pc_CodSeg: Code[10]; var pc_Lote: Code[20])
    begin
        pc_CodSeg:=gc_CodSeguimiento;
        pc_Lote:=gc_LotNo;
    end;
    local procedure lfu_OKOnPush()
    var
        lt_ItemTrackingCode: Record 6502;
    begin
        IF gc_CodSeguimiento = '' THEN ERROR(Text10000);
        IF gc_LotNo = '' THEN ERROR(Text20000);
        IF NOT lt_ItemTrackingCode.GET(gc_CodSeguimiento)THEN ERROR(Text30000);
    end;
}
