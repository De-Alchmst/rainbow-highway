unit GameLogic;
{$mode ObjFPC}{$H+}

INTERFACE

uses
  Raylib,
  Core,
  PlayerShip,
  Collisions,
  Audio,
  BeamsLogic;

var
  Player: TPlayerShip;

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

procedure InitGameLogic;
begin
  InitPlayer;
end;

procedure StartGame;
begin
  LoadBeams('Marauder.mp3');
  LoadMusic('Marauder.mp3');
end;

procedure UpdateGameLogic;
begin
  Player.Update(0);
end;

FINALIZATION
  Player.Free;

end.

