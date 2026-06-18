pageextension 50036 AlxSalesInvoice extends "Sales Invoice"
{
    layout
    {
        modify(SellToEmail)
        {
            Visible = false;
        }
        modify(SellToPhoneNo)
        {
            Visible = false;
        }
        modify(SellToMobilePhoneNo)
        {
            Visible = false;
        }
        modify("Sell-to Contact")
        {
            Visible = false;
        }
        addafter("Sell-to Contact")
        {
            field(ContactoPedido; Rec.ContactoPedido)
            {
                ApplicationArea = All;
            }
            field("Customer E-Mail"; Rec."Customer E-Mail")
            {
                ApplicationArea = All;
            }
            field(TelefonoPedido; Rec.TelefonoPedido)
            {
                ApplicationArea = All;
            }
        }
        addafter("Responsibility Center")
        {
            field(NoEvento; Rec.NoEvento)
            {
                ApplicationArea = All;
            }
            field(Cobrado; Rec.Cobrado)
            {
                ApplicationArea = All;
            }
            field("Fecha Servicio"; Rec."Fecha Servicio")
            {
                ApplicationArea = All;
            }
        }
        addlast(General)
        {
            field("Tipo de Impresión"; Rec."Tipo de Impresión")
            {
                ApplicationArea = Basic, Suite;
            }
            field("No Impresion Comentarios"; Rec."No Impresion Comentarios")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }
}
