page 50148 AlxControlVentas
{
/*  //ApplicationArea = All;
     Caption = 'Control de ventas';
     PageType = List;
     SourceTable = "Sales Invoice Line";
     UsageCategory = ReportsAndAnalysis;
     SourceTableView = SORTING("Sell-to Customer No.")
     WHERE(Type = const(Item));
     layout
     {
         area(Content)
         {
             repeater(General)
             {
                 field("Cliente No"; Rec."Sell-to Customer No.")
                 {
                     Caption = 'Cliente No';
                 }
                 field("Nombre"; "_Sell-to Customer Name")
                 {
                     Caption = 'Nombre';
                 }
                 field("Dirección"; "_Sell-to Address")
                 {
                     Caption = 'Dirección';
                 }
                 field("Dirección 2"; "_Sell-to Address 2")
                 {
                     Caption = 'Dirección 2';
                 }
                 field("Código Postal"; "_Sell-to Post Code")
                 {
                     Caption = 'Código Postal';
                 }
                 field("Población"; "_Sell-to City")
                 {
                     Caption = 'Población';
                 }
                 field("Provincia"; "_Sell-to County")
                 {
                     Caption = 'Provincia';
                 }
                 field("Teléfono"; _Telefono)
                 {
                     Caption = 'Teléfono';
                 }
                 field("Correo Electrónico"; _Correo)
                 {
                     Caption = 'Correo Electrónico';
                 }
                 field(Contacto; _Contacto)
                 {
                     Caption = 'Contacto';
                 }
                 field("Cod. Almacén"; Rec."Location Code")
                 {
                     Caption = 'Cod. Almacén';
                 }
                 field(Bloqueado; _Bloqueado)
                 {
                     Caption = 'Bloqueado';
                 }
                 field("Crédito Maximo"; _CreditoMax)
                 {
                     Caption = 'Crédito Maximo';
                 }
                 field("Divisa"; "_Currency Code")
                 {
                     Caption = 'Divisa';
                 }
                 field("Grupo Dto"; Rec."Customer Disc. Group")
                 {
                     Caption = 'Grupo Dto';
                 }
                 field("Grupo Contable"; Rec."Gen. Bus. Posting Group")
                 {
                     Caption = 'Grupo Contable';
                 }
                 field("Grupo Precio"; Rec."Customer Price Group")
                 {
                     Caption = 'Grupo Precio';
                 }
                 field("Términos Pago"; "_Payment Terms Code")
                 {
                     Caption = 'Términos Pago';
                 }
                 field(Vendedor; "_Salesperson Code")
                 {
                     Caption = 'Vendedor';
                 }
                 field("Cod Transportista"; "_Shipping Agent Code")
                 {
                     Caption = 'Cod Transportista';
                 }
                 field("Cod Servicio Transportista"; "_Shipment Method Code")
                 {
                     Caption = 'Cod Servicio Transportista';
                 }
                 field("Aviso Envío"; _ShippingAdvice)
                 {
                     Caption = 'Aviso Envío';
                 }
                 field("Facturación Automática"; _FacturacionAuto)
                 {
                     Caption = 'Facturación Automática';
                 }
                 field("Fecha Ultima Modificación"; _FechaUltimaModificacion)
                 {
                     Caption = 'Fecha Ultima Modificación';
                 }
                 field("Cod Agente"; _CodAgente)
                 {
                     Caption = 'Cod Agente';
                 }
                 field("Factura"; Rec."No.")
                 {
                     Caption = 'Factura';
                 }
                 field("Fecha"; "_Document Date")
                 {
                     Caption = 'Fecha';
                 }
                 field("AÑO"; _Ano)
                 {
                     Caption = 'AÑO';
                 }
                 field(MES; _Mes)
                 {
                     Caption = 'MES';
                 }
                 field(CLIENTE; _Cliente)
                 {
                     Caption = 'CLIENTE';
                 }
                 field("Linea Empresa"; Rec."Shortcut Dimension 2 Code")
                 {
                     Caption = 'Linea Empresa';
                 }
                 field(Producto; Rec."No.")
                 {
                     Caption = 'Producto';
                 }
                 field("Descripción"; Rec.Description)
                 {
                     Caption = 'Descripción';
                 }
                 field(CANTIDAD; Rec.Quantity)
                 {
                     Caption = 'CANTIDAD';
                 }
                 field("€ SIN IVA"; Rec."Line Amount")
                 {
                     Caption = '€ SIN IVA';
                 }
                 field("€ CON IVA"; Rec."Amount Including VAT")
                 {
                     Caption = '€ CON IVA';
                 }
                 field("PRECIO"; Rec."Unit Price")
                 {
                     Caption = 'PRECIO';
                 }
                 field("Dto"; Rec."Line Discount Amount")
                 {
                     Caption = 'Dto';
                 }
                 field("% Descuento"; Rec."Line Discount %")
                 {
                     Caption = '% Descuento';
                 }
                 field("Importe"; Rec."Line Amount")
                 {
                     Caption = 'Importe';
                 }
                 field("Base IVA"; Rec."VAT Base Amount")
                 {
                     Caption = 'Base IVA';
                 }
                 field(Comision; _Comision)
                 {
                     Caption = 'Comision';
                 }
                 field("LineasNegocio"; Rec."Shortcut Dimension 1 Code")
                 {
                     Caption = 'LineasNegocio';
                 }
                 field("TipoLinea"; Rec.Type)
                 {
                     Caption = 'TipoLinea';
                 }
                 field("Importe Pendiente"; "_Remaining Amount")
                 {
                     Caption = 'Importe Pendiente';
                 }
                 field(Pagado; _Pagado)
                 {
                     Caption = 'Pagado';
                 }
                 field("Forma Pago"; "_Payment Method Code")
                 {
                     Caption = 'Forma Pago';
                 }
                 field("Peso Neto Linea"; _PesoNeto)
                 {
                     Caption = 'Peso Neto Linea';
                 }
                 field("Tipo Documento"; _TipoDocumento)
                 {
                     Caption = 'Tipo Documento';
                 }

             }
         }
     }

     var
         recCust: Record Customer;
         recSIH: Record "Sales Invoice Header";
         _Telefono: Text[150];
         _Correo: Text[150];
         _Contacto: Text[150];
         _Alias: Text[150];
         _Bloqueado: Boolean;
         _CreditoMax: Decimal;
         _ShippingAdvice: Code[50];
         _FacturacionAuto: Integer;
         _FechaUltimaModificacion: date;
         _CodAgente: Code[50];
         _Ano: Integer;
         _Mes: Integer;
         _Cliente: Text;
         _Comision: Text;
         _Pagado: Text;
         _TipoDocumento: Text;
         _PesoNeto: Decimal;

         //Sales Invoice Header
         "_Sell-to Customer Name": Text[150];
         "_Sell-to Address": Text[150];
         "_Sell-to Address 2": Text[150];
         "_Sell-to Post Code": Code[50];
         "_Sell-to City": Text[150];
         "_Sell-to County": Text[150];
         "_Currency Code": Code[20];
         "_Payment Terms Code": Code[50];
         "_Salesperson Code": Code[50];
         "_Shipping Agent Code": Code[50];
         "_Shipment Method Code": Code[50];
         "_Document Date": Date;
         "_Remaining Amount": Decimal;
         "_Payment Method Code": Code[50];

     trigger OnAfterGetRecord()
     begin
         ClearAll();
         recSIH.Reset();
         recSIH.SetRange("No.", Rec."Document No.");
         recSIH.FindFirst();

         recSIH.CalcFields("Remaining Amount");
         "_Sell-to Customer Name" := recSIH."Sell-to Customer Name";
         "_Sell-to Address" := recSIH."Sell-to Address";
         "_Sell-to Address 2" := recSIH."Sell-to Address 2";
         "_Sell-to Post Code" := recSIH."Sell-to Post Code";
         "_Sell-to City" := recSIH."Sell-to City";
         "_Sell-to County" := recSIH."Sell-to County";
         "_Currency Code" := recSIH."Currency Code";
         "_Payment Terms Code" := recSIH."Payment Method Code";
         "_Salesperson Code" := recSIH."Salesperson Code";
         "_Shipping Agent Code" := recSIH."Shipping Agent Code";
         "_Shipment Method Code" := recSIH."Shipment Method Code";
         "_Document Date" := recSIH."Document Date";
         "_Payment Method Code" := recSIH."Payment Method Code";

         if recSIH."Remaining Amount" = 0 then
             _Pagado := 'SI'
         else
             _Pagado := 'NO';

         recCust.Reset();
         recCust.SetRange("No.", Rec."Sell-to Customer No.");
         if recCust.FindFirst() then begin
             if recSIH."Sell-to Phone No." <> '' then
                 _Telefono := recSIH."Sell-to Phone No."
             else
                 _Telefono := recCust."Phone No.";

             if recSIH."Sell-to E-Mail" <> '' then
                 _Correo := recSIH."Sell-to E-Mail"
             else
                 _Correo := recCust."E-Mail";

             if recSIH."Sell-to Contact" <> '' then
                 _Contacto := recSIH."Sell-to Contact"
             else
                 _Contacto := recCust.Contact;

             _Alias := recCust."Search Name";
             _Bloqueado := recCust.IsBlocked();
             _CreditoMax := recCust."Credit Limit (LCY)";
             _ShippingAdvice := Format(recCust."Shipping Advice");
             _FacturacionAuto := 0;
             _FechaUltimaModificacion := recCust."Last Date Modified";
             _CodAgente := recCust."Shipping Agent Code";
             _Ano := Date2DMY(RecSIH."Document Date", 3);
             _Mes := Date2DMY(RecSIH."Document Date", 2);
             _Cliente := Format(recCust."No." + ' ' + recCust.Name);
             _Comision := '';
             _TipoDocumento := 'Factura';
             _PesoNeto := Rec."Net Weight" * Rec."Quantity (Base)";
         end;
     end;

  */
}
