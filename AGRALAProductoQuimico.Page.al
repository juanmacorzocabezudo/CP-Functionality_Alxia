page 50073 AGRALAProductoQuimico
{
    ApplicationArea = All;
    Caption = 'Producto químico';
    PageType = List;
    SourceTable = "Item Variant";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    Editable = true;
                    TableRelation = "Item Variant".Code WHERE("Item No."=FIELD("Item No."));
                }
                field(AGRALADescripcion; Rec.AGRALADescripcion)
                {
                    ApplicationArea = All;
                }
                field(AGRALACodProveedor; Rec.AGRALACodProveedor)
                {
                    ApplicationArea = All;
                }
                field(AGRALANombreProveedor; Rec.AGRALANombreProveedor)
                {
                    ApplicationArea = All;
                }
                field(AGRALANHA; Rec.AGRALANHA)
                {
                    ApplicationArea = All;
                }
                field(AGRALAFichaTecnica; Rec.AGRALAFichaTecnica)
                {
                    ApplicationArea = All;
                }
                field(AGRALAFechaVencimientoFT; Rec.AGRALAFechaVencimientoFT)
                {
                    ApplicationArea = All;
                    Editable = Rec.AGRALAFichaTecnica;
                }
                field(AGRALAFichaSeguridad; Rec.AGRALAFichaSeguridad)
                {
                    ApplicationArea = All;
                }
                field(AGRALAFechaVencimientoFS; Rec.AGRALAFechaVencimientoFS)
                {
                    ApplicationArea = All;
                    Editable = Rec.AGRALAFichaSeguridad;
                }
                field(AGRALANotasSeguimiento; Rec.AGRALANotasSeguimiento)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
