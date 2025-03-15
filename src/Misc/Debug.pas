unit Debug;
{$mode ObjFPC}{$H+}

INTERFACE

uses
  Core,
  Raylib;

const
  SKIP_MAIN_MENU = false;

var
  IsDrawHitBox: boolean = false;

procedure UpdateDebug;

IMPLEMENTATION

procedure UpdateDebug;
begin
  if IsKeyPressed(KEY_H) then
    IsDrawHitBox := not IsDrawHitBox;
end;

end.
