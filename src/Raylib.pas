unit Raylib;
{$mode ObjFPC}{$H+}

INTERFACE

{$linklib libraylib}

uses ctypes;

type

  TColor = record
    r, g, b, a : byte;
  end; 

  TRectangle = record
    x, y, width, height : cfloat;
  end;

  TVector2 = record
    x, y : cfloat;
  end;

  TVector3 = record
    x, y, z : cfloat;
  end;

  TVector4 = record
    x, y, z, w : cfloat;
  end;

  TCameraProjection = (
    CAMERA_PERSPECTIVE,
    CAMERA_ORTOGRAPHIC
  );

  TCamera3D = record
    position, target, up : TVector3;
    fovy: cfloat;
    projection: TCameraProjection;
  end;

  TCameraMode = (
    CAMERA_CUSTOM,
    CAMERA_FREE,
    CAMERA_ORBITAL,
    CAMERA_FIRST_PERSON,
    CAMERA_THIRD_PERSON
  );

const
  LIGHTGRAY: TColor = (r: 200; g: 200; b: 200; a: 255); // Light Gray
  GRAY:      TColor = (r: 130; g: 130; b: 130; a: 255); // Gray
  DARKGRAY:  TColor = (r: 80;  g: 80;  b: 80;  a: 255); // Dark Gray
  YELLOW:    TColor = (r: 253; g: 249; b: 0;   a: 255); // Yellow
  GOLD:      TColor = (r: 255; g: 203; b: 0;   a: 255); // Gold
  ORANGE:    TColor = (r: 255; g: 161; b: 0;   a: 255); // Orange
  PINK:      TColor = (r: 255; g: 109; b: 194; a: 255); // Pink
  RED:       TColor = (r: 230; g: 41;  b: 55;  a: 255); // Red
  MAROON:    TColor = (r: 190; g: 33;  b: 55;  a: 255); // Maroon
  GREEN:     TColor = (r: 0;   g: 228; b: 48;  a: 255); // Green
  LIME:      TColor = (r: 0;   g: 158; b: 47;  a: 255); // Lime
  DARKGREEN: TColor = (r: 0;   g: 117; b: 44;  a: 255); // Dark Green
  SKYBLUE:   TColor = (r: 102; g: 191; b: 255; a: 255); // Sky Blue
  BLUE:      TColor = (r: 0;   g: 121; b: 241; a: 255); // Blue
  DARKBLUE:  TColor = (r: 0;   g: 82;  b: 172; a: 255); // Dark Blue
  PURPLE:    TColor = (r: 200; g: 122; b: 255; a: 255); // Purple
  VIOLET:    TColor = (r: 135; g: 60;  b: 190; a: 255); // Violet
  DARKPURPLE:TColor = (r: 112; g: 31;  b: 126; a: 255); // Dark Purple
  BEIGE:     TColor = (r: 211; g: 176; b: 131; a: 255); // Beige
  BROWN:     TColor = (r: 127; g: 106; b: 79;  a: 255); // Brown
  DARKBROWN: TColor = (r: 76;  g: 63;  b: 47;  a: 255); // Dark beown
  WHITE:     TColor = (r: 255; g: 255; b: 255; a: 255); // White
  BLACK:     TColor = (r: 0;   g: 0;   b: 0;   a: 255); // Black
  BLANK:     TColor = (r: 0;   g: 0;   b: 0;   a: 0  ); // Black(Transparent)
  MAGENTA:   TColor = (r: 255; g: 0;   b: 255; a: 255); // Magenta
  RAYWHITE:  TColor = (r: 245; g: 245; b: 245; a: 255); // raylib logo

procedure InitWindow(width, height : integer; title: string);
external;
procedure SetTargetFPS(fps: integer);
external;
function WindowShouldClose: boolean;
external;
procedure CloseWindow;
external;

procedure BeginDrawing;
external;
procedure EndDrawing;
external;

procedure ClearBackground(color: TColor);
external;

procedure DrawText(text: string; posX, posY, fontSize: integer; color: TColor);
external;

procedure BeginMode3D(camera: TCamera3D);
external;
procedure EndMode3D;
external;

procedure DrawPlane(centerPos: TVector3; size: TVector2; color: TColor);
external;

IMPLEMENTATION

end.
