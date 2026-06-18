pageextension 50005 AlxiaCustomerList extends "Customer List"
{
    layout
    {
        addafter("Shipping Agent Code")
        {
            field("VAT Registration No."; Rec."VAT Registration No.")
            {
                ApplicationArea = All;
                Visible = true;
            }
            field("E-Mail"; Rec."E-Mail")
            {
                ApplicationArea = All;
                Visible = true;
            }
            field(Contrato; Rec.Contrato)
            {
                ApplicationArea = All;
                Visible = false;
            }
            field(Plantilla; Rec.Plantilla)
            {
                ApplicationArea = All;
                Visible = false;
            }
            /*      field("Líneas de Negocio"; Rec."Líneas de Negocio")
                 {
                     ApplicationArea = All;
                     Visible = false;
                 } */
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;
                Caption = 'Líneas de Negocio';
            }
            field(AGRALAOrderPerson; Rec.AGRALAOrderPerson)
            {
                ApplicationArea = All;
                Visible = false;
            }
            field(AGRALAContabilityPerson; Rec.AGRALAContabilityPerson)
            {
                ApplicationArea = All;
                Visible = false;
            }
            field(AGRALAContabilityPhone; Rec.AGRALAContabilityPhone)
            {
                ApplicationArea = All;
                Visible = false;
            }
            field(AGRALAContabilityEmail; Rec.AGRALAContabilityEmail)
            {
                ApplicationArea = All;
                Visible = false;
            }
            field(AGRALAQualityPerson; Rec.AGRALAQualityPerson)
            {
                ApplicationArea = All;
                Visible = false;
            }
            field(AGRALAQualityPhone; Rec.AGRALAQualityPhone)
            {
                ApplicationArea = All;
                Visible = false;
            }
            field(AGRALAQualityEmail; Rec.AGRALAQualityEmail)
            {
                ApplicationArea = All;
                Visible = false;
            }
            field(AGRALACrisis24hPerson; Rec.AGRALACrisis24hPerson)
            {
                ApplicationArea = All;
                Visible = false;
            }
            field(AGRALACrisis24hEmail; Rec.AGRALACrisis24hEmail)
            {
                ApplicationArea = All;
                Visible = false;
            }
        }
    }
/* actions
    {
        addlast(Processing)
        {
            action(AlxiaEventos)
            {
                ApplicationArea = All;
                Caption = 'Test Distance';
                Image = Event;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    CDU: Codeunit AlxGoogleMaps;
                    dist: Decimal;
                begin
                    dist := CDU.GetDistanceValueFromGoogleMaps('', '');
                    Message(Format(dist));
                end;
            }
        }
    } */
}
