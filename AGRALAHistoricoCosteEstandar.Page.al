page 50084 AGRALAHistoricoCosteEstandar
{
    Caption = 'Posted Standar Cost';
    PageType = ListPart;
    //Permissions =;
    SourceTable = 50030;
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(AGRALAFechaModificacion; Rec.AGRALAFechaModificacion)
                {
                    ApplicationArea = All;
                    Caption = 'Fecha Modificación';
                    Editable = false;
                }
                field(AGRALAIdProducto; Rec.AGRALAIdProducto)
                {
                    ApplicationArea = All;
                    Caption = 'No. Producto';
                }
                field(AGRALACosteGeneral; Rec.AGRALACosteGeneral)
                {
                    ApplicationArea = All;
                    Caption = 'Coste Estándar';
                }
                field(Proveedor; Rec.Proveedor)
                {
                    ApplicationArea = all;
                }
                field(AGRALAComentario; Rec.AGRALAComentario)
                {
                    ApplicationArea = All;
                    Caption = 'Comentario';
                }
                field(Usuario; Rec.Usuario)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnOpenPage()
    begin
        Rec.SetCurrentKey(AGRALAFechaModificacion);
        Rec.Ascending(false);
    end;
/*  trigger OnOpenPage()
     begin
         //+AGRALA 412
         Rec.SETFILTER(AGRALAIdProducto, Item."No.");
         //-AGRALA 412
     end; */
/*  var
         Item: Record 27;


     procedure SetItem(Item2: Record 27)
     begin
         Item.COPY(Item2);
     end; */
}
