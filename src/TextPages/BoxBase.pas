unit BoxBase;
{$mode ObjFPC}{$H+}

INTERFACE

uses
  Core,
  Raylib;

procedure DrawBoxOutline(Box: TRectangle; Color: TColor; Thick: real = 7);
procedure DrawBoxInside(Box: TRectangle; Color: TColor);

IMPLEMENTATION

const
  CUT_WIDTH = 25;


procedure DrawBoxOutline(Box: TRectangle; Color: TColor; Thick: real = 7);
var
  Off, OffDiv : real;

begin
  Off := Thick / 2;
  OffDiv := Off / 2;

  with Box do
  begin
    DrawLineExPoints(X - Off, Y,
                     X + Width - CUT_WIDTH, Y,
                     Thick, Color);
    DrawLineExPoints(X + Width - CUT_WIDTH - OffDiv, Y - OffDiv,
                     X + Width + OffDiv, Y + CUT_WIDTH + OffDiv,
                     Thick, Color);
    DrawLineExPoints(X + Width, Y + CUT_WIDTH,
                     X + Width, Y + Height + Off,
                     Thick, Color);
    DrawLineExPoints(X + Width, Y + Height,
                     X + CUT_WIDTH, Y + Height,
                     Thick, Color);
    DrawLineExPoints(X + CUT_WIDTH + OffDiv, Y + Height + OffDiv,
                     X - OffDiv, Y + Height - CUT_WIDTH - OffDiv,
                     Thick, Color);
    DrawLineExPoints(X, Y + Height - CUT_WIDTH,
                     X, Y,
                     Thick, Color);
  end;
end;


procedure DrawBoxInside(Box: TRectangle; Color: TColor);
var
  VectA, VectB, VectC : TVector2;

begin
  with Box do
  begin
    DrawRectangleF(X, Y, Width - CUT_WIDTH, Height - CUT_WIDTH, Color);
    DrawRectangleF(X + Width - CUT_WIDTH, Y + CUT_WIDTH,
                   CUT_WIDTH, Height - CUT_WIDTH, Color);
    DrawRectangleF(X + CUT_WIDTH, Y + Height - CUT_WIDTH,
                   Width - CUT_WIDTH, CUT_WIDTH, Color);

    VectA.X := X + Width - CUT_WIDTH;
    VectA.Y := Y;
    VectB.X := X + Width - CUT_WIDTH;
    VectB.Y := Y + CUT_WIDTH;
    VectC.X := X + Width;
    VectC.Y := Y + CUT_WIDTH;
    DrawTriangle(VectA, VectB, VectC, Color);

    VectA.X := X + CUT_WIDTH;
    VectA.Y := Y + Height;
    VectB.X := X + CUT_WIDTH;
    VectB.Y := Y + Height - CUT_WIDTH;
    VectC.X := X;
    VectC.Y := Y + Height - CUT_WIDTH;
    DrawTriangle(VectA, VectB, VectC, Color);
  end;
end;

end.

