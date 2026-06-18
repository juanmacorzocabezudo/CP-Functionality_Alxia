page 50076 AGRALAIngredientes
{
    ApplicationArea = All;
    Caption = 'Ingredientes Productos';
    PageType = List;
    SourceTable = "Item Variant";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(re)
            {
                field("Item No."; Rec."Item No.")
                {
                    Caption = 'Nº Producto';
                }
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    Caption = 'Marca';
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
                field(AGRALAOMG; Rec.AGRALAOMG)
                {
                    ApplicationArea = All;
                }
                field(AGRALAingredientesOMGText; Rec.AGRALAingredientesOMGText)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(AGRALAIrradiado; Rec.AGRALAIrradiado)
                {
                    ApplicationArea = All;
                }
                field(AGRALAIrradiadoText; Rec.AGRALAIrradiadoText)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(AGRALAAlergenos; Rec.AGRALAAlergenos)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(AGRALAAlergenosContenidoText; Rec.AGRALAAlergenosContenidoText)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(AGRALAAlergenosTrazasText; Rec.AGRALAAlergenosTrazasText)
                {
                    ApplicationArea = All;
                    Editable = Rec.AGRALAAlergenos;
                }
                field(AGRALABloqueado; Rec.AGRALABloqueado)
                {
                    ApplicationArea = All;
                }
                field(AGRALADescripcionIngred; Rec.AGRALADescripcionIngred)
                {
                    ApplicationArea = All;
                }
                field(AGRALADescripcionIngred2; Rec.AGRALADescripcionIngred2)
                {
                    ApplicationArea = All;
                }
                field(AGRALANotasSeguimiento; Rec.AGRALANotasSeguimiento)
                {
                    ApplicationArea = All;
                }
                field(AGRALAAnalisisProducto; Rec.AGRALAAnalisisProducto)
                {
                    ApplicationArea = All;
                }
                field(AGRALAFechaVencimientoAnalisis; Rec.AGRALAFechaVencimientoAnalisis)
                {
                    ApplicationArea = All;
                }
                field(AGRALAAnalisisMicro; Rec.AGRALAAnalisisMicro)
                {
                    ApplicationArea = All;
                }
                field(AGRALAFechaVencimientoAnMicro; Rec.AGRALAFechaVencimientoAnMicro)
                {
                    ApplicationArea = All;
                }
                field(AGRALAAnalisisContaminantes; Rec.AGRALAAnalisisContaminantes)
                {
                    ApplicationArea = All;
                }
                field(AGRALAFechaVencimientoAnCont; Rec.AGRALAFechaVencimientoAnCont)
                {
                    ApplicationArea = All;
                }
                field("Fecha revision"; Rec."Fecha revision")
                {
                    ApplicationArea = All;
                }
                field(Kcal; Rec.Kcal)
                {
                    ApplicationArea = All;
                }
                field(Grasas; Rec.Grasas)
                {
                    ApplicationArea = All;
                }
                field(GrasasSaturadas; Rec.GrasasSaturadas)
                {
                    ApplicationArea = All;
                }
                field(Hidratos; Rec.Hidratos)
                {
                    ApplicationArea = All;
                }
                field(Fibra; Rec.Fibra)
                {
                    ApplicationArea = All;
                }
                field(Azucares; Rec.Azucares)
                {
                    ApplicationArea = All;
                }
                field(Proteinas; Rec.Proteinas)
                {
                    ApplicationArea = All;
                }
                field(Sodio; Rec.Sodio)
                {
                    ApplicationArea = All;
                }
                field(Comentarios; Rec.Comentarios)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(a; Links)
            {
                Visible = false;
            }
            systempart(b; Notes)
            {
                Visible = false;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            group("V&ariant")
            {
                Caption = 'V&ariant';
                Image = ItemVariant;

                action(AGRALAIngredientesOMG)
                {
                    ApplicationArea = All;
                    Caption = 'Ingredientes OMG';
                    Image = BOMLevel;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 50070;
                    RunPageLink = AGRALACodProducto=FIELD("Item No."), AGRALACodVariante=FIELD(Code), AGRALATipo=CONST(OMG);
                }
                action(AGRALAIngredientesIrradiato)
                {
                    ApplicationArea = All;
                    Caption = 'Ingredientes Irradiado';
                    Image = BOMLevel;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 50071;
                    RunPageLink = AGRALACodProducto=FIELD("Item No."), AGRALACodVariante=FIELD(Code), AGRALATipo=CONST(Irradiado);
                }
                action(Alergenos)
                {
                    ApplicationArea = All;
                    Caption = 'Alergenos';
                    Image = Text;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 50074;
                    RunPageLink = "Table Name"=CONST(Item), "No."=FIELD("Item No."), AGRALAMarca=FIELD(Code);
                    RunPageView = SORTING("Table Name", "No.", "Language Code", "All Language Codes", "Starting Date", "Ending Date");
                }
                action(Prov)
                {
                    ApplicationArea = All;
                    Caption = 'Cambiar proveedor';
                    Image = VendorContact;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 50104;
                    RunPageLink = "Item No."=FIELD("Item No."), "Variant Code"=FIELD(Code);
                }
                action(Nutricion)
                {
                    ApplicationArea = All;
                    Caption = 'Valores nutricionales';
                    Image = Forecast;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 50105;
                    RunPageLink = "Item No."=FIELD("Item No."), Code=FIELD(Code);
                }
            }
        }
    }
    trigger OnOpenPage()
    var
        ItemVariant: Record 5401;
        rlItem: Record 27;
    begin
    //++ AGRALAMO 21002
    //rlItem.FINDSET;
    //REPEAT
    //ItemVariant.SETRANGE("Item No.",rlItem."No.");
    //IF ItemVariant.FINDSET THEN
    //REPEAT
    //ItemVariant.Description := rlItem.Description;
    //  ItemVariant.MODIFY;
    //  UNTIL ItemVariant.NEXT= 0;
    //UNTIL rlItem.NEXT= 0;
    //-- AGRALAMO 210021
    end;
}
