tableextension 50034 AlxItemLedgerEntry extends "Item Ledger Entry"
{
    fields
    {
        field(50000; "Formato Producto"; Code[20])
        {
        }
        field(50001; PersonaRecibe; Text[50])
        {
            Caption = 'Persona que recibe';
            Description = 'ADV001';
        }
        field(50002; TemperaturaRecepcion; Decimal)
        {
            Caption = 'Temperatura recepción';
            Description = 'ADV001';
        }
        field(50003; AspectoCorrecto; Option)
        {
            Caption = 'Aspecto correcto';
            Description = 'ADV001';
            OptionMembers = " ", "Sí", No;
        }
        field(50004; HigieneTranspCorrecta; Option)
        {
            Caption = 'Higiene transp. correcta';
            Description = 'ADV001';
            OptionMembers = " ", "Sí", No;
        }
        field(50005; Observaciones; Text[100])
        {
            Description = 'ADV001';
        }
        field(50006; "Descripción Producto"; Text[100])
        {
            CalcFormula = Lookup(Item.Description WHERE("No."=FIELD("Item No.")));
            FieldClass = FlowField;
        }
        field(50007; Proveedor; Text[100])
        {
            Caption = 'Proveedor';
            CalcFormula = Lookup(Vendor.Name WHERE("No."=FIELD("Source No.")));
            Description = 'adv002';
            FieldClass = FlowField;
        }
        field(50008; "Ud. medida Base"; Code[10])
        {
            CalcFormula = Lookup(Item."Base Unit of Measure" WHERE("No."=FIELD("Item No.")));
            FieldClass = FlowField;
        }
        field(50009; AGRALASandach; Boolean)
        {
            CalcFormula = Lookup(Item.AGRALASandach WHERE("No."=FIELD("Item No.")));
            Caption = 'Sandach';
            Description = '292';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50010; DescProducto; Text[255])
        {
            Caption = 'Descripción Producto';
        }
    }
    var rlItem: Record 27;
    rlItemAux: Record 27;
    /*   trigger OnBeforeInsert()
      begin
          IF rlItem.GET(Rec."Item No.") THEN BEGIN
              DescProducto := rlItem.Description;
          end;
      end; */
    trigger OnAfterInsert()
    begin
        //++AGRALA 862
        IF rlItem.GET(Rec."Item No.")THEN BEGIN
            rlItem.CALCFIELDS(rlItem.Inventory, rlItem.AGRALAQtyAssemblyOrderLine, rlItem.AGRALAQtyOnSalesOrder);
            rlItem.AGRALAStockDisponible:=rlItem.Inventory - rlItem.AGRALAQtyAssemblyOrderLine - rlItem.AGRALAQtyOnSalesOrder + Rec.Quantity;
            rlItem.MODIFY();
        END;
    //--AGRALA 862
    end;
}
