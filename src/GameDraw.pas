unit GameDraw;
{$mode ObjFPC}{$H+}

INTERFACE

uses
  Raylib,
  Core,
  GameLogic,
  HighwayDraw,
  PlayerShip,
  EntityBase,
  Collisions;

procedure InitGame;
procedure DrawGame;

IMPLEMENTATION

var
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


procedure InitGame;
begin
  InitGameLogic;
end;

procedure DrawGame;
var
  Ent: TEntityBase;

begin

  BeginMode3D(PlayerCamera);

    DrawHighway;

    // DrawHitBox(Player.HitBox, Lime);
    // DrawSphere(Player.HitBox.Origin, 3, RED);
    for Ent in PlayerAttacks do
      Ent.Draw;

    Player.Draw;

  EndMode3D;

end;

FINALIZATION

end.
