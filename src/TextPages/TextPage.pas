unit TextPage;
{$mode ObjFPC}{$H+}

INTERFACE

uses
  Core,
  Raylib,
  TextPageContent,
  TextBox,
  EntityBox,
  BoxBase;

procedure SetTextPageContent(Text: string);
procedure UpdateTextPageLogic();
procedure DrawTextPage();

IMPLEMENTATION

procedure SetTextPageContent(Text: string);
begin
end;


procedure UpdateTextPageLogic();
begin
end;


procedure DrawTextPage();
const
  RECT: TRectangle = (X: 40; Y: 80; Width: 500; Height: 400);

begin
  ClearBackground(RAYWHITE);
  DrawBoxInside(RECT, SKYBLUE);
  DrawBoxOutline(RECT, BLACK);
end;

end.

