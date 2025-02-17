unit GameDraw;
{$mode ObjFPC}{$H+}

INTERFACE

uses
  Raylib,
  Core,
  HighwayDraw,
  PlayerShip,
  Collisions;

procedure InitGame;
procedure DrawGame;

IMPLEMENTATION

const
  DEF_PLAYER_POS: TVector3 = (X: 0; Y: 7; Z: CAMERA_Z + 130);

var
  Player: TPlayerShip;

  PlayerCamera: TCamera3D = (
    Position: (X: 0;
               // 2/3 of Z
               Y: -(CAMERA_Z div 3) * 2;
               Z: CAMERA_Z);
    Target: (X: 0; Y: 0; Z: 0);
    Up: (X: 0; Y: 1; Z: 0);
    Fovy: 50.0;
    Projection: CAMERA_PERSPECTIVE;
  );


procedure InitPlayer;
begin
  Player := TPlayerShip.Create(DEF_PLAYER_POS);
end;

procedure InitGame;
begin
  InitPlayer;
end;

procedure DrawGame;
begin

  BeginMode3D(PlayerCamera);

    DrawHighway;

    DrawHitBox(Player.HitBox, Lime);
    DrawSphere(Player.HitBox.Origin, 3, RED);
    Player.Draw;

  EndMode3D;

end;

FINALIZATION
  Player.Free;

end.
