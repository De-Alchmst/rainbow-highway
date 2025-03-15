unit Loading;
{$mode ObjFPC}{$H+}

INTERFACE
uses
  Core,
  Raylib;

procedure ShowLoadingScreen;

IMPLEMENTATION

procedure ShowLoadingScreen;
begin
  BeginDrawing;
    ClearBackground(Gray);
    DrawText('LOADING...', 100, 200, 100, YELLOW);
    DrawText('Bare with us.', 200, 400, 100, YELLOW);
  EndDrawing;
end;

end.

