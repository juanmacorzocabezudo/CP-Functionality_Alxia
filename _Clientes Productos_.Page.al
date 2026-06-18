page 50119 "Clientes Productos"
{
    PageType = Worksheet;
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;
    SourceTable = "Productos Clientes";
    LinksAllowed = false;
    Description = 'GAP00040';

    layout
    {
        area(Content)
        {
            group(Control50002)
            {
                Caption = 'Filtrar cliente';

                field(NroCliente_Caption; NroCliente)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cliente';
                    TableRelation = Customer where("Tiene Producto Asociado"=filter('Sí'));

                    trigger OnValidate()
                    var
                        Cliente: Record Customer;
                    begin
                        NombreCliente:='';
                        if Cliente.Get(NroCliente)then begin
                            NombreCliente:=Cliente.Name;
                            Rec.SetRange("Nro. Cliente", NroCliente);
                        end
                        else
                            Rec.SetRange("Nro. Cliente");
                        CurrPage.Update();
                    end;
                }
                field(NombreCliente_Caption; NombreCliente)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Nombre';
                    Editable = false;
                }
            }
            group(Contorl50000)
            {
                Caption = 'Filtrar producto';

                field(NroProducto_Caption; NroProducto)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Producto';
                    TableRelation = Item where("Tiene Cliente Asociado"=filter('Sí'));

                    trigger OnValidate()
                    var
                        Producto: Record Item;
                    begin
                        DescripcionProducto:='';
                        if Producto.Get(NroProducto)then begin
                            DescripcionProducto:=Producto.Description;
                            Rec.SetRange("Nro. Producto", NroProducto);
                        end
                        else
                            Rec.SetRange("Nro. Producto");
                        CurrPage.Update();
                    end;
                }
                field(DescripcionProducto_Caption; DescripcionProducto)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Descripción';
                    Editable = false;
                }
                field(ComponentesConStock_Caption; ComponentesConStock)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Comp. con stock';
                    ToolTip = 'Componentes con stock';

                    trigger OnValidate()
                    begin
                        FiltrarComponentesConStock();
                    end;
                }
                field(SoloComponentesCriticos_Caption; SoloComponentesCriticos)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sólo comp. críticos';
                    ToolTip = 'Sólo componente críticos"';

                    trigger OnValidate()
                    begin
                        FiltrarComponentesCriticos();
                    end;
                }
            }
            repeater(Control50000)
            {
                ShowCaption = false;

                field("Nro. Producto"; Rec."Nro. Producto")
                {
                    ApplicationArea = Basic;
                }
                field("Descripción Producto"; Rec."Descripción Producto")
                {
                    ApplicationArea = Basic;
                }
            }
            part(ListaComponentes; "Subformulario Receta Item")
            {
                ApplicationArea = Basic, Suite;
                Editable = false;
                SubPageLink = Type=filter(Item), "Parent Item No."=field("Nro. Producto"), "Assembly BOM"=filter(false);
            }
        }
    }
    actions
    {
        area(Processing)
        {
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean begin
        if NroCliente = '' then Error(Error50000Err);
        Rec."Nro. Cliente":=NroCliente;
        Rec."Nombre Cliente":=NombreCliente;
    end;
    trigger OnAfterGetCurrRecord()
    begin
        FiltrarComponentesConStock();
        FiltrarComponentesCriticos();
    end;
    var Componentes: Record "BOM Component";
    NroProducto: Code[20];
    NroCliente: Code[20];
    DescripcionProducto: Text[100];
    NombreCliente: Text[100];
    ComponentesConStock: Boolean;
    SoloComponentesCriticos: Boolean;
    Error50000Err: Label 'You must filter a customer.', comment = 'ESP="Deb filtrar un cliente."';
    local procedure FiltrarComponentesCriticos()
    begin
        if SoloComponentesCriticos then CurrPage.ListaComponentes.Page.MarcarComponentesCriticos()
        else
            CurrPage.ListaComponentes.Page.DesMarcarComponentesCriticos();
    end;
    local procedure FiltrarComponentesConStock()
    begin
        if ComponentesConStock then CurrPage.ListaComponentes.Page.MarcarComponentesConStock()
        else
            CurrPage.ListaComponentes.Page.DesMarcarComponentesConStock();
    end;
}
