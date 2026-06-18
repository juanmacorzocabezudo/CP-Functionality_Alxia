page 50102 AlxElaboracion
{
    PageType = ListPart;
    Caption = 'Receta comentarios';
    SourceTable = AlxRecetaComentarios;
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            group(ElaboracionGroup)
            {
                ShowCaption = false;

                field(Elaboracion; _ElaboracionText)
                {
                    Caption = '';
                    MultiLine = true;
                    ExtendedDatatype = RichContent;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        SetElaboracionText();
                    end;
                }
            }
        }
    }
    /* actions
    {
        area(Processing)
        {
            action(Guardar)
            {
                ApplicationArea = All;
                Caption = 'Guardar';
                Image = Save;
                trigger OnAction()
                begin
                    SetElaboracionText();
                end;
            }
        }
    } */
    var _ElaboracionText: Text;
    trigger OnAfterGetRecord()
    begin
        GetElaboracionText();
    end;
    local procedure GetElaboracionText()
    var
        ElaboracionTextInS: InStream;
    begin
        Rec.CalcFields(ElaboracionText);
        Rec.ElaboracionText.CreateInStream(ElaboracionTextInS, TextEncoding::UTF8);
        ElaboracionTextInS.Read(_ElaboracionText);
    end;
    local procedure SetElaboracionText()
    var
        ElaboracionTextOutS: OutStream;
    begin
        Rec.ElaboracionText.CreateOutStream(ElaboracionTextOutS, TextEncoding::UTF8);
        ElaboracionTextOutS.Write(_ElaboracionText);
        if not Rec.Modify(true)then begin
            Rec.Insert(true)end;
    end;
}
