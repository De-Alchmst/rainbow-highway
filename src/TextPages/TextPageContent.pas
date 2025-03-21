unit TextPageContent;
{$mode ObjFPC}{$H+}

INTERFACE

uses
  Core,
  Raylib,
  TextBox,
  EntityBox;

type
  TTextPageContent = class
    public
      TextBoxes: TTextBoxes;
      EntityBoxes: TEntityBoxes;

      constructor Create;
      procedure Update;
      procedure Draw;
  end;

IMPLEMENTATION

constructor TTextPageContent.Create;
begin
end;


procedure TTextPageContent.Update;
var
  TextBox: TTextBox;
  EntityBox: TEntityBox;

begin
  for TextBox in  TextBoxes do
    TextBox.Update;
end;


procedure TTextPageContent.Draw;
var
  TextBox: TTextBox;
  EntityBox: TEntityBox;

begin
  for TextBox in  TextBoxes do
    TextBox.Draw;
end;

end.

