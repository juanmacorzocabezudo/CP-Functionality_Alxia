#if CP_EVENT_TESTS
codeunit 80000 "Child Event Line Tests"
{
  Subtype = Test;
  TestPermissions = Disabled;

  var
    Assert: Codeunit "Library Assert";
    LibraryInventory: Codeunit "Library - Inventory";
    LibrarySales: Codeunit "Library - Sales";
    LibraryERM: Codeunit "Library - ERM";

  [Test]
  procedure GivenNoChildren_WhenSelectingItem_ThenQuantityIsOne()
  var
    Event: Record Evento;
    EventLine: Record "Lineas Evento";
    Recipe: Record Item;
  begin
    CreateFixture(Event, EventLine, Recipe, 0, 0);
    EventLine.Tipo := EventLine.Tipo::Niño;
    EventLine.CantidadComensales := 99;
    EventLine.ImportePorPersona := 99;

    EventLine.Validate("No.", Recipe."No.");

    Assert.AreEqual(EventLine.Tipo::Niño, EventLine.Tipo, 'The line must remain a child line.');
    Assert.AreEqual(1, EventLine.Cantidad, 'Initial quantity must be one.');
    Assert.AreEqual(0, EventLine.CantidadComensales, 'Diner count must not retain a previous value.');
    Assert.AreEqual(0, EventLine.ImportePorPersona, 'Amount per person must be zero without children.');
    VerifyTotals(Event, 0, 0);
  end;

  [Test]
  procedure GivenChildren_WhenSelectingItem_ThenQuantityIsOne()
  var
    Event: Record Evento;
    EventLine: Record "Lineas Evento";
    Recipe: Record Item;
  begin
    CreateFixture(Event, EventLine, Recipe, 5, 8);
    EventLine.Tipo := EventLine.Tipo::Niño;

    EventLine.Validate("No.", Recipe."No.");

    Assert.AreEqual(1, EventLine.Cantidad, 'Initial child quantity must not be copied from event totals.');
    VerifyTotals(Event, 5, 8);
  end;

  [Test]
  procedure GivenNoChildren_WhenChangingQuantity_ThenAmountsRecalculate()
  var
    Event: Record Evento;
    EventLine: Record "Lineas Evento";
    Recipe: Record Item;
  begin
    CreateFixture(Event, EventLine, Recipe, 0, 0);
    EventLine.Tipo := EventLine.Tipo::Niño;
    EventLine.Validate("No.", Recipe."No.");
    EventLine.Validate("Precio Real", 10);
    EventLine.Modify(false);

    EventLine.Validate(Cantidad, 3);

    Assert.AreEqual(3, EventLine.Cantidad, 'Quantity must remain editable.');
    Assert.AreEqual(30, EventLine.Importe, 'Amount must equal quantity times price.');
    Assert.AreEqual(33, EventLine."Importe IVA Incl.", 'VAT-inclusive amount must use the new quantity.');
    Assert.AreEqual(11, EventLine."Precio IVA Incl.", 'VAT-inclusive unit price must remain consistent.');
    Assert.AreEqual(0, EventLine.ImportePorPersona, 'Zero children must not cause division by zero.');
    VerifyTotals(Event, 0, 0);
  end;

  [Test]
  procedure GivenNoChildren_WhenQuantityIsZero_ThenAmountsClear()
  var
    Event: Record Evento;
    EventLine: Record "Lineas Evento";
    Recipe: Record Item;
  begin
    CreateFixture(Event, EventLine, Recipe, 0, 0);
    EventLine.Tipo := EventLine.Tipo::Niño;
    EventLine.Validate("No.", Recipe."No.");
    EventLine.Validate("Precio Real", 10);
    EventLine.Modify(false);
    EventLine.ImportePorPersona := 99;

    EventLine.Validate(Cantidad, 0);

    Assert.AreEqual(0, EventLine.Importe, 'Zero quantity must clear the amount.');
    Assert.AreEqual(0, EventLine."Importe IVA Incl.", 'Zero quantity must clear the VAT-inclusive amount.');
    Assert.AreEqual(0, EventLine.ImportePorPersona, 'Amount per person must not retain a previous value.');
    VerifyTotals(Event, 0, 0);
  end;

  [Test]
  procedure GivenNoDiners_WhenCalculatingCosts_ThenChildQuantityIsUsed()
  var
    Event: Record Evento;
    EventLine: Record "Lineas Evento";
    Recipe: Record Item;
  begin
    CreateFixture(Event, EventLine, Recipe, 0, 0);
    EventLine.Tipo := EventLine.Tipo::Niño;
    EventLine.Validate("No.", Recipe."No.");
    EventLine.Validate(Cantidad, 2);
    EventLine."Coste Total Unitario" := 99;
    EventLine."Precio Propuesto" := 99;
    EventLine."Tipo Margen" := EventLine."Tipo Margen"::Porcentaje;
    EventLine."Valor Margen" := 25;
    EventLine.Modify(false);
    CreateComponent(EventLine, Recipe, 8);

    Event.gfu_CalculoCostesPrecios();
    EventLine.Get(EventLine."Codigo Evento", EventLine.Linea);

    Assert.AreEqual(8, EventLine."Coste Directo", 'Direct cost must reflect event components.');
    Assert.AreEqual(8, EventLine."Coste Total", 'Total cost must not retain a previous value.');
    Assert.AreEqual(4, EventLine."Coste Total Unitario", 'Without children, unit cost must use line quantity.');
    Assert.AreEqual(5, EventLine."Precio Propuesto", 'Percentage margin must use the updated unit cost.');
    EventLine."Tipo Margen" := EventLine."Tipo Margen"::Importe;
    EventLine."Valor Margen" := 2;
    EventLine.Modify(false);
    Event.gfu_CalculoCostesPrecios();
    EventLine.Get(EventLine."Codigo Evento", EventLine.Linea);
    Assert.AreEqual(6, EventLine."Precio Propuesto", 'Amount margin must use the updated unit cost.');
    VerifyTotals(Event, 0, 0);
  end;

  [Test]
  procedure GivenZeroChildQuantity_WhenCalculatingCosts_ThenUnitCostClears()
  var
    Event: Record Evento;
    EventLine: Record "Lineas Evento";
    Recipe: Record Item;
  begin
    CreateFixture(Event, EventLine, Recipe, 5, 0);
    EventLine.Tipo := EventLine.Tipo::Niño;
    EventLine.Validate("No.", Recipe."No.");
    EventLine.Validate(Cantidad, 0);
    EventLine."Coste Total Unitario" := 99;
    EventLine."Precio Propuesto" := 99;
    EventLine.Modify(false);

    Event.gfu_CalculoCostesPrecios();
    EventLine.Get(EventLine."Codigo Evento", EventLine.Linea);

    Assert.AreEqual(0, EventLine."Coste Total Unitario", 'Zero denominators must clear unit cost.');
    Assert.AreEqual(0, EventLine."Precio Propuesto", 'Percentage margin must not use stale unit cost.');
    VerifyTotals(Event, 5, 0);
  end;

  [Test]
  procedure GivenAdults_WhenSelectingItem_ThenAdultBehaviorIsPreserved()
  var
    Event: Record Evento;
    EventLine: Record "Lineas Evento";
    Recipe: Record Item;
  begin
    CreateFixture(Event, EventLine, Recipe, 5, 0);
    EventLine.Tipo := EventLine.Tipo::Adulto;

    EventLine.Validate("No.", Recipe."No.");
    EventLine.Validate("Precio Real", 10);

    Assert.AreEqual(5, EventLine.Cantidad, 'Adult quantity must still use total adults.');
    Assert.AreEqual(5, EventLine.CantidadComensales, 'Adult diner count must remain unchanged.');
    Assert.AreEqual(50, EventLine.Importe, 'Adult amount must remain unchanged.');
    Assert.AreEqual(10, EventLine.ImportePorPersona, 'Adult amount per person must remain unchanged.');
    VerifyTotals(Event, 5, 0);
  end;

  [Test]
  procedure GivenNoAdults_WhenSelectingAdultItem_ThenValidationStillFails()
  var
    Event: Record Evento;
    EventLine: Record "Lineas Evento";
    Recipe: Record Item;
  begin
    CreateFixture(Event, EventLine, Recipe, 0, 5);
    EventLine.Tipo := EventLine.Tipo::Adulto;

    asserterror EventLine.Validate("No.", Recipe."No.");

    Assert.ExpectedErrorCode('TestField');
    VerifyTotals(Event, 0, 5);
  end;

  [Test]
  procedure GivenDiners_WhenSelectingOtherItem_ThenOtherBehaviorIsPreserved()
  var
    Event: Record Evento;
    EventLine: Record "Lineas Evento";
    Recipe: Record Item;
  begin
    CreateFixture(Event, EventLine, Recipe, 5, 3);
    EventLine.Tipo := EventLine.Tipo::Otros;

    EventLine.Validate("No.", Recipe."No.");
    EventLine.Validate("Precio Real", 10);

    Assert.AreEqual(8, EventLine.Cantidad, 'Other quantity must still use total diners.');
    Assert.AreEqual(16, EventLine.Bocados, 'Other bites must still use bites per diner.');
    Assert.AreEqual(80, EventLine.Importe, 'Other amount must remain unchanged.');
    Assert.AreEqual(10, EventLine.ImportePorPersona, 'Other amount per person must remain unchanged.');
    VerifyTotals(Event, 5, 3);
  end;

  [Test]
  procedure GivenNoDiners_WhenSelectingOtherItem_ThenValidationStillFails()
  var
    Event: Record Evento;
    EventLine: Record "Lineas Evento";
    Recipe: Record Item;
  begin
    CreateFixture(Event, EventLine, Recipe, 0, 0);
    EventLine.Tipo := EventLine.Tipo::Otros;

    asserterror EventLine.Validate("No.", Recipe."No.");

    Assert.ExpectedErrorCode('Dialog');
    VerifyTotals(Event, 0, 0);
  end;

  local procedure CreateFixture(var Event: Record Evento; var EventLine: Record "Lineas Evento"; var Recipe: Record Item; Adults: Integer; Children: Integer)
  var
    Customer: Record Customer;
    VATPostingSetup: Record "VAT Posting Setup";
    GeneralLedgerSetup: Record "General Ledger Setup";
    SalesSetup: Record "Sales & Receivables Setup";
    Chapter: Record AlxImpresionCapitulos;
  begin
    GeneralLedgerSetup.Get();
    GeneralLedgerSetup."Amount Rounding Precision" := 0.01;
    GeneralLedgerSetup.Modify(false);
    SalesSetup.Get();
    SalesSetup."Calcular coste Cantidad" := false;
    SalesSetup.Modify(false);
    LibraryERM.CreateVATPostingSetupWithAccounts(VATPostingSetup, VATPostingSetup."VAT Calculation Type"::"Normal VAT", 10);
    LibrarySales.CreateCustomer(Customer);
    Customer.Validate("VAT Bus. Posting Group", VATPostingSetup."VAT Bus. Posting Group");
    Customer.Modify(true);
    LibraryInventory.CreateItem(Recipe);
    Recipe."Lote Receta" := 1;
    Recipe."Bocados por comensal" := 2;
    Recipe.Validate("VAT Prod. Posting Group", VATPostingSetup."VAT Prod. Posting Group");
    Recipe.Modify(true);
    Event.Init();
    Event."Codigo Evento" := CopyStr(DelChr(Format(CreateGuid()), '=', '{}-'), 1, MaxStrLen(Event."Codigo Evento"));
    Event."Codigo Cliente" := Customer."No.";
    Event."Total Adultos" := Adults;
    Event."Total Ninos" := Children;
    Event.Insert(false);
    if not Chapter.Get('NIÑOS') then begin
      Chapter.Code := 'NIÑOS';
      Chapter.Descripcion := 'Child menu';
      Chapter.Insert(false);
    end;
    EventLine.Init();
    EventLine."Codigo Evento" := Event."Codigo Evento";
    EventLine.Linea := 10000;
    EventLine.Insert(false);
    EventLine.Validate(ImprCapitulo, 'NIÑOS');
  end;

  local procedure CreateComponent(EventLine: Record "Lineas Evento"; Recipe: Record Item; Cost: Decimal)
  var
    Component: Record "Componentes Evento";
  begin
    Component.Init();
    Component."Codigo Evento" := EventLine."Codigo Evento";
    Component."Linea Evento" := EventLine.Linea;
    Component."Parent Item No." := Recipe."No.";
    Component."Line No." := 10000;
    Component.Type := Component.Type::Item;
    Component."Coste Lote" := Cost;
    Component.Insert(false);
  end;

  local procedure VerifyTotals(var Event: Record Evento; Adults: Integer; Children: Integer)
  begin
    Event.Get(Event."Codigo Evento");
    Assert.AreEqual(Adults, Event."Total Adultos", 'Adult total must not change.');
    Assert.AreEqual(Children, Event."Total Ninos", 'Child total must not change.');
  end;
}
#endif