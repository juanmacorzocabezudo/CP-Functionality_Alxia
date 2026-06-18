page 50005 AlxiaMenuCard
{
    Caption = 'Detalles Evento';
    PageType = Card;
    SourceTable = "Evento";

    layout
    {
        area(content)
        {
            part(MenuEspecial; MenuEspecialListPart)
            {
                ApplicationArea = All;
                Caption = 'Menu Especial';
                SubPageLink = "Codigo Evento"=FIELD("Codigo Evento"), Tipo=FILTER(Otros);
                SubPageView = SORTING("Codigo Evento", Linea)ORDER(Ascending)WHERE(Tipo=FILTER(Otros));
            }
            part(MenuNino; "MenuNiñoListPart")
            {
                ApplicationArea = All;
                Caption = 'Menu Niño';
                SubPageLink = "Codigo Evento"=FIELD("Codigo Evento"), Tipo=FILTER(Niño);
                SubPageView = SORTING("Codigo Evento", Linea)ORDER(Ascending)WHERE(Tipo=FILTER(Niño));
            }
            part(MenuAdulto; MenuAdultoListPart)
            {
                ApplicationArea = All;
                UpdatePropagation = Both;
                Caption = 'Menu Adulto';
                SubPageLink = "Codigo Evento"=FIELD("Codigo Evento"), Tipo=FILTER(Adulto);
                SubPageView = SORTING("Codigo Evento", Linea)ORDER(Ascending)WHERE(Tipo=FILTER(Adulto));
            }
            part(PanEvento; PanEventoListPart)
            {
                ApplicationArea = All;
                Caption = 'Pan Evento';
                SubPageLink = "Codigo Evento"=FIELD("Codigo Evento"), Tipo=CONST(Pan);
                SubPageView = SORTING("Codigo Evento", Tipo, Linea)ORDER(Ascending)WHERE(Tipo=CONST(Pan));
            }
            part(MenajeDesechable; MenajeDesechableListPart)
            {
                ApplicationArea = All;
                Caption = 'Menaje Desechable';
                SubPageLink = "Codigo Evento"=FIELD("Codigo Evento"), Tipo=CONST(Menaje);
                SubPageView = SORTING("Codigo Evento", Tipo, Linea)ORDER(Ascending)WHERE(Tipo=CONST(Menaje));
            }
            part(PersonalEvento; PersonalEventoListPart)
            {
                ApplicationArea = All;
                Caption = 'Personal Evento';
                SubPageLink = "Codigo Evento"=FIELD("Codigo Evento"), Tipo=CONST(Personal);
                SubPageView = SORTING("Codigo Evento", Linea)ORDER(Ascending)WHERE(Tipo=FILTER(Personal));
            }
            part(recursosEvento; RecursosEventoListPart)
            {
                ApplicationArea = All;
                Caption = 'Mobiliario, Transporte, Menaje No Desechable';
                SubPageLink = "Codigo Evento"=FIELD("Codigo Evento"), Tipo=CONST(Otros);
                SubPageView = SORTING("Codigo Evento", Tipo, Linea)ORDER(Ascending)WHERE(Tipo=CONST(Otros));
            }
            part(SuplementoEventos; SuplementosEventoListPart)
            {
                ApplicationArea = All;
                Caption = 'Suplementos Evento';
                SubPageLink = "Codigo Evento"=FIELD("Codigo Evento"), Tipo=CONST(Suplementos);
                SubPageView = SORTING("Codigo Evento", Tipo, Linea)ORDER(Ascending)WHERE(Tipo=CONST(Suplementos));
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Calcular Costes y Precios")
            {
                Caption = 'Calcular Costes y Precios';
                ApplicationArea = All;
                Image = CalculateCost;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    RecEvento: Record Evento;
                begin
                    RecEvento.Reset();
                    RecEvento.SetRange(RecEvento."Codigo Evento", Rec."Codigo Evento");
                    RecEvento.FindSet();
                    RecEvento.gfu_CalculoCostesPrecios;
                    RecEvento.gfu_CalculoCostesPrecios;
                    RecEvento.gfu_CalculoCostesPrecios;
                    RecEvento.gfu_CalculoCostesPrecios;
                    CurrPage.Update(false);
                    SelectLatestVersion();
                    CurrPage.MenuAdulto.Page.Update(false);
                    CurrPage.MenuNino.Page.Update(false);
                    CurrPage.MenuEspecial.Page.Update(false);
                end;
            }
        }
    }
}
