page 50083 AGRALACambioCantidadEnsamblado
{
    Caption = 'Cambio Cantidad Lineas Ensamblado';
    PageType = List;
    Permissions = TableData 911=rimd;
    SourceTable = 911;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(AGRALADescripcionMotivo; AGRALADescripcionMotivo)
                {
                    ApplicationArea = All;
                    Caption = 'Motivo';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        rlreservatioEntry: Record "Reservation Entry";
                        rlItemJournalLine: Record 83;
                        rlItemJournalTemplate: Record 82;
                        rlItemJournalBatch: Record 233;
                        rlTrackingSpecification: Record 336;
                        rlItemEntryRelation: Record 6507;
                        rlItemLedgerEntry: Record 32;
                        vlNumLine: Integer;
                        vlNumLine2: Integer;
                        ReserveItemJnlLine: Codeunit 99000835;
                        CreateReservEntry: Codeunit 99000830;
                        //CurrentEntryStatus: Option Reservation,Tracking,Surplus,Prospect;
                        Status: Enum "Reservation Status";
                        ItemTrackingMgt: Codeunit 6500;
                    begin
                        IF AGRALADescripcionMotivo = '' THEN ERROR('Obligatorio motivo');
                        IF rlItemJournalTemplate.GET('PRODUCTO')THEN BEGIN
                            IF rlItemJournalBatch.GET(rlItemJournalTemplate.Name, 'GENERICO')THEN BEGIN
                                rlItemJournalLine.SETRANGE("Journal Template Name", rlItemJournalTemplate.Name);
                                rlItemJournalLine.SETRANGE("Journal Batch Name", rlItemJournalBatch.Name);
                                IF rlItemJournalLine.FINDFIRST()THEN rlItemJournalLine.DELETEALL();
                                IF rlItemJournalLine.FINDLAST()THEN vlNumLine:=rlItemJournalLine."Line No." + 10000
                                ELSE
                                    vlNumLine:=10000;
                                rlItemJournalLine.INIT();
                                rlItemJournalLine.VALIDATE("Journal Template Name", rlItemJournalTemplate.Name);
                                rlItemJournalLine.VALIDATE("Journal Batch Name", rlItemJournalBatch.Name);
                                rlItemJournalLine.VALIDATE("Line No.", vlNumLine);
                                rlItemJournalLine.INSERT(TRUE);
                                rlItemJournalLine.VALIDATE("Item No.", Rec."No.");
                                IF Rec.Quantity < xRec.Quantity THEN BEGIN
                                    rlItemJournalLine.VALIDATE("Entry Type", rlItemJournalLine."Entry Type"::"Positive Adjmt.");
                                    rlItemJournalLine.VALIDATE(Quantity, xRec.Quantity - Rec.Quantity);
                                END
                                ELSE
                                BEGIN
                                    rlItemJournalLine.VALIDATE("Entry Type", rlItemJournalLine."Entry Type"::"Negative Adjmt.");
                                    rlItemJournalLine.VALIDATE(Quantity, Rec.Quantity - xRec.Quantity);
                                END;
                                rlItemJournalLine.VALIDATE("Posting Date", TODAY);
                                rlItemJournalLine.VALIDATE("Location Code", Rec."Location Code");
                                rlItemJournalLine.VALIDATE("Document No.", Rec."Document No.");
                                rlItemJournalLine.VALIDATE("Variant Code", Rec."Variant Code");
                                rlItemJournalLine.VALIDATE(Description, AGRALADescripcionMotivo);
                                rlItemJournalLine.VALIDATE("Source Code", 'DIAPRODS');
                                rlItemJournalLine.Type:=rlItemJournalLine.Type::"Work Center";
                                rlItemJournalLine.TrackingExists();
                                rlItemJournalLine.MODIFY(TRUE);
                                rlItemEntryRelation.SETCURRENTKEY("Source ID", "Source Type");
                                rlItemEntryRelation.SETRANGE("Source Type", DATABASE::"Posted Assembly Line");
                                rlItemEntryRelation.SETRANGE("Source Subtype", 0);
                                rlItemEntryRelation.SETRANGE("Source ID", Rec."Document No.");
                                rlItemEntryRelation.SETRANGE("Source Batch Name", '');
                                rlItemEntryRelation.SETRANGE("Source Prod. Order Line", 0);
                                rlItemEntryRelation.SETRANGE("Source Ref. No.", Rec."Line No.");
                                IF rlItemEntryRelation.FINDFIRST()THEN BEGIN
                                    rlItemLedgerEntry.GET(rlItemEntryRelation."Item Entry No.");
                                END;
                                IF rlTrackingSpecification.FINDLAST THEN vlNumLine2:=rlTrackingSpecification."Entry No." + 1
                                ELSE
                                    vlNumLine2:=0;
                                rlTrackingSpecification.INIT();
                                rlTrackingSpecification.VALIDATE("Entry No.", vlNumLine2);
                                rlTrackingSpecification.INSERT(TRUE);
                                rlTrackingSpecification.VALIDATE("Source ID", rlItemJournalTemplate.Name);
                                rlTrackingSpecification.VALIDATE("Source Type", DATABASE::"Item Journal Line");
                                rlTrackingSpecification.VALIDATE("Source Subtype", rlItemJournalLine."Entry Type");
                                rlTrackingSpecification.VALIDATE("Source Prod. Order Line", 0);
                                rlTrackingSpecification.VALIDATE("Source Batch Name", rlItemJournalBatch.Name);
                                rlTrackingSpecification.VALIDATE("Source Ref. No.", rlItemJournalLine."Line No.");
                                rlTrackingSpecification.VALIDATE("Item No.", rlItemJournalLine."Item No.");
                                rlTrackingSpecification.VALIDATE("Location Code", rlItemJournalLine."Location Code");
                                rlTrackingSpecification.VALIDATE(Description, rlItemJournalLine.Description);
                                rlTrackingSpecification.VALIDATE("Variant Code", rlItemJournalLine."Variant Code");
                                rlTrackingSpecification.VALIDATE("Lot No.", rlItemLedgerEntry."Lot No.");
                                rlTrackingSpecification.VALIDATE("Quantity (Base)", rlItemJournalLine.Quantity);
                                rlTrackingSpecification.VALIDATE("Bin Code", rlItemJournalLine."Bin Code");
                                rlTrackingSpecification.MODIFY(TRUE);
                                IF ItemTrackingMgt.IsOrderNetworkEntity(rlTrackingSpecification."Source Type", rlTrackingSpecification."Source Subtype")THEN Status:=Status::Surplus
                                ELSE
                                    Status:=Status::Prospect;
                                //SL 242215 Begin
                                rlreservatioEntry.Reset();
                                //rlreservatioEntry.SetRange("Entry No.", rlTrackingSpecification."Entry No.");
                                rlreservatioEntry.SetRange("Item No.", rlItemJournalLine."Item No.");
                                rlreservatioEntry.SetRange("Lot No.", rlItemLedgerEntry."Lot No.");
                                rlreservatioEntry.SetRange("Variant Code", rlItemJournalLine."Variant Code");
                                rlreservatioEntry.SetRange("Location Code", rlItemJournalLine."Location Code");
                                if rlreservatioEntry.FindFirst()then;
                                //SL 242215 End
                                CreateReservEntry.SetDates(rlTrackingSpecification."Warranty Date", rlTrackingSpecification."Expiration Date");
                                CreateReservEntry.SetApplyFromEntryNo(rlTrackingSpecification."Appl.-from Item Entry");
                                CreateReservEntry.SetApplyToEntryNo(rlTrackingSpecification."Appl.-to Item Entry");
                                CreateReservEntry.CreateReservEntryFor(rlTrackingSpecification."Source Type", rlTrackingSpecification."Source Subtype", rlTrackingSpecification."Source ID", rlTrackingSpecification."Source Batch Name", rlTrackingSpecification."Source Prod. Order Line", rlTrackingSpecification."Source Ref. No.", rlTrackingSpecification."Qty. per Unit of Measure", 0, rlTrackingSpecification."Quantity (Base)", rlreservatioEntry);
                                CreateReservEntry.CreateEntry(rlTrackingSpecification."Item No.", rlTrackingSpecification."Variant Code", rlTrackingSpecification."Location Code", rlTrackingSpecification.Description, rlItemJournalLine."Posting Date", rlItemJournalLine."Posting Date", 0, Status);
                                CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post", rlItemJournalLine);
                            END;
                        END;
                    end;
                }
            }
        }
    }
    actions
    {
    }
    var AGRALADescripcionMotivo: Text;
}
