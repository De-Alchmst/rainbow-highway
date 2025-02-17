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
begin
  With Box do
    DrawCubeWires(Origin, Width, Height, Length, Color);
end;
  
end.
