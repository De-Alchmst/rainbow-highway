unit PlayerShip;
{$mode ObjFPC}{$H+}

INTERFACE

uses
  Core,
  Raylib,
  Textures,
  TexturePlate,
  EntityBase;

type
  TPlayerShip = class(TEntityBase)
  private
    Bottom, Base, Top : TTexture2D;

  public
    constructor Create(StartPos: TVector3); override;
    procedure Draw; override;
    procedure Update(Index: integer); override;
  end;

IMPLEMENTATION

constructor TPlayerShip.Create(StartPos: TVector3);
begin
  With HitBox do
  begin
    Origin := StartPos;
  end;

  Bottom := GetTextureFromFile('lone-comrade-bottom');
  Base   := GetTextureFromFile('lone-comrade-base');
  Top    := GetTextureFromFile('lone-comrade-top');
end;

procedure TPlayerShip.Draw;
const
  BOT_POS: TVector3 = (X: 0; Y: -10; Z: 0);
  BAS_POS: TVector3 = (X: 0; Y: -5;  Z: 0);
  TOP_POS: TVector3 = (X: 0; Y: 0;   Z: 0);

begin
  with HitBox do
  begin
    DrawTexturePlate(Bottom, BOT_POS, Origin);
    DrawTexturePlate(Base,   BAS_POS, Origin);
    DrawTexturePlate(Top,    TOP_POS, Origin);
  end;
end;


procedure TPlayerShip.Update(Index: integer);
begin
end;


INITIALIZATION
  TPlayerShip.TextureList := TTextureNameList.Create(
    'lone-comrade-bottom',
    'lone-comrade-base',
    'lone-comrade-top'
  );

end.
