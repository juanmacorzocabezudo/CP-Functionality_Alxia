report 50014 "Alx Recipe Quantity Audit"
{
    ApplicationArea = All;
    Caption = 'Discrepancias de cantidad en recetas';
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layout/AlxRecipeQuantityAudit.rdl';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = false;

    dataset
    {
        dataitem(ReportHeader; Integer)
        {
            DataItemTableView = sorting(Number) where(Number = const(1));

            column(ReportTitle; ReportTitleLbl)
            {
            }
            column(NoDiscrepancies; NoDiscrepanciesLbl)
            {
            }
            column(ParentItemNoLabel; ParentItemNoLbl)
            {
            }
            column(ParentItemDescriptionLabel; ParentItemDescriptionLbl)
            {
            }
            column(ComponentNoLabel; ComponentNoLbl)
            {
            }
            column(ComponentDescriptionLabel; ComponentDescriptionLbl)
            {
            }
            column(ComponentTypeLabel; ComponentTypeLbl)
            {
            }
            column(UnitOfMeasureLabel; UnitOfMeasureLbl)
            {
            }
            column(BatchQuantityLabel; BatchQuantityLbl)
            {
            }
            column(RecipeBatchLabel; RecipeBatchLbl)
            {
            }
            column(QuantityPerActualLabel; QuantityPerActualLbl)
            {
            }
            column(QuantityPerExpectedLabel; QuantityPerExpectedLbl)
            {
            }

            dataitem(BOMComponent; "BOM Component")
            {
                DataItemTableView = sorting("Parent Item No.", "Line No.");

                column(ParentItemNo; BOMComponent."Parent Item No.")
                {
                }
                column(ParentItemDescription; ParentItem.Description)
                {
                }
                column(ComponentNo; BOMComponent."No.")
                {
                }
                column(ComponentDescription; BOMComponent.Description)
                {
                }
                column(ComponentType; Format(BOMComponent.Type))
                {
                }
                column(UnitOfMeasureCode; BOMComponent."Unit of Measure Code")
                {
                }
                column(BatchQuantity; BOMComponent."Cantidad por Lote")
                {
                }
                column(RecipeBatch; ParentItem."Lote Receta")
                {
                }
                column(QuantityPerActual; ActualQuantityPer)
                {
                }
                column(QuantityPerExpected; ExpectedQuantityPer)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if CachedParentItemNo <> BOMComponent."Parent Item No." then begin
                        ParentItem.Get(BOMComponent."Parent Item No.");
                        CachedParentItemNo := BOMComponent."Parent Item No.";
                    end;

                    if ParentItem."Lote Receta" = 0 then
                        CurrReport.Skip();

                    if (BOMComponent.Type = BOMComponent.Type::Resource) and
                       (BOMComponent."Resource Usage Type" = BOMComponent."Resource Usage Type"::Fixed)
                    then
                        ExpectedQuantityPer := BOMComponent."Cantidad por Lote"
                    else
                        ExpectedQuantityPer := BOMComponent."Cantidad por Lote" / ParentItem."Lote Receta";

                    // Compare and export at the same six-decimal precision as the PDF.
                    ActualQuantityPer := Round(BOMComponent."Quantity per", 0.000001);
                    ExpectedQuantityPer := Round(ExpectedQuantityPer, 0.000001);
                    if ActualQuantityPer = ExpectedQuantityPer then
                        CurrReport.Skip();
                end;

                trigger OnPreDataItem()
                begin
                    ParentItem.SetLoadFields(Description, "Lote Receta");
                    Clear(CachedParentItemNo);
                end;
            }
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Opciones';
                    field(AutoFixDiscrepancies; AutoFixDiscrepancies)
                    {
                        ApplicationArea = All;
                        Caption = 'Arreglar discrepancias automáticamente después de imprimir';
                        ToolTip = 'Si se marca, después de imprimir el PDF, se corregirán automáticamente todas las discrepancias encontradas';
                    }
                }
            }
        }
    }

    trigger OnPreReport()
    begin
        // Nada que hacer aquí
    end;

    trigger OnPostReport()
    var
        BOMComponent: Record "BOM Component";
        FixCodeunit: Codeunit "Alx Fix Recipe Qty";
        FixedCount: Integer;
    begin
        if AutoFixDiscrepancies then begin
            BOMComponent.Reset();
            FixedCount := FixCodeunit.FixDiscrepancies(BOMComponent);
            Message(FixedRecordsMsg, FixedCount);
        end;
    end;

    var
        ParentItem: Record Item;
        CachedParentItemNo: Code[20];
        ActualQuantityPer: Decimal;
        ExpectedQuantityPer: Decimal;
        AutoFixDiscrepancies: Boolean;
        ReportTitleLbl: Label 'Discrepancias de cantidad en recetas';
        NoDiscrepanciesLbl: Label 'No se han encontrado discrepancias de cantidad.';
        ParentItemNoLbl: Label 'N.º producto receta';
        ParentItemDescriptionLbl: Label 'Descripción producto receta';
        ComponentNoLbl: Label 'N.º componente';
        ComponentDescriptionLbl: Label 'Descripción componente';
        ComponentTypeLbl: Label 'Tipo';
        UnitOfMeasureLbl: Label 'Unidad de medida';
        BatchQuantityLbl: Label 'Cantidad por lote';
        RecipeBatchLbl: Label 'Lote receta';
        QuantityPerActualLbl: Label 'Cantidad por UMB actual';
        QuantityPerExpectedLbl: Label 'Cantidad por UMB esperada';
        FixedRecordsMsg: Label 'Se han corregido %1 registros de discrepancias.';
}
