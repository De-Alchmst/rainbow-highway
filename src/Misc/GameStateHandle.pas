unit GameStateHandle;
{$mode ObjFPC}{$H+}

INTERFACE
uses
  Debug;

type
  TGameState = (MainMenu, Game, Creddits, Exit);

var
  GameState: TGameState = MainMenu;

IMPLEMENTATION

end.

