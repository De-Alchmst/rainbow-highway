unit PlayerShip;
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
  PLAYER_SHIP_TEXTURE_LIST: TTextureNameList = (
    'lone-comrade-bottom',
    'lone-comrade-midbottom',
    'lone-comrade-midtop',
    'lone-comrade-top'
  );

type
  TPlayerShip = class(TEntityBase)
  private
    Bottom, MidBottom, MidTop, Top : TTexture2D;
    BasicShotCooldown: integer;
    
    procedure UpdateMovement;

  public
    Health: integer;

    constructor Create(StartPos: TVector3); override;
    procedure Draw; override;
    procedure Update; override;
    procedure HandleAttacks(var entities: TAttacks);
  end;

IMPLEMENTATION

const
  BASIC_SHOT_COOLDOWN_MAX = 10;


constructor TPlayerShip.Create(StartPos: TVector3);
begin
  with HitBox do
  begin
    Origin := StartPos;
    Width := 34;
    Height := 8;
    Length := 46;
  end;

  Speed := 2.5;
  IsAlive := true;

  Bottom    := GetTextureFromFile('lone-comrade-bottom');
  MidBottom := GetTextureFromFile('lone-comrade-midbottom');
  MidTop    := GetTextureFromFile('lone-comrade-midtop');
  Top       := GetTextureFromFile('lone-comrade-top');

  BasicShotCooldown := BASIC_SHOT_COOLDOWN_MAX;
end;

procedure TPlayerShip.Draw;
const
  BOT_POS: TVector3 = (X: 0; Y: -8; Z: 0);
  MBT_POS: TVector3 = (X: 0; Y: -5; Z: 0);
  MTP_POS: TVector3 = (X: 0; Y: -2; Z: 0);
  TOP_POS: TVector3 = (X: 0; Y: 0;  Z: 0);

begin
  with HitBox do
  begin
    DrawTexturePlate(Bottom, BOT_POS, Origin);
    DrawTexturePlate(MidBottom, MBT_POS, Origin);
    DrawTexturePlate(MidTop, MTP_POS, Origin);
    DrawTexturePlate(Top, TOP_POS, Origin);
  end;
end;


procedure TPlayerShip.UpdateMovement;
begin
  with HitBox, Origin do
  begin

    // Left
    if IsKeyDown(KEY_A) then
    begin
      X := X + Speed;
      if X > HIGHWAY_WIDTH div 2 then
        X := HIGHWAY_WIDTH div 2;
    end;

    // Right
    if IsKeyDown(KEY_D) then
    begin
      X := X - Speed;
      if X - Width < -HIGHWAY_WIDTH div 2 then
        X := Width - HIGHWAY_WIDTH div 2;
    end;

    // Up
    if IsKeyDown(KEY_W) then
    begin
      Y := Y + Speed;
      if Y > PLAY_FIELD_TOP then
        Y := PLAY_FIELD_TOP;
    end;

    // Down
    if IsKeyDown(KEY_S) then
    begin
      Y := Y - Speed;
      if Y - Height < PLAY_FIELD_BOTTOM then
        Y := Height + PLAY_FIELD_BOTTOM;
    end;
  end;
end;


procedure TPlayerShip.Update;
begin
  UpdateMovement;
end;


procedure TPlayerShip.HandleAttacks(var Entities: TAttacks);
var
  Vect: TVector3;

begin
  if BasicShotCooldown > 0 then
    dec(BasicShotCooldown)
  else
    if IsKeyDown(KEY_SPACE) then
    begin
      BasicShotCooldown := BASIC_SHOT_COOLDOWN_MAX;

      with HitBox, Origin do
      begin
        Vect.Y := Y - 2;
        Vect.Z := Z - 1;
        
        Vect.X := X - 4;
        insert(TBasicPlayerShot.Create(Vect, Speed+0.5, 10), Entities, 0);

        Vect.X := X - 26;
        insert(TBasicPlayerShot.Create(Vect, Speed+0.5, 10), Entities, 0);
      end;
    end;

end;

end.
