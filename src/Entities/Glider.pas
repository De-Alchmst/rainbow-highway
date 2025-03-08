unit Glider;
{$mode ObjFPC}{$H+}

INTERFACE

uses
  Core,
  Raylib,
  Textures,
  TexturePlate,
  EntityBase, EnemyBase, AttackBase,
  ERShots;

const
  GLIDER_TEXTURE_LIST: TTextureNameList = (
    'er/glider-bottom',
    'er/glider-middle',
    'er/glider-top'
  );

type
  TGlider = class(TEnemyBase)
    private
      Bottom, Mid, Top : TTexture2D;
      ShootCooldown: integer;

      procedure UpdateMovement;

    public
      constructor Create(StartPos: TVector3); override;
      procedure Draw; override;
      procedure Update; override;
      procedure HandleAttacks(var entities: TAttacks); override;
  end;

IMPLEMENTATION

const
  SHOOT_COOLDOWN_MAX = 30;


constructor TGlider.Create(StartPos: TVector3);
begin
  with HitBox do
  begin
    Origin := StartPos;
    Width := 30;
    Length := 19;
    Height := 5;
  end;

  IsAlive := true;
  Health := 40;
  ShootCooldown := SHOOT_COOLDOWN_MAX;

  Bottom := GetTextureFromFile('er/glider-bottom');
  Mid := GetTextureFromFile('er/glider-middle');
  Top := GetTextureFromFile('er/glider-top');
end;


procedure TGlider.Draw;
const
  BTM_POS: TVector3 = (X: 0; Y: -5; Z: 0);
  MID_POS: TVector3 = (X: 0; Y: -2; Z: 0);
  TOP_POS: TVector3 = (X: 0; Y: 0;  Z: 0);

begin
  with HitBox do
  begin
    DrawTexturePlate(Bottom, BTM_POS, Origin);
    DrawTexturePlate(Mid, MID_POS, Origin);
    DrawTexturePlate(Top, TOP_POS, Origin);
  end;

end;


procedure TGlider.UpdateMovement;
begin
end;


procedure TGlider.Update;
begin
  UpdateMovement;
end;

procedure TGlider.HandleAttacks(var Entities: TAttacks);
var
  Vect: TVector3;

begin
  if ShootCooldown > 0 then
    dec(ShootCooldown)
  else
  begin
    ShootCooldown := SHOOT_COOLDOWN_MAX;

    with HitBox, Origin do
    begin
      Vect.Y := Y - 2;
      Vect.Z := Z - Length + 1;

      Vect.X := X - 3;
      insert(TBasicERShot.Create(Vect, 3.2, 6), Entities, 0);

      Vect.X := X - 23;
      insert(TBasicERShot.Create(Vect, 3.2, 6), Entities, 0);

    end;
  end;
end;

end.
