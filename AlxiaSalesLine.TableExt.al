tableextension 50007 AlxiaSalesLine extends "Sales Line"
{
    fields
    {
        field(50000; NoEvento; Code[20])
        {
            Caption = 'Nº Evento';
            Description = 'ADV001';
            TableRelation = Evento;
        }
        field(50001; LineaEvento; Integer)
        {
            Caption = 'Linea Evento';
            Description = 'ADV001';
        }
        field(50002; "Tabla Evento"; Integer)
        {
            Caption = 'Tabla Evento';
            Description = 'ADV001';
        }
        field(50003; Imprime; Boolean)
        {
            Description = 'ADV001';
        }
        field(50004; NombreCliente; Text[100])
        {
            CalcFormula = Lookup("Sales Header"."Sell-to Customer Name" WHERE("Document Type"=FIELD("Document Type"), "No."=FIELD("Document No."), "Sell-to Customer No."=FIELD("Sell-to Customer No.")));
            Description = 'ADV002';
            FieldClass = FlowField;
        }
    }
    trigger OnAfterDelete()
    var
        rlItem: Record 27;
    begin
        //++AGRALA 862
        IF Rec.Type = Rec.Type::Item THEN IF rlItem.GET(Rec."No.")THEN BEGIN
                rlItem.CALCFIELDS(rlItem.Inventory, rlItem.AGRALAQtyAssemblyOrderLine, rlItem.AGRALAQtyOnSalesOrder);
                rlItem.AGRALAStockDisponible:=rlItem.Inventory - (rlItem.AGRALAQtyAssemblyOrderLine - Rec.Quantity) - rlItem.AGRALAQtyOnSalesOrder;
                rlItem.MODIFY();
            END;
    //--AGRALA 862
    end;
    trigger OnAfterInsert()
    var
        rlItem: Record 27;
    begin
        //++AGRALA 862
        IF xRec.Quantity <> Rec.Quantity THEN BEGIN
            IF Rec.Type = Rec.Type::Item THEN IF rlItem.GET(Rec."No.")THEN BEGIN
                    rlItem.CALCFIELDS(rlItem.Inventory, rlItem.AGRALAQtyAssemblyOrderLine, rlItem.AGRALAQtyOnSalesOrder);
                    rlItem.AGRALAStockDisponible:=rlItem.Inventory - (rlItem.AGRALAQtyAssemblyOrderLine + Rec.Quantity) - rlItem.AGRALAQtyOnSalesOrder;
                    rlItem.MODIFY();
                END;
        END;
    //--AGRALA 862
    end;
    trigger OnAfterModify()
    var
        rlItem: Record 27;
        rplAGRALAActualizarStock: Report 50056;
        rlItemAux: Record 27;
    begin
        //++AGRALA 862
        IF Rec.Type = Rec.Type::Item THEN IF rlItem.GET(Rec."No.")THEN BEGIN
                rlItemAux.SETFILTER("No.", '%1', Rec."No.");
                REPORT.RUN(REPORT::AGRALAActualizarStock, FALSE, FALSE, rlItemAux);
            END;
    //--AGRALA 862
    end;
    procedure MarkLine()
    var
        CDU: Codeunit FuncionesVarias;
    begin
        CDU.MarkLineSL(Rec);
    end;
}
