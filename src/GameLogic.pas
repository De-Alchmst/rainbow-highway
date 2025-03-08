  unit GameLogic;
{$mode ObjFPC}{$H+}

INTERFACE

uses
  Core,
  Raylib,
  Audio,
  BeamsLogic,
  Collisions,
  PlayerShip,
  Droner, Glider,
  EntityBase, EnemyBase;

var
  Player: TPlayerShip;
  PlayerAttacks, EnemyAttacks: TEntities;
  Enemies: TEnemies;

procedure InitGameLogic;
procedure UpdateGameLogic;
procedure StartGame;

IMPLEMENTATION

const
  DEF_PLAYER_POS: TVector3 = (X: -17; Y: 10; Z: CAMERA_Z + 130);


procedure InitPlayer;
begin
  Player := TPlayerShip.Create(DEF_PLAYER_POS);
end;


procedure ResetAllEntities;
begin
  ResetEntities(PlayerAttacks);
  ResetEntities(EnemyAttacks);
  ResetEnemies(Enemies);
end;


procedure InitGameLogic;
begin
  InitPlayer;
  ResetAllEntities;
end;


procedure StartGame;
const
  DRONER_POS: TVector3 = (X: 0; Y: 14; Z: PLAY_FIELD_END - 150);
  GLIDER_POS: TVector3 = (X: -40; Y: 14; Z: PLAY_FIELD_END - 150);
begin
  LoadBeams('BigCarTheft.mp3');
  LoadMusic('BigCarTheft.mp3');

  insert(TDroner.Create(DRONER_POS), Enemies, 0);
  insert(TGlider.Create(GLIDER_POS), Enemies, 0);
end;


procedure UpdateGameLogic;
begin

  UpdateEntities(PlayerAttacks);
  UpdateEntities(EnemyAttacks);

  UpdateEnemies(Enemies);
  Player.Update;

  Player.HandleAttacks(PlayerAttacks);
  AttackEnemies(Enemies, EnemyAttacks);
end;

FINALIZATION
  Player.Free;
  ResetAllEntities;
end.

