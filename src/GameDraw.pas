unit GameDraw;
{$mode ObjFPC}{$H+}

INTERFACE

uses
  Raylib,
  Core,
  Debug,
  GameLogic,
  HighwayDraw,
  PlayerShip,
  EntityBase, EnemyBase, AttackBase,
  Collisions;

procedure InitGame;
procedure DrawGame;
procedure DeinitGame;

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

  AplhaDiscard: TShader;


procedure InitGame;
begin
  InitGameLogic;

  // I draw a bunch of transparent textures crossing each other
  // This would make it near impossible to sort them in a 100% working order
  // As I don't do anything crazy, alpha discard should not impact performance
  // in any noticable way
  AplhaDiscard := LoadShader('', SourceDir + 'AlphaDiscard.fs');
end;

procedure DeinitGame;
begin
  UnloadShader(AplhaDiscard);
end;

procedure DrawGame;
begin

  BeginMode3D(PlayerCamera);

    DrawHighway;

    BeginShaderMode(AplhaDiscard);

      DrawAttacks(PlayerAttacks);
      DrawAttacks(EnemyAttacks);
      DrawEnemies(Enemies);

      Player.Draw;

      if IsDrawHitBox then
        DrawHitBox(Player.HitBox);

    EndShaderMode;

  EndMode3D;

end;

FINALIZATION

end.
