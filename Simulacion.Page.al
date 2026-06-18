page 50030 Simulacion
{
    // 
    // ADVANCE - Log de cambios
    // -----------------------------------------------------
    //   ADVANCE
    //   Fecha: 27-04-2016
    //   Técnico: JMAP
    //   Presupuesto: Proyecto I002483 - RQ600 - Creación de clientes y registro
    // 
    //   Etiqueta: ADV001
    // -----------------------------------------------------
    Caption = 'Assembly Order';
    DeleteAllowed = false;
    Editable = true;
    PageType = Document;
    SourceTable = "Assembly Header";
    SourceTableView = SORTING("Document Type", "No.")ORDER(Ascending)WHERE("Document Type"=CONST(Order));

    layout
    {
    /* area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; "No.")
                {
                    AssistEdit = true;

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Item No."; "Item No.")
                {
                    Editable = IsAsmToOrderEditable;
                    Importance = Promoted;
                    TableRelation = Item."No." WHERE("Assembly BOM" = CONST(true));

                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE;
                    end;
                }
                field(Description; Description)
                {
                }
                group()
                {
                    field(Quantity; Quantity)
                    {
                        Editable = IsAsmToOrderEditable;
                        Importance = Promoted;

                        trigger OnValidate()
                        begin
                            CurrPage.SAVERECORD;
                        end;
                    }
                    field("Unit of Measure Code"; "Unit of Measure Code")
                    {
                        Editable = IsAsmToOrderEditable;

                        trigger OnValidate()
                        begin
                            CurrPage.SAVERECORD;
                        end;
                    }
                }
            }
            part(Lines; 50031)
            {
                Caption = 'Lines';
                SubPageLink = "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("No.");
            }
            group(Posting)
            {
                Caption = 'Posting';
            }
        }
        area(factboxes)
        {
            part(ItemDetail; 910)
            {
                SubPageLink = "No." = FIELD("Item No.");
            }
            part(ItemCompon; 917)
            {
                Provider = Lines;
                SubPageLink = "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("Document No."),
                              "Line No." = FIELD("Line No.");
            }
            part(Recursos; 912)
            {
                Provider = Lines;
                SubPageLink = "No." = FIELD("No.");
            }
            systempart(link; Links)
            {
            }
            systempart(notes; Notes)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
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
                        ItemAvailFormsMgt.ShowItemAvailFromAsmHeader(Rec, ItemAvailFormsMgt.ByEvent);
                    end;
                }
                action(Period)
                {
                    Caption = 'Period';
                    Image = Period;

                    trigger OnAction()
                    begin
                        ItemAvailFormsMgt.ShowItemAvailFromAsmHeader(Rec, ItemAvailFormsMgt.ByPeriod);
                    end;
                }
                action(Variant)
                {
                    Caption = 'Variant';
                    Image = ItemVariant;

                    trigger OnAction()
                    begin
                        ItemAvailFormsMgt.ShowItemAvailFromAsmHeader(Rec, ItemAvailFormsMgt.ByVariant);
                    end;
                }
                action(Location)
                {
                    AccessByPermission = TableData 14 = R;
                    Caption = 'Location';
                    Image = Warehouse;

                    trigger OnAction()
                    begin
                        ItemAvailFormsMgt.ShowItemAvailFromAsmHeader(Rec, ItemAvailFormsMgt.ByLocation);
                    end;
                }
                action("BOM Level")
                {
                    Caption = 'BOM Level';
                    Image = BOMLevel;

                    trigger OnAction()
                    begin
                        ItemAvailFormsMgt.ShowItemAvailFromAsmHeader(Rec, ItemAvailFormsMgt.ByBOM);
                    end;
                }
            }
            group(General2)
            {
                Caption = 'General';
                Image = AssemblyBOM;
                action("Assembly BOM")
                {
                    Caption = 'Assembly BOM';
                    Image = AssemblyBOM;
                    Promoted = true;

                    trigger OnAction()
                    begin
                        ShowAssemblyList;
                    end;
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData 348 = R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        ShowDimensions;
                    end;
                }
                action("Item Tracking Lines")
                {
                    Caption = 'Item &Tracking Lines';
                    Image = ItemTrackingLines;
                    ShortCutKey = 'Shift+Ctrl+I';

                    trigger OnAction()
                    begin
                        OpenItemTrackingLines;
                    end;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page 907;
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "Document No." = FIELD"(No."),
                                  "Document Line No." = CONST(0);
                }
            }
            group(Statistics)
            {
                Caption = 'Statistics';
                Image = Statistics;
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    RunPageOnRec = true;
                    ShortCutKey = 'F7';

                    trigger OnAction()
                    begin
                        ShowStatistics;
                    end;
                }
            }
            group(Warehouse)
            {
                Caption = 'Warehouse';
                Image = Warehouse;
                action("Pick Lines/Movement Lines")
                {
                    Caption = 'Pick Lines/Movement Lines';
                    Image = PickLines;
                    RunObject = Page 5785;
                    RunPageLink = Source Type=CONST(901),
                                  Source Subtype=CONST(1),
                                  Source No.=FIELD(No.);
                    RunPageView = SORTING(Source Type,Source Subtype,Source No.,Source Line No.,Source Subline No.,Unit of Measure Code,Action Type,Breakbulk No.,Original Breakbulk);
                }
                action("Registered P&ick Lines")
                {
                    Caption = 'Registered P&ick Lines';
                    Image = RegisteredDocs;
                    RunObject = Page 7364;
                                    RunPageLink = Source Type=CONST(901),
                                  Source Subtype=CONST(1),
                                  Source No.=FIELD(No.);
                    RunPageView = SORTING(Source Type,Source Subtype,Source No.,Source Line No.,Source Subline No.);
                }
                action("Registered Invt. Movement Lines")
                {
                    Caption = 'Registered Invt. Movement Lines';
                    Image = RegisteredDocs;
                    RunObject = Page 7387;
                                    RunPageLink = Source Type=CONST(901),
                                  Source Subtype=CONST(1),
                                  Source No.=FIELD(No.);
                    RunPageView = SORTING(Source Type,Source Subtype,Source No.,Source Line No.,Source Subline No.);
                }
                action("Asm.-to-Order Whse. Shpt. Line")
                {
                    Caption = 'Asm.-to-Order Whse. Shpt. Line';
                    Enabled = NOT IsAsmToOrderEditable;
                    Image = ShipmentLines;

                    trigger OnAction()
                    var
                        ATOLink: Record "904";
                        WhseShptLine: Record "7321";
                    begin
                        TESTFIELD("Assemble to Order",TRUE);
                        ATOLink.GET("Document Type","No.");
                        WhseShptLine.SETCURRENTKEY("Source Type","Source Subtype","Source No.","Source Line No.","Assemble to Order");
                        WhseShptLine.SETRANGE("Source Type",DATABASE::"Sales Line");
                        WhseShptLine.SETRANGE("Source Subtype",ATOLink."Document Type");
                        WhseShptLine.SETRANGE("Source No.",ATOLink."Document No.");
                        WhseShptLine.SETRANGE("Source Line No.",ATOLink."Document Line No.");
                        WhseShptLine.SETRANGE("Assemble to Order",TRUE);
                        PAGE.RUNMODAL(PAGE::"Asm.-to-Order Whse. Shpt. Line",WhseShptLine);
                    end;
                }
            }
            group(History)
            {
                Caption = 'History';
                Image = History;
                group(Entries)
                {
                    Caption = 'Entries';
                    Image = Entries;
                    action("Item Ledger Entries")
                    {
                        Caption = 'Item Ledger Entries';
                        Image = ItemLedger;
                        RunObject = Page 38;
                                        RunPageLink = Order Type=CONST(Assembly),
                                      Order No.=FIELD(No.);
                        RunPageView = SORTING(Order Type,Order No.);
                        ShortCutKey = 'Ctrl+F7';
                    }
                    action("Capacity Ledger Entries")
                    {
                        Caption = 'Capacity Ledger Entries';
                        Image = CapacityLedger;
                        RunObject = Page 5832;
                                        RunPageLink = Order Type=CONST(Assembly),
                                      Order No.=FIELD(No.);
                        RunPageView = SORTING(Order Type,Order No.);
                    }
                    action("Resource Ledger Entries")
                    {
                        Caption = 'Resource Ledger Entries';
                        Image = ResourceLedger;
                        RunObject = Page 202;
                                        RunPageLink = Order Type=CONST(Assembly),
                                      Order No.=FIELD(No.);
                        RunPageView = SORTING(Order Type,Order No.);
                    }
                    action("Value Entries")
                    {
                        Caption = 'Value Entries';
                        Image = ValueLedger;
                        RunObject = Page 5802;
                                        RunPageLink = Order Type=CONST(Assembly),
                                      Order No.=FIELD(No.);
                        RunPageView = SORTING(Order Type,Order No.);
                    }
                    action("Warehouse Entries")
                    {
                        Caption = 'Warehouse Entries';
                        Image = BinLedger;
                        RunObject = Page 7318;
                                        RunPageLink = Source Type=FILTER(83|901),
                                      Source Subtype=FILTER(1|6),
                                      Source No.=FIELD(No.);
                        RunPageView = SORTING(Source Type,Source Subtype,Source No.);
                    }
                    action("Reservation Entries")
                    {
                        AccessByPermission = TableData 27=R;
                        Caption = 'Reservation Entries';
                        Image = ReservationLedger;

                        trigger OnAction()
                        begin
                            ShowReservationEntries(TRUE);
                        end;
                    }
                }
                action("Posted Assembly Orders")
                {
                    Caption = 'Posted Assembly Orders';
                    Image = PostedOrder;
                    RunObject = Page 922;
                                    RunPageLink = Order No.=FIELD(No.);
                    RunPageView = SORTING(Order No.);
                }
            }
            separator()
            {
            }
        }
        area(processing)
        {
            group(Release)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                separator()
                {
                }
                action("Re&lease")
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
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
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        ReleaseAssemblyDoc: Codeunit "903";
                    begin
                        ReleaseAssemblyDoc.Reopen(Rec);
                    end;
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action(ShowAvailability)
                {
                    Caption = 'Show Availability';
                    Image = ItemAvailbyLoc;
                    Promoted = true;

                    trigger OnAction()
                    begin
                        ShowAvailability;
                    end;
                }
                action("Update Unit Cost")
                {
                    Caption = 'Update Unit Cost';
                    Enabled = IsUnitCostEditable;
                    Image = UpdateUnitCost;
                    Promoted = true;

                    trigger OnAction()
                    begin
                        UpdateUnitCost;
                    end;
                }
                action("Refresh Lines")
                {
                    Caption = 'Refresh Lines';
                    Image = RefreshLines;

                    trigger OnAction()
                    begin
                        RefreshBOM;
                        CurrPage.UPDATE;
                    end;
                }
                action("&Reserve")
                {
                    Caption = '&Reserve';
                    Ellipsis = true;
                    Image = Reserve;

                    trigger OnAction()
                    begin
                        ShowReservation;
                    end;
                }
                action("Copy Document")
                {
                    Caption = 'Copy Document';
                    Image = CopyDocument;

                    trigger OnAction()
                    var
                        CopyAssemblyDocument: Report "901";
                    begin
                        CopyAssemblyDocument.SetAssemblyHeader(Rec);
                        CopyAssemblyDocument.RUNMODAL;
                    end;
                }
                separator()
                {
                }
            }
            group(Warehouse)
            {
                Caption = 'Warehouse';
                Image = Warehouse;
                action("Create Inventor&y Movement")
                {
                    Caption = 'Create Inventor&y Movement';
                    Ellipsis = true;
                    Image = CreatePutAway;

                    trigger OnAction()
                    var
                        ATOMovementsCreated: Integer;
                        TotalATOMovementsToBeCreated: Integer;
                    begin
                        CreateInvtMovement(FALSE,FALSE,FALSE,ATOMovementsCreated,TotalATOMovementsToBeCreated);
                    end;
                }
                action("Create Whse. Pick")
                {
                    AccessByPermission = TableData 7302=R;
                    Caption = 'Create Whse. Pick';
                    Image = CreateWarehousePick;

                    trigger OnAction()
                    begin
                        CreatePick(TRUE,USERID,0,FALSE,FALSE,FALSE);
                    end;
                }
                action("Order &Tracking")
                {
                    Caption = 'Order &Tracking';
                    Image = OrderTracking;

                    trigger OnAction()
                    begin
                        ShowTracking;
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
            }
            group(Print)
            {
                Caption = 'Print';
                Image = Print;
                action("Imprimir Simulacion")
                {
                    Caption = 'Imprimir Simulacion';
                    Ellipsis = true;
                    Image = Print;

                    trigger OnAction()
                    var
                        DocPrint: Codeunit "229";
                    begin
                        DocPrint.PrintAsmHeader(Rec);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IsUnitCostEditable := NOT IsStandardCostItem;
        IsAsmToOrderEditable := NOT IsAsmToOrder;
    end;

    trigger OnDeleteRecord(): Boolean
    var
        AssemblyHeaderReserve: Codeunit "925";
    begin
        TESTFIELD("Assemble to Order",FALSE);
        IF (Quantity <> 0) AND ItemExists("Item No.") THEN BEGIN
          COMMIT;
          IF NOT AssemblyHeaderReserve.DeleteLineConfirm(Rec) THEN
            EXIT(FALSE);
          AssemblyHeaderReserve.DeleteLine(Rec);
        END;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Simulacion := TRUE;
    end;

    trigger OnOpenPage()
    begin
        IsUnitCostEditable := TRUE;
        IsAsmToOrderEditable := TRUE;
        UpdateWarningOnLines;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF DELETE(TRUE) THEN;
    end;

    var
        ItemAvailFormsMgt: Codeunit "353";
      
        IsUnitCostEditable: Boolean;
      
        IsAsmToOrderEditable: Boolean; */
    }
}
