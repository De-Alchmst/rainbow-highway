unit Droner;
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
  DRONER_TEXTURE_LIST: TTextureNameList = (
    'er/droner-bottom',
    'er/droner-top'
  );

type
  TDroner = class(TEnemyBase)
    private
      Bottom, Top : TTexture2D;
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
  SHOOT_COOLDOWN_MAX = 50;


constructor TDroner.Create(StartPos: TVector3);
begin
  with HitBox do
  begin
    Origin := StartPos;
    Width := 18;
    Length := 15;
    Height := 2;
  end;

  IsAlive := true;
  Health := 20;
  ShootCooldown := SHOOT_COOLDOWN_MAX;

  Bottom := GetTextureFromFile('er/droner-bottom');
  Top := GetTextureFromFile('er/droner-top');
end;


procedure TDroner.Draw;
const
  BTM_POS: TVector3 = (X: 0; Y: -3; Z: 0);
  TOP_POS: TVector3 = (X: 0; Y: 0;  Z: 0);

begin
  with HitBox do
  begin
    DrawTexturePlate(Bottom, BTM_POS, Origin);
    DrawTexturePlate(Top, TOP_POS, Origin);
  end;

end;


procedure TDroner.UpdateMovement;
begin
end;


procedure TDroner.Update;
begin
  UpdateMovement;
end;

procedure TDroner.HandleAttacks(var Entities: TAttacks);
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
      Vect.X := X - Width / 2 + 2;

      insert(TBasicERShot.Create(Vect, 2, 4), Entities, 0);
    end;
  end;
end;

end.
