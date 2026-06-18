codeunit 50008 AlxRecetasNiveles
{
    trigger OnRun()
    begin
        RecetasNiveles(false);
    end;
    var xNivel: Option "00 - Receta madre", "01 - Nivel", "02 - Nivel", "03 - Nivel", "04 - Nivel", "05 - Nivel";
    rBOMCompN0: Record "BOM Component";
    rBOMCompN1: Record "BOM Component";
    rBOMCompN2: Record "BOM Component";
    rBOMCompN3: Record "BOM Component";
    rBOMCompN4: Record "BOM Component";
    rBOMCompN5: Record "BOM Component";
    rItem: Record Item;
    rNiveles: Record AlxRecetasNiveles;
    rAuxNiveles: Record AlxAuxNiveles;
    Progress: Dialog;
    i: Integer;
    Text000: Label 'Analizando Receta------ #1 \ Total recetas ------ #2 \ Procesando ------ #3';
    procedure RecetasNiveles(visible: Boolean)
    begin
        rNiveles.DeleteAll();
        rAuxNiveles.DeleteAll();
        rItem.Reset();
        rItem.SetRange(AGRALAIngrediente, false);
        rItem.FindSet();
        if visible then begin
            Progress.OPEN(Text000);
            Progress.Update(2, rItem.Count());
        end;
        repeat GetNivel00(rItem."No.", xNivel::"00 - Receta madre");
            i+=1;
            if visible then begin
                Progress.Update(1, rItem."No.");
                Progress.Update(3, i);
            end;
        until rItem.Next() = 0;
        if visible then Progress.Close();
    end;
    procedure GetNivel00(ProductoBase: Code[20]; Nivel: Option)
    var
        rBOMCompN0: Record "BOM Component";
        rAlxNivel: Record AlxRecetasNiveles;
        rAuxNiveles: Record AlxAuxNiveles;
        rItem00: Record Item;
        Nivel01: Boolean;
    begin
        rBOMCompN0.Reset();
        rBOMCompN0.SetRange("Parent Item No.", ProductoBase);
        if rBOMCompN0.FindFirst()then repeat rItem00.Reset();
                rItem00.SetRange("No.", ProductoBase);
                if rItem00.FindFirst()then;
                rBOMCompN0.CalcFields("Assembly BOM");
                rAlxNivel.TransferFields(rBOMCompN0);
                rAlxNivel.ProductoBase:=ProductoBase;
                rAlxNivel."Nivel":=Nivel;
                rAlxNivel.LineNo:=GetLastLine();
                rAlxNivel.Bloqueado:=rItem00.Blocked;
                rAlxNivel."Lote receta":=rItem00."Lote Receta";
                rAlxNivel."Statistics Lot":=rItem00."Statistics Lot";
                rAlxNivel."Statistics Unit of Measurement":=rItem00."Statistics Unit of Measurement";
                rAlxNivel.Insert();
                if rBOMCompN0."Assembly BOM" then begin
                    Nivel01:=true;
                    rAuxNiveles.ProductoBase:=ProductoBase;
                    rAuxNiveles.ItemNo:=rBOMCompN0."No.";
                    rAuxNiveles.Nivel:=rAuxNiveles.Nivel::"01 - Nivel";
                    rAuxNiveles."Line No.":=GetLastLineAux(ProductoBase);
                    rAuxNiveles.Insert();
                end;
            until rBOMCompN0.Next() = 0;
        if Nivel01 then GetNivel01(ProductoBase, xNivel::"01 - Nivel");
    end;
    procedure GetNivel01(ProductoBase: Code[20]; Nivel: Option)
    var
        rBOMCompN1: Record "BOM Component";
        rAlxNivel01: Record AlxRecetasNiveles;
        rAuxNiveles: Record AlxAuxNiveles;
        rAuxNiveles01: Record AlxAuxNiveles;
        rItem01: Record Item;
        Nivel02: Boolean;
    begin
        rAuxNiveles01.SetRange(ProductoBase, ProductoBase);
        rAuxNiveles01.SetRange("Nivel", rAuxNiveles01.Nivel::"01 - Nivel");
        if rAuxNiveles01.FindFirst()then repeat rBOMCompN1.Reset();
                rBOMCompN1.SetRange("Parent Item No.", rAuxNiveles01.ItemNo);
                if rBOMCompN1.FindFirst()then repeat rItem01.Reset();
                        rItem01.SetRange("No.", rAuxNiveles01.ItemNo);
                        if rItem01.FindFirst()then;
                        rBOMCompN1.CalcFields("Assembly BOM");
                        rAlxNivel01.TransferFields(rBOMCompN1);
                        rAlxNivel01.ProductoBase:=ProductoBase;
                        rAlxNivel01."Nivel":=Nivel;
                        rAlxNivel01.LineNo:=GetLastLine();
                        rAlxNivel01.Bloqueado:=rItem01.Blocked;
                        rAlxNivel01."Lote receta":=rItem01."Lote Receta";
                        rAlxNivel01."Statistics Lot":=rItem01."Statistics Lot";
                        rAlxNivel01."Statistics Unit of Measurement":=rItem01."Statistics Unit of Measurement";
                        rAlxNivel01."Unidad medida Item":=rItem01."Base Unit of Measure";
                        rAlxNivel01.Insert();
                        if rBOMCompN1."Assembly BOM" then begin
                            Nivel02:=true;
                            rAuxNiveles.ProductoBase:=ProductoBase;
                            rAuxNiveles.ItemNo:=rBOMCompN1."No.";
                            rAuxNiveles.Nivel:=rAuxNiveles.Nivel::"02 - Nivel";
                            rAuxNiveles."Line No.":=GetLastLineAux(ProductoBase);
                            rAuxNiveles.Insert();
                        end;
                    until rBOMCompN1.Next() = 0;
            until rAuxNiveles01.Next() = 0;
        if Nivel02 then GetNivel02(ProductoBase, xNivel::"02 - Nivel");
    end;
    procedure GetNivel02(ProductoBase: Code[20]; Nivel: Option)
    var
        rBOMCompN2: Record "BOM Component";
        rAlxNivel02: Record AlxRecetasNiveles;
        rAuxNiveles: Record AlxAuxNiveles;
        rAuxNiveles02: Record AlxAuxNiveles;
        rItem02: Record Item;
        Nivel03: Boolean;
    begin
        rAuxNiveles02.SetRange(ProductoBase, ProductoBase);
        rAuxNiveles02.SetRange("Nivel", rAuxNiveles02.Nivel::"02 - Nivel");
        if rAuxNiveles02.FindFirst()then repeat rBOMCompN2.Reset();
                rBOMCompN2.SetRange("Parent Item No.", rAuxNiveles02.ItemNo);
                if rBOMCompN2.FindFirst()then repeat rItem02.Reset();
                        rItem02.SetRange("No.", rAuxNiveles02.ItemNo);
                        if rItem02.FindFirst()then;
                        rBOMCompN2.CalcFields("Assembly BOM");
                        rAlxNivel02.TransferFields(rBOMCompN2);
                        rAlxNivel02.ProductoBase:=ProductoBase;
                        rAlxNivel02."Nivel":=Nivel;
                        rAlxNivel02.LineNo:=GetLastLine();
                        rAlxNivel02.Bloqueado:=rItem02.Blocked;
                        rAlxNivel02."Lote receta":=rItem02."Lote Receta";
                        rAlxNivel02."Statistics Lot":=rItem02."Statistics Lot";
                        rAlxNivel02."Statistics Unit of Measurement":=rItem02."Statistics Unit of Measurement";
                        rAlxNivel02."Unidad medida Item":=rItem02."Base Unit of Measure";
                        rAlxNivel02.Insert();
                        if rBOMCompN2."Assembly BOM" then begin
                            Nivel03:=true;
                            rAuxNiveles.ProductoBase:=ProductoBase;
                            rAuxNiveles.ItemNo:=rBOMCompN2."No.";
                            rAuxNiveles.Nivel:=rAuxNiveles.Nivel::"03 - Nivel";
                            rAuxNiveles."Line No.":=GetLastLineAux(ProductoBase);
                            rAuxNiveles.Insert();
                        end;
                    until rBOMCompN2.Next() = 0;
            until rAuxNiveles02.Next() = 0;
        if Nivel03 then GetNivel03(ProductoBase, xNivel::"03 - Nivel");
    end;
    procedure GetNivel03(ProductoBase: Code[20]; Nivel: Option)
    var
        rBOMCompN3: Record "BOM Component";
        rAlxNivel03: Record AlxRecetasNiveles;
        rAuxNiveles: Record AlxAuxNiveles;
        rAuxNiveles03: Record AlxAuxNiveles;
        rItem03: Record Item;
        Nivel04: Boolean;
    begin
        rAuxNiveles03.SetRange(ProductoBase, ProductoBase);
        rAuxNiveles03.SetRange("Nivel", rAuxNiveles03.Nivel::"03 - Nivel");
        if rAuxNiveles03.FindFirst()then repeat rBOMCompN3.Reset();
                rBOMCompN3.SetRange("Parent Item No.", rAuxNiveles03.ItemNo);
                if rBOMCompN3.FindFirst()then repeat rItem03.Reset();
                        rItem03.SetRange("No.", rAuxNiveles03.ItemNo);
                        if rItem03.FindFirst()then;
                        rBOMCompN3.CalcFields("Assembly BOM");
                        rAlxNivel03.TransferFields(rBOMCompN3);
                        rAlxNivel03.ProductoBase:=ProductoBase;
                        rAlxNivel03."Nivel":=Nivel;
                        rAlxNivel03.LineNo:=GetLastLine();
                        rAlxNivel03.Bloqueado:=rItem03.Blocked;
                        rAlxNivel03."Lote receta":=rItem03."Lote Receta";
                        rAlxNivel03."Statistics Lot":=rItem03."Statistics Lot";
                        rAlxNivel03."Statistics Unit of Measurement":=rItem03."Statistics Unit of Measurement";
                        rAlxNivel03."Statistics Unit of Measurement":=rItem03."Statistics Unit of Measurement";
                        rAlxNivel03."Unidad medida Item":=rItem03."Base Unit of Measure";
                        rAlxNivel03.Insert();
                        if rBOMCompN3."Assembly BOM" then begin
                            Nivel04:=true;
                            rAuxNiveles.ProductoBase:=ProductoBase;
                            rAuxNiveles.ItemNo:=rBOMCompN3."No.";
                            rAuxNiveles.Nivel:=rAuxNiveles.Nivel::"04 - Nivel";
                            rAuxNiveles."Line No.":=GetLastLineAux(ProductoBase);
                            rAuxNiveles.Insert();
                        end;
                    until rBOMCompN3.Next() = 0;
            until rAuxNiveles03.Next() = 0;
        if Nivel04 then GetNivel04(ProductoBase, xNivel::"04 - Nivel");
    end;
    procedure GetNivel04(ProductoBase: Code[20]; Nivel: Option)
    var
        rBOMCompN4: Record "BOM Component";
        rAlxNivel04: Record AlxRecetasNiveles;
        rAuxNiveles: Record AlxAuxNiveles;
        rAuxNiveles04: Record AlxAuxNiveles;
        rItem04: Record Item;
        Nivel05: Boolean;
    begin
        rAuxNiveles04.SetRange(ProductoBase, ProductoBase);
        rAuxNiveles04.SetRange("Nivel", rAuxNiveles04.Nivel::"04 - Nivel");
        if rAuxNiveles04.FindFirst()then repeat rBOMCompN4.Reset();
                rBOMCompN4.SetRange("Parent Item No.", rAuxNiveles04.ItemNo);
                if rBOMCompN4.FindFirst()then repeat rItem04.Reset();
                        rItem04.SetRange("No.", rAuxNiveles04.ItemNo);
                        if rItem04.FindFirst()then;
                        rBOMCompN4.CalcFields("Assembly BOM");
                        rAlxNivel04.TransferFields(rBOMCompN4);
                        rAlxNivel04.ProductoBase:=ProductoBase;
                        rAlxNivel04."Nivel":=Nivel;
                        rAlxNivel04.LineNo:=GetLastLine();
                        rAlxNivel04.Bloqueado:=rItem04.Blocked;
                        rAlxNivel04."Lote receta":=rItem04."Lote Receta";
                        rAlxNivel04."Statistics Lot":=rItem04."Statistics Lot";
                        rAlxNivel04."Statistics Unit of Measurement":=rItem04."Statistics Unit of Measurement";
                        rAlxNivel04."Statistics Unit of Measurement":=rItem04."Statistics Unit of Measurement";
                        rAlxNivel04."Unidad medida Item":=rItem04."Base Unit of Measure";
                        rAlxNivel04.Insert();
                        if rBOMCompN4."Assembly BOM" then begin
                            Nivel05:=true;
                            rAuxNiveles.Reset();
                            rAuxNiveles.ProductoBase:=ProductoBase;
                            rAuxNiveles.ItemNo:=rBOMCompN4."No.";
                            rAuxNiveles.Nivel:=rAuxNiveles.Nivel::"05 - Nivel";
                            rAuxNiveles."Line No.":=GetLastLineAux(ProductoBase);
                            rAuxNiveles.Insert();
                        end;
                    until rBOMCompN4.Next() = 0;
            until rAuxNiveles04.Next() = 0;
        if Nivel05 then GetNivel05(ProductoBase, xNivel::"05 - Nivel");
    end;
    procedure GetNivel05(ProductoBase: Code[20]; Nivel: Option)
    var
        rBOMCompN5: Record "BOM Component";
        rAlxNivel05: Record AlxRecetasNiveles;
        rAuxNiveles05: Record AlxAuxNiveles;
        rItem05: Record Item;
    begin
        rAuxNiveles05.SetRange(ProductoBase, ProductoBase);
        rAuxNiveles05.SetRange("Nivel", rAuxNiveles05.Nivel::"05 - Nivel");
        if rAuxNiveles05.FindFirst()then repeat rBOMCompN5.Reset();
                rBOMCompN5.SetRange("Parent Item No.", rAuxNiveles05.ItemNo);
                if rBOMCompN5.FindFirst()then repeat rItem05.Reset();
                        rItem05.SetRange("No.", rAuxNiveles05.ItemNo);
                        if rItem05.FindFirst()then;
                        rBOMCompN5.CalcFields("Assembly BOM");
                        rAlxNivel05.TransferFields(rBOMCompN5);
                        rAlxNivel05.ProductoBase:=ProductoBase;
                        rAlxNivel05."Nivel":=Nivel;
                        rAlxNivel05.LineNo:=GetLastLine();
                        rAlxNivel05.Bloqueado:=rItem05.Blocked;
                        rAlxNivel05."Lote receta":=rItem05."Lote Receta";
                        rAlxNivel05."Statistics Lot":=rItem05."Statistics Lot";
                        rAlxNivel05."Statistics Unit of Measurement":=rItem05."Statistics Unit of Measurement";
                        rAlxNivel05."Unidad medida Item":=rItem05."Base Unit of Measure";
                        rAlxNivel05.Insert();
                    until rBOMCompN5.Next() = 0;
            until rAuxNiveles05.Next() = 0;
    end;
    procedure GetLastLineAux(ProductoBase: Code[20]): Integer var
        rAuxNiveles: Record AlxAuxNiveles;
    begin
        rAuxNiveles.Reset();
        rAuxNiveles.SetRange(ProductoBase, ProductoBase);
        if rAuxNiveles.FindLast()then exit(rAuxNiveles."Line No." + 1);
        exit(1);
    end;
    procedure GetLastLine(): Integer var
        rNiveles: Record AlxRecetasNiveles;
    begin
        rNiveles.Reset();
        if rNiveles.FindLast()then exit(rNiveles.LineNo + 1);
        exit(1);
    end;
}
