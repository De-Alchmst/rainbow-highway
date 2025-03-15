unit MainMenuDraw;
{$mode ObjFPC}{$H+}

INTERFACE

uses
  Core,
  Raylib,
  MainMenuLogic;

procedure DrawMainMenu;

IMPLEMENTATION

const
  FONT_SIZE = 50;

procedure DrawMenuItemText(Item: TMenuItem);
var
  Length, X, Y : integer;

begin
  with Item do
  begin
    Length := MeasureText(Title, FONT_SIZE);
    X := trunc(Rect.X + (Rect.Width - Length) / 2);
    Y := trunc(Rect.Y + (Rect.Height - FONT_SIZE) / 2);

    DrawText(Title, X, Y, FONT_SIZE, WHITE);
  end;
end;


procedure DrawMenuItem(Item: TMenuItem);
begin
  with Item do
  begin
    DrawRectangleGradientEx(Rect, PINK, SKYBLUE, SKYBLUE, PINK);
    DrawMenuItemText(Item);

    if IsSelected then DrawRectangleLinesEx(Rect, 4, VIOLET)
    else               DrawRectangleLinesEx(Rect, 4, GRAY);
  end;
end;


procedure DrawMenuItems;
var
  Item: TMenuItem;

begin
  for Item in MenuItems do
    DrawMenuItem(Item);
end;


procedure DrawMainMenu;
begin
  ClearBackground(BEIGE);

  DrawMenuItems;
end;

end.
