unit PlayerShots;
{$mode ObjFPC}{$H+}

INTERFACE

uses
  Core,
  Raylib,
  Textures,
  TexturePlate,
  EntityBase, AttackBase;

const
  BASIC_PLAYER_SHOT_TEXTURE_LIST: TTextureNameList = ('basic-player-shot');

type
  TBasicPlayerShot = class(TAttackBase)
  private
    Texture: TTexture2D;

  public
    constructor Create(StartPos: TVector3; Sp: real; Dm: integer);
    procedure Draw; override;
  end;

IMPLEMENTATION

constructor TBasicPlayerShot.Create(StartPos: TVector3; Sp: real; Dm: integer);
begin
  inherited Create(StartPos, Sp, Dm);

  With HitBox do
  begin
    Origin := StartPos;
    Width := 4;
    Height := 4;
    Length := 7;
  end;

  Direction := Forwards;
  Texture := GetTextureFromFile('basic-player-shot');
end;


procedure TBasicPlayerShot.Draw;
const
  HOR_POS: TVector3 = (X: 0; Y: -2; Z: 0);
  RGT_POS: TVector3 = (X: 0; Y: 2;  Z: 0);
  LFT_POS: TVector3 = (X: 4; Y: -2;  Z: 0);

begin
  With HitBox do
  begin
    DrawTexturePlate(Texture, HOR_POS, Origin);
    DrawTexturePlate(Texture, RGT_POS, Origin, 0, 0, 90);
    DrawTexturePlate(Texture, LFT_POS, Origin, 0, 0, -90);
  end;
end;

end.
