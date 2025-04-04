unit TextBox;
{$mode ObjFPC}{$H+}

INTERFACE

uses
  Core,
  Raylib,
  BoxBase;

type
  TTextBox = class
    private
      ContentText: string;
      FgColor, BgColor, BdColor : TColor;
      BdWidth: real;
      TextSize: integer;

      Rect: TRectangle;
      Scroll: TPercent;
      Image : TImage;
      Texture: TTexture2D;

    public
      constructor Create(Text: string; X, Y, Width, Height : real;
                         BackColor, ForeColor, BorderColor: TColor;
                         FontSize: integer; BorderWidth: real = 7);
      destructor Destroy; override;
      procedure Update;
      procedure Draw;
  end;

  TTextBoxes = array of TTextBox;

procedure InitTextBox;

IMPLEMENTATION

var
  PurpleDiscard: TShader;


procedure InitTextBox;
begin
  PurpleDiscard := LoadShader('', SourceDir + 'Shaders/PurpleDiscard.fs');
end;


constructor TTextBox.Create(Text: string; X, Y, Width, Height : real;
                            BackColor, ForeColor, BorderColor: TColor;
                            FontSize: integer; BorderWidth: real = 7);
begin
  Rect.X := X;
  Rect.Y := Y;
  Rect.Width := Width;
  Rect.Height := Height;

  ContentText := Text;
  FgColor := ForeColor;
  BgColor := BackColor;
  BdColor := BorderColor;
  BdWidth := BorderWidth;
  TextSize := FontSize;

  Scroll := 0;
  Image := GenImageColor(trunc(Width), trunc(Height), BgColor);

end;


destructor TTextBox.Destroy;
begin
  UnloadImage(Image);
  UnloadTexture(Texture);
  inherited;
end;


procedure TTextBox.Update;
  
begin
  ImageClearBackground(@Image, BgColor);
  ImageDrawText(@Image, ContentText, 10, 10, TextSize, FgColor);

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

