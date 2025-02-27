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
  EntityBase;

var
  Player: TPlayerShip;
  PlayerAttacks: TEntities;

procedure InitGameLogic;
procedure UpdateGameLogic;
procedure StartGame;

IMPLEMENTATION

const
  DEF_PLAYER_POS: TVector3 = (X: -17; Y: 10; Z: CAMERA_Z + 130);


procedure ResetPlayerAttacks;
var
  Ent: TEntityBase;

begin
  for Ent in PlayerAttacks do
    Ent.Free;
  setLength(PlayerAttacks, 0);
end;


procedure InitPlayer;
begin
  Player := TPlayerShip.Create(DEF_PLAYER_POS);
end;


procedure InitGameLogic;
begin
  InitPlayer;
  ResetPlayerAttacks;
end;


procedure StartGame;
begin
  LoadBeams('BigCarTheft.mp3');
  LoadMusic('BigCarTheft.mp3');
end;


procedure UpdatePlayerAttacks;
var
  I: integer;
  ToRemove: array of integer;

begin
  setLength(ToRemove, 0);

  for I := 0 to length(PlayerAttacks)-1 do
  begin
    PlayerAttacks[I].Update;

    if not PlayerAttacks[I].IsAlive then
      insert(I, ToRemove, 0);
  end;

  for I in ToRemove do
  begin
    PlayerAttacks[I].free;
    delete(PlayerAttacks, I, 1);
  end;
end;


procedure UpdateGameLogic;
begin

  UpdatePlayerAttacks;

  Player.Update;
  Player.HandleAttacks(PlayerAttacks);
end;

FINALIZATION
  Player.Free;
  ResetPlayerAttacks;
end.

