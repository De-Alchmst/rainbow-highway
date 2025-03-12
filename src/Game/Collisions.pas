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

procedure DrawHitBox(Box: THitBox);
function IsCollideHitBox(Box1, Box2 : THitBox): boolean;

IMPLEMENTATION

// AABB (Axis-Aligned Bounding Box) collision detection
function IsCollideHitBox(Box1, Box2 : THitBox): boolean;
var
  Box1Min, Box1Max, Box2Min, Box2Max: TVector3;
begin
  // Calculate min/max points for both boxes
  with Box1, Box1Min do
  begin
    X := Origin.X - Width;
    Y := Origin.Y - Height;
    Z := Origin.Z - Length;
  end;

  with Box1, Box1Max do
  begin
    X := Origin.X;
    Y := Origin.Y;
    Z := Origin.Z;
  end;

  with Box2, Box2Min do
  begin
    X := Origin.X - Width;
    Y := Origin.Y - Height;
    Z := Origin.Z - Length;
  end;

  with Box2, Box2Max do
  begin
    X := Origin.X;
    Y := Origin.Y;
    Z := Origin.Z;
  end;

  // Check for overlap on all axes
  Result := (Box1Min.X <= Box2Max.X) and (Box1Max.X >= Box2Min.X) and
            (Box1Min.Y <= Box2Max.Y) and (Box1Max.Y >= Box2Min.Y) and
            (Box1Min.Z <= Box2Max.Z) and (Box1Max.Z >= Box2Min.Z);
end;

procedure DrawHitBox(Box: THitBox);
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

    DrawCubeWires(Center, Width, Height, Length, LIME);
    DrawSphere(Origin, 1.2, RED);
  end;
end;
  
end.
