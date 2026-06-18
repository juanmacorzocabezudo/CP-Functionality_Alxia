pageextension 50022 AlxiaPurchaseOrderSubform extends "Purchase Order Subform"
{
    layout
    {
        modify("Variant Code")
        {
            Caption = 'Marca';
        }
        modify("IC Partner Code")
        {
            Visible = false;
        }
        modify("IC Partner Ref. Type")
        {
            Visible = false;
        }
        modify("IC Partner Reference")
        {
            Visible = false;
        }
        modify(Nonstock)
        {
            Visible = false;
        }
        modify("VAT Prod. Posting Group")
        {
            Visible = false;
        }
        modify("Drop Shipment")
        {
            Visible = false;
        }
        modify("Return Reason Code")
        {
            Visible = false;
        }
        modify("Bin Code")
        {
            Visible = false;
        }
        modify("Job Remaining Qty.")
        {
            Visible = false;
        }
        modify("Unit of Measure")
        {
            Visible = false;
        }
        modify("Indirect Cost %")
        {
            Visible = false;
        }
        modify("Unit Cost (LCY)")
        {
            Visible = true;
            Caption = 'Coste unitario con descuento';
        }
        modify("Unit Price (LCY)")
        {
            Visible = false;
        }
        modify("Line Amount")
        {
            BlankZero = true;
            Visible = true;
        }
        modify("Line Discount Amount")
        {
            Visible = false;
        }
        modify("Prepayment %")
        {
            Visible = false;
        }
        modify("Prepmt. Line Amount")
        {
            Visible = false;
        }
        modify("Prepmt. Amt. Inv.")
        {
            Visible = false;
        }
        modify("Allow Invoice Disc.")
        {
            Visible = false;
        }
        modify("Inv. Discount Amount")
        {
            Visible = false;
        }
        modify("Prepmt Amt to Deduct")
        {
            Visible = false;
        }
        modify("Prepmt Amt Deducted")
        {
            Visible = false;
        }
        modify("Allow Item Charge Assignment")
        {
            Visible = false;
        }
        modify("Job No.")
        {
            Visible = false;
        }
        modify("Job Task No.")
        {
            Visible = false;
        }
        modify("Job Planning Line No.")
        {
            Visible = false;
        }
        modify("Job Line Type")
        {
            Visible = false;
        }
        modify("Job Unit Price")
        {
            Visible = false;
        }
        modify("Job Line Amount")
        {
            Visible = false;
        }
        modify("Job Line Discount Amount")
        {
            Visible = false;
        }
        modify("Job Line Discount %")
        {
            Visible = false;
        }
        modify("Job Total Price")
        {
            Visible = false;
        }
        /*   modify("Job Unit Price (LCY)"))
          {
              Visible = false;
          } */
        modify("Job Total Price (LCY)")
        {
            Visible = false;
        }
        modify("Job Line Amount (LCY)")
        {
            Visible = false;
        }
        modify("Job Line Disc. Amount (LCY)")
        {
            Visible = false;
        }
        modify("Requested Receipt Date")
        {
            Visible = false;
        }
        modify("Promised Receipt Date")
        {
            Visible = false;
        }
        modify("Lead Time Calculation")
        {
            Visible = false;
        }
        modify("Planning Flexibility")
        {
            Visible = false;
        }
        modify("Prod. Order No.")
        {
            Visible = false;
        }
        modify("Prod. Order Line No.")
        {
            Visible = false;
        }
        modify("Operation No.")
        {
            Visible = false;
        }
        modify("Work Center No.")
        {
            Visible = false;
        }
        modify(Finished)
        {
            Visible = false;
        }
        modify("Whse. Outstanding Qty. (Base)")
        {
            Visible = false;
        }
        modify("Inbound Whse. Handling Time")
        {
            Visible = false;
        }
        modify("Blanket Order No.")
        {
            Visible = false;
        }
        modify("Blanket Order Line No.")
        {
            Visible = false;
        }
        modify("Appl.-to Item Entry")
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
        addafter("Qty. Assigned")
        {
            field(TemperaturaRecepcion; Rec.TemperaturaRecepcion)
            {
                ApplicationArea = All;
                ShowMandatory = true;
            }
            field(AspectoCorrecto; Rec.AspectoCorrecto)
            {
                ApplicationArea = All;
                ShowMandatory = true;
            }
            field(HigieneTranspCorrecta; Rec.HigieneTranspCorrecta)
            {
                ApplicationArea = All;
                ShowMandatory = true;
            }
            field(Observaciones; Rec.Observaciones)
            {
                ApplicationArea = All;
                ShowMandatory = true;
            }
            field("Último Coste Directo"; Rec."Último Coste Directo")
            {
                ApplicationArea = All;
                Caption = 'Último Coste Directo';
            }
            field(PrecioPropuesto; Rec.PrecioPropuesto)
            {
                ApplicationArea = All;
                Caption = 'Precio Propuesto';
            }
        }
    }
}
