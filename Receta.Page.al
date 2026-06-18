page 50000 Receta
{
    // 
    // ADVANCE - Log de cambios
    // -----------------------------------------------------
    //   ADVANCE
    //   Fecha: 23-05-2016
    //   Técnico: JMAP
    //   Presupuesto: I002074 - Desarrollo funcionalidades Recetas
    //   Modificación:
    // 
    //   Etiqueta: ADV001
    // -----------------------------------------------------
    // #9804 - Se añade el botón de navegar
    // #9862 - Se crea el grupo de botones de versiones
    // #10160 - Se introduce el nuevo boton
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = Item;
    SourceTableView = SORTING("No.")ORDER(Ascending);

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Lote Receta"; Rec."Lote Receta")
                {
                    ApplicationArea = All;
                    Editable = varEdit;
                }
                field("Base Unit of Measure"; Rec."Base Unit of Measure")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Statistics Lot"; Rec."Statistics Lot")
                {
                    Caption = 'Lote estadistico';
                    ApplicationArea = All;
                    Editable = varEdit;
                }
                field("Statistics Unit of Measurement"; Rec."Statistics Unit of Measurement")
                {
                    Caption = 'Unidad Medida Estadisticas';
                    ApplicationArea = All;
                    Editable = varEdit;
                }
                field("Status LM"; Rec."Status LM")
                {
                    StyleExpr = VarFormatoStatusLM;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //-- #9993
                        VarFormatoStatusLM:=GetVarFormatStatus;
                        if Rec."Status LM" <> Rec."Status LM"::"Under Construction" then begin
                            CurrPage.Editable:=false;
                            CurrPage.Update(false);
                        end;
                        varEdit:=ValStatus(Rec."Status LM");
                    //++ #9993
                    end;
                }
            }
            part(SubFormReceta;50001)
            {
                ApplicationArea = All;
                Caption = 'L.M. de Ensamblado';
                Editable = varEdit;
                SubPageLink = "Parent Item No."=FIELD("No.");
                SubPageView = SORTING("Parent Item No.", "Line No.")ORDER(Ascending);
            }
            part(recetaItem;50047)
            {
                ApplicationArea = All;
                Caption = 'L.M. de Ensamblado Producto';
                Editable = varEdit;
                SubPageLink = "Parent Item No."=FIELD("No.");
                SubPageView = SORTING("Parent Item No.", "Line No.")ORDER(Ascending);
            }
            part(recetaRecurso;50048)
            {
                ApplicationArea = All;
                Caption = 'L.M. de Ensamblado Recurso';
                Editable = varEdit;
                SubPageLink = "Parent Item No."=FIELD("No.");
                SubPageView = SORTING("Parent Item No.", "Line No.")ORDER(Ascending);
            }
            part("Elaboración";50023)
            {
                ApplicationArea = All;
                Caption = 'Elaboración';
                Editable = varEdit;
                SubPageLink = "Table Name"=CONST(Receta), "No."=FIELD("No.");
            }
            part("ElaboraciónNueva";50102)
            {
                ApplicationArea = All;
                Caption = 'Elaboración Nueva';
                Editable = varEdit;
                SubPageLink = "No."=FIELD("No.");
            }
        }
        area(factboxes)
        {
            part(DetalleCosto;50062)
            {
                ApplicationArea = All;
                SubPageLink = "No."=FIELD("No.");
            }
            part(DetalleProduccion;50061)
            {
                ApplicationArea = All;
                SubPageLink = "No."=FIELD("No.");
            }
            part(DetalleESTAN;50063)
            {
                ApplicationArea = All;
                SubPageLink = "No."=FIELD("No.");
            }
            part(DetalleMedio;50064)
            {
                ApplicationArea = All;
                SubPageLink = "No."=FIELD("No.");
            }
            part(DetallePeso;50065)
            {
                ApplicationArea = All;
                SubPageLink = "No."=FIELD("No.");
            }
            part(Detelles;50016)
            {
                ApplicationArea = All;
                SubPageLink = "No."=FIELD("No.");
            }
            systempart(Link; Links)
            {
                ApplicationArea = All;
                Visible = false;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
                Visible = false;
            }
            part(ItemDetalle;911)
            {
                //Provider = Control1000000004;
                ApplicationArea = All;
                SubPageLink = "No."=FIELD("No.");
            }
            part(Recursos;912)
            {
                //Provider = Control1000000004;
                ApplicationArea = All;
                SubPageLink = "No."=FIELD("No.");
            }
            part("Component-ItemDetails";911)
            {
                //Provider = Control1000000027;
                ApplicationArea = All;
                SubPageLink = "No."=FIELD("No.");
            }
            part("Component-ResourceDetails";912)
            {
                //Provider = Control1000000032;
                ApplicationArea = All;
                SubPageLink = "No."=FIELD("No.");
            }
        }
    }
    actions
    {
        area(Processing)
        {
            group(BOMVersion)
            {
                Caption = 'BOM Version';

                action(BOMVersionList)
                {
                    ApplicationArea = All;
                    Caption = 'Lista versiones';
                    Image = BOMVersions;
                    Promoted = true;
                    RunObject = Page 50049;
                    RunPageLink = "Item No."=FIELD("No.");
                }
                action(ArchiveVersion)
                {
                    Caption = 'Archivar versíon';
                    ApplicationArea = All;
                    Image = Archive;
                    Promoted = true;

                    trigger OnAction()
                    var
                        FuncionesVarias: Codeunit FuncionesVarias;
                    begin
                        //-- #9862
                        CLEAR(FuncionesVarias);
                        FuncionesVarias.CreateNewBOMVersion(Rec);
                    //++ #9862 
                    end;
                }
                action(ProductionReport)
                {
                    Caption = 'Parte de receta';
                    ApplicationArea = All;
                    Ellipsis = true;
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ItemLocal: Record Item;
                        RecipeReport: Report 50053;
                    begin
                        //-- #10160
                        ItemLocal.GET(Rec."No.");
                        CLEAR(RecipeReport);
                        CurrPage.SETSELECTIONFILTER(ItemLocal);
                        RecipeReport.SETTABLEVIEW(ItemLocal);
                        RecipeReport.RUNMODAL;
                    //++ #10160
                    end;
                }
            }
            group(Navegate)
            {
                Caption = 'Navegar';

                action(Item)
                {
                    Caption = 'Lista Productos';
                    ApplicationArea = All;
                    Image = Item;
                    RunObject = Page 31;
                }
                action(Resource)
                {
                    Caption = 'Lista Recurso';
                    ApplicationArea = All;
                    Image = Resource;
                    RunObject = Page 77;
                }
                action(Supply)
                {
                    Caption = 'Lista suministros';
                    ApplicationArea = All;
                    Image = Tools;
                    RunObject = Page 50042;
                }
                action(WorkCenter)
                {
                    Caption = 'Centro de Trabajo';
                    ApplicationArea = All;
                    Image = WorkCenter;
                    RunObject = Page 50046;
                }
                separator(sepa)
                {
                }
                action(BOMCost)
                {
                    Caption = 'Costes Generales';
                    ApplicationArea = All;
                    Image = Costs;

                    trigger OnAction()
                    var
                        PageBOMAditionalCost: Page 50059;
                        BOMAditionalCost: Record 50029;
                    begin
                        IF Rec.Receta_CosteLMFijado = 0 THEN BEGIN
                            Rec.SetFijarCosteLMRecetaEnFichaArticulo;
                            COMMIT;
                        END;
                        //Item No=FIELD(No.),BOM Version=CONST(0)
                        BOMAditionalCost.RESET;
                        BOMAditionalCost.SETRANGE(BOMAditionalCost."Item No", Rec."No.");
                        BOMAditionalCost.SETRANGE(BOMAditionalCost."BOM Version", 0);
                        BOMAditionalCost.SETCURRENTKEY("Item No", "BOM Version", "No. Cost");
                        PageBOMAditionalCost.SETTABLEVIEW(BOMAditionalCost);
                        PageBOMAditionalCost.RUNMODAL;
                    end;
                }
                separator(separador)
                {
                }
                action("Assambly Order")
                {
                    Caption = 'Pedidos ensamblados';
                    ApplicationArea = All;
                    Image = OrderList;
                    RunObject = Page 902;
                    RunPageLink = "Item No."=FIELD("No.");
                    RunPageView = SORTING("Document Type", "No.");
                }
                action("Post Assambly Order")
                {
                    Caption = 'Pedidos ensamblados registrados';
                    ApplicationArea = All;
                    Image = PostDocument;
                    RunObject = Page "Posted Assembly Orders";
                    RunPageLink = "Item No."=FIELD("No.");
                    RunPageView = SORTING("No.");
                }
                action("Ledger E&ntries")
                {
                    Caption = 'Movimientos';
                    ApplicationArea = All;
                    Image = ItemLedger;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page "Item Ledger Entries";
                    RunPageLink = "Item No."=FIELD("No.");
                    RunPageView = SORTING("Item No.");
                    ShortCutKey = 'Ctrl+F7';
                }
            }
            group("Assembly/Production")
            {
                Caption = 'Ensamblado/producción';
                Image = Production;

                action(Structure)
                {
                    Caption = 'Estructura';
                    ApplicationArea = All;
                    Image = Hierarchy;

                    trigger OnAction()
                    var
                        BOMStructure: Page "BOM Structure";
                    begin
                        //-- #9804
                        BOMStructure.InitItem(Rec);
                        BOMStructure.RUN;
                    //++ #9804
                    end;
                }
                action("Cost Shares")
                {
                    Caption = 'Partes costes';
                    ApplicationArea = All;
                    Image = CostBudget;

                    trigger OnAction()
                    var
                        BOMCostShares: Page "BOM Cost Shares";
                    begin
                        //-- #9804
                        BOMCostShares.InitItem(Rec);
                        BOMCostShares.RUN;
                    //++ #9804
                    end;
                }
                group("Assemb&ly")
                {
                    Caption = 'Ensamblado';
                    Image = AssemblyBOM;

                    action("Where-Used")
                    {
                        Caption = 'Puntos de uso';
                        ApplicationArea = All;
                        Image = Track;
                        RunObject = Page "Where-Used List";
                        RunPageLink = Type=CONST(Item), "No."=FIELD("No.");
                        RunPageView = SORTING(Type, "No.");
                    }
                    action("Calc. Stan&dard Cost")
                    {
                        AccessByPermission = TableData 90=R;
                        ApplicationArea = All;
                        Caption = 'Calc. coste estándar';
                        Image = CalculateCost;

                        trigger OnAction()
                        begin
                            //-- #9804
                            IF NOT CONFIRM('Atención, va a actualizar el coste estándar de todas las líneas y de la receta, está seguro?')THEN EXIT;
                            CLEAR(CalculateStdCost);
                            CalculateStdCost.CalcItem(Rec."No.", TRUE);
                        //++ #9804
                        end;
                    }
                    action("Calc. Unit Price")
                    {
                        AccessByPermission = TableData 90=R;
                        Caption = 'Calc. precio venta';
                        ApplicationArea = All;
                        Image = SuggestItemPrice;
                        Visible = false;

                        trigger OnAction()
                        begin
                            //-- #9804
                            CLEAR(CalculateStdCost);
                            CalculateStdCost.CalcAssemblyItemPrice(Rec."No.")//++ #9804
                        end;
                    }
                    action("Actualizar Importancia en coste")
                    {
                        AccessByPermission = TableData 90=R;
                        Caption = 'Actualizar Importancia en coste';
                        ApplicationArea = All;
                        Image = CalculateDiscount;

                        trigger OnAction()
                        begin
                            //-- #9804
                            Rec.ActualizarImportanciaEnCoste;
                        //++ #9804
                        end;
                    }
                    action("Actualizar Coste Estandar LM")
                    {
                        AccessByPermission = TableData 90=R;
                        Caption = 'Actualizar Coste Estandar LM';
                        ApplicationArea = All;
                        Image = Camera;

                        trigger OnAction()
                        begin
                            //-- #9804
                            Rec.ActualizarCosteEstandarLM;
                        //++ #9804
                        end;
                    }
                }
            }
            action(AGRALAInfoCalidadCabecera)
            {
                Caption = 'Info Calidad';
                ApplicationArea = All;
                Image = QualificationOverview;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    rlItemVariant: Record 5401;
                    rlItemVariantTemp: Record 5401 temporary;
                    rlBOMComponent: Record "BOM Component";
                    xlFiltros: Text;
                    xlVariant: Text;
                    pl: Page 50075;
                begin
                    CLEAR(xlFiltros);
                    rlItemVariantTemp.DeleteAll();
                    rlBOMComponent.SETRANGE("Parent Item No.", Rec."No.");
                    rlBOMComponent.SETRANGE(Type, rlBOMComponent.Type::Item);
                    rlBOMComponent.FINDSET;
                    REPEAT if rlBOMComponent."Variant Code" <> '' then begin
                            rlItemVariantTemp."Item No.":=rlBOMComponent."No.";
                            rlItemVariantTemp.Code:=rlBOMComponent."Variant Code";
                            rlItemVariantTemp.Insert();
                        end;
                    //xlFiltros += '|' + rlBOMComponent."No.";
                    //if rlBOMComponent."Variant Code" <> '' then
                    //  xlVariant += '|' + rlBOMComponent."Variant Code";
                    UNTIL rlBOMComponent.NEXT() = 0;
                    //xlFiltros := COPYSTR(xlFiltros, 2);
                    //xlVariant := COPYSTR(xlVariant, 2);
                    //rlItemVariant.SETFILTER("Item No.", xlFiltros);
                    //rlItemVariant.SetFilter(Code, xlVariant);
                    //rlItemVariant.TransferFields(rlItemVariantTemp);
                    PAGE.RUN(50075, rlItemVariantTemp);
                end;
            }
            /*   action(AGRALAInformeCalidad)
              {
                  Caption = 'Informe Calidad No';
                  ApplicationArea = All;
                  Image = "Report";
                  Visible = false;

                  trigger OnAction()
                  var
                      rlItemVariant: Record 5401;
                      rlBOMComponent: Record "BOM Component";
                      xlFiltros: Text;
                      pl: Page 50075;
                      replAGRALAInfoCalidad: Report 50025;
                  begin
                      CLEAR(xlFiltros);
                      rlBOMComponent.SETRANGE("Parent Item No.", Rec."No.");
                      rlBOMComponent.SETRANGE(Type, rlBOMComponent.Type::Item);
                      rlBOMComponent.FINDSET;
                      REPEAT
                          xlFiltros += '|' + rlBOMComponent."No.";
                      UNTIL rlBOMComponent.NEXT() = 0;
                      xlFiltros := COPYSTR(xlFiltros, 2);
                      rlItemVariant.SETFILTER("Item No.", xlFiltros);
                      replAGRALAInfoCalidad.InicializarVariables(Rec.Description);
                      replAGRALAInfoCalidad.SETTABLEVIEW(rlItemVariant);
                      replAGRALAInfoCalidad.RUN();
                  end;
              } */
            action(AGRALAInformeCalidad2)
            {
                Caption = 'Informe Calidad';
                ApplicationArea = All;
                Image = "Report";

                trigger OnAction()
                var
                    rlItemVariant: Record 5401;
                    rlBOMComponent: Record 90;
                    xlFiltros: Text;
                    pl: Page 50075;
                    replAGRALAInfoCalidad: Report 50025;
                begin
                    REPORT.RUNMODAL(50026, TRUE, TRUE, Rec);
                end;
            }
            group("Calculos de receta")
            {
                Caption = 'Calculos de receta';

                action(AGRALARecalculoRecete)
                {
                    Caption = 'Recalcular lote receta';
                    ApplicationArea = All;
                    Image = Calculate;
                    Promoted = true;
                    RunObject = Page 50078;
                    RunPageLink = "No."=FIELD("No.");
                    Visible = true;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        //-- #9993
        VarFormatoStatusLM:=GetVarFormatStatus;
        CurrPage.Editable:=ValStatus(Rec."Status LM");
        //++ #9993
        ValStatus(Rec."Status LM");
        CurrPage.Update(false);
    end;
    local procedure GetVarFormatStatus()ReturnVarFormatSatus: Text begin
        //-- #9993
        CLEAR(ReturnVarFormatSatus);
        CASE Rec."Status LM" OF Rec."Status LM"::"Under Construction": ReturnVarFormatSatus:='Strong';
        Rec."Status LM"::Certificated: ReturnVarFormatSatus:='Favorable';
        Rec."Status LM"::Block: ReturnVarFormatSatus:='Unfavorable';
        END;
        EXIT(ReturnVarFormatSatus);
    //++ #9993
    end;
    local procedure ValStatus(status: Enum AlxiaStatusLM)ret: Boolean begin
        CASE status OF status::"Under Construction": varEdit:=true;
        status::Certificated: varEdit:=false;
        status::Block: varEdit:=false;
        END;
        //CurrPage.Editable := varEdit;
        ret:=varEdit;
    end;
    /*  procedure SetFijarCosteLMRecetaEnFichaArticulo()
     var
         CDU1: Codeunit FuncionesVarias;
     begin
         Rec.Receta_CosteLMFijado := CDU1.CalcItemCosteCalculado(Rec, FALSE);
         Rec.MODIFY;
     end; */
    var CalculateStdCost: Codeunit AlxiaCalculateStandardCost;
    VarFormatoStatusLM: Text;
    varEdit: Boolean;
    trigger OnClosePage()
    var
        recBOM: Record "BOM Component";
    begin
        recBOM.Reset();
        recBOM.SetRange("Parent Item No.", Rec."No.");
        if recBOM.FindFirst()then repeat if(recBOM.Type = recBOM.Type::Item) or (recBOM.Type = recBOM.Type::Resource)then if recBOM."No." = '' then begin
                        Error('Error en la linea ' + Format(recBOM."Line No.") + ' el campo Nº no puede estar vacio.');
                    //exit;
                    end;
            until recBOM.Next() = 0;
    end;
}
