program Main;
{$mode ObjFPC}{$H+}

uses
  Raylib,
  Core,
  HighwayDraw,
  TexturesHandle,
  GameDraw;

procedure Initialize;
begin
  InitWindow(WINDOW_WIDTH, WINDOW_HEIGHT, 'Rainbow Highway!');
  SetTargetFPS(TARGET_FPS);

  // things that need to be done after InitWindow
  InitTextures;
  InitGame;
end;


procedure Deinitialize;
begin
  // things that need to deinitialize before CloseWindow
  DeinitTextures;

  CloseWindow;
end;

begin
  Initialize;

  while not WindowShouldClose() do
  begin

    BeginDrawing;
      
      DrawHighway;
      DrawEntities;

      DrawFPS(30, 30);

    EndDrawing;

  end;
end.
