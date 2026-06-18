table 50022 "Work center Header"
{
    //Caption = 'Work center Header';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            var
                NoSeries: Codeunit "No. Series";
            begin
                if "No." <> xRec."No." then begin
                    GetSalesSetup();
                    NoSeries.TestManual(GetNoSeriesCode());
                    "No. Series":='';
                end;
            end;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Descripción';
        }
        field(3; "Total Cost"; Decimal)
        {
            CalcFormula = Sum("Work Center Line".Cost WHERE("Work Center No."=FIELD("No.")));
            Caption = 'Coste Total';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; "Unit of Mesaruement"; Code[10])
        {
            Caption = 'Unidad Medidia';
            TableRelation = "Unit of Measure".Code;
        }
        field(10; Comment; Text[250])
        {
            Caption = 'Comentario';
        }
        field(11; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
    }
    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    /* trigger OnInsert()
    var
        rWorkCenter: record "Work center Header";
        numero: Integer;
    begin
        if Rec."No." = '' then begin
            rWorkCenter.Reset();
            if rWorkCenter.FindLast() then begin
                Evaluate(numero, rWorkCenter."No.");
            end;
            Rec."No." := Format(numero + 1);
        end;
    end; */
    trigger OnInsert()
    begin
        InitInsert();
    end;
    procedure InitInsert()
    var
        rCentro: Record "Work center Header";
        NoSeries: Codeunit "No. Series";
        NoSeriesCode: Code[20];
    begin
        if "No." = '' then begin
            NoSeriesCode:=GetNoSeriesCode();
            "No. Series":=NoSeriesCode;
            if NoSeries.AreRelated("No. Series", xRec."No. Series")then "No. Series":=xRec."No. Series";
            "No.":=NoSeries.GetNextNo("No. Series", Today);
            rCentro.ReadIsolation(IsolationLevel::ReadUncommitted);
            rCentro.SetLoadFields("No.");
            while rCentro.Get("No.")do "No.":=NoSeries.GetNextNo("No. Series", Today);
        end;
    end;
    trigger OnDelete()
    begin
        IF CONFIRM(TextDelete, TRUE)THEN DeleteLines
        ELSE
            ERROR(TextDeleteStop);
    end;
    var TextDelete: Label 'Confirm that you want to delete the work center and all the asociated lines?';
    TextDeleteStop: Label 'The delete operation has been stoped';
    local procedure DeleteLines()
    var
        WorkCenterLine: Record 50023;
    begin
        WorkCenterLine.RESET;
        WorkCenterLine.SETRANGE("Work Center No.", Rec."No.");
        IF WorkCenterLine.FINDSET THEN BEGIN
            REPEAT WorkCenterLine.DELETE;
            UNTIL WorkCenterLine.NEXT = 0;
        END;
    end;
    local procedure GetSalesSetup()
    begin
        SalesSetup.Get();
    end;
    procedure GetNoSeriesCode(): Code[20]var
        NoSeries2: Codeunit "No. Series";
        NoSeriesCode: Code[20];
    begin
        GetSalesSetup();
        NoSeriesCode:=SalesSetup."Serie Centro Trabajo";
        exit(NoSeriesCode);
    end;
    var SalesSetup: Record "Sales & Receivables Setup";
}
