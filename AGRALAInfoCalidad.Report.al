report 50025 AGRALAInfoCalidad
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layout/AGRALAInfoCalidad.rdlc';
    Caption = 'Info calidad';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(ItemVariant; "Item Variant")
        {
            column(Code_ItemVariant; ItemVariant.Code)
            {
            }
            column(ItemNo_ItemVariant; ItemVariant."Item No.")
            {
            }
            column(Description_ItemVariant; ItemVariant.Description)
            {
            }
            column(Description2_ItemVariant; ItemVariant."Description 2")
            {
            }
            column(AGRALACodProveedor_ItemVariant; ItemVariant.AGRALACodProveedor)
            {
            }
            column(AGRALANombreProveedor_ItemVariant; ItemVariant.AGRALANombreProveedor)
            {
            }
            column(AGRALADescripcion_ItemVariant; ItemVariant.AGRALADescripcion)
            {
            }
            column(AGRALAFichaTecnica_ItemVariant; ItemVariant.AGRALAFichaTecnica)
            {
            }
            column(AGRALAFechaVencimientoFT_ItemVariant; ItemVariant.AGRALAFechaVencimientoFT)
            {
            }
            column(AGRALAOMG_ItemVariant; ItemVariant.AGRALAOMG)
            {
            }
            column(AGRALAIngredienetesOMGText_ItemVariant; ItemVariant.AGRALAingredientesOMGText)
            {
            }
            column(AGRALAIrradiado_ItemVariant; ItemVariant.AGRALAIrradiado)
            {
            }
            column(AGRALAIrradiadoText_ItemVariant; ItemVariant.AGRALAIrradiadoText)
            {
            }
            column(AGRALADeclaraciondeConformidad_ItemVariant; ItemVariant.AGRALADeclaraciondeConformidad)
            {
            }
            column(AGRALAFechaVigorDC_ItemVariant; ItemVariant.AGRALAFechaVigorDC)
            {
            }
            column(AGRALAEnsayosMigracion_ItemVariant; ItemVariant.AGRALAEnsayosMigracion)
            {
            }
            column(AGRALAOtrosEnsayos_ItemVariant; ItemVariant.AGRALAOtrosEnsayos)
            {
            }
            column(AGRALANHA_ItemVariant; ItemVariant.AGRALANHA)
            {
            }
            column(AGRALAFichaSeguridad_ItemVariant; ItemVariant.AGRALAFichaSeguridad)
            {
            }
            column(AGRALAFechaVencimientoFS_ItemVariant; ItemVariant.AGRALAFechaVencimientoFS)
            {
            }
            column(AGRALAingredientesOMG_ItemVariant; ItemVariant.AGRALAingredientesOMGText)
            {
            }
            column(AGRALAIngredientes_ItemVariant; ItemVariant.AGRALADescripcionIngred)
            {
            }
            column(AGRALAIngredientes2_ItemVariant; ItemVariant.AGRALADescripcionIngred2)
            {
            }
            column(AGRALAAlergenos_ItemVariant; ItemVariant.AGRALAAlergenos)
            {
            }
            column(AGRALAAlergenosContenidoText_ItemVariant; ItemVariant.AGRALAAlergenosContenidoText)
            {
            }
            column(AGRALAAlergenosTrazasText_ItemVariant; ItemVariant.AGRALAAlergenosTrazasText)
            {
            }
            column(AGRALANombreReceta; xlRecetaNombre)
            {
            }
        }
        dataitem(DataItem1000000029;2000000026)
        {
            DataItemTableView = WHERE(Number=FILTER(=1));

            column(Picture; rlCompanyInfo.Picture)
            {
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group("Nombre receta")
                {
                    field(xlRecetaNombre; xlRecetaNombre)
                    {
                        ApplicationArea = all;
                        Caption = 'Nombre receta';
                    }
                }
            }
        }
        actions
        {
        }
    }
    labels
    {
    }
    trigger OnInitReport()
    begin
        rlCompanyInfo.GET;
        rlCompanyInfo.CALCFIELDS(Picture);
    end;
    trigger OnPostReport()
    begin
    //PAGE.RUN(50075, "Item Variant");
    end;
    var rlCompanyInfo: Record 79;
    xlRecetaNombre: Text[250];
    procedure InicializarVariables(var plRecetaNombre: Text[250])
    begin
        xlRecetaNombre:=plRecetaNombre;
    end;
}
