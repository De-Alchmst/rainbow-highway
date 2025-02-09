unit HighwayDraw;
{$mode ObjFPC}{$H+}

INTERFACE

uses
  Raylib,
  Core,
  HighwayLogic;

procedure DrawHighway;

IMPLEMENTATION

const
  LINE_WIDTH = 3; 
  LINE_LENGTH = 20;
  LINE_GAP = 30;
  LINE_ROWS = 3;

var
  Speed: integer = 2;
 
  BGColor: TColor;
  RoadColor: TColor;

  PlayerCamera: TCamera3D = (
    Position: (X: 0; Y: 100; Z: -150);
    Target: (X: 0; Y: 0; Z: 0);
    Up: (X: 0; Y: 1; Z: 0);
    Fovy: 50.0;
    Projection: CAMERA_PERSPECTIVE;
  );

  LinesMoved: integer = 0;


procedure MoveLines;
begin
  LinesMoved := (LinesMoved + Speed) mod (LINE_LENGTH + LINE_GAP);
end; 

procedure Move;
begin
  MoveLines;
end;



procedure DrawInnerLines;
var
  HorGap, LineCount, I, J: integer;
  LinePos: TVector3 = (X: 0; Y: 0; Z: 0);
  LineSize: TVector2 = (X: real(LINE_WIDTH); Y: real(LINE_LENGTH));


begin
  HorGap := (HIGHWAY_WIDTH - LINE_ROWS) div (LINE_ROWS + 1);
  LineCount := HIGHWAY_LENGTH div (LINE_LENGTH + LINE_GAP);

  for I := 1 to LINE_ROWS do
  begin
    LinePos.X := HIGHWAY_WIDTH div 2 - I * HorGap - (I - 1) * LINE_WIDTH;

    for J := 1 to LineCount do
    begin
      LinePos.Z := - HIGHWAY_LENGTH div 2
                   + J * (LINE_LENGTH + LINE_GAP) - LinesMoved;
      DrawPlane(LinePos, LineSize, RoadColor);
    end;
  end;
end;


procedure DrawForceField;
var
  FieldPos: TVector3 = (X: 0; Y: -1; Z: 0);
  FieldSize: TVector2 = (X: HIGHWAY_WIDTH; Y: HIGHWAY_LENGTH);
  FieldColor: TColor = (R: 169; G: 239; B: 253; A: 100);

begin
  DrawPlane(FieldPos, FieldSize, FieldColor);
end;


procedure DrawSideLines;
var
  LinePos: TVector3 = (X: 0; Y: 0; Z: 0);
  LineSize: TVector2 = (X: 3; Y: HIGHWAY_LENGTH);

begin
  LinePos.x := - HIGHWAY_WIDTH / 2;
  DrawPlane(LinePos, LineSize, RoadColor);

  LinePos.x := + HIGHWAY_WIDTH / 2;
  DrawPlane(LinePos, LineSize, RoadColor);
end;


procedure DrawHighway;
begin
  Move;

  ClearBackground(BGColor);

  BeginMode3D(PlayerCamera);

    DrawForceField;
    DrawSideLines;
    DrawInnerLines;

  EndMode3D;
end;

INITIALIZATION

  BGColor := BLACK;
  RoadColor := WHITE;
end.
