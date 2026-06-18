page 50039 "Assembly Orders Associated"
{
/*
    // #9627 - Se crea el formulario nuevo para los pedidos asociados

    Caption = 'Assembly Orders';
    CardPageID = "Assembly Order";
    DataCaptionFields = "No.";
    Editable = false;
    PageType = List;
    SourceTable = 900;
    SourceTableView = WHERE("Document Type" = FILTER(Order),
                            Simulacion = FILTER(false),
                            "Associated Order" = CONST(true));

    layout
    {
        area(content)
        {
            repeater(Rep)
            {
                field("Document Type"; Rec."Document Type")
                {
                }
                field("No."; Rec."No.")
                {
                }
                field("Associated Order No."; Rec."Associated Order No.")
                {
                }
                field("Associated First Order No."; Rec."Associated First Order No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(AGRALAFechaProduccion; Rec.AGRALAFechaProduccion)
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field(AGRALAFechaEntrega; Rec.AGRALAFechaEntrega)
                {
                }
                field("Due Date"; Rec."Due Date")
                {
                    Visible = false;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    Visible = false;
                }
                field("Ending Date"; Rec."Ending Date")
                {
                    Visible = false;
                }
                field("Assemble to Order"; Rec."Assemble to Order")
                {
                }
                field("Item No."; Rec."Item No.")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                }
                field("Location Code"; Rec."Location Code")
                {
                }
                field("Variant Code"; Rec."Variant Code")
                {
                }
                field("Bin Code"; Rec."Bin Code")
                {
                }
                field("Remaining Quantity"; Rec."Remaining Quantity")
                {
                }
                field(NoEvento; Rec.NoEvento)
                {
                }
                field("Cantidad Original"; Rec."Cantidad Original")
                {
                }
                field(Diferencia; Rec.Diferencia)
                {
                    StyleExpr = StyleTextDiferencia;
                }
                field("Diferencia%"; "Diferencia%")
                {
                    StyleExpr = StyleTextDiferencia;
                }
                field(AGRALASemana; Rec.AGRALASemana)
                {
                    Visible = false;
                }
                field(AGRALAParteReceta; Rec.AGRALAParteReceta)
                {
                    Visible = false;
                }
                field(AGRALAObservaciones; Rec.AGRALAObservaciones)
                {
                    Visible = false;
                }
                field(AGRALAObservacionesIntern; Rec.AGRALAObservacionesIntern)
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(RecordLinks; Links)
            {
                Caption = 'RecordLinks';
                Visible = false;
            }
            systempart(notes; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Line)
            {
                Caption = 'Line';
                Image = Line;
                group(Entries)
                {
                    Caption = 'Entries';
                    Image = Entries;
                    action("Item Ledger Entries")
                    {
                        Caption = 'Item Ledger E&ntries';
                        Image = ItemLedger;
                        RunObject = Page 38;
                        RunPageLink = "Order Type" = CONST(Assembly),
                                      "Order No." = FIELD("No.");
                        RunPageView = SORTING("Order Type", "Order No.");
                        ShortCutKey = 'Ctrl+F7';
                    }
                    action("Capacity Ledger Entries")
                    {
                        Caption = 'Capacity Ledger Entries';
                        Image = CapacityLedger;
                        RunObject = Page 5832;
                        RunPageLink = "Order Type" = CONST(Assembly),
                                      "Order No." = FIELD("No.");
                        RunPageView = SORTING("Order Type", "Order No.");
                    }
                    action("Resource Ledger Entries")
                    {
                        Caption = 'Resource Ledger Entries';
                        Image = ResourceLedger;
                        RunObject = Page 202;
                        RunPageLink = "Order Type" = CONST(Assembly),
                                      "Order No." = FIELD("No.");
                        RunPageView = SORTING("Order Type", "Order No.");
                    }
                    action("Value Entries")
                    {
                        Caption = 'Value Entries';
                        Image = ValueLedger;
                        RunObject = Page 5802;
                        RunPageLink = "Order Type" = CONST(Assembly),
                                      "Order No." = FIELD("No.");
                        RunPageView = SORTING("Order Type", "Order No.");
                    }
                    action("Warehouse Entries")
                    {
                        Caption = '&Warehouse Entries';
                        Image = BinLedger;
                        RunObject = Page 7318;
                        RunPageLink = "Source Type" = FILTER(83 | 901),
                                      "Source Subtype" = FILTER(1 | 6),
                                      "Source No." = FIELD("No.");
                        RunPageView = SORTING("Source Type", "Source Subtype", "Source No.");
                    }
                }
                action("Show Order")
                {
                    Caption = 'Show Order';
                    Image = ViewOrder;
                    RunObject = Page 900;
                    RunPageLink = Document Type=FIELD(Document Type),
                                  No.=FIELD(No.);
                    ShortCutKey = 'Shift+F7';
                }
                action("Ensamblados Registrados")
                {
                    Image = PickLines;

                    trigger OnAction()
                    begin
                        Rec.ShowPostedAssemblyOrders(Rec."Item No.");
                    end;
                }
                action("Todos los ensamblados registrados")
                {
                    Image = RegisteredDocs;

                    trigger OnAction()
                    begin
                        Rec.ShowPostedAssemblyOrders('');
                    end;
                }
                group("Item Availability by")
                {
                    Caption = 'Item Availability by';
                    Image = ItemAvailability;
                    action("Event")
                    {
                        Caption = 'Event';
                        Image = "Event";

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromAsmHeader(Rec,ItemAvailFormsMgt.ByEvent);
                        end;
                    }
                    action(Period)
                    {
                        Caption = 'Period';
                        Image = Period;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromAsmHeader(Rec,ItemAvailFormsMgt.ByPeriod);
                        end;
                    }
                    action(Variant)
                    {
                        Caption = 'Variant';
                        Image = ItemVariant;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromAsmHeader(Rec,ItemAvailFormsMgt.ByVariant);
                        end;
                    }
                    action(Location)
                    {
                        AccessByPermission = TableData 14=R;
                        Caption = 'Location';
                        Image = Warehouse;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromAsmHeader(Rec,ItemAvailFormsMgt.ByLocation);
                        end;
                    }
                    action("BOM Level")
                    {
                        Caption = 'BOM Level';
                        Image = BOMLevel;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromAsmHeader(Rec,ItemAvailFormsMgt.ByBOM);
                        end;
                    }
                }
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    RunObject = Page 916;
                                    RunPageOnRec = true;
                                    ShortCutKey = 'F7';
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData 348=R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        ShowDimensions;
                    end;
                }
                action("Assembly BOM")
                {
                    Caption = 'Assembly BOM';
                    Image = AssemblyBOM;
                    RunObject = Page 36;
                                    RunPageLink = Parent Item No.=FIELD(Item No.);
                }
                action(Comments)
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page 907;
                                    RunPageLink = Document Type=FIELD(Document Type),
                                  Document No.=FIELD(No.),
                                  Document Line No.=CONST(0);
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Re&lease")
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction()
                    begin
                        CODEUNIT.RUN(CODEUNIT::"Release Assembly Document",Rec);
                    end;
                }
                action("Re&open")
                {
                    Caption = 'Re&open';
                    Image = ReOpen;

                    trigger OnAction()
                    var
                        ReleaseAssemblyDoc: Codeunit "903";
                    begin
                        ReleaseAssemblyDoc.Reopen(Rec);
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action("P&ost")
                {
                    Caption = 'P&ost';
                    Ellipsis = true;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin
                        CODEUNIT.RUN(CODEUNIT::"Assembly-Post (Yes/No)",Rec);
                    end;
                }
                action("Post &Batch")
                {
                    Caption = 'Post &Batch';
                    Ellipsis = true;
                    Image = PostBatch;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        REPORT.RUNMODAL(REPORT::"Batch Post Assembly Orders",TRUE,TRUE,Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //++ KR
        StyleTextDiferencia := 'Standard';
        IF Diferencia > 0 THEN
          StyleTextDiferencia := 'Unfavorable'
        ELSE IF Diferencia < 0 THEN
          StyleTextDiferencia := 'Favorable';
    end;

    trigger OnOpenPage()
    begin
        SETRANGE(Simulacion,FALSE);
    end;

    var
        ItemAvailFormsMgt: Codeunit "353";
        "//++ KR": Integer;
        StyleTextDiferencia: Text;
*/
}
