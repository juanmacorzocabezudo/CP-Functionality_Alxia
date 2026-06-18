page 50091 AlxModCosteEstandar
{
    Caption = 'Modificar Coste Estandar';
    PageType = Card;
    SourceTable = Item;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'Ajustar Coste estándar';

                field("Standard Cost"; Rec."Standard Cost")
                {
                    ApplicationArea = All;
                    Caption = 'Coste estándar actual';
                    Enabled = false;
                    Editable = false;
                }
                field(_NuevoCoste; _NuevoCoste)
                {
                    ApplicationArea = All;
                    Caption = 'Nuevo coste estándar';
                    Enabled = _edit;
                    Editable = _edit;
                }
                field(_Proveedor; _Proveedor)
                {
                    ApplicationArea = All;
                    Caption = 'Proveedor';
                    TableRelation = Vendor."No.";
                }
                field(_Cometario; _Cometario)
                {
                    ApplicationArea = All;
                    Caption = 'Comentario';
                    MultiLine = true;
                }
            }
            part(Hist; AGRALAHistoricoCosteEstandar)
            {
                ApplicationArea = All;
                Caption = 'Historico coste estandar';
                SubPageLink = AGRALAIdProducto=field("No.");
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Aceptar)
            {
                Caption = 'Aceptar';
                ApplicationArea = All;
                Image = Confirm;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Enabled = _edit;

                trigger OnAction()
                var
                    RecItem: Record Item;
                    RecHist: Record 50030;
                begin
                    RecItem.Reset();
                    RecItem.SetRange("No.", Rec."No.");
                    RecItem.FindFirst();
                    RecItem."Standard Cost":=_NuevoCoste;
                    RecItem.Modify();
                    RecHist.Reset();
                    RecHist.AGRALAFechaModificacion:=CreateDateTime(Today, time);
                    RecHist.AGRALACosteGeneral:=_NuevoCoste;
                    RecHist.AGRALAComentario:=_Cometario;
                    RecHist.AGRALAIdProducto:=Rec."No.";
                    RecHist.Proveedor:=_Proveedor;
                    RecHist.Usuario:=UserId;
                    RecHist.Insert();
                end;
            }
        }
    }
    var _NuevoCoste: Decimal;
    _edit: Boolean;
    _Cometario: Text;
    _Proveedor: code[20];
    trigger OnOpenPage()
    var
        ItemNo: Text;
    begin
        Evaluate(ItemNo, Rec."No.");
        if(ItemNo.Contains('MP')) or (ItemNo.Contains('MA'))then begin
            Editable:=true;
            _edit:=true;
        end
        else
        begin
            Editable:=false;
            _edit:=false;
        end;
    end;
}
