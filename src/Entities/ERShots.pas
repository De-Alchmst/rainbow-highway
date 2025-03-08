unit ERShots;
{$mode ObjFPC}{$H+}

INTERFACE

uses
  Core,
  Raylib,
  Textures,
  TexturePlate,
  EntityBase,
  PlayerShots;

const
  // we use player shot texture
  BASIC_ER_SHOT_TEXTURE_LIST: TTextureNameList = ();

type
  TBasicERShot = class(TBasicPlayerShot)
  public
    procedure Update; override;
  end;

IMPLEMENTATION

procedure TBasicERShot.Update;
begin
  with HitBox, Origin do
  begin
    Z := Z - Speed;

    if Z < MAP_END then
      IsAlive := false;
  end;
end;

end.

