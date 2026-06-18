table 50014 "Componentes Evento"
{
    // ADVANCE - Log de cambios
    // -----------------------------------------------------
    //   ADVANCE
    //   Fecha: 15-04-2016
    //   Técnico: JMAP
    //   Presupuesto: Proyecto I002436 - RQ300 - Def. de componentes de recetas de eventos
    // 
    //   Etiqueta: ADV001
    // -----------------------------------------------------
    //   ADVANCE
    //   Fecha: 17-08-2018
    //   Técnico: JAB
    //   Presupuesto: I009029 - Gestión de escalados
    //   Etiqueta: ADV002
    // -----------------------------------------------------
    //   ADVANCE
    //   Fecha: 12-11-2018
    //   Técnico: JAB
    //   Presupuesto: I009029 - Gestión de escalados
    //   Modificación: Redondear al entero superior cuando se trate de un "Recurso" - "Máquina"
    //   Etiqueta: ADV003
    // -----------------------------------------------------
    //   ADVANCE
    //   Fecha: 28-06-2019
    //   Técnico: JAB
    //   Presupuesto: I011528 - Error en componentes de evento cantidad por UMB
    //   Etiqueta: ADV004
    // -----------------------------------------------------
    // KR 23/03/2022 - Se comenta para permitir introducir lineas en blanco
    Caption = 'Event Component';
    DrillDownPageID = 50068;
    LookupPageID = 50068;

    fields
    {
        field(1; "Parent Item No."; Code[20])
        {
            Caption = 'Nº L.M';
            NotBlank = true;
            TableRelation = Item WHERE(Type=CONST(Inventory));
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Nº Linea';
        }
        field(3; Type; Option)
        {
            Caption = 'Tipo';
            OptionCaption = ' ,Producto,Recurso';
            OptionMembers = " ", Item, Resource;

            trigger OnValidate()
            begin
                "No.":='';
                "Variant Code":='';
            end;
        }
        field(4; "No."; Code[20])
        {
            Caption = 'Nº';
            TableRelation = IF(Type=CONST(Item))Item WHERE(Type=CONST(Inventory))
            ELSE IF(Type=CONST(Resource))Resource;

            trigger OnValidate()
            var
                LineasEvento: Record 50002;
            begin
                //-- KR 23/03/2022
                //TESTFIELD(Type);
                //++ KR 23/03/2022
                "Variant Code":='';
                IF "No." = '' THEN EXIT;
                CASE Type OF Type::Item: BEGIN
                    Item.GET("No.");
                    ValidateAgainstRecursion("No.");
                    Item.CALCFIELDS("Assembly BOM");
                    "Assembly BOM":=Item."Assembly BOM";
                    Description:=Item.Description;
                    "Unit of Measure Code":=Item."Base Unit of Measure";
                    //++ KR 29/01/22
                    //CosteUnitario := Item."Unit Cost";
                    IF Item."Standard Cost" <> 0 THEN CosteUnitario:=Item."Standard Cost" * GetUnitOfMeasurmentPer(Rec."No.", Rec."Unit of Measure Code") //#10652
                    ELSE
                        CosteUnitario:=Item."Unit Cost" * GetUnitOfMeasurmentPer(Rec."No.", Rec."Unit of Measure Code"); //#10652
                    //--
                    ParentItem.GET("Parent Item No.");
                    //CalcLowLevelCode.SetRecursiveLevelsOnItem(Item, ParentItem."Low-Level Code" + 1, TRUE);
                    Item.FIND;
                    ParentItem.FIND;
                    //SL quito validacion de "Low-Level Code" Error al meter una MP dentro de una receta en un evento
                    //IF ParentItem."Low-Level Code" > Item."Low-Level Code" THEN
                    //    ERROR(Text001, "No.");
                    //++ KR Eventos 28/11/21
                    //++ Si cambia de producto borramos componentes hijos
                    IF(Rec."No." <> '') AND (Rec."No." <> xRec."No.")THEN BEGIN
                        DeleteSubComponentes;
                    END;
                    LineasEvento.InsertaComponentes(Rec);
                //--
                END;
                Type::Resource: BEGIN
                    Res.GET("No.");
                    "Assembly BOM":=FALSE;
                    Description:=Res.Name;
                    CosteUnitario:=Res."Unit Cost";
                    "Unit of Measure Code":=Res."Base Unit of Measure";
                END;
                END;
            end;
        }
        field(5; "Assembly BOM"; Boolean)
        {
            CalcFormula = Exist("BOM Component" WHERE(Type=CONST(Item), "Parent Item No."=FIELD("No.")));
            Caption = 'L.M. de ensamblado';
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; Description; Text[50])
        {
            Caption = 'Descripción';
        }
        field(7; "Unit of Measure Code"; Code[50])
        {
            Caption = 'Cód. Unidad medida';
            TableRelation = IF(Type=CONST(Item))"Item Unit of Measure".Code WHERE("Item No."=FIELD("No."))
            ELSE IF(Type=CONST(Resource))"Resource Unit of Measure".Code WHERE("Resource No."=FIELD("No."));

            trigger OnValidate()
            var
                itemlocal: Record 27;
            begin
                //-- #10652
                CASE Type OF Type::Item: BEGIN
                    itemlocal.GET("No.");
                    CosteUnitario:=itemlocal."Standard Cost" * GetUnitOfMeasurmentPer(Rec."No.", Rec."Unit of Measure Code");
                END;
                END;
                ActualizarCosteCalculado();
                VALIDATE("Importancia en Coste");
            //++ #10652
            end;
        }
        field(8; "Quantity per"; Decimal)
        {
            Caption = 'Cantidad por';
            DecimalPlaces = 0: 5;
            MinValue = 0;

            trigger OnValidate()
            begin
                "Coste Calculado":="Quantity per" * CosteUnitario;
                //++ KR
                ActualizarRecetaCascada;
            end;
        }
        field(9; Position; Code[50])
        {
            Caption = 'Posición';
        }
        field(10; "Position 2"; Code[50])
        {
            Caption = 'Posición 2';
        }
        field(11; "Position 3"; Code[50])
        {
            Caption = 'Posición 3';
        }
        field(12; "Machine No."; Code[50])
        {
            Caption = 'Machine No.';
        }
        field(13; "Lead-Time Offset"; DateFormula)
        {
            Caption = 'Lead-Time Offset';
        }
        field(14; "BOM Description"; Text[150])
        {
            CalcFormula = Lookup(Item.Description WHERE("No."=FIELD("Parent Item No.")));
            Caption = 'L.M. Descripción';
            Editable = false;
            FieldClass = FlowField;
        }
        field(20; "Resource Usage Type"; Option)
        {
            Caption = 'Resource Usage Type';
            OptionCaption = 'Directo,Fijo';
            OptionMembers = Direct, "Fixed";

            trigger OnValidate()
            begin
                IF "Resource Usage Type" = xRec."Resource Usage Type" THEN EXIT;
                TESTFIELD(Type, Type::Resource);
            end;
        }
        field(5402; "Variant Code"; Code[50])
        {
            Caption = 'Marca';
            TableRelation = IF(Type=CONST(Item))"Item Variant".Code WHERE("Item No."=FIELD("No."));

            trigger OnValidate()
            begin
                IF "Variant Code" = '' THEN EXIT;
                TESTFIELD(Type, Type::Item);
                TESTFIELD("No.");
                ItemVariant.GET("No.", "Variant Code");
                Description:=ItemVariant.Description;
            end;
        }
        field(5900; "Installed in Line No."; Integer)
        {
            Caption = 'Installed in Line No.';

            trigger OnLookup()
            begin
                BOMComp.RESET;
                BOMComp.SETRANGE("Parent Item No.", "Parent Item No.");
                BOMComp.SETRANGE(Type, BOMComp.Type::Item);
                BOMComp.SETFILTER("Line No.", '<>%1', "Line No.");
                CLEAR(AssemblyBOM);
                AssemblyBOM.SETTABLEVIEW(BOMComp);
                AssemblyBOM.EDITABLE(FALSE);
                AssemblyBOM.LOOKUPMODE(TRUE);
                IF AssemblyBOM.RUNMODAL = ACTION::LookupOK THEN BEGIN
                    AssemblyBOM.GETRECORD(BOMComp);
                    VALIDATE("Installed in Line No.", BOMComp."Line No.");
                END;
            end;
            trigger OnValidate()
            begin
                IF "Installed in Line No." <> 0 THEN BEGIN
                    IF "Installed in Line No." = "Line No." THEN ERROR(Text000, FIELDCAPTION("Installed in Line No."));
                    BOMComp.RESET;
                    BOMComp.SETRANGE("Parent Item No.", "Parent Item No.");
                    BOMComp.SETRANGE(Type, BOMComp.Type::Item);
                    BOMComp.SETRANGE("Line No.", "Installed in Line No.");
                    BOMComp.FINDFIRST;
                    BOMComp.TESTFIELD("Quantity per", 1);
                    "Installed in Item No.":=BOMComp."No.";
                END
                ELSE
                    "Installed in Item No.":='';
            end;
        }
        field(5901; "Installed in Item No."; Code[20])
        {
            Caption = 'Installed in Item No.';
            TableRelation = IF(Type=CONST(Item))Item;

            trigger OnLookup()
            begin
                BOMComp.RESET;
                BOMComp.SETRANGE("Parent Item No.", "Parent Item No.");
                BOMComp.SETRANGE(Type, BOMComp.Type::Item);
                BOMComp."No.":="Installed in Item No.";
                BOMComp.SETFILTER("Line No.", '<>%1', "Line No.");
                CLEAR(AssemblyBOM);
                AssemblyBOM.SETTABLEVIEW(BOMComp);
                AssemblyBOM.EDITABLE(FALSE);
                AssemblyBOM.LOOKUPMODE(TRUE);
                IF AssemblyBOM.RUNMODAL = ACTION::LookupOK THEN BEGIN
                    AssemblyBOM.GETRECORD(BOMComp);
                    VALIDATE("Installed in Line No.", BOMComp."Line No.");
                END;
            end;
            trigger OnValidate()
            begin
                IF "Installed in Item No." <> '' THEN BEGIN
                    BOMComp.RESET;
                    BOMComp.SETRANGE("Parent Item No.", "Parent Item No.");
                    BOMComp.SETRANGE(Type, BOMComp.Type::Item);
                    BOMComp.SETRANGE("No.", "Installed in Item No.");
                    BOMComp.FINDFIRST;
                END;
                VALIDATE("Installed in Line No.", BOMComp."Line No.");
            end;
        }
        field(50000; "Cantidad por Lote"; Decimal)
        {
            Caption = 'Cantidad por Lote';
            DecimalPlaces = 0: 6;

            trigger OnValidate()
            var
                lt_producto: Record 27;
                lt_LineaEvento: Record 50002;
                lt_lineamenaje: Record 50016;
            begin
                lt_producto.RESET;
                lt_producto.GET("Parent Item No.");
                lt_producto.TESTFIELD(lt_producto."Lote Receta");
                IF(Type = Type::Resource) AND ("Resource Usage Type" = "Resource Usage Type"::Fixed)THEN BEGIN
                    VALIDATE("Quantity per", "Cantidad por Lote");
                END
                ELSE
                BEGIN
                    //++ KR 16/08/21
                    /*
                    getProductoEvento;
                    IF ProductosEvento.Cantidad <> 0 THEN
                    BEGIN
                      VALIDATE("Quantity per",Rec."Cantidad por Lote"/ProductosEvento.Cantidad);
                    END ELSE BEGIN
                    */
                    //--
                    IF lt_LineaEvento.GET("Codigo Evento", "Linea Evento")THEN BEGIN
                        IF gd_CantidadCabecera <> 0 THEN BEGIN
                            // Inicio ADV002
                            // Línea eliminada VALIDATE("Quantity per","Cantidad por Lote"/lt_LineaEvento.Cantidad)
                            gfu_CalcularEscalado(lt_LineaEvento);
                        // Fin ADV002
                        END
                        ELSE
                            // Inicio ADV004
                            //VALIDATE("Quantity per", 0);
                            VALIDATE("Quantity per", Rec."Cantidad por Lote" / lt_LineaEvento.Cantidad);
                    // Fin ADV004
                    END
                    ELSE IF lt_lineamenaje.GET("Codigo Evento", 2, "Linea Evento")THEN BEGIN
                            VALIDATE("Quantity per", Rec."Cantidad por Lote" / lt_lineamenaje.Cantidad);
                        END;
                //++
                //END;
                //--
                END;
                Validate("Importancia en Coste");
                "Coste Lote":="Cantidad por Lote" * CosteUnitario;
            end;
        }
        field(50001; "Importancia en Coste"; Decimal)
        {
            Caption = 'Importancia en Coste';
            Editable = false;

            trigger OnValidate()
            begin
                ActualizarImportancia();
            end;
        }
        field(50002; "Cantidad por Bandeja"; Decimal)
        {
            Enabled = false;
        }
        field(50003; "Proveedor por Defecto"; Code[20])
        {
            CalcFormula = Lookup(Item."Vendor No." WHERE("No."=FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50004; CosteUnitario; Decimal)
        {
            Caption = 'Coste Unitario';
            Editable = false;
        }
        field(50005; Comentario; Text[80])
        {
        }
        field(50006; "Alias Proveedor"; Text[50])
        {
            Editable = false;
        }
        field(50007; "Coste Calculado"; Decimal)
        {
            Editable = false;
        }
        field(50008; "Codigo Evento"; Code[20])
        {
            TableRelation = Evento;
        }
        field(50009; "Linea Evento"; Integer)
        {
        }
        field(50010; TipoRecurso; Option)
        {
            Caption = 'Tipo Recurso';
            Description = '#9785';
            Editable = false;
            OptionCaption = ' ,Person,Machine';
            OptionMembers = " ", Person, Machine;
        }
        field(50011; "Coste Lote"; Decimal)
        {
            Editable = false;

            trigger OnValidate()
            begin
                nro:=1;
            end;
        }
        field(50012; Bocados; Decimal)
        {
            Editable = false;
        }
        field(50013; "Huérfano"; Boolean)
        {
        }
        field(50014; CantidadEscalado; Decimal)
        {
            Caption = 'Cantidad escalado';
        }
        field(50015; "Related Work Center"; Code[20])
        {
            Caption = 'Related Work Center';
            Description = '#9785';
            Editable = false;
            TableRelation = "Work center Header"."No.";
        }
        field(60000; CantidadPorLoteAnterior; Decimal)
        {
            Description = 'KR Eventos';
        }
        field(50016; Intermedio; Boolean)
        {
            Caption = 'Producto PI';
        }
    }
    keys
    {
        key(Key1; "Codigo Evento", "Linea Evento", "Parent Item No.", "Line No.")
        {
            Clustered = true;
            SumIndexFields = "Coste Lote";
        }
        key(Key2; Type, "No.")
        {
        }
        key(Key3; Position)
        {
        }
        key(Key4; "Parent Item No.", Type, Position)
        {
        }
        key(Key5; "Codigo Evento", Position, "Linea Evento")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnDelete()
    begin
        //++ KR eventos
        DeleteSubComponentes;
    //--
    end;
    trigger OnInsert()
    begin
        Item.GET("Parent Item No.");
        IF Type = Type::Item THEN ValidateAgainstRecursion("No.");
    end;
    trigger OnModify()
    var
        coste: Decimal;
    begin
        Item.GET("Parent Item No.");
        IF Type = Type::Item THEN ValidateAgainstRecursion("No.");
        coste:="Coste Lote";
    end;
    trigger OnRename()
    begin
        Item.GET("Parent Item No.");
        IF Type = Type::Item THEN ValidateAgainstRecursion("No.")end;
    var Text000: Label '%1 cannot be component of itself.';
    Text001: Label 'You cannot insert item %1 as an assembly component of itself.';
    Item: Record 27;
    ParentItem: Record 27;
    Res: Record 156;
    ItemVariant: Record 5401;
    BOMComp: Record 90;
    gt_Escalados: Record 50017;
    gd_CantidadCabecera: Decimal;
    gb_FijarCantidadCabecera: Boolean;
    ERROR001: Label 'There is no scaling section for product %1 for quantity %2. Review the list of scales for that product';
    ProductosEvento: Record 50016;
    //CalcLowLevelCode: Codeunit 99000793;
    AssemblyBOM: Page 36;
    procedure ValidateAgainstRecursion(ItemNo: Code[20])
    var
        BOMComp: Record 90;
    begin
        IF "Parent Item No." = ItemNo THEN ERROR(Text001, ItemNo);
        IF Type = Type::Item THEN BEGIN
            BOMComp.SETCURRENTKEY(Type, "No.");
            BOMComp.SETRANGE(Type, Type::Item);
            BOMComp.SETRANGE("No.", "Parent Item No.");
            IF BOMComp.FINDSET THEN REPEAT BOMComp.ValidateAgainstRecursion(ItemNo);
                UNTIL BOMComp.NEXT = 0 END end;
    procedure gfu_CalcularEscalado(var pt_LineaEvento: Record 50002)
    var
        li_DifActual: Integer;
        li_DifAnterior: Integer;
        li_CantTramoAnterior: Decimal;
        li_Cantidad: Decimal;
        lb_SalirRepeat: Boolean;
        lb_ExisteEscalado: Boolean;
        lb_ExisteEscaladoSuperior: Boolean;
        lt_Componente: Record 90;
    begin
        // Inicio ADV002
        li_DifActual:=0;
        li_DifAnterior:=10000;
        li_CantTramoAnterior:=0;
        lb_SalirRepeat:=FALSE;
        lb_ExisteEscalado:=FALSE;
        lb_ExisteEscaladoSuperior:=FALSE;
        IF NOT gb_FijarCantidadCabecera THEN gd_CantidadCabecera:=pt_LineaEvento.Cantidad;
        gt_Escalados.RESET;
        gt_Escalados.SETRANGE(gt_Escalados.NumeroLM, "Parent Item No.");
        gt_Escalados.SETRANGE(gt_Escalados.NumeroLinea, "Line No.");
        gt_Escalados.SETRANGE(gt_Escalados.Tipo, Type);
        gt_Escalados.SETRANGE(gt_Escalados.Numero, "No.");
        gt_Escalados.SETRANGE(gt_Escalados.CodigoUnidadMedida, "Unit of Measure Code");
        IF gt_Escalados.FINDSET THEN BEGIN
            gt_Escalados.SETCURRENTKEY(LoteReceta);
            gt_Escalados.SETASCENDING(LoteReceta, TRUE);
            REPEAT CASE gt_Escalados.TipoTramo OF 0: BEGIN
                    lb_ExisteEscaladoSuperior:=TRUE;
                    IF gt_Escalados.LoteReceta <= gd_CantidadCabecera THEN IF gt_Escalados.CalculoProporcional THEN BEGIN
                            "Cantidad por Lote":=(gt_Escalados.CantidadLoteReceta / gt_Escalados.LoteReceta) * gd_CantidadCabecera;
                            // Inicio ADV003
                            IF Type = gt_Escalados.Tipo::Recurso THEN BEGIN
                                lt_Componente.RESET;
                                IF lt_Componente.GET(gt_Escalados.NumeroLM, gt_Escalados.NumeroLinea)THEN IF lt_Componente.TipoRecurso = lt_Componente.TipoRecurso::Machine THEN "Cantidad por Lote":=ROUND("Cantidad por Lote", 1, '>')END;
                            // Fin ADV003
                            li_CantTramoAnterior:="Cantidad por Lote" END
                        ELSE
                            "Cantidad por Lote":=gt_Escalados.CantidadLoteReceta
                    ELSE // Compruebo si el resultado del cálculo es mayor a la cantidad configurada en el tramo superior
                        IF li_CantTramoAnterior <> 0 THEN IF gt_Escalados.CantidadLoteReceta <= li_CantTramoAnterior THEN BEGIN
                                "Cantidad por Lote":=gt_Escalados.CantidadLoteReceta;
                                CantidadEscalado:=li_CantTramoAnterior END;
                END;
                1: BEGIN
                    lb_ExisteEscaladoSuperior:=TRUE;
                    li_DifActual:=ABS(gd_CantidadCabecera - gt_Escalados.LoteReceta);
                    IF li_DifActual < li_DifAnterior THEN IF gt_Escalados.CalculoProporcional THEN BEGIN
                            "Cantidad por Lote":=(gt_Escalados.CantidadLoteReceta / gt_Escalados.LoteReceta) * gd_CantidadCabecera;
                            // Inicio ADV003
                            IF Type = gt_Escalados.Tipo::Recurso THEN BEGIN
                                lt_Componente.RESET;
                                IF lt_Componente.GET(gt_Escalados.NumeroLM, gt_Escalados.NumeroLinea)THEN IF lt_Componente.TipoRecurso = lt_Componente.TipoRecurso::Machine THEN "Cantidad por Lote":=ROUND("Cantidad por Lote", 1, '>')END;
                            // Fin ADV003
                            li_CantTramoAnterior:="Cantidad por Lote";
                            li_DifAnterior:=li_DifActual END
                        ELSE
                        BEGIN
                            "Cantidad por Lote":=gt_Escalados.CantidadLoteReceta;
                            li_DifAnterior:=li_DifActual END
                    ELSE // Compruebo si el resultado del cálculo es mayor a la cantidad configurada en el tramo superior
                        IF li_CantTramoAnterior <> 0 THEN IF gt_Escalados.CantidadLoteReceta <= li_CantTramoAnterior THEN BEGIN
                                "Cantidad por Lote":=gt_Escalados.CantidadLoteReceta;
                                CantidadEscalado:=li_CantTramoAnterior END;
                END;
                2: IF gt_Escalados.LoteReceta >= gd_CantidadCabecera THEN IF gt_Escalados.CalculoProporcional THEN BEGIN
                            "Cantidad por Lote":=(gt_Escalados.CantidadLoteReceta / gt_Escalados.LoteReceta) * gd_CantidadCabecera;
                            // Inicio ADV003
                            IF Type = gt_Escalados.Tipo::Recurso THEN BEGIN
                                lt_Componente.RESET;
                                IF lt_Componente.GET(gt_Escalados.NumeroLM, gt_Escalados.NumeroLinea)THEN IF lt_Componente.TipoRecurso = lt_Componente.TipoRecurso::Machine THEN "Cantidad por Lote":=ROUND("Cantidad por Lote", 1, '>')END;
                            // Fin ADV003
                            li_CantTramoAnterior:="Cantidad por Lote";
                            lb_ExisteEscaladoSuperior:=TRUE END
                        ELSE
                        BEGIN
                            "Cantidad por Lote":=gt_Escalados.CantidadLoteReceta;
                            lb_SalirRepeat:=TRUE;
                            lb_ExisteEscaladoSuperior:=TRUE END;
                ELSE // Compruebo si el resultado del cálculo es mayor a la cantidad configurada en el tramo superior
                    IF li_CantTramoAnterior <> 0 THEN IF gt_Escalados.CantidadLoteReceta <= li_CantTramoAnterior THEN BEGIN
                            "Cantidad por Lote":=gt_Escalados.CantidadLoteReceta;
                            CantidadEscalado:=li_CantTramoAnterior END;
                END;
                "Quantity per":="Cantidad por Lote" / gd_CantidadCabecera;
            UNTIL(gt_Escalados.NEXT = 0) OR lb_SalirRepeat;
        END;
        IF(lb_ExisteEscalado) AND (NOT lb_ExisteEscaladoSuperior)THEN ERROR(ERROR001, "No.", gd_CantidadCabecera);
        // Fin ADV002
        //++ KR 28/11/21
        VALIDATE("Quantity per");
    //--
    end;
    procedure gfu_SetCantidadLineaEvento(pd_Cantidad: Decimal; pb_Fijar: Boolean)
    begin
        // Inicio ADV002
        gd_CantidadCabecera:=pd_Cantidad;
        gb_FijarCantidadCabecera:=pb_Fijar;
    // Fin ADV002
    end;
    local procedure "//++ KR"()
    begin
    end;
    local procedure getProductoEvento()
    begin
        //++ TODO: Falta arrastrar el tipo de producto evento para poder acceder a él desde las líneas
        //++ Falta añadir el filtro de tipo en las líneas, por ahora se filtra por el producto pero si se usa el mismo producto en dos productoseventos comparten componentes :)) (16/08/21)
        IF(ProductosEvento."Codigo Evento" <> Rec."Codigo Evento") OR (ProductosEvento.Linea <> Rec."Linea Evento") OR (ProductosEvento.Producto <> Rec."Parent Item No.")THEN BEGIN
            //ProductosEvento.GET(Rec."Codigo Evento", Rec.Type, Rec."Linea Evento", Rec."Parent Item No.");
            ProductosEvento.RESET;
            ProductosEvento.SETRANGE(ProductosEvento."Codigo Evento", Rec."Codigo Evento");
            ProductosEvento.SETRANGE(ProductosEvento.Linea, Rec."Linea Evento");
            ProductosEvento.SETRANGE(ProductosEvento.Producto, Rec."Parent Item No.");
            ProductosEvento.FINDFIRST;
        END;
    end;
    procedure ReturnFormat(ComponentesEvento: Record 50014)ReturnText: Text var
        ItemLocal: Record 27;
    begin
        //-- #9804
        CLEAR(ReturnText);
        CASE ComponentesEvento.Type OF ComponentesEvento.Type::Item: BEGIN
            IF ItemLocal.GET(ComponentesEvento."No.")THEN BEGIN
                ItemLocal.CALCFIELDS("Assembly BOM");
                IF ItemLocal."Assembly BOM" THEN ReturnText:='StrongAccent';
            END;
        END;
        ComponentesEvento.Type::" ": BEGIN
            IF "Related Work Center" <> '' THEN ReturnText:='Strong';
        END;
        END;
    //++ #9804
    end;
    procedure ReturnFormatImportanciaCoste(ComponentesEvento: Record 50014)ReturnText: Text var
        TotalImportanciaCoste: Decimal;
        CalcImportanciaCoste: Decimal;
        BOMComponentCheck: Record 90;
    begin
        //-- #9804
        CLEAR(ReturnText);
        CLEAR(TotalImportanciaCoste);
        CLEAR(CalcImportanciaCoste);
        IF ComponentesEvento.Type <> ComponentesEvento.Type::" " THEN BEGIN
            /*BOMComponentCheck.RESET;
            BOMComponentCheck.SETRANGE("Parent Item No.", BOMComponent."Parent Item No.");
            IF BOMComponentCheck.FINDSET THEN BEGIN
               REPEAT
                 TotalImportanciaCoste := TotalImportanciaCoste + BOMComponentCheck."Importancia en Coste";
               UNTIL BOMComponentCheck.NEXT = 0;
            END;

            IF TotalImportanciaCoste <> 0 THEN BEGIN
               CalcImportanciaCoste := ROUND(((BOMComponent."Importancia en Coste") / TotalImportanciaCoste),0.01);
            END;*/
            CalcImportanciaCoste:=ComponentesEvento."Importancia en Coste" / 100;
            IF CalcImportanciaCoste >= 0.66 THEN BEGIN
                ReturnText:='Unfavorable';
            END
            ELSE
            BEGIN
                IF CalcImportanciaCoste >= 0.33 THEN ReturnText:='Ambiguous'
                ELSE
                    ReturnText:='Favorable';
            END;
        END;
    //++ #9804
    end;
    local procedure ActualizarCosteCalculado()
    begin
        "Coste Calculado":="Quantity per" * CosteUnitario;
    end;
    procedure CalcItemStandardCost(BOMComponent: Record 90)ReturnItemUnitCost: Decimal var
        Resource: Record 156;
    begin
        //-- #9766
        CLEAR(ReturnItemUnitCost);
        CASE BOMComponent.Type OF BOMComponent.Type::Item: BEGIN
            Item.RESET;
            IF Item.GET(BOMComponent."No.")THEN ReturnItemUnitCost:=Item."Standard Cost";
        END;
        BOMComponent.Type::Resource: BEGIN
            Resource.RESET;
            IF Resource.GET(BOMComponent."No.")THEN ReturnItemUnitCost:=Resource."Unit Cost";
        END;
        END;
        EXIT(ReturnItemUnitCost);
    //++ #9766
    end;
    procedure ActualizarRecetaCascada()
    var
        ComponentesEvento2: Record 50014;
        BOMComponent: Record 90;
        ItemSub: Record 27;
        LineasEvento: Record 50002;
    begin
        IF Type <> Type::Item THEN EXIT;
        // OBtenemos receta de la línea en curso
        Item.GET("No.");
        Item.CALCFIELDS("Assembly BOM");
        IF NOT Item."Assembly BOM" THEN EXIT;
        Item.TESTFIELD("Lote Receta");
        // Buscamos componentes evento de este producto y actualizamos cantidades
        ComponentesEvento2.RESET;
        ComponentesEvento2.SETRANGE("Codigo Evento", "Codigo Evento");
        ComponentesEvento2.SETRANGE("Linea Evento", "Linea Evento");
        ComponentesEvento2.SETRANGE("Parent Item No.", "No.");
        //ComponentesEvento2.SETRANGE(Type, ComponentesEvento2.Type::Item);
        IF NOT ComponentesEvento2.FINDFIRST THEN BEGIN
        //LineasEvento.InsertaComponentes(ComponentesEvento);
        END
        ELSE
        BEGIN
            //SL desde aca 813
            REPEAT ComponentesEvento2.CantidadPorLoteAnterior:=ComponentesEvento2."Cantidad por Lote";
                //SL Ajuste de cantidad por lote en cascada
                // IF ComponentesEvento2."Cantidad por Lote" = 0 THEN BEGIN
                // Buscamos la receta original
                IF BOMComponent.GET(ComponentesEvento2."Parent Item No.", ComponentesEvento2."Line No.")THEN BEGIN
                    //SL Teams Javier 20250723->10:54
                    IF BOMComponent."No." <> ComponentesEvento2."No." THEN //ERROR('No encuentra línea de receta para %1, %2', ComponentesEvento2."Parent Item No.", ComponentesEvento2."Line No.");
                        exit;
                    //if BOMComponent."No." = ComponentesEvento2."No." THEN
                    //SL Teams Javier 20250723<-10:54
                    // Actualizamos cantidad en base a la cantidad por lote
                    ComponentesEvento2.VALIDATE("Cantidad por Lote", (Rec."Cantidad por Lote" * BOMComponent."Cantidad por Lote" / Item."Lote Receta"));
                END
                ELSE
                BEGIN
                    ComponentesEvento2.VALIDATE("Cantidad por Lote", ComponentesEvento2."Cantidad por Lote" * (Rec."Cantidad por Lote" / xRec."Cantidad por Lote"));
                END;
                //  END ELSE BEGIN
                //
                // IF (xRec."Cantidad por Lote" = 0) THEN begin
                //     xRec."Cantidad por Lote" := Rec.CantidadPorLoteAnterior;
                //      ComponentesEvento2.VALIDATE("Cantidad por Lote", ComponentesEvento2."Cantidad por Lote" * (Rec."Cantidad por Lote" / xRec."Cantidad por Lote"));
                // end;
                //              
                // END;
                //SL hasta aca 848
                /*
                    // Si un componente es LM que genere la actualización correspondiente
                    IF ComponentesEvento2.Type = ComponentesEvento2.Type::Item THEN
                    BEGIN
                      ItemSub.GET(ComponentesEvento2."No.");
                      ItemSub.CALCFIELDS("Assembly BOM");
                      IF ItemSub."Assembly BOM" THEN
                        ComponentesEvento2.ActualizarRecetaCascada;
                    END;
                */
                ComponentesEvento2.MODIFY(TRUE);
            UNTIL ComponentesEvento2.NEXT = 0;
        END;
    end;
    procedure ActualizarRecetaCascada2()
    var
        ComponentesEvento2: Record 50014;
        BOMComponent: Record 90;
        ItemSub: Record 27;
        LineasEvento: Record 50002;
    begin
        IF Type <> Type::Item THEN EXIT;
        // OBtenemos receta de la línea en curso
        Item.GET("No.");
        Item.CALCFIELDS("Assembly BOM");
        IF NOT Item."Assembly BOM" THEN EXIT;
        Item.TESTFIELD("Lote Receta");
        // Buscamos componentes evento de este producto y actualizamos cantidades
        ComponentesEvento2.RESET;
        ComponentesEvento2.SETRANGE("Codigo Evento", "Codigo Evento");
        ComponentesEvento2.SETRANGE("Linea Evento", "Linea Evento");
        ComponentesEvento2.SETRANGE("Parent Item No.", "No.");
        //ComponentesEvento2.SETRANGE(Type, ComponentesEvento2.Type::Item);
        IF NOT ComponentesEvento2.FINDFIRST THEN BEGIN
        //LineasEvento.InsertaComponentes(ComponentesEvento);
        END
        ELSE
        BEGIN
            REPEAT ComponentesEvento2.CantidadPorLoteAnterior:=ComponentesEvento2."Cantidad por Lote";
                IF ComponentesEvento2."Cantidad por Lote" = 0 THEN BEGIN
                    // Buscamos la receta original
                    IF BOMComponent.GET(ComponentesEvento2."Parent Item No.", ComponentesEvento2."Line No.")THEN BEGIN
                        IF BOMComponent."No." <> ComponentesEvento2."No." THEN ERROR('No encuentra línea de receta para %1, %2', ComponentesEvento2."Parent Item No.", ComponentesEvento2."Line No.");
                        // Actualizamos cantidad en base a la cantidad por lote
                        ComponentesEvento2.VALIDATE("Cantidad por Lote", (Rec."Cantidad por Lote" * BOMComponent."Cantidad por Lote" / Item."Lote Receta"));
                    END
                    ELSE
                    BEGIN
                        ComponentesEvento2.VALIDATE("Cantidad por Lote", ComponentesEvento2."Cantidad por Lote" * (Rec."Cantidad por Lote" / xRec."Cantidad por Lote"));
                    END;
                END
                ELSE
                BEGIN
                    IF(xRec."Cantidad por Lote" = 0)THEN xRec."Cantidad por Lote":=Rec.CantidadPorLoteAnterior;
                    ComponentesEvento2.VALIDATE("Cantidad por Lote", ComponentesEvento2."Cantidad por Lote" * (Rec."Cantidad por Lote" / xRec."Cantidad por Lote"));
                END;
                /*
                    // Si un componente es LM que genere la actualización correspondiente
                    IF ComponentesEvento2.Type = ComponentesEvento2.Type::Item THEN
                    BEGIN
                      ItemSub.GET(ComponentesEvento2."No.");
                      ItemSub.CALCFIELDS("Assembly BOM");
                      IF ItemSub."Assembly BOM" THEN
                        ComponentesEvento2.ActualizarRecetaCascada;
                    END;
                */
                ComponentesEvento2.MODIFY(TRUE);
            UNTIL ComponentesEvento2.NEXT = 0;
        END;
    end;
    procedure DeleteSubComponentes()
    var
        ComponentesEvento: Record 50014;
    begin
        //++ KR 25/11/21 - eventos
        // Buscamos componentes hijos
        ComponentesEvento.RESET;
        ComponentesEvento.SETRANGE("Codigo Evento", Rec."Codigo Evento");
        ComponentesEvento.SETRANGE("Linea Evento", Rec."Linea Evento");
        ComponentesEvento.SETRANGE("Parent Item No.", Rec."No.");
        ComponentesEvento.DELETEALL(TRUE);
    //--
    end;
    local procedure GetUnitOfMeasurmentPer(VarItemNo: Code[20]; VarUnitOfMeasurmentCode: Code[20])ReturnFactor: Decimal var
        ItemUnitofMeasure: Record 5404;
    begin
        //-- #10652
        CLEAR(ReturnFactor);
        ItemUnitofMeasure.RESET;
        ItemUnitofMeasure.SETRANGE("Item No.", VarItemNo);
        ItemUnitofMeasure.SETRANGE(Code, VarUnitOfMeasurmentCode);
        IF ItemUnitofMeasure.FINDFIRST THEN ReturnFactor:=ItemUnitofMeasure."Qty. per Unit of Measure"
        ELSE
            ReturnFactor:=1;
    //++ #10652
    end;
    procedure ActualizarImportancia()
    var
        Item: Record Item;
    begin
        //-- #9804
        Item.GET(Rec."Parent Item No.");
        Item.ActualizarImportanciaEnCosteEventos(Rec."Codigo Evento", Rec."Linea Evento", Rec."Parent Item No.");
    //++ #9804
    end;
    var nro: Integer;
}
