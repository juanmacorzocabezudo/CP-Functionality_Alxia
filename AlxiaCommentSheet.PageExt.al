pageextension 50015 AlxiaCommentSheet extends "Comment Sheet"
{
    Caption = 'Certificados';

    layout
    {
        modify(Comment)
        {
            Visible = false;
        }
        addafter(Comment)
        {
            field(AGRALADescripcionProveedor; Rec.AGRALADescripcionProveedor)
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(AGRALATipoCertificado; Rec.AGRALATipoCertificado)
            {
                ApplicationArea = All;
            }
            field(AGRALAFechaVencimiento; Rec.AGRALAFechaVencimiento)
            {
                ApplicationArea = All;
            }
        }
    }
    trigger OnClosePage()
    var
        rlVendor: Record 23;
    begin
        IF(Rec."Table Name" = Rec."Table Name"::Vendor)THEN BEGIN
            IF rlVendor.GET(Rec."No.")THEN IF Rec.FINDSET THEN rlVendor.AGRALACertificados:=TRUE
                ELSE
                    rlVendor.AGRALACertificados:=FALSE;
            rlVendor.MODIFY;
        END;
    end;
}
