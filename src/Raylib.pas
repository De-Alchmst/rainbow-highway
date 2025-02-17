unit Raylib;
{$mode ObjFPC}{$H+}

INTERFACE

{$linklib libraylib}

uses ctypes;

type

  TColor = record
    R, G, B, A : byte;
  end; 

  TRectangle = record
    X, Y, Width, Height : cfloat;
  end;

  TVector2 = record
    X, Y : cfloat;
  end;

  TVector3 = record
    X, Y, Z : cfloat;
  end;

  TVector4 = record
    X, Y, Z, W : cfloat;
  end;

  TCameraProjection = (
    CAMERA_PERSPECTIVE,
    CAMERA_ORTOGRAPHIC
  );

  TCamera3D = record
    Position, Target, Up : TVector3;
    Fovy: cfloat;
    Projection: TCameraProjection;
  end;

  TCameraMode = (
    CAMERA_CUSTOM,
    CAMERA_FREE,
    CAMERA_ORBITAL,
    CAMERA_FIRST_PERSON,
    CAMERA_THIRD_PERSON
  );

  TTexture2D = record
    Id: cuint;
    Width, Height, Mipmaps, Format: cint;
  end;

  TImage = record
    data: pcchar;
    Width, Height, Mipmaps, Format: cint;
  end;

const
  LIGHTGRAY: TColor = (R: 200; G: 200; B: 200; A: 255); // Light Gray
  GRAY:      TColor = (R: 130; G: 130; B: 130; A: 255); // Gray
  DARKGRAY:  TColor = (R: 80;  G: 80;  B: 80;  A: 255); // Dark Gray
  YELLOW:    TColor = (R: 253; G: 249; B: 0;   A: 255); // Yellow
  GOLD:      TColor = (R: 255; G: 203; B: 0;   A: 255); // Gold
  ORANGE:    TColor = (R: 255; G: 161; B: 0;   A: 255); // Orange
  PINK:      TColor = (R: 255; G: 109; B: 194; A: 255); // Pink
  RED:       TColor = (R: 230; G: 41;  B: 55;  A: 255); // Red
  MAROON:    TColor = (R: 190; G: 33;  B: 55;  A: 255); // Maroon
  GREEN:     TColor = (R: 0;   G: 228; B: 48;  A: 255); // Green
  LIME:      TColor = (R: 0;   G: 158; B: 47;  A: 255); // Lime
  DARKGREEN: TColor = (R: 0;   G: 117; B: 44;  A: 255); // Dark Green
  SKYBLUE:   TColor = (R: 102; G: 191; B: 255; A: 255); // Sky Blue
  BLUE:      TColor = (R: 0;   G: 121; B: 241; A: 255); // Blue
  DARKBLUE:  TColor = (R: 0;   G: 82;  B: 172; A: 255); // Dark Blue
  PURPLE:    TColor = (R: 200; G: 122; B: 255; A: 255); // Purple
  VIOLET:    TColor = (R: 135; G: 60;  B: 190; A: 255); // Violet
  DARKPURPLE:TColor = (R: 112; G: 31;  B: 126; A: 255); // Dark Purple
  BEIGE:     TColor = (R: 211; G: 176; B: 131; A: 255); // Beige
  BROWN:     TColor = (R: 127; G: 106; B: 79;  A: 255); // Brown
  DARKBROWN: TColor = (R: 76;  G: 63;  B: 47;  A: 255); // Dark beown
  WHITE:     TColor = (R: 255; G: 255; B: 255; A: 255); // White
  BLACK:     TColor = (R: 0;   G: 0;   B: 0;   A: 255); // Black
  BLANK:     TColor = (R: 0;   G: 0;   B: 0;   A: 0  ); // Black(Transparent)
  MAGENTA:   TColor = (R: 255; G: 0;   B: 255; A: 255); // Magenta
  RAYWHITE:  TColor = (R: 245; G: 245; B: 245; A: 255); // raylib logo

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

procedure DrawFPS(x, y : cint);
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
procedure DrawSphere(centerPos: TVector3; radius: cfloat; color: TColor);
external;
procedure DrawCube(centerPos: TVector3; width, height, length: cfloat;
                   color: TColor);
external;
procedure DrawCubeWires(centerPos: TVector3; width, height, length: cfloat;
                   color: TColor);
external;

function LoadTexture(fileName: string): TTexture2D;
external;
procedure UnloadTexture(texture: TTexture2D);
external;
function LoadTextureFromImage(image: TImage): TTexture2D;
external;

function LoadImage(fileName: string): TImage;
external;
procedure UnloadImage(image: TImage);
external;

IMPLEMENTATION

end.
