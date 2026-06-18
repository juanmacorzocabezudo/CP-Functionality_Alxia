report 50053 "Recipe Report"
{
    ApplicationArea = All;
    Caption = 'Parte de Receta';
    UsageCategory = Administration;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layout/RecipeReport.rdl';

    dataset
    {
        dataitem(Item; Item)
        {
            //CalcFields = Picture;
            column(CompanyInfoPicture; CompanyInfo.Picture)
            {
            }
            column(imagenproducto; Item.Picture)
            {
            }
            column(No_Item; Item."No.")
            {
            }
            column(LoteReceta_Item; Item."Lote Receta")
            {
            }
            column(PercLoss_Item; Item."Perc. Loss")
            {
            }
            column(StatisticsLot_Item; Item."Statistics Lot")
            {
            }
            column(BaseUnitofMeasure_Item; Item."Base Unit of Measure")
            {
            }
            column(Description_Item; Item.Description)
            {
            }
            column(QuantityCaliente; VarQtyCaliente)
            {
            }
            column(VarMostrarRecursos; VarMostrarRecursos)
            {
            }
            column(ElaboracionText; _ElaboracionText)
            {
            }
            dataitem("BOM Component"; "BOM Component")
            {
                CalcFields = "Assembly BOM";
                DataItemLink = "Parent Item No."=FIELD("No.");
                DataItemTableView = SORTING("Parent Item No.", "Line No.")ORDER(Ascending)WHERE(Type=CONST(Item));

                column(LineNo_BOMComponent; "BOM Component"."Line No.")
                {
                }
                column(No_BOMComponent; "BOM Component"."No.")
                {
                }
                column(VariantCode_BOMComponent; "BOM Component"."Variant Code")
                {
                }
                column(Description_BOMComponent; "BOM Component".Description)
                {
                }
                column(varDescription; varDescripcion)
                {
                }
                column(UnitofMeasureCode_BOMComponent; "BOM Component"."Unit of Measure Code")
                {
                }
                column(Quantityper_BOMComponent; "BOM Component"."Quantity per")
                {
                }
                column(CantidadporLote_BOMComponent; "BOM Component"."Cantidad por Lote")
                {
                }
                column(Position_BOMComponent; "BOM Component".Position)
                {
                }
                column(Position2_BOMComponent; "BOM Component"."Position 2")
                {
                }
                column(Position3_BOMComponent; "BOM Component"."Position 3")
                {
                }
                column(ImportanciaenCoste_BOMComponent; "BOM Component"."Importancia en Coste")
                {
                }
                column(CantidadporBandeja_BOMComponent; "BOM Component"."Cantidad por Bandeja")
                {
                }
                column(ProveedorporDefecto_BOMComponent; "BOM Component"."Proveedor por Defecto")
                {
                }
                column(CosteUnitario_BOMComponent; "BOM Component".CosteUnitario)
                {
                }
                column(Comentario_BOMComponent; "BOM Component".Comentario)
                {
                }
                column(CosteCalculado_BOMComponent; "BOM Component"."Coste Calculado")
                {
                }
                column(TipoRecurso_BOMComponent; "BOM Component".TipoRecurso)
                {
                }
                column(RelatedWorkCenter_BOMComponent; "BOM Component"."Related Work Center")
                {
                }
                column(Maquila_BOMComponent; "BOM Component".Maquila)
                {
                }
                column(PercLoss_BOMComponent; "BOM Component"."Perc. Loss")
                {
                }
                column(NetAmount_BOMComponent; "BOM Component"."Net Amount")
                {
                }
                column(ParentItemDesciption_BOMComponent; "BOM Component"."Parent Item Desciption")
                {
                }
                column(Sombrear; gb_Sombrear)
                {
                }
                column(VarProductoLM; VarProductoLM)
                {
                }
                trigger OnAfterGetRecord()
                var
                    rItem: Record Item;
                begin
                    gb_Sombrear:=TRUE;
                    CLEAR(VarProductoLM);
                    CASE "BOM Component".Type OF "BOM Component".Type::Item: BEGIN
                        gr_Item.RESET;
                        gr_Item.SETRANGE("No.", "BOM Component"."No.");
                        IF gr_Item.FINDFIRST THEN BEGIN
                            gb_Sombrear:=gr_Item."Item Tracking Code" = '';
                            VarProductoLM:="BOM Component"."Assembly BOM";
                        END;
                    END;
                    END;
                    //SL BEGIN GAP00009 
                    Clear(varDescripcion);
                    rItem.Reset();
                    rItem.SetRange("No.", "BOM Component"."No.");
                    if rItem.FindFirst()then varDescripcion:=rItem.Description;
                //SL END GAP00009 
                end;
            }
            dataitem("BOM Component Resource"; "BOM Component")
            {
                DataItemLink = "Parent Item No."=FIELD("No.");
                DataItemTableView = SORTING("Parent Item No.", "Line No.")ORDER(Ascending)WHERE(Type=FILTER(<>Item));

                column(LineNo_BOMComponentResource; "BOM Component Resource"."Line No.")
                {
                }
                column(No_BOMComponentResource; "BOM Component Resource"."No.")
                {
                }
                column(VarRecursoNegrita; VarRecursoNegrita)
                {
                }
                column(VariantCode_BOMComponentResource; "BOM Component Resource"."Variant Code")
                {
                }
                column(Description_BOMComponentResource; "BOM Component Resource".Description)
                {
                }
                column(UnitofMeasureCode_BOMComponentResource; "BOM Component Resource"."Unit of Measure Code")
                {
                }
                column(Quantityper_BOMComponentResource; "BOM Component Resource"."Quantity per")
                {
                }
                column(CantidadporLote_BOMComponentResource; "BOM Component Resource"."Cantidad por Lote")
                {
                }
                column(Position_BOMComponentResource; "BOM Component Resource".Position)
                {
                }
                column(Position2_BOMComponentResource; "BOM Component Resource"."Position 2")
                {
                }
                column(Position3_BOMComponentResource; "BOM Component Resource"."Position 3")
                {
                }
                column(ImportanciaenCoste_BOMComponentResource; "BOM Component Resource"."Importancia en Coste")
                {
                }
                column(CantidadporBandeja_BOMComponentResource; "BOM Component Resource"."Cantidad por Bandeja")
                {
                }
                column(ProveedorporDefecto_BOMComponentResource; "BOM Component Resource"."Proveedor por Defecto")
                {
                }
                column(CosteUnitario_BOMComponentResource; "BOM Component Resource".CosteUnitario)
                {
                }
                column(Comentario_BOMComponentResource; "BOM Component Resource".Comentario)
                {
                }
                column(CosteCalculado_BOMComponentResource; "BOM Component Resource"."Coste Calculado")
                {
                }
                column(TipoRecurso_BOMComponentResource; "BOM Component Resource".TipoRecurso)
                {
                }
                column(RelatedWorkCenter_BOMComponentResource; "BOM Component Resource"."Related Work Center")
                {
                }
                column(Maquila_BOMComponentResource; "BOM Component Resource".Maquila)
                {
                }
                column(PercLoss_BOMComponentResource; "BOM Component Resource"."Perc. Loss")
                {
                }
                column(NetAmount_BOMComponentResource; "BOM Component Resource"."Net Amount")
                {
                }
                column(ParentItemDesciption_BOMComponentResource; "BOM Component Resource"."Parent Item Desciption")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    CLEAR(VarRecursoNegrita);
                    IF("BOM Component Resource".Type = "BOM Component Resource".Type::" ") AND ("BOM Component Resource"."Related Work Center" <> '')THEN VarRecursoNegrita:=TRUE;
                end;
            }
            dataitem("Receta Comentarios"; "Receta Comentarios")
            {
                DataItemLink = "No."=FIELD("No.");
                DataItemTableView = SORTING("Table Name", "No.", "Line No.")WHERE("Table Name"=CONST(Receta));

                column(LineNo_RecetaComentarios; "Receta Comentarios"."Line No.")
                {
                }
                column(No_RecetaComentarios; "Receta Comentarios"."No.")
                {
                }
                column(Comment_RecetaComentarios; "Receta Comentarios".Comment)
                {
                }
                column(ImprimeRojo_RecetaComentarios; "Receta Comentarios"."Imprime Rojo")
                {
                }
                column(Subrayadoamarillo_RecetaComentarios; "Receta Comentarios"."Subrayado amarillo")
                {
                }
                column(FormatLine_RecetaComentarios; "Receta Comentarios"."Format Line")
                {
                }
                column(Comment2_RecetaComentarios; "Receta Comentarios"."Comment 2")
                {
                }
                column(FormatLine2_RecetaComentarios; "Receta Comentarios"."Format Line 2")
                {
                }
                column(Subrayadoamarillo2_RecetaComentarios; "Receta Comentarios"."Subrayado amarillo 2")
                {
                }
                column(VarNormal; VarNormal)
                {
                }
                column(VarNegrita; VarNegrita)
                {
                }
                column(VarAzul; VarAzul)
                {
                }
                column(VarRojo; VarRojo)
                {
                }
                column(VarNormal2; VarNormal2)
                {
                }
                column(VarNegrita2; VarNegrita2)
                {
                }
                column(VarAzul2; VarAzul2)
                {
                }
                column(VarRojo2; VarRojo2)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    CLEAR(VarNormal);
                    CLEAR(VarNegrita);
                    CLEAR(VarAzul);
                    CLEAR(VarRojo);
                    CLEAR(VarNormal2);
                    CLEAR(VarNegrita2);
                    CLEAR(VarAzul2);
                    CLEAR(VarRojo2);
                    CASE "Receta Comentarios"."Format Line" OF "Receta Comentarios"."Format Line"::" ": VarNormal:=TRUE;
                    "Receta Comentarios"."Format Line"::StandardAccent: VarAzul:=TRUE;
                    "Receta Comentarios"."Format Line"::Unfavorable: VarRojo:=TRUE;
                    "Receta Comentarios"."Format Line"::Strong: VarNegrita:=TRUE;
                    END;
                    CASE "Receta Comentarios"."Format Line 2" OF "Receta Comentarios"."Format Line 2"::" ": VarNormal2:=TRUE;
                    "Receta Comentarios"."Format Line 2"::StandardAccent: VarAzul2:=TRUE;
                    "Receta Comentarios"."Format Line 2"::Unfavorable: VarRojo2:=TRUE;
                    "Receta Comentarios"."Format Line 2"::Strong: VarNegrita2:=TRUE;
                    END;
                end;
            }
            trigger OnAfterGetRecord()
            var
                RichTextInS: InStream;
                rComentarios: Record AlxRecetaComentarios;
            begin
                CLEAR(VarQtyCaliente);
                IF VarElaboracionCaliente THEN VarQtyCaliente:=Item."Lote Receta" + ((Item."Lote Receta" * Item."Perc. Loss") / 100)
                ELSE
                    VarQtyCaliente:=0;
                rComentarios.Reset();
                rComentarios.SetRange("No.", Item."No.");
                if rComentarios.FindFirst()then begin
                    rComentarios.CalcFields(ElaboracionText);
                    rComentarios.ElaboracionText.CreateInStream(RichTextInS, TextEncoding::UTF8);
                    RichTextInS.Read(_ElaboracionText);
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field(VarMostrarRecursos; VarMostrarRecursos)
                    {
                        ApplicationArea = All;
                        Caption = 'Mostrar Recursos';
                    }
                    field(VarElaboracionCaliente; VarElaboracionCaliente)
                    {
                        ApplicationArea = All;
                        Caption = 'Heat creation';
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
    LblReferencia='Marca / Referencia';
    LblDescripcion='Descripción';
    LblCantidad='Quantity';
    LblCantidadNet='Quantity Net';
    LblCantidadMadre='Quantity from Recepy';
    LblUdm='Ud.';
    LblCantConsumida='Cant. Consumida';
    LblLote='Lote';
    lblBase='Base Imponible';
    lblIVA='% IVA';
    lblImporteIVA='Importe IVA';
    lblTotalParcial='Total Parcial';
    lblSenalizado='SEÑALIZADO';
    lblImpSenal='Importe Señal';
    lblImpPendiente='Importe Pendiente';
    lblHoraEvento='Hora Evento';
    lblEMail='E-Mail';
    lblContacto='Contacto';
    lblDireccionEvento='Dirección evento';
    lblCPLocalidad='C.P. Localidad';
    lblProvincia='Provincia';
    LblPreparados='MP Preparados';
    LblConsumidas='MP Consumidas';
    LblEstimacion='ESTIMACIÓN PRODUCCIÓN';
    LblIngredientes='INGREDIENTES';
    LblElaboracion='ELABORACIÓN ANTIGUA';
    LblNotas='NOTES';
    LblTotalCaliente='TOTAL PESO ELABORADO EN CALIENTE (REAL)';
    LblTotalFrio='TOTAL PESO ELABORADO EN FRÍO (REAL)';
    LblTotalCalienteEstimado='TOTAL PESO ELABORADO EN CALIENTE (ESTIMADO)';
    LblTotalFrioEstimado='TOTAL PESO ELABORADO EN FRÍO (ESTIMADO)';
    LblRecursos='RECURSOS';
    LblRComsunidas='Consumidas';
    LblRNotas='Notas';
    LblComents='COMENTARIOS';
    }
    trigger OnInitReport()
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);
        VarElaboracionCaliente:=TRUE;
    end;
    trigger OnPostReport()
    begin
    end;
    var CompanyInfo: Record 79;
    gr_Item: Record 27;
    gb_Sombrear: Boolean;
    VarProductoLM: Boolean;
    VarNormal: Boolean;
    VarNegrita: Boolean;
    VarAzul: Boolean;
    VarRojo: Boolean;
    VarNormal2: Boolean;
    VarNegrita2: Boolean;
    VarAzul2: Boolean;
    VarRojo2: Boolean;
    VarRecursoNegrita: Boolean;
    VarMostrarRecursos: Boolean;
    VarElaboracionCaliente: Boolean;
    varDescripcion: Text[100];
    VarQtyCaliente: Decimal;
    _ElaboracionText: Text;
}
