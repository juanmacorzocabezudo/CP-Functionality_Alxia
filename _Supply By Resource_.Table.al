table 50021 "Supply By Resource"
{
    Caption = 'Suministro por recurso';
    DataClassification = CustomerContent;

    ;
    fields
    {
        field(1; Resource; Code[20])
        {
            Caption = 'Recurso';
            TableRelation = Resource."No.";

            trigger OnValidate()
            begin
                GetResourceInformation(Resource);
            end;
        }
        field(2; Type; Option)
        {
            Caption = 'Tipo';
            OptionCaption = 'Persona,Maquina';
            OptionMembers = Person, Machine;

            trigger OnValidate()
            begin
                GetSupplyInformation(Type, "No.");
            end;
        }
        field(3; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = Supply."No." WHERE(Type=FIELD(Type));

            trigger OnValidate()
            begin
                GetSupplyInformation(Type, "No.");
            end;
        }
        field(4; Description; Text[50])
        {
            Caption = 'Descripción';
        }
        field(5; "UofM Supply"; Code[20])
        {
            Caption = 'Unidad medida suministro';
            TableRelation = "Unit of Measure".Code;
        }
        field(6; "Quantity per"; Decimal)
        {
            Caption = 'Cantidad por';

            trigger OnValidate()
            begin
                VALIDATE(Cost);
            end;
        }
        field(7; Price; Decimal)
        {
            Caption = 'Precio';
            Editable = false;

            trigger OnValidate()
            begin
                VALIDATE(Cost);
            end;
        }
        field(8; Cost; Decimal)
        {
            Caption = 'Coste Total';
            DecimalPlaces = 3: 3;
            Editable = false;

            trigger OnValidate()
            begin
                Cost:=ROUND((Price * "Quantity per"), 0.001);
            end;
        }
        field(9; Machine; Code[30])
        {
            Caption = 'Maquina';
        }
        field(10; Comment; Text[250])
        {
            Caption = 'Comentario';
        }
        field(11; "Resource Direct Cost"; Decimal)
        {
            CalcFormula = Lookup(Resource."Direct Unit Cost" WHERE("No."=FIELD(Resource)));
            Caption = 'Coste recurso';
            Editable = false;
            FieldClass = FlowField;
        }
        field(12; "UofM Resource"; Code[20])
        {
            Caption = 'Unidad medida recurso';
            Editable = false;
            TableRelation = "Unit of Measure".Code;
        }
        field(13; "Resource Name"; Text[50])
        {
            Caption = 'Nombre recurso';
            Editable = false;
        }
    }
    keys
    {
        key(Key1; Resource, Type, "No.", Machine)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnDelete()
    begin
        ApplyResourceCost(2);
    end;
    trigger OnInsert()
    begin
        ApplyResourceCost(0);
    end;
    trigger OnModify()
    begin
        ApplyResourceCost(1);
    end;
    local procedure GetResourceInformation(VarResource: Code[20])
    var
        Resource: Record 156;
    begin
        Resource.RESET;
        Resource.SETRANGE("No.", VarResource);
        IF Resource.FINDFIRST THEN BEGIN
            VALIDATE("UofM Resource", Resource."Base Unit of Measure");
            VALIDATE("Resource Name", Resource.Name);
        END
        ELSE
        BEGIN
            VALIDATE("UofM Resource", '');
            VALIDATE("Resource Name", '');
        END;
    end;
    local procedure GetSupplyInformation(VarType: Integer; VarNo: Code[20])
    var
        Supply: Record 50020;
    begin
        Supply.RESET;
        Supply.SETRANGE(Type, VarType);
        Supply.SETRANGE("No.", VarNo);
        IF Supply.FINDFIRST THEN BEGIN
            VALIDATE(Description, Supply.Description);
            VALIDATE("UofM Supply", Supply."Unit of measurement");
            VALIDATE(Price, Supply.Price);
        END
        ELSE
        BEGIN
            VALIDATE(Description, '');
            VALIDATE("UofM Supply", '');
            VALIDATE(Price, 0);
        END;
    end;
    local procedure ApplyResourceCost(VarAction: Option "Action Insert", "Action Modify", "Action Delete")
    var
        Resource: Record 156;
    begin
        Resource.RESET;
        Resource.SETRANGE("No.", Rec.Resource);
        IF Resource.FINDFIRST THEN BEGIN
            CASE VarAction OF VarAction::"Action Insert": BEGIN
                Resource.VALIDATE("Direct Unit Cost", Resource."Direct Unit Cost" + Rec.Cost);
                Resource.MODIFY;
            END;
            VarAction::"Action Modify": BEGIN
                Resource.VALIDATE("Direct Unit Cost", (Resource."Direct Unit Cost" + Rec.Cost - xRec.Cost));
                Resource.MODIFY;
            END;
            VarAction::"Action Delete": BEGIN
                Resource.VALIDATE("Direct Unit Cost", (Resource."Direct Unit Cost" - Rec.Cost));
                Resource.MODIFY;
            END;
            END;
        END;
    end;
}
