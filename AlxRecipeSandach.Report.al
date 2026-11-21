report 50015 AlxRecipeSandach
{
  ApplicationArea = All;
  Caption = 'Sandach in Recipes and Subrecipes';
  UsageCategory = ReportsAndAnalysis;
  DefaultRenderingLayout = RecipeLayout;

  dataset
  {
    dataitem(RecipeRow; Integer)
    {
      DataItemTableView = sorting(Number);

      column(ReportTitle; ReportTitleLbl) { }
      column(LevelCaption; LevelLbl) { }
      column(ParentCaption; ParentLbl) { }
      column(ItemCaption; ItemLbl) { }
      column(DescriptionCaption; DescriptionLbl) { }
      column(SandachCaption; SandachLbl) { }
      column(ReplenishmentCaption; ReplenishmentLbl) { }
      column(NoteCaption; NoteLbl) { }
      column(RecipeLevel; Levels.Get(Number)) { }
      column(ParentNo; Parents.Get(Number)) { }
      column(ItemNo; Items.Get(Number)) { }
      column(ItemDescription; Descriptions.Get(Number)) { }
      column(Sandach; SandachValues.Get(Number)) { }
      column(Replenishment; Replenishments.Get(Number)) { }
      column(RowNote; Notes.Get(Number)) { }

      trigger OnPreDataItem()
      begin
        SetRange(Number, 1, Items.Count());
      end;
    }
  }

  requestpage
  {
    layout
    {
      area(Content)
      {
        group(Options)
        {
          Caption = 'Options';

          field(RootItemNo; RootItemNo)
          {
            ApplicationArea = All;
            Caption = 'Recipe Item No.';
            TableRelation = Item."No.";
            ToolTip = 'Specifies the item whose recipe and subrecipes will be listed.';
          }
        }
      }
    }
  }

  rendering
  {
    layout(RecipeLayout)
    {
      Type = RDLC;
      LayoutFile = './src/Layout/AlxRecipeSandach.rdl';
      Caption = 'Sandach in Recipes and Subrecipes';
    }
  }

  trigger OnPreReport()
  begin
    if RootItemNo = '' then
      Error(SelectItemErr);

    CollectRecipe();
  end;

  var
    RootItemNo: Code[20];
    Levels: List of [Integer];
    Parents: List of [Code[20]];
    Items: List of [Code[20]];
    Descriptions: List of [Text];
    SandachValues: List of [Text];
    Replenishments: List of [Text];
    Notes: List of [Text];
    ReportTitleLbl: Label 'Sandach in Recipes and Subrecipes';
    LevelLbl: Label 'Level';
    ParentLbl: Label 'Parent Item';
    ItemLbl: Label 'Item No.';
    DescriptionLbl: Label 'Description';
    SandachLbl: Label 'Sandach';
    ReplenishmentLbl: Label 'Replenishment System';
    NoteLbl: Label 'Notes';
    YesLbl: Label 'Yes';
    NoLbl: Label 'No';
    CycleLbl: Label 'Circular reference. This branch was not expanded.';
    SelectItemErr: Label 'Select a recipe item.';
    MissingItemErr: Label 'Item %1 could not be found while reviewing the recipe. Parent item: %2.', Comment = '%1 = item number, %2 = parent item number (blank for the root)';

  local procedure CollectRecipe()
  var
    RecipeItem: Record Item;
    PendingItems: List of [Code[20]];
    PendingLevels: List of [Integer];
    ActivePath: List of [Code[20]];
    ItemNo: Code[20];
    ParentNo: Code[20];
    Level: Integer;
    StackIndex: Integer;
    IsCycle: Boolean;
  begin
    PendingItems.Add(RootItemNo);
    PendingLevels.Add(0);
    RecipeItem.SetLoadFields(Description, AGRALASandach, "Replenishment System");

    while PendingItems.Count() > 0 do begin
      StackIndex := PendingItems.Count();
      ItemNo := PendingItems.Get(StackIndex);
      Level := PendingLevels.Get(StackIndex);
      PendingItems.RemoveAt(StackIndex);
      PendingLevels.RemoveAt(StackIndex);

      // Discard the previous branch's descendants, keeping only the current ancestors.
      while ActivePath.Count() > Level do
        ActivePath.RemoveAt(ActivePath.Count());
      Clear(ParentNo);
      if Level > 0 then
        ParentNo := ActivePath.Get(Level);

      if not RecipeItem.Get(ItemNo) then
        Error(MissingItemErr, ItemNo, ParentNo);
      IsCycle := ActivePath.Contains(ItemNo);
      AddRow(RecipeItem, ParentNo, Level, IsCycle);

      if not IsCycle then begin
        ActivePath.Add(ItemNo);
        PushComponents(ItemNo, Level + 1, PendingItems, PendingLevels);
      end;
    end;
  end;

  local procedure PushComponents(ParentNo: Code[20]; Level: Integer; var PendingItems: List of [Code[20]]; var PendingLevels: List of [Integer])
  var
    Component: Record "BOM Component";
  begin
    Component.SetLoadFields("No.");
    Component.SetCurrentKey("Parent Item No.", "Line No.");
    Component.Ascending(false);
    Component.SetRange("Parent Item No.", ParentNo);
    Component.SetRange(Type, Component.Type::Item);
    if Component.FindSet() then
      repeat
        PendingItems.Add(Component."No.");
        PendingLevels.Add(Level);
      until Component.Next() = 0;
  end;

  local procedure AddRow(RecipeItem: Record Item; ParentNo: Code[20]; Level: Integer; IsCycle: Boolean)
  begin
    Levels.Add(Level);
    Parents.Add(ParentNo);
    Items.Add(RecipeItem."No.");
    Descriptions.Add(RecipeItem.Description);
    if RecipeItem.AGRALASandach then
      SandachValues.Add(YesLbl)
    else
      SandachValues.Add(NoLbl);
    Replenishments.Add(Format(RecipeItem."Replenishment System"));
    if IsCycle then
      Notes.Add(CycleLbl)
    else
      Notes.Add('');
  end;
}
