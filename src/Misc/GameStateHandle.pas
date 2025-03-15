unit GameStateHandle;
{$mode ObjFPC}{$H+}

INTERFACE
uses
  Debug;

type
  TGameState = (MainMenu, Game, Credits, Wiki, Manual, Config, Exit);

var
  GameState: TGameState = MainMenu;

IMPLEMENTATION

end.

