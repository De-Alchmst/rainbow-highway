unit ERShots;
{$mode ObjFPC}{$H+}

INTERFACE

uses
  Core,
  Raylib,
  Textures,
  TexturePlate,
  EntityBase, AttackBase,
  PlayerShots;

const
  // we use player shot texture
  BASIC_ER_SHOT_TEXTURE_LIST: TTextureNameList = ();

type
  TBasicERShot = class(TBasicPlayerShot)
  public
    constructor Create(StartPos: TVector3; Sp: real; Dm: integer);
  end;

IMPLEMENTATION

constructor TBasicERShot.Create(StartPos: TVector3; Sp: real; Dm: integer);
begin
  inherited Create(StartPos, Sp, Dm);
  Direction := Backwards;
end;

end.

