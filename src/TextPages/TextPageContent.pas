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
      ImageBoxes: TEntityBoxes;

      constructor Create();
  end;

IMPLEMENTATION

constructor TTextPageContent.Create();
begin
end;

end.

