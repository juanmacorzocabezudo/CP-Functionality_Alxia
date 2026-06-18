page 50106 AlxRecetasNiveles
{
    ApplicationArea = All;
    Caption = 'Receta Niveles';
    PageType = List;
    SourceTable = "AlxRecetasNiveles";
    UsageCategory = Lists;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Producto Base"; Rec.ProductoBase)
                {
                    Caption = 'Receta Madre';
                    ApplicationArea = All;
                }
                field(Nivel; Rec.Nivel)
                {
                }
                field("Producto"; Rec."Parent Item No.")
                {
                }
                field("N Linea"; Rec."Line No.")
                {
                }
                field("Tipo"; Rec."Type")
                {
                }
                field("No Producto"; Rec."No.")
                {
                }
                field("L.M. de ensamblado"; Rec."Assembly BOM")
                {
                }
                field("Descripcion"; Rec.Description)
                {
                }
                field("Unidad medida"; Rec."Unit of Measure Code")
                {
                }
                field("Cantidad por"; Rec."Quantity per")
                {
                }
                field("Description L.M. de ensamblado"; Rec."BOM Description")
                {
                }
                field("Marca"; Rec."Variant Code")
                {
                }
                field("Cantidad por Lote"; Rec."Cantidad por Lote")
                {
                }
                field("Importancia en Coste"; Rec."Importancia en Coste")
                {
                }
                field("Proveedor por Defecto"; Rec."Proveedor por Defecto")
                {
                }
                field(CosteUnitario; Rec.CosteUnitario)
                {
                }
                field(Comentario; Rec.Comentario)
                {
                }
                field("Coste Calculado"; Rec."Coste Calculado")
                {
                }
                field(TipoRecurso; Rec.TipoRecurso)
                {
                }
                field("No. Centro trabajo"; Rec."Related Work Center")
                {
                }
                field(Maquila; Rec.Maquila)
                {
                }
                field("Porc. Merma"; Rec."Perc. Loss")
                {
                }
                field("Cantidad neta"; Rec."Net Amount")
                {
                }
                field("Descripcion receta madre"; Rec."Parent Item Desciption")
                {
                }
                field(Bloqueado; Rec.Bloqueado)
                {
                    ApplicationArea = All;
                    Caption = 'Bloqueado';
                }
                field("Lote receta"; Rec."Lote receta")
                {
                    ApplicationArea = All;
                    Caption = 'Lote receta';
                }
                field("Unidad medida base"; Rec."Unidad medida Item")
                {
                    ApplicationArea = All;
                    Caption = 'Unidad medida base';
                }
                field("Lote Estadistico"; Rec."Statistics Lot")
                {
                    ApplicationArea = All;
                }
                field("Unidad Medida Estadisticas"; Rec."Statistics Unit of Measurement")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
