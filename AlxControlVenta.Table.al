table 50148 AlxControlVenta
{
    TableType = Temporary;
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(2; "Cliente No"; Code[20])
        {
            Caption = 'Cliente No';
        }
        field(3; Nombre; Text[150])
        {
            Caption = 'Nombre';
        }
        field(4; "Dirección"; Text[150])
        {
            Caption = 'Dirección';
        }
        field(5; "Dirección 2"; Text[150])
        {
            Caption = 'Dirección 2';
        }
        field(6; "Código Postal"; Code[50])
        {
            Caption = 'Código Postal';
        }
        field(7; "Población"; Text[150])
        {
            Caption = 'Población';
        }
        field(8; Provincia; Text[150])
        {
            Caption = 'Provincia';
        }
        field(9; "Teléfono"; Text[150])
        {
            Caption = 'Teléfono';
        }
        field(10; "Correo Electrónico"; Text[150])
        {
            Caption = 'Correo Electrónico';
        }
        field(11; Contacto; Text[150])
        {
            Caption = 'Contacto';
        }
        field(12; "Cod. Almacén"; Text[150])
        {
            Caption = 'Cod. Almacén';
        }
        field(13; Bloqueado; Text[50])
        {
            Caption = 'Bloqueado';
        }
        field(14; "Crédito Maximo"; Decimal)
        {
            Caption = 'Crédito Maximo';
        }
        field(15; Divisa; Code[50])
        {
            Caption = 'Divisa';
        }
        field(16; "Grupo Dto"; Code[50])
        {
            Caption = 'Grupo Dto';
        }
        field(17; "Grupo Contable"; Code[50])
        {
            Caption = 'Grupo Contable';
        }
        field(18; "Grupo Precio"; Code[50])
        {
            Caption = 'Grupo Precio';
        }
        field(19; "Términos Pago"; Code[50])
        {
            Caption = 'Términos Pago';
        }
        field(20; Vendedor; Code[50])
        {
            Caption = 'Vendedor';
        }
        field(21; "Cod Transportista"; Code[50])
        {
            Caption = 'Cod Transportista';
        }
        field(22; "Cod Servicio Transportista"; Code[50])
        {
            Caption = 'Cod Servicio Transportista';
        }
        field(23; "Aviso Envío"; Code[50])
        {
            Caption = 'Aviso Envío';
        }
        field(24; "Facturación Automática"; Text[150])
        {
            Caption = 'Facturación Automática';
        }
        field(25; "Fecha Ultima Modificación"; Date)
        {
            Caption = 'Fecha Ultima Modificación';
        }
        field(26; "Cod Agente"; Code[50])
        {
            Caption = 'Cod Agente';
        }
        field(27; Factura; Text[50])
        {
            Caption = 'Factura';
        }
        field(28; Fecha; Date)
        {
            Caption = 'Fecha';
        }
        field(29; "AÑO"; Integer)
        {
            Caption = 'AÑO';
        }
        field(30; MES; Integer)
        {
            Caption = 'MES';
        }
        field(31; CLIENTE; Text[150])
        {
            Caption = 'CLIENTE';
        }
        field(32; "Linea Empresa"; Code[20])
        {
            Caption = 'Linea Empresa';
        }
        field(33; Producto; Code[20])
        {
            Caption = 'Producto';
        }
        field(34; "Descripción"; Text[150])
        {
            Caption = 'Descripción';
        }
        field(35; CANTIDAD; Decimal)
        {
            Caption = 'CANTIDAD';
        }
        field(36; "€ SIN IVA"; Decimal)
        {
            Caption = '€ SIN IVA';
        }
        field(37; "€ CON IVA"; Decimal)
        {
            Caption = '€ CON IVA';
        }
        field(38; PRECIO; Decimal)
        {
            Caption = 'PRECIO';
        }
        field(39; Dto; Decimal)
        {
            Caption = 'Dto';
        }
        field(40; "% Descuento"; Decimal)
        {
            Caption = '% Descuento';
        }
        field(41; Importe; Decimal)
        {
            Caption = 'Importe';
        }
        field(42; "Base IVA"; Decimal)
        {
            Caption = 'Base IVA';
        }
        field(43; Comision; Decimal)
        {
            Caption = 'Comision';
        }
        field(44; LineasNegocio; Code[50])
        {
            Caption = 'LineasNegocio';
        }
        field(45; TipoLinea; Text[50])
        {
            Caption = 'TipoLinea';
        }
        field(46; "Importe Pendiente"; Decimal)
        {
            Caption = 'Importe Pendiente';
        }
        field(47; Pagado; Text[10])
        {
            Caption = 'Pagado';
        }
        field(48; "Forma Pago"; Code[50])
        {
            Caption = 'Forma Pago';
        }
        field(49; "Peso Neto Linea"; Decimal)
        {
            Caption = 'Peso Neto Linea';
        }
        field(50; "Tipo Documento"; Text[150])
        {
            Caption = 'Tipo Documento';
        }
        field(51; Alias; Text[150])
        {
            Caption = 'Alias';
        }
        field(52; "Fecha Servicio"; Date)
        {
            Caption = 'Fecha Servicio';
        }
        field(53; "Terminos Pago"; Code[10])
        {
            Caption = 'Termino Pago';
        }
    }
    keys
    {
        key(PK; "Line No.", "Cliente No")
        {
            Clustered = true;
        }
    }
}
