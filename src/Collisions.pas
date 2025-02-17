unit Collisions;
{$mode ObjFPC}{$H+}

INTERFACE
  
uses
  Core,
  Raylib;

type
  {
   Origin
     V
     +----------+
    /          /|
   /          / |
  +----------+  |
  |          |  | 
  |          |  |
  |          H  +
  |          | L
  |          |/
  +------W---+

  }
  THitBox = record
    Origin: TVector3;
    Width, Height, Length: real;
  end;

procedure DrawHitBox(box: THitBox; Color: TColor);

IMPLEMENTATION

procedure DrawHitBox(Box: THitBox; Color: TColor);
var
  Center: TVector3;
begin
  With Box do
  begin
    with Origin do
    begin
      Center.X := X - Width  / 2;
      Center.Y := Y - Height / 2;
      Center.Z := Z - Length / 2;
    end;

    DrawCubeWires(Center, Width, Height, Length, Color);
  end;
end;
  
end.
