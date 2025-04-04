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

procedure InitTextPages;
procedure SetTextPageContent(New: TTextPageContent);
procedure UpdateTextPageLogic;
procedure DrawTextPage;

IMPLEMENTATION

var
  PageContent: TTextPageContent;

procedure InitTextPages;
begin
  InitTextBox;
end;

procedure SetTextPageContent(New: TTextPageContent);
begin
  PageContent := New;
end;


procedure UpdateTextPageLogic;
begin
  PageContent.Update;
end;


procedure DrawTextPage;
begin
  ClearBackground(RAYWHITE);
  PageContent.Draw;
end;

end.

