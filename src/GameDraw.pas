unit GameDraw;
{$mode ObjFPC}{$H+}

INTERFACE

uses
  Raylib,
  Core,
  PlayerShip;

procedure InitGame;
procedure DrawEntities;

IMPLEMENTATION

const
  DEF_PLAYER_POS: TVector3 = (X: 0; Y: 10; Z: CAMERA_Z + 50);

var
  Player: TPlayerShip;

procedure InitPlayer;
begin
  Player := TPlayerShip.Create(DEF_PLAYER_POS);
end;

procedure InitGame;
begin
  InitPlayer;
end;

procedure DrawEntities;
begin
  Player.Draw;
end;

FINALIZATION
  Player.Free;

end.
