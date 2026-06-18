page 50105 AlxValoresNutricionales
{
    ApplicationArea = All;
    Caption = 'Valores nutricionales';
    PageType = List;
    SourceTable = "Item Variant";
    UsageCategory = Lists;
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    Editable = false;
                }
                field("Item No."; Rec."Item No.")
                {
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                }
                field("Fecha revision"; Rec."Fecha revision")
                {
                    ApplicationArea = All;
                }
                field(Kcal; Rec.Kcal)
                {
                }
                field(Grasas; Rec.Grasas)
                {
                }
                field(GrasasSaturadas; Rec.GrasasSaturadas)
                {
                }
                field(Hidratos; Rec.Hidratos)
                {
                }
                field(Azucares; Rec.Azucares)
                {
                }
                field(Fibra; Rec.Fibra)
                {
                }
                field(Proteinas; Rec.Proteinas)
                {
                }
                field(Sodio; Rec.Sodio)
                {
                }
                field(Comentarios; Rec.Comentarios)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
