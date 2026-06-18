page 50050 "BOM Version Header"
{
    Caption = 'BOM Version Header';
    PageType = Card;
    SourceTable = "BOM Version Header";
    DeleteAllowed = false;
    InsertAllowed = false;
    SourceTableView = SORTING("Item No.", "BOM Version");

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("BOM Version"; Rec."BOM Version")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Lote Receta"; Rec."Lote Receta")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Base Unit of Measure"; Rec."Base Unit of Measure")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Statistics Lot"; Rec."Statistics Lot")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Statistics Unit of Measurement"; Rec."Statistics Unit of Measurement")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                }
            }
            part(part1;50051)
            {
                ApplicationArea = All;
                Editable = false;
                SubPageLink = "Parent Item No."=FIELD("Item No."), "BOM Version"=FIELD("BOM Version");
                SubPageView = SORTING("Parent Item No.", "BOM Version", "Line No.")ORDER(Ascending);
            }
            part(part2;50052)
            {
                ApplicationArea = All;
                Editable = false;
                SubPageLink = "Parent Item No."=FIELD("Item No."), "BOM Version"=FIELD("BOM Version");
                SubPageView = SORTING("Parent Item No.", "BOM Version", "Line No.")ORDER(Ascending);
            }
            part("Elaboración";50053)
            {
                ApplicationArea = All;
                Caption = 'Elaboración';
                Editable = false;
                SubPageLink = "Table Name"=CONST(Receta), "No."=FIELD("Item No."), "BOM Version"=FIELD("BOM Version");
            }
        }
        area(factboxes)
        {
            part(part3;50054)
            {
                ApplicationArea = All;
                SubPageLink = "Item No."=FIELD("Item No."), "BOM Version"=FIELD("BOM Version");
            }
        }
    }
    actions
    {
        area(processing)
        {
            group("Actions")
            {
                Caption = 'Actions';

                action(VersionRecovery)
                {
                    ApplicationArea = All;
                    Caption = 'Version Recovery';
                    Image = Reconcile;
                    Promoted = true;

                    trigger OnAction()
                    var
                        FuncionesVarias: Codeunit 50003;
                    begin
                        //-- #9993
                        CLEAR(FuncionesVarias);
                        FuncionesVarias.RecuperateBOMVersion(Rec);
                    //++ #9993
                    end;
                }
            }
        }
        area(navigation)
        {
            group(Navegate)
            {
                Caption = 'Navegar';

                action(Item)
                {
                    ApplicationArea = All;
                    Caption = 'Item List';
                    Image = Item;
                    RunObject = Page 31;
                }
                action(Resource)
                {
                    ApplicationArea = All;
                    Caption = 'Resource List';
                    Image = Resource;
                    RunObject = Page 77;
                }
                action(Supply)
                {
                    ApplicationArea = All;
                    Caption = 'Supply List';
                    Image = Tools;
                    RunObject = Page 50042;
                }
                action(WorkCenter)
                {
                    ApplicationArea = All;
                    Caption = 'Work Center List';
                    Image = WorkCenter;
                    RunObject = Page 50046;
                }
                separator(sep)
                {
                }
                action(BOMCost)
                {
                    ApplicationArea = All;
                    Caption = 'Aditional Cost';
                    Image = Costs;
                    RunObject = Page 50060;
                    RunPageLink = "Item No"=FIELD("Item No."), "BOM Version"=FIELD("BOM Version");
                    RunPageView = SORTING("Item No", "BOM Version", "No. Cost");
                }
                separator(sep2)
                {
                }
                action("Ledger E&ntries")
                {
                    ApplicationArea = All;
                    Caption = 'Ledger E&ntries';
                    Image = ItemLedger;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page 38;
                    RunPageLink = "Item No."=FIELD("Item No.");
                    RunPageView = SORTING("Item No.");
                    ShortCutKey = 'Ctrl+F7';
                }
            }
            group("Assembly/Production")
            {
                Caption = 'Assembly/Production';
                Image = Production;

                action(Structure)
                {
                    ApplicationArea = All;
                    Caption = 'Structure';
                    Image = Hierarchy;

                    trigger OnAction()
                    var
                        Item: Record 27;
                        BOMStructure: Page 5870;
                    begin
                        //-- #9804
                        Item.GET(Rec."Item No.");
                        BOMStructure.InitItem(Item);
                        BOMStructure.RUN;
                    //++ #9804
                    end;
                }
                action("Cost Shares")
                {
                    ApplicationArea = All;
                    Caption = 'Cost Shares';
                    Image = CostBudget;

                    trigger OnAction()
                    var
                        Item: Record 27;
                        BOMCostShares: Page 5872;
                    begin
                        //-- #9804
                        Item.GET(Rec."Item No.");
                        BOMCostShares.InitItem(Item);
                        BOMCostShares.RUN;
                    //++ #9804
                    end;
                }
                group("Assemb&ly")
                {
                    Caption = 'Assemb&ly';
                    Image = AssemblyBOM;

                    action("Where-Used")
                    {
                        ApplicationArea = All;
                        Caption = 'Where-Used';
                        Image = Track;
                        RunObject = Page 37;
                        RunPageLink = Type=CONST(Item), "No."=FIELD("Item No.");
                        RunPageView = SORTING(Type, "No.");
                    }
                    action("Calc. Stan&dard Cost")
                    {
                        ApplicationArea = All;
                        AccessByPermission = TableData 90=R;
                        Caption = 'Calc. Stan&dard Cost';
                        Image = CalculateCost;

                        trigger OnAction()
                        begin
                            //-- #9804
                            CLEAR(CalculateStdCost);
                            CalculateStdCost.CalcItem(Rec."Item No.", TRUE);
                        //++ #9804
                        end;
                    }
                    action("Calc. Unit Price")
                    {
                        ApplicationArea = All;
                        AccessByPermission = TableData 90=R;
                        Caption = 'Calc. Unit Price';
                        Image = SuggestItemPrice;
                        Visible = false;

                        trigger OnAction()
                        begin
                            //-- #9804
                            CLEAR(CalculateStdCost);
                            CalculateStdCost.CalcAssemblyItemPrice(Rec."Item No.")//++ #9804
                        end;
                    }
                }
            }
        }
    }
    var CalculateStdCost: Codeunit AlxiaCalculateStandardCost;
}
