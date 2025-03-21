unit TextBox;
{$mode ObjFPC}{$H+}

INTERFACE

uses
  Core,
  Raylib;

type
  TTextBox = class
    public
      constructor Create();
  end;

  TTextBoxes = array of TTextBox;

IMPLEMENTATION

constructor TTextBox.Create();
begin
end;

end.

