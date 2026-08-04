table 50002 "Lineas Evento"
{
    // -----------------------------------------------------
    //   ADVANCE
    //   Fecha: 17-08-2018
    //   Técnico: JAB
    //   Presupuesto: I009029 - Gestión de escalados
    //   Etiqueta: ADV001
    // -----------------------------------------------------
    //   ADVANCE
    //   Fecha: 12-11-2018
    //   Técnico: JAB
    //   Presupuesto: I009029 - Gestión de escalados
    //   Modificación: Redondear al entero superior cuando se trate de un "Recurso" - "Máquina"
    //   Etiqueta: ADV002
    // -----------------------------------------------------
    // ADVANCE
    //   Fecha: 27/03/2019
    //   Técnico: CPL
    //   Presupuesto: I011530 - No deja cambiar un producto. tiene que eliminar la línea y crear otra.
    //   Si no se quedan líneas colgadas en Lineas componentes
    //   Modificación:
    //   Etiqueta: ADV003
    // -----------------------------------------------------
    // ADVANCE
    //   Fecha: 21/05/2019
    //   Técnico: CPL
    //   Presupuesto: I012162 - Error Bocados por bandeja, cuando no tiene bocados el componente
    //   Modificación:
    //   Etiqueta: ADV004
    // -----------------------------------------------------
    // ADVANCE
    //   Fecha: 27/11/2019
    //   Técnico: CPL
    //   Presupuesto: I013200 - que no pregunte si quiere actualizar el almacén pq no ha cambiado.
    //   Modificación:
    //   Etiqueta: ADV005
    // -----------------------------------------------------
    // KR 23/03/2022 - Se comenta el control introducido para introducir las lineas en blanco
    DrillDownPageID = "Lineas Eventos";
    LookupPageID = "Lineas Eventos";

    fields
    {
        field(1; "Codigo Evento"; Code[20])
        {
            trigger OnValidate()
            begin
                //CalcCosteDirecto;
            end;
        }
        field(2; Linea; Integer)
        {
            trigger OnValidate()
            begin
                //CalcCosteDirecto;
            end;
        }
        field(3; Tipo; Option)
        {
            OptionCaption = 'Adulto,Niño,Otros';
            OptionMembers = Adulto,"Niño",Otros;
        }
        field(4; "No."; Code[20])
        {
            TableRelation = Item;

            trigger OnValidate()
            var
                LT_ITEM: Record 27;
                lt_Evento: Record 50004;
                lt_VATPostingSetup: Record 325;
                lt_Customer: Record 18;
                lt_CustTemplate: Record "Customer Templ.";
            begin
                //ADV004 Inicio
                IF (Rec."No." <> xRec."No.") AND (xRec."No." <> '') THEN BEGIN
                    ERROR('No se puede modificar un producto.Tiene que eliminar la línea y crearla de nuevo');
                END;
                //ADV004 Fin
                lt_Evento.GET("Codigo Evento");
                LT_ITEM.RESET;
                IF LT_ITEM.GET(Rec."No.") THEN BEGIN
                    Descripcion := LT_ITEM.Description;
                    IF lt_Evento."Codigo Cliente" <> '' THEN BEGIN
                        lt_Customer.GET(lt_Evento."Codigo Cliente");
                        lt_VATPostingSetup.GET(lt_Customer."VAT Bus. Posting Group", LT_ITEM."VAT Prod. Posting Group");
                        "% IVA" := lt_VATPostingSetup."VAT %";
                    END
                    ELSE BEGIN
                        lt_Evento.TESTFIELD("Plantilla Cliente");
                        lt_CustTemplate.GET(lt_Evento."Plantilla Cliente");
                        lt_VATPostingSetup.GET(lt_CustTemplate."VAT Bus. Posting Group", LT_ITEM."VAT Prod. Posting Group");
                        "% IVA" := lt_VATPostingSetup."VAT %";
                    END;
                END
                ELSE BEGIN
                    Descripcion := '';
                    "% IVA" := 0;
                END;
                LT_ITEM.TESTFIELD("Lote Receta");
                "Tipo Margen" := "Tipo Margen"::Porcentaje;
                "Valor Margen" := lt_Evento."% Beneficio";
                IF Tipo = Tipo::Adulto THEN BEGIN
                    lt_Evento.TESTFIELD("Total Adultos");
                    Cantidad := lt_Evento."Total Adultos";
                    CantidadComensales := lt_Evento."Total Adultos";
                END
                ELSE IF Rec.Tipo = Rec.Tipo::Niño THEN BEGIN
                    lt_Evento.TESTFIELD("Total Ninos");
                    Cantidad := lt_Evento."Total Ninos";
                END
                ELSE IF Rec.Tipo = Rec.Tipo::Otros THEN BEGIN //Otros
                    IF (lt_Evento."Total Adultos" + lt_Evento."Total Ninos") = 0 THEN ERROR(Text20000);
                    LT_ITEM.TESTFIELD("Bocados por comensal");
                    Cantidad := lt_Evento."Total Adultos" + lt_Evento."Total Ninos";
                    Bocados := Cantidad * LT_ITEM."Bocados por comensal";
                END;
                IF Linea <> 0 THEN MODIFY;
                lfu_InsertaComponentes;
                lfu_CalculaImportes;
                //CalcCosteDirecto;
            end;
        }
        field(5; Descripcion; Text[50])
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
            var
                lt_lincom: Record "Componentes Evento";
                lt_Item: Record Item;
                lt_bom: Record "BOM Component";
                rSRS: Record "Sales & Receivables Setup";
            begin
                IF (Cantidad = 0) AND lfu_TieneComponentes THEN ERROR(Text10000);
                IF Tipo = Tipo::Otros THEN BEGIN
                    IF (Rec.Linea <> 0) AND (Rec.Cantidad <> xRec.Cantidad) AND (xRec.Cantidad <> 0) THEN BEGIN
                        lt_Item.GET("No.");
                        lt_Item.VALIDATE("Bocados por comensal");
                        VALIDATE(Bocados, Cantidad * lt_Item."Bocados por comensal");
                    END;
                END
                ELSE BEGIN
                    rSRS.GET();
                    IF (Rec.Linea <> 0) AND (Rec.Cantidad <> xRec.Cantidad) AND (xRec.Cantidad <> 0) THEN BEGIN
                        lt_lincom.RESET;
                        lt_lincom.SETRANGE(lt_lincom."Codigo Evento", "Codigo Evento");
                        lt_lincom.SETRANGE(lt_lincom."Linea Evento", Linea);
                        //ADV004 Inicio Añadimos la siguiente línea
                        lt_lincom.SETRANGE(lt_lincom."Parent Item No.", Rec."No.");
                        //ADV004 Fin
                        IF lt_lincom.FINDSET THEN BEGIN
                            REPEAT //++AGRALA
                                lt_Item.GET("No.");
                                IF lt_bom.GET(lt_lincom."Parent Item No.", lt_lincom."Line No.") THEN begin
                                    lt_lincom."Cantidad por Lote" := lt_bom."Cantidad por Lote" * Cantidad / lt_Item."Lote Receta";
                                    //lt_lincom.Validate("Cantidad por Lote");
                                end;
                                gfu_CalcularEscalado(lt_lincom);
                                //--AGRALA
                                // Inicio ADV001
                                lt_lincom.gfu_SetCantidadLineaEvento(Rec.Cantidad, TRUE);
                                // Fin ADV001
                                lt_lincom.MODIFY;
                                lt_lincom.Validate("Cantidad por Lote");
                                lt_lincom.Modify(false);
                            //--AGRALA
                            UNTIL lt_lincom.NEXT = 0;
                        END;
                    END;
                END;
                lfu_CalculaImportes;
                if rSRS."Calcular coste Cantidad" then CalcCosteDirecto;
            end;
        }
        field(7; "Coste Unitario"; Decimal)
        {
            Enabled = false;
        }
        field(8; "Precio Unitario"; Decimal)
        {
            Enabled = false;
        }
        field(9; Importe; Decimal)
        {
            Editable = false;
        }
        field(10; "% IVA"; Decimal)
        {
            Editable = false;
        }
        field(11; "Importe IVA Incl."; Decimal)
        {
            Editable = false;
        }
        field(12; Imprime; Boolean)
        {
            InitValue = true;
        }
        field(13; Comentarios; Text[80])
        {
        }
        field(14; "Coste Directo"; Decimal)
        {
            Editable = false;
        }
        field(15; "Tipo Margen"; Option)
        {
            OptionMembers = Porcentaje,Importe;
        }
        field(16; "Valor Margen"; Decimal)
        {
        }
        field(17; "Coste Indirecto Recursos"; Decimal)
        {
            Editable = false;
        }
        field(18; "Precio Venta Recursos"; Decimal)
        {
            Editable = false;
        }
        field(19; "Precio Propuesto"; Decimal)
        {
            Caption = 'Precio Propuesto Plato';
            Editable = false;
        }
        field(20; "Precio Real"; Decimal)
        {
            DecimalPlaces = 2 : 3;

            trigger OnValidate()
            var
                GLSetup: Record "General Ledger Setup";
            begin
                lfu_CalculaImportes;
            end;
        }
        field(21; "Precio IVA Incl."; Decimal)
        {
            Editable = false;
        }
        field(22; "Coste Total"; Decimal)
        {
            Editable = false;
        }
        field(23; "Coste Indirecto Pan"; Decimal)
        {
            Editable = false;
        }
        field(24; "Coste Total Unitario"; Decimal)
        {
            Editable = false;
        }
        field(25; Bocados; Integer)
        {
            trigger OnValidate()
            var
                lt_Item: Record Item;
                lt_lincom: Record "Componentes Evento";
                TotBocadosComp: Decimal;
                lt_ProdComp: Record Item;
                cantidadComp: Decimal;
            begin
                IF (Tipo = Tipo::Otros) AND (Cantidad = 0) AND lfu_TieneComponentes THEN ERROR(Text10000);
                IF (Tipo = Tipo::Otros) AND (Rec.Bocados <> 0) AND (Rec.Bocados <> xRec.Bocados) AND (xRec.Bocados <> 0) THEN BEGIN
                    lt_lincom.RESET;
                    lt_lincom.SETRANGE(lt_lincom."Codigo Evento", "Codigo Evento");
                    lt_lincom.SETRANGE(lt_lincom."Linea Evento", Linea);
                    //ADV004 Inicio Añadimos la siguiente línea
                    lt_lincom.SETRANGE(lt_lincom."Parent Item No.", Rec."No.");
                    //ADV004 Fin
                    IF lt_lincom.FINDSET THEN
                        REPEAT
                            lt_lincom.Bocados := lt_lincom.Bocados * (Rec.Bocados / xRec.Bocados);
                            lt_ProdComp.GET(lt_lincom."No.");
                            //ADV004 Comprobar si el componente tiene bocados
                            // Comentamos línea: lt_ProdComp.TESTFIELD("Bocados por bandeja");
                            //IF then
                            lt_ProdComp.TESTFIELD("Bocados por bandeja");
                            cantidadComp := lt_lincom.Bocados / lt_ProdComp."Bocados por bandeja";
                            lt_lincom.VALIDATE("Cantidad por Lote", ROUND(cantidadComp, 1, '>'));
                            lt_lincom.MODIFY;
                        UNTIL lt_lincom.NEXT = 0;
                END;
            end;
        }
        field(26; ImportePorPersona; Decimal)
        {
            Caption = 'Importe por persona';
            Editable = false;
        }
        field(27; ImprCapitulo; Code[20])
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
        field(28; DescripCapitulo; Text[150])
        {
            Caption = 'Descripción';
        }
        field(29; Orden; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Orden';
            Description = 'GAP0045';
        }
        field(30; CantidadComensales; integer)
        {
            Caption = 'Cantidad comensales';
            DataClassification = CustomerContent;
            Description = 'GAP0061';
        }
    }
    keys
    {
        key(Key1; "Codigo Evento", Linea)
        {
            Clustered = true;
        }
        key(Key2; "Codigo Evento", Tipo, Linea)
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnDelete()
    begin
        lfu_BorraComponentes(TRUE);
    end;

    trigger OnInsert()
    var
        lt_Capitulo: Record "AlxImpresionCapitulos";
    begin
        ImprCapitulo := 'MENU';
        if lt_Capitulo.GET(ImprCapitulo) then;
        DescripCapitulo := lt_Capitulo.Descripcion;
        lfu_InsertaComponentes;
    end;

    trigger OnModify()
    begin
        lfu_InsertaComponentes;
    end;

    trigger OnRename()
    begin
        ERROR('No puede renombrar líneas de evento. Elimine la línea y créela de nuevo');
    end;

    var
        Text10000: Label 'No puede asignar cantidad 0 a la linea ya que tiene componentes. ';
        Text20000: Label 'Debe especificar numero de comensales en el evento.';
        gb_FijarCantidadCabecera: Boolean;
        gd_CantidadCabecera: Decimal;
        gt_Escalados: Record Escalados;
        gt_lincom: Record "Componentes Evento";
        ERROR001: Label 'There is no scaling section for product %1 for quantity %2. Review the list of scales for that product';
        FuncionesVarias: Codeunit FuncionesVarias;
        //++ crear lineas ensamblados": ;
        Text001: Label 'Do you want to update the %1 on the lines?';
        Text002: Label 'Do you want to update the Dimensions on the lines?';
        Text003: Label 'Changing %1 will change all the lines. Do you want to change the %1 from %2 to %3?';
        Text004: Label 'This assembly order may have customized lines. Are you sure that you want to reset the lines according to the assembly BOM?';
        Text005: Label 'Due Date %1 is before work date %2 in one or more of the assembly lines.';
        Text006: Label 'Item %1 is not a BOM.';
        Text007: Label 'There is not enough space to explode the BOM.';
        SkipConfirmUpdate: Boolean;
        WarningModeOff: Boolean;

    local procedure lfu_BorraComponentes(b_runTrigger: Boolean)
    var
        lt_lincom: Record "Componentes Evento";
    begin
        lt_lincom.RESET;
        lt_lincom.SETRANGE(lt_lincom."Codigo Evento", "Codigo Evento");
        lt_lincom.SETRANGE(lt_lincom."Linea Evento", Linea);
        //++ KR Eventos 29/11/21
        lt_lincom.SETRANGE(lt_lincom."Parent Item No.", "No.");
        //--
        lt_lincom.DELETEALL(b_runTrigger);
    end;

    local procedure lfu_InsertaComponentes()
    var
        lt_bom: Record 90;
        lt_producto: Record 27;
        lt_lincom: Record 50014;
        numBocados: Integer;
        lt_ProdComp: Record 27;
        cantidadComp: Decimal;
    begin
        IF (Rec.Linea <> 0) AND (Rec."No." <> xRec."No.") THEN BEGIN
            IF "No." <> '' THEN BEGIN
                lt_producto.GET("No.");
                IF Rec.Tipo = Rec.Tipo::Otros THEN BEGIN
                    lt_producto.TESTFIELD("Bocados por comensal");
                    lt_bom.RESET;
                    lt_bom.SETRANGE(lt_bom."Parent Item No.", "No.");
                    IF lt_bom.FINDSET THEN BEGIN
                        lfu_BorraComponentes(FALSE);
                        REPEAT
                            lt_lincom.INIT;
                            lt_lincom.TRANSFERFIELDS(lt_bom);
                            lt_lincom."Codigo Evento" := "Codigo Evento";
                            lt_lincom."Linea Evento" := Rec.Linea;
                            lt_ProdComp.GET(lt_bom."No.");
                            //++ KR 02/11/21
                            //lt_ProdComp.TESTFIELD("Bocados por bandeja");
                            IF lt_ProdComp."Bocados por bandeja" = 0 THEN ERROR('Debe indicar el campo "Bocados por bandeja" del producto %1', lt_ProdComp."No.");
                            //--
                            lt_lincom.Bocados := Bocados * lt_bom."Cantidad por Lote";
                            cantidadComp := Bocados * lt_bom."Cantidad por Lote" / lt_ProdComp."Bocados por bandeja";
                            lt_lincom."Cantidad por Lote" := ROUND(cantidadComp, 1, '>');
                            IF (lt_lincom.Type = lt_lincom.Type::Resource) AND (lt_lincom."Resource Usage Type" = lt_lincom."Resource Usage Type"::Fixed) THEN
                                lt_lincom.VALIDATE("Quantity per", lt_lincom."Cantidad por Lote")
                            ELSE BEGIN
                                IF Rec.Cantidad <> 0 THEN // Inicio ADV001
                                // Línea eliminada lt_lincom.VALIDATE("Quantity per",lt_lincom."Cantidad por Lote"/Rec.Cantidad)
                                BEGIN
                                    gt_lincom := lt_lincom;
                                    gfu_CalcularEscalado(gt_lincom);
                                    lt_lincom := gt_lincom
                                END
                                // Fin ADV001
                                ELSE
                                    lt_lincom.VALIDATE("Quantity per", 0);
                            END;
                            lt_lincom."Coste Lote" := lt_lincom."Cantidad por Lote" * lt_lincom.CosteUnitario;
                            IF lt_lincom."Linea Evento" <> 0 THEN lt_lincom.INSERT;
                            //++ KR 15/11/21
                            // Si tiene componentes
                            InsertaComponentes(lt_lincom);
                        // Insertar componentes
                        //--
                        UNTIL lt_bom.NEXT = 0;
                    END;
                END
                ELSE BEGIN
                    lt_bom.RESET;
                    lt_bom.SETRANGE(lt_bom."Parent Item No.", "No.");
                    IF lt_bom.FINDSET THEN BEGIN
                        lfu_BorraComponentes(FALSE);
                        REPEAT
                            lt_lincom.INIT;
                            lt_lincom.TRANSFERFIELDS(lt_bom);
                            lt_lincom."Codigo Evento" := "Codigo Evento";
                            lt_lincom."Linea Evento" := Rec.Linea;
                            lt_lincom."Cantidad por Lote" := lt_lincom."Cantidad por Lote" * Cantidad / lt_producto."Lote Receta";
                            IF (lt_lincom.Type = lt_lincom.Type::Resource) AND (lt_lincom."Resource Usage Type" = lt_lincom."Resource Usage Type"::Fixed) THEN
                                lt_lincom.VALIDATE("Quantity per", lt_lincom."Cantidad por Lote")
                            ELSE BEGIN
                                IF Rec.Cantidad <> 0 THEN // Inicio ADV001
                                // Línea eliminada lt_lincom.VALIDATE("Quantity per",lt_lincom."Cantidad por Lote"/Rec.Cantidad)
                                BEGIN
                                    gt_lincom := lt_lincom;
                                    gfu_CalcularEscalado(gt_lincom);
                                    lt_lincom := gt_lincom
                                END
                                // Fin ADV001
                                ELSE
                                    lt_lincom.VALIDATE("Quantity per", 0);
                            END;
                            lt_lincom."Coste Lote" := lt_lincom."Cantidad por Lote" * lt_lincom.CosteUnitario;
                            IF lt_lincom."Linea Evento" <> 0 THEN lt_lincom.INSERT;
                            //++ KR 15/11/21
                            // Si tiene componentes
                            InsertaComponentes(lt_lincom);
                        // Insertar componentes
                        //--
                        UNTIL lt_bom.NEXT = 0;
                    END;
                END;
            END;
        END;
    end;

    local procedure lfu_InsertaComponentes2()
    var
        lt_bom: Record "BOM Component";
        lt_producto: Record Item;
        lt_lincom: Record "Componentes Evento";
        numBocados: Integer;
        lt_ProdComp: Record Item;
        cantidadComp: Decimal;
    begin
        IF (Rec.Linea <> 0) AND (Rec."No." <> xRec."No.") THEN BEGIN
            lfu_BorraComponentes(TRUE);
            IF "No." <> '' THEN BEGIN
                lt_producto.GET("No.");
                IF Rec.Tipo = Rec.Tipo::Otros THEN BEGIN
                    lt_producto.TESTFIELD("Bocados por comensal");
                    lt_bom.RESET;
                    lt_bom.SETRANGE(lt_bom."Parent Item No.", "No.");
                    IF lt_bom.FINDSET THEN BEGIN
                        lfu_BorraComponentes(FALSE);
                        REPEAT
                            lt_lincom.INIT;
                            lt_lincom.TRANSFERFIELDS(lt_bom);
                            lt_lincom."Codigo Evento" := "Codigo Evento";
                            lt_lincom."Linea Evento" := Rec.Linea;
                            lt_ProdComp.GET(lt_bom."No.");
                            //++ KR 02/11/21
                            //lt_ProdComp.TESTFIELD("Bocados por bandeja");
                            IF lt_ProdComp."Bocados por bandeja" = 0 THEN ERROR('Debe indicar el campo "Bocados por bandeja" del producto %1', lt_ProdComp."No.");
                            //--
                            lt_lincom.Bocados := Bocados * lt_bom."Cantidad por Lote";
                            cantidadComp := Bocados * lt_bom."Cantidad por Lote" / lt_ProdComp."Bocados por bandeja";
                            lt_lincom."Cantidad por Lote" := ROUND(cantidadComp, 1, '>');
                            IF (lt_lincom.Type = lt_lincom.Type::Resource) AND (lt_lincom."Resource Usage Type" = lt_lincom."Resource Usage Type"::Fixed) THEN
                                lt_lincom.VALIDATE("Quantity per", lt_lincom."Cantidad por Lote")
                            ELSE BEGIN
                                IF Rec.Cantidad <> 0 THEN // Inicio ADV001
                                // Línea eliminada lt_lincom.VALIDATE("Quantity per",lt_lincom."Cantidad por Lote"/Rec.Cantidad)
                                BEGIN
                                    gt_lincom := lt_lincom;
                                    gfu_CalcularEscalado(gt_lincom);
                                    lt_lincom := gt_lincom
                                END
                                // Fin ADV001
                                ELSE
                                    lt_lincom.VALIDATE("Quantity per", 0);
                            END;
                            lt_lincom."Coste Lote" := lt_lincom."Cantidad por Lote" * lt_lincom.CosteUnitario;
                            IF lt_lincom."Linea Evento" <> 0 THEN lt_lincom.INSERT;
                            //++ KR 15/11/21
                            // Si tiene componentes
                            InsertaComponentes(lt_lincom);
                        // Insertar componentes
                        //--
                        UNTIL lt_bom.NEXT = 0;
                    END;
                END
                ELSE BEGIN
                    lt_bom.RESET;
                    lt_bom.SETRANGE(lt_bom."Parent Item No.", "No.");
                    IF lt_bom.FINDSET THEN BEGIN
                        lfu_BorraComponentes(FALSE);
                        REPEAT
                            lt_lincom.INIT;
                            lt_lincom.TRANSFERFIELDS(lt_bom);
                            lt_lincom."Codigo Evento" := "Codigo Evento";
                            lt_lincom."Linea Evento" := Rec.Linea;
                            lt_lincom."Cantidad por Lote" := lt_lincom."Cantidad por Lote" * Cantidad / lt_producto."Lote Receta";
                            IF (lt_lincom.Type = lt_lincom.Type::Resource) AND (lt_lincom."Resource Usage Type" = lt_lincom."Resource Usage Type"::Fixed) THEN
                                lt_lincom.VALIDATE("Quantity per", lt_lincom."Cantidad por Lote")
                            ELSE BEGIN
                                IF Rec.Cantidad <> 0 THEN // Inicio ADV001
                                // Línea eliminada lt_lincom.VALIDATE("Quantity per",lt_lincom."Cantidad por Lote"/Rec.Cantidad)
                                BEGIN
                                    gt_lincom := lt_lincom;
                                    gfu_CalcularEscalado(gt_lincom);
                                    lt_lincom := gt_lincom
                                END
                                // Fin ADV001
                                ELSE
                                    lt_lincom.VALIDATE("Quantity per", 0);
                            END;
                            lt_lincom."Coste Lote" := lt_lincom."Cantidad por Lote" * lt_lincom.CosteUnitario;
                            IF lt_lincom."Linea Evento" <> 0 THEN lt_lincom.INSERT;
                            //++ KR 15/11/21
                            // Si tiene componentes
                            InsertaComponentes(lt_lincom);
                        // Insertar componentes
                        //--
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
            //ADV004 Inicio Añadimos la siguiente línea
            lt_lincom.SETRANGE(lt_lincom."Parent Item No.", Rec."No.");
            //ADV004 Fin
            TieneLineas := NOT lt_lincom.ISEMPTY;
        END;
    end;

    local procedure lfu_CalculaImportes()
    var
        GLSetup: Record "General Ledger Setup";
        Rcd_Evento: Record Evento;
    begin
        GLSetup.GET;
        Importe := ROUND(Rec.Cantidad * Rec."Precio Real", GLSetup."Amount Rounding Precision");
        "Importe IVA Incl." := ROUND(Importe * (1 + "% IVA" / 100), GLSetup."Amount Rounding Precision");
        "Precio IVA Incl." := ROUND("Precio Real" * (1 + "% IVA" / 100), GLSetup."Amount Rounding Precision");
        Rcd_Evento.GET("Codigo Evento");
        IF Tipo = Rec.Tipo::Adulto THEN BEGIN
            IF Rcd_Evento."Total Adultos" <> 0 THEN
                ImportePorPersona := ROUND(Importe / Rcd_Evento."Total Adultos", GLSetup."Amount Rounding Precision")
            ELSE
                ImportePorPersona := 0;
        END
        ELSE IF Tipo = Rec.Tipo::Niño THEN BEGIN
            IF Rcd_Evento."Total Ninos" <> 0 THEN
                ImportePorPersona := ROUND(Importe / Rcd_Evento."Total Ninos", GLSetup."Amount Rounding Precision")
            ELSE
                ImportePorPersona := 0;
        END
        ELSE IF Tipo = Rec.Tipo::Otros THEN BEGIN
            IF (Rcd_Evento."Total Adultos" + Rcd_Evento."Total Ninos") <> 0 THEN
                ImportePorPersona := ROUND(Importe / (Rcd_Evento."Total Adultos" + Rcd_Evento."Total Ninos"), GLSetup."Amount Rounding Precision")
            ELSE
                ImportePorPersona := 0;
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
        //SL Comentarios 
        if Rec."No." <> '' then begin
            lt_Item.GET(Rec."No.");
            lt_Item.CALCFIELDS("Assembly BOM");
            IF lt_Item."Assembly BOM" THEN BEGIN
                lt_Evento.GET(Rec."Codigo Evento");
                AsmHeader.INIT;
                AsmHeader.SetWarningsOff;
                AsmHeader.VALIDATE("Document Type", AsmHeader."Document Type"::Order);
                AsmHeader.VALIDATE("No.", '');
                //ADV005 Cambiar el validate antes.
                AsmHeader.VALIDATE("Posting Date", lt_Evento."Fecha Evento");
                AsmHeader.VALIDATE("Due Date", lt_Evento."Fecha Evento");
                AsmHeader.VALIDATE("Location Code", '001');
                //ADV005
                //SL Fecha de produccion!!!
                //AsmHeader.AGRALAFechaProduccion := lt_Evento.AGRALAFechaProduccion;
                //AsmHeader.AGRALAFechaEntrega := AssemblyHeader.AGRALAFechaEntrega;
                //SL END
                AsmHeader.INSERT(TRUE);
                AsmHeader.VALIDATE("Item No.", Rec."No.");
                AsmHeader.VALIDATE(Quantity, Rec.Cantidad);
                AsmHeader.VALIDATE("Quantity to Assemble", Rec.Cantidad);
                //AsmHeader.VALIDATE("Posting Date",lt_Evento."Fecha Evento"); //ADV005: comento linea
                AsmHeader.NoEvento := Rec."Codigo Evento";
                //++ KR 280521
                AsmHeader.Description := Rec.Descripcion;
                //--
                // AsmHeader.VALIDATE("Location Code",'001'); //ADV005: comento linea
                AsmHeader.MODIFY(TRUE);
                UpdateAssemblyLines(AsmHeader, AsmHeader, AsmHeader.FIELDNO(Quantity), TRUE, AsmHeader.FIELDNO(Quantity), AsmHeader.FIELDNO(Quantity));
                //++ KR 13/05/21
                /*
                      AsmLine.RESET;
                      AsmLine.SETRANGE("Document Type",AsmHeader."Document Type");
                      AsmLine.SETRANGE("Document No.",AsmHeader."No.");
                      AsmLine.DELETEALL;

                      lt_lincom.RESET;
                      lt_lincom.SETRANGE(lt_lincom."Codigo Evento",Rec."Codigo Evento");
                      lt_lincom.SETRANGE(lt_lincom."Linea Evento",Rec.Linea);
                      IF lt_lincom.FINDSET THEN
                        REPEAT
                          LineNo := LineNo + 10000;
                          AsmLine.INIT;
                          AsmLine."Document Type" := AsmHeader."Document Type";
                          AsmLine.VALIDATE("Document No.",AsmHeader."No.");
                          AsmLine.VALIDATE(Type,lt_lincom.Type);
                          AsmLine.VALIDATE("No.",lt_lincom."No.");
                          AsmLine."Line No." := LineNo;
                          AsmLine.INSERT(TRUE);
                          IF AsmLine.Type = AsmLine.Type::Item THEN
                            AsmLine.VALIDATE("Location Code",'001');
                          //inicio si es cocktel y se mete como menu, cojo cantidades totales en lugar de cantidades unitarias.
                          IF (lt_Item."Lote Receta"=1) AND (Rec.Tipo <> Rec.Tipo::Otros) THEN
                              AsmLine.VALIDATE(AsmLine."Quantity per",lt_lincom."Cantidad por Lote")
                            ELSE
                              AsmLine.VALIDATE("Quantity per",lt_lincom."Cantidad por Lote"/Rec.Cantidad);
                          AsmLine.MODIFY;
                        UNTIL lt_lincom.NEXT = 0;
                    */
            end;
        END;
    end;

    procedure gfu_CalcularEscalado(var pt_LineaComponente: Record "Componentes Evento")
    var
        li_DifActual: Integer;
        li_DifAnterior: Integer;
        li_CantTramoAnterior: Decimal;
        li_Cantidad: Decimal;
        lb_SalirRepeat: Boolean;
        lb_ExisteEscalado: Boolean;
        lb_ExisteEscaladoSuperior: Boolean;
        lt_Componente: Record "BOM Component";
    begin
        // Inicio ADV001
        li_DifActual := 0;
        li_DifAnterior := 10000;
        li_CantTramoAnterior := 0;
        lb_SalirRepeat := FALSE;
        lb_ExisteEscalado := FALSE;
        lb_ExisteEscaladoSuperior := FALSE;
        IF NOT gb_FijarCantidadCabecera THEN gd_CantidadCabecera := Rec.Cantidad;
        gt_Escalados.RESET;
        gt_Escalados.SETRANGE(gt_Escalados.NumeroLM, pt_LineaComponente."Parent Item No.");
        gt_Escalados.SETRANGE(gt_Escalados.Tipo, pt_LineaComponente.Type);
        gt_Escalados.SETRANGE(gt_Escalados.Numero, pt_LineaComponente."No.");
        gt_Escalados.SETRANGE(gt_Escalados.CodigoUnidadMedida, pt_LineaComponente."Unit of Measure Code");
        IF gt_Escalados.FINDSET THEN BEGIN
            gt_Escalados.SETCURRENTKEY(LoteReceta);
            gt_Escalados.SETASCENDING(LoteReceta, TRUE);
            REPEAT
                lb_ExisteEscalado := TRUE;
                CASE gt_Escalados.TipoTramo OF
                    0:
                        BEGIN
                            lb_ExisteEscaladoSuperior := TRUE;
                            IF gt_Escalados.LoteReceta <= gd_CantidadCabecera THEN
                                IF gt_Escalados.CalculoProporcional THEN BEGIN
                                    pt_LineaComponente."Cantidad por Lote" := (gt_Escalados.CantidadLoteReceta / gt_Escalados.LoteReceta) * gd_CantidadCabecera;
                                    // Inicio ADV002
                                    IF pt_LineaComponente.Type = gt_Escalados.Tipo::Recurso THEN BEGIN
                                        lt_Componente.RESET;
                                        IF lt_Componente.GET(gt_Escalados.NumeroLM, gt_Escalados.NumeroLinea) THEN IF lt_Componente.TipoRecurso = lt_Componente.TipoRecurso::Machine THEN pt_LineaComponente."Cantidad por Lote" := ROUND(pt_LineaComponente."Cantidad por Lote", 1, '>')
                                    END;
                                    // Fin ADV002
                                    li_CantTramoAnterior := pt_LineaComponente."Cantidad por Lote"
                                END
                                ELSE BEGIN
                                    //++AGRALA
                                    pt_LineaComponente."Cantidad por Lote" := gt_Escalados.CantidadLoteReceta;
                                    li_CantTramoAnterior := pt_LineaComponente."Cantidad por Lote";
                                    //--AGRALA
                                END
                            ELSE // Compruebo si el resultado del cálculo es mayor a la cantidad configurada en el tramo superior
                                IF li_CantTramoAnterior <> 0 THEN
                                    IF gt_Escalados.CantidadLoteReceta <= li_CantTramoAnterior THEN BEGIN
                                        pt_LineaComponente."Cantidad por Lote" := gt_Escalados.CantidadLoteReceta;
                                        pt_LineaComponente.CantidadEscalado := li_CantTramoAnterior
                                    END;
                        END;
                    1:
                        BEGIN
                            lb_ExisteEscaladoSuperior := TRUE;
                            li_DifActual := ABS(Rec.Cantidad - gt_Escalados.LoteReceta);
                            IF li_DifActual < li_DifAnterior THEN
                                IF gt_Escalados.CalculoProporcional THEN BEGIN
                                    pt_LineaComponente."Cantidad por Lote" := (gt_Escalados.CantidadLoteReceta / gt_Escalados.LoteReceta) * gd_CantidadCabecera;
                                    // Inicio ADV002
                                    IF pt_LineaComponente.Type = gt_Escalados.Tipo::Recurso THEN BEGIN
                                        lt_Componente.RESET;
                                        IF lt_Componente.GET(gt_Escalados.NumeroLM, gt_Escalados.NumeroLinea) THEN IF lt_Componente.TipoRecurso = lt_Componente.TipoRecurso::Machine THEN pt_LineaComponente."Cantidad por Lote" := ROUND(pt_LineaComponente."Cantidad por Lote", 1, '>')
                                    END;
                                    // Fin ADV002
                                    li_CantTramoAnterior := pt_LineaComponente."Cantidad por Lote";
                                    li_DifAnterior := li_DifActual
                                END
                                ELSE BEGIN
                                    pt_LineaComponente."Cantidad por Lote" := gt_Escalados.CantidadLoteReceta;
                                    li_DifAnterior := li_DifActual
                                END
                            ELSE // Compruebo si el resultado del cálculo es mayor a la cantidad configurada en el tramo superior
                                IF li_CantTramoAnterior <> 0 THEN
                                    IF gt_Escalados.CantidadLoteReceta <= li_CantTramoAnterior THEN BEGIN
                                        pt_LineaComponente."Cantidad por Lote" := gt_Escalados.CantidadLoteReceta;
                                        pt_LineaComponente.CantidadEscalado := li_CantTramoAnterior
                                    END;
                        END;
                    2:
                        IF gt_Escalados.LoteReceta >= gd_CantidadCabecera THEN
                            IF gt_Escalados.CalculoProporcional THEN BEGIN
                                pt_LineaComponente."Cantidad por Lote" := (gt_Escalados.CantidadLoteReceta / gt_Escalados.LoteReceta) * gd_CantidadCabecera;
                                // Inicio ADV002
                                IF pt_LineaComponente.Type = gt_Escalados.Tipo::Recurso THEN BEGIN
                                    lt_Componente.RESET;
                                    IF lt_Componente.GET(gt_Escalados.NumeroLM, gt_Escalados.NumeroLinea) THEN IF lt_Componente.TipoRecurso = lt_Componente.TipoRecurso::Machine THEN pt_LineaComponente."Cantidad por Lote" := ROUND(pt_LineaComponente."Cantidad por Lote", 1, '>')
                                END;
                                // Fin ADV002
                                li_CantTramoAnterior := pt_LineaComponente."Cantidad por Lote";
                                lb_ExisteEscaladoSuperior := TRUE
                            END
                            ELSE BEGIN
                                pt_LineaComponente."Cantidad por Lote" := gt_Escalados.CantidadLoteReceta;
                                lb_SalirRepeat := TRUE;
                                lb_ExisteEscaladoSuperior := TRUE
                            END;
                    ELSE // Compruebo si el resultado del cálculo es mayor a la cantidad configurada en el tramo superior
                        IF li_CantTramoAnterior <> 0 THEN
                            IF gt_Escalados.CantidadLoteReceta <= li_CantTramoAnterior THEN BEGIN
                                pt_LineaComponente."Cantidad por Lote" := gt_Escalados.CantidadLoteReceta;
                                pt_LineaComponente.CantidadEscalado := li_CantTramoAnterior
                            END;
                END;
                pt_LineaComponente."Quantity per" := pt_LineaComponente."Cantidad por Lote" / gd_CantidadCabecera;
            UNTIL (gt_Escalados.NEXT = 0) OR lb_SalirRepeat;
        END;
        IF (lb_ExisteEscalado) AND (NOT lb_ExisteEscaladoSuperior) THEN ERROR(ERROR001, pt_LineaComponente."No.", gd_CantidadCabecera);
        // Fin ADV001
    end;

    procedure gfu_CreaRegPedEnsamblado2()
    var
        AsmHeader: Record "Assembly Header";
        lt_Item: Record Item;
        lt_Evento: Record Evento;
        lt_lincom: Record "Componentes Evento";
        LineNo: Integer;
        AsmLine: Record "Assembly Line";
        AssemblyPost: Codeunit "Assembly-Post";
    begin
        lt_Item.GET(Rec."No.");
        lt_Item.CALCFIELDS("Assembly BOM");
        IF lt_Item."Assembly BOM" THEN BEGIN
            lt_Evento.GET(Rec."Codigo Evento");
            AsmHeader.INIT;
            AsmHeader.SetWarningsOff;
            AsmHeader.VALIDATE("Document Type", AsmHeader."Document Type"::Order);
            AsmHeader.VALIDATE("No.", '');
            AsmHeader.INSERT(TRUE);
            AsmHeader.VALIDATE("Item No.", Rec."No.");
            AsmHeader.VALIDATE(Quantity, Rec.Cantidad);
            AsmHeader.VALIDATE("Quantity to Assemble", Rec.Cantidad);
            AsmHeader.VALIDATE("Posting Date", lt_Evento."Fecha Evento");
            AsmHeader.NoEvento := Rec."Codigo Evento";
            AsmHeader.planificado := TRUE;
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
                    //inicio si es cocktel y se mete como menu, cojo cantidades totales en lugar de cantidades unitarias.
                    IF (lt_Item."Lote Receta" = 1) AND (Rec.Tipo <> Rec.Tipo::Otros) THEN
                        AsmLine.VALIDATE(AsmLine."Quantity per", lt_lincom."Cantidad por Lote")
                    ELSE
                        AsmLine.VALIDATE("Quantity per", lt_lincom."Cantidad por Lote" / Rec.Cantidad);
                    AsmLine.MODIFY;
                UNTIL lt_lincom.NEXT = 0;
        END;
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
        //++ 16/11/21
        //CLEAR(FuncionesVarias);
        //FuncionesVarias.CreateAssamblyOrders(AsmHeader);
        CreateAssamblyOrders(AsmHeader);
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
        /*  IF ShowPageEvenIfEnoughComponentsAvailable OR QtyAvailTooLow THEN BEGIN
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
                   END; */
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

    local procedure CalcEarliestDueDate(AsmHeader: Record 900; EarliestStartingDate: Date) EarliestDueDate: Date
    var
        ReqLine: Record 246;
        LeadTimeMgt: Codeunit 5404;
        EarliestEndingDate: Date;
        CDUFI: Codeunit 50000;
    begin
        EarliestDueDate := 0D;
        IF EarliestStartingDate > 0D THEN BEGIN
            EarliestEndingDate :=// earliest starting date + lead time calculation
            CDUFI.PlannedEndingDate2(AsmHeader."Item No.", AsmHeader."Location Code", AsmHeader."Variant Code", '', LeadTimeMgt.ManufacturingLeadTime(AsmHeader."Item No.", AsmHeader."Location Code", AsmHeader."Variant Code"), ReqLine."Ref. Order Type"::Assembly, EarliestStartingDate);
            EarliestDueDate :=// earliest ending date + (default) safety lead time
            LeadTimeMgt.GetPlannedDueDate(AsmHeader."Item No.", AsmHeader."Location Code", AsmHeader."Variant Code", EarliestEndingDate, '', ReqLine."Ref. Order Type"::Assembly);
        END;
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
        AssemblyLine.VALIDATE(Description, BomComponent.Description);
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
        AssemblyLine.VALIDATE(Description, BomComponent.Description);
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

    procedure InsertaComponentes(ComponentesEvento: Record 50014)
    var
        ComponentesEventoInsert: Record 50014;
        Item: Record 27;
        BOMComponent: Record 90;
        cantidadPorLote: Decimal;
        ItemNo: Text;
    begin
        IF ComponentesEvento.Type = ComponentesEvento.Type::Resource THEN EXIT;
        //IF ComponentesEvento."Cantidad por Lote" = 0 THEN
        //EXIT;
        IF NOT Item.GET(ComponentesEvento."No.") THEN EXIT;
        Item.CALCFIELDS(Item."Assembly BOM");
        IF NOT Item."Assembly BOM" THEN EXIT;
        BOMComponent.RESET;
        BOMComponent.SETRANGE("Parent Item No.", ComponentesEvento."No.");
        //** COMENTADO KR 23/03/2022 **
        //++ KR
        //BOMComponent.SETFILTER(BOMComponent.Type, '<>%1', BOMComponent.Type::" ");
        //--
        IF BOMComponent.FINDSET THEN
            REPEAT
                ComponentesEventoInsert.TRANSFERFIELDS(BOMComponent);
                ComponentesEventoInsert."Codigo Evento" := ComponentesEvento."Codigo Evento";
                ComponentesEventoInsert."Linea Evento" := ComponentesEvento."Linea Evento";
                ComponentesEventoInsert."Parent Item No." := BOMComponent."Parent Item No.";
                ComponentesEventoInsert."Line No." := BOMComponent."Line No.";
                //SL: Marco los productos Intermedios para el calculo de coste.
                Evaluate(ItemNo, BOMComponent."Parent Item No.");
                if ItemNo.Contains('PI') then ComponentesEventoInsert.Intermedio := true;
                //SL: end
                if ComponentesEventoInsert.INSERT(TRUE) then;
                ComponentesEventoInsert.VALIDATE(Type, BOMComponent.Type);
                ComponentesEventoInsert.VALIDATE("No.", BOMComponent."No.");
                //cantidadPorLote := ComponentesEventoInsert."Cantidad por Lote";
                //ComponentesEventoInsert.VALIDATE("Cantidad por Lote", 0);
                IF BOMComponent."No." <> '' THEN BEGIN
                    //ComponentesEventoInsert.VALIDATE("No.", BOMComponent."No.");
                    //ComponentesEventoInsert."No." := BOMComponent."No.";
                    ComponentesEventoInsert.VALIDATE("Cantidad por Lote", ComponentesEventoInsert."Cantidad por Lote" * ComponentesEvento."Cantidad por Lote" / Item."Lote Receta");
                    IF ComponentesEvento."Cantidad por Lote" <> 0 THEN ComponentesEventoInsert.VALIDATE("Quantity per", ComponentesEventoInsert."Cantidad por Lote" / ComponentesEvento."Cantidad por Lote");
                    IF (ComponentesEventoInsert.Type = ComponentesEventoInsert.Type::Resource) AND (ComponentesEventoInsert."Resource Usage Type" = ComponentesEventoInsert."Resource Usage Type"::Fixed) THEN
                        ComponentesEventoInsert.VALIDATE("Quantity per", ComponentesEventoInsert."Cantidad por Lote")
                    ELSE BEGIN
                        IF ComponentesEvento."Cantidad por Lote" = 0 THEN
                            ComponentesEventoInsert.VALIDATE("Quantity per", 0)
                        ELSE BEGIN
                            gfu_CalcularEscalado(ComponentesEventoInsert);
                        END;
                    END;
                    ComponentesEventoInsert.VALIDATE("Coste Lote", ComponentesEventoInsert."Cantidad por Lote" * ComponentesEventoInsert.CosteUnitario);
                END;
                ComponentesEventoInsert.MODIFY(TRUE);
            //InsertaComponentes(ComponentesEventoInsert);
            UNTIL BOMComponent.NEXT = 0;
    end;

    procedure InsertaComponentes2(ComponentesEvento: Record "Componentes Evento")
    var
        ComponentesEventoInsert: Record "Componentes Evento";
        Item: Record Item;
        BOMComponent: Record "BOM Component";
        cantidadPorLote: Decimal;
        ItemNo: Text;
        costoLote: decimal;
    begin
        IF ComponentesEvento.Type = ComponentesEvento.Type::Resource THEN EXIT;
        //IF ComponentesEvento."Cantidad por Lote" = 0 THEN
        //EXIT;
        IF NOT Item.GET(ComponentesEvento."No.") THEN EXIT;
        Item.CALCFIELDS(Item."Assembly BOM");
        IF NOT Item."Assembly BOM" THEN EXIT;
        BOMComponent.RESET;
        BOMComponent.SETRANGE("Parent Item No.", ComponentesEvento."No.");
        //** COMENTADO KR 23/03/2022 **
        //++ KR
        //BOMComponent.SETFILTER(BOMComponent.Type, '<>%1', BOMComponent.Type::" ");
        //--
        IF BOMComponent.FINDSET THEN
            REPEAT
                ComponentesEventoInsert.TRANSFERFIELDS(BOMComponent);
                ComponentesEventoInsert."Codigo Evento" := ComponentesEvento."Codigo Evento";
                ComponentesEventoInsert."Linea Evento" := ComponentesEvento."Linea Evento";
                ComponentesEventoInsert."Parent Item No." := BOMComponent."Parent Item No.";
                ComponentesEventoInsert."Line No." := BOMComponent."Line No.";
                //SL: Marco los productos Intermedios para el calculo de coste.
                Evaluate(ItemNo, BOMComponent."Parent Item No.");
                if ItemNo.Contains('PI') then ComponentesEventoInsert.Intermedio := true;
                //SL: end
                ComponentesEventoInsert.INSERT(TRUE);
                ComponentesEventoInsert.VALIDATE(Type, BOMComponent.Type);
                ComponentesEventoInsert.VALIDATE("No.", BOMComponent."No.");
                //cantidadPorLote := ComponentesEventoInsert."Cantidad por Lote";
                //ComponentesEventoInsert.VALIDATE("Cantidad por Lote", 0);
                IF BOMComponent."No." <> '' THEN BEGIN
                    //ComponentesEventoInsert.VALIDATE("No.", BOMComponent."No.");
                    //ComponentesEventoInsert."No." := BOMComponent."No.";
                    ComponentesEventoInsert.VALIDATE("Cantidad por Lote", ComponentesEventoInsert."Cantidad por Lote" * ComponentesEvento."Cantidad por Lote" / Item."Lote Receta");
                    IF ComponentesEvento."Cantidad por Lote" <> 0 THEN ComponentesEventoInsert.VALIDATE("Quantity per", ComponentesEventoInsert."Cantidad por Lote" / ComponentesEvento."Cantidad por Lote");
                    IF (ComponentesEventoInsert.Type = ComponentesEventoInsert.Type::Resource) AND (ComponentesEventoInsert."Resource Usage Type" = ComponentesEventoInsert."Resource Usage Type"::Fixed) THEN
                        ComponentesEventoInsert.VALIDATE("Quantity per", ComponentesEventoInsert."Cantidad por Lote")
                    ELSE BEGIN
                        IF ComponentesEvento."Cantidad por Lote" = 0 THEN
                            ComponentesEventoInsert.VALIDATE("Quantity per", 0)
                        ELSE BEGIN
                            gfu_CalcularEscalado(ComponentesEventoInsert);
                        END;
                    END;
                    costoLote := ComponentesEventoInsert."Cantidad por Lote" * ComponentesEventoInsert.CosteUnitario;
                    ComponentesEventoInsert.VALIDATE("Coste Lote", ComponentesEventoInsert."Cantidad por Lote" * ComponentesEventoInsert.CosteUnitario);
                END
                else
                    ComponentesEventoInsert."Coste Lote" := 0;
                ComponentesEventoInsert.MODIFY(TRUE);
            //InsertaComponentes(ComponentesEventoInsert);
            UNTIL BOMComponent.NEXT = 0;
    end;

    procedure CreateAssamblyOrders(var ParAssemblyHeader: Record "Assembly Header")
    var
        AssemblyLineLocal: Record "Assembly Line";
        InsAssemblyHeader: Record "Assembly Header";
        InsAssemblyLine: Record "Assembly Line";
        Item: Record Item;
        BOMComponent: Record "BOM Component";
        ModAssemblyLine: Record "Assembly Line";
        VarFirstOrderNo: Code[20];
    begin
        //-- #9627
        CLEAR(VarFirstOrderNo);
        VarFirstOrderNo := ParAssemblyHeader."No.";
        AssemblyLineLocal.RESET;
        AssemblyLineLocal.SETRANGE("Document Type", ParAssemblyHeader."Document Type");
        AssemblyLineLocal.SETRANGE("Document No.", ParAssemblyHeader."No.");
        AssemblyLineLocal.SETRANGE(Type, AssemblyLineLocal.Type::Item);
        IF AssemblyLineLocal.FINDSET THEN BEGIN
            REPEAT
                Item.RESET;
                Item.GET(AssemblyLineLocal."No.");
                Item.CALCFIELDS("Assembly BOM");
                IF Item."Assembly BOM" THEN BEGIN
                    InsAssemblyHeader.RESET;
                    InsAssemblyHeader.SETRANGE("Associated Order", TRUE);
                    InsAssemblyHeader.SETRANGE("Associated Order No.", AssemblyLineLocal."Document No.");
                    InsAssemblyHeader.SETRANGE("Associated Order Line", AssemblyLineLocal."Line No.");
                    IF InsAssemblyHeader.FINDFIRST THEN BEGIN
                        //IF InsAssemblyHeader."Quantity to Assemble (Base)" <> AssemblyLineLocal."Quantity to Consume (Base)" THEN BEGIN
                        ModAssamblyOrders(AssemblyLineLocal);
                        //END;
                    END
                    ELSE BEGIN
                        InsAssamblyOrders(ParAssemblyHeader, AssemblyLineLocal, Item, VarFirstOrderNo);
                    END;
                END;
            UNTIL AssemblyLineLocal.NEXT = 0;
        END;
        IF ParAssemblyHeader."Associated Order" THEN BEGIN
            ModAssamblyOrderLine(ParAssemblyHeader);
        END;
        //++ #9627
    end;

    procedure ModAssamblyOrderLine(AssemblyHeader: Record "Assembly Header")
    var
        ModAssemblyLine: Record "Assembly Line";
        VarModRec: Boolean;
    begin
        //-- #9627
        CLEAR(VarModRec);
        ModAssemblyLine.RESET;
        ModAssemblyLine.SETRANGE("Document Type", ModAssemblyLine."Document Type"::Order);
        ModAssemblyLine.SETRANGE("Document No.", AssemblyHeader."Associated Order No.");
        ModAssemblyLine.SETRANGE("Line No.", AssemblyHeader."Associated Order Line");
        IF ModAssemblyLine.FINDFIRST THEN BEGIN
            IF ModAssemblyLine.Quantity <> AssemblyHeader.Quantity THEN BEGIN
                VarModRec := TRUE;
                ModAssemblyLine.VALIDATE(Quantity, AssemblyHeader.Quantity);
            END;
            IF ModAssemblyLine."Location Code" <> AssemblyHeader."Location Code" THEN BEGIN
                VarModRec := TRUE;
                ModAssemblyLine.VALIDATE("Location Code", AssemblyHeader."Location Code");
            END;
            IF ModAssemblyLine."Due Date" <> AssemblyHeader."Due Date" THEN BEGIN
                VarModRec := TRUE;
                ModAssemblyLine.VALIDATE("Due Date", AssemblyHeader."Due Date");
            END;
            IF VarModRec THEN ModAssemblyLine.MODIFY(TRUE);
        END;
        //++ #9627
    end;

    procedure ModAssamblyOrders(AssemblyLine: Record "Assembly Line")
    var
        ModAssemblyHeader: Record "Assembly Header";
        ErrorAssociatedBloc: Label 'The line cannot be change because the associated order is blocked';
    begin
        //-- #9627
        ModAssemblyHeader.RESET;
        ModAssemblyHeader.SETRANGE("Associated Order", TRUE);
        ModAssemblyHeader.SETRANGE("Associated Order No.", AssemblyLine."Document No.");
        ModAssemblyHeader.SETRANGE("Associated Order Line", AssemblyLine."Line No.");
        IF ModAssemblyHeader.FINDFIRST THEN BEGIN
            IF ModAssemblyHeader."Associated Blocked" THEN BEGIN
                ERROR(ErrorAssociatedBloc);
            END
            ELSE BEGIN
                ModAssemblyHeader.SetWarningsOff;
                ModAssemblyHeader.ShowConfirmChangeQtyOff(TRUE);
                ModAssemblyHeader.VALIDATE(Quantity, AssemblyLine."Quantity to Consume (Base)");
                ModAssemblyHeader.VALIDATE("Location Code", AssemblyLine."Location Code");
                ModAssemblyHeader.VALIDATE("Due Date", AssemblyLine."Due Date");
                ModAssemblyHeader.MODIFY(TRUE);
            END;
        END;
        //++ #9627
    end;

    procedure InsAssamblyOrders(AssemblyHeader: Record "Assembly Header"; AssemblyLine: Record "Assembly Line"; Item: Record Item; VarFirstOrderNo: Code[20])
    var
        InsAssemblyHeader: Record "Assembly Header";
    begin
        //-- #9627
        InsAssemblyHeader.INIT;
        InsAssemblyHeader."Document Type" := AssemblyLine."Document Type";
        InsAssemblyHeader.INSERT(TRUE);
        InsAssemblyHeader.SetWarningsOff;
        InsAssemblyHeader.VALIDATE("Item No.", AssemblyLine."No.");
        InsAssemblyHeader.VALIDATE("Unit of Measure Code", AssemblyLine."Unit of Measure Code");
        InsAssemblyHeader.Description := AssemblyLine.Description;
        InsAssemblyHeader."Description 2" := AssemblyLine."Description 2";
        InsAssemblyHeader."Variant Code" := AssemblyLine."Variant Code";
        InsAssemblyHeader."Location Code" := AssemblyLine."Location Code";
        InsAssemblyHeader."Inventory Posting Group" := AssemblyLine."Inventory Posting Group";
        InsAssemblyHeader.VALIDATE("Unit Cost", AssemblyLine."Unit Cost");
        InsAssemblyHeader."Due Date" := AssemblyLine."Due Date";
        InsAssemblyHeader."Starting Date" := AssemblyHeader."Starting Date";
        InsAssemblyHeader."Ending Date" := AssemblyHeader."Ending Date";
        InsAssemblyHeader.Quantity := AssemblyLine.Quantity;
        InsAssemblyHeader."Quantity (Base)" := AssemblyLine."Quantity (Base)";
        InsAssemblyHeader.InitRemainingQty;
        InsAssemblyHeader.InitQtyToAssemble;
        IF AssemblyLine."Bin Code" <> '' THEN
            InsAssemblyHeader."Bin Code" := AssemblyLine."Bin Code"
        ELSE
            InsAssemblyHeader.GetDefaultBin;
        InsAssemblyHeader."Planning Flexibility" := AssemblyHeader."Planning Flexibility";
        InsAssemblyHeader."Shortcut Dimension 1 Code" := AssemblyLine."Shortcut Dimension 1 Code";
        InsAssemblyHeader."Shortcut Dimension 2 Code" := AssemblyLine."Shortcut Dimension 2 Code";
        InsAssemblyHeader."Dimension Set ID" := AssemblyLine."Dimension Set ID";
        InsAssemblyHeader.NoEvento := AssemblyHeader.NoEvento;
        InsAssemblyHeader."Associated Order" := TRUE;
        InsAssemblyHeader."Associated Order No." := AssemblyLine."Document No.";
        InsAssemblyHeader."Associated Order Line" := AssemblyLine."Line No.";
        InsAssemblyHeader."Associated First Order No." := VarFirstOrderNo;
        InsAssemblyHeader.VALIDATE("Net Amount"); //** #9969
        InsAssemblyHeader.MODIFY;
        InsAssamblyOrdersLines(InsAssemblyHeader, AssemblyLine, Item, VarFirstOrderNo);
        //++ #9627
    end;

    procedure InsAssamblyOrdersLines(AssemblyHeader: Record "Assembly Header"; AssemblyLine: Record "Assembly Line"; Item: Record Item; VarFirstOrderNo: Code[20])
    var
        InsAssemblyHeader: Record "Assembly Header";
        BOMComponent: Record "Componentes Evento";
    begin
        //-- #9627
        BOMComponent.RESET;
        BOMComponent.SETRANGE("Codigo Evento", Rec."Codigo Evento");
        BOMComponent.SETRANGE("Linea Evento", Rec.Linea);
        BOMComponent.SETRANGE("Parent Item No.", Item."No.");
        IF BOMComponent.FINDFIRST THEN BEGIN
            REPEAT
                AssemblyHeader.AddBOMLineEvento(BOMComponent);
            UNTIL BOMComponent.NEXT = 0
        END;
        CheckNewLinesAssamblyOrders(AssemblyHeader, VarFirstOrderNo);
        //++ #9627
    end;

    procedure CheckNewLinesAssamblyOrders(AssemblyHeader: Record "Assembly Header"; VarFirstOrderNo: Code[20])
    var
        AssemblyLine: Record "Assembly Line";
        Item: Record Item;
        BOMComponent: Record "BOM Component";
    begin
        //-- #9627
        AssemblyLine.RESET;
        AssemblyLine.SETRANGE("Document Type", AssemblyHeader."Document Type");
        AssemblyLine.SETRANGE("Document No.", AssemblyHeader."No.");
        AssemblyLine.SETRANGE(Type, AssemblyLine.Type::Item);
        IF AssemblyLine.FINDSET THEN BEGIN
            REPEAT
                Item.RESET;
                Item.GET(AssemblyLine."No.");
                Item.CALCFIELDS("Assembly BOM");
                IF Item."Assembly BOM" THEN BEGIN
                    InsAssamblyOrders(AssemblyHeader, AssemblyLine, Item, VarFirstOrderNo);
                END;
            UNTIL AssemblyLine.NEXT = 0;
        END;
        //++ #9627
    end;

    procedure CalcCosteDirecto()
    var
        ComponentesEventoLocal: Record "Componentes Evento";
        lt_Componentes: Record "Componentes Evento";
    begin
        /*  ComponentesEventoLocal.RESET;
         ComponentesEventoLocal.SETCURRENTKEY("Codigo Evento", "Linea Evento", "Parent Item No.", "Line No.");
         ComponentesEventoLocal.SETRANGE("Codigo Evento", Rec."Codigo Evento");
         ComponentesEventoLocal.SETRANGE("Linea Evento", Rec.Linea);
         ComponentesEventoLocal.SETRANGE("Parent Item No.", Rec."No.");
         ComponentesEventoLocal.SetFilter(Type, '%1|%2', ComponentesEventoLocal.Type::Item, ComponentesEventoLocal.Type::Resource);
         ComponentesEventoLocal.CALCSUMS("Coste Lote");

         Rec."Coste Directo" := ComponentesEventoLocal."Coste Lote"; */
        lt_Componentes.RESET;
        lt_Componentes.SETCURRENTKEY("Codigo Evento", "Linea Evento", "Parent Item No.", "Line No.");
        lt_Componentes.SETRANGE("Codigo Evento", Rec."Codigo Evento");
        lt_Componentes.SETRANGE("Linea Evento", Rec.Linea);
        lt_Componentes.SETRANGE("Parent Item No.", Rec."No.");
        if lt_Componentes.FindFirst() then;
        lt_Componentes.CALCSUMS("Coste Lote");
        Rec."Coste Directo" := lt_Componentes."Coste Lote";
        Rec.MODIFY;
        // KR 22/11/21 Buscamos costes de hijos (se pone aquí por comodidad porque el proceso está montado para ejecutarse dos veces seguidas :) )
        CalcularCosteLMRecursivo(lt_Componentes);
    end;

    local procedure CalcularCosteLMRecursivo(var ComponentesEvento: Record "Componentes Evento")
    var
        ComponentesEventos2: Record "Componentes Evento";
        Item: Record Item;
        ItemNo: Text;
    begin
        IF ComponentesEvento.FINDFIRST THEN
            REPEAT
                IF Item.GET(ComponentesEvento."No.") THEN BEGIN
                    Item.CALCFIELDS("Assembly BOM");
                    IF Item."Assembly BOM" THEN BEGIN
                        // Sumamos coste
                        ComponentesEventos2.RESET;
                        ComponentesEventos2.SETRANGE("Codigo Evento", ComponentesEvento."Codigo Evento");
                        ComponentesEventos2.SETRANGE("Linea Evento", ComponentesEvento."Linea Evento");
                        ComponentesEventos2.SETRANGE("Parent Item No.", ComponentesEvento."No.");
                        ComponentesEventos2.SetFilter(Type, '%1|%2', ComponentesEventos2.Type::Item, ComponentesEventos2.Type::Resource);
                        //++ PRimero actualizamos costes hijos
                        CalcularCosteLMRecursivo(ComponentesEventos2);
                        ComponentesEventos2.CALCSUMS("Coste Lote");
                        //--                        
                        ComponentesEvento."Coste Lote" := ComponentesEventos2."Coste Lote";
                        ComponentesEvento.MODIFY;
                    END;
                END;
            UNTIL ComponentesEvento.NEXT = 0;
    end;
}
