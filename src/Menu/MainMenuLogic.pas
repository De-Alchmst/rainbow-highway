unit MainMenuLogic;
{$mode ObjFPC}{$H+}

INTERFACE

uses
  Raylib,
  Core,
  GameStateHandle;

type
  TMenuItem = record
    Title: string;
    IsSelected: boolean;
    Rect: TRectangle;
    SetGameState: TGameState;
  end;

var
  MenuItems: array of TMenuItem;

procedure UpdateMainMenuLogic;

IMPLEMENTATION

type
  TMenuItemPrototype = record
    Title: string;
    SetGameState: TGameState;
  end;

const
  MENU_ITEM_WIDTH = 250;
  MENU_ITEM_HEIGHT = 80;
  MENU_ITEM_GAP = 20;

  MENU_ITEM_PROTOTYPES: array of TMenuItemPrototype = (
    (Title: 'PLAY'; SetGameState: Game),
    (Title: 'WIKI'; SetGameState: Wiki),
    (Title: 'MANUAL'; SetGameState: Manual),
    (Title: 'CREDITS'; SetGameState: Credits),
    (Title: 'EXIT'; SetGameState: Exit)
  );

var
  SelectedIndex: integer = 0;


procedure InitMenuItems;
var
  I, YStart : integer;

const
  X_START = WINDOW_WIDTH div 2 - MENU_ITEM_WIDTH div 2;

begin
  YStart := (WINDOW_HEIGHT
             - length(MENU_ITEM_PROTOTYPES) * (MENU_ITEM_HEIGHT + MENU_ITEM_GAP) 
             + MENU_ITEM_GAP) div 2;

  setLength(MenuItems, length(MENU_ITEM_PROTOTYPES));

  for I := 0 to length(MENU_ITEM_PROTOTYPES)-1 do
    with MenuItems[I] do
    begin

      Title := MENU_ITEM_PROTOTYPES[I].Title;
      SetGameState := MENU_ITEM_PROTOTYPES[I].SetGameState;
      IsSelected := false;

      with Rect do
      begin
        X := X_START;
        Y := YStart + I * (MENU_ITEM_HEIGHT + MENU_ITEM_GAP);
        Width := MENU_ITEM_WIDTH;
        Height := MENU_ITEM_HEIGHT;
      end;
    end;
end;


function IsMouseMoved: boolean;
var
  Vect: TVector2;
begin
  Vect := GetMouseDelta;
  Result := (Vect.X <> 0) and (Vect.Y <> 0);
end;


procedure SetSelection;
var
  I: integer;

begin
  for I := 0 to length(MenuItems)-1 do
  if I = SelectedIndex then
    MenuItems[I].IsSelected := true
  else
    MenuItems[I].IsSelected := false;
end;


procedure HandleSelectionKeys;
begin
  // DOWN
  // if IsKeyPressed(KEY_S) or IsKeyPressed(KEY_DOWN) then
  //   SelectedIndex := (SelectedIndex + 1) mod length(MenuItems);

  // // UP
  // if IsKeyPressed(KEY_W) or IsKeyPressed(KEY_UP) then
  // begin
  //   dec(SelectedIndex);
  //   if SelectedIndex < 0 then
  //     SelectedIndex := length(MenuItems)-1;
  // end;
end;


procedure HandleSelectionMouse;
var
  I: integer;
  MPos: TVector2;

begin
  if IsMouseMoved then
  begin
    MPos := GetMousePosition;

    for I := 0 to length(MenuItems)-1 do
      if CheckCollisionPointRec(MPos, MenuItems[I].Rect) then
      begin
        SelectedIndex := I;
        break;
      end;
  end;
end;


procedure HandleSelection;
begin
  HandleSelectionKeys;
  HandleSelectionMouse;
  SetSelection;
end;


procedure HandleActivation;
begin
  if IsKeyPressed(KEY_ENTER) or IsMouseButtonPressed(MOUSE_BUTTON_RIGHT) then
    GameState := MenuItems[SelectedIndex].SetGameState;
end;


procedure UpdateMainMenuLogic;
begin
  HandleSelection;
  HandleActivation;
end;

INITIALIZATION
  InitMenuItems;

end.
