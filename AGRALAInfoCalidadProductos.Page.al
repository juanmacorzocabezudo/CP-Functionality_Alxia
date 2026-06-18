page 50075 AGRALAInfoCalidadProductos
{
    ApplicationArea = All;
    Caption = 'Info Calidad Productos';
    PageType = List;
    SourceTable = "Item Variant";
    UsageCategory = Administration;
    PromotedActionCategories = 'Info calidad';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    Caption = 'Marca';
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field(AGRALATipoProducto; Rec.AGRALATipoProducto)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
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
                field(AGRALADescripcion; Rec.AGRALADescripcion)
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
                }
                field(AGRALADeclaraciondeConformidad; Rec.AGRALADeclaraciondeConformidad)
                {
                    ApplicationArea = All;
                }
                field(AGRALAFechaVigorDC; Rec.AGRALAFechaVigorDC)
                {
                    ApplicationArea = All;
                }
                field(AGRALAEnsayosMigracion; Rec.AGRALAEnsayosMigracion)
                {
                    ApplicationArea = All;
                }
                field(AGRALAOtrosEnsayos; Rec.AGRALAOtrosEnsayos)
                {
                    ApplicationArea = All;
                }
                field(AGRALANHA; Rec.AGRALANHA)
                {
                    ApplicationArea = All;
                }
                field(AGRALAFichaSeguridad; Rec.AGRALAFichaSeguridad)
                {
                    ApplicationArea = All;
                }
                field(AGRALAFechaVencimientoFS; Rec.AGRALAFechaVencimientoFS)
                {
                    ApplicationArea = All;
                }
                field(AGRALAOMG; Rec.AGRALAOMG)
                {
                    ApplicationArea = All;
                }
                field(AGRALAingredientesOMGText; Rec.AGRALAingredientesOMGText)
                {
                    ApplicationArea = All;
                }
                field(AGRALAIrradiado; Rec.AGRALAIrradiado)
                {
                    ApplicationArea = All;
                }
                field(AGRALAIrradiadoText; Rec.AGRALAIrradiadoText)
                {
                    ApplicationArea = All;
                }
                field(AGRALAAlergenos; Rec.AGRALAAlergenos)
                {
                    ApplicationArea = All;
                }
                field(AGRALAAlergenosContenidoText; Rec.AGRALAAlergenosContenidoText)
                {
                    ApplicationArea = All;
                }
                field(AGRALAAlergenosTrazasText; Rec.AGRALAAlergenosTrazasText)
                {
                    ApplicationArea = All;
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
                field(_fechaUltimaCompra; _fechaUltimaCompra)
                {
                    ApplicationArea = All;
                    Caption = 'Fecha de ultima compra';
                }
                field(_SANDACH; _SANDACH)
                {
                    ApplicationArea = All;
                    Caption = 'Sandach';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(AGRALAIngredientesOMG)
            {
                Caption = 'Ingredientes OMG';
                Image = BOMLevel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page 50070;
                RunPageLink = AGRALACodProducto=FIELD("Item No."), AGRALACodVariante=FIELD(Code), AGRALATipo=CONST(OMG);
            }
            action(AGRALAIngredientesIrradiato)
            {
                Caption = 'Ingredientes Irradiado';
                Image = BOMLevel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page 50071;
                RunPageLink = AGRALACodProducto=FIELD("Item No."), AGRALACodVariante=FIELD(Code), AGRALATipo=CONST(Irradiado);
            }
            action(Alergenos)
            {
                Caption = 'Alergenos';
                Image = Text;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page 50074;
                RunPageLink = "Table Name"=CONST(Item), "No."=FIELD("Item No."), AGRALAMarca=FIELD(Code);
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    var
        rlItem: Record 27;
        rlItemVariant: Record 5401;
    begin
    end;
    trigger OnAfterGetRecord()
    var
        rlItem: Record 27;
        rlItemVariant: Record 5401;
        ItemNo: Text;
    begin
        Clear(_fechaUltimaCompra);
        Clear(_SANDACH);
        Evaluate(ItemNo, Rec."Item No.");
        if ItemNo.Contains('MP')then begin
            rlItem.reset;
            rlItem.SetRange("No.", Rec."Item No.");
            if rlItem.FindFirst()then begin
                _fechaUltimaCompra:=rlItem."Fecha ultima factura compra";
                _SANDACH:=rlItem.AGRALASandach;
            end;
        end
        else
        begin
            rlItem.reset;
            rlItem.SetRange("No.", Rec."Item No.");
            if rlItem.FindFirst()then begin
                _SANDACH:=rlItem.AGRALASandach;
            end;
        end;
    end;
    trigger OnOpenPage()
    var
        rlItemVariant: Record 5401;
        rlItem: Record 27;
    begin
        rlItem.FINDSET;
        REPEAT CLEAR(rlItemVariant);
            rlItemVariant.SETRANGE("Item No.", rlItem."No.");
            IF rlItemVariant.FINDSET THEN REPEAT rlItemVariant.VALIDATE(AGRALATipoProducto, Rec.AGRALATipoProducto::" ");
                    IF rlItem.AGRALAIngrediente THEN rlItemVariant.VALIDATE(AGRALATipoProducto, Rec.AGRALATipoProducto::Ingrediente);
                    IF rlItem.AGRALAMaterialContacto THEN rlItemVariant.VALIDATE(AGRALATipoProducto, Rec.AGRALATipoProducto::MaterialContacto);
                    IF rlItem.AGRALAProductoQuimico THEN rlItemVariant.VALIDATE(AGRALATipoProducto, Rec.AGRALATipoProducto::ProductoQuimico);
                    rlItemVariant.MODIFY;
                UNTIL rlItemVariant.NEXT = 0;
        UNTIL rlItem.NEXT() = 0;
    //Rec.MODIFY;
    end;
    var _fechaUltimaCompra: Date;
    _SANDACH: Boolean;
}
