page 50042 "Supply List"
{
    ApplicationArea = All;
    Caption = 'Suministros';
    PageType = List;
    SourceTable = Supply;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Unit of measurement"; Rec."Unit of measurement")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field(Price; Rec.Price)
                {
                    ApplicationArea = All;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Where-Used")
            {
                ApplicationArea = All;
                Caption = 'Puntos de uso';
                Image = Track;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Promoted = true;
                RunObject = Page SuministroRecursos;
                RunPageLink = Type=field(Type), "No."=FIELD("No.");
                RunPageView = SORTING(Type, "No.");
            }
            action(Actualizar)
            {
                ApplicationArea = All;
                Caption = 'Actualizar';
                Image = UpdateXML;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Promoted = true;

                trigger OnAction()
                begin
                    ActulizarPrecio();
                end;
            }
        }
    }
    procedure ActulizarPrecio()
    var
        recSupply: Record Supply;
    begin
        recSupply.Reset();
        if recSupply.FindFirst()then repeat ActualizarRecursos(recSupply);
            until recSupply.Next() = 0;
    end;
    procedure ActualizarRecursos(var recSupply: Record Supply)
    var
        recSBR: Record "Supply By Resource";
        recSBRAux: Record "Supply By Resource";
        recResource: Record Resource;
        recCentroLine: Record "Work Center Line";
    begin
        recSBR.Reset();
        recSBR.SetRange("No.", recSupply."No.");
        if recSBR.FindFirst()then repeat recSBR.Validate(Price, recSupply.Price);
                recSBR.Modify();
                recResource.Reset();
                recResource.SetRange("No.", recSBR.Resource);
                if recResource.FindFirst()then begin
                    recSBRAux.Reset();
                    recSBRAux.SetRange(Resource, recResource."No.");
                    if recSBRAux.FindFirst()then begin
                        recSBRAux.CalcSums(Cost);
                        recResource.Validate("Direct Unit Cost", recSBRAux.Cost);
                        recResource.Modify();
                    end;
                    recCentroLine.Reset();
                    recCentroLine.SetRange("No.", recResource."No.");
                    if recCentroLine.FindFirst()then repeat recCentroLine.Validate("Resource Cost", recSBRAux.Cost);
                            recCentroLine.Modify();
                        until recCentroLine.Next() = 0;
                end;
            until recSBR.Next() = 0;
    end;
}
