tableextension 50022 AlxiaItemVariant extends "Item Variant"
{
    DataCaptionFields = "Item No.", "Code", Description;

    fields
    {
        field(50000; AGRALACodProveedor; Text[250])
        {
            CalcFormula = Lookup("Item Vendor"."Vendor No." WHERE("Item No."=FIELD("Item No."), "Variant Code"=FIELD(Code)));
            Caption = 'Cód. Proveedor';
            Description = '#210021';
            //Editable = false;
            FieldClass = FlowField;
            TableRelation = Vendor."No.";
        /* trigger OnLookup()
            var
                rlItemVendor: Record 99;
            begin
                rlItemVendor.SETRANGE("Item No.", "Item No.");
                rlItemVendor.SETRANGE("Variant Code", Code);
                PAGE.RUN(114, rlItemVendor);
            end; */
        }
        field(50001; AGRALANombreProveedor; Text[120])
        {
            CalcFormula = Lookup(Vendor.Name WHERE("No."=FIELD(AGRALACodProveedor)));
            Caption = 'Nombre proveedor';
            Description = '#210021';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50002; AGRALADescripcion; Text[150])
        {
            CalcFormula = Lookup(Item.Description WHERE("No."=FIELD("Item No.")));
            Caption = 'Descripción del producto';
            Description = '#210021';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50003; AGRALAFichaTecnica; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Ficha técnica';
            Description = '#210021';
        }
        field(50004; AGRALAFechaVencimientoFT; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Vencimiento FT';
            Description = '#210021';
        }
        field(50005; AGRALAOMG; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Ingredientes OMG (Si/No)';
            Description = '#210021';
            Editable = false;
        }
        field(50006; AGRALAIrradiado; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Ingredientes Irradiado (Si/No)';
            Description = '#210021';
            Editable = false;
        }
        field(50007; AGRALADeclaraciondeConformidad; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Declaración de conformidad';
            Description = '#210021';
        }
        field(50008; AGRALAFechaVigorDC; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Vigor';
            Description = '#210021';
        }
        field(50009; AGRALAEnsayosMigracion; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Ensayo migración';
            Description = '#210021';
        }
        field(50010; AGRALAOtrosEnsayos; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Otros ensayos';
            Description = '#210021';
        }
        field(50011; AGRALANHA; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Nº HA';
            Description = '#210021';
        }
        field(50012; AGRALAFichaSeguridad; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Ficha Seguridad';
            Description = '#210021';
        }
        field(50013; AGRALAFechaVencimientoFS; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha vencimiento FS';
            Description = '#210021';
        }
        field(50014; AGRALAingredientesOMGText; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Ingredientes OMG';
            Description = '#210021';
        }
        field(50015; AGRALAIrradiadoText; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Ingredientes Irradiados';
            Description = '#210021';
        }
        field(50016; AGRALAAlergenos; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Alérgenos (Si/No)';
            Description = '#210021';
        }
        field(50017; AGRALAAlergenosContenidoText; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Alérgenos Contenido';
            Description = '#210021';
        }
        field(50018; AGRALAAlergenosTrazasText; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Alérgenos Trazas';
            Description = '#210021';
        }
        field(50019; AGRALATipoProducto; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo producto';
            Description = '#210021';
            OptionCaption = ' ,Ingrediente,Material contacto,Producto químico';
            OptionMembers = " ", Ingrediente, MaterialContacto, ProductoQuimico;
        }
        field(50020; AGRALABloqueado; Boolean)
        {
            CalcFormula = Lookup(Item.Blocked WHERE("No."=FIELD("Item No.")));
            Caption = 'Bloqueado';
            Description = '#210021';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50021; AGRALADescripcionIngred; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripción ingredientes';
            Description = '#210021';
        }
        field(50022; AGRALANProveedor; Integer)
        {
            CalcFormula = Count("Item Vendor" WHERE("Item No."=FIELD("Item No."), "Variant Code"=FIELD(Code)));
            Caption = 'Nº de proveedores';
            Description = '#210021';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = Vendor."No.";

            trigger OnLookup()
            var
                rlItemVendor: Record 99;
            begin
                rlItemVendor.SETRANGE("Item No.", "Item No.");
                rlItemVendor.SETRANGE("Variant Code", Code);
                PAGE.RUN(114, rlItemVendor);
            end;
        }
        field(50023; AGRALADescripcionIngred2; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripción ingredientes 2';
            Description = '#210021';
        }
        field(50024; AGRALANotasSeguimiento; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Notas seguimiento';
            Description = '#210021';
        }
        field(50025; AGRALAAnalisisProducto; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Análisis producto';
            Description = '#934';
        }
        field(50026; AGRALAFechaVencimientoAnalisis; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha vencimiento análisis';
            Description = '#934';
        }
        field(50027; AGRALAAnalisisMicro; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Análisis micro';
            Description = '#934';
        }
        field(50028; AGRALAFechaVencimientoAnMicro; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Vencimiento an. micro';
            Description = '#934';
        }
        field(50029; AGRALAAnalisisContaminantes; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Análisis contaminantes';
            Description = '#934';
        }
        field(50030; AGRALAFechaVencimientoAnCont; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Vencimiento an. contaminantes';
            Description = '#934';
        }
        field(50031; Kcal; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Kcal';
            Description = 'GAP00030';
        }
        field(50032; Grasas; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Grasas';
            Description = 'GAP00030';
        }
        field(50033; GrasasSaturadas; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Grasas saturadas';
            Description = 'GAP00030';
        }
        field(50034; Hidratos; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Hidratos';
            Description = 'GAP00030';
        }
        field(50035; Azucares; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Azúcares';
            Description = 'GAP00030';
        }
        field(50036; Proteinas; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Proteínas';
            Description = 'GAP00030';
        }
        field(50037; Sodio; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Sodio';
            Description = 'GAP00030';
        }
        field(50038; "Fecha revision"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha revisión';
            Description = '#GAP00030';
        }
        field(50039; Fibra; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Fibra';
            Description = 'GAP00030';
        }
        field(50040; Comentarios; Text[1024])
        {
            DataClassification = CustomerContent;
            Caption = 'Comentarios';
            Description = '#GAP00030';
        }
        modify(Code)
        {
        trigger OnAfterValidate()
        var
            rlItem: Record 27;
        begin
            //++ AGRALAMO 210021
            rlItem.GET(Rec."Item No.");
            Rec.Description:=rlItem.Description;
        //-- AGRALAMO 210021
        end;
        }
    }
}
