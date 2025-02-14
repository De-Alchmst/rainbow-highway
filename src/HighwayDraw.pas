unit HighwayDraw;
{$mode ObjFPC}{$H+}

INTERFACE

uses
  Raylib,
  Core,
  HighwayLogic,
  Beams;

procedure DrawHighway;

IMPLEMENTATION
var
  BGColor: TColor;
  RoadLineColor: TColor;
  RoadFieldColor: TColor;

  PlayerCamera: TCamera3D = (
    Position: (X: 0;
               // 2/3 of Z
               Y: -(CAMERA_Z div 3) * 2;
               Z: CAMERA_Z);
    Target: (X: 0; Y: 0; Z: 0);
    Up: (X: 0; Y: 1; Z: 0);
    Fovy: 50.0;
    Projection: CAMERA_PERSPECTIVE;
  );


procedure InitColors;
begin
  BGColor := BLACK;
  RoadLineColor := WHITE;
  with RoadFieldColor do
  begin
    R := 99;
    G := 241;
    B := 232;
    A := 230;
  end;
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
      DrawPlane(LinePos, LineSize, RoadLineColor);
    end;
  end;
end;


procedure DrawRoadForceField;
var
  FieldPos: TVector3 = (X: 0; Y: -1; Z: 0);
  FieldSize: TVector2 = (X: HIGHWAY_WIDTH; Y: HIGHWAY_LENGTH);

begin
  DrawPlane(FieldPos, FieldSize, RoadFieldColor);
end;


procedure DrawSideLines;
var
  LinePos: TVector3 = (X: 0; Y: 0; Z: 0);
  LineSize: TVector2 = (X: 3; Y: HIGHWAY_LENGTH);

begin
  LinePos.x := - HIGHWAY_WIDTH / 2;
  DrawPlane(LinePos, LineSize, RoadLineColor);

  LinePos.x := + HIGHWAY_WIDTH / 2;
  DrawPlane(LinePos, LineSize, RoadLineColor);
end;


procedure DrawRoadParticles;
var
  ParticlePos: TVector3;
  ParticleSize: TVector2 = (X: real(RP_WIDTH); Y: real(RP_LENGTH));

begin
  for ParticlePos in RoadParticles do
    DrawPlane(ParticlePos, ParticleSize, WHITE);
end;


procedure DrawStars;
var
  StarPos: TVector3;

begin
  for StarPos in  Stars do
    DrawCube(StarPos, STAR_SIZE, STAR_SIZE, STAR_SIZE, WHITE);
end;


procedure DrawRoad;
begin
  DrawRoadParticles;
  DrawRoadForceField;
  DrawSideLines;
  DrawInnerLines;
end;


procedure DrawHighway;
begin
  UpdateHighwayLogic;

  ClearBackground(BGColor);

  BeginMode3D(PlayerCamera);

    DrawRoad;
    DrawStars;

  EndMode3D;
end;

INITIALIZATION

  InitColors;
end.
