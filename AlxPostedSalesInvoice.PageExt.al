pageextension 50037 AlxPostedSalesInvoice extends "Posted Sales Invoice"
{
    layout
    {
        modify(SellToEmail)
        {
            Visible = false;
        }
        modify(SellToPhoneNo)
        {
            Visible = false;
        }
        modify(SellToMobilePhoneNo)
        {
            Visible = false;
        }
        modify("Sell-to Contact")
        {
            Visible = false;
        }
        addafter("Sell-to Contact")
        {
            field(ContactoPedido; Rec.ContactoPedido)
            {
                ApplicationArea = All;
            }
            field("Customer E-Mail"; Rec."Customer E-Mail")
            {
                ApplicationArea = All;
            }
            field(TelefonoPedido; Rec.TelefonoPedido)
            {
                ApplicationArea = All;
            }
        }
        addafter("Responsibility Center")
        {
            field(NoEvento; Rec.NoEvento)
            {
                ApplicationArea = All;
            }
            field(Cobrado; Rec.Cobrado)
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Fecha Servicio"; Rec."Fecha Servicio")
            {
                ApplicationArea = All;
            }
        }
        addlast(General)
        {
            field("Tipo de Impresión"; Rec."Tipo de Impresión")
            {
                ApplicationArea = Basic, Suite;
                Description = 'GAP00037';
                Visible = false;
            }
            field("Var Tipo de Impresión"; _TipoImpresion)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Tipo de impresión';
                Description = 'GAP00054';
                Editable = false;
                Enabled = false;
            }
            field("No Impresion Comentarios"; Rec."No Impresion Comentarios")
            {
                ApplicationArea = Basic, Suite;
                Description = 'GAP00037';
            }
        }
    }
    actions
    {
        addlast(processing)
        {
            action(Action50000)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Actualizar "T.Impresión"';
                Description = 'GAP00037';
                Image = UpdateDescription;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Modifica el campo "Tipo de Impresión".';

                trigger OnAction()
                var
                    fCurrPage: Codeunit FuncionesVarias;
                begin
                    fCurrPage.Modify_TipoDeImpresionField_OnPostedSalesInvoice(Rec."No.");
                    CurrPage.Update();
                end;
            }
            action(Action50001)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Act./Desa. "Imp. Com."';
                Description = 'GAP00037';
                Image = CreateInteraction;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Activa o desactiva el campo "Impresión Comentarios".';

                trigger OnAction()
                var
                    fCurrPage: Codeunit FuncionesVarias;
                begin
                    fCurrPage.ActivateOrDesactivated_ImpresionComentariosField_OnPostedSalesInvoice(Rec."No.");
                    CurrPage.Update();
                end;
            }
        }
        addlast(processing)
        {
            action(Action50002)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Imprimir';
                Description = 'GAP00037,GAP00045';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Category6;
                ToolTip = 'Imprime el informe por tipo de impresión indicado en la factura.';

                trigger OnAction()
                var
                    InformePorCapitulo: Report "Factura Impresion por Capitulo"; //AlxInformeHistFactVntaCapitulo;
                    InformePorCapituloDetallada: Report "Factura Imp. por Capitulo Dtl"; //AlxInformeHistFactVntaCapitDtl;
                    InformeDetallada: Report AlxInformeHistFactVtaDetallada;
                    InformePersonalizado: Report AlxSales_Invoice;
                    Factura: Record "Sales Invoice Header";
                    Funciones: Codeunit FuncionesVarias;
                begin
                    Factura.Get(Rec."No.");
                    if Rec.NoEvento <> '' then begin
                        if Rec."Shortcut Dimension 1 Code" = 'CATERING' then begin
                            case Rec."Tipo de Impresión" of Rec."Tipo de Impresión"::"Impresion por Capitulo": begin
                                // Imprimir impresión por capítulo.
                                InformePorCapitulo.ConfigurarFiltros(Rec."No.", Rec.NoEvento, Rec."No Impresion Comentarios");
                                InformePorCapitulo.Run();
                            end;
                            Rec."Tipo de Impresión"::"Imp. por Capitulo Dtl.": begin
                                // Imprimir impresión por capítulo detallado.
                                InformePorCapituloDetallada.ConfigurarFiltros(Rec."No.", Rec.NoEvento, Rec."No Impresion Comentarios");
                                InformePorCapituloDetallada.Run();
                            end;
                            Rec."Tipo de Impresión"::"Impresion Concepto Generico", Rec."Tipo de Impresión"::"Impresion Detallada": begin
                                // Imprimir impresión detallada.
                                Clear(InformePersonalizado);
                                if Rec."No Impresion Comentarios" then InformePersonalizado.ConfigurarFiltros(Factura."No.", false)
                                else
                                    InformePersonalizado.ConfigurarFiltros(Factura."No.", true);
                                InformePersonalizado.Run();
                            end;
                            end;
                        end
                        else
                        begin
                            // Imprimir impresión detallada.
                            Clear(InformeDetallada);
                            if Rec."No Impresion Comentarios" then InformeDetallada.ConfigurarFiltros(Rec."No.", Rec."Tipo de Impresión", false)
                            else
                                InformeDetallada.ConfigurarFiltros(Rec."No.", Rec."Tipo de Impresión", true);
                            InformeDetallada.SetTableView(Factura);
                            InformeDetallada.Run();
                        end;
                    end
                    else
                    begin
                        // Imprimir impresión detallada.
                        //SL >>> GAP00054 lo hago desde el OnAfterGetRecord
                        //Funciones.Modify_TipoDeImpresion_PostedSalesInvoice(Factura."No.");
                        //Commit();
                        //SL >>> GAP00054
                        Clear(InformePersonalizado);
                        InformePersonalizado.ConfigurarFiltros(Factura."No.", true);
                        InformePersonalizado.Run();
                    end;
                end;
            }
        }
        modify(Print)
        {
            Visible = false;
        }
    }
    //SL >>> GAP00054
    var _TipoImpresion: Enum AlxiaEventoTipodeImpresion;
    trigger OnAfterGetRecord()
    var
        Funciones: Codeunit FuncionesVarias;
        rEventos: Record Evento;
    begin
        _TipoImpresion:=Rec."Tipo de Impresión";
        if(Rec.NoEvento <> '') and (Not Rec."Tipo de Impresión Ajustada")then begin
            rEventos.SetRange("Codigo Evento", Rec.NoEvento);
            if rEventos.FindFirst()then if rEventos."Tipo de Impresión" <> Rec."Tipo de Impresión" then begin
                    Funciones.Modify_TipoDeImpresion(Rec."No.", rEventos."Tipo de Impresión");
                    Commit();
                    _TipoImpresion:=rEventos."Tipo de Impresión";
                end;
        end;
        if(Rec."Shortcut Dimension 1 Code" = 'ALIMENTACION') and (Rec."Tipo de Impresión" <> Rec."Tipo de Impresión"::"Impresion Detallada")then begin
            Funciones.Modify_TipoDeImpresion_PostedSalesInvoice(Rec."No.");
            Commit();
            _TipoImpresion:=_TipoImpresion::"Impresion Detallada";
        end;
    end;
//SL >>> GAP00054
}
