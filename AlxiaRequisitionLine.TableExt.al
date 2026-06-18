tableextension 50029 AlxiaRequisitionLine extends "Requisition Line"
{
    fields
    {
        field(50000; Evento; Code[20])
        {
            TableRelation = Evento;
        }
        field(50001; AGRALATipo; Option)
        {
            Caption = 'Nivell';
            Description = '#210021';
            OptionCaption = '00 - Receta madre,01 - Nivel,02 - Nivel,03 - Nivel,04 - Nivel,05 - Nivel';
            OptionMembers = "00 - Receta madre", "01 - Nivel", "02 - Nivel", "03 - Nivel", "04 - Nivel", "05 - Nivel";
        }
        field(50002; AGRALACodProcedencia; Code[20])
        {
            Description = '#210021';
        }
        field(50003; AGRALANombreCliente; Text[250])
        {
            Description = '#210021';
        }
        field(50004; AGRALANombreProveedor; Text[250])
        {
            Description = '#210021';
        }
        field(50005; AGRALAStock; Decimal)
        {
            Caption = 'Stock';
            Description = '#210021';
        }
        field(50006; AGRALACantidadPedidosCompra; Decimal)
        {
            Caption = 'Cantidad pedido de compra';
            Description = '#210021';
        }
        field(50007; AGRALACantidadNecesaria; Decimal)
        {
            Caption = 'Cantidad necesaria';
            Description = '#210021';
        }
        field(50008; AGRALACosteUnitario; Decimal)
        {
            Caption = 'Coste unitario';
            Description = '#210021';
        }
        field(50009; AGRALACosteEstandar; Decimal)
        {
            Caption = 'Coste estandar';
            Description = '#210021';
        }
        field(50010; AGRALAOrigenDemanda; Code[20])
        {
            Caption = 'Origen demanda';
            Description = '#210021';

            //Editable = false;
            trigger OnLookup()
            var
                rlSalesHeader: Record 36;
                rlAssemblyHeader: Record 900;
                rlEvento: Record 50004;
            begin
                IF AGRALAProcedencia = AGRALAProcedencia::EVENTO THEN BEGIN
                    rlEvento.SETRANGE("Codigo Evento", AGRALAOrigenDemanda);
                    PAGE.RUN(50006, rlEvento);
                END;
                IF(AGRALAProcedencia = AGRALAProcedencia::"PED. ENSAMBLADO EVENTO") OR (AGRALAProcedencia = AGRALAProcedencia::"PED. ENSAMBLADO SIN ENVENTO")THEN BEGIN
                    rlAssemblyHeader.SETRANGE("Document Type", rlAssemblyHeader."Document Type"::Order);
                    rlAssemblyHeader.SETRANGE("No.", AGRALAOrigenDemanda);
                    PAGE.RUN(900, rlAssemblyHeader);
                END;
                IF(AGRALAProcedencia = AGRALAProcedencia::"PED. VENTA")THEN BEGIN
                    rlSalesHeader.SETRANGE("Document Type", rlSalesHeader."Document Type"::Order);
                    rlSalesHeader.SETRANGE("No.", AGRALAOrigenDemanda);
                    PAGE.RUN(42, rlSalesHeader);
                END;
            end;
        }
        field(50011; AGRALANombreEvenClieEns; Text[250])
        {
            Caption = 'Nombre evento, nombre del cliente, pedido ensamblado';
            Description = '#210021';
        }
        field(50012; AGRALAEstadoEvento; Option)
        {
            CalcFormula = Lookup(Evento.Estado WHERE("Codigo Evento"=FIELD(AGRALAOrigenDemanda)));
            Caption = 'Estado del evento';
            Description = '#210021';
            FieldClass = FlowField;
            OptionCaption = 'Presupuesto,Aceptado,Rechazado,Anulado,Realizado,Archivado,EnProceso';
            OptionMembers = Presupuesto, Aceptado, Rechazado, Anulado, Realizado, Archivado, EnProceso;
        }
        field(50013; AGRALADiferencia; Decimal)
        {
            Caption = 'Diferencia';
            Description = '#210021';
        }
        field(50014; AGRALALineaNegocio; Option)
        {
            Caption = 'Linea Negocio';
            Description = '#210021';
            OptionCaption = ',CATERING,ALIMENTACIÓN';
            OptionMembers = , CATERING, "ALIMENTACIÓN";
        }
        field(50015; AGRALAProcedencia; Option)
        {
            Caption = 'Procedencia';
            Description = '#210021';
            OptionCaption = ',EVENTO,PED. ENSAMBLADO EVENTO,PED. ENSAMBLADO SIN ENVENTO,PED. VENTA';
            OptionMembers = , EVENTO, "PED. ENSAMBLADO EVENTO", "PED. ENSAMBLADO SIN ENVENTO", "PED. VENTA";
        }
        field(50016; AlxDiferencia; Decimal)
        {
            Caption = 'Diferencia';
            Description = 'Alx';
        }
        field(50017; "AlxSafetyStockQuantity"; Decimal)
        {
            Caption = 'Stock de seguridad';
            Description = 'Alx';
        }
        field(50018; AlxLastDirectCost; Decimal)
        {
            Caption = 'Ultimo coste directo';
            Description = 'Alx';
        }
        field(50019; AlxMarca; Code[50])
        {
            Caption = 'Marca';
        }
        field(50020; AlxLineaNegocio; Code[20])
        {
            Caption = 'Linea de Negocio';
        }
    }
}
