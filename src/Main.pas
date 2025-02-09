program Main;
{$mode ObjFPC}{$H+}

uses
  Raylib,
  Core,
  HighwayLogic, HighwayDraw;

procedure Initialize;
begin
  InitWindow(WINDOW_WIDTH, WINDOW_HEIGHT, 'Rainbow Highway!');
  SetTargetFPS(TARGET_FPS);
end;

begin
  Initialize;

  while not WindowShouldClose() do
  begin

    UpdateHighwayLogic;

    BeginDrawing;
      
      DrawHighway;

    EndDrawing;

  end;
end.
