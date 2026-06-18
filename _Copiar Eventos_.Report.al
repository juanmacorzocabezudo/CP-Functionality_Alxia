report 50000 "Copiar Eventos"
{
    // ADVANCE - Log de cambios
    // -----------------------------------------------------
    //   ADVANCE
    //   Fecha: 23-03-2017
    //   Técnico: JAB
    //   Presupuesto: I004151 - Adaptaciones Copiar Eventos
    //   Modificación: A la hora de copiar un evento, tener en cuenta las nuevas modificaciones hechas del
    //                 desglose en Menaje, Suplemento y Pan
    // 
    //   Etiqueta: ADV001
    // -----------------------------------------------------
    //   ADVANCE
    //   Fecha: 26-07-2017
    //   Técnico: JAB
    //   Presupuesto: I004840 - Adaptaciones Copiar Eventos
    //   Modificación: A la hora de copiar un evento, no copiar los campos de Contratado, Señalizado y poner
    //                 a cero el Importe señal
    // 
    //   Etiqueta: ADV002
    // -----------------------------------------------------
    //DefaultLayout = RDLC;
    //RDLCLayout = './src/report/CopiarEventos.rdlc';
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1000000000;2000000026)
        {
            MaxIteration = 1;

            trigger OnAfterGetRecord()
            begin
                gt_eventoorigen.RESET;
                gt_eventoorigen.SETRANGE(gt_eventoorigen."Codigo Evento", EventoOrigen);
                IF gt_eventoorigen.FINDSET THEN BEGIN
                    gt_eventodestino.INIT;
                    gt_eventodestino.TRANSFERFIELDS(gt_eventoorigen);
                    gt_eventodestino.CreadoEnsamblado:=FALSE;
                    gt_eventodestino."Codigo Evento":='';
                    gt_eventodestino.Estado:=gt_eventodestino.Estado::Presupuesto;
                    // Inicio ADV002
                    gt_eventodestino.Contratado:=FALSE;
                    gt_eventodestino.Senalizado:=FALSE;
                    gt_eventodestino."Imp Senal":=0;
                    //SL GAP00065 >>>
                    gt_eventodestino."Tipo de Impresión":=gt_eventodestino."Tipo de Impresión"::"Imp. por Capitulo Dtl.";
                    gt_eventodestino."Impresion Comentarios":=false;
                    gt_eventodestino."Importe Rechazado":=0;
                    //SL Fin GAP00065 <<<
                    // Fin ADV002
                    gt_eventodestino.INSERT(TRUE);
                    //lineas de evento
                    gt_lineasorigen.RESET;
                    gt_lineasorigen.SETRANGE(gt_lineasorigen."Codigo Evento", EventoOrigen);
                    IF gt_lineasorigen.FINDSET THEN REPEAT gt_lineasdestino.INIT;
                            gt_lineasdestino.TRANSFERFIELDS(gt_lineasorigen);
                            gt_lineasdestino."Codigo Evento":=gt_eventodestino."Codigo Evento";
                            gt_lineasdestino.INSERT;
                        UNTIL gt_lineasorigen.NEXT = 0;
                    //recursos
                    gt_recursosorigen.RESET;
                    gt_recursosorigen.SETRANGE(gt_recursosorigen."Codigo Evento", EventoOrigen);
                    IF gt_recursosorigen.FINDSET THEN REPEAT gt_recursosdestino.INIT;
                            gt_recursosdestino.TRANSFERFIELDS(gt_recursosorigen);
                            gt_recursosdestino."Codigo Evento":=gt_eventodestino."Codigo Evento";
                            gt_recursosdestino.INSERT;
                        UNTIL gt_recursosorigen.NEXT = 0;
                    //desglose evento
                    /*
                    gt_desgloseorigen.RESET;
                    gt_desgloseorigen.SETRANGE(gt_desgloseorigen."Codigo Evento",EventoOrigen);
                    IF gt_desgloseorigen.FINDSET THEN REPEAT
                      gt_desglosedestino.INIT;
                      gt_desglosedestino.TRANSFERFIELDS(gt_desgloseorigen);
                      gt_desglosedestino."Codigo Evento" := gt_eventodestino."Codigo Evento";
                      gt_desglosedestino.INSERT;
                    UNTIL gt_desgloseorigen.NEXT=0;
                    */
                    //componentes
                    gt_componentesorigen.RESET;
                    gt_componentesorigen.SETRANGE(gt_componentesorigen."Codigo Evento", EventoOrigen);
                    IF gt_componentesorigen.FINDSET THEN REPEAT gt_componentesdestino.INIT;
                            gt_componentesdestino.TRANSFERFIELDS(gt_componentesorigen);
                            gt_componentesdestino."Codigo Evento":=gt_eventodestino."Codigo Evento";
                            gt_componentesdestino.INSERT;
                        UNTIL gt_componentesorigen.NEXT = 0;
                    // Inicio ADV001
                    //productos
                    gt_productoorigen.RESET;
                    gt_productoorigen.SETRANGE(gt_productoorigen."Codigo Evento", EventoOrigen);
                    IF gt_productoorigen.FINDSET THEN REPEAT gt_productodestino.INIT;
                            gt_productodestino.TRANSFERFIELDS(gt_productoorigen);
                            gt_productodestino."Codigo Evento":=gt_eventodestino."Codigo Evento";
                            gt_productodestino.INSERT;
                        UNTIL gt_productoorigen.NEXT = 0;
                // Fin ADV001
                END;
                MESSAGE(Text10000, gt_eventodestino."Codigo Evento");
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                field("Evento Origen"; EventoOrigen)
                {
                    ApplicationArea = All;
                    TableRelation = Evento;
                }
            }
        }
        actions
        {
        }
    }
    labels
    {
    }
    var EventoOrigen: Code[20];
    EventoDestino: Code[20];
    gt_eventoorigen: Record 50004;
    gt_eventodestino: Record 50004;
    gt_lineasorigen: Record 50002;
    gt_lineasdestino: Record 50002;
    gt_recursosorigen: Record 50003;
    gt_recursosdestino: Record 50003;
    gt_desgloseorigen: Record 50005;
    gt_desglosedestino: Record 50005;
    gt_componentesorigen: Record 50014;
    gt_componentesdestino: Record 50014;
    Text10000: Label 'Se ha creado el evento Nº %1.';
    gt_productoorigen: Record 50016;
    gt_productodestino: Record 50016;
    procedure SetEventos(_EventoOrigen: Code[20])
    begin
        EventoOrigen:=_EventoOrigen;
    end;
}
