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
  Audio,
  Loading,
  WikiPage,
  TextPage;

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

procedure Update;
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

      Wiki:
      begin
        UpdateTextPageLogic;

        BeginDrawing;
          DrawTextPage;
        EndDrawing;
      end;

      Manual:
      begin
      end;

      Config:
      begin
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

      else begin end;
    end;
end;

procedure InitGameState;
begin
  case GameState of
    MainMenu:
      PlayMainMenuTheme;

    Game:
      begin
        ShowLoadingScreen;
        StartGame;
      end;

    Wiki:
      begin
        ShowLoadingScreen;
        SetTextPageContent(GetWikiTextPageContent());
      end;
    else begin end;
  end;
end;

var
  PrevGameState: TGameState;

begin
  Initialize;

  {$if SKIP_MAIN_MENU = true}
    GameState := Game;
    StartGame;
  {$else}
    PlayMainMenuTheme;
  {$endif}

  while (not WindowShouldClose()) and (GameState <> Exit) do
  begin
    PrevGameState := GameState;

    Update;

    if GameState <> PrevGameState then
      InitGameState;
  end;
end.
