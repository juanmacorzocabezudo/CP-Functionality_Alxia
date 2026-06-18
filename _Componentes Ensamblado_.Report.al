report 50017 "Componentes Ensamblado"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layout/ComponentesEnsamblado.rdlc';

    dataset
    {
        dataitem("Assembly Header";900)
        {
            column(PaymentTermsDescription; PaymentTerms.Description)
            {
            }
            column(PaymentMethodDescription; PaymentMethod.Description)
            {
            }
            column(PmtTermsDescCaption; PmtTermsDescCaptionLbl)
            {
            }
            column(PmtMethodDescCaption; PmtMethodDescCaptionLbl)
            {
            }
            column(HomePageCaption; HomePageCaptionCap)
            {
            }
            column(DocumentType_AssemblyHeader; "Assembly Header"."Document Type")
            {
            }
            column(No_AssemblyHeader; "Assembly Header"."No.")
            {
            }
            column(Description_AssemblyHeader; "Assembly Header".Description)
            {
            }
            column(SearchDescription_AssemblyHeader; "Assembly Header"."Search Description")
            {
            }
            column(Description2_AssemblyHeader; "Assembly Header"."Description 2")
            {
            }
            column(CreationDate_AssemblyHeader; "Assembly Header"."Creation Date")
            {
            }
            column(LastDateModified_AssemblyHeader; "Assembly Header"."Last Date Modified")
            {
            }
            column(ItemNo_AssemblyHeader; "Assembly Header"."Item No.")
            {
            }
            column(VariantCode_AssemblyHeader; "Assembly Header"."Variant Code")
            {
            }
            column(InventoryPostingGroup_AssemblyHeader; "Assembly Header"."Inventory Posting Group")
            {
            }
            column(GenProdPostingGroup_AssemblyHeader; "Assembly Header"."Gen. Prod. Posting Group")
            {
            }
            column(Comment_AssemblyHeader; "Assembly Header".Comment)
            {
            }
            column(LocationCode_AssemblyHeader; "Assembly Header"."Location Code")
            {
            }
            column(ShortcutDimension1Code_AssemblyHeader; "Assembly Header"."Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code_AssemblyHeader; "Assembly Header"."Shortcut Dimension 2 Code")
            {
            }
            column(PostingDate_AssemblyHeader; "Assembly Header"."Posting Date")
            {
            }
            column(DueDate_AssemblyHeader; "Assembly Header"."Due Date")
            {
            }
            column(StartingDate_AssemblyHeader; "Assembly Header"."Starting Date")
            {
            }
            column(EndingDate_AssemblyHeader; "Assembly Header"."Ending Date")
            {
            }
            column(BinCode_AssemblyHeader; "Assembly Header"."Bin Code")
            {
            }
            column(Quantity_AssemblyHeader; "Assembly Header".Quantity)
            {
            }
            column(QuantityBase_AssemblyHeader; "Assembly Header"."Quantity (Base)")
            {
            }
            column(RemainingQuantity_AssemblyHeader; "Assembly Header"."Remaining Quantity")
            {
            }
            column(RemainingQuantityBase_AssemblyHeader; "Assembly Header"."Remaining Quantity (Base)")
            {
            }
            column(AssembledQuantity_AssemblyHeader; "Assembly Header"."Assembled Quantity")
            {
            }
            column(AssembledQuantityBase_AssemblyHeader; "Assembly Header"."Assembled Quantity (Base)")
            {
            }
            column(QuantitytoAssemble_AssemblyHeader; "Assembly Header"."Quantity to Assemble")
            {
            }
            column(QuantitytoAssembleBase_AssemblyHeader; "Assembly Header"."Quantity to Assemble (Base)")
            {
            }
            column(ReservedQuantity_AssemblyHeader; "Assembly Header"."Reserved Quantity")
            {
            }
            column(ReservedQtyBase_AssemblyHeader; "Assembly Header"."Reserved Qty. (Base)")
            {
            }
            column(PlanningFlexibility_AssemblyHeader; "Assembly Header"."Planning Flexibility")
            {
            }
            column(MPSOrder_AssemblyHeader; "Assembly Header"."MPS Order")
            {
            }
            column(AssembletoOrder_AssemblyHeader; "Assembly Header"."Assemble to Order")
            {
            }
            column(PostingNo_AssemblyHeader; "Assembly Header"."Posting No.")
            {
            }
            column(UnitCost_AssemblyHeader; "Assembly Header"."Unit Cost")
            {
            }
            column(CostAmount_AssemblyHeader; "Assembly Header"."Cost Amount")
            {
            }
            column(RolledupAssemblyCost_AssemblyHeader; "Assembly Header"."Rolled-up Assembly Cost")
            {
            }
            column(IndirectCost_AssemblyHeader; "Assembly Header"."Indirect Cost %")
            {
            }
            column(OverheadRate_AssemblyHeader; "Assembly Header"."Overhead Rate")
            {
            }
            column(UnitofMeasureCode_AssemblyHeader; "Assembly Header"."Unit of Measure Code")
            {
            }
            column(QtyperUnitofMeasure_AssemblyHeader; "Assembly Header"."Qty. per Unit of Measure")
            {
            }
            column(NoSeries_AssemblyHeader; "Assembly Header"."No. Series")
            {
            }
            column(PostingNoSeries_AssemblyHeader; "Assembly Header"."Posting No. Series")
            {
            }
            column(Status_AssemblyHeader; "Assembly Header".Status)
            {
            }
            column(DimensionSetID_AssemblyHeader; "Assembly Header"."Dimension Set ID")
            {
            }
            column(AssignedUserID_AssemblyHeader; "Assembly Header"."Assigned User ID")
            {
            }
            column(NoEvento_AssemblyHeader; "Assembly Header".NoEvento)
            {
            }
            column(Autoconsumo_AssemblyHeader; "Assembly Header".Autoconsumo)
            {
            }
            column(Simulacion_AssemblyHeader; "Assembly Header".Simulacion)
            {
            }
            column(EmailCaption; EmailCaptionLbl)
            {
            }
            column(imagenproducto; gt_producto.Picture)
            {
            }
            column(OutputNo; OutputNo)
            {
            }
            column(CompanyInfoPicture; CompanyInfo.Picture)
            {
            }
            column(CompanyAddr1; CompanyAddr[1])
            {
            }
            column(CompanyAddr2; CompanyAddr[2])
            {
            }
            column(CompanyAddr3; CompanyAddr[3])
            {
            }
            column(CompanyAddr4; CompanyAddr[4])
            {
            }
            column(CompanyAddr5; CompanyAddr[5])
            {
            }
            column(CompanyAddr6; CompanyAddr[6])
            {
            }
            column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfoVATRegistrationNo; CompanyInfo."VAT Registration No.")
            {
            }
            #pragma warning disable AL0432
            column(CompanyInfoHomePage; CompanyInfo."Home Page")
            {
            }
            #pragma warning restore AL0432
            column(CompanyInfoEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyInfoFaxNo; CompanyInfo."Fax No.")
            {
            }
            column(PageCaption; PageCaptionCap)
            {
            }
            column(PhoneNoCaption; PhoneNoCaptionLbl)
            {
            }
            column(VATRegNoCaption; VATRegNoCaptionLbl)
            {
            }
            column(FaxNoCaption; FaxNoCaptionLbl)
            {
            }
            column(Listado_Titulo; TituloReport)
            {
            }
            dataitem("Assembly Line";901)
            {
                DataItemLink = "Document Type"=FIELD("Document Type"), "Document No."=FIELD("No.");
                DataItemLinkReference = "Assembly Header";

                column(DocumentType_AssemblyLine; "Assembly Line"."Document Type")
                {
                }
                column(DocumentNo_AssemblyLine; "Assembly Line"."Document No.")
                {
                }
                column(LineNo_AssemblyLine; "Assembly Line"."Line No.")
                {
                }
                column(Type_AssemblyLine; "Assembly Line".Type)
                {
                }
                column(No_AssemblyLine; "Assembly Line"."No.")
                {
                }
                column(VariantCode_AssemblyLine; "Assembly Line"."Variant Code")
                {
                }
                column(Description_AssemblyLine; "Assembly Line".Description)
                {
                }
                column(Description2_AssemblyLine; "Assembly Line"."Description 2")
                {
                }
                column(LeadTimeOffset_AssemblyLine; "Assembly Line"."Lead-Time Offset")
                {
                }
                column(ResourceUsageType_AssemblyLine; "Assembly Line"."Resource Usage Type")
                {
                }
                column(LocationCode_AssemblyLine; "Assembly Line"."Location Code")
                {
                }
                column(ShortcutDimension1Code_AssemblyLine; "Assembly Line"."Shortcut Dimension 1 Code")
                {
                }
                column(ShortcutDimension2Code_AssemblyLine; "Assembly Line"."Shortcut Dimension 2 Code")
                {
                }
                column(BinCode_AssemblyLine; "Assembly Line"."Bin Code")
                {
                }
                column(Position_AssemblyLine; "Assembly Line".Position)
                {
                }
                column(Position2_AssemblyLine; "Assembly Line"."Position 2")
                {
                }
                column(Position3_AssemblyLine; "Assembly Line"."Position 3")
                {
                }
                column(AppltoItemEntry_AssemblyLine; "Assembly Line"."Appl.-to Item Entry")
                {
                }
                column(ApplfromItemEntry_AssemblyLine; "Assembly Line"."Appl.-from Item Entry")
                {
                }
                column(Quantity_AssemblyLine; "Assembly Line".Quantity)
                {
                }
                column(QuantityBase_AssemblyLine; "Assembly Line"."Quantity (Base)")
                {
                }
                column(RemainingQuantity_AssemblyLine; "Assembly Line"."Remaining Quantity")
                {
                }
                column(RemainingQuantityBase_AssemblyLine; "Assembly Line"."Remaining Quantity (Base)")
                {
                }
                column(ConsumedQuantity_AssemblyLine; "Assembly Line"."Consumed Quantity")
                {
                }
                column(ConsumedQuantityBase_AssemblyLine; "Assembly Line"."Consumed Quantity (Base)")
                {
                }
                column(QuantitytoConsume_AssemblyLine; "Assembly Line"."Quantity to Consume")
                {
                }
                column(QuantitytoConsumeBase_AssemblyLine; "Assembly Line"."Quantity to Consume (Base)")
                {
                }
                column(ReservedQuantity_AssemblyLine; "Assembly Line"."Reserved Quantity")
                {
                }
                column(ReservedQtyBase_AssemblyLine; "Assembly Line"."Reserved Qty. (Base)")
                {
                }
                column(AvailWarning_AssemblyLine; "Assembly Line"."Avail. Warning")
                {
                }
                column(SubstitutionAvailable_AssemblyLine; "Assembly Line"."Substitution Available")
                {
                }
                column(DueDate_AssemblyLine; "Assembly Line"."Due Date")
                {
                }
                column(Reserve_AssemblyLine; "Assembly Line".Reserve)
                {
                }
                column(Quantityper_AssemblyLine; "Assembly Line"."Quantity per")
                {
                }
                column(QtyperUnitofMeasure_AssemblyLine; "Assembly Line"."Qty. per Unit of Measure")
                {
                }
                column(InventoryPostingGroup_AssemblyLine; "Assembly Line"."Inventory Posting Group")
                {
                }
                column(GenProdPostingGroup_AssemblyLine; "Assembly Line"."Gen. Prod. Posting Group")
                {
                }
                column(UnitCost_AssemblyLine; "Assembly Line"."Unit Cost")
                {
                }
                column(CostAmount_AssemblyLine; "Assembly Line"."Cost Amount")
                {
                }
                column(DateFilter_AssemblyLine; "Assembly Line"."Date Filter")
                {
                }
                column(UnitofMeasureCode_AssemblyLine; "Assembly Line"."Unit of Measure Code")
                {
                }
                column(DimensionSetID_AssemblyLine; "Assembly Line"."Dimension Set ID")
                {
                }
                column(PickQty_AssemblyLine; "Assembly Line"."Pick Qty.")
                {
                }
                column(PickQtyBase_AssemblyLine; "Assembly Line"."Pick Qty. (Base)")
                {
                }
                column(QtyPicked_AssemblyLine; "Assembly Line"."Qty. Picked")
                {
                }
                column(QtyPickedBase_AssemblyLine; "Assembly Line"."Qty. Picked (Base)")
                {
                }
                column(Sombrear; gb_Sombrear)
                {
                }
                column(comentario; "Assembly Line".Comentario)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    gb_Sombrear:=TRUE;
                    gr_Item.RESET;
                    gr_Item.SETRANGE("No.", "Assembly Line"."No.");
                    IF gr_Item.FINDFIRST THEN gb_Sombrear:=gr_Item."Item Tracking Code" = '';
                end;
                trigger OnPreDataItem()
                var
                    lt_VATPostingSetup: Record 325;
                    GLAccount: Record 15;
                    GrupoRegIVANeg: Code[20];
                    lt_Customer: Record 18;
                    lt_CustTemplate: Record "Customer Templ.";
                begin
                /*  IF gt_producto.GET("Assembly Header"."Item No.") THEN
                         if gt_producto.Picture.Count <> 0 then
                             gt_producto.CALCFIELDS(Picture); */
                end;
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field(NoOfCopies; NoOfCopies)
                    {
                        ApplicationArea = All;
                        Caption = 'No. of Copies';
                        Visible = false;
                    }
                    field(gb_MostrarComentarios; gb_MostrarComentarios)
                    {
                        ApplicationArea = All;
                        Caption = 'Mostrar comentarios';
                        Visible = false;
                    }
                }
            }
        }
        actions
        {
        }
        trigger OnOpenPage()
        begin
            gb_MostrarComentarios:=TRUE;
        end;
    }
    labels
    {
    LblReferencia='Marca / Referencia';
    LblDescripcion='Descripción';
    LblCantidad='<Cantidad a Consumir>';
    LblUdm='Ud.';
    LblCantConsumida='Cant. Consumida';
    LblLote='Lote';
    lblBase='Base Imponible';
    lblIVA='% IVA';
    lblImporteIVA='Importe IVA';
    lblTotalParcial='Total Parcial';
    lblSenalizado='SEÑALIZADO';
    lblImpSenal='Importe Señal';
    lblImpPendiente='Importe Pendiente';
    lblHoraEvento='Hora Evento';
    lblEMail='E-Mail';
    lblContacto='Contacto';
    lblDireccionEvento='Dirección evento';
    lblCPLocalidad='C.P. Localidad';
    lblProvincia='Provincia';
    }
    trigger OnInitReport()
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);
    end;
    var NoOfCopies: Integer;
    NoOfLoops: Integer;
    CopyText: Text[30];
    OutputNo: Integer;
    Text003: Label 'COPY';
    PageCaptionCap: Label 'Page %1 of %2';
    PhoneNoCaptionLbl: Label 'Phone No.';
    VATRegNoCaptionLbl: Label 'VAT Registration No.';
    HomePageCaptionCap: Label 'Home Page';
    EmailCaptionLbl: Label 'E-Mail';
    PaymentMethod: Record 289;
    PaymentTerms: Record 3;
    CompanyInfo: Record 79;
    FormatAddr: Codeunit 365;
    CompanyAddr: array[8]of Text[50];
    PmtTermsDescCaptionLbl: Label 'Payment Terms';
    PmtMethodDescCaptionLbl: Label 'Payment Method';
    LineasEventoTMP: Record 50002 temporary;
    LineEventoNo: Integer;
    FaxNoCaptionLbl: Label 'Phone No.';
    TituloReport: Text[100];
    PresupuestoCaptionLbl: Label 'Presupuesto';
    PedidoCaptionLbl: Label 'Pedido';
    NoClienteCaptionLbl: Label 'Nº cliente';
    NoContactoCaptionLbl: Label 'Nº contacto';
    FechaEventoCaptionLbl: Label 'Fecha evento';
    NoEventoCaptionLbl: Label 'Nº evento';
    FechaAltaCaptionLbl: Label 'Fecha alta';
    #pragma warning disable AL0432
    VATAmountLineTMP: Record 290 temporary;
    #pragma warning restore AL0432
    TxtTotal: Text[200];
    TotalCaptionlbl: Label 'Total';
    SalesReceivablesSetup: Record 311;
    GLSetup: Record 98;
    gb_Pedido: Boolean;
    gb_MostrarComentarios: Boolean;
    txtComentarioEvento: Text[550];
    gr_Item: Record 27;
    gb_Sombrear: Boolean;
    gt_producto: Record 27;
}
