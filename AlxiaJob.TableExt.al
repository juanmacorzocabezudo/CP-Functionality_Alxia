tableextension 50020 AlxiaJob extends Job
{
    fields
    {
        field(50000; Estado; Option)
        {
            Caption = 'Estado';
            DataClassification = CustomerContent;
            OptionCaption = 'Presupuesto,Aceptado,Rechazado,Anulado,Realizado,Archivado,En proceso';
            OptionMembers = Presupuesto, Aceptado, Rechazado, Anulado, Realizado, Archivado, EnProceso;
        }
        field(50001; "Tipo Evento"; Code[20])
        {
            Caption = 'Tipo Evento';
            DataClassification = CustomerContent;

            ;
            TableRelation = "Tipo de Evento".Codigo;

            trigger OnValidate()
            begin
                lfu_CalculaPan;
            end;
        }
        field(50002; "Hora Evento"; Time)
        {
            Caption = 'Hora Evento';
            DataClassification = CustomerContent;

            ;
            trigger OnValidate()
            begin
                IF("Hora Evento" >= 070100T) AND ("Hora Evento" < 100100T)THEN "Franja horaria":="Franja horaria"::Desayuno
                ELSE IF("Hora Evento" >= 100100T) AND ("Hora Evento" < 130100T)THEN "Franja horaria":="Franja horaria"::Almuerzo
                    ELSE IF("Hora Evento" >= 130100T) AND ("Hora Evento" < 170100T)THEN "Franja horaria":="Franja horaria"::Comida
                        ELSE IF("Hora Evento" >= 170100T) AND ("Hora Evento" < 193100T)THEN "Franja horaria":="Franja horaria"::Merienda
                            ELSE IF("Hora Evento" >= 193100T) AND ("Hora Evento" < 223100T)THEN "Franja horaria":="Franja horaria"::Cena
                                ELSE IF(("Hora Evento" >= 223100T) AND ("Hora Evento" <= 235959T)) OR (("Hora Evento" >= 000000T) AND ("Hora Evento" < 010100T))THEN "Franja horaria":="Franja horaria"::Recena
                                    ELSE IF("Hora Evento" >= 010100T) AND ("Hora Evento" < 070100T)THEN "Franja horaria":="Franja horaria"::Madrugada
                                        ELSE
                                            "Franja horaria":="Franja horaria"::" ";
            end;
        }
        field(50003; "Total Adultos"; Integer)
        {
            Caption = 'Total Adultos';
            DataClassification = CustomerContent;

            ;
            trigger OnValidate()
            begin
                lfu_CalculaPan;
                //si hay líneas aviso
                gt_lineas2.RESET;
                gt_lineas2.SETRANGE(gt_lineas2."Job No.", Rec."No.");
                IF gt_lineas2.FINDSET THEN MESSAGE('Recuerde que tiene que repasar las líneas de evento para que el número de comensales coincida');
            end;
        }
        field(50004; "Total Ninos"; Integer)
        {
            Caption = 'Total Ninos';
            DataClassification = CustomerContent;

            ;
            trigger OnValidate()
            begin
                lfu_CalculaPan;
                //si hay líneas aviso
                gt_lineas2.RESET;
                gt_lineas2.SETRANGE(gt_lineas2."Job No.", Rec."No.");
                IF gt_lineas2.FINDSET THEN MESSAGE('Recuerde que tiene que repasar las líneas de evento para que el número de comensales coincida');
            end;
        }
        field(50005; "% Beneficio"; Decimal)
        {
            Caption = '% Beneficio';
            DataClassification = CustomerContent;

            ;
        }
        /*   field(50006; "Coste Total"; Decimal)
          {
              Caption = 'Coste Total';

              CalcFormula = Sum("Job Task"."Usage (Total Cost)" WHERE("Job No." = FIELD("No.")));
              Editable = false;
              FieldClass = FlowField;
          } */
        /*   field(50007; "Coste Menu Adulto"; Decimal)
          {
              Caption = 'Coste Menu Adulto';
              CalcFormula = Sum("Job Task"."Usage (Total Price)" WHERE("Job No." = FIELD("No."),
                                                                              Tipo = CONST(Adulto)));
              Caption = 'Coste Menú Adulto';

              //
              Editable = false;
              FieldClass = FlowField;
          } */
        /*   field(50008; "Coste Menu Nino"; Decimal)
          {
              Caption = 'Coste Menu Nino';
             DataClassification = CustomerContent;;
          } */
        /*    field(50009; "Coste Menu Otros"; Decimal)
           {
               Caption = 'Coste Menu Otros';
              DataClassification = CustomerContent;;
           } */
        /*     field(50010; "Precio Menu Adulto"; Decimal)
            {
                Caption = 'Precio Menu Adulto';
               DataClassification = CustomerContent;;
            } */
        /*   field(50011; "Precio Menu Nino"; Decimal)
          {
              Caption = 'Precio Menu Nino';
             DataClassification = CustomerContent;;
          }
          field(50012; "Precio Otros Menus"; Decimal)
          {
              Caption = 'Precio Otros Menus';
             DataClassification = CustomerContent;;
          } */
        field(50013; "Importe Total Evento"; Decimal)
        {
            Caption = 'Importe Total Evento';
            DataClassification = CustomerContent;

            ;
        }
        field(50014; "Importe Total IVA Incluido"; Decimal)
        {
            Caption = 'Importe Total IVA Incluido';
            DataClassification = CustomerContent;

            ;
        }
        /*  field(50015; "Coste Total Elaboracion"; Decimal)
         {
             Caption = 'Coste Total Elaboracion';
            DataClassification = CustomerContent;;
         } */
        /*     field(50016; "Coste Total Recursos"; Decimal)
            {
                Caption = 'Coste Total Recursos';
               DataClassification = CustomerContent;;
            } */
        field(50017; "Fecha Evento"; Date)
        {
            Caption = 'Fecha Evento';
            DataClassification = CustomerContent;

            ;
        }
        field(50018; Poblacion; Text[30])
        {
            Caption = 'Poblacion';
            DataClassification = CustomerContent;

            ;
        }
        field(50019; Senalizado; Boolean)
        {
            Caption = 'Señalizado';
            DataClassification = CustomerContent;

            ;
        }
        field(50020; "Imp Senal"; Decimal)
        {
            Caption = 'Importe Señal';
            DataClassification = CustomerContent;

            ;
        }
        field(50021; Contratado; Boolean)
        {
            Caption = 'Contratado';
            DataClassification = CustomerContent;

            ;
        }
        field(50022; "Motivo Anulacion"; Text[50])
        {
            Caption = 'Motivo Anulacion';
            DataClassification = CustomerContent;

            ;
        }
        field(50023; "Variedad Evento"; Code[20])
        {
            Caption = 'Variedad Evento';
            DataClassification = CustomerContent;

            ;
            TableRelation = "Variedad de Evento";

            trigger OnValidate()
            begin
                lfu_CalculaPan;
            end;
        }
        field(50024; "Codigo Contacto"; Code[20])
        {
            Caption = 'Codigo Contacto';
            DataClassification = CustomerContent;

            ;
        }
        field(50025; Comentario; Text[250])
        {
            Caption = 'Comentario';
            DataClassification = CustomerContent;

            ;
        }
        field(50026; "Cod Teminos Pago"; Code[10])
        {
            Caption = 'Cod Terminos Pago';
            DataClassification = CustomerContent;

            ;
            TableRelation = "Payment Terms";
        }
        field(50027; "Cod Forma Pago"; Code[10])
        {
            Caption = 'Cod Forma Pago';
            DataClassification = CustomerContent;

            ;
            TableRelation = "Payment Method";

            trigger OnValidate()
            var
                PaymentMethod: Record 289;
            begin
            end;
        }
        field(50028; Barras; Decimal)
        {
            Caption = 'Barras';
            DataClassification = CustomerContent;

            ;
        }
        field(50029; Gallegas; Decimal)
        {
            Caption = 'Gallegas';
            DataClassification = CustomerContent;

            ;
        }
        field(50030; Colines; Decimal)
        {
            Caption = 'Colines';
            DataClassification = CustomerContent;

            ;
        }
        field(50031; Alcachofas; Decimal)
        {
            Caption = 'Alcachofas';
            DataClassification = CustomerContent;

            ;
        }
        field(50032; "Importe Barras"; Decimal)
        {
            Caption = 'Importe Barras';
            DataClassification = CustomerContent;

            ;
        }
        field(50033; "Importe Pan Gallego"; Decimal)
        {
            Caption = 'Importe Pan Gallego';
            DataClassification = CustomerContent;

            ;
        }
        field(50034; "Importe Colines"; Decimal)
        {
            Caption = 'Importe Colines';
            DataClassification = CustomerContent;

            ;
        }
        field(50035; "Importe Alcachofas"; Decimal)
        {
            Caption = 'Importe Alcachofas';
            DataClassification = CustomerContent;

            ;
        }
        field(50036; "Concepto Generico Facturacion"; Text[100])
        {
            Caption = 'Concepto Generico Facturacion';
            DataClassification = CustomerContent;

            ;
        }
        field(50037; "Cod Pais"; Code[10])
        {
            Caption = 'Cod Pais';
            DataClassification = CustomerContent;

            ;
            TableRelation = "Country/Region";
        }
        field(50038; Vehiculo; Code[20])
        {
            Caption = 'Vehiculo';
            DataClassification = CustomerContent;

            ;
            Enabled = false;
            TableRelation = Resource;
        }
        field(50039; CodVendedor; Code[10])
        {
            DataClassification = CustomerContent;

            ;
            Caption = 'Codigo Vendedor';
            TableRelation = "Salesperson/Purchaser";

            trigger OnValidate()
            var
                lt_Vendedor: Record "Salesperson/Purchaser";
            begin
                IF CodVendedor = '' THEN "Commission %":=0
                ELSE
                BEGIN
                    lt_Vendedor.GET(CodVendedor);
                    "Commission %":=lt_Vendedor."Commission %";
                END;
            end;
        }
        field(50040; "Commission %"; Decimal)
        {
            Caption = 'Commission %';
            DataClassification = CustomerContent;

            ;
        }
        field(50041; ComoNosConociste; Code[10])
        {
            Caption = 'ComoNosConociste';
            DataClassification = CustomerContent;

            ;
        }
        field(50042; FechaAlta; Date)
        {
            Caption = 'Fecha Alta';
            DataClassification = CustomerContent;

            ;
        }
        field(50043; "Evento Origen"; Code[20])
        {
            Caption = 'Evento Origen';
            DataClassification = CustomerContent;

            ;
            TableRelation = Evento;
        }
        field(50044; "Franja horaria"; Option)
        {
            Caption = 'Franja horaria';
            DataClassification = CustomerContent;

            ;
            OptionMembers = " ", Desayuno, Almuerzo, Comida, Merienda, Cena, Recena, Madrugada;
            Editable = false;
        }
        field(50045; "Doble Pan"; Boolean)
        {
            Caption = 'Doble Pan';
            DataClassification = CustomerContent;

            ;
        }
        field(50046; "Nada Pan"; Boolean)
        {
            Caption = 'Nada Pan';
            DataClassification = CustomerContent;

            ;
        }
        field(50047; "Observaciones Internas"; Text[250])
        {
            Caption = 'Observaciones Internas';
            DataClassification = CustomerContent;

            ;
        }
        field(50048; "Codigo Postal 2"; Code[20])
        {
            DataClassification = CustomerContent;

            ;
            Caption = 'Código Postal Evento';
            TableRelation = "Post Code".Code;

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode("Poblacion 2", "Codigo Postal 2", "Provincia 2", "Cod Pais", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(50049; "Poblacion 2"; Text[30])
        {
            Caption = 'Población Evento';
            DataClassification = CustomerContent;

            ;
        }
        field(50050; "Provincia 2"; Text[30])
        {
            DataClassification = CustomerContent;

            ;
            Caption = 'Provincia Evento';
            TableRelation = Area.Code;

            trigger OnValidate()
            begin
                PostCode.ValidateCity("Poblacion 2", "Codigo Postal 2", "Provincia 2", "Cod Pais", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(50051; EquipoVendedor; Code[10])
        {
            Caption = 'Equipo Vendedor';
            CalcFormula = Min("Team Salesperson"."Team Code" WHERE("Salesperson Code"=FIELD(CodVendedor)));
            Description = 'ADV001';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50052; "Oferta Mes Sin IVA"; Boolean)
        {
            Caption = 'Oferta Mes Sin IVA';
            DataClassification = CustomerContent;

            ;
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
                    lt_LineasEvento.SETRANGE("Codigo Evento", "No.");
                    lt_LineasEvento.SETRANGE("No.", lt_SalesSetup."Producto Oferta Mes sin IVA");
                    IF lt_LineasEvento.FINDFIRST THEN IF CONFIRM(Text80000, FALSE)THEN lt_LineasEvento.DELETEALL;
                END;
            //ADV003 Fin
            end;
        }
        field(50053; Comentario2; Text[250])
        {
            Caption = 'Comentario2';
            DataClassification = CustomerContent;

            ;
        }
        field(50054; CreadoEnsamblado; Boolean)
        {
            Caption = 'CreadoEnsamblado';
            CalcFormula = Exist("Assembly Header" WHERE(NoEvento=FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50055; "Coste Total Visualizado"; Decimal)
        {
            Caption = 'Coste Total Visualizado';
            DataClassification = CustomerContent;

            ;
        }
        field(50056; NuevoCosteTotalDirecto; Decimal)
        {
            Caption = 'NuevoCosteTotalDirecto';
            DataClassification = CustomerContent;

            ;
        }
        field(50057; AGRALATraspasadoH; Boolean)
        {
            Caption = 'AGRALATraspasadoH';
            DataClassification = CustomerContent;

            ;
        }
        field(50058; "Plantilla Cliente"; Code[20])
        {
            TableRelation = "Customer Templ.".Code;
        }
        field(50059; "Telefono 2"; Code[1024])
        {
            Caption = 'Teléfono Evento';
            ExtendedDatatype = PhoneNo;
        }
        field(50060; "Direccion 2"; Text[2048])
        {
            Caption = 'Dirección Evento';
        }
        field(50061; "Persona de Contacto 2"; Text[2048])
        {
            Caption = 'Persona de Contacto Evento';
        }
        field(50062; "E-Mail 2"; Text[2048])
        {
            Caption = 'E-Mail Evento';
        }
    }
    keys
    {
        key(Key2; "Fecha Evento", "Hora Evento")
        {
        }
    }
    var gt_lineas2: Record "Job Task";
    SalesSetup: Record "Sales & Receivables Setup";
    // NoSeriesMgt: Codeunit "No. Series";
    gt_lineas: Record "Lineas Evento";
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
    Text20000: Label '<&Presupuesto,&Aceptado,R&echazado,A&nulado,&Realizado,&Archivado,&En Proceso>';
    Text30000: Label 'Crear Sólo Contacto,Crear Cliente y Contacto';
    Text40000: Label 'El Contacto Nº %1 ya tiene un cliente relacionado.';
    Text50000: Label '¿Desea crear un nuevo Cliente y relacionarlo con el Contacto Nº %1?';
    Text60000: Label 'Debe crear el cliente o seleccionar uno existente.';
    Text70000: Label 'Se ha creado el el Pedido Nº %1.';
    Text80000: Label 'Existen lineas del evento con el Producto Oferta Mes sin IVA. ¿Desea eliminarlas?';
    gd_CosteRecursos: Decimal;
    local procedure lfu_CalculaPan()
    var
        Rcd_Calculopan: Record "Calculo pan";
        Comensales: Integer;
    begin
        Barras:=0;
        Gallegas:=0;
        Colines:=0;
        Alcachofas:=0;
        "Importe Barras":=0;
        "Importe Pan Gallego":=0;
        "Importe Colines":=0;
        "Importe Alcachofas":=0;
        IF NOT "Nada Pan" THEN BEGIN
            IF("Total Adultos" <> 0) OR ("Total Ninos" <> 0)THEN IF Rcd_Calculopan.GET("Tipo Evento", "Variedad Evento")THEN BEGIN
                    Comensales:="Total Adultos" + "Total Ninos";
                    Barras:=ROUND(Comensales * Rcd_Calculopan."Cantidad Barras", 1, '>');
                    Gallegas:=ROUND(Comensales * Rcd_Calculopan."Cantidad Pan Gallego", 1, '>');
                    Colines:=ROUND(Comensales * Rcd_Calculopan."Cantidad Colines", 1, '>');
                    Alcachofas:=ROUND(Comensales * Rcd_Calculopan."Cantidad Alcachofas", 1, '>');
                    IF "Doble Pan" THEN BEGIN
                        Barras:=2 * Barras;
                        Gallegas:=2 * Gallegas;
                        Colines:=2 * Colines;
                        Alcachofas:=2 * Alcachofas;
                    END;
                    "Importe Barras":=Barras * Rcd_Calculopan."Precio Barras";
                    "Importe Pan Gallego":=Gallegas * Rcd_Calculopan."Precio Pan Gallego";
                    "Importe Colines":=Colines * Rcd_Calculopan."Precio Colines";
                    "Importe Alcachofas":=Alcachofas * Rcd_Calculopan."Precio Alcachofas";
                END;
        END;
    end;
    procedure gfu_CambiarEstado()
    var
        Selection: Integer;
    begin
    /*      Selection := STRMENU(Text20000);
             IF Selection = 0 THEN
                 EXIT;

             IF Selection = 5 THEN BEGIN     //Realizado
                 IF "Bill-to Customer No." = '' THEN
                     ERROR(Text60000);

                 lfu_CreaPedido;
                 Estado := Selection - 1;
                 MODIFY;
             END ELSE
                 IF Selection = 6 THEN BEGIN  //Archivado
                     lfu_ArchivaEvento;
                 END ELSE BEGIN
                     Estado := Selection - 1;
                     MODIFY;
                 END;

             //++ AGRALAMO - 210021 -54
             IF Selection = 7 THEN BEGIN
                 Estado := Estado::EnProceso;
                 MODIFY;
             END
             //-- AGRALAMO - 210021 - 54 */
    end;
}
