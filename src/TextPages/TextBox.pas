unit TextBox;
{$mode ObjFPC}{$H+}

INTERFACE

uses
  strutils, types,
  Core,
  Raylib,
  BoxBase;

type
  TTextBox = class
    private
      ContentTextLines: TStringDynArray;
      FgColor, BgColor, BdColor : TColor;
      BdWidth: real;
      TextSize, XSpacing, YSpacing: integer;

      Rect: TRectangle;
      Scroll: TPercent;
      Image : TImage;
      Texture: TTexture2D;
      TextFont: TFont;

    public
      constructor Create(Text: string; X, Y, Width, Height : real;
                         BackColor, ForeColor, BorderColor: TColor; Font: TFont;
                         FontSize, CharSpacing, LineSpacing: integer;
                         BorderWidth: real = 7);
      destructor Destroy; override;
      procedure Update;
      procedure Draw;
  end;

  TTextBoxes = array of TTextBox;

procedure InitTextBox;

IMPLEMENTATION

const
  PADDING_X = 10;
  PADDING_Y = 10;

var
  PurpleDiscard: TShader;


procedure InitTextBox;
begin
  PurpleDiscard := LoadShader('', SourceDir + 'Shaders/PurpleDiscard.fs');
end;


constructor TTextBox.Create(Text: string; X, Y, Width, Height : real;
                            BackColor, ForeColor, BorderColor: TColor;
                            Font: TFont;
                            FontSize, CharSpacing, LineSpacing: integer;
                            BorderWidth: real = 7);
begin
  Rect.X := X;
  Rect.Y := Y;
  Rect.Width := Width;
  Rect.Height := Height;

  FgColor := ForeColor;
  BgColor := BackColor;
  BdColor := BorderColor;
  BdWidth := BorderWidth;
  TextFont := Font;
  TextSize := FontSize;
  XSpacing := CharSpacing;
  YSpacing := LineSpacing;

  Scroll := 0;
  Image := GenImageColor(trunc(Width), trunc(Height), BgColor);

  ContentTextLines := SplitString(Text, #10);

end;


destructor TTextBox.Destroy;
begin
  UnloadImage(Image);
  UnloadTexture(Texture);
  inherited;
end;


procedure DrawLines(var Image: TImage; Lines: TStringDynArray;
                    Font: TFont; Size, XSpacing, YSpacing: integer;
                    Color: TColor);
var
  Pos: TVector2;
  Line: string;

begin
  Pos.X := PADDING_X;
  Pos.Y := PADDING_Y;
  for Line in Lines do
  begin
    ImageDrawTextEx(@Image, Font, Line, Pos, Size, XSpacing, Color);

    Pos.Y := Pos.Y + Size + YSpacing;
  end;
end;


procedure TTextBox.Update;
begin
  ImageClearBackground(@Image, BgColor);

  DrawLines(Image, ContentTextLines, TextFont, TextSize,
             XSpacing, YSpacing, FgColor);

  TrimImageToBox(Image, Rect);

  UnloadTexture(Texture);
  Texture := LoadTextureFromImage(Image);
end;


procedure TTextBox.Draw;
begin
  BeginShaderMode(PurpleDiscard);

    DrawTexture(Texture, trunc(Rect.X), trunc(Rect.Y), WHITE);

  EndShaderMode;

  DrawBoxOutline(Rect, BdColor, BdWidth);
end;

end.

