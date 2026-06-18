pageextension 50006 AlxiaCustomerCard extends "Customer Card"
{
    layout
    {
        addafter("Last Date Modified")
        {
            field(Contrato; Rec.Contrato)
            {
                ApplicationArea = All;
            }
            field(Plantilla; Rec.Plantilla)
            {
                ApplicationArea = All;
            }
            /*   field("Líneas de Negocio"; Rec."Líneas de Negocio")
              {
                  ApplicationArea = All;
              } */
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;
                Caption = 'Líneas de Negocio';
            }
        }
        modify("E-Mail")
        {
            Visible = false;
        }
        addafter("Preferred Bank Account Code")
        {
            field(CodBancoEmpresa; Rec.CodBancoEmpresa)
            {
                ApplicationArea = All;
            }
        }
        addafter("Prepayment %")
        {
            field("Facturacion Mensual"; Rec."Facturacion Mensual")
            {
                ApplicationArea = All;
            }
        }
        addafter(General)
        {
            group(Communication)
            {
                Caption = 'Comunicación';

                field(AGRALAOrderPerson; Rec.AGRALAOrderPerson)
                {
                    ApplicationArea = All;
                }
                field("Phone No.2"; rec."Phone No.")
                {
                    Caption = 'Nº teléfono Pedidos';
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("E-Mail2"; Rec."E-Mail")
                {
                    Caption = 'Correo electrónico Pedidos';
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field(AGRALAContabilityPerson; Rec.AGRALAContabilityPerson)
                {
                    ApplicationArea = All;
                }
                field(AGRALAContabilityPhone; Rec.AGRALAContabilityPhone)
                {
                    ApplicationArea = All;
                    ExtendedDatatype = PhoneNo;
                }
                field(AGRALAContabilityEmail; Rec.AGRALAContabilityEmail)
                {
                    ApplicationArea = All;
                    ExtendedDatatype = EMail;
                }
                field(AGRALAQualityPerson; Rec.AGRALAQualityPerson)
                {
                    ApplicationArea = All;
                }
                field(AGRALAQualityPhone; Rec.AGRALAQualityPhone)
                {
                    ApplicationArea = All;
                    ExtendedDatatype = PhoneNo;
                }
                field(AGRALAQualityEmail; Rec.AGRALAQualityEmail)
                {
                    ApplicationArea = All;
                    ExtendedDatatype = EMail;
                }
                field(AGRALACrisis24hPerson; Rec.AGRALACrisis24hPerson)
                {
                    ApplicationArea = All;
                }
                field("Fax No.2"; Rec."Fax No.")
                {
                    ApplicationArea = All;
                }
                field(AGRALACrisis24hEmail; Rec.AGRALACrisis24hEmail)
                {
                    ApplicationArea = All;
                    ExtendedDatatype = EMail;
                }
                field("Home Page2"; Rec."Home Page")
                {
                    ApplicationArea = All;
                }
                field("IC Partner Code2"; Rec."IC Partner Code")
                {
                    ApplicationArea = All;
                }
                field("Document Sending Profile2"; Rec."Document Sending Profile")
                {
                    ApplicationArea = All;
                }
            }
        }
        addafter("Shipping Time")
        {
            field(HorarioAperturaRecepcion; Rec.HorarioAperturaRecepcion)
            {
                ApplicationArea = All;
            }
        }
    }
}
