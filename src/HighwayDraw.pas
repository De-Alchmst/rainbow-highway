unit HighwayDraw;
{$mode ObjFPC}{$H+}

INTERFACE

uses
  Raylib,
  Core,
  HighwayLogic;

procedure DrawHighway;

IMPLEMENTATION

var
  BGColor : TColor;

procedure DrawHighway;
begin
  ClearBackground(BGColor);
end;

INITIALIZATION

  BGColor := BLACK;

end.
