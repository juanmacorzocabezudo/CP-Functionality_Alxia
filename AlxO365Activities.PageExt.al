pageextension 50024 AlxO365Activities extends "O365 Activities"
{
    layout
    {
        addafter("Incoming Documents")
        {
            cuegroup("Envento")
            {
                Caption = 'Eventos';

                field(FormPreparacion; Rec.FormPresupuestado)
                {
                    ApplicationArea = ALL;
                    DrillDownPageID = "Lista de Eventos";
                    Caption = 'Presupuesto';

                    trigger OnDrillDown()
                    begin
                        DrillDown(Estado::Presupuesto);
                    end;
                }
                field(FormPdfFirma; Rec.FormAceptado)
                {
                    ApplicationArea = ALL;
                    DrillDownPageID = "Lista de Eventos";
                    Caption = 'Aceptado';

                    trigger OnDrillDown()
                    begin
                        DrillDown(Estado::Aceptado);
                    end;
                }
                field(FormFirmadas; Rec.FormRechazado)
                {
                    ApplicationArea = ALL;
                    DrillDownPageID = "Lista de Eventos";
                    Caption = 'Rechazado';

                    trigger OnDrillDown()
                    begin
                        DrillDown(Estado::Rechazado);
                    end;
                }
                field(FormRechazadas; Rec.FormAnulado)
                {
                    ApplicationArea = ALL;
                    DrillDownPageID = "Lista de Eventos";
                    Caption = 'Anulado';

                    trigger OnDrillDown()
                    begin
                        DrillDown(Estado::Anulado);
                    end;
                }
                field(FormRealizado; Rec.FormRealizado)
                {
                    ApplicationArea = ALL;
                    DrillDownPageID = "Lista de Eventos";
                    Caption = 'Realizado';

                    trigger OnDrillDown()
                    begin
                        DrillDown(Estado::Realizado);
                    end;
                }
                field(FormArchivado; Rec.FormArchivado)
                {
                    ApplicationArea = ALL;
                    DrillDownPageID = "Lista de Eventos";
                    Caption = 'Archivado';

                    trigger OnDrillDown()
                    begin
                        DrillDown(Estado::Archivado);
                    end;
                }
            /*  field(FormEnProceso; Rec.FormEnProceso)
                 {
                     ApplicationArea = ALL;
                     DrillDownPageID = "Lista de Eventos";
                     Caption = 'En Proceso';

                     trigger OnDrillDown()
                     begin
                         DrillDown(Estado::EnProceso);
                     end;
                 } */
            }
            cuegroup("PedEns")
            {
                Caption = 'Pedidos Ensamblado';

                field(FormPedidoEns; Rec.FormPedidoEns)
                {
                    ApplicationArea = All;
                    Caption = 'Total';
                    DrillDownPageID = "Assembly Orders";
                }
            }
            cuegroup(StockDisponbile)
            {
                Caption = 'Stock disponible negativo';

                field(StockNegativo; Rec.StockNegativo)
                {
                    Caption = 'Cantidad de productos';
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        DrillStock();
                    end;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        recEvento: Record Evento;
        recAssemOrder: Record "Assembly Header";
        recSRS: Record "Sales & Receivables Setup";
        rItem: Record Item;
        cantItem: Integer;
    begin
        recSRS.Get();
        if(recSRS.FechaDesde <> 0D) and (recSRS.FechaHasta <> 0D)then begin
            recEvento.Reset();
            recEvento.SetRange(recEvento.Estado, recEvento.Estado::Presupuesto);
            recEvento.SetFilter(recEvento."Fecha Evento", '%1..%2', recSRS.FechaDesde, recSRS.FechaHasta);
            if recEvento.FindFirst()then;
            Rec.FormPresupuestado:=recEvento.Count;
            Rec.Modify(false);
            recEvento.Reset();
            recEvento.SetRange(recEvento.Estado, recEvento.Estado::Aceptado);
            recEvento.SetFilter(recEvento."Fecha Evento", '%1..%2', recSRS.FechaDesde, recSRS.FechaHasta);
            if recEvento.FindFirst()then;
            Rec.FormAceptado:=recEvento.Count;
            Rec.Modify(false);
            recEvento.Reset();
            recEvento.SetRange(recEvento.Estado, recEvento.Estado::Rechazado);
            recEvento.SetFilter(recEvento."Fecha Evento", '%1..%2', recSRS.FechaDesde, recSRS.FechaHasta);
            if recEvento.FindFirst()then;
            Rec.FormRechazado:=recEvento.Count;
            Rec.Modify(false);
            recEvento.Reset();
            recEvento.SetRange(recEvento.Estado, recEvento.Estado::Anulado);
            recEvento.SetFilter(recEvento."Fecha Evento", '%1..%2', recSRS.FechaDesde, recSRS.FechaHasta);
            if recEvento.FindFirst()then;
            Rec.FormAnulado:=recEvento.Count;
            Rec.Modify(false);
            recEvento.Reset();
            recEvento.SetRange(recEvento.Estado, recEvento.Estado::Archivado);
            recEvento.SetFilter(recEvento."Fecha Evento", '%1..%2', recSRS.FechaDesde, recSRS.FechaHasta);
            if recEvento.FindFirst()then;
            Rec.FormArchivado:=recEvento.Count;
            Rec.Modify(false);
            recEvento.Reset();
            recEvento.SetRange(recEvento.Estado, recEvento.Estado::Realizado);
            recEvento.SetFilter(recEvento."Fecha Evento", '%1..%2', recSRS.FechaDesde, recSRS.FechaHasta);
            if recEvento.FindFirst()then;
            Rec.FormRealizado:=recEvento.Count;
            Rec.Modify(false);
        /*   recEvento.Reset();
              recEvento.SetRange(recEvento.Estado, recEvento.Estado::EnProceso);
              recEvento.SetFilter(recEvento."Fecha Evento", '%1..%2', recSRS.FechaDesde, recSRS.FechaHasta);
              if recEvento.FindFirst() then;
              Rec.FormEnProceso := recEvento.Count;
              Rec.Modify(false); */
        end;
        recAssemOrder.Reset();
        if recAssemOrder.FindFirst()then begin
            Rec.FormPedidoEns:=recAssemOrder.Count;
            Rec.Modify(false);
        end;
        rItem.Reset();
        rItem.SetFilter("No.", 'MP*|MA*|PI*');
        rItem.SetRange(Blocked, false);
        if rItem.FindSet()then begin
            rItemAux.DeleteAll();
            repeat rItem.CalcFields(Inventory);
                rItem.CalcFields(AGRALAQtyAssemblyOrderLine);
                rItem.CalcFields(AGRALAQtyOnSalesOrder);
                if(rItem.Inventory - rItem.AGRALAQtyAssemblyOrderLine - rItem.AGRALAQtyOnSalesOrder) < 0 then begin
                    cantItem:=cantItem + 1;
                    rItemAux.TransferFields(rItem);
                    rItemAux.Insert();
                end;
            until rItem.Next() = 0;
            Rec.StockNegativo:=cantItem;
            Rec.Modify(false);
        end;
    end;
    procedure DrillDown(Estado: Option)
    var
        recEvento: Record Evento;
        pageGA: Page "Lista de Eventos";
    begin
        recEvento.Reset();
        recEvento.SetRange(recEvento.Estado, Estado);
        pageGA.SetTableView(recEvento);
        pageGA.Run();
    end;
    procedure DrillStock()
    var
        pageGA: Page "Item List";
    begin
        //pageGA.SetTableView(rItemAux);
        PAGE.RUN(31, rItemAux);
    end;
    var Estado: Option Presupuesto, Aceptado, Rechazado, Anulado, Realizado, Archivado, EnProceso;
    rItemAux: Record Item temporary;
}
