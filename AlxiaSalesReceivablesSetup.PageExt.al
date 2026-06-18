pageextension 50002 AlxiaSalesReceivablesSetup extends "Sales & Receivables Setup"
{
    layout
    {
        addlast(General)
        {
            field("Dimension Obligatoria"; Rec."Dimension Obligatoria")
            {
                ApplicationArea = All;
            }
        }
        addafter(Archiving)
        {
            group(ConfPilas)
            {
                Caption = 'Conf Pilas Eventos';

                field(FechaDesde; Rec.FechaDesde)
                {
                    ApplicationArea = All;
                }
                field(FechaHasta; Rec.FechaHasta)
                {
                    ApplicationArea = All;
                }
            }
        }
        addafter(ConfPilas)
        {
            group(ConfEventos)
            {
                Caption = 'Conf. Eventos';

                field("Cuenta Eventos"; Rec."Cuenta Eventos")
                {
                    ApplicationArea = All;
                }
                field("Producto Eventos Archivados"; Rec."Producto Eventos Archivados")
                {
                    ApplicationArea = All;
                }
                field("Producto Oferta Mes sin IVA"; Rec."Producto Oferta Mes sin IVA")
                {
                    ApplicationArea = All;
                }
                field("Serie Eventos"; Rec."Serie Eventos")
                {
                    ApplicationArea = All;
                }
                field("Serie Centro Trabajo"; Rec."Serie Centro Trabajo")
                {
                    ApplicationArea = All;
                }
                field("Crea Nuevo Evento"; Rec."Crea Nuevo Evento")
                {
                    Caption = 'Crear nuevo evento';
                    ToolTip = 'Al archivar un evento se creará un nuevo evento.';
                    ApplicationArea = All;
                }
                field(CopyDim; Rec.CopyDim)
                {
                    ApplicationArea = All;
                    Caption = 'Copiar Dimensiones';
                }
                group(Control50000)
                {
                    Caption = 'Tipo de Impresión';
                    Description = 'GAP00037';

                    field("Linea Evento Adulto"; Rec."Linea Evento Adulto")
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Será la descripción que aparecerá en el detalle del informe proforma del evento y de la factura registrada por tipo de impresión por capitulo.';
                    }
                    field("Linea Evento Ninno"; Rec."Linea Evento Ninno")
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Será la descripción que aparecerá en el detalle del informe proforma del evento y de la factura registrada por tipo de impresión por capitulo.';
                    }
                    field("Linea Evento Otros"; Rec."Linea Evento Otros")
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Será la descripción que aparecerá en el detalle del informe proforma del evento y de la factura registrada por tipo de impresión por capitulo.';
                    }
                    field("Calcular coste Cantidad"; Rec."Calcular coste Cantidad")
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Al marcar esta opción, el coste directo receta se calculará con el cambio de cantidad.';
                    }
                }
            }
            group(Control50001)
            {
                Caption = 'Control de Productos Asociados a Clientes';

                field("Periodo Inicial Cal Clientes"; Rec."Periodo Inicial Cal Clientes")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }
}
