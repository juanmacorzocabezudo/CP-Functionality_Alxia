pageextension 50039 AlxPostedSalesInvoices extends "Posted Sales Invoices"
{
    layout
    {
        modify("No.")
        {
            StyleExpr = StyleText;
        }
        modify("Due Date")
        {
            StyleExpr = StyleText;
        }
        modify("Sell-to Customer No.")
        {
            StyleExpr = StyleText;
        }
        modify("Sell-to Customer Name")
        {
            StyleExpr = StyleText;
        }
        addafter("Amount Including VAT")
        {
            field("Customer E-Mail"; Rec."Customer E-Mail")
            {
                ApplicationArea = All;
                Caption = 'Email Cliente';
            }
            field("Payment Method Code2"; Rec."Payment Method Code")
            {
                ApplicationArea = All;
                Visible = true;
            }
            field("Payment Terms Code2"; Rec."Payment Terms Code")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        modify(Print)
        {
            Visible = false;
        }
        addafter(Print)
        {
            action(Action50005)
            {
                ApplicationArea = All;
                Caption = 'Imprimir';
                Description = 'GAP00037,GAP00045';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Category7;
                ToolTip = 'Imprime el informe por tipo de impresión indicado en la factura.';

                trigger OnAction()
                var
                    InformePorCapitulo: Report AlxInformeHistFactVntaCapitulo;
                    InformePorCapituloDetallada: Report AlxInformeHistFactVntaCapitDtl;
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
                                Clear(InformePorCapitulo);
                                if Rec."No Impresion Comentarios" then InformePorCapitulo.ConfigurarFiltros(Rec."No.", Rec."Tipo de Impresión", false)
                                else
                                    InformePorCapitulo.ConfigurarFiltros(Rec."No.", Rec."Tipo de Impresión", true);
                                InformePorCapitulo.SetTableView(Factura);
                                InformePorCapitulo.Run();
                            end;
                            Rec."Tipo de Impresión"::"Imp. por Capitulo Dtl.": begin
                                // Imprimir impresión por capítulo detallado.
                                Clear(InformePorCapituloDetallada);
                                if Rec."No Impresion Comentarios" then InformePorCapituloDetallada.ConfigurarFiltros(Rec."No.", Rec."Tipo de Impresión", false)
                                else
                                    InformePorCapituloDetallada.ConfigurarFiltros(Rec."No.", Rec."Tipo de Impresión", true);
                                InformePorCapituloDetallada.SetTableView(Factura);
                                InformePorCapituloDetallada.Run();
                            end;
                            Rec."Tipo de Impresión"::"Impresion Concepto Generico", Rec."Tipo de Impresión"::"Impresion Detallada": begin
                                // Imprimir impresión detallada.
                                Clear(InformeDetallada);
                                if Rec."No Impresion Comentarios" then InformeDetallada.ConfigurarFiltros(Rec."No.", Rec."Tipo de Impresión", false)
                                else
                                    InformeDetallada.ConfigurarFiltros(Rec."No.", Rec."Tipo de Impresión", true);
                                InformeDetallada.SetTableView(Factura);
                                InformeDetallada.Run();
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
    }
    var StyleText: Text[30];
    trigger OnAfterGetRecord()
    var
        Funciones: Codeunit FuncionesVarias;
        rEventos: Record Evento;
    begin
        StyleText:='Standard';
        if Rec."Remaining Amount" <> 0 then if Rec."Due Date" < Today then StyleText:='Unfavorable';
        if(Rec.NoEvento <> '') and (Not Rec."Tipo de Impresión Ajustada")then begin
            rEventos.SetRange("Codigo Evento", Rec.NoEvento);
            if rEventos.FindFirst()then if rEventos."Tipo de Impresión" <> Rec."Tipo de Impresión" then begin
                    Funciones.Modify_TipoDeImpresion(Rec."No.", rEventos."Tipo de Impresión");
                    Commit();
                end;
        end;
        if(Rec."Shortcut Dimension 1 Code" = 'ALIMENTACION') and (Rec."Tipo de Impresión" <> Rec."Tipo de Impresión"::"Impresion Detallada")then begin
            Funciones.Modify_TipoDeImpresion_PostedSalesInvoice(Rec."No.");
            Commit();
        end;
    end;
//SL >>> GAP00054
}
