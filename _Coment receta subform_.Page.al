page 50023 "Coment receta subform"
{
    // ADVANCE - Log de cambios
    // -----------------------------------------------------
    //   ADVANCE
    //   Fecha: 23-05-2016
    //   Técnico: JMAP
    //   Presupuesto: I002074 - Desarrollo funcionalidades Recetas
    //   Modificación:
    // 
    //   Etiqueta: ADV001
    // -----------------------------------------------------
    // #9862 - Se introduce codigo para el formato de la linea
    // #9969 - Se hacen visible los campos de subrayados
    AutoSplitKey = true;
    MultipleNewLines = true;
    PageType = ListPart;
    Caption = 'Receta comentarios';
    SourceTable = "Receta Comentarios";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                    Caption = 'Comentarios';
                    StyleExpr = VarFormato;
                }
                field("Format Line"; Rec."Format Line")
                {
                    ApplicationArea = All;
                    Caption = 'Formato Linea';
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
                field("Subrayado amarillo"; Rec."Subrayado amarillo")
                {
                    ApplicationArea = All;
                }
                field("Comment 2"; Rec."Comment 2")
                {
                    Caption = 'Cometario 2';
                    ApplicationArea = All;
                    StyleExpr = VarFormato2;
                }
                field("Format Line 2"; Rec."Format Line 2")
                {
                    ApplicationArea = All;
                    Caption = 'Formato Linea 2';
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
                field("Subrayado amarillo 2"; Rec."Subrayado amarillo 2")
                {
                    ApplicationArea = All;
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
