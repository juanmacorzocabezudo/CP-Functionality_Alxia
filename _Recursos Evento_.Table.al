table 50003 "Recursos Evento"
{
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
        field(3; "Codigo Recurso"; Code[20])
        {
            TableRelation = Resource;

            /*   trigger OnLookup()
              var
                  Resource: Record Resource;
              begin
                  IF Tipo = Rec.Tipo::Personal THEN
                      Resource.SETRANGE("Resource Group No.", 'PERSONAL')
                  ELSE
                      IF Tipo = Rec.Tipo::Otros THEN
                          Resource.SETFILTER("Resource Group No.", '%1|%2', 'MOBILIARIO', 'TRANSPORTE')
                      ELSE
                          IF Tipo = Rec.Tipo::Menaje THEN
                              Resource.SETRANGE("Resource Group No.", 'MENAJE')
                          ELSE
                              IF Tipo = Rec.Tipo::Suplementos THEN
                                  Resource.SETRANGE("Resource Group No.", 'SUPLEMENTOS')
                              ELSE
                                  IF Tipo = Rec.Tipo::Pan THEN
                                      Resource.SETRANGE("Resource Group No.", 'PAN');


                  IF PAGE.RUNMODAL(0, Resource) = ACTION::LookupOK THEN
                      VALIDATE("Codigo Recurso", Resource."No.");
              end; */
            trigger OnValidate()
            var
                lt_Evento: Record Evento;
                lt_Customer: Record Customer;
                lt_VATPostingSetup: Record "VAT Posting Setup";
                lt_CustTemplate: Record "Customer Templ.";
            begin
                //ADV003 Inicio
                IF(Rec."Codigo Recurso" <> xRec."Codigo Recurso") AND (xRec."Codigo Recurso" <> '')THEN BEGIN
                    ERROR('No se puede modificar un recuso.Tiene que eliminar la línea y crearla de nuevo');
                END;
                //ADV003 Fin
                IF "Codigo Recurso" <> '' THEN BEGIN
                    gt_recurso.GET("Codigo Recurso");
                    Descripcion:=gt_recurso.Name;
                    "Unidad de medida":=gt_recurso."Base Unit of Measure";
                    "Tipo Recurso":=gt_recurso.Type;
                    lt_Evento.GET("Codigo Evento");
                    IF lt_Evento."Codigo Cliente" <> '' THEN BEGIN
                        lt_Customer.GET(lt_Evento."Codigo Cliente");
                        lt_VATPostingSetup.GET(lt_Customer."VAT Bus. Posting Group", gt_recurso."VAT Prod. Posting Group");
                        "% IVA":=lt_VATPostingSetup."VAT %";
                    END
                    ELSE
                    BEGIN
                        lt_Evento.TESTFIELD("Plantilla Cliente");
                        lt_CustTemplate.GET(lt_Evento."Plantilla Cliente");
                        lt_VATPostingSetup.GET(lt_CustTemplate."VAT Bus. Posting Group", gt_recurso."VAT Prod. Posting Group");
                        "% IVA":=lt_VATPostingSetup."VAT %";
                    END;
                END
                ELSE
                BEGIN
                    Descripcion:='';
                    "Unidad de medida":='';
                    "Tipo Recurso":=0;
                    "% IVA":=0;
                END;
            end;
        }
        field(4; Descripcion; Text[50])
        {
        }
        field(5; "Tipo Recurso"; Option)
        {
            Editable = false;
            OptionMembers = Persona, Maquina;
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
            TableRelation = "Resource Unit of Measure".Code WHERE("Resource No."=FIELD("Codigo Recurso"));
        }
        field(8; "Coste Unitario"; Decimal)
        {
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
            OptionMembers = Porcentaje, Importe;

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
            OptionMembers = Personal, Otros, Menaje, Suplementos, Pan;
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
        field(27; ImprCapitulo; Code[20])
        {
            Caption = 'Capitulo';
            TableRelation = AlxImpresionCapitulos.Code;

            trigger OnValidate()
            var
                lt_Capitulo: Record "AlxImpresionCapitulos";
            begin
                IF(ImprCapitulo <> xRec.ImprCapitulo) and (ImprCapitulo <> '')THEN BEGIN
                    lt_Capitulo.GET(ImprCapitulo);
                    DescripCapitulo:=lt_Capitulo.Descripcion;
                END
                ELSE
                    DescripCapitulo:='';
            end;
        }
        field(28; DescripCapitulo; Text[150])
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
        gt_linrecurso.RESET;
        gt_linrecurso.SETRANGE(gt_linrecurso."Codigo Evento", "Codigo Evento");
        gt_linrecurso.SETRANGE(gt_linrecurso."Linea Recurso Evento", Linea);
        IF gt_linrecurso.FINDSET THEN REPEAT gt_linrecurso.DELETE(TRUE);
            UNTIL gt_linrecurso.NEXT = 0;
    end;
    trigger OnInsert()
    var
        lt_Capitulo: Record "AlxImpresionCapitulos";
    begin
        gt_evento.GET("Codigo Evento");
        //"Hora Evento" := gt_evento."Hora Evento";
        "Tipo Margen":="Tipo Margen"::Porcentaje;
        "Valor Margen":=gt_evento."% Beneficio";
        if Rec."Tipo Recurso" = Rec."Tipo Recurso"::Persona then begin
            ImprCapitulo:='PERSONAL';
            if lt_Capitulo.GET(ImprCapitulo)then;
            DescripCapitulo:=lt_Capitulo.Descripcion;
        end;
        if Rec."Tipo Recurso" = Rec."Tipo Recurso"::Maquina then begin
            ImprCapitulo:='TRANSPORTE';
            if lt_Capitulo.GET(ImprCapitulo)then;
            DescripCapitulo:=lt_Capitulo.Descripcion;
        end;
    end;
    var gt_evento: Record Evento;
    gt_recurso: Record Resource;
    gt_linrecurso: Record "Asignacion Recursos Eventos";
    local procedure lfu_CalculaImporte()
    var
        GLSetup: Record "General Ledger Setup";
    begin
        GLSetup.GET;
        Importe:=ROUND(Rec.Cantidad * Rec."Precio Real", GLSetup."Amount Rounding Precision");
        "Importe IVA Incl.":=ROUND(Importe * (1 + "% IVA" / 100), GLSetup."Amount Rounding Precision");
        "Precio IVA Incl.":=ROUND("Precio Real" * (1 + "% IVA" / 100), GLSetup."Amount Rounding Precision");
    end;
    local procedure lfu_CalculaPreciosCantidad()
    begin
        IF(xRec."Coste Unitario" <> Rec."Coste Unitario") OR (xRec."Tipo Margen" <> Rec."Tipo Margen") OR (xRec."Valor Margen" <> Rec."Valor Margen")THEN BEGIN
            gt_recurso.GET("Codigo Recurso");
            // "Coste Unitario" := gt_recurso."Unit Cost";
            "Coste Total":=Cantidad * "Coste Unitario";
            // Precio := gt_recurso."Unit Price";
            IF "Tipo Margen" = Rec."Tipo Margen"::Porcentaje THEN "Precio Propuesto":=("Coste Total" * (1 + "Valor Margen" / 100)) / Cantidad
            ELSE IF "Tipo Margen" = Rec."Tipo Margen"::Importe THEN "Precio Propuesto":=("Coste Total" + (Cantidad * "Valor Margen")) / Cantidad;
            // Inicio ADV002
            // ADV002 "Precio Real" := "Precio Propuesto";
            // Fin ADV002
            lfu_CalculaImporte;
        END;
    end;
    local procedure lfu_CalculaPrecios()
    var
        IsHandle: Boolean;
    begin
        IF(xRec.Cantidad <> Rec.Cantidad) OR (xRec."Tipo Margen" <> Rec."Tipo Margen") OR (xRec."Valor Margen" <> Rec."Valor Margen")THEN BEGIN
            gt_recurso.GET("Codigo Recurso");
            /*     // GAP00039 >>>
                IsHandle := true;
                OnBeforeCalcularCosteUnitario(Rec, gt_recurso, IsHandle);
                if IsHandle then
                    // GAP00039 <<< */
            if(xRec."Coste Unitario" = Rec."Coste Unitario") and (Rec."Coste Unitario" <> 0)then "Coste Unitario":=Rec."Coste Unitario"
            else
                "Coste Unitario":=gt_recurso."Unit Cost";
            "Coste Total":=Cantidad * "Coste Unitario";
            Precio:=gt_recurso."Unit Price";
            IF "Tipo Margen" = Rec."Tipo Margen"::Porcentaje THEN "Precio Propuesto":=("Coste Total" * (1 + "Valor Margen" / 100)) / Cantidad
            ELSE IF "Tipo Margen" = Rec."Tipo Margen"::Importe THEN "Precio Propuesto":=("Coste Total" + (Cantidad * "Valor Margen")) / Cantidad;
            // Inicio ADV002
            // ADV002 "Precio Real" := "Precio Propuesto";
            // Fin ADV002
            lfu_CalculaImporte;
        END;
    end;
/*  // GAP00039 >>>
     [IntegrationEvent(false, false)]
     local procedure OnBeforeCalcularCosteUnitario(var RecursoEvento: Record "Recursos Evento"; Recurso: Record Resource; var IsHandle: Boolean)
     begin
     end; */
// GAP00039 <<<
}
