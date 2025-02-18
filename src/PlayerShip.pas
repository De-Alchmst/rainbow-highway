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
    Bottom, MidBottom, MidTop, Top : TTexture2D;
    Speed: real;
    
    procedure UpdateMovement;

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
    Width := 34;
    Height := 8;
    Length := 46;
  end;

  Speed := 2.5;

  Bottom    := GetTextureFromFile('lone-comrade-bottom');
  MidBottom := GetTextureFromFile('lone-comrade-midbottom');
  MidTop    := GetTextureFromFile('lone-comrade-midtop');
  Top       := GetTextureFromFile('lone-comrade-top');
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

    // Forwards
    if IsKeyDown(KEY_W) then
    begin
      Z := Z + Speed;
      if Z > PLAY_FIELD_PLAYER_END then
        Z := PLAY_FIELD_PLAYER_END;
    end;

    // Backwards
    if IsKeyDown(KEY_S) then
    begin
      Z := Z - Speed;
      if Z - Length < PLAY_FIELD_BEGIN then
        Z := Length + PLAY_FIELD_BEGIN;
    end;

    // Up
    if IsKeyDown(KEY_Q) then
    begin
      Y := Y + Speed;
      if Y > PLAY_FIELD_TOP then
        Y := PLAY_FIELD_TOP;
    end;

    // Down
    if IsKeyDown(KEY_E) then
    begin
      Y := Y - Speed;
      if Y - Height < PLAY_FIELD_BOTTOM then
        Y := Height + PLAY_FIELD_BOTTOM;
    end;
  end;
end;


procedure TPlayerShip.Update(Index: integer);
begin
  UpdateMovement;
end;


INITIALIZATION
  TPlayerShip.TextureList := TTextureNameList.Create(
    'lone-comrade-bottom',
    'lone-comrade-midbottom',
    'lone-comrade-midtop',
    'lone-comrade-top'
  );

end.
