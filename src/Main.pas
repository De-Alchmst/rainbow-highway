program Main;
{$mode ObjFPC}{$H+}

uses
  Raylib,
  Core,
  HighwayDraw,
  TexturesHandle,
  GameDraw,
  GameLogic,
  Audio;

procedure Initialize;
begin
  InitWindow(WINDOW_WIDTH, WINDOW_HEIGHT, 'Rainbow Highway!');
  InitAudioDevice;
  SetTargetFPS(TARGET_FPS);

  // things that need to be done after InitWindow
  InitTextures;
  InitGame;
end;


procedure Deinitialize;
begin
  // things that need to deinitialize before CloseWindow
  DeinitTextures;

  CloseAudioDevice;
end;


begin
  Initialize;

  StartGame;

  while not WindowShouldClose() do
  begin

    UpdateGameLogic;
    UpdateAudio;

    BeginDrawing;
      
      DrawGame;

      DrawFPS(30, 30);

    EndDrawing;

  end;
end.
