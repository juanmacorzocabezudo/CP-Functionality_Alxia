pageextension 50014 AlxiaSalesOrder extends "Sales Order"
{
    layout
    {
        addbefore("Requested Delivery Date")
        {
            field("Shipment Date2"; Rec."Shipment Date")
            {
                ApplicationArea = All;
            }
        }
        addafter("Posting Date")
        {
            field("Waranty Lot Date"; Rec."Waranty Lot Date")
            {
                ApplicationArea = All;
            }
        }
        addafter("Payment Terms Code")
        {
            field(CodBancoEmpresa; Rec.CodBancoEmpresaMigr)
            {
                ApplicationArea = All;
            }
        }
        modify("Shipment Date")
        {
            trigger OnAfterValidate()
            begin
                Rec."Fecha Servicio":=Rec."Shipment Date";
            end;
        }
        addafter("Promised Delivery Date")
        {
            field("Fecha Servicio"; Rec."Fecha Servicio")
            {
                ApplicationArea = All;
            }
        }
        addafter(General)
        {
            group(Eventos)
            {
                field(NoEvento; Rec.NoEvento)
                {
                    ApplicationArea = All;
                    Caption = 'Nº Evento';
                    TableRelation = Evento."Codigo Evento";
                //Editable = false;
                }
                field("Importe total evento"; Rec."Importe total evento")
                {
                    ApplicationArea = All;
                    Caption = 'Importe total evento';
                    Editable = false;
                }
                field("Importe Rechazado"; Rec."Importe Rechazado")
                {
                    ApplicationArea = All;
                    Caption = 'Importe rechazado';
                    ToolTip = 'Servicio desestimado por el cliente';
                //Editable = false;
                }
                field("Importe Contratado"; Rec."Importe Contratado")
                {
                    ApplicationArea = All;
                    Caption = 'Importe contratado';
                    ToolTip = 'Servicio Contratado';
                    Editable = false;
                }
            }
        }
    }
}
