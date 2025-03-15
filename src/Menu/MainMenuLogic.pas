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
  end;

var
  MenuItems: array of TMenuItem;

procedure UpdateMainMenuLogic;

IMPLEMENTATION

type
  TMenuItemPrototype = record
    Title: string;
  end;

const
  MENU_ITEM_WIDTH = 300;
  MENU_ITEM_HEIGHT = 100;
  MENU_ITEM_GAP = 50;

  MENU_ITEM_PROTOTYPES: array of TMenuItemPrototype = (
    (Title: 'PLAY'),
    (Title: 'WIKI'),
    (Title: 'MANUAL'),
    (Title: 'CREDDITS'),
    (Title: 'EXIT')
  );

procedure InitMenuItems;
var
  I, YStart: integer;

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


procedure HandleSelection;
begin
end;


procedure HandleActivation;
begin
end;


procedure UpdateMainMenuLogic;
begin
  HandleSelection;
  HandleActivation;
end;

INITIALIZATION
  InitMenuItems;

end.
