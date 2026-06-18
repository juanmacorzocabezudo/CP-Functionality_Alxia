page 50077 AGRALAInfoCalidadProveedores
{
    Caption = 'Ingredientes Calidad Proveedor';
    Editable = false;
    PageType = List;
    SourceTable = 23;
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field(AGRALAInfoCalidad; Rec.AGRALAInfoCalidad)
                {
                }
                field(AGRALANRGSAA; Rec.AGRALANRGSAA)
                {
                }
                field(AGRALACopiaRGSEAA; Rec.AGRALACopiaRGSEAA)
                {
                }
                field(AGRALAFirmaCuestionario; Rec.AGRALAFirmaCuestionario)
                {
                }
                field(AGRALAFirmaCompromiso; Rec.AGRALAFirmaCompromiso)
                {
                }
                field(AGRALATipoProveedor; Rec.AGRALATipoProveedor)
                {
                }
                field(AGRALATipoProductoServicios; Rec.AGRALATipoProductoServicios)
                {
                }
                field(AGRALACertificadosText; Rec.AGRALACertificadosText)
                {
                }
                field(AGRALAFechaVencCertificados; Rec.AGRALAFechaVencCertificados)
                {
                }
                field(Blocked; Rec.Blocked)
                {
                }
                field("Fecha Cuestionario Calidad"; Rec."Fecha Cuestionario Calidad")
                {
                }
            }
        }
    }
    actions
    {
    }
    trigger OnOpenPage()
    var
        rlCommentLine: Record 97;
        rlVendor: Record 23;
    begin
        IF rlVendor.FINDSET THEN REPEAT rlVendor.AGRALACertificadosText:='';
                rlVendor.AGRALATipoProveedor:='';
                rlVendor.AGRALATipoProductoServicios:='';
                rlVendor.AGRALAFechaVencCertificados:='';
                rlVendor.MODIFY;
            UNTIL rlVendor.NEXT = 0;
        CLEAR(rlVendor);
        IF rlVendor.FINDSET THEN REPEAT rlCommentLine.SETRANGE("Table Name", rlCommentLine."Table Name"::Vendor);
                rlCommentLine.SETRANGE("No.", rlVendor."No.");
                IF rlCommentLine.FINDSET THEN REPEAT rlVendor.AGRALACertificadosText+=FORMAT(rlCommentLine.AGRALATipoCertificado) + ',' + ' ';
                        rlVendor.AGRALAFechaVencCertificados+=FORMAT(rlCommentLine.AGRALAFechaVencimiento) + ',' + ' ';
                    UNTIL rlCommentLine.NEXT = 0;
                IF rlVendor.AGRALAFabricante = TRUE THEN rlVendor.AGRALATipoProveedor+='Fabricante' + ',' + ' ';
                IF rlVendor.AGRALADistribuidor = TRUE THEN rlVendor.AGRALATipoProveedor+='Distribuidor' + ',' + ' ';
                IF rlVendor.AGRALABroker = TRUE THEN rlVendor.AGRALATipoProveedor+='Broker' + ',' + ' ';
                IF rlVendor.AGRALAServicios = TRUE THEN rlVendor.AGRALATipoProveedor+='Servicios' + ',' + ' ';
                IF rlVendor.AGRALAIngredienteMP = TRUE THEN rlVendor.AGRALATipoProductoServicios+='IngredienteMP' + ',' + ' ';
                IF rlVendor.AGRALAMaterialenvasado = TRUE THEN rlVendor.AGRALATipoProductoServicios+='Materialenvasado' + ',' + ' ';
                IF rlVendor.AGRALAEmblajesetiquetas = TRUE THEN rlVendor.AGRALATipoProductoServicios+='Emblajesetiquetas' + ',' + ' ';
                IF rlVendor.AGRALAProductosquimicos = TRUE THEN rlVendor.AGRALATipoProductoServicios+='Productos químicos' + ',' + ' ';
                IF rlVendor.AGRALAControldeplagas = TRUE THEN rlVendor.AGRALATipoProductoServicios+='Control de plagas ' + ',' + ' ';
                IF rlVendor.AGRALAGestionresiduos = TRUE THEN rlVendor.AGRALATipoProductoServicios+='Gestion residuos' + ',' + ' ';
                IF rlVendor.AGRALALaboratorio = TRUE THEN rlVendor.AGRALATipoProductoServicios+='Laboratorio' + ',' + ' ';
                IF rlVendor.AGRALACalibracion = TRUE THEN rlVendor.AGRALATipoProductoServicios+='Calibración' + ',' + ' ';
                IF rlVendor.AGRALATransporte = TRUE THEN rlVendor.AGRALATipoProductoServicios+='Transporte' + ',' + ' ';
                IF rlVendor.AGRALAMenaje = TRUE THEN rlVendor.AGRALATipoProductoServicios+='Menaje' + ',' + ' ';
                IF rlVendor.AGRALAMaquinaria = TRUE THEN rlVendor.AGRALATipoProductoServicios+='Maquinaría' + ',' + ' ';
                IF rlVendor.AGRALAMantenimientoConstruccio = TRUE THEN rlVendor.AGRALATipoProductoServicios+='Mantenimiento Construcción' + ',' + ' ';
                IF rlVendor.AGRALACodificacion = TRUE THEN rlVendor.AGRALATipoProductoServicios+='Codificación' + ',' + ' ';
                IF rlVendor.AGRALAImpresoras = TRUE THEN rlVendor.AGRALATipoProductoServicios+='Impresoras' + ',' + ' ';
                IF rlVendor.AGRALAConsultoria = TRUE THEN rlVendor.AGRALATipoProductoServicios+='Consultoría' + ',' + ' ';
                IF rlVendor.AGRALATelecomunicaciones = TRUE THEN rlVendor.AGRALATipoProductoServicios+='Telecomunicaciones' + ',' + ' ';
                IF rlVendor.AGRALAEnergia = TRUE THEN rlVendor.AGRALATipoProductoServicios+='Energía' + ',' + ' ';
                rlVendor.MODIFY;
            UNTIL rlVendor.NEXT = 0;
    end;
}
