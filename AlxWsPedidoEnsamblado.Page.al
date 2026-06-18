page 50149 AlxWsPedidoEnsamblado
{
    ApplicationArea = All;
    Caption = 'AlxWsPedidoEnsamblado';
    PageType = List;
    SourceTable = "Assembly Header";
    UsageCategory = Lists;
    SourceTableView = where("Document Type"=filter(Order), "No."=filter(<>''), "Associated Order"=const(false), "Shortcut Dimension 1 Code"=filter('ALIMENTACION'));

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Semana; Rec.AGRALASemana)
                {
                    ApplicationArea = All;
                }
                field("Fecha Produccion"; Rec.AGRALAFechaProduccion)
                {
                    ApplicationArea = All;
                }
                field("Fecha Ultima Fabricación"; Rec."AGRALAFechaUltimaFabricación")
                {
                    ApplicationArea = All;
                }
                field("Fecha Entrega"; Rec.AGRALAFechaEntrega)
                {
                    ApplicationArea = All;
                }
                field("Parte Receta"; Rec.AGRALAParteReceta)
                {
                    ApplicationArea = All;
                }
                field("Nº Producto"; Rec."Item No.")
                {
                    ApplicationArea = All;
                    Caption = 'Nº Producto';
                }
                field(Descripcion; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Descripcion';
                }
                field(Cantidad; Rec.Quantity)
                {
                    ApplicationArea = All;
                    Caption = 'Cantidad';
                }
                field(Observaciones; Rec.AGRALAObservaciones)
                {
                    ApplicationArea = All;
                }
                field("Observaciones Internas"; Rec.AGRALAObservacionesIntern)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
/* 
        trigger OnAfterGetRecord()
        var
            recAH: Record "Assembly Header";
        begin
            ClearAll();
            recAH.SetRange("Document Type", Rec."Document Type");
            recAH.SetRange("No.", Rec."Document No.");
            if recAH.FindFirst() then begin
                _AGRALASemana := recAH.AGRALASemana;
                _AGRALAFechaProduccion := recAH.AGRALAFechaProduccion;
                _AGRALAFechaUltimaFabricacion := recAH."AGRALAFechaUltimaFabricación";
                _AGRALAFechaEntrega := recAH.AGRALAFechaEntrega;
                _AGRALAParteReceta := Format(recAH.AGRALAParteReceta);
                _AGRALAObservaciones := recAH.AGRALAObservaciones;
                _AGRALAObservacionesIntern := recAH.AGRALAObservacionesIntern;
            end;
        end; */
/*  var
         _AGRALASemana: Integer;
         _AGRALAFechaProduccion: Date;
         _AGRALAFechaUltimaFabricacion: Date;
         _AGRALAFechaEntrega: Date;
         _AGRALAParteReceta: Text;
         _AGRALAObservaciones: Text;
         _AGRALAObservacionesIntern: Text; */
}
