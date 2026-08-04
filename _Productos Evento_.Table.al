table 50016 "Productos Evento"
{
    // 
    // ADVANCE - Log de cambios
    // -----------------------------------------------------
    //   ADVANCE
    //   Fecha: 01-03-2017
    //   Técnico: JAB
    //   Presupuesto: I003981 - Nuevo fichero de Productos Evento para poder realizar
    //                          el desglose de opciones en Menaje, Suplementos y Pan.
    //   Etiqueta: ADV001
    // -----------------------------------------------------
    //   ADVANCE
    //   Fecha: 21-03-2017
    //   Técnico: JAB
    //   Presupuesto: I004128 - Recálculo Precio Real
    //   Modificación: Cuando se modifica el Coste Unitario no debe recalcularse el Precio Real
    // 
    //   Etiqueta: ADV002
    // -----------------------------------------------------
    //   ADVANCE
    //   Fecha: 08-05-2017
    //   Técnico: JAB
    //   Presupuesto: I004422 - Función para Eliminar Productos
    //   Modificación: Cuando se elimine debe borrar los productos
    // 
    //   Etiqueta: ADV003
    // -----------------------------------------------------
    // ADVANCE
    //   Fecha: 27/03/2019
    //   Técnico: CPL
    //   Presupuesto: I011530 - No deja cambiar un producto. tiene que eliminar la línea y crear otra.
    //   Si no se quedan líneas colgadas en Lineas componentes
    //   Modificación:
    //   Etiqueta: ADV004
    // -----------------------------------------------------
    DrillDownPageID = 50032;
    LookupPageID = 50032;

    fields
    {
        field(1; "Codigo Evento"; Code[20])
        {
            Editable = false;
            TableRelation = Evento;
        }
        field(2; Linea; Integer)
        {
        }
        field(3; "Codigo Producto"; Code[20])
        {
            TableRelation = Item."No.";

            trigger OnLookup()
            var
                Resource: Record Resource;
            begin
            end;

            trigger OnValidate()
            var
                lt_Evento: Record Evento;
                lt_Customer: Record Customer;
                lt_VATPostingSetup: Record "VAT Posting Setup";
                lt_CustTemplate: Record "Customer Templ.";
            begin
                IF "Codigo Producto" <> '' THEN BEGIN
                    gt_producto.GET("Codigo Producto");
                    Descripcion := gt_producto.Description;
                    "Unidad de medida" := gt_producto."Base Unit of Measure";
                    //"Tipo Recurso" := gt_recurso.Type;
                    lt_Evento.GET("Codigo Evento");
                    IF lt_Evento."Codigo Cliente" <> '' THEN BEGIN
                        lt_Customer.GET(lt_Evento."Codigo Cliente");
                        lt_VATPostingSetup.GET(lt_Customer."VAT Bus. Posting Group", gt_producto."VAT Prod. Posting Group");
                        "% IVA" := lt_VATPostingSetup."VAT %";
                    END
                    ELSE BEGIN
                        lt_Evento.TESTFIELD("Plantilla Cliente");
                        lt_CustTemplate.GET(lt_Evento."Plantilla Cliente");
                        lt_VATPostingSetup.GET(lt_CustTemplate."VAT Bus. Posting Group", gt_producto."VAT Prod. Posting Group");
                        "% IVA" := lt_VATPostingSetup."VAT %";
                    END;
                END
                ELSE BEGIN
                    Descripcion := '';
                    "Unidad de medida" := '';
                    //"Tipo Recurso" := 0;
                    "% IVA" := 0;
                END;
                // Inicio ADV001
                lfu_InsertaComponentes;
                lfu_CalculaImporte;
                // Fin ADV001
            end;
        }
        field(4; Descripcion; Text[50])
        {
            trigger OnValidate()
            var
                lt_lincom: Record "Componentes Evento";
            begin
            end;
        }
        field(6; Cantidad; Decimal)
        {
            trigger OnValidate()
            begin
                lfu_CalculaPrecios;
            end;
        }
        field(7; "Unidad de medida"; Code[20])
        {
            TableRelation = "Resource Unit of Measure".Code WHERE("Resource No." = FIELD("Unidad de medida"));
        }
        field(8; "Coste Unitario"; Decimal)
        {
            DecimalPlaces = 0 : 4;
            Editable = true;

            trigger OnValidate()
            begin
                lfu_CalculaPreciosCantidad;
            end;
        }
        field(9; "Coste Total"; Decimal)
        {
            Editable = false;
        }
        field(10; Precio; Decimal)
        {
            Editable = false;
        }
        field(11; "Hora Evento"; Time)
        {
            Editable = false;
            Enabled = false;
        }
        field(13; Comentarios; Text[80])
        {
        }
        field(15; "Tipo Margen"; Option)
        {
            OptionMembers = Porcentaje,Importe;

            trigger OnValidate()
            begin
                lfu_CalculaPrecios;
            end;
        }
        field(16; "Valor Margen"; Decimal)
        {
            trigger OnValidate()
            begin
                lfu_CalculaPrecios;
            end;
        }
        field(19; "Precio Propuesto"; Decimal)
        {
            Editable = false;
        }
        field(20; "Precio Real"; Decimal)
        {
            trigger OnValidate()
            begin
                lfu_CalculaImporte;
            end;
        }
        field(21; Tipo; Option)
        {
            Description = 'I003981';
            OptionCaption = 'Personal,Otros,Menaje,Suplementos,Pan';
            OptionMembers = Personal,Otros,Menaje,Suplementos,Pan;
        }
        field(22; Importe; Decimal)
        {
        }
        field(23; "% IVA"; Decimal)
        {
            Editable = false;
        }
        field(24; "Importe IVA Incl."; Decimal)
        {
            Editable = false;
        }
        field(25; "Precio IVA Incl."; Decimal)
        {
            Editable = false;
        }
        field(26; Imprime; Boolean)
        {
            InitValue = true;
        }
        field(27; Producto; Code[20])
        {
            Description = 'I003981';
            TableRelation = Item;

            trigger OnValidate()
            var
                lt_Evento: Record Evento;
                lt_Customer: Record Customer;
                lt_VATPostingSetup: Record "VAT Posting Setup";
                lt_CustTemplate: Record "Customer Templ.";
            begin
                //ADV004 Inicio
                IF (Rec.Producto <> xRec.Producto) AND (xRec.Producto <> '') THEN BEGIN
                    ERROR('No se puede modificar un producto.Tiene que eliminar la línea y crearla de nuevo');
                END;
                //ADV004 Fin
                IF Producto <> '' THEN BEGIN
                    gt_producto.GET(Producto);
                    Descripcion := gt_producto.Description;
                    "Unidad de medida" := gt_producto."Base Unit of Measure";
                    lt_Evento.GET("Codigo Evento");
                    IF lt_Evento."Codigo Cliente" <> '' THEN BEGIN
                        lt_Customer.GET(lt_Evento."Codigo Cliente");
                        lt_VATPostingSetup.GET(lt_Customer."VAT Bus. Posting Group", gt_producto."VAT Prod. Posting Group");
                        "% IVA" := lt_VATPostingSetup."VAT %";
                    END
                    ELSE BEGIN
                        lt_Evento.TESTFIELD("Plantilla Cliente");
                        lt_CustTemplate.GET(lt_Evento."Plantilla Cliente");
                        lt_VATPostingSetup.GET(lt_CustTemplate."VAT Bus. Posting Group", gt_producto."VAT Prod. Posting Group");
                        "% IVA" := lt_VATPostingSetup."VAT %";
                    END;
                END
                ELSE BEGIN
                    Descripcion := '';
                    "Unidad de medida" := '';
                    "% IVA" := 0;
                END;
                // Inicio ADV001
                lfu_InsertaComponentes;
                lfu_CalculaImporte;
                // Fin ADV001
            end;
        }
        field(28; ImprCapitulo; Code[20])
        {
            Caption = 'Capitulo';
            TableRelation = AlxImpresionCapitulos.Code;

            trigger OnValidate()
            var
                lt_Capitulo: Record "AlxImpresionCapitulos";
            begin
                IF (ImprCapitulo <> xRec.ImprCapitulo) and (ImprCapitulo <> '') THEN BEGIN
                    lt_Capitulo.GET(ImprCapitulo);
                    DescripCapitulo := lt_Capitulo.Descripcion;
                END
                ELSE
                    DescripCapitulo := '';
            end;
        }
        field(29; DescripCapitulo; Text[150])
        {
            Caption = 'Descripción';
        }
    }
    keys
    {
        key(Key1; "Codigo Evento", Tipo, Linea)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnDelete()
    begin
        // Inicio ADV003
        lfu_BorraComponentes(TRUE);
        // Fin ADV003
    end;

    trigger OnInsert()
    var
        lt_Capitulo: Record "AlxImpresionCapitulos";
    begin
        gt_evento.GET("Codigo Evento");
        "Tipo Margen" := "Tipo Margen"::Porcentaje;
        "Valor Margen" := gt_evento."% Beneficio";
        // Inicio ADV001
        lfu_InsertaComponentes;
        // Fin ADV001
        if Rec.Tipo = Rec.Tipo::Pan then begin
            ImprCapitulo := 'PAN';
            if lt_Capitulo.GET(ImprCapitulo) then;
            DescripCapitulo := lt_Capitulo.Descripcion;
        end;
        if Rec.Tipo = Rec.Tipo::Suplementos then begin
            ImprCapitulo := 'SUPLEMENTO';
            if lt_Capitulo.GET(ImprCapitulo) then;
            DescripCapitulo := lt_Capitulo.Descripcion;
        end;
        if Rec.Tipo = Rec.Tipo::Menaje then begin
            ImprCapitulo := 'MENAJE';
            if lt_Capitulo.GET(ImprCapitulo) then;
            DescripCapitulo := lt_Capitulo.Descripcion;
        end;
        /*  if Rec.Tipo = Rec.Tipo::Otros then begin
             ImprCapitulo := 'OTROS';
             if lt_Capitulo.GET(ImprCapitulo) then;
             DescripCapitulo := lt_Capitulo.Descripcion;
         end; */
        // ADV004 Inicio
        IF Rec.Producto <> '' THEN BEGIN
            gt_producto.GET(Rec.Producto);
            Rec.VALIDATE("Codigo Producto", gt_producto."No.");
        END
        ELSE
            Rec."Codigo Producto" := '';
        // ADV004 Fin
    end;

    trigger OnModify()
    begin
        // Inicio ADV001
        lfu_InsertaComponentes;
        // Fin ADV001
    end;

    trigger OnRename()
    begin
        ERROR('No puede renombrar líneas');
    end;

    var
        gt_evento: Record Evento;
        gt_producto: Record Item;
        FuncionesVarias: Codeunit FuncionesVarias;
        SkipConfirmUpdate: Boolean;
        WarningModeOff: Boolean;
        //"//++ crear lineas ensamblados": ;
        Text001: Label 'Do you want to update the %1 on the lines?';
        Text002: Label 'Do you want to update the Dimensions on the lines?';
        Text003: Label 'Changing %1 will change all the lines. Do you want to change the %1 from %2 to %3?';
        Text004: Label 'This assembly order may have customized lines. Are you sure that you want to reset the lines according to the assembly BOM?';
        Text005: Label 'Due Date %1 is before work date %2 in one or more of the assembly lines.';
        Text006: Label 'Item %1 is not a BOM.';
        Text007: Label 'There is not enough space to explode the BOM.';

    local procedure lfu_CalculaImporte()
    var
        GLSetup: Record "General Ledger Setup";
    begin
        GLSetup.GET;
        Importe := ROUND(Rec.Cantidad * Rec."Precio Real", GLSetup."Amount Rounding Precision");
        "Importe IVA Incl." := ROUND(Importe * (1 + "% IVA" / 100), GLSetup."Amount Rounding Precision");
        "Precio IVA Incl." := ROUND("Precio Real" * (1 + "% IVA" / 100), GLSetup."Amount Rounding Precision");
    end;

    local procedure lfu_CalculaImporteOut(var RecPE: record "Productos Evento")
    var
        GLSetup: Record "General Ledger Setup";
    begin
        GLSetup.GET;
        RecPE.Importe := ROUND(RecPE.Cantidad * RecPE."Precio Real", GLSetup."Amount Rounding Precision");
        RecPE."Importe IVA Incl." := ROUND(RecPE.Importe * (1 + RecPE."% IVA" / 100), GLSetup."Amount Rounding Precision");
        RecPE."Precio IVA Incl." := ROUND(RecPE."Precio Real" * (1 + "% IVA" / 100), GLSetup."Amount Rounding Precision");
    end;

    local procedure lfu_CalculaPreciosCantidad()
    begin
        IF (xRec."Coste Unitario" <> Rec."Coste Unitario") OR (xRec."Tipo Margen" <> Rec."Tipo Margen") OR (xRec."Valor Margen" <> Rec."Valor Margen") THEN BEGIN
            gt_producto.GET(Producto);
            // "Coste Unitario" := gt_recurso."Unit Cost";
            "Coste Total" := Cantidad * "Coste Unitario";
            // Precio := gt_recurso."Unit Price";
            IF "Tipo Margen" = Rec."Tipo Margen"::Porcentaje THEN
                "Precio Propuesto" := ("Coste Total" * (1 + "Valor Margen" / 100)) / Cantidad
            ELSE IF "Tipo Margen" = Rec."Tipo Margen"::Importe THEN "Precio Propuesto" := ("Coste Total" + (Cantidad * "Valor Margen")) / Cantidad;
            // Inicio ADV002
            // ADV002 "Precio Real" := "Precio Propuesto";
            // Fin ADV002
            lfu_CalculaImporte;
        END;
    end;

    local procedure lfu_CalculaPrecios2()
    var
        RecComp: Record "Componentes Evento";
        costeTotal: Decimal;
    begin
        IF (xRec.Cantidad <> Rec.Cantidad) OR (xRec."Tipo Margen" <> Rec."Tipo Margen") OR (xRec."Valor Margen" <> Rec."Valor Margen") THEN BEGIN
            gt_producto.GET(Producto);
            //++ KR 29/01/21
            IF gt_producto."Standard Cost" <> 0 THEN
                "Coste Unitario" := gt_producto."Standard Cost"
            ELSE
                //-- KR
                "Coste Unitario" := gt_producto."Unit Cost";
            //SL: Inicio
            RecComp.Reset();
            RecComp.SetRange(RecComp."Codigo Evento", "Codigo Evento");
            RecComp.SetRange("Parent Item No.", Producto);
            if RecComp.FindFirst() then
                repeat
                    costeTotal := costeTotal + RecComp.CosteUnitario;
                until RecComp.Next() = 0;
            //if costeTotal <> 0 then
            "Coste Unitario" := costeTotal;
            //SL: Fin
            "Coste Total" := Cantidad * "Coste Unitario";
            Precio := gt_producto."Unit Price";
            IF "Tipo Margen" = Rec."Tipo Margen"::Porcentaje THEN
                "Precio Propuesto" := ("Coste Total" * (1 + "Valor Margen" / 100)) / Cantidad
            ELSE IF "Tipo Margen" = Rec."Tipo Margen"::Importe THEN "Precio Propuesto" := ("Coste Total" + (Cantidad * "Valor Margen")) / Cantidad;
            // Inicio ADV002
            // ADV002 "Precio Real" := "Precio Propuesto";
            // Fin ADV002
            lfu_CalculaImporte;
        END;
    end;

    local procedure lfu_CalculaPrecios()
    var
        RecComp: Record "Componentes Evento";
        costeTotal: Decimal;
    begin
        IF (xRec.Cantidad <> Rec.Cantidad) OR (xRec."Tipo Margen" <> Rec."Tipo Margen") OR (xRec."Valor Margen" <> Rec."Valor Margen") THEN BEGIN
            gt_producto.GET(Producto);
            //++ KR 29/01/21
            /*if (xRec."Coste Unitario" = Rec."Coste Unitario") and (Rec."Coste Unitario" <> 0) then
                "Coste Unitario" := Rec."Coste Unitario"
            else
                IF gt_producto."Standard Cost" <> 0 THEN
                    "Coste Unitario" := gt_producto."Standard Cost"
                ELSE
                    //-- KR
                    "Coste Unitario" := gt_producto."Unit Cost";*/
            //SL: Inicio
            RecComp.Reset();
            RecComp.SetRange(RecComp."Codigo Evento", "Codigo Evento");
            RecComp.SetRange(RecComp."Linea Evento", Linea);
            RecComp.SetRange("Parent Item No.", Producto);
            if RecComp.FindFirst() then
                repeat
                    costeTotal := costeTotal + RecComp.CosteUnitario;
                until RecComp.Next() = 0
            // [24/03/2026] RM >>>
            // El valor del coste unitario, si no existe componentes, debe guardarse el coste unitario de la ficha del producto.
            else
                costeTotal := gt_producto."Unit Cost";
            // [24/03/2026] RM <<<
            //if costeTotal <> 0 then
            "Coste Unitario" := costeTotal;
            //SL: Fin
            "Coste Total" := Cantidad * "Coste Unitario";
            Precio := gt_producto."Unit Price";
            IF "Tipo Margen" = Rec."Tipo Margen"::Porcentaje THEN
                "Precio Propuesto" := ("Coste Total" * (1 + "Valor Margen" / 100)) / Cantidad
            ELSE IF "Tipo Margen" = Rec."Tipo Margen"::Importe THEN "Precio Propuesto" := ("Coste Total" + (Cantidad * "Valor Margen")) / Cantidad;
            // Inicio ADV002
            // ADV002 "Precio Real" := "Precio Propuesto";
            // Fin ADV002
            lfu_CalculaImporte;
        END;
    end;

    procedure lfu_CalculaPreciosOut(var RecPE: Record "Productos Evento")
    var
        RecComp: Record "Componentes Evento";
        costeTotal: Decimal;
    begin
        //IF (xRec.Cantidad <> Rec.Cantidad) OR (xRec."Tipo Margen" <> Rec."Tipo Margen") OR (xRec."Valor Margen" <> Rec."Valor Margen") THEN BEGIN
        //gt_producto.GET(RecPE.Producto);
        //++ KR 29/01/21
        //IF gt_producto."Standard Cost" <> 0 THEN
        //    RecPE."Coste Unitario" := gt_producto."Standard Cost"
        // ELSE
        //-- KR
        //   RecPE."Coste Unitario" := gt_producto."Unit Cost";
        //SL: Inicio
        RecComp.Reset();
        RecComp.SetRange(RecComp."Codigo Evento", RecPE."Codigo Evento");
        RecComp.SetRange("Linea Evento", RecPE.Linea);
        RecComp.SetRange("Parent Item No.", RecPE.Producto);
        if RecComp.FindFirst() then
            repeat
                costeTotal := costeTotal + RecComp.CosteUnitario;
            until RecComp.Next() = 0;
        RecPE."Coste Unitario" := costeTotal;
        //SL: Fin
        RecPE."Coste Total" := RecPE.Cantidad * RecPE."Coste Unitario";
        RecPE.Precio := gt_producto."Unit Price";
        if recPE.Cantidad <> 0 then
            IF RecPE."Tipo Margen" = RecPE."Tipo Margen"::Porcentaje THEN
                RecPE."Precio Propuesto" := (RecPE."Coste Total" * (1 + RecPE."Valor Margen" / 100)) / RecPE.Cantidad
            ELSE IF RecPE."Tipo Margen" = RecPE."Tipo Margen"::Importe THEN RecPE."Precio Propuesto" := (RecPE."Coste Total" + (RecPE.Cantidad * RecPE."Valor Margen")) / RecPE.Cantidad;
        // Inicio ADV002
        // ADV002 "Precio Real" := "Precio Propuesto";
        // Fin ADV002
        lfu_CalculaImporteOut(RecPE);
        //END;
    end;

    local procedure lfu_BorraComponentes(b_runTrigger: Boolean)
    var
        lt_lincom: Record "Componentes Evento";
        lt_linprod: Record "Productos Evento";
    begin
        lt_lincom.RESET;
        lt_lincom.SETRANGE(lt_lincom."Codigo Evento", "Codigo Evento");
        lt_lincom.SETRANGE(lt_lincom."Linea Evento", Linea);
        lt_lincom.SETRANGE(lt_lincom."Parent Item No.", Rec."Codigo Producto");
        lt_lincom.DELETEALL(b_runTrigger);
    end;

    local procedure lfu_InsertaComponentes()
    var
        lt_bom: Record "BOM Component";
        lt_producto: Record Item;
        lt_lincom: Record "Componentes Evento";
        numBocados: Integer;
        lt_ProdComp: Record Item;
        cantidadComp: Decimal;
    begin
        //++ KR - 11/08/21 - Si ya existen las líneas que solo modifique la cantidad
        IF CompruebaSiHayComponentes THEN BEGIN
            ModificarComponentes;
            EXIT;
        END;
        //--
        //IF (Rec."Codigo Producto" = '') AND (Rec.Producto <> '') THEN
        Rec."Codigo Producto" := Rec.Producto;
        //++ KR 11/08/21 - SE CAMBIA PARA QUE NO BORRE LAS LÍNEAS GENERADAS, SOLO CAMBIE LA CANTIDAD
        lfu_BorraComponentes(TRUE);
        //-- KR
        IF (Rec.Linea <> 0) AND (Rec."Codigo Producto" <> '') THEN BEGIN
            //++ KR 11/08/21 - SE CAMBIA PARA QUE NO BORRE LAS LÍNEAS GENERADAS, SOLO CAMBIE LA CANTIDAD
            lfu_BorraComponentes(TRUE);
            //__
            IF "Codigo Producto" <> '' THEN BEGIN
                lt_producto.GET("Codigo Producto");
                IF Rec.Tipo = Rec.Tipo::Otros THEN BEGIN
                    lt_producto.TESTFIELD("Bocados por comensal");
                    //numBocados := Cantidad * lt_producto."Bocados por comensal";
                    lt_bom.RESET;
                    lt_bom.SETRANGE(lt_bom."Parent Item No.", "Codigo Producto");
                    IF lt_bom.FINDSET THEN BEGIN
                        lfu_BorraComponentes(FALSE);
                        REPEAT
                            lt_lincom.INIT;
                            lt_lincom.TRANSFERFIELDS(lt_bom);
                            lt_lincom."Codigo Evento" := "Codigo Evento";
                            lt_lincom."Linea Evento" := Rec.Linea;
                            lt_lincom.Intermedio := true;
                            lt_ProdComp.GET(lt_bom."No.");
                            lt_ProdComp.TESTFIELD("Bocados por bandeja");
                            // ADV001 lt_lincom.Bocados := Bocados * lt_bom."Cantidad por Lote";
                            // ADV001 cantidadComp := Bocados * lt_bom."Cantidad por Lote" / lt_ProdComp."Bocados por bandeja";
                            //lt_lincom.VALIDATE("Cantidad por Lote", ROUND(cantidadComp,1,'>'));
                            lt_lincom."Cantidad por Lote" := ROUND(cantidadComp, 1, '>');
                            IF (lt_lincom.Type = lt_lincom.Type::Resource) AND (lt_lincom."Resource Usage Type" = lt_lincom."Resource Usage Type"::Fixed) THEN
                                lt_lincom.VALIDATE("Quantity per", lt_lincom."Cantidad por Lote")
                            ELSE BEGIN
                                IF Rec.Cantidad <> 0 THEN
                                    lt_lincom.VALIDATE("Quantity per", lt_lincom."Cantidad por Lote" / Rec.Cantidad)
                                ELSE
                                    lt_lincom.VALIDATE("Quantity per", 0);
                            END;
                            lt_lincom."Coste Lote" := lt_lincom."Cantidad por Lote" * lt_lincom.CosteUnitario;
                            IF lt_lincom."Linea Evento" <> 0 THEN lt_lincom.INSERT;
                        UNTIL lt_bom.NEXT = 0;
                    END;
                END
                ELSE BEGIN
                    lt_bom.RESET;
                    lt_bom.SETRANGE(lt_bom."Parent Item No.", "Codigo Producto");
                    IF lt_bom.FINDSET THEN BEGIN
                        lfu_BorraComponentes(FALSE);
                        REPEAT
                            lt_lincom.INIT;
                            lt_lincom.TRANSFERFIELDS(lt_bom);
                            lt_lincom."Codigo Evento" := "Codigo Evento";
                            lt_lincom."Linea Evento" := Rec.Linea;
                            lt_lincom.Intermedio := true;
                            //lt_lincom.VALIDATE("Cantidad por Lote", lt_lincom."Cantidad por Lote" * Cantidad / lt_producto."Lote Receta");
                            lt_lincom."Cantidad por Lote" := lt_lincom."Cantidad por Lote" * Cantidad / lt_producto."Lote Receta";
                            IF (lt_lincom.Type = lt_lincom.Type::Resource) AND (lt_lincom."Resource Usage Type" = lt_lincom."Resource Usage Type"::Fixed) THEN
                                lt_lincom.VALIDATE("Quantity per", lt_lincom."Cantidad por Lote")
                            ELSE BEGIN
                                IF Rec.Cantidad <> 0 THEN
                                    lt_lincom.VALIDATE("Quantity per", lt_lincom."Cantidad por Lote" / Rec.Cantidad)
                                ELSE
                                    lt_lincom.VALIDATE("Quantity per", 0);
                            END;
                            lt_lincom."Coste Lote" := lt_lincom."Cantidad por Lote" * lt_lincom.CosteUnitario;
                            IF lt_lincom."Linea Evento" <> 0 THEN lt_lincom.INSERT;
                        UNTIL lt_bom.NEXT = 0;
                    END;
                END;
            END;
        END;
    end;

    local procedure lfu_TieneComponentes() TieneLineas: Boolean
    var
        lt_lincom: Record "Componentes Evento";
        cantidadComp: Decimal;
    begin
        TieneLineas := FALSE;
        IF Rec.Linea <> 0 THEN BEGIN
            lt_lincom.RESET;
            lt_lincom.SETRANGE(lt_lincom."Codigo Evento", Rec."Codigo Evento");
            lt_lincom.SETRANGE(lt_lincom."Linea Evento", Rec.Linea);
            TieneLineas := NOT lt_lincom.ISEMPTY;
        END;
    end;

    procedure gfu_CreaRegPedEnsamblado()
    var
        AsmHeader: Record "Assembly Header";
        lt_Item: Record Item;
        lt_Evento: Record Evento;
        lt_lincom: Record "Componentes Evento";
        LineNo: Integer;
        AsmLine: Record "Assembly Line";
        AssemblyPost: Codeunit "Assembly-Post";
    begin
        if Rec.Producto <> '' then begin
            lt_Item.GET(Rec.Producto);
            lt_Item.CALCFIELDS("Assembly BOM");
            IF lt_Item."Assembly BOM" THEN BEGIN
                lt_Evento.GET(Rec."Codigo Evento");
                AsmHeader.INIT;
                AsmHeader.SetWarningsOff;
                AsmHeader.VALIDATE("Document Type", AsmHeader."Document Type"::Order);
                AsmHeader.VALIDATE("No.", '');
                AsmHeader.INSERT(TRUE);
                AsmHeader.VALIDATE("Item No.", Rec.Producto);
                AsmHeader.VALIDATE(Quantity, Rec.Cantidad);
                AsmHeader.VALIDATE("Quantity to Assemble", Rec.Cantidad);
                AsmHeader.VALIDATE("Posting Date", lt_Evento."Fecha Evento");
                AsmHeader.NoEvento := Rec."Codigo Evento";
                AsmHeader.MODIFY(TRUE);
                AsmLine.RESET;
                AsmLine.SETRANGE("Document Type", AsmHeader."Document Type");
                AsmLine.SETRANGE("Document No.", AsmHeader."No.");
                AsmLine.DELETEALL;
                lt_lincom.RESET;
                lt_lincom.SETRANGE(lt_lincom."Codigo Evento", Rec."Codigo Evento");
                lt_lincom.SETRANGE(lt_lincom."Linea Evento", Rec.Linea);
                IF lt_lincom.FINDSET THEN
                    REPEAT
                        LineNo := LineNo + 10000;
                        AsmLine.INIT;
                        AsmLine."Document Type" := AsmHeader."Document Type";
                        AsmLine.VALIDATE("Document No.", AsmHeader."No.");
                        AsmLine.VALIDATE(Type, lt_lincom.Type);
                        AsmLine.VALIDATE("No.", lt_lincom."No.");
                        AsmLine."Line No." := LineNo;
                        AsmLine.INSERT(TRUE);
                        IF AsmLine.Type = AsmLine.Type::Item THEN AsmLine.VALIDATE("Location Code", '001');
                        AsmLine.VALIDATE("Quantity per", lt_lincom."Quantity per");
                        AsmLine.MODIFY;
                    UNTIL lt_lincom.NEXT = 0;
                //AssemblyPost.RUN(AsmHeader)
            END;
        end;
    end;

    procedure gfu_CreaRegPedEnsambladoKR()
    var
        AsmHeader: Record "Assembly Header";
        lt_Item: Record Item;
        lt_Evento: Record Evento;
        lt_lincom: Record "Componentes Evento";
        LineNo: Integer;
        AsmLine: Record "Assembly Line";
        AssemblyPost: Codeunit "Assembly-Post";
    begin
        if Rec.Producto <> '' then begin
            lt_Item.GET(Rec.Producto);
            lt_Item.CALCFIELDS("Assembly BOM");
            IF lt_Item."Assembly BOM" THEN BEGIN
                lt_Evento.GET(Rec."Codigo Evento");
                AsmHeader.INIT;
                AsmHeader.SetWarningsOff;
                AsmHeader.VALIDATE("Document Type", AsmHeader."Document Type"::Order);
                AsmHeader.VALIDATE("No.", '');
                AsmHeader.INSERT(TRUE);
                AsmHeader.VALIDATE("Item No.", Rec.Producto);
                AsmHeader.VALIDATE(Quantity, Rec.Cantidad);
                AsmHeader.VALIDATE("Quantity to Assemble", Rec.Cantidad);
                AsmHeader.VALIDATE("Posting Date", lt_Evento."Fecha Evento");
                AsmHeader.NoEvento := Rec."Codigo Evento";
                //++ KR 280521
                AsmHeader.Description := Rec.Descripcion;
                //--
                AsmHeader.MODIFY(TRUE);
                UpdateAssemblyLines(AsmHeader, AsmHeader, AsmHeader.FIELDNO(Quantity), TRUE, AsmHeader.FIELDNO(Quantity), AsmHeader.FIELDNO(Quantity));
            END;
        end;
    end;

    procedure UpdateAssemblyLines(var AsmHeader: Record "Assembly Header"; OldAsmHeader: Record "Assembly Header"; FieldNum: Integer; ReplaceLinesFromBOM: Boolean; CurrFieldNo: Integer; CurrentFieldNum: Integer)
    var
        AssemblyLine: Record "Assembly Line";
        TempAssemblyHeader: Record "Assembly Header" temporary;
        TempAssemblyLine: Record "Assembly Line" temporary;
        BomComponent: Record "Componentes Evento";
        TempCurrAsmLine: Record "Assembly Line" temporary;
        ItemCheckAvail: Codeunit "Item-Check Avail.";
        NoOfLinesFound: Integer;
        UpdateDueDate: Boolean;
        UpdateLocation: Boolean;
        UpdateQuantity: Boolean;
        UpdateUOM: Boolean;
        UpdateQtyToConsume: Boolean;
        UpdateDimension: Boolean;
        DueDateBeforeWorkDate: Boolean;
        NewLineDueDate: Date;
    begin
        IF (FieldNum <> CurrentFieldNum) OR // Update has been called from OnValidate of another field than was originally intended.
 ((NOT (FieldNum IN [AsmHeader.FIELDNO("Item No."), AsmHeader.FIELDNO("Variant Code"), AsmHeader.FIELDNO("Location Code"), AsmHeader.FIELDNO("Starting Date"), AsmHeader.FIELDNO(Quantity), AsmHeader.FIELDNO("Unit of Measure Code"), AsmHeader.FIELDNO("Quantity to Assemble"), AsmHeader.FIELDNO("Dimension Set ID")])) AND (NOT ReplaceLinesFromBOM)) THEN
            EXIT;
        WarningModeOff := TRUE;
        NoOfLinesFound := CopyAssemblyData(AsmHeader, TempAssemblyHeader, TempAssemblyLine);
        IF ReplaceLinesFromBOM THEN BEGIN
            TempAssemblyLine.DELETEALL;
            IF NOT ((AsmHeader."Quantity (Base)" = 0) OR (AsmHeader."Item No." = '')) THEN BEGIN // condition to replace asm lines
                SetLinkToBOM(AsmHeader, BomComponent);
                IF BomComponent.FINDSET THEN
                    REPEAT
                        InsertAsmLine(AsmHeader, TempAssemblyLine, TRUE);
                        AddBOMLine2(AsmHeader, TempAssemblyLine, TRUE, BomComponent, FALSE);
                    UNTIL BomComponent.NEXT <= 0;
            END;
        END
        ELSE IF NoOfLinesFound = 0 THEN EXIT; // MODIFY condition but no lines to modify
        // make pre-checks OR ask user to confirm
        IF PreCheckAndConfirmUpdate(AsmHeader, OldAsmHeader, FieldNum, ReplaceLinesFromBOM, TempAssemblyLine, UpdateDueDate, UpdateLocation, UpdateQuantity, UpdateUOM, UpdateQtyToConsume, UpdateDimension) THEN EXIT;
        IF NOT ReplaceLinesFromBOM THEN
            IF TempAssemblyLine.FIND('-') THEN
                REPEAT
                    TempCurrAsmLine := TempAssemblyLine;
                    TempCurrAsmLine.INSERT;
                    TempAssemblyLine.SetSkipVerificationsThatChangeDatabase(TRUE);
                    UpdateExistingLine(AsmHeader, OldAsmHeader, CurrFieldNo, TempAssemblyLine, UpdateDueDate, UpdateLocation, UpdateQuantity, UpdateUOM, UpdateQtyToConsume, UpdateDimension);
                UNTIL TempAssemblyLine.NEXT = 0;
        //++ KR
        /*
        IF NOT (FieldNum IN [AsmHeader.FIELDNO("Quantity to Assemble"),AsmHeader.FIELDNO("Dimension Set ID")]) THEN
          IF ShowAvailability(FALSE,TempAssemblyHeader,TempAssemblyLine) THEN
            ItemCheckAvail.RaiseUpdateInterruptedError;
        */
        DoVerificationsSkippedEarlier(ReplaceLinesFromBOM, TempAssemblyLine, TempCurrAsmLine, UpdateDimension, AsmHeader."Dimension Set ID", OldAsmHeader."Dimension Set ID");
        AssemblyLine.RESET;
        IF ReplaceLinesFromBOM THEN BEGIN
            DeleteLines(AsmHeader);
            TempAssemblyLine.RESET;
        END;
        IF TempAssemblyLine.FIND('-') THEN
            REPEAT
                IF NOT ReplaceLinesFromBOM THEN AssemblyLine.GET(TempAssemblyLine."Document Type", TempAssemblyLine."Document No.", TempAssemblyLine."Line No.");
                AssemblyLine := TempAssemblyLine;
                IF ReplaceLinesFromBOM THEN
                    AssemblyLine.INSERT(TRUE)
                ELSE
                    AssemblyLine.MODIFY(TRUE);
                AsmHeader.AutoReserveAsmLine(AssemblyLine);
                IF AssemblyLine."Due Date" < WORKDATE THEN BEGIN
                    DueDateBeforeWorkDate := TRUE;
                    NewLineDueDate := AssemblyLine."Due Date";
                END;
            UNTIL TempAssemblyLine.NEXT = 0;
        IF ReplaceLinesFromBOM OR UpdateDueDate THEN IF DueDateBeforeWorkDate THEN ShowDueDateBeforeWorkDateMsg(NewLineDueDate);
        //-- #9627
        CLEAR(FuncionesVarias);
        FuncionesVarias.CreateAssamblyOrders(AsmHeader);
        //++ #9627
    end;

    procedure CopyAssemblyData(FromAssemblyHeader: Record "Assembly Header"; var ToAssemblyHeader: Record "Assembly Header"; var ToAssemblyLine: Record "Assembly Line") NoOfLinesInserted: Integer
    var
        AssemblyLine: Record "Assembly Line";
    begin
        ToAssemblyHeader := FromAssemblyHeader;
        ToAssemblyHeader.INSERT;
        SetLinkToLines(FromAssemblyHeader, AssemblyLine);
        AssemblyLine.SETFILTER(Type, '%1|%2', AssemblyLine.Type::Item, AssemblyLine.Type::Resource);
        ToAssemblyLine.RESET;
        ToAssemblyLine.DELETEALL;
        IF AssemblyLine.FIND('-') THEN
            REPEAT
                ToAssemblyLine := AssemblyLine;
                ToAssemblyLine.INSERT;
                NoOfLinesInserted += 1;
            UNTIL AssemblyLine.NEXT = 0;
    end;

    local procedure SetLinkToBOM(AsmHeader: Record "Assembly Header"; var BOMComponent: Record "Componentes Evento")
    begin
        //++ KR
        BOMComponent.SETRANGE("Codigo Evento", Rec."Codigo Evento");
        BOMComponent.SETRANGE("Linea Evento", Rec.Linea);
        //--
        BOMComponent.SETRANGE("Parent Item No.", AsmHeader."Item No.");
    end;

    local procedure PreCheckAndConfirmUpdate(AsmHeader: Record "Assembly Header"; OldAsmHeader: Record "Assembly Header"; FieldNum: Integer; var ReplaceLinesFromBOM: Boolean; var TempAssemblyLine: Record "Assembly Line" temporary; var UpdateDueDate: Boolean; var UpdateLocation: Boolean; var UpdateQuantity: Boolean; var UpdateUOM: Boolean; var UpdateQtyToConsume: Boolean; var UpdateDimension: Boolean): Boolean
    begin
        UpdateDueDate := FALSE;
        UpdateLocation := FALSE;
        UpdateQuantity := FALSE;
        UpdateUOM := FALSE;
        UpdateQtyToConsume := FALSE;
        UpdateDimension := FALSE;
        CASE FieldNum OF
            AsmHeader.FIELDNO(AsmHeader."Item No."):
                BEGIN
                    IF AsmHeader."Item No." <> OldAsmHeader."Item No." THEN IF LinesExist(AsmHeader) THEN IF GUIALLOWED THEN IF NOT CONFIRM(STRSUBSTNO(Text003, AsmHeader.FIELDCAPTION(AsmHeader."Item No."), OldAsmHeader."Item No.", AsmHeader."Item No."), TRUE) THEN ERROR('');
                END;
            AsmHeader.FIELDNO(AsmHeader."Variant Code"):
                UpdateDueDate := TRUE;
            AsmHeader.FIELDNO(AsmHeader."Location Code"):
                BEGIN
                    UpdateDueDate := TRUE;
                    IF AsmHeader."Location Code" <> OldAsmHeader."Location Code" THEN BEGIN
                        TempAssemblyLine.SETRANGE(Type, TempAssemblyLine.Type::Item);
                        TempAssemblyLine.SETFILTER("Location Code", '<>%1', AsmHeader."Location Code");
                        IF NOT TempAssemblyLine.ISEMPTY THEN //-- #9627
                            IF SkipConfirmUpdate THEN
                                UpdateLocation := TRUE
                            ELSE BEGIN
                                /************************ TEXTO ORIGINAL ************************/
                                IF GUIALLOWED THEN IF CONFIRM(STRSUBSTNO(Text001, TempAssemblyLine.FIELDCAPTION("Location Code")), FALSE) THEN UpdateLocation := TRUE;
                                /********************** FIN TEXTO ORIGINAL **********************/
                            END;
                        //++ #9627
                        TempAssemblyLine.SETRANGE("Location Code");
                        TempAssemblyLine.SETRANGE(Type);
                    END;
                END;
            AsmHeader.FIELDNO(AsmHeader."Starting Date"):
                UpdateDueDate := TRUE;
            AsmHeader.FIELDNO(AsmHeader.Quantity):
                IF AsmHeader.Quantity <> OldAsmHeader.Quantity THEN BEGIN
                    UpdateQuantity := TRUE;
                    UpdateQtyToConsume := TRUE;
                END;
            AsmHeader.FIELDNO(AsmHeader."Unit of Measure Code"):
                IF AsmHeader."Unit of Measure Code" <> OldAsmHeader."Unit of Measure Code" THEN
                    UpdateUOM := TRUE;
            AsmHeader.FIELDNO(AsmHeader."Quantity to Assemble"):
                UpdateQtyToConsume := TRUE;
            AsmHeader.FIELDNO(AsmHeader."Dimension Set ID"):
                IF AsmHeader."Dimension Set ID" <> OldAsmHeader."Dimension Set ID" THEN BEGIN
                    IF LinesExist(AsmHeader) THEN IF GUIALLOWED AND CONFIRM(STRSUBSTNO(Text002)) THEN UpdateDimension := TRUE;
                END;
            ELSE IF CalledFromRefreshBOM(ReplaceLinesFromBOM, FieldNum) THEN IF LinesExist(AsmHeader) THEN IF GUIALLOWED THEN IF NOT CONFIRM(Text004, FALSE) THEN ReplaceLinesFromBOM := FALSE;
        END;
        IF NOT (UpdateDueDate OR UpdateLocation OR UpdateQuantity OR UpdateUOM OR UpdateQtyToConsume OR UpdateDimension) AND // nothing to update
        NOT ReplaceLinesFromBOM THEN
            EXIT(TRUE);
    end;

    local procedure UpdateExistingLine(var AsmHeader: Record "Assembly Header"; OldAsmHeader: Record "Assembly Header"; CurrFieldNo: Integer; var AssemblyLine: Record "Assembly Line"; UpdateDueDate: Boolean; UpdateLocation: Boolean; UpdateQuantity: Boolean; UpdateUOM: Boolean; UpdateQtyToConsume: Boolean; UpdateDimension: Boolean)
    var
        QtyRatio: Decimal;
        QtyToConsume: Decimal;
    begin
        IF AsmHeader.IsStatusCheckSuspended THEN AssemblyLine.SuspendStatusCheck(TRUE);
        IF UpdateLocation THEN BEGIN
            IF AssemblyLine.Type = AssemblyLine.Type::Item THEN AssemblyLine.VALIDATE("Location Code", AsmHeader."Location Code");
        END;
        IF UpdateDueDate THEN BEGIN
            AssemblyLine.SetTestReservationDateConflict(CurrFieldNo <> 0);
            AssemblyLine.ValidateLeadTimeOffset(AsmHeader, AssemblyLine."Lead-Time Offset", FALSE);
        END;
        IF UpdateQuantity THEN BEGIN
            QtyRatio := AsmHeader.Quantity / OldAsmHeader.Quantity;
            // Inicio ADV001
            AssemblyLine.gfu_SetCantidadCabecera(AsmHeader.Quantity, AsmHeader."Quantity (Base)", AsmHeader."Remaining Quantity", AsmHeader."Remaining Quantity (Base)", AsmHeader."Quantity to Assemble", AsmHeader."Quantity to Assemble (Base)", TRUE);
            // Fin ADV001
            IF AssemblyLine.FixedUsage THEN
                AssemblyLine.VALIDATE(Quantity)
            ELSE BEGIN
                // FIX: Líneas manuales (Quantity per = 0) deben actualizarse proporcionalmente
                // Líneas del BOM (Quantity per > 0) usan la fórmula estándar
                IF AssemblyLine."Quantity per" = 0 THEN
                    // Línea manual: actualizar proporcionalmente
                    AssemblyLine.VALIDATE(Quantity, AssemblyLine.Quantity * QtyRatio)
                ELSE
                    // Línea del BOM: usar Quantity per × Header Quantity
                    AssemblyLine.VALIDATE(Quantity, AssemblyLine."Quantity per" * AsmHeader.Quantity);
            END;
            AssemblyLine.InitQtyToConsume;
        END;
        IF UpdateUOM THEN BEGIN
            QtyRatio := AsmHeader."Qty. per Unit of Measure" / OldAsmHeader."Qty. per Unit of Measure";
            IF AssemblyLine.FixedUsage THEN
                AssemblyLine.VALIDATE("Quantity per")
            ELSE
                AssemblyLine.VALIDATE("Quantity per", AssemblyLine."Quantity per" * QtyRatio);
            AssemblyLine.InitQtyToConsume;
        END;
        IF UpdateQtyToConsume THEN
            IF NOT AssemblyLine.FixedUsage THEN BEGIN
                AssemblyLine.InitQtyToConsume;
                QtyToConsume := AssemblyLine.Quantity * AsmHeader."Quantity to Assemble" / AsmHeader.Quantity;
                AsmHeader.RoundQty(QtyToConsume);
                AssemblyLine.VALIDATE("Quantity to Consume", QtyToConsume);
            END;
        IF UpdateDimension THEN AssemblyLine.UpdateDim(AsmHeader."Dimension Set ID", OldAsmHeader."Dimension Set ID");
        AssemblyLine.MODIFY(TRUE);
        // Inicio ADV001
        AssemblyLine.gfu_SetCantidadCabecera(AsmHeader.Quantity, AsmHeader."Quantity (Base)", AsmHeader."Remaining Quantity", AsmHeader."Remaining Quantity (Base)", AsmHeader."Quantity to Assemble", AsmHeader."Quantity to Assemble (Base)", FALSE);
        // Fin ADV001
    end;

    procedure ShowAvailability(ShowPageEvenIfEnoughComponentsAvailable: Boolean; var TmpAssemblyHeader: Record "Assembly Header"; var TempAssemblyLine: Record "Assembly Line" temporary) Rollback: Boolean
    var
        Item: Record Item;
        TempAssemblyLine2: Record "Assembly Line" temporary;
        AssemblySetup: Record "Assembly Setup";
        ItemCheckAvail: Codeunit "Item-Check Avail.";
        AssemblyAvailability: Page "Assembly Availability";
        Inventory: Decimal;
        GrossRequirement: Decimal;
        ReservedRequirement: Decimal;
        ScheduledReceipts: Decimal;
        ReservedReceipts: Decimal;
        EarliestAvailableDateX: Date;
        QtyAvailToMake: Decimal;
        QtyAvailTooLow: Boolean;
    begin
        AssemblySetup.GET;
        IF NOT GUIALLOWED OR TempAssemblyLine.ISEMPTY OR (NOT AssemblySetup."Stockout Warning" AND NOT ShowPageEvenIfEnoughComponentsAvailable) OR NOT GetWarningMode THEN EXIT(FALSE);
        TmpAssemblyHeader.TESTFIELD("Item No.");
        Item.GET(TmpAssemblyHeader."Item No.");
        ItemCheckAvail.AsmOrderCalculate(TmpAssemblyHeader, Inventory, GrossRequirement, ReservedRequirement, ScheduledReceipts, ReservedReceipts);
        TempAssemblyLine2.COPY(TempAssemblyLine, TRUE);
        AvailToPromise(TmpAssemblyHeader, TempAssemblyLine2, QtyAvailToMake, EarliestAvailableDateX);
        QtyAvailTooLow := QtyAvailToMake < TmpAssemblyHeader."Remaining Quantity";
        /*   IF ShowPageEvenIfEnoughComponentsAvailable OR QtyAvailTooLow THEN BEGIN
                  AssemblyAvailability.SetData(TmpAssemblyHeader, TempAssemblyLine);
                  AssemblyAvailability.SetHeaderInventoryData(
                    Inventory, GrossRequirement, ReservedRequirement, ScheduledReceipts, ReservedReceipts,
                    EarliestAvailableDateX, QtyAvailToMake, QtyAvailTooLow);
                  Rollback := NOT (AssemblyAvailability.RUNMODAL = ACTION::Yes);
              END; */
    end;

    local procedure DoVerificationsSkippedEarlier(ReplaceLinesFromBOM: Boolean; var TempNewAsmLine: Record "Assembly Line" temporary; var TempOldAsmLine: Record "Assembly Line" temporary; UpdateDimension: Boolean; NewHeaderSetID: Integer; OldHeaderSetID: Integer)
    begin
        IF TempNewAsmLine.FIND('-') THEN
            REPEAT
                TempNewAsmLine.SetSkipVerificationsThatChangeDatabase(FALSE);
                // FIX: Cuando ReplaceLinesFromBOM = TRUE, saltamos las verificaciones de reserva
                // porque las líneas antiguas serán borradas completamente
                IF NOT ReplaceLinesFromBOM THEN BEGIN
                    TempOldAsmLine.GET(TempNewAsmLine."Document Type", TempNewAsmLine."Document No.", TempNewAsmLine."Line No.");
                    TempNewAsmLine.VerifyReservationQuantity(TempNewAsmLine, TempOldAsmLine);
                    TempNewAsmLine.VerifyReservationChange(TempNewAsmLine, TempOldAsmLine);
                END;
                TempNewAsmLine.VerifyReservationDateConflict(TempNewAsmLine);
                /*    IF ReplaceLinesFromBOM THEN
                       CASE TempNewAsmLine.Type OF
                           TempNewAsmLine.Type::Item:
                               TempNewAsmLine.CreateDim(DATABASE::Item, TempNewAsmLine."No.", NewHeaderSetID);
                           TempNewAsmLine.Type::Resource:
                               TempNewAsmLine.CreateDim(DATABASE::Resource, TempNewAsmLine."No.", NewHeaderSetID);
                       END
                   ELSE BEGIN
                       IF UpdateDimension THEN
                           TempNewAsmLine.UpdateDim(NewHeaderSetID, OldHeaderSetID);
                   END;
    */
                TempNewAsmLine.MODIFY;
            UNTIL TempNewAsmLine.NEXT = 0;
    end;

    procedure DeleteLines(AsmHeader: Record "Assembly Header")
    var
        AssemblyLine: Record "Assembly Line";
        AssemblyLineReserve: Codeunit "Assembly Line-Reserve";
    begin
        // Borra las líneas y sus Reservation Entries
        SetLinkToLines(AsmHeader, AssemblyLine);
        IF AssemblyLine.FIND('-') THEN BEGIN
            REPEAT
                // Borrar tracking entries de esta línea
                AssemblyLineReserve.DeleteLine(AssemblyLine);
                
                AssemblyLine.SuspendStatusCheck(TRUE);
                AssemblyLine.DELETE(TRUE);
            UNTIL AssemblyLine.NEXT = 0;
        END;
    end;

    procedure c_Calc()
    begin
    end;

    procedure ShowDueDateBeforeWorkDateMsg(ActualLineDueDate: Date)
    begin
        IF GUIALLOWED THEN IF GetWarningMode THEN MESSAGE(Text005, ActualLineDueDate, WORKDATE);
    end;

    local procedure SetLinkToLines(AsmHeader: Record "Assembly Header"; var AssemblyLine: Record "Assembly Line")
    begin
        AssemblyLine.SETRANGE("Document Type", AsmHeader."Document Type");
        AssemblyLine.SETRANGE("Document No.", AsmHeader."No.");
    end;

    local procedure SetLinkToItemLines(AsmHeader: Record "Assembly Header"; var AssemblyLine: Record "Assembly Line")
    begin
        SetLinkToLines(AsmHeader, AssemblyLine);
        AssemblyLine.SETRANGE(Type, AssemblyLine.Type::Item);
    end;

    local procedure LinesExist(AsmHeader: Record "Assembly Header"): Boolean
    var
        AssemblyLine: Record "Assembly Line";
    begin
        SetLinkToLines(AsmHeader, AssemblyLine);
        EXIT(NOT AssemblyLine.ISEMPTY);
    end;

    local procedure CalledFromRefreshBOM(ReplaceLinesFromBOM: Boolean; FieldNum: Integer): Boolean
    begin
        EXIT(ReplaceLinesFromBOM AND (FieldNum = 0));
    end;

    local procedure GetWarningMode(): Boolean
    begin
        EXIT(NOT WarningModeOff);
    end;

    local procedure AvailToPromise(AsmHeader: Record "Assembly Header"; var AssemblyLine: Record "Assembly Line"; var OrderAbleToAssemble: Decimal; var EarliestDueDate: Date)
    var
        LineAvailabilityDate: Date;
        LineStartingDate: Date;
        EarliestStartingDate: Date;
        LineAbleToAssemble: Decimal;
    begin
        SetLinkToItemLines(AsmHeader, AssemblyLine);
        AssemblyLine.SETFILTER("No.", '<>%1', '');
        AssemblyLine.SETFILTER("Quantity per", '<>%1', 0);
        OrderAbleToAssemble := AsmHeader."Remaining Quantity";
        IF AssemblyLine.FINDSET THEN
            REPEAT
                LineAbleToAssemble := CalcAvailToAssemble(AssemblyLine, AsmHeader, LineAvailabilityDate);
                IF LineAbleToAssemble < OrderAbleToAssemble THEN OrderAbleToAssemble := LineAbleToAssemble;
                IF LineAvailabilityDate > 0D THEN BEGIN
                    LineStartingDate := CALCDATE(AssemblyLine."Lead-Time Offset", LineAvailabilityDate);
                    IF LineStartingDate > EarliestStartingDate THEN EarliestStartingDate := LineStartingDate; // latest of all line starting dates
                END;
            UNTIL AssemblyLine.NEXT = 0;
        EarliestDueDate := CalcEarliestDueDate(AsmHeader, EarliestStartingDate);
    end;

    local procedure CalcAvailToAssemble(AssemblyLine: Record "Assembly Line"; AsmHeader: Record "Assembly Header"; var LineAvailabilityDate: Date) LineAbleToAssemble: Decimal
    var
        Item: Record Item;
        GrossRequirement: Decimal;
        ScheduledRcpt: Decimal;
        ExpectedInventory: Decimal;
        LineInventory: Decimal;
    begin
        AssemblyLine.CalcAvailToAssemble(AsmHeader, Item, GrossRequirement, ScheduledRcpt, ExpectedInventory, LineInventory, LineAvailabilityDate, LineAbleToAssemble);
    end;

    local procedure CalcEarliestDueDate(AsmHeader: Record "Assembly Header"; EarliestStartingDate: Date) EarliestDueDate: Date
    var
        ReqLine: Record 246;
        LeadTimeMgt: Codeunit 5404;
        EarliestEndingDate: Date;
    begin
        /* WITH AsmHeader DO BEGIN
                EarliestDueDate := 0D;
                IF EarliestStartingDate > 0D THEN BEGIN
                    EarliestEndingDate := // earliest starting date + lead time calculation
                      LeadTimeMgt.PlannedEndingDate2("Item No.", "Location Code", "Variant Code",
                        '', LeadTimeMgt.ManufacturingLeadTime("Item No.", "Location Code", "Variant Code"),
                        ReqLine."Ref. Order Type"::Assembly, EarliestStartingDate);
                    EarliestDueDate := // earliest ending date + (default) safety lead time
                      LeadTimeMgt.PlannedDueDate("Item No.", "Location Code", "Variant Code",
                        EarliestEndingDate, '', ReqLine."Ref. Order Type"::Assembly);
                END;
            END; */
    end;

    local procedure InsertAsmLine(AsmHeader: Record "Assembly Header"; var AssemblyLine: Record "Assembly Line"; AsmLineRecordIsTemporary: Boolean)
    begin
        AssemblyLine.INIT;
        AssemblyLine."Document Type" := AsmHeader."Document Type";
        AssemblyLine."Document No." := AsmHeader."No.";
        AssemblyLine."Line No." := GetNextAsmLineNo(AssemblyLine, AsmLineRecordIsTemporary);
        AssemblyLine.INSERT(TRUE);
    end;

    local procedure AddBOMLine2(AsmHeader: Record 900; var AssemblyLine: Record 901; AsmLineRecordIsTemporary: Boolean; BomComponent: Record 50014; ShowDueDateBeforeWorkDateMessage: Boolean)
    var
        DueDateBeforeWorkDateMsgShown: Boolean;
        SkipVerificationsThatChangeDatabase: Boolean;
    begin
        SkipVerificationsThatChangeDatabase := AsmLineRecordIsTemporary;
        AssemblyLine.SetSkipVerificationsThatChangeDatabase(SkipVerificationsThatChangeDatabase);
        AssemblyLine.VALIDATE(Type, BomComponent.Type);
        // Inicio ADV001
        AssemblyLine.gfu_SetCantidadCabecera(AsmHeader.Quantity, AsmHeader."Quantity (Base)", AsmHeader."Remaining Quantity", AsmHeader."Remaining Quantity (Base)", AsmHeader."Quantity to Assemble", AsmHeader."Quantity to Assemble (Base)", TRUE);
        // Fin ADV001
        AssemblyLine.VALIDATE("No.", BomComponent."No.");
        //++ KR 28/05/21
        AssemblyLine.VALIDATE(AssemblyLine.Description, BomComponent.Description);
        //--
        IF AssemblyLine.Type = AssemblyLine.Type::Resource THEN
            CASE BomComponent."Resource Usage Type" OF
                BomComponent."Resource Usage Type"::Direct:
                    AssemblyLine.VALIDATE("Resource Usage Type", AssemblyLine."Resource Usage Type"::Direct);
                BomComponent."Resource Usage Type"::Fixed:
                    AssemblyLine.VALIDATE("Resource Usage Type", AssemblyLine."Resource Usage Type"::Fixed);
            END;
        AssemblyLine.VALIDATE("Unit of Measure Code", BomComponent."Unit of Measure Code");
        IF AssemblyLine.Type <> AssemblyLine.Type::" " THEN AssemblyLine.VALIDATE("Quantity per", AssemblyLine.CalcQuantityFromBOM(BomComponent.Type, BomComponent."Quantity per", 1, AsmHeader."Qty. per Unit of Measure", AssemblyLine."Resource Usage Type"));
        AssemblyLine.VALIDATE(Quantity, AssemblyLine.CalcQuantityFromBOM(BomComponent.Type, BomComponent."Quantity per", AsmHeader.Quantity, AsmHeader."Qty. per Unit of Measure", AssemblyLine."Resource Usage Type"));
        AssemblyLine.VALIDATE("Quantity to Consume", AssemblyLine.CalcQuantityFromBOM(BomComponent.Type, BomComponent."Quantity per", AsmHeader."Quantity to Assemble", AsmHeader."Qty. per Unit of Measure", AssemblyLine."Resource Usage Type"));
        AssemblyLine.ValidateDueDate(AsmHeader, AsmHeader."Starting Date", ShowDueDateBeforeWorkDateMessage);
        DueDateBeforeWorkDateMsgShown := (AssemblyLine."Due Date" < WORKDATE) AND ShowDueDateBeforeWorkDateMessage;
        AssemblyLine.ValidateLeadTimeOffset(AsmHeader, BomComponent."Lead-Time Offset", NOT DueDateBeforeWorkDateMsgShown AND ShowDueDateBeforeWorkDateMessage);
        AssemblyLine.Description := BomComponent.Description;
        AssemblyLine."Description 2" := AsmHeader."Description 2";
        IF AssemblyLine.Type = AssemblyLine.Type::Item THEN AssemblyLine.VALIDATE("Variant Code", BomComponent."Variant Code");
        AssemblyLine.Position := BomComponent.Position;
        AssemblyLine."Position 2" := BomComponent."Position 2";
        AssemblyLine."Position 3" := BomComponent."Position 3";
        IF AsmHeader."Location Code" <> '' THEN IF AssemblyLine.Type = AssemblyLine.Type::Item THEN AssemblyLine.VALIDATE("Location Code", AsmHeader."Location Code");
        //++ KR 28/05/21
        AssemblyLine.VALIDATE(AssemblyLine.Description, BomComponent.Description);
        //--
        AssemblyLine.MODIFY(TRUE);
        // Inicio ADV001
        AssemblyLine.gfu_SetCantidadCabecera(AsmHeader.Quantity, AsmHeader."Quantity (Base)", AsmHeader."Remaining Quantity", AsmHeader."Remaining Quantity (Base)", AsmHeader."Quantity to Assemble", AsmHeader."Quantity to Assemble (Base)", FALSE);
        // Fin ADV001
    end;

    procedure AddBOMLine(AsmHeader: Record "Assembly Header"; var AssemblyLine: Record "Assembly Line"; BomComponent: Record "Componentes Evento")
    begin
        InsertAsmLine(AsmHeader, AssemblyLine, FALSE);
        AddBOMLine2(AsmHeader, AssemblyLine, FALSE, BomComponent, FALSE);
    end;

    procedure GetNextAsmLineNo(var AsmLine: Record "Assembly Line"; AsmLineRecordIsTemporary: Boolean): Integer
    var
        TempAssemblyLine2: Record "Assembly Line" temporary;
        AssemblyLine2: Record "Assembly Line";
    begin
        IF AsmLineRecordIsTemporary THEN BEGIN
            TempAssemblyLine2.COPY(AsmLine, TRUE);
            TempAssemblyLine2.SETRANGE("Document Type", AsmLine."Document Type");
            TempAssemblyLine2.SETRANGE("Document No.", AsmLine."Document No.");
            IF TempAssemblyLine2.FINDLAST THEN EXIT(TempAssemblyLine2."Line No." + 10000);
        END
        ELSE BEGIN
            AssemblyLine2.SETRANGE("Document Type", AsmLine."Document Type");
            AssemblyLine2.SETRANGE("Document No.", AsmLine."Document No.");
            IF AssemblyLine2.FINDLAST THEN EXIT(AssemblyLine2."Line No." + 10000);
        END;
        EXIT(10000);
    end;

    local procedure CompruebaSiHayComponentes(): Boolean
    var
        lt_lincom: Record "Componentes Evento";
        lt_linprod: Record "Productos Evento";
    begin
        lt_lincom.RESET;
        lt_lincom.SETRANGE(lt_lincom."Codigo Evento", "Codigo Evento");
        lt_lincom.SETRANGE(lt_lincom."Linea Evento", Linea);
        lt_lincom.SETRANGE(lt_lincom."Parent Item No.", Rec."Codigo Producto");
        if lt_lincom.FindFirst() then
            EXIT(true)
        else
            exit(false);
    end;

    local procedure ModificarComponentes()
    var
        lt_lincom: Record "Componentes Evento";
        rItem: Record Item;
        lt_bom: Record 90;
    begin
        if Rec.Tipo = Rec.tipo::Pan then begin
            rItem.Reset;
            rItem.Get(Rec."Codigo Producto");
            rItem.CalcFields("Assembly BOM");
            if rItem."Assembly BOM" = false then begin
                lt_lincom.RESET;
                lt_lincom.SETRANGE(lt_lincom."Codigo Evento", "Codigo Evento");
                lt_lincom.SETRANGE(lt_lincom."Linea Evento", Linea);
                lt_lincom.SETRANGE(lt_lincom."Parent Item No.", Rec."Codigo Producto");
                IF lt_lincom.FINDFIRST THEN
                    REPEAT
                        IF Rec.Cantidad <> 0 THEN BEGIN
                            //lt_lincom.VALIDATE("Quantity per", lt_lincom."Cantidad por Lote"/Rec.Cantidad)
                            lt_lincom."Cantidad por Lote" := Rec.Cantidad;
                            lt_lincom."Quantity per" := lt_lincom."Cantidad por Lote" / Rec.Cantidad;
                            lt_lincom."Coste Calculado" := lt_lincom."Quantity per" * lt_lincom.CosteUnitario;
                            lt_lincom."Coste Lote" := lt_lincom."Cantidad por Lote" * lt_lincom.CosteUnitario;
                            lt_lincom.MODIFY;
                        END
                        ELSE
                            lt_lincom.VALIDATE(lt_lincom."Cantidad por Lote", 0);
                    UNTIL lt_lincom.NEXT = 0;
            end
            else begin
                lt_lincom.RESET;
                lt_lincom.SETRANGE(lt_lincom."Codigo Evento", "Codigo Evento");
                lt_lincom.SETRANGE(lt_lincom."Linea Evento", Linea);
                lt_lincom.SETRANGE(lt_lincom."Parent Item No.", Rec."Codigo Producto");
                IF lt_lincom.FINDFIRST THEN
                    REPEAT
                        IF Rec.Cantidad <> 0 THEN BEGIN
                            //lt_lincom.VALIDATE("Quantity per", lt_lincom."Cantidad por Lote"/Rec.Cantidad)
                            //SL >>> GAP00058 
                            lt_lincom."Cantidad por Lote" := GetCantLote(lt_lincom."Parent Item No.", lt_lincom."No.") * Rec.Cantidad / rItem."Lote Receta";
                            //lt_lincom."Cantidad por Lote" := Rec.Cantidad;
                            lt_lincom."Quantity per" := lt_lincom."Cantidad por Lote" / Rec.Cantidad;
                            lt_lincom."Coste Calculado" := lt_lincom."Quantity per" * lt_lincom.CosteUnitario;
                            lt_lincom."Coste Lote" := lt_lincom."Cantidad por Lote" * lt_lincom.CosteUnitario;
                            lt_lincom.MODIFY;
                        END
                        ELSE
                            lt_lincom.VALIDATE(lt_lincom."Cantidad por Lote", 0);
                    UNTIL lt_lincom.NEXT = 0;
            end;
        end
        else begin
            lt_lincom.RESET;
            lt_lincom.SETRANGE(lt_lincom."Codigo Evento", "Codigo Evento");
            lt_lincom.SETRANGE(lt_lincom."Linea Evento", Linea);
            lt_lincom.SETRANGE(lt_lincom."Parent Item No.", Rec."Codigo Producto");
            IF lt_lincom.FINDFIRST THEN
                REPEAT
                    IF Rec.Cantidad <> 0 THEN BEGIN
                        //lt_lincom.VALIDATE("Quantity per", lt_lincom."Cantidad por Lote"/Rec.Cantidad)
                        lt_lincom."Cantidad por Lote" := Rec.Cantidad;
                        lt_lincom."Quantity per" := lt_lincom."Cantidad por Lote" / Rec.Cantidad;
                        lt_lincom."Coste Calculado" := lt_lincom."Quantity per" * lt_lincom.CosteUnitario;
                        lt_lincom."Coste Lote" := lt_lincom."Cantidad por Lote" * lt_lincom.CosteUnitario;
                    END
                    ELSE
                        lt_lincom.VALIDATE(lt_lincom."Cantidad por Lote", 0);
                    lt_lincom.MODIFY;
                UNTIL lt_lincom.NEXT = 0;
        end;
    end;

    procedure GetCantLote(BOM: Code[20]; Item: Code[20]): Decimal
    var
        lt_bom: Record 90;
    begin
        lt_bom.reset;
        lt_bom.SETRANGE(lt_bom."Parent Item No.", BOM);
        lt_bom.SETRANGE(lt_bom."No.", Item);
        if lt_bom.FINDFIRST then
            exit(lt_bom."Cantidad por Lote")
        else
            exit(0);
    end;
}
