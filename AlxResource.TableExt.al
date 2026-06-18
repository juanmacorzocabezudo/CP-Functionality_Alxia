tableextension 50040 AlxResource extends Resource
{
    fields
    {
    }
    trigger OnDelete()
    var
        rBOM: Record "BOM Component";
    begin
        rBOM.Reset();
        rBOM.SetRange("No.", Rec."No.");
        if rBOM.FindFirst()then Error('No se puede eliminar, el recurso se encuentra activo en la receta ' + rBOM."Parent Item No.");
    end;
}
