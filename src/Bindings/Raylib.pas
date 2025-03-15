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
    data: pcsize_t;
    Width, Height, Mipmaps, Format: cint;
  end;

  TAudioStream = record
    Buffer, Processor : pcsize_t;
    SampleRate, SampleSize, Channels : cuint;
  end;

  TSound = record
    Stream: TAudioStream;
    FrameCount: cuint;
  end;

  TMusic = record
    Stream: TAudioStream;
    FrameCount: cuint;
    Looping: cbool;
    CtxType: cint;
    CtxData: pcsize_t;
  end;

  TWave = record
    FrameCount, Samplerate, SampleSize, Channels : cuint;
    Data: pcsize_t;
  end;

  TShader = record
    Id: cuint;
    locs: ^cint;
  end;

  TKeyboardKey = (
    KEY_NULL            = 0,        // Key: NULL, used for no key pressed

    KEY_SPACE           = 32,       // Key: Space
    KEY_APOSTROPHE      = 39,       // Key: '
    KEY_COMMA           = 44,       // Key: ,
    KEY_MINUS           = 45,       // Key: -
    KEY_PERIOD          = 46,       // Key: .
    KEY_SLASH           = 47,       // Key: /
    KEY_ZERO            = 48,       // Key: 0
    KEY_ONE             = 49,       // Key: 1
    KEY_TWO             = 50,       // Key: 2
    KEY_THREE           = 51,       // Key: 3
    KEY_FOUR            = 52,       // Key: 4
    KEY_FIVE            = 53,       // Key: 5
    KEY_SIX             = 54,       // Key: 6
    KEY_SEVEN           = 55,       // Key: 7
    KEY_EIGHT           = 56,       // Key: 8
    KEY_NINE            = 57,       // Key: 9
    KEY_SEMICOLON       = 59,       // Key: ;
    KEY_EQUAL           = 61,       // Key: =
    KEY_A               = 65,       // Key: A | a
    KEY_B               = 66,       // Key: B | b
    KEY_C               = 67,       // Key: C | c
    KEY_D               = 68,       // Key: D | d
    KEY_E               = 69,       // Key: E | e
    KEY_F               = 70,       // Key: F | f
    KEY_G               = 71,       // Key: G | g
    KEY_H               = 72,       // Key: H | h
    KEY_I               = 73,       // Key: I | i
    KEY_J               = 74,       // Key: J | j
    KEY_K               = 75,       // Key: K | k
    KEY_L               = 76,       // Key: L | l
    KEY_M               = 77,       // Key: M | m
    KEY_N               = 78,       // Key: N | n
    KEY_O               = 79,       // Key: O | o
    KEY_P               = 80,       // Key: P | p
    KEY_Q               = 81,       // Key: Q | q
    KEY_R               = 82,       // Key: R | r
    KEY_S               = 83,       // Key: S | s
    KEY_T               = 84,       // Key: T | t
    KEY_U               = 85,       // Key: U | u
    KEY_V               = 86,       // Key: V | v
    KEY_W               = 87,       // Key: W | w
    KEY_X               = 88,       // Key: X | x
    KEY_Y               = 89,       // Key: Y | y
    KEY_Z               = 90,       // Key: Z | z
    KEY_LEFT_BRACKET    = 91,       // Key: [
    KEY_BACKSLASH       = 92,       // Key: '\'
    KEY_RIGHT_BRACKET   = 93,       // Key: ]
    KEY_GRAVE           = 96,       // Key: `

    KEY_ESCAPE          = 256,      // Key: Esc
    KEY_ENTER           = 257,      // Key: Enter
    KEY_TAB             = 258,      // Key: Tab
    KEY_BACKSPACE       = 259,      // Key: Backspace
    KEY_INSERT          = 260,      // Key: Ins
    KEY_DELETE          = 261,      // Key: Del
    KEY_RIGHT           = 262,      // Key: Cursor right
    KEY_LEFT            = 263,      // Key: Cursor left
    KEY_DOWN            = 264,      // Key: Cursor down
    KEY_UP              = 265,      // Key: Cursor up
    KEY_PAGE_UP         = 266,      // Key: Page up
    KEY_PAGE_DOWN       = 267,      // Key: Page down
    KEY_HOME            = 268,      // Key: Home
    KEY_END             = 269,      // Key: End
    KEY_CAPS_LOCK       = 280,      // Key: Caps lock
    KEY_SCROLL_LOCK     = 281,      // Key: Scroll down
    KEY_NUM_LOCK        = 282,      // Key: Num lock
    KEY_PRINT_SCREEN    = 283,      // Key: Print screen
    KEY_PAUSE           = 284,      // Key: Pause
    KEY_F1              = 290,      // Key: F1
    KEY_F2              = 291,      // Key: F2
    KEY_F3              = 292,      // Key: F3
    KEY_F4              = 293,      // Key: F4
    KEY_F5              = 294,      // Key: F5
    KEY_F6              = 295,      // Key: F6
    KEY_F7              = 296,      // Key: F7
    KEY_F8              = 297,      // Key: F8
    KEY_F9              = 298,      // Key: F9
    KEY_F10             = 299,      // Key: F10
    KEY_F11             = 300,      // Key: F11
    KEY_F12             = 301,      // Key: F12

    KEY_KP_0            = 320,      // Key: Keypad 0
    KEY_KP_1            = 321,      // Key: Keypad 1
    KEY_KP_2            = 322,      // Key: Keypad 2
    KEY_KP_3            = 323,      // Key: Keypad 3
    KEY_KP_4            = 324,      // Key: Keypad 4
    KEY_KP_5            = 325,      // Key: Keypad 5
    KEY_KP_6            = 326,      // Key: Keypad 6
    KEY_KP_7            = 327,      // Key: Keypad 7
    KEY_KP_8            = 328,      // Key: Keypad 8
    KEY_KP_9            = 329,      // Key: Keypad 9
    KEY_KP_DECIMAL      = 330,      // Key: Keypad .
    KEY_KP_DIVIDE       = 331,      // Key: Keypad /
    KEY_KP_MULTIPLY     = 332,      // Key: Keypad *
    KEY_KP_SUBTRACT     = 333,      // Key: Keypad -
    KEY_KP_ADD          = 334,      // Key: Keypad +
    KEY_KP_ENTER        = 335,      // Key: Keypad Enter
    KEY_KP_EQUAL        = 336,      // Key: Keypad =
    
    KEY_LEFT_SHIFT      = 340,      // Key: Shift left
    KEY_LEFT_CONTROL    = 341,      // Key: Control left
    KEY_LEFT_ALT        = 342,      // Key: Alt left
    KEY_LEFT_SUPER      = 343,      // Key: Super left
    KEY_RIGHT_SHIFT     = 344,      // Key: Shift right
    KEY_RIGHT_CONTROL   = 345,      // Key: Control right
    KEY_RIGHT_ALT       = 346,      // Key: Alt right
    KEY_RIGHT_SUPER     = 347,      // Key: Super right
    KEY_KB_MENU         = 348       // Key: KB menu
  );

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

procedure DrawREctangleRect(rectangle: TRectangle; color: TColor);
external;
procedure DrawRectangleGradientEx(rectangle: TRectangle;
                                  topLeft, bottomLeft, bottomRight,
                                  topRight: TColor);
external;
procedure DrawRectangleLinesEx(rectangle: TRectangle; lineThick: cfloat;
                               color: TColor);
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

function IsKeyPressed(key: TKeyboardKey): boolean;
external;
function IsKeyPressedRepeat(key: TKeyboardKey): boolean;
external;
function IsKeyDown(key: TKeyboardKey): boolean;
external;
function IsKeyReleased(key: TKeyboardKey): boolean;
external;
function IsKeyUp(key: TKeyboardKey): boolean;
external;

function GetKeyPressed: TKeyboardKey;
external;
function GetCharPressed: cint;
external;

procedure SetExitKey(key: TKeyboardKey);
external;

procedure InitAudioDevice;
external;
procedure CloseAudioDevice;
external;
function LoadMusicStream(fileName: string): TMusic;
external;
procedure UnloadMusicStream(music: TMusic);
external;
procedure PlayMusicStream(music: TMusic);
external;
procedure UpdateMusicStream(music: TMusic);
external;
procedure StopMusicStream(music: TMusic);
external;
procedure ResumeMusicStream(music: TMusic);
external;

function LoadWave(fileName: string): TWave;
external;
procedure UnloadWave(wave: TWave);
external;

function LoadShader(vsFileName, fsFileName : string): TShader;
external;
procedure UnloadShader(shader: TShader);
external;
procedure BeginShaderMode(shader: TShader);
external;
procedure EndShaderMode;
external;

IMPLEMENTATION

end.
