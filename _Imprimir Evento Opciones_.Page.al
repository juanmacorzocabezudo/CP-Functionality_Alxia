page 50029 "Imprimir Evento Opciones"
{
    //Permissions = tabledata Evento = rm;
    layout
    {
        area(content)
        {
            group(Control50000)
            {
                Caption = 'Informe Evento';

                field("Imprimir Informe Evento"; gb_MostrarComentarios)
                {
                    ApplicationArea = all;
                }
                group(Control50001)
                {
                    Caption = 'Filtros: Informe evento';

                    field("Tipo de Impresion"; TipoDeImpresion)
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Imprimir Comentarios"; ImprimirComentarios)
                    {
                        ApplicationArea = All;
                    }
                }
            }
            group(Control50002)
            {
                Caption = 'Informe Hoja de Producción';

                field("Imprimir Hoja de Producción"; gb_MostrarHojaProduccion)
                {
                    ApplicationArea = all;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            group(g)
            {
                action(Imprimir)
                {
                    ApplicationArea = All;
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        InformeImpPorCapitulo: Report "Evento Impresion por Capitulo"; //"Informe Evento - Imp. Capitulo";
                        InformeImpPorCapituloDtl: Report "Evento Imp. por Capitulo Dtl."; //"InformeEvento - ImpCapituloDtl";
                    begin
                        IF gb_MostrarComentarios THEN BEGIN
                            case TipoDeImpresion of TipoDeImpresion::"Impresion Concepto Generico", TipoDeImpresion::"Impresion Detallada": begin
                                CLEAR(GRP_EVENTO);
                                GRP_EVENTO.ModificarFiltrosDelEvento(TipoDeImpresion, ImprimirComentarios);
                                GRP_EVENTO.SETTABLEVIEW(gr_Evento);
                                GRP_EVENTO.RUN;
                            end;
                            TipoDeImpresion::"Impresion por Capitulo": begin
                                Clear(InformeImpPorCapitulo);
                                //InformeImpPorCapitulo.ModificarFiltrosDelEvento(TipoDeImpresion, ImprimirComentarios);
                                InformeImpPorCapitulo.ConfigurarFiltros(gr_Evento."Codigo Evento", ImprimirComentarios);
                                //InformeImpPorCapitulo.SetTableView(gr_Evento);
                                InformeImpPorCapitulo.Run();
                            end;
                            TipoDeImpresion::"Imp. por Capitulo Dtl.": begin
                                Clear(InformeImpPorCapituloDtl);
                                //InformeImpPorCapituloDtl.ModificarFiltrosDelEvento(TipoDeImpresion, ImprimirComentarios);
                                InformeImpPorCapituloDtl.ConfigurarFiltros(gr_Evento."Codigo Evento", ImprimirComentarios);
                                //InformeImpPorCapituloDtl.SetTableView(gr_Evento);
                                InformeImpPorCapituloDtl.Run();
                            end;
                            end;
                        END;
                        IF gb_MostrarHojaProduccion THEN BEGIN
                            CLEAR(GRP_HOJA);
                            GRP_HOJA.SETTABLEVIEW(gr_Evento);
                            GRP_HOJA.RUN;
                        END;
                    end;
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        gb_MostrarComentarios:=TRUE;
        gb_MostrarHojaProduccion:=TRUE;
        ImprimirComentarios:=true;
    end;
    var gb_MostrarComentarios: Boolean;
    gb_MostrarHojaProduccion: Boolean;
    gr_Evento: Record 50004;
    GRP_EVENTO: Report 50007;
    GRP_HOJA: Report 50018;
    ImprimirComentarios: Boolean;
    TipoDeImpresion: Enum AlxiaEventoTipodeImpresion;
    procedure Get_Evento(_CodeEvento: Code[20])
    begin
        gr_Evento.RESET;
        gr_Evento.SETRANGE(gr_Evento."Codigo Evento", _CodeEvento);
        IF gr_Evento.FINDFIRST THEN;
        TipoDeImpresion:=gr_Evento."Tipo de Impresión";
    end;
}
