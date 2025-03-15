program Main;
{$mode ObjFPC}{$H+}

uses
  Raylib,
  Core, Debug,
  GameStateHandle,
  HighwayDraw,
  TexturesHandle,
  GameDraw, GameLogic,
  MainMenuDraw, MainMenuLogic,
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
  DeinitGame;

  CloseAudioDevice;
end;


begin
  Initialize;

  StartGame;

  while (not WindowShouldClose()) or (GameState = Exit) do
  begin

    UpdateDebug;
    UpdateAudio;

    case GameState of
      MainMenu:
      begin
        UpdateMainMenuLogic;

        BeginDrawing;
          DrawMainMenu;
        EndDrawing;
      end;

      Credits:
      begin
      end;

      Game:
      begin
        UpdateGameLogic;

        BeginDrawing;
          DrawGame;

          DrawFPS(30, 30);
        EndDrawing;
      end;

      else
      begin
      end;
    end;

  end;
end.
