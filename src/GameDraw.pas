unit GameDraw;
{$mode ObjFPC}{$H+}

INTERFACE

uses
  Raylib,
  Core,
  PlayerShip;

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

procedure DrawEntities;
begin
  Player.Draw;
end;

INITIALIZATION
  InitPlayer;

FINALIZATION
  Player.Free;

end.
