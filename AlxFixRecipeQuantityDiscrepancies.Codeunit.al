codeunit 50010 "Alx Fix Recipe Qty"
{
    procedure FixDiscrepancies(var BOMComponent: Record "BOM Component"): Integer
    var
        ParentItem: Record Item;
        FixedCount: Integer;
        ExpectedQuantityPer: Decimal;
    begin
        FixedCount := 0;

        if BOMComponent.FindSet(true) then begin
            repeat
                if ParentItem.Get(BOMComponent."Parent Item No.") then begin
                    if ParentItem."Lote Receta" <> 0 then begin
                        // Calcular la cantidad esperada por UMB
                        if (BOMComponent.Type = BOMComponent.Type::Resource) and
                           (BOMComponent."Resource Usage Type" = BOMComponent."Resource Usage Type"::Fixed)
                        then
                            ExpectedQuantityPer := BOMComponent."Cantidad por Lote"
                        else
                            ExpectedQuantityPer := BOMComponent."Cantidad por Lote" / ParentItem."Lote Receta";

                        // Comparar con precisión de seis decimales
                        if Round(BOMComponent."Quantity per", 0.000001) <> Round(ExpectedQuantityPer, 0.000001) then begin
                            BOMComponent."Quantity per" := ExpectedQuantityPer;
                            BOMComponent.Modify(false);
                            FixedCount := FixedCount + 1;
                        end;
                    end;
                end;
            until BOMComponent.Next() = 0;
        end;

        exit(FixedCount);
    end;
}
