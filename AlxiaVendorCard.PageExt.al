pageextension 50007 AlxiaVendorCard extends "Vendor Card"
{
    layout
    {
        addafter(General)
        {
            group(Communication)
            {
                Caption = 'Comunicación';

                field(AGRALAPersonaContactoPedidos; Rec.AGRALAPersonaContactoPedidos)
                {
                    Caption = 'Persona contacto pedidos ';
                    ApplicationArea = All;
                }
                field("Phone No.2"; Rec."Phone No.")
                {
                    Caption = 'Nº Teléfono';
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("E-Mail2"; Rec."E-Mail")
                {
                    Caption = 'Correo Electrónico';
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field(AGRALAContabilityPerson; Rec.AGRALAContabilityPerson)
                {
                    ApplicationArea = All;
                }
                field(AGRALAContabilityPhone; Rec.AGRALAContabilityPhone)
                {
                    ExtendedDatatype = PhoneNo;
                    ApplicationArea = All;
                }
                field(AGRALAContabilityEmail; Rec.AGRALAContabilityEmail)
                {
                    ExtendedDatatype = EMail;
                    ApplicationArea = All;
                }
                field(AGRALAPersonaCalidad; Rec.AGRALAPersonaCalidad)
                {
                    Caption = 'Persona Contacto Calidad';
                    ApplicationArea = All;
                }
                field(AGRALATelefonoCalidad; Rec.AGRALATelefonoCalidad)
                {
                    Caption = 'Nº Teléfono Calidad';
                    ExtendedDatatype = PhoneNo;
                    ApplicationArea = All;
                }
                field(AGRALACorreoCalidad; Rec.AGRALACorreoCalidad)
                {
                    Caption = 'Correo Electrónico Calidad';
                    ExtendedDatatype = EMail;
                    ApplicationArea = All;
                }
                field(AGRALAContactoCrisis; Rec.AGRALAContactoCrisis)
                {
                    Caption = 'Persona Contacto 24h Crisis';
                    ApplicationArea = All;
                }
                field("Fax No.2"; Rec."Fax No.")
                {
                    Caption = 'Fax No.';
                    ApplicationArea = All;
                }
                field(AGRALACorreoCrisis; Rec.AGRALACorreoCrisis)
                {
                    Caption = 'Correo Electrónico 24h Crisis';
                    ExtendedDatatype = EMail;
                    ApplicationArea = All;
                }
                field("Home Page2"; Rec."Home Page")
                {
                    ApplicationArea = All;
                }
                field("IC Partner Code2"; Rec."IC Partner Code")
                {
                    ApplicationArea = All;
                }
            }
        }
        addafter("Creditor No.")
        {
            field("Preferred Bank Account"; Rec."Preferred Bank Account Code")
            {
                ApplicationArea = All;
            }
            field("IBAN cta preferida"; Rec."IBAN cta preferida")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        addafter(Receiving)
        {
            group("Datos de calidad")
            {
                Caption = 'Datos de calidad';

                field(AGRALAInfoCalidad; Rec.AGRALAInfoCalidad)
                {
                    ApplicationArea = All;
                }
                field("Fecha Cuestionario Calidad"; Rec."Fecha Cuestionario Calidad")
                {
                    ApplicationArea = All;
                }
                field(AGRALACopiaRGSEAA; Rec.AGRALACopiaRGSEAA)
                {
                    ApplicationArea = All;
                    Enabled = not Rec.AGRALAInfoCalidad;
                }
                field(AGRALANRGSAA; Rec.AGRALANRGSAA)
                {
                    ApplicationArea = All;
                    Enabled = not Rec.AGRALAInfoCalidad;
                }
                field(AGRALACertificados; Rec.AGRALACertificados)
                {
                    ApplicationArea = All;
                    Enabled = not Rec.AGRALAInfoCalidad;
                }
                field(AGRALAFirmaCuestionario; Rec.AGRALAFirmaCuestionario)
                {
                    ApplicationArea = All;
                    Enabled = not Rec.AGRALAInfoCalidad;
                }
                field("Telefono contacto 24H"; Rec."Telefono contacto 24H")
                {
                    ApplicationArea = All;
                }
                group("Tipo proveedor")
                {
                    Caption = 'Tipo proveedor';

                    field(AGRALAFabricante; Rec.AGRALAFabricante)
                    {
                        ApplicationArea = All;
                    }
                    field(AGRALADistribuidor; Rec.AGRALADistribuidor)
                    {
                        ApplicationArea = All;
                    }
                    field(AGRALABroker; Rec.AGRALABroker)
                    {
                        ApplicationArea = All;
                    }
                    field(AGRALAServicios; Rec.AGRALAServicios)
                    {
                        ApplicationArea = All;
                    }
                    field(LastPaymentDate; LastPaymentDate)
                    {
                        AccessByPermission = TableData "Vendor Ledger Entry"=R;
                        ApplicationArea = All;
                        Caption = 'Fecha última compra';
                        Editable = false;
                    }
                }
                group("Tipo producto Servicio")
                {
                    Caption = 'Tipo producto Servicio';

                    field(AlxTipoServicio; Rec.AlxTipoServicio)
                    {
                        ApplicationArea = All;
                    //Enabled = Rec.AGRALAInfoCalidad;
                    }
                    field(AGRALAIngredienteMP; Rec.AGRALAIngredienteMP)
                    {
                        ApplicationArea = All;
                    //Enabled = Rec.AGRALAInfoCalidad;
                    }
                    field(AGRALAMaterialenvasado; Rec.AGRALAMaterialenvasado)
                    {
                        ApplicationArea = All;
                    //Enabled = Rec.AGRALAInfoCalidad;
                    }
                    field(AGRALAEmblajesetiquetas; Rec.AGRALAEmblajesetiquetas)
                    {
                        ApplicationArea = All;
                    //Enabled = Rec.AGRALAInfoCalidad;
                    }
                    field(AGRALAProductosquimicos; Rec.AGRALAProductosquimicos)
                    {
                        ApplicationArea = All;
                    //Enabled = Rec.AGRALAInfoCalidad;
                    }
                    field(AGRALAControldeplagas; Rec.AGRALAControldeplagas)
                    {
                        ApplicationArea = All;
                    //Enabled = Rec.AGRALAInfoCalidad;
                    }
                    field(AGRALAGestionresiduos; Rec.AGRALAGestionresiduos)
                    {
                        ApplicationArea = All;
                    //Enabled = Rec.AGRALAInfoCalidad;
                    }
                    field(AGRALALaboratorio; Rec.AGRALALaboratorio)
                    {
                        ApplicationArea = All;
                    //Enabled = Rec.AGRALAInfoCalidad;
                    }
                    field(AGRALACalibracion; Rec.AGRALACalibracion)
                    {
                        ApplicationArea = All;
                    //Enabled = Rec.AGRALAInfoCalidad;
                    }
                    field(AGRALATransporte; Rec.AGRALATransporte)
                    {
                        ApplicationArea = All;
                    //Enabled = Rec.AGRALAInfoCalidad;
                    }
                    field(AGRALAMenaje; Rec.AGRALAMenaje)
                    {
                        ApplicationArea = All;
                    //Enabled = Rec.AGRALAInfoCalidad;
                    }
                    field(AGRALAMaquinaria; Rec.AGRALAMaquinaria)
                    {
                        ApplicationArea = All;
                    //Enabled = Rec.AGRALAInfoCalidad;
                    }
                    field(AGRALAMantenimientoConstruccio; Rec.AGRALAMantenimientoConstruccio)
                    {
                        ApplicationArea = All;
                    //Enabled = Rec.AGRALAInfoCalidad;
                    }
                    field(AGRALACodificacion; Rec.AGRALACodificacion)
                    {
                        ApplicationArea = All;
                    //Enabled = Rec.AGRALAInfoCalidad;
                    }
                    field(AGRALAImpresoras; Rec.AGRALAImpresoras)
                    {
                        ApplicationArea = All;
                    //Enabled = Rec.AGRALAInfoCalidad;
                    }
                    field(AGRALAConsultoria; Rec.AGRALAConsultoria)
                    {
                        ApplicationArea = All;
                    //Enabled = Rec.AGRALAInfoCalidad;
                    }
                    field(AGRALATelecomunicaciones; Rec.AGRALATelecomunicaciones)
                    {
                        ApplicationArea = All;
                    //Enabled = Rec.AGRALAInfoCalidad;
                    }
                    field(AGRALAEnergia; Rec.AGRALAEnergia)
                    {
                        ApplicationArea = All;
                    //Enabled = Rec.AGRALAInfoCalidad;
                    }
                }
            }
        }
    }
    actions
    {
        addafter(Items)
        {
            action("AGRALAProductos/Servicio")
            {
                ApplicationArea = All;
                Caption = 'Productos/Servicios';
                Image = ICPartner;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 50076;
                RunPageLink = AGRALACodProveedor=FIELD("No.");
            }
            action(Orders2)
            {
                ApplicationArea = All;
                Caption = 'Pedidos';
                Image = Document;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 9307;
                RunPageLink = "Buy-from Vendor No."=FIELD("No.");
                RunPageView = SORTING("Document Type", "Buy-from Vendor No.");
            }
            action(Cert)
            {
                ApplicationArea = All;
                Caption = 'Certificados';
                Image = ContactReference;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Comment Sheet";
                RunPageLink = "Table Name"=const(Vendor), "No."=field("No.");
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        SetLastInvoice();
    end;
    local procedure SetLastInvoice()
    var
        VendorLedgerEntry: Record "Vendor Ledger Entry";
    begin
        VendorLedgerEntry.SetCurrentKey("Document Type", "Vendor No.", "Posting Date", "Currency Code");
        VendorLedgerEntry.SetRange("Vendor No.", Rec."No.");
        VendorLedgerEntry.SetRange("Document Type", VendorLedgerEntry."Document Type"::Invoice);
        VendorLedgerEntry.SetRange(Reversed, false);
        if VendorLedgerEntry.FindLast()then LastPaymentDate:=VendorLedgerEntry."Posting Date";
    end;
    var LastPaymentDate: Date;
}
