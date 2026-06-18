pageextension 50011 AlxiaAssemblyOrderSubform extends "Assembly Order Subform"
{
    layout
    {
        modify(Quantity)
        {
            Editable = true;
        }
        modify("Variant Code")
        {
            Caption = 'Marca';
        }
        addbefore("Avail. Warning")
        {
            /*    field(_nLote; _nLote)
               {
                   ApplicationArea = All;
                   Caption = 'N Lote';
               } */
            field(ShowHasTracking; Rec.ShowHasTracking)
            {
                Caption = 'Lote Relleno';
                ApplicationArea = All;
            }
        }
        addafter("Avail. Warning")
        {
            field(Position; Rec.Position)
            {
                ApplicationArea = All;
            }
        }
        addafter("Variant Code")
        {
            field(AGRALACentroCoste; Rec.AGRALACentroCoste)
            {
                ApplicationArea = All;
            }
        }
        modify(Description)
        {
            StyleExpr = StyleTextLine;
        }
        modify("Description 2")
        {
            Visible = false;
        }
        modify("Qty. Picked")
        {
            Visible = false;
        }
        modify("Pick Qty.")
        {
            Visible = false;
        }
        modify("Lead-Time Offset")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }
        modify("Bin Code")
        {
            Visible = false;
        }
        modify("Inventory Posting Group")
        {
            Visible = false;
        }
        modify(Reserve)
        {
            Visible = false;
        }
        addafter(Quantity)
        {
            field("Perc. Loss"; Rec."Perc. Loss")
            {
                ApplicationArea = All;
                BlankZero = true;
            }
            field(numeroRelacionado; numeroRelacionado)
            {
                ApplicationArea = All;
                Caption = 'Pedido relacionado';
            }
            field("Net Amount"; Rec."Net Amount")
            {
                ApplicationArea = All;
                BlankZero = true;
            }
        }
        addafter("Appl.-from Item Entry")
        {
            field(Comentario; Rec.Comentario)
            {
                ApplicationArea = All;
            }
            field("Position 2"; Rec."Position 2")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Position 3"; Rec."Position 3")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field(CantidadEscalado; Rec.CantidadEscalado)
            {
                ApplicationArea = All;
                BlankZero = true;
                StyleExpr = StyleTextEscalado;
            }
            field("Cod Proveedor"; Rec."Cod Proveedor")
            {
                ApplicationArea = All;
            }
            field("Nombre Proveedor"; Rec."Nombre Proveedor")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = All;
            }
            field("Cantidad Original"; Rec."Cantidad Original")
            {
                ApplicationArea = All;
            }
            field("Cantidad Por Original"; Rec."Cantidad Por Original")
            {
                ApplicationArea = All;
            }
            field(Diferencia; Rec.Diferencia)
            {
                ApplicationArea = All;
                BlankZero = true;
                StyleExpr = StyleTextDiferencia;
            }
            field("Diferencia%"; Rec."Diferencia%")
            {
                ApplicationArea = All;
                BlankZero = true;
                StyleExpr = StyleTextDiferencia;
            }
            field(AGRALAResponsable; Rec.AGRALAResponsable)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        /*  modify("Item Tracking Lines")
         {
             Visible = false;
         } */
        /*  addafter("Reservation Entries")
         {
             action("ItemTrackingLines")
             {
                 ApplicationArea = ItemTracking;
                 Caption = 'Item &Tracking Lines';
                 Image = ItemTrackingLines;
                 ShortCutKey = 'Ctrl+Alt+I';
                 ToolTip = 'View or edit serial numbers and lot numbers that are assigned to the item on the document or journal line.';

                 trigger OnAction()
                 begin
                     OpenItemTrackingLines2();
                 end;
             }
         } */
        addafter("F&unctions")
        {
            action(RECETA)
            {
                ApplicationArea = All;
                Enabled = true;
                Image = BOM;
                //Promoted = true;
                //PromotedIsBig = true;
                RunObject = Page 50000;
                RunPageLink = "No."=FIELD("No.");
                RunPageView = SORTING("No.")ORDER(Ascending);
            }
            action("Associeated Order")
            {
                ApplicationArea = All;
                Caption = 'Pedido Asociado';
                Image = Navigate;

                trigger OnAction()
                begin
                    //-- #9627
                    Rec.ShowAssocietedOrder(Rec);
                    CurrPage.UPDATE;
                //++ #9627
                end;
            }
            action(WorkCenter)
            {
                Caption = 'Seleccionar Centro Trabajo';
                ApplicationArea = All;
                Image = WorkCenter;

                trigger OnAction()
                var
                    WorkcenterHeader: Record 50022;
                begin
                    WorkcenterHeader.RESET;
                    IF PAGE.RUNMODAL(50046, WorkcenterHeader) = ACTION::LookupOK THEN BEGIN
                        Rec.InsertLinesFromWorkCenter(Rec."No.", WorkcenterHeader."No.");
                    END;
                end;
            }
            action(PageCard)
            {
                Caption = 'Ficha';
                ApplicationArea = All;
                Image = Card;

                trigger OnAction()
                var
                    Item: Record Item;
                    Resource: Record Resource;
                begin
                    //-- #9804
                    CASE Rec.Type OF Rec.Type::Item: BEGIN
                        Item.RESET;
                        Item.SETRANGE("No.", Rec."No.");
                        Item.FINDSET;
                        PAGE.RUN(30, Item);
                    END;
                    Rec.Type::Resource: BEGIN
                        Resource.RESET;
                        Resource.SETRANGE("No.", Rec."No.");
                        Resource.FINDSET;
                        PAGE.RUN(76, Resource);
                    END;
                    END;
                //++ #9804
                end;
            }
            action(SupplyByResource)
            {
                ApplicationArea = All;
                Caption = 'Suministros por recursos';
                Image = ResourceCosts;

                trigger OnAction()
                var
                    SupplyByResource: Record 50021;
                begin
                    //-- #9804
                    CASE Rec.Type OF Rec.Type::Resource: BEGIN
                        SupplyByResource.RESET;
                        SupplyByResource.SETRANGE(Resource, Rec."No.");
                        SupplyByResource.FINDSET;
                        PAGE.RUN(50043, SupplyByResource);
                    END;
                    END;
                //++ #9804
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        rItem: Record Item;
    begin
        ReservationStatusField:=Rec.ReservationStatus;
        //++ KR 04/04/21
        //-- #9993
        /******************* TEXTO ORIGINAL ******************
        IF (Rec.Type IN [Rec.Type::" ", Rec.Type::Item]) AND (COPYSTR(Rec."No.", 1, 2) = 'PI') THEN
          //StyleTextLine := 'Favorable'
          StyleTextLine := 'Ambiguous'
        ELSE
          StyleTextLine := 'Standard';
        ***************** FIND TEXTO ORIGINAL *****************/
        CLEAR(StyleTextLine);
        CASE Rec.Type OF Rec.Type::Item: BEGIN
            IF Item.GET(Rec."No.")THEN BEGIN
                Item.CALCFIELDS("Assembly BOM");
                IF Item."Assembly BOM" THEN StyleTextLine:='Ambiguous';
            END;
            Clear(numeroRelacionado);
            numeroRelacionado:=Rec.ShowAssocietedOrderList(Rec);
        END;
        Rec.Type::" ": BEGIN
            IF Rec."Related Work Center" <> '' THEN StyleTextLine:='Strong';
        END;
        END;
        //++ #9993
        /*    if (Rec."No." <> '') and (Rec.Type = Rec.Type::Item) then begin
               rItem.Get(Rec."No.");
               if rItem."Item Tracking Code" <> '' then
                   _nLote := true;
           end; */
        StyleTextEscalado:='Standard';
        IF Rec.CantidadEscalado <> 0 THEN StyleTextEscalado:='Unfavorable';
        StyleTextDiferencia:='Standard';
        IF Rec.Diferencia > 0 THEN StyleTextDiferencia:='Unfavorable'
        ELSE IF Rec.Diferencia < 0 THEN StyleTextDiferencia:='Favorable';
    end;
    /*  trigger OnDeleteRecord(): Boolean
     var
         AssemblyLineReserve: Codeunit 926;
     begin
         IF (Rec.Quantity <> 0) AND Rec.ItemExists(Rec."No.") THEN BEGIN
             COMMIT;
             IF NOT AssemblyLineReserve.DeleteLineConfirm(Rec) THEN
                 EXIT(FALSE);
             AssemblyLineReserve.DeleteLine(Rec);
         END;
     end;
  */
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //-- #9993
        StyleTextLine:='';
        StyleTextEscalado:='';
        StyleTextDiferencia:='';
    //++ #9993
    end;
    var ItemAvailFormsMgt: Codeunit 353;
    ReservationStatusField: Option " ", Partial, Full;
    "//++ KR": Integer;
    StyleTextLine: Text;
    StyleTextEscalado: Text;
    StyleTextDiferencia: Text;
    Item: Record 27;
    numeroRelacionado: Text;
    AssemblyLineReserve: Codeunit "Assembly Line-Reserve";
    //_nLote: Boolean;
    local procedure ReserveItem()
    begin
        IF Rec.Type <> Rec.Type::Item THEN EXIT;
        IF(Rec."Remaining Quantity (Base)" <> xRec."Remaining Quantity (Base)") OR (Rec."No." <> xRec."No.") OR (Rec."Location Code" <> xRec."Location Code") OR (Rec."Variant Code" <> xRec."Variant Code") OR (Rec."Due Date" <> xRec."Due Date") OR ((Rec.Reserve <> xRec.Reserve) AND (Rec."Remaining Quantity (Base)" <> 0))THEN IF Rec.Reserve = Rec.Reserve::Always THEN BEGIN
                CurrPage.SAVERECORD;
                Rec.AutoReserve;
                CurrPage.UPDATE(FALSE);
            END;
        ReservationStatusField:=Rec.ReservationStatus;
    end;
/*  procedure OpenItemTrackingLines2()
     var
         IsHandled: Boolean;
     begin
         Rec.TestField(Type, Rec.Type::Item);
         Rec.TestField("No.");
         Rec.TestField("Quantity");
         AssemblyLineReserve.CallItemTracking(Rec);
     end; */
}
