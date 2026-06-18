query 50002 AlxLineasEvento
{
    Caption = 'AlxLineasEvento';
    QueryType = Normal;

    elements
    {
        dataitem(LineasEvento;
            "Lineas Evento")
        {
            column(CodigoEvento;
                "Codigo Evento")
            {
            }
            column(Linea;
                Linea)
            {
            }
            column(Tipo;
                Tipo)
            {
            }
            column(No;
                "No.")
            {
            }
            column(Descripcion;
                Descripcion)
            {
            }
            column(Cantidad;
                Cantidad)
            {
            }
            column(Importe;
                Importe)
            {
            }
            column(IVA;
                "% IVA")
            {
            }
            column(ImporteIVAIncl;
                "Importe IVA Incl.")
            {
            }
            column(Imprime;
                Imprime)
            {
            }
            column(Comentarios;
                Comentarios)
            {
            }
            column(CosteDirecto;
                "Coste Directo")
            {
            }
            column(TipoMargen;
                "Tipo Margen")
            {
            }
            column(ValorMargen;
                "Valor Margen")
            {
            }
            column(CosteIndirectoRecursos;
                "Coste Indirecto Recursos")
            {
            }
            column(PrecioVentaRecursos;
                "Precio Venta Recursos")
            {
            }
            column(PrecioPropuesto;
                "Precio Propuesto")
            {
            }
            column(PrecioReal;
                "Precio Real")
            {
            }
            column(PrecioIVAIncl;
                "Precio IVA Incl.")
            {
            }
            column(CosteTotal;
                "Coste Total")
            {
            }
            column(CosteIndirectoPan;
                "Coste Indirecto Pan")
            {
            }
            column(CosteTotalUnitario;
                "Coste Total Unitario")
            {
            }
            column(Bocados;
                Bocados)
            {
            }
            column(ImportePorPersona;
                ImportePorPersona)
            {
            }
            dataitem(Evento;
                Evento)
            {
                DataItemLink = "Codigo Evento"=LineasEvento."Codigo Evento";

                column(Estado;
                    Estado)
                {
                }
                column(TipoEvento;
                    "Tipo Evento")
                {
                }
                column(DescripcionEvento;
                    Descripcion)
                {
                }
                column(Telefono;
                    Telefono)
                {
                }
                column(Telefono2;
                    "Telefono 2")
                {
                }
                column(Direccion;
                    Direccion)
                {
                }
                column(Direccion2;
                    "Direccion 2")
                {
                }
                column(CIFNIF;
                    "CIF/NIF")
                {
                }
                column(CodigoPostal;
                    "Codigo Postal")
                {
                }
                column(Provincia;
                    Provincia)
                {
                }
                column(CodigoCliente;
                    "Codigo Cliente")
                {
                }
                column(PersonadeContacto;
                    "Persona de Contacto")
                {
                }
                column(PlantillaCliente;
                    "Plantilla Cliente")
                {
                }
                column(HoraEvento;
                    "Hora Evento")
                {
                }
                column(TotalAdultos;
                    "Total Adultos")
                {
                }
                column(TotalNinos;
                    "Total Ninos")
                {
                }
                column(Beneficio;
                    "% Beneficio")
                {
                }
                column(CosteTotalEvento;
                    "Coste Total")
                {
                }
                column(CosteMenuAdulto;
                    "Coste Menu Adulto")
                {
                }
                column(CosteMenuNino;
                    "Coste Menu Nino")
                {
                }
                column(CosteMenuOtros;
                    "Coste Menu Otros")
                {
                }
                column(PrecioMenuAdulto;
                    "Precio Menu Adulto")
                {
                }
                column(PrecioMenuNino;
                    "Precio Menu Nino")
                {
                }
                column(PrecioOtrosMenus;
                    "Precio Otros Menus")
                {
                }
                column(ImporteTotalEvento;
                    "Importe Total Evento")
                {
                }
                column(ImporteTotalIVAIncluido;
                    "Importe Total IVA Incluido")
                {
                }
                column(CosteTotalElaboracion;
                    "Coste Total Elaboracion")
                {
                }
                column(CosteTotalRecursos;
                    "Coste Total Recursos")
                {
                }
                column(NoSeries;
                    "No. Series")
                {
                }
                column(FechaEvento;
                    "Fecha Evento")
                {
                }
                column(Poblacion;
                    Poblacion)
                {
                }
                column(Senalizado;
                    Senalizado)
                {
                }
                column(ImpSenal;
                    "Imp Senal")
                {
                }
                column(Contratado;
                    Contratado)
                {
                }
                column(MotivoAnulacion;
                    "Motivo Anulacion")
                {
                }
                column(VariedadEvento;
                    "Variedad Evento")
                {
                }
                column(PersonadeContacto2;
                    "Persona de Contacto 2")
                {
                }
                column(EMail;
                    "E-Mail")
                {
                }
                column(EMail2;
                    "E-Mail 2")
                {
                }
                column(CodigoContacto;
                    "Codigo Contacto")
                {
                }
                column(Comentario;
                    Comentario)
                {
                }
                column(CodTeminosPago;
                    "Cod Teminos Pago")
                {
                }
                column(CodFormaPago;
                    "Cod Forma Pago")
                {
                }
                column(Barras;
                    Barras)
                {
                }
                column(Gallegas;
                    Gallegas)
                {
                }
                column(Colines;
                    Colines)
                {
                }
                column(Alcachofas;
                    Alcachofas)
                {
                }
                column(ImporteBarras;
                    "Importe Barras")
                {
                }
                column(ImportePanGallego;
                    "Importe Pan Gallego")
                {
                }
                column(ImporteColines;
                    "Importe Colines")
                {
                }
                column(ImporteAlcachofas;
                    "Importe Alcachofas")
                {
                }
                column(ConceptoGenericoFacturacion;
                    "Concepto Generico Facturacion")
                {
                }
                column(CodPais;
                    "Cod Pais")
                {
                }
                column(CodVendedor;
                    CodVendedor)
                {
                }
                column(Commission;
                    "Commission %")
                {
                }
                column(ComoNosConocisteText;
                    ComoNosConocisteText)
                {
                }
                column(FechaAlta;
                    FechaAlta)
                {
                }
                column(EventoOrigen;
                    "Evento Origen")
                {
                }
                column(Franjahoraria;
                    "Franja horaria")
                {
                }
                column(DoblePan;
                    "Doble Pan")
                {
                }
                column(NadaPan;
                    "Nada Pan")
                {
                }
                column(ObservacionesInternas;
                    "Observaciones Internas")
                {
                }
                column(CodigoPostal2;
                    "Codigo Postal 2")
                {
                }
                column(Poblacion2;
                    "Poblacion 2")
                {
                }
                column(Provincia2;
                    "Provincia 2")
                {
                }
                column(EquipoVendedor;
                    EquipoVendedor)
                {
                }
                column(OfertaMesSinIVA;
                    "Oferta Mes Sin IVA")
                {
                }
                column(Comentario2;
                    Comentario2)
                {
                }
                column(CreadoEnsamblado;
                    CreadoEnsamblado)
                {
                }
                column(CosteTotalVisualizado;
                    "Coste Total Visualizado")
                {
                }
                column(NuevoCosteTotalDirecto;
                    NuevoCosteTotalDirecto)
                {
                }
                column(AGRALATraspasadoH;
                    AGRALATraspasadoH)
                {
                }
                column(CdigoTexto;
                    "Código Texto")
                {
                }
                column(DescripcinTexto;
                    "Descripción Texto")
                {
                }
                column(TextoSaludo;
                    "Texto Saludo")
                {
                }
                column(TextoOtrasopciones;
                    "Texto Otras opciones")
                {
                }
                column(TextoDirectrices;
                    "Texto Directrices")
                {
                }
                column(TextoClienteaportaparasi;
                    "Texto Cliente aporta para si")
                {
                }
                column(TextoClienteaportacatering;
                    "Texto Cliente aporta catering")
                {
                }
                column(TextoDocobligatoria;
                    "Texto Doc. obligatoria")
                {
                }
                column(TextoFormasdepago;
                    "Texto Formas de pago")
                {
                }
                column(TextoCondicionescontratacin;
                    "Texto Condiciones contratación")
                {
                }
                column(TextoDespedida;
                    "Texto Despedida")
                {
                }
                column(NombreProvincia;
                    "Nombre Provincia")
                {
                }
                column(NombreProvinciaEvento;
                    "Nombre Provincia Evento")
                {
                }
                column(CosteRecursosEvento;
                    CosteRecursosEvento)
                {
                }
                column(CosteProductoEvento;
                    CosteProductoEvento)
                {
                }
            }
        }
    }
    trigger OnBeforeOpen()
    begin
    end;
}
