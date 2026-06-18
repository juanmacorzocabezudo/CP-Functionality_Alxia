table 50004 Evento
{
    // ADVANCE - Log de cambios
    // -----------------------------------------------------
    //   ADVANCE
    //   Fecha: 03-06-2016
    //   Técnico: JMAP
    //   Presupuesto: I002693 - Seguridad comerciales vean su equipo
    //   Modificación:
    // 
    //   Etiqueta: ADV001
    // -----------------------------------------------------
    //   ADVANCE
    //   Fecha: 27-06-2016
    //   Técnico: JMAP
    //   Presupuesto: I002815 - Ampliación y nuevos campos en Eventos
    //   Modificación:
    //   Etiqueta: ADV002
    // -----------------------------------------------------
    //   ADVANCE
    //   Fecha: 30-06-2016
    //   Técnico: JMAP
    //   Presupuesto: I002835 - Oferta Mes sin IVA en Eventos
    //   Modificación: Modificacion del proceso de calculo para que tenga en cuenta la ofera mes sin IVA
    //   Etiqueta: ADV003
    // -----------------------------------------------------
    //   ADVANCE
    //   Fecha: 09-03-2017
    //   Técnico: JAB
    //   Presupuesto: I004050 - Recálculo Costes Eventos
    //   Modificación: Recalcular los costes indirectos que se imputan al evento para tener en cuenta el
    //                 desglose realizado en Menaje, Suplementos y Pan, para repartirlo entre los Menús
    //                 Adulto, Niño y Especial.
    //   Etiqueta: ADV004
    // -----------------------------------------------------
    //   ADVANCE
    //   Fecha: 15-03-2017
    //   Técnico: JAB
    //   Presupuesto: I004084 - No Recalcular Precio Propuesto
    //   Modificación: No debe de recalcular el precio propuesto si ya ha sido calculado con anterioridad.
    //   Etiqueta: ADV005
    // -----------------------------------------------------
    //   ADVANCE
    //   Fecha: 22-03-2017
    //   Técnico: JAB
    //   Presupuesto: I004142 - Importe Total Evento
    //   Modificación: El precio real de los tres nuevos apartados debe tenerse en cuenta para el importe total del evento.
    //   Etiqueta: ADV006
    // -----------------------------------------------------
    //   ADVANCE
    //   Fecha: 22-03-2017
    //   Técnico: JAB
    //   Presupuesto: I004143 - Cálculo del precio propuesto
    //   Modificación: Cálculo del precio propuesto:
    //                 CD + CI = CT
    //                 CT / UNIDADES = CU
    //                 CU + MARGEN = PRECIO PROPUESTO
    //                 PRECIO REAL SE INFORMA MANUALMENTE.
    //                 Eliminar todas las demás variables que puedan estar afectando en el cálculo actualmente.
    //   Etiqueta: ADV007
    // -----------------------------------------------------
    //   ADVANCE
    //   Fecha: 23-05-2017
    //   Técnico: JAB
    //   Presupuesto: I004502 - Revisar Mes sin IVA en tabla Productos Evento
    //   Modificación: Revisar el cálculo que se hace del mes sin IVA para que tenga en cuenta la nueva tabla de
    //                 Productos Evento (Tabla 50016).
    //   Etiqueta: ADV008
    // -----------------------------------------------------
    //   ADVANCE
    //   Fecha: 07-02-2018
    //   Técnico: ESP
    //   Presupuesto: I006638 - Traspasar líneas eventos a pdos. de venta (suplementos, pan y menaje desechable)
    //   Etiqueta: ADV009
    // -----------------------------------------------------
    //   ADVANCE
    //   Fecha: 28-02-2018
    //   Técnico: ESP
    //   Presupuesto: I006938 - Informar CIF al validar cliente o contacto
    //   Etiqueta: ADV010
    // -----------------------------------------------------
    //   ADVANCE
    //   Fecha: 28-12-2018
    //   Técnico: CPL
    //   Presupuesto: Que al borrar el cliente y borrar contacto y dejarlo vacio que no borre todos los datos.
    //   Etiqueta: ADV011
    // -----------------------------------------------------
    //   ADVANCE
    //   Fecha: 22-10-2020
    //   Técnico: RVM
    //   Presupuesto: I015307 - Exportación datos evento
    //   Modificación: Al eliminar el evento eliminar el producto del evento
    //   Etiqueta: ADV012
    // -----------------------------------------------------
    LookupPageID = 50004;

    fields
    {
        field(1; "Codigo Evento"; Code[20])
        {
            trigger OnValidate()
            begin
                IF "Codigo Evento" <> xRec."Codigo Evento" THEN BEGIN
                    SalesSetup.GET;
                    NoSeriesMgt.TestManual(SalesSetup."Serie Eventos", "Codigo Evento");
                    "No. Series" := '';
                END;
            end;
        }
        field(2; Estado; Option)
        {
            OptionCaption = 'Presupuesto,Aceptado,Rechazado,Anulado,Realizado,Archivado,En proceso';
            OptionMembers = Presupuesto,Aceptado,Rechazado,Anulado,Realizado,Archivado,EnProceso;
        }
        field(3; "Tipo Evento"; Code[20])
        {
            TableRelation = "Tipo de Evento".Codigo;

            trigger OnValidate()
            begin
                lfu_CalculaPan;
            end;
        }
        field(4; Descripcion; Text[2048])
        {
            Caption = 'Descripción';
        }
        field(5; Telefono; Code[2048])
        {
            Caption = 'Teléfono Cliente';
            ExtendedDatatype = PhoneNo;
        }
        field(6; "Telefono 2"; Code[2048])
        {
            Caption = 'Teléfono Evento';
            ExtendedDatatype = PhoneNo;
        }
        field(7; Direccion; Text[2048])
        {
            Caption = 'Dirección Cliente';
        }
        field(8; "Direccion 2"; Text[2048])
        {
            Caption = 'Dirección Evento';
        }
        field(9; "CIF/NIF"; Code[20])
        {
        }
        field(10; "Codigo Postal"; Code[20])
        {
            Caption = 'Código Postal Cliente';
            TableRelation = "Post Code".Code;

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode(Poblacion, "Codigo Postal", Provincia, "Cod Pais", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(11; Provincia; Text[30])
        {
            TableRelation = Area.Text;
            ValidateTableRelation = false;
        }
        field(12; "Codigo Cliente"; Code[20])
        {
            Caption = 'Código Cliente';
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                UpdateCust;
            end;
        }
        field(13; "Persona de Contacto"; Text[100])
        {
            Caption = 'Nombre Cliente';
        }
        field(14; "Plantilla Cliente"; Code[20])
        {
            TableRelation = "Customer Templ.".Code;
        }
        field(15; "Hora Evento"; Time)
        {
            trigger OnValidate()
            begin
                IF ("Hora Evento" >= 070100T) AND ("Hora Evento" < 100100T) THEN
                    "Franja horaria" := "Franja horaria"::Desayuno
                ELSE IF ("Hora Evento" >= 100100T) AND ("Hora Evento" < 130100T) THEN
                    "Franja horaria" := "Franja horaria"::Almuerzo
                ELSE IF ("Hora Evento" >= 130100T) AND ("Hora Evento" < 170100T) THEN
                    "Franja horaria" := "Franja horaria"::Comida
                ELSE IF ("Hora Evento" >= 170100T) AND ("Hora Evento" < 193100T) THEN
                    "Franja horaria" := "Franja horaria"::Merienda
                ELSE IF ("Hora Evento" >= 193100T) AND ("Hora Evento" < 223100T) THEN
                    "Franja horaria" := "Franja horaria"::Cena
                ELSE IF (("Hora Evento" >= 223100T) AND ("Hora Evento" <= 235959T)) OR (("Hora Evento" >= 000000T) AND ("Hora Evento" < 010100T)) THEN
                    "Franja horaria" := "Franja horaria"::Recena
                ELSE IF ("Hora Evento" >= 010100T) AND ("Hora Evento" < 070100T) THEN
                    "Franja horaria" := "Franja horaria"::Madrugada
                ELSE
                    "Franja horaria" := "Franja horaria"::" ";
            end;
        }
        field(16; "Total Adultos"; Integer)
        {
            trigger OnValidate()
            begin
                lfu_CalculaPan;
                //si hay líneas aviso
                gt_lineas2.RESET;
                gt_lineas2.SETRANGE(gt_lineas2."Codigo Evento", Rec."Codigo Evento");
                IF gt_lineas2.FINDSET THEN MESSAGE('Recuerde que tiene que repasar las líneas de evento para que el número de comensales coincida');
            end;
        }
        field(17; "Total Ninos"; Integer)
        {
            Caption = 'Total Niños';

            trigger OnValidate()
            begin
                lfu_CalculaPan;
                //si hay líneas aviso
                gt_lineas2.RESET;
                gt_lineas2.SETRANGE(gt_lineas2."Codigo Evento", Rec."Codigo Evento");
                IF gt_lineas2.FINDSET THEN MESSAGE('Recuerde que tiene que repasar las líneas de evento para que el número de comensales coincida');
            end;
        }
        field(18; "% Beneficio"; Decimal)
        {
        }
        field(19; "Coste Total"; Decimal)
        {
            CalcFormula = Sum("Lineas Evento"."Coste Total" WHERE("Codigo Evento" = FIELD("Codigo Evento")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(20; "Coste Menu Adulto"; Decimal)
        {
            CalcFormula = Sum("Lineas Evento"."Coste Total Unitario" WHERE("Codigo Evento" = FIELD("Codigo Evento"), Tipo = CONST(Adulto)));
            Caption = 'Coste Menú Adulto';
            Editable = false;
            FieldClass = FlowField;
        }
        field(21; "Coste Menu Nino"; Decimal)
        {
            CalcFormula = Sum("Lineas Evento"."Coste Total Unitario" WHERE("Codigo Evento" = FIELD("Codigo Evento"), Tipo = CONST(Niño)));
            Caption = 'Coste Menú Niño';
            Editable = false;
            FieldClass = FlowField;
        }
        field(22; "Coste Menu Otros"; Decimal)
        {
            CalcFormula = Sum("Lineas Evento"."Coste Total Unitario" WHERE("Codigo Evento" = FIELD("Codigo Evento"), Tipo = CONST(Otros)));
            Caption = 'Coste Menú Especial';
            Editable = false;
            FieldClass = FlowField;
        }
        field(23; "Precio Menu Adulto"; Decimal)
        {
            CalcFormula = Sum("Lineas Evento".ImportePorPersona WHERE("Codigo Evento" = FIELD("Codigo Evento"), Tipo = CONST(Adulto)));
            Caption = 'Precio Menú Adulto';
            Editable = false;
            FieldClass = FlowField;
        }
        field(24; "Precio Menu Nino"; Decimal)
        {
            CalcFormula = Sum("Lineas Evento".ImportePorPersona WHERE("Codigo Evento" = FIELD("Codigo Evento"), Tipo = CONST(Niño)));
            Caption = 'Precio Menú Niño';
            Editable = false;
            FieldClass = FlowField;
        }
        field(25; "Precio Otros Menus"; Decimal)
        {
            CalcFormula = Sum("Lineas Evento".ImportePorPersona WHERE("Codigo Evento" = FIELD("Codigo Evento"), Tipo = CONST(Otros)));
            Caption = 'Precio Menú Especial';
            Editable = false;
            FieldClass = FlowField;
        }
        field(26; "Importe Total Evento"; Decimal)
        {
            Editable = false;
        }
        field(27; "Importe Total IVA Incluido"; Decimal)
        {
            Editable = false;
        }
        field(28; "Coste Total Elaboracion"; Decimal)
        {
            CalcFormula = Sum("Componentes Evento"."Coste Lote" WHERE("Codigo Evento" = FIELD("Codigo Evento"), Intermedio = const(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(29; "Coste Total Recursos"; Decimal)
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(30; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(31; "Fecha Evento"; Date)
        {
        }
        field(32; Poblacion; Text[30])
        {
            trigger OnValidate()
            begin
                //PostCode.ValidateCity(
                //  Poblacion, "Codigo Postal", Provincia, "Cod Pais", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(33; Senalizado; Boolean)
        {
            Caption = 'Señalizado';
        }
        field(34; "Imp Senal"; Decimal)
        {
            Caption = 'Importe Señal';
        }
        field(35; Contratado; Boolean)
        {
        }
        field(36; "Motivo Anulacion"; Text[1024])
        {
            Caption = 'Motivo Anulación';
        }
        field(37; "Variedad Evento"; Code[20])
        {
            TableRelation = "Variedad de Evento";

            trigger OnValidate()
            begin
                lfu_CalculaPan;
            end;
        }
        field(38; "Persona de Contacto 2"; Text[1024])
        {
            Caption = 'Persona de Contacto Evento';
        }
        field(39; "E-Mail"; Text[80])
        {
            Caption = 'E-Mail Cliente';
        }
        field(40; "E-Mail 2"; Text[1024])
        {
            Caption = 'E-Mail Evento';
        }
        field(41; "Codigo Contacto"; Code[20])
        {
            TableRelation = Contact;

            trigger OnLookup()
            begin
                IF ("Codigo Cliente" <> '') AND Cont.GET("Codigo Contacto") THEN
                    Cont.SETRANGE("Company No.", Cont."Company No.")
                ELSE IF Cust.GET("Codigo Cliente") THEN BEGIN
                    ContBusinessRelation.RESET;
                    ContBusinessRelation.SETCURRENTKEY("Link to Table", "No.");
                    ContBusinessRelation.SETRANGE("Link to Table", ContBusinessRelation."Link to Table"::Customer);
                    ContBusinessRelation.SETRANGE("No.", "Codigo Cliente");
                    IF ContBusinessRelation.FINDFIRST THEN Cont.SETRANGE("Company No.", ContBusinessRelation."Contact No.");
                END
                ELSE
                    Cont.SETFILTER("Company No.", '<>''''');
                IF "Codigo Contacto" <> '' THEN IF Cont.GET("Codigo Contacto") THEN;
                IF PAGE.RUNMODAL(0, Cont) = ACTION::LookupOK THEN BEGIN
                    xRec := Rec;
                    VALIDATE("Codigo Contacto", Cont."No.");
                END;
            end;

            trigger OnValidate()
            begin
                IF ("Codigo Contacto" <> xRec."Codigo Contacto") AND (xRec."Codigo Contacto" <> '') THEN
                    IF ("Codigo Contacto" = '') AND ("Codigo Cliente" = '') THEN BEGIN
                        //INIT;
                        "No. Series" := xRec."No. Series";
                        VALIDATE(Descripcion, xRec.Descripcion);
                    END;
                IF ("Codigo Cliente" <> '') AND ("Codigo Contacto" <> '') THEN BEGIN
                    Cont.GET("Codigo Contacto");
                    ContBusinessRelation.RESET;
                    ContBusinessRelation.SETCURRENTKEY("Link to Table", "No.");
                    ContBusinessRelation.SETRANGE("Link to Table", ContBusinessRelation."Link to Table"::Customer);
                    ContBusinessRelation.SETRANGE("No.", "Codigo Cliente");
                    IF ContBusinessRelation.FINDFIRST THEN IF ContBusinessRelation."Contact No." <> Cont."Company No." THEN ERROR(Text005, Cont."No.", Cont.Name, "Codigo Cliente");
                END;
                UpdateBillToCust("Codigo Contacto");
            end;
        }
        field(42; Comentario; Text[2048])
        {
        }
        field(43; "Cod Teminos Pago"; Code[10])
        {
            Caption = 'Payment Terms Code';
            TableRelation = "Payment Terms";
        }
        field(44; "Cod Forma Pago"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";

            trigger OnValidate()
            var
                PaymentMethod: Record 289;
            begin
            end;
        }
        field(45; Barras; Decimal)
        {
            Editable = false;
        }
        field(46; Gallegas; Decimal)
        {
            Editable = false;
        }
        field(47; Colines; Decimal)
        {
            Editable = false;
        }
        field(48; Alcachofas; Decimal)
        {
            Editable = false;
        }
        field(49; "Importe Barras"; Decimal)
        {
            Editable = false;
        }
        field(50; "Importe Pan Gallego"; Decimal)
        {
            Editable = false;
        }
        field(51; "Importe Colines"; Decimal)
        {
            Editable = false;
        }
        field(52; "Importe Alcachofas"; Decimal)
        {
            Editable = false;
        }
        field(53; "Concepto Generico Facturacion"; Text[50])
        {
            Caption = 'Concepto Genérico Facturación';
        }
        field(54; "Cod Pais"; Code[10])
        {
            Caption = 'Cód. País';
            TableRelation = "Country/Region";
        }
        field(55; Vehiculo; Code[20])
        {
            Enabled = false;
            TableRelation = Resource;
        }
        field(56; CodVendedor; Code[10])
        {
            Caption = 'Codigo Vendedor';
            TableRelation = "Salesperson/Purchaser";

            trigger OnValidate()
            var
                lt_Vendedor: Record "Salesperson/Purchaser";
            begin
                IF CodVendedor = '' THEN
                    "Commission %" := 0
                ELSE BEGIN
                    lt_Vendedor.GET(CodVendedor);
                    "Commission %" := lt_Vendedor."Commission %";
                END;
            end;
        }
        field(57; "Commission %"; Decimal)
        {
            Caption = 'Commission %';
            DecimalPlaces = 2 : 2;
            MaxValue = 100;
            MinValue = 0;
        }
        /*    field(58; ComoNosConociste; Option)
           {
               Caption = 'Como nos conociste';
               OptionMembers = " ","Anuncio de publicidad en papel","Recomendación de un conocido","Publicidad en nuestros vehículos","A través de una campaña de mailing (email publicitario)","A través de Internet (Google)","A través de Internet (Twitter/Facebook)","Anuncio en Radio","En un evento al que asistió Comidas Populares","Otro (especifícalo en comentarios)","Cliente de fiel (habitual)","A través de un RRPP","A través de Lead Catering","A través de WEB Comidas Populares","A través de WEB Paellas Gigantes CP","A través de la WEB SELEKTA";
           } */
        field(58; ComoNosConocisteText; Text[250])
        {
            Caption = 'Como nos conociste';
            TableRelation = AlxiaComonosconociste.Valor;
        }
        field(59; FechaAlta; Date)
        {
            Caption = 'Fecha alta';
            Editable = false;
        }
        field(60; "Evento Origen"; Code[20])
        {
            TableRelation = Evento;
        }
        field(61; "Franja horaria"; Option)
        {
            Editable = false;
            OptionMembers = " ",Desayuno,Almuerzo,Comida,Merienda,Cena,Recena,Madrugada;
        }
        field(62; "Doble Pan"; Boolean)
        {
        }
        field(63; "Nada Pan"; Boolean)
        {
        }
        field(64; "Observaciones Internas"; Text[250])
        {
        }
        field(65; "Codigo Postal 2"; Code[20])
        {
            Caption = 'Código Postal Evento';
            TableRelation = "Post Code".Code;

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode("Poblacion 2", "Codigo Postal 2", "Provincia 2", "Cod Pais", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(66; "Poblacion 2"; Text[30])
        {
            Caption = 'Población Evento';
        }
        field(67; "Provincia 2"; Text[30])
        {
            Caption = 'Provincia Evento';
            TableRelation = Area.Text;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                // PostCode.ValidateCity(
                //   "Poblacion 2", "Codigo Postal 2", "Provincia 2", "Cod Pais", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(68; EquipoVendedor; Code[10])
        {
            CalcFormula = Min("Team Salesperson"."Team Code" WHERE("Salesperson Code" = FIELD(CodVendedor)));
            Description = 'ADV001';
            Editable = false;
            FieldClass = FlowField;
        }
        field(69; "Oferta Mes Sin IVA"; Boolean)
        {
            Description = 'ADV002';

            trigger OnValidate()
            var
                lt_LineasEvento: Record "Lineas Evento";
                lt_SalesSetup: Record "Sales & Receivables Setup";
            begin
                //ADV003 Inicio
                IF NOT "Oferta Mes Sin IVA" THEN BEGIN
                    lt_SalesSetup.GET;
                    lt_SalesSetup.TESTFIELD("Producto Oferta Mes sin IVA");
                    lt_LineasEvento.RESET;
                    lt_LineasEvento.SETRANGE("Codigo Evento", "Codigo Evento");
                    lt_LineasEvento.SETRANGE("No.", lt_SalesSetup."Producto Oferta Mes sin IVA");
                    IF lt_LineasEvento.FINDFIRST THEN IF CONFIRM(Text80000, FALSE) THEN lt_LineasEvento.DELETEALL;
                END;
                //ADV003 Fin
            end;
        }
        field(70; Comentario2; Text[250])
        {
            Caption = 'Comentario 2';
        }
        field(71; CreadoEnsamblado; Boolean)
        {
            CalcFormula = Exist("Assembly Header" WHERE(NoEvento = FIELD("Codigo Evento")));
            FieldClass = FlowField;
        }
        field(50001; "Coste Total Visualizado"; Decimal)
        {
            Description = 'ADV004';
        }
        field(50002; NuevoCosteTotalDirecto; Decimal)
        {
            Caption = 'Coste Total Directo';
            Description = 'KR';
        }
        field(50003; AGRALATraspasadoH; Boolean)
        {
            Description = '226';
        }
        field(50004; "Código Texto"; Code[20])
        {
            Caption = 'Código Texto';
            TableRelation = AlxiaTextoEventos."Código Texto";

            trigger OnValidate()
            var
                recTextoEvento: Record AlxiaTextoEventos;
            begin
                recTextoEvento.Reset();
                recTextoEvento.SetRange("Código Texto", Rec."Código Texto");
                if recTextoEvento.FindFirst() then begin
                    Rec."Descripción Texto" := recTextoEvento."Descripción Texto";
                    Rec."Texto Saludo" := recTextoEvento."Texto Saludo";
                    Rec."Texto Otras opciones" := recTextoEvento."Texto Otras opciones";
                    Rec."Texto Directrices" := recTextoEvento."Texto Directrices";
                    Rec."Texto Cliente aporta para si" := recTextoEvento."Texto Cliente aporta para si";
                    Rec."Texto Cliente aporta catering" := recTextoEvento."Texto Cliente aporta catering";
                    Rec."Texto Doc. obligatoria" := recTextoEvento."Texto Doc. obligatoria";
                    Rec."Texto Formas de pago" := recTextoEvento."Texto Formas de pago";
                    Rec."Texto Condiciones contratación" := recTextoEvento."Texto Condiciones contratación";
                    Rec."Texto Despedida" := recTextoEvento."Descripción Texto";
                end;
            end;
        }
        field(50005; "Descripción Texto"; Text[1024])
        {
            Caption = 'Descripción Texto';
        }
        field(50006; "Texto Saludo"; Text[2048])
        {
            Caption = 'Texto Saludo';
        }
        field(50007; "Texto Otras opciones"; Text[2048])
        {
            Caption = 'Texto Otras opciones';
        }
        field(50008; "Texto Directrices"; Text[2048])
        {
            Caption = 'Texto Directrices';
        }
        field(50009; "Texto Cliente aporta para si"; Text[2048])
        {
            Caption = 'Texto Cliente aporta para si';
        }
        field(50010; "Texto Cliente aporta catering"; Text[2048])
        {
            Caption = 'Texto Cliente aporta catering';
        }
        field(50011; "Texto Doc. obligatoria"; Text[2048])
        {
            Caption = 'Texto Documentación obligatoria';
        }
        field(50012; "Texto Formas de pago"; Text[2048])
        {
            Caption = 'Texto Formas de pago';
        }
        field(50013; "Texto Condiciones contratación"; Text[2048])
        {
            Caption = 'Texto Condiciones contratación';
        }
        field(50014; "Texto Despedida"; Text[2048])
        {
            Caption = 'Texto Despedida';
        }
        field(50015; "Nombre Provincia"; Text[150])
        {
            Caption = 'Nombre Provicia';
        }
        field(50016; "Nombre Provincia Evento"; Text[150])
        {
            Caption = 'Nombre Provincia Evento';
        }
        field(50017; CosteRecursosEvento; Decimal)
        {
            Caption = 'Coste Total Recursos';
            FieldClass = FlowField;
            CalcFormula = Sum("Recursos Evento"."Coste Total" WHERE("Codigo Evento" = FIELD("Codigo Evento")));
            Editable = false;
        }
        field(50018; CosteProductoEvento; Decimal)
        {
            Caption = 'Coste Total Productos';
            FieldClass = FlowField;
            CalcFormula = Sum("Productos Evento"."Coste Total" WHERE("Codigo Evento" = FIELD("Codigo Evento")));
            Editable = false;
        }
        field(50019; "Importe Rechazado"; Decimal)
        {
            Caption = 'Importe rechazado';
            //Editable = false;
        }
        // GAP00042 >>>
        // Eliminar el campo “Importe contratado”.
        /*field(50020; "Importe Contratado"; Decimal)
        {
            Caption = 'Importe contratado';
            //Editable = false;
        }*/
        // GAP00042 <<<
        field(50021; "Tipo de Impresión"; Enum AlxiaEventoTipodeImpresion)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo de impresión';
            Description = 'GAP00045';
        }
        field(50022; "Impresion Comentarios"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Impresión comentarios';
        }
        field(50023; "Importe Pedido Venta"; Integer)
        {
            Caption = 'Importe pedido de venta';
            Description = 'GAP00042';
            FieldClass = FlowField;
            AccessByPermission = TableData "Sales Header" = R;
            CalcFormula = Count("Sales Header" where("Document Type" = filter(Order), NoEvento = field("Codigo Evento")));
            Editable = false;
        }
        field(50024; "Importe Factura Venta"; Integer)
        {
            Caption = 'Importe factura de venta';
            Description = 'GAP00042';
            FieldClass = FlowField;
            AccessByPermission = TableData "Sales Invoice Line" = R;
            CalcFormula = Count("Sales Invoice Header" where(NoEvento = field("Codigo Evento")));
            Editable = false;
        }
        field(50025; "Lugar Evento 2"; Text[500])
        {
            DataClassification = ToBeClassified;
            Caption = 'Lugar del evento';
            Description = 'GAP00057';
            // Se traspasó de la extensión CP - feature.
        }
    }
    keys
    {
        key(Key1; "Codigo Evento")
        {
            Clustered = true;
        }
        key(Key2; "Fecha Evento", "Hora Evento")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnDelete()
    var
        lt_ProductosEvento: Record "Productos Evento";
    begin
        //borro todas las cosas relacionadas con el evento
        gt_lineas.RESET;
        gt_lineas.SETRANGE(gt_lineas."Codigo Evento", "Codigo Evento");
        IF gt_lineas.FINDSET THEN
            REPEAT
                gt_lineas.DELETE(TRUE);
            UNTIL gt_lineas.NEXT = 0;
        gt_recursos.RESET;
        gt_recursos.SETRANGE(gt_recursos."Codigo Evento", "Codigo Evento");
        IF gt_recursos.FINDSET THEN
            REPEAT
                gt_recursos.DELETE(TRUE);
            UNTIL gt_recursos.NEXT = 0;
        // INICIO ADV012
        lt_ProductosEvento.RESET;
        lt_ProductosEvento.SETRANGE("Codigo Evento", "Codigo Evento");
        IF lt_ProductosEvento.FINDSET THEN
            REPEAT
                lt_ProductosEvento.DELETE(TRUE);
            UNTIL lt_ProductosEvento.NEXT = 0;
        // FIN ADV012
    end;

    trigger OnInsert()
    begin
        IF "Codigo Evento" = '' THEN BEGIN
            SalesSetup.GET;
            SalesSetup.TESTFIELD("Serie Eventos");
            "Codigo Evento" := NoSeriesMgt.GetNextNo(SalesSetup."Serie Eventos", 0D, true);
            "No. Series" := SalesSetup."Serie Eventos";
        END;
        FechaAlta := TODAY;
        "Impresion Comentarios" := true;
    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit "No. Series";
        gt_lineas: Record "Lineas Evento";
        //gt_lineas: Record "Lineas Evento";
        gt_recursos: Record "Recursos Evento";
        gt_linrecurso: Record "Asignacion Recursos Eventos";
        gt_componentes: Record "Componentes Evento";
        gs_cliente: Code[20];
        gt_pedido: Record "Sales Header";
        gt_lineasventa: Record "Sales Line";
        gt_linevento: Record "Lineas Evento";
        Text012: Label 'You cannot set %1 to %2, as this %3 has set %4 to %5.';
        PostCode: Record "Post Code";
        Text006: Label 'Contact %1 %2 is not related to customer %3.';
        Cont: Record Contact;
        Cust: Record Customer;
        ContBusinessRelation: Record "Contact Business Relation";
        Text005: Label 'Contact %1 %2 is related to a different company than customer %3.';
        Text10000: Label 'Debe introducir Total Adultos y/o Total Niños.';
        GLSetup: Record "General Ledger Setup";
        //JMC 12/06/2026 Se quitan los estados archivado y en proceso
        Text20000: Label '&Presupuesto,&Aceptado,R&echazado,A&nulado,&Realizado';
        Text30000: Label 'Crear Sólo Contacto,Crear Cliente y Contacto';
        Text40000: Label 'El Contacto Nº %1 ya tiene un cliente relacionado.';
        Text50000: Label '¿Desea crear un nuevo Cliente y relacionarlo con el Contacto Nº %1?';
        Text60000: Label 'Debe crear el cliente o seleccionar uno existente.';
        Text70000: Label 'Se ha creado el el Pedido Nº %1.';
        Text80000: Label 'Existen lineas del evento con el Producto Oferta Mes sin IVA. ¿Desea eliminarlas?';
        gd_CosteRecursos: Decimal;
        gt_lineas2: Record "Lineas Evento";

    procedure AssistEdit(OldEvent: Record Evento): Boolean
    var
        Evento: Record Evento;
        NoSeriesLine: Record "No. Series Line";
    begin
        Evento := Rec;
        SalesSetup.GET;
        SalesSetup.TESTFIELD("Serie Eventos");
        IF NoSeriesMgt.LookupRelatedNoSeries(SalesSetup."Serie Eventos", OldEvent."No. Series", Rec."No. Series") THEN BEGIN
            Evento."Codigo Evento" := NoSeriesMgt.GetNextNo(Rec."No. Series", 0D, true);
            Rec := Evento;
            EXIT(TRUE);
        END;
    end;

    local procedure CrearCliente(): Code[20]
    begin
    end;

    local procedure UpdateCust()
    var
        Cust: Record Customer;
        ltContact: Record Contact;
    begin
        IF "Codigo Cliente" <> '' THEN BEGIN
            Cust.GET("Codigo Cliente");
            Cust.TESTFIELD("Customer Posting Group");
            Cust.TESTFIELD("Bill-to Customer No.", '');
            IF Cust.Blocked = Cust.Blocked::All THEN ERROR(Text012, FIELDCAPTION("Codigo Cliente"), "Codigo Cliente", Cust.TABLECAPTION, Cust.FIELDCAPTION(Blocked), Cust.Blocked);
            "Persona de Contacto" := Cust.Name;
            Direccion := Cust.Address;
            Poblacion := Cust.City;
            "Codigo Postal" := Cust."Post Code";
            Provincia := Cust.County;
            "Cod Pais" := Cust."Country/Region Code";
            Telefono := Cust."Phone No.";
            "E-Mail" := Cust."E-Mail";
            "Cod Forma Pago" := Cust."Payment Method Code";
            "Cod Teminos Pago" := Cust."Payment Terms Code";
            //inicio ADV010
            "CIF/NIF" := Cust."VAT Registration No.";
            //fin ADV010
            //SL Se agrega poblacion y provincia evento
            //"Poblacion 2" := Cust.City;
            //"Provincia 2" := Cust.County;
            //SL fin
            UpdateBillToCont("Codigo Cliente");
        END
        ELSE BEGIN
            IF "Codigo Contacto" <> '' THEN BEGIN
                ltContact.GET("Codigo Contacto");
                "Persona de Contacto" := ltContact.Name;
                Direccion := ltContact.Address;
                Poblacion := ltContact.City;
                "Codigo Postal" := ltContact."Post Code";
                Provincia := ltContact.County;
                "Cod Pais" := ltContact."Country/Region Code";
                Telefono := ltContact."Phone No.";
                "E-Mail" := ltContact."E-Mail";
                "Cod Forma Pago" := '';
                "Cod Teminos Pago" := '';
                //incio ADV010
                "CIF/NIF" := ltContact."VAT Registration No.";
                //fin ADV010
                //SL Se agrega poblacion y provincia evento
                //"Poblacion 2" := ltContact.City;
                //"Provincia 2" := ltContact.County;
                //SL fin
            END
            ELSE BEGIN
                //SL si el cliente y el contacto están vacío no borre datos y deje lo que haya
                "Persona de Contacto" := '';
                Direccion := '';
                Poblacion := '';
                "Codigo Postal" := '';
                Provincia := '';
                "Cod Pais" := '';
                Telefono := '';
                "E-Mail" := '';
                "Cod Forma Pago" := '';
                "Cod Teminos Pago" := '';
                "Poblacion 2" := '';
                "Provincia 2" := '';
                "CIF/NIF" := '';
                VALIDATE("Codigo Contacto", '');
            END;
        END;
    end;

    local procedure UpdateBillToCont(CustomerNo: Code[20])
    var
        ContBusRel: Record "Contact Business Relation";
        Cust: Record Customer;
    begin
        IF Cust.GET(CustomerNo) THEN
            IF Cust."Primary Contact No." <> '' THEN
                "Codigo Contacto" := Cust."Primary Contact No."
            ELSE BEGIN
                ContBusRel.RESET;
                ContBusRel.SETCURRENTKEY("Link to Table", "No.");
                ContBusRel.SETRANGE("Link to Table", ContBusRel."Link to Table"::Customer);
                ContBusRel.SETRANGE("No.", "Codigo Cliente");
                IF ContBusRel.FINDFIRST THEN "Codigo Contacto" := ContBusRel."Contact No.";
            END;
    end;

    local procedure UpdateBillToCust(ContactNo: Code[20])
    var
        ContBusinessRelation: Record "Contact Business Relation";
        Cust: Record Customer;
        Cont: Record Contact;
    begin
        IF Cont.GET(ContactNo) THEN
            "Codigo Contacto" := Cont."No."
        ELSE
            EXIT;
        ContBusinessRelation.RESET;
        ContBusinessRelation.SETCURRENTKEY("Link to Table", "Contact No.");
        ContBusinessRelation.SETRANGE("Link to Table", ContBusinessRelation."Link to Table"::Customer);
        ContBusinessRelation.SETRANGE("Contact No.", Cont."Company No.");
        IF ContBusinessRelation.FINDFIRST THEN BEGIN
            IF "Codigo Cliente" = '' THEN
                VALIDATE("Codigo Cliente", ContBusinessRelation."No.")
            ELSE IF "Codigo Cliente" <> ContBusinessRelation."No." THEN ERROR(Text006, Cont."No.", Cont.Name, "Codigo Cliente");
        END
        ELSE
            VALIDATE("Codigo Cliente");
    end;

    procedure gfu_CalculoCostesPrecios()
    var
        RecComp: Record "Componentes Evento";
        RecProEve: Record "Productos Evento";
        RecProEveAux: Record "Productos Evento";
        lt_LineaEventos: Record "Lineas Evento";
        lt_Componentes: Record "Componentes Evento";
        CosteMenu: Decimal;
        CosteRecursos: Decimal;
        PrecioRecursos: Decimal;
        lt_RecursosEvento: Record "Recursos Evento";
        CostePan: Decimal;
        SalesSetup: Record "Sales & Receivables Setup";
        ImpIVA: Decimal;
        lt_Item: Record Item;
        PorcIVA: Decimal;
        lt_Customer: Record Customer;
        lt_VATPostingSetup: Record "VAT Posting Setup";
        lt_CustTemplate: Record "Customer Templ.";
        NumLinea: Integer;
        lt_ProductosEvento: Record "Productos Evento";
        CosteRepartido: Decimal;
        ItemNo: Text;
    begin
        //++ KR
        SELECTLATESTVERSION;
        //--
        if (Estado = Estado::Presupuesto) or (Estado = Estado::Aceptado) or (Estado = Estado::Archivado) then begin
            IF ("Total Adultos" = 0) AND ("Total Ninos" = 0) THEN ERROR(Text10000);
            GLSetup.GET;
            //Inicio ADV004
            //ADV004 lfu_CalculaPan;
            //ADV004 CostePan := "Importe Barras" + "Importe Pan Gallego" + "Importe Colines" + "Importe Alcachofas";
            //Fin ADV004
            //ADV003 Inicio
            IF "Oferta Mes Sin IVA" THEN BEGIN
                SalesSetup.GET;
                SalesSetup.TESTFIELD("Producto Oferta Mes sin IVA");
                lt_LineaEventos.RESET;
                lt_LineaEventos.SETRANGE("Codigo Evento", "Codigo Evento");
                lt_LineaEventos.SETRANGE("No.", SalesSetup."Producto Oferta Mes sin IVA");
                lt_LineaEventos.DELETEALL;
            END;
            //ADV003 Fin
            //Coste Recursos para luego repartir
            CosteRecursos := 0;
            PrecioRecursos := 0;
            lt_RecursosEvento.RESET;
            lt_RecursosEvento.SETRANGE("Codigo Evento", "Codigo Evento");
            IF lt_RecursosEvento.FINDSET THEN
                REPEAT
                    CosteRecursos := CosteRecursos + lt_RecursosEvento."Coste Total";
                    PrecioRecursos := PrecioRecursos + lt_RecursosEvento.Importe;
                UNTIL lt_RecursosEvento.NEXT = 0;
            // Inicio ADV004
            lt_ProductosEvento.RESET;
            lt_ProductosEvento.SETRANGE("Codigo Evento", "Codigo Evento");
            IF lt_ProductosEvento.FINDSET THEN
                REPEAT
                    CosteRecursos := CosteRecursos + lt_ProductosEvento."Coste Total";
                    PrecioRecursos := PrecioRecursos + lt_ProductosEvento.Importe;
                UNTIL lt_ProductosEvento.NEXT = 0;
            //SL: Inicio
            /*  RecProEve.Reset();
             RecProEve.SetRange(RecProEve."Codigo Evento", "Codigo Evento");
             if RecProEve.FindFirst() then
                 repeat
                     RecProEveAux.Reset();
                     RecProEveAux.SetRange("Codigo Evento", RecProEve."Codigo Evento");
                     RecProEveAux.SetRange(Linea, RecProEve.Linea);
                     RecProEveAux.SetRange(Producto, RecProEve.Producto);
                     if RecProEveAux.FindFirst() then begin
                         RecProEveAux.lfu_CalculaPreciosOut(RecProEveAux);
                         RecProEveAux.Modify();
                     end;
                 until RecProEve.Next() = 0; */
            //SL: Fin
            //Fin ADV004
            // Inicio ADV004
            // Realizo u    n lectura previa de los menús Adulto, Niño y Especial para calcular el CosteMenu total y así poder hacer el reparto
            gd_CosteRecursos := CosteRecursos;
            CosteMenu := 0;
            lt_LineaEventos.RESET;
            lt_LineaEventos.SETRANGE("Codigo Evento", Rec."Codigo Evento");
            lt_LineaEventos.SETRANGE(Tipo, lt_LineaEventos.Tipo::Adulto);
            IF lt_LineaEventos.FINDSET THEN
                REPEAT
                    CosteMenu := CosteMenu + lt_LineaEventos."Coste Directo";
                UNTIL lt_LineaEventos.NEXT = 0;
            lt_LineaEventos.RESET;
            lt_LineaEventos.SETRANGE("Codigo Evento", Rec."Codigo Evento");
            lt_LineaEventos.SETRANGE(Tipo, lt_LineaEventos.Tipo::Niño);
            IF lt_LineaEventos.FINDSET THEN
                REPEAT
                    CosteMenu := CosteMenu + lt_LineaEventos."Coste Directo";
                UNTIL lt_LineaEventos.NEXT = 0;
            lt_LineaEventos.RESET;
            lt_LineaEventos.SETRANGE("Codigo Evento", Rec."Codigo Evento");
            lt_LineaEventos.SETRANGE(Tipo, lt_LineaEventos.Tipo::Otros);
            IF lt_LineaEventos.FINDSET THEN
                REPEAT
                    CosteMenu := CosteMenu + lt_LineaEventos."Coste Directo";
                UNTIL lt_LineaEventos.NEXT = 0;
            // Fin ADV004
            //Menú Adultoslt_LineaEventos.FINDSET
            //ADV004 CosteMenu := 0;
            lt_LineaEventos.RESET;
            lt_LineaEventos.SETRANGE("Codigo Evento", Rec."Codigo Evento");
            lt_LineaEventos.SETRANGE(Tipo, lt_LineaEventos.Tipo::Adulto);
            IF lt_LineaEventos.FINDSET THEN
                REPEAT
                    lt_Componentes.RESET;
                    lt_Componentes.SETCURRENTKEY("Codigo Evento", "Linea Evento", "Parent Item No.", "Line No.");
                    lt_Componentes.SETRANGE("Codigo Evento", lt_LineaEventos."Codigo Evento");
                    lt_Componentes.SETRANGE("Linea Evento", lt_LineaEventos.Linea);
                    lt_Componentes.SETRANGE("Parent Item No.", lt_LineaEventos."No.");
                    if lt_Componentes.FindFirst() then;
                    lt_Componentes.CALCSUMS("Coste Lote");
                    lt_LineaEventos."Coste Directo" := lt_Componentes."Coste Lote";
                    lt_LineaEventos.MODIFY;
                    // KR 22/11/21 Buscamos costes de hijos (se pone aquí por comodidad porque el proceso está montado para ejecutarse dos veces seguidas :) )
                    CalcularCosteLMRecursivo(lt_Componentes);
                //--
                //ADV004 CosteMenu := CosteMenu + lt_LineaEventos."Coste Directo";
                UNTIL lt_LineaEventos.NEXT = 0;
            IF lt_LineaEventos.FINDSET THEN
                REPEAT
                    IF CosteMenu <> 0 THEN BEGIN
                        lt_LineaEventos."Coste Indirecto Recursos" := ROUND((CosteRecursos) * (lt_LineaEventos."Coste Directo" / CosteMenu), GLSetup."Amount Rounding Precision");
                        //ADV004 lt_LineaEventos."Coste Indirecto Pan" := ROUND((CostePan / ("Total Adultos"+"Total Ninos")) * (lt_LineaEventos."Coste Directo" / CosteMenu),GLSetup."Amount Rounding Precision");
                        IF ("Total Adultos" + "Total Ninos") <> 0 THEN
                            lt_LineaEventos."Precio Venta Recursos" := ROUND((PrecioRecursos / ("Total Adultos" + "Total Ninos")) * (lt_LineaEventos."Coste Directo" / CosteMenu), GLSetup."Amount Rounding Precision")
                        ELSE
                            lt_LineaEventos."Precio Venta Recursos" := 0;
                    END
                    ELSE BEGIN
                        lt_LineaEventos."Coste Indirecto Recursos" := 0;
                        lt_LineaEventos."Coste Indirecto Pan" := 0;
                        lt_LineaEventos."Precio Venta Recursos" := 0;
                    END;
                    // Inicio ADV007
                    // ADV007 lt_LineaEventos."Coste Total" := lt_LineaEventos."Coste Directo" + (lt_LineaEventos."Coste Indirecto Recursos")+ (lt_LineaEventos."Coste Indirecto Pan"* lt_LineaEventos.Cantidad);
                    lt_LineaEventos."Coste Total" := lt_LineaEventos."Coste Directo" + lt_LineaEventos."Coste Indirecto Recursos";
                    lt_LineaEventos."Precio Propuesto" := 0;
                    // Fin ADV007
                    IF ("Total Adultos") <> 0 THEN
                        lt_LineaEventos."Coste Total Unitario" := lt_LineaEventos."Coste Total" / ("Total Adultos")
                    ELSE
                        lt_LineaEventos."Coste Total Unitario" := 0;
                    IF lt_LineaEventos."Tipo Margen" = lt_LineaEventos."Tipo Margen"::Importe THEN // Inicio ADV005
                        // ADV005 lt_LineaEventos."Precio Propuesto":= lt_LineaEventos."Coste Directo"  + (lt_LineaEventos.Cantidad * lt_LineaEventos."Valor Margen")
                        // ADV007 IF lt_LineaEventos."Precio Propuesto" = 0 THEN
                        // Inicio ADV007
                        // ADV007 lt_LineaEventos."Precio Propuesto":= lt_LineaEventos."Coste Directo"  + (lt_LineaEventos.Cantidad * lt_LineaEventos."Valor Margen")
                        lt_LineaEventos."Precio Propuesto" := lt_LineaEventos."Coste Total Unitario" + lt_LineaEventos."Valor Margen"
                    // Fin ADV007
                    // Fin ADV005
                    ELSE IF lt_LineaEventos."Tipo Margen" = lt_LineaEventos."Tipo Margen"::Porcentaje THEN // Inicio ADV005
                                                                                                           // ADV005 lt_LineaEventos."Precio Propuesto":= lt_LineaEventos."Coste Directo" * (1 + lt_LineaEventos."Valor Margen"/100);
                                                                                                           // ADV007 IF lt_LineaEventos."Precio Propuesto" = 0 THEN
                                                                                                           // Inicio ADV007
                                                                                                           // ADV007 lt_LineaEventos."Precio Propuesto":= lt_LineaEventos."Coste Directo" * (1 + lt_LineaEventos."Valor Margen"/100);
                        lt_LineaEventos."Precio Propuesto" := lt_LineaEventos."Coste Total Unitario" * (1 + lt_LineaEventos."Valor Margen" / 100);
                    // Fin ADV007
                    // Fin ADV005
                    // Inicio ADV005
                    // ADV005 lt_LineaEventos."Precio Propuesto" := ROUND((lt_LineaEventos."Precio Propuesto" / "Total Adultos") + lt_LineaEventos."Coste Indirecto Pan" + lt_LineaEventos."Precio Venta Recursos",GLSetup."Amount Rounding Precision");
                    // ADV007 IF lt_LineaEventos."Precio Propuesto" = 0 THEN
                    // ADV007 lt_LineaEventos."Precio Propuesto" := ROUND((lt_LineaEventos."Precio Propuesto" / "Total Adultos") + lt_LineaEventos."Coste Indirecto Pan" + lt_LineaEventos."Precio Venta Recursos",GLSetup."Amount Rounding Precision");
                    // Fin ADV005
                    //lt_LineaEventos.VALIDATE("Precio Real",lt_LineaEventos."Precio Propuesto");
                    lt_LineaEventos.MODIFY;
                UNTIL lt_LineaEventos.NEXT = 0;
            //Menú Niños
            //ADV004 CosteMenu := 0;
            lt_LineaEventos.RESET;
            lt_LineaEventos.SETRANGE("Codigo Evento", Rec."Codigo Evento");
            lt_LineaEventos.SETRANGE(Tipo, lt_LineaEventos.Tipo::Niño);
            IF lt_LineaEventos.FINDSET THEN
                REPEAT
                    lt_Componentes.RESET;
                    lt_Componentes.SETCURRENTKEY("Codigo Evento", "Linea Evento", "Parent Item No.", "Line No.");
                    lt_Componentes.SETRANGE("Codigo Evento", lt_LineaEventos."Codigo Evento");
                    lt_Componentes.SETRANGE("Linea Evento", lt_LineaEventos.Linea);
                    lt_Componentes.SETRANGE("Parent Item No.", lt_LineaEventos."No.");
                    lt_Componentes.CALCSUMS("Coste Lote");
                    lt_LineaEventos."Coste Directo" := lt_Componentes."Coste Lote";
                    lt_LineaEventos.MODIFY;
                    //ADV004 CosteMenu := CosteMenu + lt_LineaEventos."Coste Directo";
                    // KR 22/11/21 Buscamos costes de hijos
                    //lt_Componentes."Coste Lote" +=
                    CalcularCosteLMRecursivo(lt_Componentes);
                //--
                UNTIL lt_LineaEventos.NEXT = 0;
            IF lt_LineaEventos.FINDSET THEN
                REPEAT
                    IF CosteMenu <> 0 THEN BEGIN
                        lt_LineaEventos."Coste Indirecto Recursos" := ROUND(CosteRecursos * (lt_LineaEventos."Coste Directo" / CosteMenu), GLSetup."Amount Rounding Precision");
                        //ADV004 lt_LineaEventos."Coste Indirecto Pan" := ROUND((CostePan / ("Total Adultos"+"Total Ninos")) * (lt_LineaEventos."Coste Directo" / CosteMenu),GLSetup."Amount Rounding Precision");
                        IF ("Total Adultos" + "Total Ninos") <> 0 THEN
                            lt_LineaEventos."Precio Venta Recursos" := ROUND((PrecioRecursos / ("Total Adultos" + "Total Ninos")) * (lt_LineaEventos."Coste Directo" / CosteMenu), GLSetup."Amount Rounding Precision")
                        ELSE
                            lt_LineaEventos."Precio Venta Recursos" := 0;
                    END
                    ELSE BEGIN
                        lt_LineaEventos."Coste Indirecto Recursos" := 0;
                        lt_LineaEventos."Coste Indirecto Pan" := 0;
                        lt_LineaEventos."Precio Venta Recursos" := 0;
                    END;
                    // Inicio ADV007
                    // ADV007 lt_LineaEventos."Coste Total" := lt_LineaEventos."Coste Directo" + (lt_LineaEventos."Coste Indirecto Recursos" )+ (lt_LineaEventos."Coste Indirecto Pan"*lt_LineaEventos.Cantidad);
                    lt_LineaEventos."Coste Total" := lt_LineaEventos."Coste Directo" + lt_LineaEventos."Coste Indirecto Recursos";
                    lt_LineaEventos."Precio Propuesto" := 0;
                    // Fin ADV007
                    IF "Total Ninos" <> 0 THEN lt_LineaEventos."Coste Total Unitario" := lt_LineaEventos."Coste Total" / "Total Ninos";
                    IF lt_LineaEventos."Tipo Margen" = lt_LineaEventos."Tipo Margen"::Importe THEN // Inicio ADV005
                        // ADV005 lt_LineaEventos."Precio Propuesto":= lt_LineaEventos."Coste Directo"  + (lt_LineaEventos.Cantidad * lt_LineaEventos."Valor Margen")
                        // ADV007 IF lt_LineaEventos."Precio Propuesto" = 0 THEN
                        // Inicio ADV007
                        // ADV007 lt_LineaEventos."Precio Propuesto":= lt_LineaEventos."Coste Directo"  + (lt_LineaEventos.Cantidad * lt_LineaEventos."Valor Margen")
                        lt_LineaEventos."Precio Propuesto" := lt_LineaEventos."Coste Total Unitario" + lt_LineaEventos."Valor Margen"
                    // Fin ADV007
                    // Fin ADV005
                    ELSE IF lt_LineaEventos."Tipo Margen" = lt_LineaEventos."Tipo Margen"::Porcentaje THEN // Inicio ADV005
                                                                                                           // ADV005 lt_LineaEventos."Precio Propuesto":= lt_LineaEventos."Coste Directo" * (1 + lt_LineaEventos."Valor Margen"/100);
                                                                                                           // ADV007 IF lt_LineaEventos."Precio Propuesto" = 0 THEN
                                                                                                           // Inicio ADV007
                                                                                                           // ADV007 lt_LineaEventos."Precio Propuesto":= lt_LineaEventos."Coste Directo" * (1 + lt_LineaEventos."Valor Margen"/100);
                        lt_LineaEventos."Precio Propuesto" := lt_LineaEventos."Coste Total Unitario" * (1 + lt_LineaEventos."Valor Margen" / 100);
                    // Fin ADV007
                    // Fin ADV005
                    // Inicio ADV005
                    // ADV005 lt_LineaEventos."Precio Propuesto" := ROUND((lt_LineaEventos."Precio Propuesto"  / "Total Ninos") + lt_LineaEventos."Coste Indirecto Pan" + lt_LineaEventos."Precio Venta Recursos",GLSetup."Amount Rounding Precision");
                    // ADV007 IF lt_LineaEventos."Precio Propuesto" = 0 THEN
                    // ADV007 lt_LineaEventos."Precio Propuesto" := ROUND((lt_LineaEventos."Precio Propuesto"  / "Total Ninos") + lt_LineaEventos."Coste Indirecto Pan" + lt_LineaEventos."Precio Venta Recursos",GLSetup."Amount Rounding Precision");
                    // Fin ADV005
                    //lt_LineaEventos.VALIDATE("Precio Real",lt_LineaEventos."Precio Propuesto");
                    lt_LineaEventos.MODIFY;
                UNTIL lt_LineaEventos.NEXT = 0;
            //Menú Otros
            // ADV004 - Comento todo lo referente al Menú Otros para rehacerlo igual que el Menú Adulto y Menú Niño
            /*
            lt_LineaEventos.RESET;
            lt_LineaEventos.SETRANGE("Codigo Evento",Rec."Codigo Evento");
            lt_LineaEventos.SETFILTER(Tipo,'%1|%2',lt_LineaEventos.Tipo::Adulto, lt_LineaEventos.Tipo::Niño);
            IF NOT lt_LineaEventos.ISEMPTY THEN BEGIN
              lt_LineaEventos.RESET;
              lt_LineaEventos.SETRANGE("Codigo Evento",Rec."Codigo Evento");
              lt_LineaEventos.SETRANGE(Tipo, lt_LineaEventos.Tipo::Otros);
              IF lt_LineaEventos.FINDSET THEN
                REPEAT
                  lt_Componentes.RESET;
                  lt_Componentes.SETCURRENTKEY("Codigo Evento","Linea Evento","Parent Item No.","Line No.");
                  lt_Componentes.SETRANGE("Codigo Evento",lt_LineaEventos."Codigo Evento");
                  lt_Componentes.SETRANGE("Linea Evento",lt_LineaEventos.Linea);
                  lt_Componentes.SETRANGE("Parent Item No.",lt_LineaEventos."No.");
                  lt_Componentes.CALCSUMS("Coste Lote");
                  lt_LineaEventos."Coste Directo" := lt_Componentes."Coste Lote";
                  lt_LineaEventos."Coste Indirecto Recursos" := 0;
                  lt_LineaEventos."Coste Indirecto Pan" := 0;
                  lt_LineaEventos."Coste Total" := lt_LineaEventos."Coste Directo" + lt_LineaEventos."Coste Indirecto Recursos";
                  lt_LineaEventos."Coste Total Unitario"  := lt_LineaEventos."Coste Total" / ("Total Adultos" + "Total Ninos");
                  IF lt_LineaEventos."Tipo Margen" = lt_LineaEventos."Tipo Margen"::Porcentaje THEN
                    lt_LineaEventos."Precio Propuesto" := ROUND((lt_LineaEventos."Coste Directo"  + (lt_LineaEventos.Cantidad * lt_LineaEventos."Valor Margen"))/("Total Adultos" + "Total Ninos"),GLSetup."Amount Rounding Precision")
                  ELSE IF lt_LineaEventos."Tipo Margen" = lt_LineaEventos."Tipo Margen"::Porcentaje THEN
                    lt_LineaEventos."Precio Propuesto":= ROUND((lt_LineaEventos."Coste Directo" * (1 + lt_LineaEventos."Valor Margen"/100)) / ("Total Adultos" + "Total Ninos"),GLSetup."Amount Rounding Precision");
                  //lt_LineaEventos.VALIDATE("Precio Real",lt_LineaEventos."Precio Propuesto");
                  lt_LineaEventos.MODIFY;
                UNTIL lt_LineaEventos.NEXT = 0;
            END ELSE BEGIN
              //ADV004 CosteMenu := 0;
              lt_LineaEventos.RESET;
              lt_LineaEventos.SETRANGE("Codigo Evento",Rec."Codigo Evento");
              lt_LineaEventos.SETRANGE(Tipo, lt_LineaEventos.Tipo::Otros);
              IF lt_LineaEventos.FINDSET THEN
                REPEAT
                  lt_Componentes.RESET;
                  lt_Componentes.SETCURRENTKEY("Codigo Evento","Linea Evento","Parent Item No.","Line No.");
                  lt_Componentes.SETRANGE("Codigo Evento",lt_LineaEventos."Codigo Evento");
                  lt_Componentes.SETRANGE("Linea Evento",lt_LineaEventos.Linea);
                  lt_Componentes.SETRANGE("Parent Item No.",lt_LineaEventos."No.");
                  lt_Componentes.CALCSUMS("Coste Lote");
                  lt_LineaEventos."Coste Directo" := lt_Componentes."Coste Lote";
                  lt_LineaEventos.MODIFY;
                  //ADV004 CosteMenu := CosteMenu + lt_LineaEventos."Coste Directo";
                UNTIL lt_LineaEventos.NEXT = 0;
              IF lt_LineaEventos.FINDSET THEN
                REPEAT
                  IF CosteMenu <> 0 THEN BEGIN
                    lt_LineaEventos."Coste Indirecto Recursos" := ROUND((CosteRecursos ) * (lt_LineaEventos."Coste Directo" / CosteMenu),GLSetup."Amount Rounding Precision");
                    //ADV004 lt_LineaEventos."Coste Indirecto Pan" := ROUND((CostePan / ("Total Adultos"+"Total Ninos")) * (lt_LineaEventos."Coste Directo" / CosteMenu),GLSetup."Amount Rounding Precision");
                    lt_LineaEventos."Precio Venta Recursos" := ROUND((PrecioRecursos / ("Total Adultos"+"Total Ninos")) * (lt_LineaEventos."Coste Directo" / CosteMenu),GLSetup."Amount Rounding Precision");
                  END ELSE BEGIN
                    lt_LineaEventos."Coste Indirecto Recursos" := 0;
                    lt_LineaEventos."Coste Indirecto Pan" := 0;
                    lt_LineaEventos."Precio Venta Recursos" :=0;
                  END;
                  lt_LineaEventos."Coste Total" := lt_LineaEventos."Coste Directo" + (lt_LineaEventos."Coste Indirecto Recursos")+ (lt_LineaEventos."Coste Indirecto Pan"*lt_LineaEventos.Cantidad);
                  lt_LineaEventos."Coste Total Unitario"  := lt_LineaEventos."Coste Total" / ("Total Adultos" + "Total Ninos");
                  IF lt_LineaEventos."Tipo Margen" = lt_LineaEventos."Tipo Margen"::Importe THEN
                    lt_LineaEventos."Precio Propuesto":= lt_LineaEventos."Coste Directo"  + (lt_LineaEventos.Cantidad * lt_LineaEventos."Valor Margen")
                  ELSE IF lt_LineaEventos."Tipo Margen" = lt_LineaEventos."Tipo Margen"::Porcentaje THEN
                    lt_LineaEventos."Precio Propuesto":= lt_LineaEventos."Coste Directo" * (1 + lt_LineaEventos."Valor Margen"/100);
                  lt_LineaEventos."Precio Propuesto" := ROUND((lt_LineaEventos."Precio Propuesto"  / ("Total Adultos" + "Total Ninos")) + lt_LineaEventos."Coste Indirecto Pan" + lt_LineaEventos."Precio Venta Recursos",GLSetup."Amount Rounding Precision");
                  //lt_LineaEventos.VALIDATE("Precio Real",lt_LineaEventos."Precio Propuesto");
                  lt_LineaEventos.MODIFY;
                UNTIL lt_LineaEventos.NEXT = 0;
            END;
            */
            // Inicio ADV004
            // Menú Otros
            lt_LineaEventos.RESET;
            lt_LineaEventos.SETRANGE("Codigo Evento", Rec."Codigo Evento");
            lt_LineaEventos.SETRANGE(Tipo, lt_LineaEventos.Tipo::Otros);
            IF lt_LineaEventos.FINDSET THEN
                REPEAT
                    lt_Componentes.RESET;
                    lt_Componentes.SETCURRENTKEY("Codigo Evento", "Linea Evento", "Parent Item No.", "Line No.");
                    lt_Componentes.SETRANGE("Codigo Evento", lt_LineaEventos."Codigo Evento");
                    lt_Componentes.SETRANGE("Linea Evento", lt_LineaEventos.Linea);
                    lt_Componentes.SETRANGE("Parent Item No.", lt_LineaEventos."No.");
                    lt_Componentes.CALCSUMS("Coste Lote");
                    lt_LineaEventos."Coste Directo" := lt_Componentes."Coste Lote";
                    lt_LineaEventos.MODIFY;
                UNTIL lt_LineaEventos.NEXT = 0;
            IF lt_LineaEventos.FINDSET THEN
                REPEAT
                    IF CosteMenu <> 0 THEN BEGIN
                        lt_LineaEventos."Coste Indirecto Recursos" := ROUND(CosteRecursos * (lt_LineaEventos."Coste Directo" / CosteMenu), GLSetup."Amount Rounding Precision");
                        IF ("Total Adultos" + "Total Ninos") <> 0 THEN
                            lt_LineaEventos."Precio Venta Recursos" := ROUND((PrecioRecursos / ("Total Adultos" + "Total Ninos")) * (lt_LineaEventos."Coste Directo" / CosteMenu), GLSetup."Amount Rounding Precision")
                        ELSE
                            lt_LineaEventos."Precio Venta Recursos" := 0;
                    END
                    ELSE BEGIN
                        lt_LineaEventos."Coste Indirecto Recursos" := 0;
                        lt_LineaEventos."Coste Indirecto Pan" := 0;
                        lt_LineaEventos."Precio Venta Recursos" := 0;
                    END;
                    // Inicio ADV007
                    // ADV007 lt_LineaEventos."Coste Total" := lt_LineaEventos."Coste Directo" + (lt_LineaEventos."Coste Indirecto Recursos" )+ (lt_LineaEventos."Coste Indirecto Pan"*lt_LineaEventos.Cantidad);
                    lt_LineaEventos."Coste Total" := lt_LineaEventos."Coste Directo" + lt_LineaEventos."Coste Indirecto Recursos";
                    lt_LineaEventos."Precio Propuesto" := 0;
                    // Fin ADV007
                    IF ("Total Adultos" + "Total Ninos") <> 0 THEN
                        lt_LineaEventos."Coste Total Unitario" := lt_LineaEventos."Coste Total" / ("Total Adultos" + "Total Ninos")
                    ELSE
                        lt_LineaEventos."Coste Total Unitario" := 0;
                    IF lt_LineaEventos."Tipo Margen" = lt_LineaEventos."Tipo Margen"::Importe THEN // Inicio ADV005
                        // ADV005 lt_LineaEventos."Precio Propuesto":= lt_LineaEventos."Coste Directo"  + (lt_LineaEventos.Cantidad * lt_LineaEventos."Valor Margen")
                        // ADV007 IF lt_LineaEventos."Precio Propuesto" = 0 THEN
                        // Inicio ADV007
                        // ADV007 lt_LineaEventos."Precio Propuesto":= lt_LineaEventos."Coste Directo"  + (lt_LineaEventos.Cantidad * lt_LineaEventos."Valor Margen")
                        lt_LineaEventos."Precio Propuesto" := lt_LineaEventos."Coste Total Unitario" + lt_LineaEventos."Valor Margen"
                    // Fin ADV007
                    // Fin ADV005
                    ELSE IF lt_LineaEventos."Tipo Margen" = lt_LineaEventos."Tipo Margen"::Porcentaje THEN // Inicio ADV005
                                                                                                           // ADV005 lt_LineaEventos."Precio Propuesto":= lt_LineaEventos."Coste Directo" * (1 + lt_LineaEventos."Valor Margen"/100);
                                                                                                           // ADV007 IF lt_LineaEventos."Precio Propuesto" = 0 THEN
                                                                                                           // Inicio ADV007
                                                                                                           // ADV007 lt_LineaEventos."Precio Propuesto":= lt_LineaEventos."Coste Directo" * (1 + lt_LineaEventos."Valor Margen"/100);
                        lt_LineaEventos."Precio Propuesto" := lt_LineaEventos."Coste Total Unitario" * (1 + lt_LineaEventos."Valor Margen" / 100);
                    // Fin ADV007
                    // Fin ADV005
                    // Inicio ADV005
                    // ADV007 IF lt_LineaEventos."Precio Propuesto" = 0 THEN
                    // Fin ADV005
                    lt_LineaEventos.MODIFY;
                UNTIL lt_LineaEventos.NEXT = 0;
            // Fin ADV004
            lt_LineaEventos.RESET;
            lt_LineaEventos.SETRANGE("Codigo Evento", Rec."Codigo Evento");
            lt_LineaEventos.CALCSUMS(Importe, "Importe IVA Incl.");
            lt_RecursosEvento.RESET;
            lt_RecursosEvento.SETRANGE("Codigo Evento", "Codigo Evento");
            lt_RecursosEvento.CALCSUMS(Importe, "Importe IVA Incl.");
            // Inicio ADV006
            lt_ProductosEvento.RESET;
            lt_ProductosEvento.SETRANGE("Codigo Evento", "Codigo Evento");
            lt_ProductosEvento.CALCSUMS(lt_ProductosEvento.Importe, lt_ProductosEvento."Importe IVA Incl.");
            // FIn ADV006
            // Inicio ADV006
            // ADV006 Rec."Importe Total Evento" := lt_LineaEventos.Importe + lt_RecursosEvento.Importe;
            // ADV006 Rec."Importe Total IVA Incluido" := lt_LineaEventos."Importe IVA Incl." + lt_RecursosEvento."Importe IVA Incl.";
            Rec."Importe Total Evento" := lt_LineaEventos.Importe + lt_RecursosEvento.Importe + lt_ProductosEvento.Importe;
            Rec."Importe Total IVA Incluido" := lt_LineaEventos."Importe IVA Incl." + lt_RecursosEvento."Importe IVA Incl." + lt_ProductosEvento."Importe IVA Incl.";
            // Fin ADV006
            // Inicio ADV004
            Rec."Coste Total Recursos" := CosteRecursos;
            Rec."Coste Total Visualizado" := Rec."Coste Total Elaboracion" + Rec."Coste Total Recursos";
            // Fin ADV004
            MODIFY;
            //ADV003 Inicio
            IF "Oferta Mes Sin IVA" THEN BEGIN
                ImpIVA := "Importe Total IVA Incluido" - "Importe Total Evento";
                IF ImpIVA <> 0 THEN BEGIN
                    SalesSetup.GET;
                    lt_Item.GET(SalesSetup."Producto Oferta Mes sin IVA");
                    PorcIVA := 0;
                    IF "Codigo Cliente" <> '' THEN BEGIN
                        lt_Customer.GET("Codigo Cliente");
                        lt_VATPostingSetup.GET(lt_Customer."VAT Bus. Posting Group", lt_Item."VAT Prod. Posting Group");
                        PorcIVA := lt_VATPostingSetup."VAT %";
                    END
                    ELSE BEGIN
                        TESTFIELD("Plantilla Cliente");
                        lt_CustTemplate.GET("Plantilla Cliente");
                        lt_VATPostingSetup.GET(lt_CustTemplate."VAT Bus. Posting Group", lt_Item."VAT Prod. Posting Group");
                        PorcIVA := lt_VATPostingSetup."VAT %";
                    END;
                    NumLinea := 10000;
                    lt_LineaEventos.RESET;
                    lt_LineaEventos.SETRANGE("Codigo Evento", "Codigo Evento");
                    IF lt_LineaEventos.FINDLAST THEN NumLinea := lt_LineaEventos.Linea + 10000;
                    lt_LineaEventos.INIT;
                    lt_LineaEventos."Codigo Evento" := "Codigo Evento";
                    lt_LineaEventos.Linea := NumLinea;
                    lt_LineaEventos.Tipo := lt_LineaEventos.Tipo::Otros;
                    lt_LineaEventos.INSERT;
                    lt_LineaEventos.VALIDATE("No.", SalesSetup."Producto Oferta Mes sin IVA");
                    lt_LineaEventos.VALIDATE(Cantidad, -1);
                    lt_LineaEventos.VALIDATE("Precio Real", ROUND(ImpIVA / (1 + (PorcIVA / 100)), 0.001));
                    lt_LineaEventos.MODIFY;
                    lt_LineaEventos.RESET;
                    lt_LineaEventos.SETRANGE("Codigo Evento", Rec."Codigo Evento");
                    lt_LineaEventos.CALCSUMS(Importe, "Importe IVA Incl.");
                    lt_RecursosEvento.RESET;
                    lt_RecursosEvento.SETRANGE("Codigo Evento", "Codigo Evento");
                    lt_RecursosEvento.CALCSUMS(Importe, "Importe IVA Incl.");
                    // Inicio ADV008
                    lt_ProductosEvento.RESET;
                    lt_ProductosEvento.SETRANGE("Codigo Evento", lt_ProductosEvento."Codigo Evento");
                    lt_ProductosEvento.CALCSUMS(Importe, lt_ProductosEvento."Importe IVA Incl.");
                    // Fin ADV008
                    // Inicio ADV008
                    // ADV008 Rec."Importe Total Evento" := lt_LineaEventos.Importe + lt_RecursosEvento.Importe;
                    Rec."Importe Total Evento" := lt_LineaEventos.Importe + lt_RecursosEvento.Importe + lt_ProductosEvento.Importe;
                    // ADV008 Rec."Importe Total IVA Incluido" := lt_LineaEventos."Importe IVA Incl." + lt_RecursosEvento."Importe IVA Incl.";
                    Rec."Importe Total IVA Incluido" := lt_LineaEventos."Importe IVA Incl." + lt_RecursosEvento."Importe IVA Incl." + lt_ProductosEvento."Importe IVA Incl.";
                    // Fin ADV008
                    // Inicio ADV004
                    Rec."Coste Total Recursos" := CosteRecursos;
                    Rec."Coste Total Visualizado" := Rec."Coste Total Elaboracion" + Rec."Coste Total Recursos";
                    // Fin ADV004
                    MODIFY;
                END;
            END;
            //ADV003 Fin
        end
        else
            Message('El estado del evento no permite el recalculo.');
    end;

    procedure gfu_CambiarEstado()
    var
        Selection: Integer;
    begin
        Selection := STRMENU(Text20000);
        IF Selection = 0 THEN EXIT;
        IF Selection = 5 THEN BEGIN //Realizado
            IF "Codigo Cliente" = '' THEN ERROR(Text60000);
            lfu_CreaPedido;
            Estado := Selection - 1;
            Rec.Modify(true);
        END
        ELSE IF Selection = 6 THEN BEGIN //Archivado
            lfu_ArchivaEvento;
        END
        ELSE BEGIN
            Estado := Selection - 1;
            MODIFY;
        END;
        //++ AGRALAMO - 210021 -54
        IF Selection = 7 THEN BEGIN
            Estado := Estado::EnProceso;
            MODIFY;
        END //-- AGRALAMO - 210021 - 54
    end;

    procedure gfu_CambiarEstadoList()
    var
        Selection: Integer;
        repAnulacion: Report AlxAnularEvento;
    begin
        Selection := STRMENU(Text20000);
        IF Selection = 0 THEN EXIT;
        if Selection = 4 then begin //Anulado
            repAnulacion.SetEvento("Codigo Evento");
            repAnulacion.Run();
            exit;
        end;
        IF Selection = 5 THEN BEGIN //Realizado
            IF "Codigo Cliente" = '' THEN ERROR(Text60000);
            lfu_CreaPedido;
            Estado := Selection - 1;
            Rec.Modify(true);
        END
        ELSE IF Selection = 6 THEN BEGIN //Archivado
            lfu_ArchivaEvento;
        END
        ELSE IF Selection = 3 THEN BEGIN //Rechazado
            lfu_RechazaEvento;
            Estado := Estado::Rechazado;
            Rec.Modify(true);
        END
        ELSE BEGIN
            Estado := Selection - 1;
            MODIFY;
        END;
        //++ AGRALAMO - 210021 -54
        IF Selection = 7 THEN BEGIN
            Estado := Estado::EnProceso;
            MODIFY;
        END //-- AGRALAMO - 210021 - 54
    end;

    local procedure lfu_CalculaPan()
    var
        Rcd_Calculopan: Record "Calculo pan";
        Comensales: Integer;
    begin
        Barras := 0;
        Gallegas := 0;
        Colines := 0;
        Alcachofas := 0;
        "Importe Barras" := 0;
        "Importe Pan Gallego" := 0;
        "Importe Colines" := 0;
        "Importe Alcachofas" := 0;
        IF NOT "Nada Pan" THEN BEGIN
            IF ("Total Adultos" <> 0) OR ("Total Ninos" <> 0) THEN
                IF Rcd_Calculopan.GET("Tipo Evento", "Variedad Evento") THEN BEGIN
                    Comensales := "Total Adultos" + "Total Ninos";
                    Barras := ROUND(Comensales * Rcd_Calculopan."Cantidad Barras", 1, '>');
                    Gallegas := ROUND(Comensales * Rcd_Calculopan."Cantidad Pan Gallego", 1, '>');
                    Colines := ROUND(Comensales * Rcd_Calculopan."Cantidad Colines", 1, '>');
                    Alcachofas := ROUND(Comensales * Rcd_Calculopan."Cantidad Alcachofas", 1, '>');
                    IF "Doble Pan" THEN BEGIN
                        Barras := 2 * Barras;
                        Gallegas := 2 * Gallegas;
                        Colines := 2 * Colines;
                        Alcachofas := 2 * Alcachofas;
                    END;
                    "Importe Barras" := Barras * Rcd_Calculopan."Precio Barras";
                    "Importe Pan Gallego" := Gallegas * Rcd_Calculopan."Precio Pan Gallego";
                    "Importe Colines" := Colines * Rcd_Calculopan."Precio Colines";
                    "Importe Alcachofas" := Alcachofas * Rcd_Calculopan."Precio Alcachofas";
                END;
        END;
    end;

    procedure gfu_CrearClienteContacto()
    var
        Rcd_Contact: Record Contact;
        Rcd_Customer: Record Customer;
        Selection: Integer;
        CustTemplate: Record "Customer Templ.";
        DefaultDim: Record "Default Dimension";
        DefaultDim2: Record "Default Dimension";
        RMSetup: Record "Marketing Setup";
        ContBusRel: Record "Contact Business Relation";
    begin
        IF ("Codigo Cliente" <> '') AND ("Codigo Contacto" <> '') THEN EXIT;
        IF ("Codigo Cliente" = '') AND ("Codigo Contacto" = '') THEN BEGIN
            Selection := STRMENU(Text30000);
            IF Selection = 0 THEN EXIT;
            IF Selection = 1 THEN BEGIN //Contacto
                Rcd_Contact.INIT;
                Rcd_Contact.Name := Rec."Persona de Contacto";
                Rcd_Contact.Address := Rec.Direccion;
                Rcd_Contact."Phone No." := Rec.Telefono;
                Rcd_Contact."E-Mail" := Rec."E-Mail";
                Rcd_Contact."Post Code" := Rec."Codigo Postal";
                Rcd_Contact.City := Rec.Poblacion;
                Rcd_Contact.County := Rec.Provincia;
                Rcd_Contact."Country/Region Code" := Rec."Cod Pais";
                Rcd_Contact.INSERT(TRUE);
                Rec."Codigo Contacto" := Rcd_Contact."No.";
                Rec.MODIFY;
            END
            ELSE IF Selection = 2 THEN BEGIN //Cliente y contacto
                RMSetup.GET;
                RMSetup.TESTFIELD("Bus. Rel. Code for Customers");
                //Crea Contacto
                Rec.TESTFIELD("Plantilla Cliente");
                Rcd_Contact.INIT;
                Rcd_Contact.Name := Rec."Persona de Contacto";
                Rcd_Contact.Address := Rec.Direccion;
                Rcd_Contact."Phone No." := Rec.Telefono;
                Rcd_Contact."E-Mail" := Rec."E-Mail";
                Rcd_Contact."Post Code" := Rec."Codigo Postal";
                Rcd_Contact.City := Rec.Poblacion;
                Rcd_Contact.County := Rec.Provincia;
                Rcd_Contact."Country/Region Code" := Rec."Cod Pais";
                Rcd_Contact.INSERT(TRUE);
                Rec."Codigo Contacto" := Rcd_Contact."No.";
                Rec.MODIFY;
                //Crea cliente
                CustTemplate.GET("Plantilla Cliente");
                Rcd_Customer.INIT;
                Rcd_Customer.SetInsertFromContact(TRUE); //Para que no cree contacto en el validate del insert
                Rcd_Customer.INSERT(TRUE);
                Rcd_Customer.SetInsertFromContact(FALSE);
                Rcd_Customer.Name := Rec."Persona de Contacto";
                Rcd_Customer.Address := Rec.Direccion;
                Rcd_Customer."Phone No." := Rec.Telefono;
                Rcd_Customer."E-Mail" := Rec."E-Mail";
                Rcd_Customer."Post Code" := Rec."Codigo Postal";
                Rcd_Customer.City := Rec.Poblacion;
                Rcd_Customer.County := Rec.Provincia;
                Rcd_Customer."Country/Region Code" := Rec."Cod Pais";
                Rcd_Customer."Currency Code" := CustTemplate."Currency Code";
                Rcd_Customer."Customer Posting Group" := CustTemplate."Customer Posting Group";
                Rcd_Customer."Customer Price Group" := CustTemplate."Customer Price Group";
                Rcd_Customer."Invoice Disc. Code" := CustTemplate."Invoice Disc. Code";
                Rcd_Customer."Customer Disc. Group" := CustTemplate."Customer Disc. Group";
                Rcd_Customer."Allow Line Disc." := CustTemplate."Allow Line Disc.";
                Rcd_Customer."Gen. Bus. Posting Group" := CustTemplate."Gen. Bus. Posting Group";
                Rcd_Customer."VAT Bus. Posting Group" := CustTemplate."VAT Bus. Posting Group";
                Rcd_Customer."Payment Terms Code" := Rec."Cod Teminos Pago";
                Rcd_Customer."Payment Method Code" := Rec."Cod Forma Pago";
                Rcd_Customer."Shipment Method Code" := CustTemplate."Shipment Method Code";
                Rcd_Customer."Location Code" := CustTemplate."Cod. Almacen";
                Rcd_Customer.MODIFY;
                Rec."Codigo Cliente" := Rcd_Customer."No.";
                Rec.MODIFY;
                ContBusRel.INIT;
                ContBusRel."Contact No." := Rcd_Contact."No.";
                ContBusRel."Business Relation Code" := RMSetup."Bus. Rel. Code for Customers";
                ContBusRel."Link to Table" := ContBusRel."Link to Table"::Customer;
                ContBusRel."No." := Rcd_Customer."No.";
                ContBusRel.INSERT;
                DefaultDim.SETRANGE("Table ID", DATABASE::"Customer Templ.");
                DefaultDim.SETRANGE("No.", CustTemplate.Code);
                IF DefaultDim.FIND('-') THEN
                    REPEAT
                        CLEAR(DefaultDim2);
                        DefaultDim2.INIT;
                        DefaultDim2.VALIDATE("Table ID", DATABASE::Customer);
                        DefaultDim2."No." := Cust."No.";
                        DefaultDim2.VALIDATE("Dimension Code", DefaultDim."Dimension Code");
                        DefaultDim2.VALIDATE("Dimension Value Code", DefaultDim."Dimension Value Code");
                        DefaultDim2."Value Posting" := DefaultDim."Value Posting";
                        DefaultDim2.INSERT(TRUE);
                    UNTIL DefaultDim.NEXT = 0;
            END;
        END
        ELSE IF ("Codigo Cliente" = '') AND ("Codigo Contacto" <> '') THEN BEGIN
            RMSetup.GET;
            RMSetup.TESTFIELD("Bus. Rel. Code for Customers");
            ContBusRel.RESET;
            ContBusRel.SETRANGE("Contact No.", "Codigo Contacto");
            ContBusRel.SETRANGE("Link to Table", ContBusRel."Link to Table"::Customer);
            IF ContBusRel.FINDFIRST THEN ERROR(Text40000, "Codigo Contacto");
            IF NOT CONFIRM(Text50000, FALSE, "Codigo Contacto") THEN EXIT;
            Rec.TESTFIELD("Plantilla Cliente");
            //Crea cliente
            CustTemplate.GET("Plantilla Cliente");
            Rcd_Customer.INIT;
            Rcd_Customer.SetInsertFromContact(TRUE); //Para que no cree contacto en el validate del insert
            Rcd_Customer.INSERT(TRUE);
            Rcd_Customer.SetInsertFromContact(FALSE);
            Rcd_Customer.Name := Rec."Persona de Contacto";
            Rcd_Customer.Address := Rec.Direccion;
            Rcd_Customer."Phone No." := Rec.Telefono;
            Rcd_Customer."E-Mail" := Rec."E-Mail";
            Rcd_Customer."Post Code" := Rec."Codigo Postal";
            Rcd_Customer.City := Rec.Poblacion;
            Rcd_Customer.County := Rec.Provincia;
            Rcd_Customer."Country/Region Code" := Rec."Cod Pais";
            Rcd_Customer."Currency Code" := CustTemplate."Currency Code";
            Rcd_Customer."Customer Posting Group" := CustTemplate."Customer Posting Group";
            Rcd_Customer."Customer Price Group" := CustTemplate."Customer Price Group";
            Rcd_Customer."Invoice Disc. Code" := CustTemplate."Invoice Disc. Code";
            Rcd_Customer."Customer Disc. Group" := CustTemplate."Customer Disc. Group";
            Rcd_Customer."Allow Line Disc." := CustTemplate."Allow Line Disc.";
            Rcd_Customer."Gen. Bus. Posting Group" := CustTemplate."Gen. Bus. Posting Group";
            Rcd_Customer."VAT Bus. Posting Group" := CustTemplate."VAT Bus. Posting Group";
            Rcd_Customer."Payment Terms Code" := Rec."Cod Teminos Pago";
            Rcd_Customer."Payment Method Code" := Rec."Cod Forma Pago";
            Rcd_Customer."Shipment Method Code" := CustTemplate."Shipment Method Code";
            Rcd_Customer."Location Code" := CustTemplate."Cod. Almacen";
            Rcd_Customer.MODIFY;
            Rec."Codigo Cliente" := Rcd_Customer."No.";
            Rec.MODIFY;
            ContBusRel.INIT;
            ContBusRel."Contact No." := Rec."Codigo Contacto";
            ContBusRel."Business Relation Code" := RMSetup."Bus. Rel. Code for Customers";
            ContBusRel."Link to Table" := ContBusRel."Link to Table"::Customer;
            ContBusRel."No." := Rcd_Customer."No.";
            ContBusRel.INSERT;
            DefaultDim.SETRANGE("Table ID", DATABASE::"Customer Templ.");
            DefaultDim.SETRANGE("No.", CustTemplate.Code);
            IF DefaultDim.FIND('-') THEN
                REPEAT
                    CLEAR(DefaultDim2);
                    DefaultDim2.INIT;
                    DefaultDim2.VALIDATE("Table ID", DATABASE::Customer);
                    DefaultDim2."No." := Cust."No.";
                    DefaultDim2.VALIDATE("Dimension Code", DefaultDim."Dimension Code");
                    DefaultDim2.VALIDATE("Dimension Value Code", DefaultDim."Dimension Value Code");
                    DefaultDim2."Value Posting" := DefaultDim."Value Posting";
                    DefaultDim2.INSERT(TRUE);
                UNTIL DefaultDim.NEXT = 0;
        END;
    end;

    procedure gfu_ImpBeneficio(): Decimal
    begin
        CALCFIELDS("Coste Total");
        EXIT("Importe Total Evento" - "Coste Total");
    end;

    procedure gfu_PorcBeneficio(): Decimal
    begin
        CALCFIELDS("Coste Total");
        IF "Importe Total Evento" = 0 THEN
            EXIT(0)
        ELSE BEGIN
            IF "Importe Total Evento" <> 0 THEN
                EXIT(("Importe Total Evento" - "Coste Total") / "Importe Total Evento" * 100)
            ELSE
                EXIT(0);
        END;
    end;

    procedure gfu_PorcBeneficioTeorico(): Decimal
    begin
        CALCFIELDS("Coste Total");
        IF "Importe Total Evento" = 0 THEN
            EXIT(0)
        ELSE BEGIN
            IF "Importe Total Evento" <> 0 THEN
                EXIT(("Coste Total") / "Importe Total Evento" * 100)
            ELSE
                EXIT(0);
        END;
    end;

    local procedure lfu_CreaPedido()
    var
        lt_RecursosEvento: Record 50003;
        SalesReceivablesSetup: Record 311;
        NoLinea: Integer;
        lt_ProductosEvento: Record 50016;
    begin
        //Para que no genere nada
        //ERROR('No se puede pasar a estado realizado');
        IF Rec."Concepto Generico Facturacion" <> '' THEN BEGIN
            SalesReceivablesSetup.GET;
            SalesReceivablesSetup.TESTFIELD("Cuenta Eventos");
        END;
        gt_pedido.SetHideValidationDialog(TRUE);
        gt_pedido.INIT;
        gt_pedido."No." := '';
        gt_pedido."Document Type" := gt_pedido."Document Type"::Order;
        gt_pedido.INSERT(TRUE);
        gt_pedido."Document Date" := Rec."Fecha Evento";
        //SL RV: fecha registro pedidos venta catering
        //gt_pedido."Order Date" := Rec."Fecha Evento";
        gt_pedido."Order Date" := Today;
        gt_pedido."Fecha Servicio" := "Fecha Evento";
        //SL End
        gt_pedido."Posting Date" := Rec."Fecha Evento";
        gt_pedido.VALIDATE("Sell-to Customer No.", Rec."Codigo Cliente");
        gt_pedido.NoEvento := Rec."Codigo Evento";
        gt_pedido.VALIDATE("Payment Method Code", Rec."Cod Forma Pago");
        gt_pedido.VALIDATE("Payment Terms Code", Rec."Cod Teminos Pago");
        gt_pedido.VALIDATE("Salesperson Code", Rec.CodVendedor);
        gt_pedido."Importe total evento" := Rec."Importe Total Evento";
        gt_pedido."Importe Rechazado" := Rec."Importe Rechazado";
        gt_pedido."Importe Contratado" := Rec."Importe Total Evento" - Rec."Importe Rechazado";
        gt_pedido.MODIFY(TRUE);
        //++ AGRALAMO - 66
        //IF gt_linevento."No." <> '' THEN  BEGIN
        //-- AGRALAMO - 66
        //lineas pedido
        //SL ajuste correo RE: GAP00061 - Ajuste Informes Eventos y Facturas Total por capítulos
        //IF Rec."Concepto Generico Facturacion" = '' THEN BEGIN
        //Menu Adulto
        gt_linevento.RESET;
        gt_linevento.SETRANGE(gt_linevento."Codigo Evento", Rec."Codigo Evento");
        gt_linevento.SETRANGE(Tipo, gt_linevento.Tipo::Adulto);
        IF gt_linevento.FINDSET THEN
            REPEAT
                gt_lineasventa.INIT;
                gt_lineasventa."Document Type" := gt_lineasventa."Document Type"::Order;
                gt_lineasventa."Document No." := gt_pedido."No.";
                gt_lineasventa."Line No." := gt_linevento.Linea;
                gt_lineasventa.INSERT(TRUE);
                //SL Es comentario
                if gt_linevento."No." = '' then begin
                    gt_lineasventa.Validate(Type, gt_lineasventa.Type::" ");
                    gt_lineasventa."No." := '';
                    //gt_lineasventa.Description := gt_linevento.Descripcion;
                end
                else begin
                    gt_lineasventa.Type := gt_lineasventa.Type::Item;
                    gt_lineasventa.VALIDATE("No.", gt_linevento."No.");
                    gt_lineasventa.VALIDATE(gt_lineasventa.Quantity, gt_linevento.Cantidad);
                    gt_lineasventa.VALIDATE("Unit Price", gt_linevento."Precio Real");
                end;
                //gt_lineasventa.Type := gt_lineasventa.Type::Item;
                //gt_lineasventa.VALIDATE("No.", gt_linevento."No.");
                //    gt_lineasventa.VALIDATE("Location Code",'001');
                //gt_lineasventa.VALIDATE(gt_lineasventa.Quantity, gt_linevento.Cantidad);
                //gt_lineasventa.VALIDATE("Unit Price", gt_linevento."Precio Real");
                //gt_lineasventa.VALIDATE("Qty. to Assemble to Order",gt_linevento.Cantidad);
                gt_lineasventa.NoEvento := gt_linevento."Codigo Evento";
                gt_lineasventa.LineaEvento := gt_linevento.Linea;
                //SL Begin
                gt_lineasventa.Description := gt_linevento.Descripcion;
                //SL End
                gt_lineasventa."Tabla Evento" := DATABASE::"Lineas Evento";
                gt_lineasventa.Imprime := gt_linevento.Imprime;
                gt_lineasventa.MODIFY(TRUE);
            UNTIL gt_linevento.NEXT = 0;
        //Menu Niño
        gt_linevento.RESET;
        gt_linevento.SETRANGE(gt_linevento."Codigo Evento", Rec."Codigo Evento");
        gt_linevento.SETRANGE(Tipo, gt_linevento.Tipo::Niño);
        IF gt_linevento.FINDSET THEN
            REPEAT
                gt_lineasventa.INIT;
                gt_lineasventa."Document Type" := gt_lineasventa."Document Type"::Order;
                gt_lineasventa."Document No." := gt_pedido."No.";
                gt_lineasventa."Line No." := gt_linevento.Linea;
                gt_lineasventa.INSERT(TRUE);
                if gt_linevento."No." = '' then begin
                    gt_lineasventa.Validate(Type, gt_lineasventa.Type::" ");
                    gt_lineasventa."No." := '';
                    //gt_lineasventa.Description := gt_linevento.Descripcion;
                end
                else begin
                    gt_lineasventa.Type := gt_lineasventa.Type::Item;
                    gt_lineasventa.VALIDATE("No.", gt_linevento."No.");
                    gt_lineasventa.VALIDATE(gt_lineasventa.Quantity, gt_linevento.Cantidad);
                    gt_lineasventa.VALIDATE("Unit Price", gt_linevento."Precio Real");
                end;
                //SL Begin
                gt_lineasventa.Description := gt_linevento.Descripcion;
                //SL End
                //gt_lineasventa.VALIDATE(gt_lineasventa.Quantity, gt_linevento.Cantidad);
                //    gt_lineasventa.VALIDATE("Location Code",'001');
                //gt_lineasventa.VALIDATE("Unit Price", gt_linevento."Precio Real");
                //gt_lineasventa.VALIDATE("Qty. to Assemble to Order",gt_linevento.Cantidad);
                gt_lineasventa.NoEvento := gt_linevento."Codigo Evento";
                gt_lineasventa.LineaEvento := gt_linevento.Linea;
                gt_lineasventa."Tabla Evento" := DATABASE::"Lineas Evento";
                gt_lineasventa.MODIFY(TRUE);
            UNTIL gt_linevento.NEXT = 0;
        //Menu Otros
        gt_linevento.RESET;
        gt_linevento.SETRANGE(gt_linevento."Codigo Evento", Rec."Codigo Evento");
        gt_linevento.SETRANGE(Tipo, gt_linevento.Tipo::Otros);
        IF gt_linevento.FINDSET THEN
            REPEAT
                gt_lineasventa.INIT;
                gt_lineasventa."Document Type" := gt_lineasventa."Document Type"::Order;
                gt_lineasventa."Document No." := gt_pedido."No.";
                gt_lineasventa."Line No." := gt_linevento.Linea;
                gt_lineasventa.INSERT(TRUE);
                if gt_linevento."No." = '' then begin
                    gt_lineasventa.Validate(Type, gt_lineasventa.Type::" ");
                    gt_lineasventa."No." := '';
                    //gt_lineasventa.Description := gt_linevento.Descripcion;
                end
                else begin
                    gt_lineasventa.Type := gt_lineasventa.Type::Item;
                    gt_lineasventa.VALIDATE("No.", gt_linevento."No.");
                    gt_lineasventa.VALIDATE(gt_lineasventa.Quantity, gt_linevento.Cantidad);
                    gt_lineasventa.VALIDATE("Unit Price", gt_linevento."Precio Real");
                end;
                //  gt_lineasventa.VALIDATE("Location Code",'001');
                //gt_lineasventa.VALIDATE(gt_lineasventa.Quantity, gt_linevento.Cantidad);
                //gt_lineasventa.VALIDATE("Unit Price", gt_linevento."Precio Real");
                //gt_lineasventa.VALIDATE("Qty. to Assemble to Order",gt_linevento.Cantidad);
                //SL Begin
                gt_lineasventa.Description := gt_linevento.Descripcion;
                //SL End
                gt_lineasventa.NoEvento := gt_linevento."Codigo Evento";
                gt_lineasventa.LineaEvento := gt_linevento.Linea;
                gt_lineasventa."Tabla Evento" := DATABASE::"Lineas Evento";
                gt_lineasventa.MODIFY(TRUE);
            UNTIL gt_linevento.NEXT = 0;
        NoLinea := 0;
        gt_lineasventa.RESET;
        gt_lineasventa.SETRANGE("Document Type", gt_lineasventa."Document Type"::Order);
        gt_lineasventa.SETRANGE("Document No.", gt_pedido."No.");
        IF gt_lineasventa.FINDLAST THEN NoLinea := gt_lineasventa."Line No.";
        //Recursos personal
        lt_RecursosEvento.RESET;
        lt_RecursosEvento.SETRANGE("Codigo Evento", Rec."Codigo Evento");
        lt_RecursosEvento.SETRANGE(Tipo, lt_RecursosEvento.Tipo::Personal);
        IF lt_RecursosEvento.FINDSET THEN
            REPEAT
                gt_lineasventa.INIT;
                gt_lineasventa."Document Type" := gt_lineasventa."Document Type"::Order;
                gt_lineasventa."Document No." := gt_pedido."No.";
                NoLinea := NoLinea + 10000;
                gt_lineasventa."Line No." := NoLinea;
                gt_lineasventa.INSERT(TRUE);
                if lt_RecursosEvento."Codigo Recurso" = '' then begin
                    gt_lineasventa.Validate(Type, gt_lineasventa.Type::" ");
                    gt_lineasventa."No." := '';
                end
                else begin
                    gt_lineasventa.Type := gt_lineasventa.Type::Resource;
                    gt_lineasventa.VALIDATE("No.", lt_RecursosEvento."Codigo Recurso");
                    gt_lineasventa.VALIDATE(gt_lineasventa.Quantity, lt_RecursosEvento.Cantidad);
                    //gt_lineasventa.VALIDATE("Unit Price",0);
                    gt_lineasventa.VALIDATE("Unit Price", lt_RecursosEvento."Precio Real");
                end;
                //gt_lineasventa.Type := gt_lineasventa.Type::Resource;
                //gt_lineasventa.VALIDATE("No.", lt_RecursosEvento."Codigo Recurso");
                //gt_lineasventa.VALIDATE(gt_lineasventa.Quantity, lt_RecursosEvento.Cantidad);
                //gt_lineasventa.VALIDATE("Unit Price",0);
                //gt_lineasventa.VALIDATE("Unit Price", lt_RecursosEvento."Precio Real");
                //gt_lineasventa.VALIDATE("Qty. to Assemble to Order",gt_linevento.Cantidad);
                gt_lineasventa.NoEvento := lt_RecursosEvento."Codigo Evento";
                gt_lineasventa.LineaEvento := lt_RecursosEvento.Linea;
                //SL Begin
                gt_lineasventa.Description := lt_RecursosEvento.Descripcion;
                //SL End
                gt_lineasventa."Tabla Evento" := DATABASE::"Recursos Evento";
                gt_lineasventa.MODIFY(TRUE);
            UNTIL lt_RecursosEvento.NEXT = 0;
        //Recursos otros
        lt_RecursosEvento.RESET;
        lt_RecursosEvento.SETRANGE("Codigo Evento", Rec."Codigo Evento");
        lt_RecursosEvento.SETRANGE(Tipo, lt_RecursosEvento.Tipo::Otros);
        IF lt_RecursosEvento.FINDSET THEN
            REPEAT
                gt_lineasventa.INIT;
                gt_lineasventa."Document Type" := gt_lineasventa."Document Type"::Order;
                gt_lineasventa."Document No." := gt_pedido."No.";
                NoLinea := NoLinea + 10000;
                gt_lineasventa."Line No." := NoLinea;
                gt_lineasventa.INSERT(TRUE);
                if lt_RecursosEvento."Codigo Recurso" = '' then begin
                    gt_lineasventa.Validate(Type, gt_lineasventa.Type::" ");
                    gt_lineasventa."No." := '';
                end
                else begin
                    gt_lineasventa.Type := gt_lineasventa.Type::Resource;
                    gt_lineasventa.VALIDATE("No.", lt_RecursosEvento."Codigo Recurso");
                    gt_lineasventa.VALIDATE(gt_lineasventa.Quantity, lt_RecursosEvento.Cantidad);
                    //gt_lineasventa.VALIDATE("Unit Price",0);
                    gt_lineasventa.VALIDATE("Unit Price", lt_RecursosEvento."Precio Real");
                end;
                //gt_lineasventa.Type := gt_lineasventa.Type::Resource;
                //gt_lineasventa.VALIDATE("No.", lt_RecursosEvento."Codigo Recurso");
                // gt_lineasventa.VALIDATE(gt_lineasventa.Quantity, lt_RecursosEvento.Cantidad);
                //gt_lineasventa.VALIDATE("Unit Price",0);
                // gt_lineasventa.VALIDATE("Unit Price", lt_RecursosEvento."Precio Real");
                //gt_lineasventa.VALIDATE("Qty. to Assemble to Order",gt_linevento.Cantidad);
                gt_lineasventa.NoEvento := lt_RecursosEvento."Codigo Evento";
                gt_lineasventa.LineaEvento := lt_RecursosEvento.Linea;
                //SL Begin
                gt_lineasventa.Description := lt_RecursosEvento.Descripcion;
                //SL End
                gt_lineasventa."Tabla Evento" := DATABASE::"Recursos Evento";
                gt_lineasventa.MODIFY(TRUE);
            UNTIL lt_RecursosEvento.NEXT = 0;
        //inicio ADV009
        //Menaje desechable
        lt_ProductosEvento.RESET;
        lt_ProductosEvento.SETRANGE("Codigo Evento", Rec."Codigo Evento");
        lt_ProductosEvento.SETRANGE(Tipo, lt_ProductosEvento.Tipo::Menaje);
        IF lt_ProductosEvento.FINDSET THEN
            REPEAT
                gt_lineasventa.INIT;
                gt_lineasventa."Document Type" := gt_lineasventa."Document Type"::Order;
                gt_lineasventa."Document No." := gt_pedido."No.";
                NoLinea := NoLinea + 10000;
                gt_lineasventa."Line No." := NoLinea;
                gt_lineasventa.INSERT(TRUE);
                if lt_ProductosEvento."Codigo Producto" = '' then begin
                    gt_lineasventa.Validate(Type, gt_lineasventa.Type::" ");
                    gt_lineasventa."No." := '';
                end
                else begin
                    gt_lineasventa.Type := gt_lineasventa.Type::Item;
                    gt_lineasventa.VALIDATE("No.", lt_ProductosEvento."Codigo Producto");
                    gt_lineasventa.VALIDATE(gt_lineasventa.Quantity, lt_ProductosEvento.Cantidad);
                    gt_lineasventa.VALIDATE("Unit Price", lt_ProductosEvento."Precio Real");
                end;
                //gt_lineasventa.Type := gt_lineasventa.Type::Item;
                //gt_lineasventa.VALIDATE("No.", lt_ProductosEvento."Codigo Producto");
                //gt_lineasventa.VALIDATE(gt_lineasventa.Quantity, lt_ProductosEvento.Cantidad);
                //gt_lineasventa.VALIDATE("Unit Price", lt_ProductosEvento."Precio Real");
                gt_lineasventa.Description := lt_ProductosEvento.Descripcion;
                gt_lineasventa.NoEvento := lt_ProductosEvento."Codigo Evento";
                gt_lineasventa.LineaEvento := lt_ProductosEvento.Linea;
                gt_lineasventa."Tabla Evento" := DATABASE::"Productos Evento";
                gt_lineasventa.MODIFY(TRUE);
            UNTIL lt_ProductosEvento.NEXT = 0;
        //Menaje suplementos
        lt_ProductosEvento.RESET;
        lt_ProductosEvento.SETRANGE("Codigo Evento", Rec."Codigo Evento");
        lt_ProductosEvento.SETRANGE(Tipo, lt_ProductosEvento.Tipo::Suplementos);
        IF lt_ProductosEvento.FINDSET THEN
            REPEAT
                gt_lineasventa.INIT;
                gt_lineasventa."Document Type" := gt_lineasventa."Document Type"::Order;
                gt_lineasventa."Document No." := gt_pedido."No.";
                NoLinea := NoLinea + 10000;
                gt_lineasventa."Line No." := NoLinea;
                gt_lineasventa.INSERT(TRUE);
                if lt_ProductosEvento."Codigo Producto" = '' then begin
                    gt_lineasventa.Validate(Type, gt_lineasventa.Type::" ");
                    gt_lineasventa."No." := '';
                end
                else begin
                    gt_lineasventa.Type := gt_lineasventa.Type::Item;
                    gt_lineasventa.VALIDATE("No.", lt_ProductosEvento."Codigo Producto");
                    gt_lineasventa.VALIDATE(gt_lineasventa.Quantity, lt_ProductosEvento.Cantidad);
                    gt_lineasventa.VALIDATE("Unit Price", lt_ProductosEvento."Precio Real");
                end;
                //gt_lineasventa.Type := gt_lineasventa.Type::Item;
                //gt_lineasventa.VALIDATE("No.", lt_ProductosEvento."Codigo Producto");
                //gt_lineasventa.VALIDATE(gt_lineasventa.Quantity, lt_ProductosEvento.Cantidad);
                //gt_lineasventa.VALIDATE("Unit Price", lt_ProductosEvento."Precio Real");
                gt_lineasventa.Description := lt_ProductosEvento.Descripcion;
                gt_lineasventa.NoEvento := lt_ProductosEvento."Codigo Evento";
                gt_lineasventa.LineaEvento := lt_ProductosEvento.Linea;
                gt_lineasventa."Tabla Evento" := DATABASE::"Productos Evento";
                gt_lineasventa.MODIFY(TRUE);
            UNTIL lt_ProductosEvento.NEXT = 0;
        //Pan
        lt_ProductosEvento.RESET;
        lt_ProductosEvento.SETRANGE("Codigo Evento", Rec."Codigo Evento");
        lt_ProductosEvento.SETRANGE(Tipo, lt_ProductosEvento.Tipo::Pan);
        IF lt_ProductosEvento.FINDSET THEN
            REPEAT
                gt_lineasventa.INIT;
                gt_lineasventa."Document Type" := gt_lineasventa."Document Type"::Order;
                gt_lineasventa."Document No." := gt_pedido."No.";
                NoLinea := NoLinea + 10000;
                gt_lineasventa."Line No." := NoLinea;
                gt_lineasventa.INSERT(TRUE);
                if lt_ProductosEvento."Codigo Producto" = '' then begin
                    gt_lineasventa.Validate(Type, gt_lineasventa.Type::" ");
                    gt_lineasventa."No." := '';
                end
                else begin
                    gt_lineasventa.Type := gt_lineasventa.Type::Item;
                    gt_lineasventa.VALIDATE("No.", lt_ProductosEvento."Codigo Producto");
                    gt_lineasventa.VALIDATE(gt_lineasventa.Quantity, lt_ProductosEvento.Cantidad);
                    gt_lineasventa.VALIDATE("Unit Price", lt_ProductosEvento."Precio Real");
                end;
                //gt_lineasventa.Type := gt_lineasventa.Type::Item;
                //gt_lineasventa.VALIDATE("No.", lt_ProductosEvento."Codigo Producto");
                //gt_lineasventa.VALIDATE(gt_lineasventa.Quantity, lt_ProductosEvento.Cantidad);
                //gt_lineasventa.VALIDATE("Unit Price", lt_ProductosEvento."Precio Real");
                gt_lineasventa.Description := lt_ProductosEvento.Descripcion;
                gt_lineasventa.NoEvento := lt_ProductosEvento."Codigo Evento";
                gt_lineasventa.LineaEvento := lt_ProductosEvento.Linea;
                gt_lineasventa."Tabla Evento" := DATABASE::"Productos Evento";
                gt_lineasventa.MODIFY(TRUE);
            UNTIL lt_ProductosEvento.NEXT = 0;
        //fin ADV009
        //SL Ajuste correo RE: GAP00061 - Ajuste Informes Eventos y Facturas Total por capítulos
        /* END ELSE BEGIN
            gt_lineasventa.INIT;
            gt_lineasventa."Document Type" := gt_lineasventa."Document Type"::Order;
            gt_lineasventa."Document No." := gt_pedido."No.";
            gt_lineasventa."Line No." := 10000;
            gt_lineasventa.INSERT(TRUE);
            gt_lineasventa.Type := gt_lineasventa.Type::"G/L Account";
            gt_lineasventa.VALIDATE("No.", SalesReceivablesSetup."Cuenta Eventos");
            gt_lineasventa.Description := Rec."Concepto Generico Facturacion";
            gt_lineasventa.VALIDATE(gt_lineasventa.Quantity, 1);
            //Rec.CALCFIELDS("Importe Total Evento");
            gt_lineasventa.VALIDATE("Unit Price", Rec."Importe Total Evento");
            gt_lineasventa.NoEvento := lt_RecursosEvento."Codigo Evento";
            //gt_lineasventa.LineaEvento := lt_RecursosEvento.Linea;
            //gt_lineasventa."Tabla Evento" := DATABASE::"Lineas Evento";
            gt_lineasventa.MODIFY(TRUE);
        END; */
        //Pedidos ensamblado
        IF NOT Rec.CreadoEnsamblado THEN BEGIN
            gt_linevento.RESET;
            gt_linevento.SETRANGE(gt_linevento."Codigo Evento", Rec."Codigo Evento");
            IF gt_linevento.FINDSET THEN
                REPEAT
                    gt_linevento.gfu_CreaRegPedEnsamblado;
                UNTIL gt_linevento.NEXT = 0;
            //++ KR SGA
            lt_ProductosEvento.RESET;
            lt_ProductosEvento.SETRANGE(lt_ProductosEvento."Codigo Evento", Rec."Codigo Evento");
            IF lt_ProductosEvento.FINDSET THEN
                REPEAT
                    lt_ProductosEvento.gfu_CreaRegPedEnsambladoKR;
                UNTIL lt_ProductosEvento.NEXT = 0;
            //-- KR SGA
            Rec.CreadoEnsamblado := TRUE;
            Rec.MODIFY;
        END;
        //++ AGRALAMO - 66
        //END;
        //-- AGRALAMO - 66
        MESSAGE(Text70000, gt_pedido."No.");
    end;

    //JMC 16/06/2026 Copiamos funcionalidad de archivar evento para el estado rechazado
    local procedure lfu_RechazaEvento()
    var
        lp_Dialogo: Page 50011;
        lt_Evento: Record 50004;
        l_Text10000: Label 'El evento ya ha sido rechazado anteriormente. ¿Desea continuar?';
        l_Text20000: Label 'Importe a rechazar';
        //l_Text20000: Label 'Importe rechazado';
        ln_Importe: Decimal;
        l_Text30000: Label 'Importe no puede ser 0. ';
        lt_LineasEvento: Record 50002;
        lt_ProductosEvento: Record 50016;
        SalesReceivablesSetup: Record 311;
        l_Text40000: Label 'Se ha grabado el Evento rechazado Nº %1.';
    begin
        lt_Evento.RESET;
        lt_Evento.SETRANGE("Evento Origen", Rec."Codigo Evento");
        IF lt_Evento.FINDFIRST THEN IF NOT CONFIRM(l_Text10000, FALSE) THEN EXIT;
        lp_Dialogo.gfu_SetDialogoImporte(l_Text20000);
        IF lp_Dialogo.RUNMODAL = ACTION::OK THEN
            ln_Importe := lp_Dialogo.gfu_GetDialogoImporte
        ELSE
            EXIT;
        IF ln_Importe = 0 THEN ERROR(l_Text30000);
        Rec."Importe Rechazado" := ln_Importe;
        Rec.Modify();
        SalesReceivablesSetup.GET;
        if SalesReceivablesSetup."Crea Nuevo Evento" then begin
            lt_Evento.INIT;
            lt_Evento.TRANSFERFIELDS(Rec);
            lt_Evento."Importe Rechazado" := 0;
            lt_Evento."Codigo Evento" := '';
            lt_Evento.Estado := lt_Evento.Estado::Archivado;
            lt_Evento."Evento Origen" := Rec."Codigo Evento";
            IF lt_Evento."Concepto Generico Facturacion" = '' THEN lt_Evento."Concepto Generico Facturacion" := lt_Evento.Descripcion;
            lt_Evento.INSERT(TRUE);
            SalesReceivablesSetup.TESTFIELD("Producto Eventos Archivados");
            lt_LineasEvento.INIT;
            lt_LineasEvento."Codigo Evento" := lt_Evento."Codigo Evento";
            lt_LineasEvento.Linea := 10000;
            lt_LineasEvento.Tipo := lt_LineasEvento.Tipo::Adulto;
            lt_LineasEvento.INSERT(TRUE);
            lt_LineasEvento.VALIDATE("No.", SalesReceivablesSetup."Producto Eventos Archivados");
            lt_LineasEvento.Cantidad := 1;
            lt_LineasEvento.VALIDATE("Precio Real", ln_Importe);
            lt_LineasEvento.MODIFY(TRUE);
            lt_Evento.gfu_CalculoCostesPrecios;
            lt_Evento.MODIFY;
        end;
        IF NOT Rec.CreadoEnsamblado THEN
            IF CONFIRM('Se va a rechazar el evento, ¿desea que genere un pedido de ensamblado?') THEN BEGIN
                //Pedidos ensamblado
                gt_linevento.RESET;
                gt_linevento.SETRANGE(gt_linevento."Codigo Evento", Rec."Codigo Evento");
                IF gt_linevento.FINDSET THEN
                    REPEAT
                        gt_linevento.gfu_CreaRegPedEnsamblado;
                    UNTIL gt_linevento.NEXT = 0;
                //++ KR SGA
                lt_ProductosEvento.RESET;
                lt_ProductosEvento.SETRANGE(lt_ProductosEvento."Codigo Evento", Rec."Codigo Evento");
                IF lt_ProductosEvento.FINDSET THEN
                    REPEAT
                        lt_ProductosEvento.gfu_CreaRegPedEnsambladoKR;
                    UNTIL lt_ProductosEvento.NEXT = 0;
                //-- KR SGA
                Rec.CreadoEnsamblado := TRUE;
                Rec.MODIFY;
            END;
        if SalesReceivablesSetup."Crea Nuevo Evento" then
            MESSAGE(l_Text40000, lt_Evento."Codigo Evento")
        else
            Message('Proceso completo.');
    end;

    local procedure lfu_ArchivaEvento()
    var
        lp_Dialogo: Page 50011;
        lt_Evento: Record 50004;
        l_Text10000: Label 'El evento ya ha sido archivado anteriormente. ¿Desea continuar?';
        l_Text20000: Label 'Importe a archivar';
        //l_Text20000: Label 'Importe rechazado';
        ln_Importe: Decimal;
        l_Text30000: Label 'Importe no puede ser 0. ';
        lt_LineasEvento: Record 50002;
        lt_ProductosEvento: Record 50016;
        SalesReceivablesSetup: Record 311;
        l_Text40000: Label 'Se ha grabado el Evento archivado Nº %1.';
    begin
        lt_Evento.RESET;
        lt_Evento.SETRANGE("Evento Origen", Rec."Codigo Evento");
        IF lt_Evento.FINDFIRST THEN IF NOT CONFIRM(l_Text10000, FALSE) THEN EXIT;
        lp_Dialogo.gfu_SetDialogoImporte(l_Text20000);
        IF lp_Dialogo.RUNMODAL = ACTION::OK THEN
            ln_Importe := lp_Dialogo.gfu_GetDialogoImporte
        ELSE
            EXIT;
        IF ln_Importe = 0 THEN ERROR(l_Text30000);
        Rec."Importe Rechazado" := ln_Importe;
        Rec.Modify();
        SalesReceivablesSetup.GET;
        if SalesReceivablesSetup."Crea Nuevo Evento" then begin
            lt_Evento.INIT;
            lt_Evento.TRANSFERFIELDS(Rec);
            lt_Evento."Importe Rechazado" := 0;
            lt_Evento."Codigo Evento" := '';
            lt_Evento.Estado := lt_Evento.Estado::Rechazado;
            lt_Evento."Evento Origen" := Rec."Codigo Evento";
            IF lt_Evento."Concepto Generico Facturacion" = '' THEN lt_Evento."Concepto Generico Facturacion" := lt_Evento.Descripcion;
            lt_Evento.INSERT(TRUE);
            SalesReceivablesSetup.TESTFIELD("Producto Eventos Archivados");
            lt_LineasEvento.INIT;
            lt_LineasEvento."Codigo Evento" := lt_Evento."Codigo Evento";
            lt_LineasEvento.Linea := 10000;
            lt_LineasEvento.Tipo := lt_LineasEvento.Tipo::Adulto;
            lt_LineasEvento.INSERT(TRUE);
            lt_LineasEvento.VALIDATE("No.", SalesReceivablesSetup."Producto Eventos Archivados");
            lt_LineasEvento.Cantidad := 1;
            lt_LineasEvento.VALIDATE("Precio Real", ln_Importe);
            lt_LineasEvento.MODIFY(TRUE);
            lt_Evento.gfu_CalculoCostesPrecios;
            lt_Evento.MODIFY;
        end;
        IF NOT Rec.CreadoEnsamblado THEN
            IF CONFIRM('Se va a archivar el evento, ¿desea que genere un pedido de ensamblado?') THEN BEGIN
                //Pedidos ensamblado
                gt_linevento.RESET;
                gt_linevento.SETRANGE(gt_linevento."Codigo Evento", Rec."Codigo Evento");
                IF gt_linevento.FINDSET THEN
                    REPEAT
                        gt_linevento.gfu_CreaRegPedEnsamblado;
                    UNTIL gt_linevento.NEXT = 0;
                //++ KR SGA
                lt_ProductosEvento.RESET;
                lt_ProductosEvento.SETRANGE(lt_ProductosEvento."Codigo Evento", Rec."Codigo Evento");
                IF lt_ProductosEvento.FINDSET THEN
                    REPEAT
                        lt_ProductosEvento.gfu_CreaRegPedEnsambladoKR;
                    UNTIL lt_ProductosEvento.NEXT = 0;
                //-- KR SGA
                Rec.CreadoEnsamblado := TRUE;
                Rec.MODIFY;
            END;
        if SalesReceivablesSetup."Crea Nuevo Evento" then
            MESSAGE(l_Text40000, lt_Evento."Codigo Evento")
        else
            Message('Proceso completo.');
    end;

    local procedure "//++ KR"()
    begin
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
                        //SL Productos intermedios no son tenidos en cuenta para el costo
                        //Evaluate(ItemNo, componentesEvento."No.");
                        //if not ItemNo.Contains('PI') then begin
                        // Sumamos coste
                        ComponentesEventos2.RESET;
                        ComponentesEventos2.SETRANGE("Codigo Evento", ComponentesEvento."Codigo Evento");
                        ComponentesEventos2.SETRANGE("Linea Evento", ComponentesEvento."Linea Evento");
                        ComponentesEventos2.SETRANGE("Parent Item No.", ComponentesEvento."No.");
                        //ComponentesEventos2.SetRange(Intermedio, false);
                        ComponentesEventos2.SetFilter(Type, '%1|%2', ComponentesEventos2.Type::Item, ComponentesEventos2.Type::Resource);
                        //++ PRimero actualizamos costes hijos
                        CalcularCosteLMRecursivo(ComponentesEventos2);
                        ComponentesEventos2.CALCSUMS("Coste Lote");
                        //--                        
                        ComponentesEvento."Coste Lote" := ComponentesEventos2."Coste Lote";
                        ComponentesEvento.CosteUnitario := 0;
                        IF ComponentesEvento."Cantidad por Lote" <> 0 THEN ComponentesEvento.CosteUnitario := ComponentesEvento."Coste Lote" / ComponentesEvento."Cantidad por Lote";
                        ComponentesEvento."Coste Calculado" := ComponentesEvento."Quantity per" * ComponentesEvento.CosteUnitario;
                        ComponentesEvento.MODIFY;
                        //end;
                    END;
                END;
            UNTIL ComponentesEvento.NEXT = 0;
    end;

    procedure gfu_CalculoCostesPreciosKR()
    var
        lt_LineaEventos: Record "Lineas Evento";
        lt_Componentes: Record "Componentes Evento";
        CosteMenu: Decimal;
        CosteRecursos: Decimal;
        PrecioRecursos: Decimal;
        lt_RecursosEvento: Record "Recursos Evento";
        CostePan: Decimal;
        SalesSetup: Record "Sales & Receivables Setup";
        ImpIVA: Decimal;
        lt_Item: Record Item;
        PorcIVA: Decimal;
        lt_Customer: Record Customer;
        lt_VATPostingSetup: Record "VAT Posting Setup";
        lt_CustTemplate: Record "Customer Templ.";
        NumLinea: Integer;
        lt_ProductosEvento: Record "Productos Evento";
        CosteRepartido: Decimal;
        "//++ KR": Integer;
        costeMenaje: Decimal;
        precioMenaje: Decimal;
    begin
        IF ("Total Adultos" = 0) AND ("Total Ninos" = 0) THEN ERROR(Text10000);
        GLSetup.GET;
        //Inicio ADV004
        //ADV004 lfu_CalculaPan;
        //ADV004 CostePan := "Importe Barras" + "Importe Pan Gallego" + "Importe Colines" + "Importe Alcachofas";
        //Fin ADV004
        //ADV003 Inicio
        IF "Oferta Mes Sin IVA" THEN BEGIN
            SalesSetup.GET;
            SalesSetup.TESTFIELD("Producto Oferta Mes sin IVA");
            lt_LineaEventos.RESET;
            lt_LineaEventos.SETRANGE("Codigo Evento", "Codigo Evento");
            lt_LineaEventos.SETRANGE("No.", SalesSetup."Producto Oferta Mes sin IVA");
            lt_LineaEventos.DELETEALL;
        END;
        //ADV003 Fin
        //Coste Recursos para luego repartir
        CosteRecursos := 0;
        PrecioRecursos := 0;
        CosteMenu := 0;
        //++ KR 29/01/22
        costeMenaje := 0;
        precioMenaje := 0;
        // Esto corresponde a personas
        lt_RecursosEvento.RESET;
        lt_RecursosEvento.SETRANGE("Codigo Evento", "Codigo Evento");
        IF lt_RecursosEvento.FINDSET THEN
            REPEAT
                CosteRecursos := CosteRecursos + lt_RecursosEvento."Coste Total";
                PrecioRecursos := PrecioRecursos + lt_RecursosEvento.Importe;
            UNTIL lt_RecursosEvento.NEXT = 0;
        // Inicio ADV004
        // esto corresponde a mensaje, suplementos y pan
        lt_ProductosEvento.RESET;
        lt_ProductosEvento.SETRANGE("Codigo Evento", "Codigo Evento");
        IF lt_ProductosEvento.FINDSET THEN
            REPEAT //++ KR 29/01/22
                //CosteRecursos := CosteRecursos + lt_ProductosEvento."Coste Total";
                //PrecioRecursos := PrecioRecursos + lt_ProductosEvento.Importe;
                costeMenaje := costeMenaje + lt_ProductosEvento."Coste Total";
                precioMenaje := precioMenaje + lt_ProductosEvento.Importe;
            //--
            UNTIL lt_ProductosEvento.NEXT = 0;
        //Fin ADV004
        // KR Actualizamos coste por línea para usarlo luego en los cálculos
        lt_LineaEventos.RESET;
        lt_LineaEventos.SETRANGE("Codigo Evento", Rec."Codigo Evento");
        //lt_LineaEventos.SETRANGE(Tipo, lt_LineaEventos.Tipo::Adulto);
        IF lt_LineaEventos.FINDSET THEN
            REPEAT
                lt_Componentes.RESET;
                lt_Componentes.SETCURRENTKEY("Codigo Evento", "Linea Evento", "Parent Item No.", "Line No.");
                lt_Componentes.SETRANGE("Codigo Evento", lt_LineaEventos."Codigo Evento");
                lt_Componentes.SETRANGE("Linea Evento", lt_LineaEventos.Linea);
                lt_Componentes.SETRANGE("Parent Item No.", lt_LineaEventos."No.");
                // KR 22/11/21 Actualizamos costes de hijos
                CalcularCosteLMRecursivo(lt_Componentes);
                //--
                lt_Componentes.CALCSUMS("Coste Lote");
                lt_LineaEventos."Coste Directo" := lt_Componentes."Coste Lote";
                lt_LineaEventos.MODIFY;
            //ADV004 CosteMenu := CosteMenu + lt_LineaEventos."Coste Directo";
            UNTIL lt_LineaEventos.NEXT = 0;
        // Inicio ADV004
        // Realizo un lectura previa de los menús Adulto, Niño y Especial para calcular el CosteMenu total y así poder hacer el reparto
        gd_CosteRecursos := CosteRecursos;
        lt_LineaEventos.RESET;
        lt_LineaEventos.SETRANGE("Codigo Evento", Rec."Codigo Evento");
        //lt_LineaEventos.SETRANGE(Tipo, lt_LineaEventos.Tipo::Adulto);
        IF lt_LineaEventos.FINDSET THEN
            REPEAT
                CosteMenu := CosteMenu + lt_LineaEventos."Coste Directo";
            UNTIL lt_LineaEventos.NEXT = 0;
        // Fin ADV004
        //Menú Adultos
        lt_LineaEventos.RESET;
        lt_LineaEventos.SETRANGE("Codigo Evento", Rec."Codigo Evento");
        //lt_LineaEventos.SETRANGE(Tipo, lt_LineaEventos.Tipo::Adulto);
        //++ KR
        lt_LineaEventos.SETFILTER(lt_LineaEventos."No.", '<>%1', '');
        //--
        IF lt_LineaEventos.FINDSET THEN
            REPEAT
                IF CosteMenu <> 0 THEN BEGIN
                    lt_LineaEventos."Coste Indirecto Recursos" := ROUND((CosteRecursos) * (lt_LineaEventos."Coste Directo" / CosteMenu), GLSetup."Amount Rounding Precision");
                    //ADV004 lt_LineaEventos."Coste Indirecto Pan" := ROUND((CostePan / ("Total Adultos"+"Total Ninos")) * (lt_LineaEventos."Coste Directo" / CosteMenu),GLSetup."Amount Rounding Precision");
                    IF ("Total Adultos" + "Total Ninos") <> 0 THEN
                        lt_LineaEventos."Precio Venta Recursos" := ROUND((PrecioRecursos / ("Total Adultos" + "Total Ninos")) * (lt_LineaEventos."Coste Directo" / CosteMenu), GLSetup."Amount Rounding Precision")
                    ELSE
                        lt_LineaEventos."Precio Venta Recursos" := 0;
                END
                ELSE BEGIN
                    lt_LineaEventos."Coste Indirecto Recursos" := 0;
                    lt_LineaEventos."Coste Indirecto Pan" := 0;
                    lt_LineaEventos."Precio Venta Recursos" := 0;
                END;
                // Inicio ADV007
                // ADV007 lt_LineaEventos."Coste Total" := lt_LineaEventos."Coste Directo" + (lt_LineaEventos."Coste Indirecto Recursos")+ (lt_LineaEventos."Coste Indirecto Pan"* lt_LineaEventos.Cantidad);
                //++ KR Eventos (28/11/21)
                //lt_LineaEventos."Coste Total" := lt_LineaEventos."Coste Directo" + lt_LineaEventos."Coste Indirecto Recursos";
                lt_LineaEventos."Coste Total" := lt_LineaEventos."Coste Directo" + lt_LineaEventos."Coste Indirecto Recursos";
                //lt_LineaEventos."Coste Total" := lt_LineaEventos."Coste Total" * lt_LineaEventos.Cantidad;
                //--
                lt_LineaEventos."Precio Propuesto" := 0;
                // Fin ADV007
                //++ KR eventos 28/11/21
                //lt_LineaEventos."Coste Total Unitario"  := lt_LineaEventos."Coste Total" / "Total Adultos";
                IF lt_LineaEventos.Tipo = lt_LineaEventos.Tipo::Adulto THEN BEGIN
                    IF "Total Adultos" <> 0 THEN
                        lt_LineaEventos."Coste Total Unitario" := lt_LineaEventos."Coste Total" / "Total Adultos"
                    ELSE
                        lt_LineaEventos."Coste Total Unitario" := 0;
                END
                ELSE BEGIN
                    IF lt_LineaEventos.Tipo = lt_LineaEventos.Tipo::Niño THEN BEGIN
                        IF "Total Ninos" <> 0 THEN
                            lt_LineaEventos."Coste Total Unitario" := lt_LineaEventos."Coste Total" / "Total Ninos"
                        ELSE
                            lt_LineaEventos."Coste Total Unitario" := 0;
                    END
                    ELSE BEGIN
                        IF lt_LineaEventos.Tipo = lt_LineaEventos.Tipo::Otros THEN BEGIN
                            IF ("Total Adultos" + "Total Ninos") <> 0 THEN
                                lt_LineaEventos."Coste Total Unitario" := lt_LineaEventos."Coste Total" / ("Total Adultos" + "Total Ninos")
                            ELSE
                                lt_LineaEventos."Coste Total Unitario" := 0;
                        END;
                    END;
                END;
                //--
                IF lt_LineaEventos."Tipo Margen" = lt_LineaEventos."Tipo Margen"::Importe THEN // Inicio ADV005
                    // ADV005 lt_LineaEventos."Precio Propuesto":= lt_LineaEventos."Coste Directo"  + (lt_LineaEventos.Cantidad * lt_LineaEventos."Valor Margen")
                    // ADV007 IF lt_LineaEventos."Precio Propuesto" = 0 THEN
                    // Inicio ADV007
                    // ADV007 lt_LineaEventos."Precio Propuesto":= lt_LineaEventos."Coste Directo"  + (lt_LineaEventos.Cantidad * lt_LineaEventos."Valor Margen")
                    lt_LineaEventos."Precio Propuesto" := lt_LineaEventos."Coste Total Unitario" + lt_LineaEventos."Valor Margen"
                // Fin ADV007
                // Fin ADV005
                ELSE IF lt_LineaEventos."Tipo Margen" = lt_LineaEventos."Tipo Margen"::Porcentaje THEN // Inicio ADV005
                                                                                                       // ADV005 lt_LineaEventos."Precio Propuesto":= lt_LineaEventos."Coste Directo" * (1 + lt_LineaEventos."Valor Margen"/100);
                                                                                                       // ADV007 IF lt_LineaEventos."Precio Propuesto" = 0 THEN
                                                                                                       // Inicio ADV007
                                                                                                       // ADV007 lt_LineaEventos."Precio Propuesto":= lt_LineaEventos."Coste Directo" * (1 + lt_LineaEventos."Valor Margen"/100);
                    lt_LineaEventos."Precio Propuesto" := lt_LineaEventos."Coste Total Unitario" * (1 + lt_LineaEventos."Valor Margen" / 100);
                // Fin ADV007
                // Fin ADV005
                // Inicio ADV005
                // ADV005 lt_LineaEventos."Precio Propuesto" := ROUND((lt_LineaEventos."Precio Propuesto" / "Total Adultos") + lt_LineaEventos."Coste Indirecto Pan" + lt_LineaEventos."Precio Venta Recursos",GLSetup."Amount Rounding Precision");
                // ADV007 IF lt_LineaEventos."Precio Propuesto" = 0 THEN
                // ADV007 lt_LineaEventos."Precio Propuesto" := ROUND((lt_LineaEventos."Precio Propuesto" / "Total Adultos") + lt_LineaEventos."Coste Indirecto Pan" + lt_LineaEventos."Precio Venta Recursos",GLSetup."Amount Rounding Precision");
                // Fin ADV005
                //lt_LineaEventos.VALIDATE("Precio Real",lt_LineaEventos."Precio Propuesto");
                lt_LineaEventos.MODIFY;
            UNTIL lt_LineaEventos.NEXT = 0;
        // Fin ADV004
        lt_LineaEventos.RESET;
        lt_LineaEventos.SETRANGE("Codigo Evento", Rec."Codigo Evento");
        lt_LineaEventos.CALCSUMS(Importe, "Importe IVA Incl.");
        lt_RecursosEvento.RESET;
        lt_RecursosEvento.SETRANGE("Codigo Evento", "Codigo Evento");
        lt_RecursosEvento.CALCSUMS(Importe, "Importe IVA Incl.");
        // Inicio ADV006
        lt_ProductosEvento.RESET;
        lt_ProductosEvento.SETRANGE("Codigo Evento", "Codigo Evento");
        lt_ProductosEvento.CALCSUMS(lt_ProductosEvento.Importe, lt_ProductosEvento."Importe IVA Incl.");
        // FIn ADV006
        // Inicio ADV006
        // ADV006 Rec."Importe Total Evento" := lt_LineaEventos.Importe + lt_RecursosEvento.Importe;
        // ADV006 Rec."Importe Total IVA Incluido" := lt_LineaEventos."Importe IVA Incl." + lt_RecursosEvento."Importe IVA Incl.";
        Rec."Importe Total Evento" := lt_LineaEventos.Importe + lt_RecursosEvento.Importe + lt_ProductosEvento.Importe;
        Rec."Importe Total IVA Incluido" := lt_LineaEventos."Importe IVA Incl." + lt_RecursosEvento."Importe IVA Incl." + lt_ProductosEvento."Importe IVA Incl.";
        // Fin ADV006
        // Inicio ADV004
        Rec."Coste Total Recursos" := CosteRecursos;
        //++ KR Eventos 28/11/21
        Rec.NuevoCosteTotalDirecto := CosteMenu + costeMenaje;
        Rec.CALCFIELDS("Coste Total Elaboracion");
        //--
        //Rec."Coste Total Visualizado" := Rec."Coste Total Elaboracion" + Rec."Coste Total Recursos";
        //++ KR 29/01/22
        Rec."Coste Total Visualizado" := Rec.NuevoCosteTotalDirecto + Rec."Coste Total Recursos";
        // Fin ADV004
        MODIFY;
        //ADV003 Inicio
        IF "Oferta Mes Sin IVA" THEN BEGIN
            ImpIVA := "Importe Total IVA Incluido" - "Importe Total Evento";
            IF ImpIVA <> 0 THEN BEGIN
                SalesSetup.GET;
                lt_Item.GET(SalesSetup."Producto Oferta Mes sin IVA");
                PorcIVA := 0;
                IF "Codigo Cliente" <> '' THEN BEGIN
                    lt_Customer.GET("Codigo Cliente");
                    lt_VATPostingSetup.GET(lt_Customer."VAT Bus. Posting Group", lt_Item."VAT Prod. Posting Group");
                    PorcIVA := lt_VATPostingSetup."VAT %";
                END
                ELSE BEGIN
                    TESTFIELD("Plantilla Cliente");
                    lt_CustTemplate.GET("Plantilla Cliente");
                    lt_VATPostingSetup.GET(lt_CustTemplate."VAT Bus. Posting Group", lt_Item."VAT Prod. Posting Group");
                    PorcIVA := lt_VATPostingSetup."VAT %";
                END;
                NumLinea := 10000;
                lt_LineaEventos.RESET;
                lt_LineaEventos.SETRANGE("Codigo Evento", "Codigo Evento");
                IF lt_LineaEventos.FINDLAST THEN NumLinea := lt_LineaEventos.Linea + 10000;
                lt_LineaEventos.INIT;
                lt_LineaEventos."Codigo Evento" := "Codigo Evento";
                lt_LineaEventos.Linea := NumLinea;
                lt_LineaEventos.Tipo := lt_LineaEventos.Tipo::Otros;
                lt_LineaEventos.INSERT;
                lt_LineaEventos.VALIDATE("No.", SalesSetup."Producto Oferta Mes sin IVA");
                lt_LineaEventos.VALIDATE(Cantidad, -1);
                lt_LineaEventos.VALIDATE("Precio Real", ROUND(ImpIVA / (1 + (PorcIVA / 100)), 0.001));
                lt_LineaEventos.MODIFY;
                lt_LineaEventos.RESET;
                lt_LineaEventos.SETRANGE("Codigo Evento", Rec."Codigo Evento");
                lt_LineaEventos.CALCSUMS(Importe, "Importe IVA Incl.");
                lt_RecursosEvento.RESET;
                lt_RecursosEvento.SETRANGE("Codigo Evento", "Codigo Evento");
                lt_RecursosEvento.CALCSUMS(Importe, "Importe IVA Incl.");
                // Inicio ADV008
                lt_ProductosEvento.RESET;
                lt_ProductosEvento.SETRANGE("Codigo Evento", lt_ProductosEvento."Codigo Evento");
                lt_ProductosEvento.CALCSUMS(Importe, lt_ProductosEvento."Importe IVA Incl.");
                // Fin ADV008
                // Inicio ADV008
                // ADV008 Rec."Importe Total Evento" := lt_LineaEventos.Importe + lt_RecursosEvento.Importe;
                Rec."Importe Total Evento" := lt_LineaEventos.Importe + lt_RecursosEvento.Importe + lt_ProductosEvento.Importe;
                // ADV008 Rec."Importe Total IVA Incluido" := lt_LineaEventos."Importe IVA Incl." + lt_RecursosEvento."Importe IVA Incl.";
                Rec."Importe Total IVA Incluido" := lt_LineaEventos."Importe IVA Incl." + lt_RecursosEvento."Importe IVA Incl." + lt_ProductosEvento."Importe IVA Incl.";
                // Fin ADV008
                // Inicio ADV004
                Rec."Coste Total Recursos" := CosteRecursos;
                //++ KR Eventos 28/11/21
                Rec.CALCFIELDS("Coste Total Elaboracion");
                //--
                Rec."Coste Total Visualizado" := Rec."Coste Total Elaboracion" + Rec."Coste Total Recursos";
                // Fin ADV004
                MODIFY;
            END;
        END;
        //ADV003 Fin
    end;

    procedure getEventoArhivado(): Decimal
    var
        rEvento: Record Evento;
    begin
        if Rec."Evento Origen" <> '' then begin
            rEvento.SetRange("Codigo Evento", Rec."Evento Origen");
            if rEvento.FindFirst() then exit(rEvento."Importe Rechazado")
        end;
    end;
}
