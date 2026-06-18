page 50072 AGRALAContactoAlimentos
{
    ApplicationArea = All;
    Caption = 'Material contacto alimentos';
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
                field(AGRALAFichaTecnica; Rec.AGRALAFichaTecnica)
                {
                    ApplicationArea = All;
                }
                field(AGRALAFechaVencimientoFT; Rec.AGRALAFechaVencimientoFT)
                {
                    ApplicationArea = All;
                    Editable = Rec.AGRALAFichaTecnica;
                }
                field(AGRALADeclaraciondeConformidad; Rec.AGRALADeclaraciondeConformidad)
                {
                    ApplicationArea = All;
                }
                field(AGRALAFechaVigorDC; Rec.AGRALAFechaVigorDC)
                {
                    ApplicationArea = All;
                    Editable = Rec.AGRALADeclaraciondeConformidad;
                }
                field(AGRALAEnsayosMigracion; Rec.AGRALAEnsayosMigracion)
                {
                    ApplicationArea = All;
                }
                field(AGRALAOtrosEnsayos; Rec.AGRALAOtrosEnsayos)
                {
                    ApplicationArea = All;
                }
                field(AGRALANotasSeguimiento; Rec.AGRALANotasSeguimiento)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
