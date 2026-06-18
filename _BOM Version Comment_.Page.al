page 50053 "BOM Version Comment"
{
    Caption = 'BOM Version Comment';
    PageType = ListPart;
    SourceTable = "BOM Comment Version";
    AutoSplitKey = true;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    MultipleNewLines = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                    StyleExpr = VarFormato;
                }
                field("Format Line"; Rec."Format Line")
                {
                    ApplicationArea = All;
                    OptionCaption = ' ,Azul,Rojo,Negrita';

                    trigger OnValidate()
                    begin
                        //-- #9862
                        CASE Rec."Format Line" OF Rec."Format Line"::" ": VarFormato:='';
                        ELSE
                            VarFormato:=FORMAT(Rec."Format Line");
                        END;
                        CASE Rec."Format Line 2" OF Rec."Format Line 2"::" ": VarFormato2:='';
                        ELSE
                            VarFormato2:=FORMAT(Rec."Format Line 2");
                        END;
                    //++ #9862
                    end;
                }
                field("Comment 2"; Rec."Comment 2")
                {
                    ApplicationArea = All;
                    StyleExpr = VarFormato2;
                }
                field("Format Line 2"; Rec."Format Line 2")
                {
                    ApplicationArea = All;
                    OptionCaption = ' ,Azul,Rojo,Negrita';

                    trigger OnValidate()
                    begin
                        //-- #9862
                        CASE Rec."Format Line" OF Rec."Format Line"::" ": VarFormato:='';
                        ELSE
                            VarFormato:=FORMAT(Rec."Format Line");
                        END;
                        CASE Rec."Format Line 2" OF Rec."Format Line 2"::" ": VarFormato2:='';
                        ELSE
                            VarFormato2:=FORMAT(Rec."Format Line 2");
                        END;
                    //++ #9862
                    end;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnAfterGetRecord()
    begin
        //-- #9862
        CASE Rec."Format Line" OF Rec."Format Line"::" ": VarFormato:='';
        ELSE
            VarFormato:=FORMAT(Rec."Format Line");
        END;
        CASE Rec."Format Line 2" OF Rec."Format Line 2"::" ": VarFormato2:='';
        ELSE
            VarFormato2:=FORMAT(Rec."Format Line 2");
        END;
    //++ #9862
    end;
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //-- #9862
        VarFormato:='';
        VarFormato2:='';
    //++ #9862
    end;
    var VarFormato: Text;
    VarFormato2: Text;
}
