unit EntityBox;
{$mode ObjFPC}{$H+}

INTERFACE

uses
  Core,
  Raylib,
  EntityBase;

type
  TEntityBox = class
    public
      constructor Create();
  end;

  TEntityBoxes = array of TEntityBox;

IMPLEMENTATION

constructor TEntityBox.Create();
begin
end;

end.

