tableextension 50021 AlxiaVendor extends Vendor
{
    fields
    {
        field(50001; "IBAN cta preferida"; Code[50])
        {
            CalcFormula = Lookup("Vendor Bank Account".IBAN WHERE(Code=FIELD("Preferred Bank Account Code"), "Vendor No."=FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50002; AGRALACopiaRGSEAA; Boolean)
        {
            Caption = 'Copia RGSEAA';
            Description = '#210021';
        }
        field(50003; AGRALANRGSAA; Code[50])
        {
            Caption = 'Nº RGSEAA';
            Description = '#210021';
        }
        field(50006; AGRALACertificados; Boolean)
        {
            Caption = 'Certificados';
            Description = '#210021';
            Editable = false;
        }
        field(50007; AGRALAFirmaCuestionario; Boolean)
        {
            Caption = 'Cuestionario';
            Description = '#210021';
        }
        field(50008; AGRALAFirmaCompromiso; Boolean)
        {
            Caption = 'Firmado compromiso de proveedor';
            Description = '#210021';
        }
        field(50009; AGRALAMaterialenvasado; Boolean)
        {
            Caption = 'Material envasado';
            Description = '#210021';
        }
        field(50010; AGRALAEmblajesetiquetas; Boolean)
        {
            Caption = 'Embalajes-Etiquetas';
            Description = '#210021';
        }
        field(50011; AGRALAProductosquimicos; Boolean)
        {
            Caption = 'Productos químicos';
            Description = '#210021';
        }
        field(50012; AGRALAControldeplagas; Boolean)
        {
            Caption = 'Control de plagas';
            Description = '#210021';
        }
        field(50013; AGRALAGestionresiduos; Boolean)
        {
            Caption = 'Gestión residuos';
            Description = '#210021';
        }
        field(50014; AGRALALaboratorio; Boolean)
        {
            Caption = 'Laboratorio';
            Description = '#210021';
        }
        field(50015; AGRALACalibracion; Boolean)
        {
            Caption = 'Calibración';
            Description = '#210021';
        }
        field(50016; AGRALATransporte; Boolean)
        {
            Caption = 'Transporte';
            Description = '#210021';
        }
        field(50017; AGRALAMenaje; Boolean)
        {
            Caption = 'Menaje';
            Description = '#210021';
        }
        field(50018; AGRALAMaquinaria; Boolean)
        {
            Caption = 'Maquinaria';
            Description = '#210021';
        }
        field(50019; AGRALAMantenimientoConstruccio; Boolean)
        {
            Caption = 'Mantenimiento/Construcción';
            Description = '#210021';
        }
        field(50020; AGRALACodificacion; Boolean)
        {
            Caption = 'Codificación';
            Description = '#210021';
        }
        field(50021; AGRALAImpresoras; Boolean)
        {
            Caption = 'Impresoras';
            Description = '#210021';
        }
        field(50024; AGRALAConsultoria; Boolean)
        {
            Caption = 'Consultoría';
            Description = '#210021';
        }
        field(50025; AGRALATelecomunicaciones; Boolean)
        {
            Caption = 'Telecomunicaciones';
            Description = '#210021';
        }
        field(50026; AGRALAEnergia; Boolean)
        {
            Caption = 'Energía';
            Description = '#210021';
        }
        field(50027; AGRALAFabricante; Boolean)
        {
            Caption = 'Fabricante';
            Description = '#210021';
        }
        field(50028; AGRALADistribuidor; Boolean)
        {
            Caption = 'Distribuidor';
            Description = '#210021';
        }
        field(50029; AGRALABroker; Boolean)
        {
            Caption = 'Broker';
            Description = '#210021';
        }
        field(50030; AGRALAServicios; Boolean)
        {
            Caption = 'Servicios';
            Description = '#210021';
        }
        field(50031; AGRALAIngredienteMP; Boolean)
        {
            Caption = 'Ingrediente o materia prima';
            Description = '#210021';
        }
        field(50032; AGRALACertificadosText; Text[250])
        {
            Caption = 'Certificados Texto';
            Description = '#210021';
        }
        field(50033; AGRALAFechaVencCertificados; Text[250])
        {
            Caption = 'Fecha vencimiento certificados';
            Description = '#210021';
        }
        field(50034; AGRALATipoProveedor; Text[250])
        {
            Caption = 'Tipo proveedor';
            Description = '#210021';
        }
        field(50035; AGRALATipoProductoServicios; Text[250])
        {
            Caption = 'Tipo producto/servicios';
            Description = '#210021';
        }
        field(50036; AGRALAInfoCalidad; Boolean)
        {
            Caption = 'Info calidad NO necesario';
            Description = '#210021';
        }
        field(50037; AGRALAPersonaContactoPedidos; Text[250])
        {
        }
        field(50038; AGRALATelefonoCalidad; Text[50])
        {
        }
        field(50039; AGRALACorreoCalidad; Text[250])
        {
        }
        field(50040; AGRALAPersonaCalidad; Text[250])
        {
        }
        field(50041; AGRALACorreoCrisis; Text[250])
        {
        }
        field(50042; AGRALAContactoCrisis; Text[250])
        {
        }
        field(50043; AGRALAContabilityPerson; Text[50])
        {
            Caption = 'Persona contacto Contabilidad';
            Description = '935';
        }
        field(50044; AGRALAContabilityPhone; Text[20])
        {
            Caption = 'Nº telefono Contabilidad';
            Description = '935';
        }
        field(50045; AGRALAContabilityEmail; Text[80])
        {
            Caption = 'Correo electrónico Contabilidad';
            Description = '935';
        }
        field(50046; AlxTipoServicio; Code[20])
        {
            Caption = 'Tipo servicio';
            TableRelation = AlxiaTipoServicio."Código";
        }
        field(50047; "Fecha Cuestionario Calidad"; Date)
        {
            Caption = 'Fecha Cuestionario Calidad';
        }
        field(50048; "Telefono contacto 24H"; Text[100])
        {
            Caption = 'Telefono contacto 24H';
        }
    }
}
