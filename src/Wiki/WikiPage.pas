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
    'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA' + #10
    + 'BBBBBBBBBBBBBBBBBBBB' + #10 +
    'CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC',
    400, 30, 500, 700,
    SKYBLUE, BLACK, BLACK,
    GetFontDefault(), 23, 2, 4
    ), Result.TextBoxes, 0);
end;

end.

