page 50082 AlxiaMarcas
{
    ApplicationArea = All;
    Caption = 'Marcas';
    PageType = List;
    SourceTable = AlxiaMarcas;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Codigo; Rec.Codigo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Codigo field.';
                }
                field(Marca; Rec.Marca)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Marca field.';
                }
            }
        }
    }
/*  actions
     {
         area(Processing)
         {
             action(migrar)
             {
                 Caption = 'Migrar Item y Proveedores';
                 ApplicationArea = All;
                 Image = BOM;
                 trigger OnAction()
                 var
                     recItemVariant: Record "Item Variant";
                     recMarca: Record AlxiaMarcas;
                     recItemVariantAux: Record "Item Variant";
                     lineNo: Integer;
                 begin
                     recItemVariant.Reset();
                     recItemVariant.FindSet();

                     repeat
                         lineNo := lineNo + 1;
                         recItemVariantAux.Reset();
                         recItemVariantAux.SetRange(code, recItemVariant.Code);
                         recItemVariantAux.SetRange("Item No.", recItemVariant."Item No.");
                         if recItemVariantAux.FindFirst() then begin
                             //recItemVariantAux.Marca := recItemVariant.Code;
                             //recItemVariantAux."Vendor No." := recItemVariant.AGRALACodProveedor;
                             //recItemVariantAux."_Item No." := recItemVariant."Item No.";
                             //recItemVariantAux."Line No." := lineNo;
                             recItemVariantAux.Modify(true);
                         end;
                     until recItemVariant.Next() = 0;
                 end;
             }
         }
     } */
}
