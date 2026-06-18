pageextension 50004 AlxiaJobCard extends "Job Card"
{
    actions
    {
        addafter("Create Inventory Pick")
        {
            action("Menú Adultos")
            {
                Caption = 'Menú Adultos';
                Image = SalesPurchaseTeam;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Menu Adulto";
                RunPageLink = "Codigo Evento"=FIELD("No."), Tipo=FILTER(Adulto);
                RunPageView = SORTING("Codigo Evento", Linea)ORDER(Ascending)WHERE(Tipo=FILTER(Adulto));
            }
            action("Menú Niños")
            {
                Caption = 'Menú Niños';
                ApplicationArea = All;
                Image = SocialSecurity;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Menu Niño";
                RunPageLink = "Codigo Evento"=FIELD("No."), Tipo=FILTER(Niño);
                RunPageView = SORTING("Codigo Evento", Linea)ORDER(Ascending)WHERE(Tipo=FILTER(Niño));
            }
            action("Menú Especial")
            {
                ApplicationArea = All;
                Image = SocialSecurityLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Menu Especial";
                RunPageLink = "Codigo Evento"=FIELD("No."), Tipo=FILTER(Otros);
                RunPageView = SORTING("Codigo Evento", Linea)ORDER(Ascending)WHERE(Tipo=FILTER(Otros));
            }
            action("Personal Evento")
            {
                Caption = 'Personal Evento';
                ApplicationArea = All;
                Image = ResourceSkills;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Personal Eventos";
                RunPageLink = "Codigo Evento"=FIELD("No."), Tipo=CONST(Personal);
                RunPageView = SORTING("Codigo Evento", Linea)ORDER(Ascending)WHERE(Tipo=FILTER(Personal));
            }
            action(RecursosEvento)
            {
                Caption = 'Mobiliario, Transporte, Menaje No Desechable';
                ApplicationArea = All;
                Image = ResourceSetup;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Recursos Eventos";
                RunPageLink = "Codigo Evento"=FIELD("No."), Tipo=CONST(Otros);
                RunPageView = SORTING("Codigo Evento", Tipo, Linea)ORDER(Ascending)WHERE(Tipo=CONST(Otros));
            }
            action("Menaje Desechable")
            {
                Caption = 'Menaje Desechable';
                ApplicationArea = All;
                Image = ResourceSetup;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Menaje Desechable";
                RunPageLink = "Codigo Evento"=FIELD("No."), Tipo=CONST(Menaje);
                RunPageView = SORTING("Codigo Evento", Tipo, Linea)ORDER(Ascending)WHERE(Tipo=CONST(Menaje));
            }
            action("Suplementos Evento")
            {
                Caption = 'Suplementos Evento';
                ApplicationArea = All;
                Image = ResourceSetup;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Suplementos Evento";
                RunPageLink = "Codigo Evento"=FIELD("No."), Tipo=CONST(Suplementos);
                RunPageView = SORTING("Codigo Evento", Tipo, Linea)ORDER(Ascending)WHERE(Tipo=CONST(Suplementos));
            }
            action("Pan Evento")
            {
                Caption = 'Pan Evento';
                ApplicationArea = All;
                Image = ResourceSetup;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Pan Evento";
                RunPageLink = "Codigo Evento"=FIELD("No."), Tipo=CONST(Pan);
                RunPageView = SORTING("Codigo Evento", Tipo, Linea)ORDER(Ascending)WHERE(Tipo=CONST(Pan));
            }
            action(Componentes)
            {
                Caption = 'Componentes';
                Image = BOM;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
            //RunObject = Page 50079;
            //RunPageLink = Codigo Evento=FIELD(Codigo Evento);
            }
            action("Copiar Evento")
            {
                Caption = 'Copiar Evento';
                ApplicationArea = All;
                Image = CopyDocument;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                var
                //rpt_copiarevento: Report "50000";
                begin
                    IF CONFIRM('¿Desea duplicar este evento?')THEN BEGIN
                        /*  CLEAR(rpt_copiarevento);
                         rpt_copiarevento.USEREQUESTPAGE(FALSE);
                         rpt_copiarevento.SetEventos(Rec."Codigo Evento");
                         rpt_copiarevento.RUNMODAL; */
                        MESSAGE('Copiado Finalizado');
                    END;
                end;
            }
            action("Calcular Costes y Precios")
            {
                Caption = 'Calcular Costes y Precios';
                ApplicationArea = All;
                Image = CalculateCost;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    //Rec.gfu_CalculoCostesPrecios;
                    //Rec.gfu_CalculoCostesPrecios;
                    CurrPage.UPDATE;
                end;
            }
            action("Cambiar Estado")
            {
                Caption = 'Cambiar Estado';
                ApplicationArea = All;
                Image = ChangeStatus;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.gfu_CambiarEstado;
                end;
            }
        }
    }
}
