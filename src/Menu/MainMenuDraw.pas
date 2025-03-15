unit MainMenuDraw;
{$mode ObjFPC}{$H+}

INTERFACE

uses
  Core,
  Raylib,
  MainMenuLogic;

procedure DrawMainMenu;

IMPLEMENTATION


procedure DrawMenuItem(Item: TMenuItem);
begin
  with Item do
  begin
    DrawRectangleGradientEx(Rect, PINK, SKYBLUE, SKYBLUE, PINK);

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
