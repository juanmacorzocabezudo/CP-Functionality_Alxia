report 50026 AGRALAInfoCalidadRecetas
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layout/AGRALAInfoCalidadRecetas.rdl';
    Caption = 'Info calidad recetas';

    dataset
    {
        dataitem(RecetaMadre;27)
        {
            PrintOnlyIfDetail = false;

            column(Producto00RecetaMadre; RecetaMadre."No.")
            {
            }
            column(DescricionProducto00RecetaMadre; RecetaMadre.Description)
            {
            }
            column(LoteReceta00RecetaMadre; RecetaMadre."Lote Receta")
            {
            }
            column(UMS00RecetaMadre; RecetaMadre."Base Unit of Measure")
            {
            }
            column(Texto00RecetaMadre; xl00RecetaMadre)
            {
            }
            dataitem("01Nivel";90)
            {
                DataItemLink = "Parent Item No."=FIELD("No.");
                DataItemTableView = WHERE(Type=CONST(Item));
                PrintOnlyIfDetail = false;

                column(Producto01Nivel; "01Nivel"."No.")
                {
                }
                column(DescricionProducto01Nivel; "01Nivel".Description)
                {
                }
                column(LoteReceta01Nivel; "01Nivel"."Cantidad por Lote")
                {
                }
                column(UMS01Nivel; "01Nivel"."Unit of Measure Code")
                {
                }
                column(Texto01Nivel; xl01Nivel)
                {
                }
                column(PorcentajeNivel01; xlPorcentajeNivel01)
                {
                }
                column(TLoteNivel01; xgProductoNivel01TLote)
                {
                }
                column(TPorcNivel01; xgProductoNivel01TPorc)
                {
                }
                column(Variant_Code; "Variant Code")
                {
                }
                dataitem(InfoCalidad01Nivel;5401)
                {
                    DataItemLink = "Item No."=FIELD("No."), Code=FIELD("Variant Code");

                    column(Marca01Nivel; InfoCalidad01Nivel.Code)
                    {
                    }
                    column(IngredientesOMG01Nivel; InfoCalidad01Nivel.AGRALAingredientesOMGText)
                    {
                    }
                    column(IngredientesIrradiado01Nivel; InfoCalidad01Nivel.AGRALAIrradiadoText)
                    {
                    }
                    column(AlergenosContiene01Nivel; InfoCalidad01Nivel.AGRALAAlergenosContenidoText)
                    {
                    }
                    column(AlergenosTrazas01Nivel; InfoCalidad01Nivel.AGRALAAlergenosTrazasText)
                    {
                    }
                    column(DescripcionIngredientes01Nivel; InfoCalidad01Nivel.AGRALADescripcionIngred)
                    {
                    }
                    column(DescripcionIngredientes201Nivel; InfoCalidad01Nivel.AGRALADescripcionIngred2)
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        if InfoCalidad01Nivel.Code = '' then CurrReport.Skip();
                    end;
                }
                dataitem("02Nivel";90)
                {
                    DataItemLink = "Parent Item No."=FIELD("No.");
                    DataItemTableView = WHERE(Type=CONST(Item));
                    PrintOnlyIfDetail = false;

                    column(Producto02Nivel; "02Nivel"."No.")
                    {
                    }
                    column(DescricionProducto02Nivel; "02Nivel".Description)
                    {
                    }
                    column(LoteReceta02Nivel; "02Nivel"."Cantidad por Lote")
                    {
                    }
                    column(UMS02Nivel; "02Nivel"."Unit of Measure Code")
                    {
                    }
                    column(Texto02Nivel; xl02Nivel)
                    {
                    }
                    column(PorcentajeNivel02; xlPorcentajeNivel02)
                    {
                    }
                    column(TLoteNivel02; xgProductoNivel02TLote)
                    {
                    }
                    column(TPorcNivel02; xgProductoNivel02TPorc)
                    {
                    }
                    dataitem(InfoCalidad02Nivel;5401)
                    {
                        DataItemLink = "Item No."=FIELD("No."), Code=FIELD("Variant Code");

                        column(Marca02Nivel; InfoCalidad02Nivel.Code)
                        {
                        }
                        column(IngredientesOMG02Nivel; InfoCalidad02Nivel.AGRALAingredientesOMGText)
                        {
                        }
                        column(IngredientesIrradiado02Nivel; InfoCalidad02Nivel.AGRALAIrradiadoText)
                        {
                        }
                        column(AlergenosContiene02Nivel; InfoCalidad02Nivel.AGRALAAlergenosContenidoText)
                        {
                        }
                        column(AlergenosTrazas02Nivel; InfoCalidad02Nivel.AGRALAAlergenosTrazasText)
                        {
                        }
                        column(DescripcionIngredientes02Nivel; InfoCalidad02Nivel.AGRALADescripcionIngred)
                        {
                        }
                        column(DescripcionIngredientes202Nivel; InfoCalidad02Nivel.AGRALADescripcionIngred2)
                        {
                        }
                    }
                    dataitem("03Nivel";90)
                    {
                        DataItemLink = "Parent Item No."=FIELD("No.");
                        DataItemTableView = WHERE(Type=CONST(Item));
                        PrintOnlyIfDetail = false;

                        column(Producto03Nivel; "03Nivel"."No.")
                        {
                        }
                        column(DescricionProducto03Nivel; "03Nivel".Description)
                        {
                        }
                        column(LoteReceta03Nivel; "03Nivel"."Cantidad por Lote")
                        {
                        }
                        column(UMS03Nivel; "03Nivel"."Unit of Measure Code")
                        {
                        }
                        column(Texto03Nivel; xl03Nivel)
                        {
                        }
                        column(PorcentajeNivel03; xlPorcentajeNivel03)
                        {
                        }
                        column(TLoteNivel03; xgProductoNivel03TLote)
                        {
                        }
                        column(TPorcNivel03; xgProductoNivel03TPorc)
                        {
                        }
                        dataitem(InfoCalidad03Nivel;5401)
                        {
                            DataItemLink = "Item No."=FIELD("No."), Code=FIELD("Variant Code");

                            column(Marca03Nivel; InfoCalidad03Nivel.Code)
                            {
                            }
                            column(IngredientesOMG03Nivel; InfoCalidad03Nivel.AGRALAingredientesOMGText)
                            {
                            }
                            column(IngredientesIrradiado03Nivel; InfoCalidad03Nivel.AGRALAIrradiadoText)
                            {
                            }
                            column(AlergenosContiene03Nivel; InfoCalidad03Nivel.AGRALAAlergenosContenidoText)
                            {
                            }
                            column(AlergenosTrazas03Nivel; InfoCalidad03Nivel.AGRALAAlergenosTrazasText)
                            {
                            }
                            column(DescripcionIngredientes03Nivel; InfoCalidad03Nivel.AGRALADescripcionIngred)
                            {
                            }
                            column(DescripcionIngredientes203Nivel; InfoCalidad03Nivel.AGRALADescripcionIngred2)
                            {
                            }
                        }
                        dataitem("04Nivel";90)
                        {
                            DataItemLink = "Parent Item No."=FIELD("No.");
                            DataItemTableView = WHERE(Type=CONST(Item));
                            PrintOnlyIfDetail = false;

                            column(Producto04Nivel; "04Nivel"."No.")
                            {
                            }
                            column(DescricionProducto04Nivel; "04Nivel".Description)
                            {
                            }
                            column(LoteReceta04Nivel; "04Nivel"."Cantidad por Lote")
                            {
                            }
                            column(UMS04Nivel; "04Nivel"."Unit of Measure Code")
                            {
                            }
                            column(Texto04Nivel; xl04Nivel)
                            {
                            }
                            column(PorcentajeNivel04; xlPorcentajeNivel04)
                            {
                            }
                            column(TLoteNivel04; xgProductoNivel04TLote)
                            {
                            }
                            column(TPorcNivel04; xgProductoNivel04TPorc)
                            {
                            }
                            dataitem(InfoCalidad04Nivel;5401)
                            {
                                DataItemLink = "Item No."=FIELD("No."), Code=FIELD("Variant Code");

                                column(Marca04Nivel; InfoCalidad04Nivel.Code)
                                {
                                }
                                column(IngredientesOMG04Nivel; InfoCalidad04Nivel.AGRALAingredientesOMGText)
                                {
                                }
                                column(IngredientesIrradiado04Nivel; InfoCalidad04Nivel.AGRALAIrradiadoText)
                                {
                                }
                                column(AlergenosContiene04Nivel; InfoCalidad04Nivel.AGRALAAlergenosContenidoText)
                                {
                                }
                                column(AlergenosTrazas04Nivel; InfoCalidad04Nivel.AGRALAAlergenosTrazasText)
                                {
                                }
                                column(DescripcionIngredientes04Nivel; InfoCalidad04Nivel.AGRALADescripcionIngred)
                                {
                                }
                                column(DescripcionIngredientes204Nivel; InfoCalidad04Nivel.AGRALADescripcionIngred2)
                                {
                                }
                            }
                            dataitem("05Nivel";90)
                            {
                                DataItemLink = "Parent Item No."=FIELD("No.");
                                DataItemTableView = WHERE(Type=CONST(Item));
                                PrintOnlyIfDetail = false;

                                column(Producto05Nivel; "05Nivel"."No.")
                                {
                                }
                                column(DescricionProducto05Nivel; "05Nivel".Description)
                                {
                                }
                                column(LoteReceta05Nivel; "05Nivel"."Cantidad por Lote")
                                {
                                }
                                column(UMS05Nivel; "05Nivel"."Unit of Measure Code")
                                {
                                }
                                column(Texto05Nivel; xl05Nivel)
                                {
                                }
                                column(xlPorcentajeNivel05; xlPorcentajeNivel05)
                                {
                                }
                                column(TLoteNivel05; xgProductoNivel05TLote)
                                {
                                }
                                column(TPorcNivel05; xgProductoNivel05TPorc)
                                {
                                }
                                dataitem(InfoCalidad05Nivel;5401)
                                {
                                    DataItemLink = "Item No."=FIELD("No."), Code=FIELD("Variant Code");

                                    column(Marca05Nivel; InfoCalidad05Nivel.Code)
                                    {
                                    }
                                    column(IngredientesOMG05Nivel; InfoCalidad05Nivel.AGRALAingredientesOMGText)
                                    {
                                    }
                                    column(IngredientesIrradiado05Nivel; InfoCalidad05Nivel.AGRALAIrradiadoText)
                                    {
                                    }
                                    column(AlergenosContiene05Nivel; InfoCalidad05Nivel.AGRALAAlergenosContenidoText)
                                    {
                                    }
                                    column(AlergenosTrazas05Nivel; InfoCalidad05Nivel.AGRALAAlergenosTrazasText)
                                    {
                                    }
                                    column(DescripcionIngredientes05Nivel; InfoCalidad05Nivel.AGRALADescripcionIngred)
                                    {
                                    }
                                    column(DescripcionIngredientes205Nivel; InfoCalidad05Nivel.AGRALADescripcionIngred2)
                                    {
                                    }
                                }
                                trigger OnAfterGetRecord()
                                var
                                    rlitem: Record 27;
                                begin
                                    IF(xlProductoNivel04 <> xlProductoNivel04c)THEN BEGIN
                                        xlProductoNivel04c:=xlProductoNivel04;
                                        xgProductoNivel05TLote:=0;
                                        xgProductoNivel05TPorc:=0;
                                    END;
                                    IF(xlProductoNivel04 = xlProductoNivel04c)THEN BEGIN
                                        rlitem.GET("05Nivel"."Parent Item No.");
                                        xgProductoNivel05TLote+="05Nivel"."Quantity per" * "04Nivel"."Cantidad por Lote";
                                        //xgProductoNivel05TLote += ("05Nivel"."Cantidad por Lote"*"04Nivel"."Cantidad por Lote")/ rlitem."Lote Receta";
                                        //xgProductoNivel05TLote += "05Nivel"."Cantidad por Lote";
                                        "05Nivel"."Cantidad por Lote":="05Nivel"."Quantity per" * "04Nivel"."Cantidad por Lote";
                                        xgProductoNivel05TPorc+=("05Nivel"."Cantidad por Lote" * 100) / "04Nivel"."Cantidad por Lote";
                                    END;
                                    "05Nivel"."Cantidad por Lote":="05Nivel"."Quantity per" * "04Nivel"."Cantidad por Lote";
                                    //xlPorcentajeNivel05 := (xgProductoNivel05TLote*100)/"04Nivel"."Cantidad por Lote";
                                    xlPorcentajeNivel04:=("04Nivel"."Cantidad por Lote" * 100) / "03Nivel"."Cantidad por Lote";
                                    xlProductoNivel05:="05Nivel"."No.";
                                end;
                            }
                            trigger OnAfterGetRecord()
                            var
                                rlItem: Record 27;
                            begin
                                IF(xlProductoNivel03 <> xlProductoNivel03c)THEN BEGIN
                                    xlProductoNivel03c:=xlProductoNivel03;
                                    xgProductoNivel04TLote:=0;
                                    xgProductoNivel04TPorc:=0;
                                END;
                                IF(xlProductoNivel03 = xlProductoNivel03c)THEN BEGIN
                                    rlItem.GET("04Nivel"."Parent Item No.");
                                    xgProductoNivel04TLote+="04Nivel"."Quantity per" * "03Nivel"."Cantidad por Lote";
                                    //xgProductoNivel04TLote += ("04Nivel"."Cantidad por Lote"*"03Nivel"."Cantidad por Lote")/ rlItem."Lote Receta";
                                    //xgProductoNivel04TLote += "04Nivel"."Cantidad por Lote";
                                    "04Nivel"."Cantidad por Lote":="04Nivel"."Quantity per" * "03Nivel"."Cantidad por Lote";
                                    xgProductoNivel04TPorc+=("04Nivel"."Cantidad por Lote" * 100) / "03Nivel"."Cantidad por Lote";
                                END;
                                "04Nivel"."Cantidad por Lote":="04Nivel"."Quantity per" * "03Nivel"."Cantidad por Lote";
                                //xlPorcentajeNivel04 := (xgProductoNivel04TLote*100)/"03Nivel"."Cantidad por Lote";
                                xlPorcentajeNivel04:=("04Nivel"."Cantidad por Lote" * 100) / "03Nivel"."Cantidad por Lote";
                                xlProductoNivel04:="04Nivel"."No.";
                            end;
                        }
                        trigger OnAfterGetRecord()
                        var
                            rlitem: Record 27;
                        begin
                            IF(xlProductoNivel02 <> xlProductoNivel02c)THEN BEGIN
                                xlProductoNivel02c:=xlProductoNivel02;
                                xgProductoNivel03TLote:=0;
                                xgProductoNivel03TPorc:=0;
                            END;
                            IF(xlProductoNivel02 = xlProductoNivel02c)THEN BEGIN
                                rlitem.GET("03Nivel"."Parent Item No.");
                                xgProductoNivel03TLote+="03Nivel"."Quantity per" * "02Nivel"."Cantidad por Lote";
                                //xgProductoNivel03TLote += ("03Nivel"."Cantidad por Lote"*"02Nivel"."Cantidad por Lote")/ rlitem."Lote Receta";
                                //xgProductoNivel03TLote += "03Nivel"."Cantidad por Lote";
                                "03Nivel"."Cantidad por Lote":="03Nivel"."Quantity per" * "02Nivel"."Cantidad por Lote";
                                xgProductoNivel03TPorc+=("03Nivel"."Cantidad por Lote" * 100) / "02Nivel"."Cantidad por Lote";
                            END;
                            "03Nivel"."Cantidad por Lote":="03Nivel"."Quantity per" * "02Nivel"."Cantidad por Lote";
                            //xlPorcentajeNivel03 := (xgProductoNivel03TLote*100)/"02Nivel"."Cantidad por Lote";
                            xlPorcentajeNivel03:=("03Nivel"."Cantidad por Lote" * 100) / "02Nivel"."Cantidad por Lote";
                            xlProductoNivel03:="03Nivel"."No.";
                        end;
                    }
                    trigger OnAfterGetRecord()
                    var
                        rlItem: Record 27;
                    begin
                        IF(xlProductoNivel01 <> xlProductoNivel01c)THEN BEGIN
                            xlProductoNivel01c:=xlProductoNivel01;
                            xgProductoNivel02TLote:=0;
                            xgProductoNivel02TPorc:=0;
                        END;
                        IF(xlProductoNivel01 = xlProductoNivel01c)THEN BEGIN
                            rlItem.GET("02Nivel"."Parent Item No.");
                            xgProductoNivel02TLote+="02Nivel"."Quantity per" * "01Nivel"."Cantidad por Lote";
                            //xgProductoNivel02TLote += ("02Nivel"."Cantidad por Lote"*"01Nivel"."Cantidad por Lote")/ rlItem."Lote Receta";
                            //xgProductoNivel02TPorc += (xgProductoNivel02TLote*100)/"01Nivel"."Cantidad por Lote";
                            xgProductoNivel02TPorc+=("02Nivel"."Cantidad por Lote" * 100) / "01Nivel"."Cantidad por Lote";
                        END;
                        "02Nivel"."Cantidad por Lote":="02Nivel"."Quantity per" * "01Nivel"."Cantidad por Lote";
                        //xlPorcentajeNivel02 := (xgProductoNivel02TLote*100)/"01Nivel"."Cantidad por Lote";
                        xlPorcentajeNivel02:=("02Nivel"."Cantidad por Lote" * 100) / "01Nivel"."Cantidad por Lote";
                        xlProductoNivel02:="02Nivel"."No.";
                    end;
                }
                trigger OnAfterGetRecord()
                var
                    rlItem: Record 27;
                begin
                    IF(xlProductoNivel00 <> xlProductoNivel00c)THEN BEGIN
                        xlProductoNivel00c:=xlProductoNivel00;
                        xgProductoNivel01TLote:=0;
                        xgProductoNivel01TPorc:=0;
                    END;
                    IF(xlProductoNivel00 = xlProductoNivel00c)THEN BEGIN
                        rlItem.GET("01Nivel"."Parent Item No.");
                        xgProductoNivel01TLote+="01Nivel"."Quantity per" * RecetaMadre."Lote Receta";
                        //xgProductoNivel02TLote += ("02Nivel"."Cantidad por Lote"*"01Nivel"."Cantidad por Lote")/ rlItem."Lote Receta";
                        //xgProductoNivel02TPorc += (xgProductoNivel02TLote*100)/"01Nivel"."Cantidad por Lote";
                        xgProductoNivel01TPorc+=("01Nivel"."Cantidad por Lote" * 100) / RecetaMadre."Lote Receta";
                    END;
                    "01Nivel"."Cantidad por Lote":="01Nivel"."Quantity per" * RecetaMadre."Lote Receta";
                    //xlPorcentajeNivel02 := (xgProductoNivel02TLote*100)/"01Nivel"."Cantidad por Lote";
                    xlPorcentajeNivel01:=("01Nivel"."Cantidad por Lote" * 100) / RecetaMadre."Lote Receta";
                    xlProductoNivel01:="01Nivel"."No.";
                    //xlPorcentajeNivel00 := RecetaMadre."Lote Receta"*100)/RecetaMadre."Lote Receta";
                    //xlPorcentajeNivel01 := ("01Nivel"."Cantidad por Lote"*RecetaMadre."Lote Receta")/100;
                    xlProductoNivel00:=RecetaMadre."No.";
                end;
            }
            trigger OnAfterGetRecord()
            var
                rl1BOMComponent: Record 90;
                rl2BOMComponent: Record 90;
                rl3BOMComponent: Record 90;
                rl4BOMComponent: Record 90;
                rl5BOMComponent: Record 90;
                xlProductoNivel01: Code[20];
                xlProductoNivel02: Code[20];
                xlProductoNivel03: Code[20];
                xlProductoNivel04: Code[20];
                xlProductoNivel05: Code[20];
                xlProductoNivel01c: Code[20];
                xlProductoNivel02c: Code[20];
                xlProductoNivel03c: Code[20];
                xlProductoNivel04c: Code[20];
                xlProductoNivel05c: Code[20];
                rlItem: Record 27;
            begin
                CLEAR(rl1BOMComponent);
                CLEAR(xgProductoNivel01TLote);
                CLEAR(xgProductoNivel02TLote);
                CLEAR(xgProductoNivel03TLote);
                CLEAR(xgProductoNivel04TLote);
                CLEAR(xgProductoNivel05TLote);
                CLEAR(xlProductoNivel01);
                CLEAR(xlProductoNivel02);
                CLEAR(xlProductoNivel03);
                CLEAR(xlProductoNivel04);
                CLEAR(xlProductoNivel05);
                CLEAR(xlProductoNivel01c);
                CLEAR(xlProductoNivel02c);
                CLEAR(xlProductoNivel03c);
                CLEAR(xlProductoNivel04c);
                CLEAR(xlProductoNivel05c);
                CLEAR(rl1BOMComponent);
                rl1BOMComponent.SETRANGE("Parent Item No.", RecetaMadre."No.");
                IF rl1BOMComponent.FINDSET THEN REPEAT xgProductoNivel01TLote+=rl1BOMComponent."Cantidad por Lote";
                        xgProductoNivel01TPorc+=(rl1BOMComponent."Cantidad por Lote" * 100) / RecetaMadre."Lote Receta";
                        CLEAR(rl2BOMComponent);
                        rl2BOMComponent.SETRANGE("Parent Item No.", rl1BOMComponent."No.");
                        IF rl2BOMComponent.FINDSET THEN REPEAT rlItem.GET(rl2BOMComponent."Parent Item No.");
                                xgProductoNivel02TLote+=(rl2BOMComponent."Cantidad por Lote" * rl1BOMComponent."Cantidad por Lote") / rlItem."Lote Receta";
                                xgProductoNivel02TPorc+=(rl2BOMComponent."Cantidad por Lote" * 100) / rl1BOMComponent."Cantidad por Lote";
                                CLEAR(rl3BOMComponent);
                                rl3BOMComponent.SETRANGE("Parent Item No.", rl2BOMComponent."No.");
                                IF rl3BOMComponent.FINDSET THEN REPEAT rlItem.GET(rl3BOMComponent."Parent Item No.");
                                        xgProductoNivel03TLote+=(rl3BOMComponent."Cantidad por Lote" * rl2BOMComponent."Cantidad por Lote") / rlItem."Lote Receta";
                                        xgProductoNivel03TPorc+=(rl3BOMComponent."Cantidad por Lote" * 100) / rl2BOMComponent."Cantidad por Lote";
                                        CLEAR(rl4BOMComponent);
                                        rl4BOMComponent.SETRANGE("Parent Item No.", rl3BOMComponent."No.");
                                        IF rl4BOMComponent.FINDSET THEN REPEAT rlItem.GET(rl4BOMComponent."Parent Item No.");
                                                xgProductoNivel04TLote+=(rl4BOMComponent."Cantidad por Lote" * rl3BOMComponent."Cantidad por Lote") / rlItem."Lote Receta";
                                                xgProductoNivel04TPorc+=(rl4BOMComponent."Cantidad por Lote" * 100) / rl3BOMComponent."Cantidad por Lote";
                                                CLEAR(rl5BOMComponent);
                                                rl5BOMComponent.SETRANGE("Parent Item No.", rl4BOMComponent."No.");
                                                IF rl5BOMComponent.FINDSET THEN REPEAT rlItem.GET(rl5BOMComponent."Parent Item No.");
                                                        xgProductoNivel05TLote+=(rl5BOMComponent."Cantidad por Lote" * rl4BOMComponent."Cantidad por Lote") / rlItem."Lote Receta";
                                                        xgProductoNivel05TPorc+=(rl5BOMComponent."Cantidad por Lote" * 100) / rl4BOMComponent."Cantidad por Lote";
                                                    UNTIL rl5BOMComponent.NEXT = 0;
                                            UNTIL rl4BOMComponent.NEXT = 0;
                                    UNTIL rl3BOMComponent.NEXT = 0;
                            UNTIL rl2BOMComponent.NEXT = 0;
                    UNTIL rl1BOMComponent.NEXT = 0;
                xlProductoNivel00:=RecetaMadre."No.";
            end;
        }
        dataitem(DataItem1000000013;2000000026)
        {
            DataItemTableView = WHERE(Number=FILTER(=1));

            column(Picture; rlCompanyInfo.Picture)
            {
            }
            trigger OnPreDataItem()
            begin
                rlCompanyInfo.CALCFIELDS(Picture);
            end;
        }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    labels
    {
    }
    var xl00RecetaMadre: Label '00 - Receta Madre';
    xl01Nivel: Label '01 - Nivel';
    xl02Nivel: Label '02 - Nivel';
    xl03Nivel: Label '03 - Nivel';
    xl04Nivel: Label '04 - Nivel';
    xl05Nivel: Label '05 - Nivel';
    rlCompanyInfo: Record 79;
    xlPorcentajeNivel01: Decimal;
    xlPorcentajeNivel00: Decimal;
    xlPorcentajeNivel02: Decimal;
    xlPorcentajeNivel03: Decimal;
    xlPorcentajeNivel04: Decimal;
    xlPorcentajeNivel05: Decimal;
    xlProductoNivel01: Text;
    xlProductoNivel00: Text;
    xlProductoNivel02: Text;
    xlProductoNivel03: Text;
    xlProductoNivel04: Text;
    xlProductoNivel05: Text;
    xgProductoNivel01TLote: Decimal;
    xgProductoNivel00TLote: Decimal;
    xgProductoNivel02TLote: Decimal;
    xgProductoNivel03TLote: Decimal;
    xgProductoNivel04TLote: Decimal;
    xgProductoNivel05TLote: Decimal;
    xgProductoNivel01TPorc: Decimal;
    xgProductoNivel02TPorc: Decimal;
    xgProductoNivel03TPorc: Decimal;
    xgProductoNivel04TPorc: Decimal;
    xgProductoNivel05TPorc: Decimal;
    xlProductoNivel01c: Text;
    xlProductoNivel00c: Text;
    xlProductoNivel02c: Text;
    xlProductoNivel03c: Text;
    xlProductoNivel04c: Text;
    xlProductoNivel05c: Text;
    ig: Integer;
}
