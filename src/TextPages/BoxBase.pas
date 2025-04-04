unit BoxBase;
{$mode ObjFPC}{$H+}

INTERFACE

uses
  Core,
  Raylib;

const
  BOX_CUT_WIDTH = 25;

procedure DrawBoxOutline(Box: TRectangle; Color: TColor; Thick: real = 7);
procedure DrawBoxInside(Box: TRectangle; Color: TColor);
procedure TrimImageToBox(var Image: TImage; Box: TRectangle);

IMPLEMENTATION


procedure DrawBoxOutline(Box: TRectangle; Color: TColor; Thick: real = 7);
var
  Off, OffDiv : real;

begin
  Off := Thick / 2;
  OffDiv := Off / 2;

  with Box do
  begin
    DrawLineExPoints(X - Off, Y,
                     X + Width - BOX_CUT_WIDTH, Y,
                     Thick, Color);
    DrawLineExPoints(X + Width - BOX_CUT_WIDTH - OffDiv, Y - OffDiv,
                     X + Width + OffDiv, Y + BOX_CUT_WIDTH + OffDiv,
                     Thick, Color);
    DrawLineExPoints(X + Width, Y + BOX_CUT_WIDTH,
                     X + Width, Y + Height + Off,
                     Thick, Color);
    DrawLineExPoints(X + Width, Y + Height,
                     X + BOX_CUT_WIDTH, Y + Height,
                     Thick, Color);
    DrawLineExPoints(X + BOX_CUT_WIDTH + OffDiv, Y + Height + OffDiv,
                     X - OffDiv, Y + Height - BOX_CUT_WIDTH - OffDiv,
                     Thick, Color);
    DrawLineExPoints(X, Y + Height - BOX_CUT_WIDTH,
                     X, Y,
                     Thick, Color);
  end;
end;


procedure TrimImageToBox(var Image: TImage; Box: TRectangle);
var
  v1, v2, v3 : TVector2;
begin
  // Top Right
  v1.X := Box.Width - BOX_CUT_WIDTH;
  v1.Y := 0;
  v2.X := Box.Width;
  v2.Y := 0;
  v3.X := Box.Width;
  v3.Y := BOX_CUT_WIDTH;

  ImageDrawTriangle(@Image, v1, v2, v3, TRANSPARENT_PURPLE);

  // Bottom Left
  v1.X := 0;
  v1.Y := Box.Height - BOX_CUT_WIDTH;
  v2.X := BOX_CUT_WIDTH;
  v2.Y := Box.Height;
  v3.X := 0;
  v3.Y := Box.Height;

  ImageDrawTriangle(@Image, v1, v2, v3, TRANSPARENT_PURPLE);
end;


procedure DrawBoxInside(Box: TRectangle; Color: TColor);
var
  VectA, VectB, VectC : TVector2;

begin
  with Box do
  begin
    DrawRectangleF(X, Y, Width - BOX_CUT_WIDTH, Height - BOX_CUT_WIDTH, Color);
    DrawRectangleF(X + Width - BOX_CUT_WIDTH, Y + BOX_CUT_WIDTH,
                   BOX_CUT_WIDTH, Height - BOX_CUT_WIDTH, Color);
    DrawRectangleF(X + BOX_CUT_WIDTH, Y + Height - BOX_CUT_WIDTH,
                   Width - BOX_CUT_WIDTH, BOX_CUT_WIDTH, Color);

    VectA.X := X + Width - BOX_CUT_WIDTH;
    VectA.Y := Y;
    VectB.X := X + Width - BOX_CUT_WIDTH;
    VectB.Y := Y + BOX_CUT_WIDTH;
    VectC.X := X + Width;
    VectC.Y := Y + BOX_CUT_WIDTH;
    DrawTriangle(VectA, VectB, VectC, Color);

    VectA.X := X + BOX_CUT_WIDTH;
    VectA.Y := Y + Height;
    VectB.X := X + BOX_CUT_WIDTH;
    VectB.Y := Y + Height - BOX_CUT_WIDTH;
    VectC.X := X;
    VectC.Y := Y + Height - BOX_CUT_WIDTH;
    DrawTriangle(VectA, VectB, VectC, Color);
  end;
end;

end.

