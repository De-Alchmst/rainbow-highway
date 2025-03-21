unit WikiPage;
{$mode ObjFPC}{$H+}

INTERFACE

uses
  Core,
  Raylib,
  TextBox,
  TextPageContent;

function GetWikiTextPageContent: TTextPageContent;

IMPLEMENTATION

function GetWikiTextPageContent: TTextPageContent;
begin
  Result := TTextPageContent.Create;
  insert(TTextBox.Create(
    'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA',
    400, 30, 500, 700,
    SKYBLUE, BLACK, BLACK,
    20
    ), Result.TextBoxes, 0);
end;

end.

