unit HighwayDraw;
{$mode ObjFPC}{$H+}

INTERFACE

uses
  Raylib,
  Core,
  HighwayLogic,
  BeamsDraw;

procedure DrawHighway;

IMPLEMENTATION
var
  BGColor: TColor;
  RoadLineColor: TColor;
  RoadFieldColor: TColor;


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
      LinePos.Z := MAP_END + J * (LINE_LENGTH + LINE_GAP) - LinesMoved;
      DrawPlane(LinePos, LineSize, RoadLineColor);
    end;
  end;
end;


procedure DrawRoadForceField;
var
  FieldPos: TVector3 = (X: 0; Y: -1; Z: HIGHWAY_LENGTH div 2 + MAP_END);
  FieldSize: TVector2 = (X: HIGHWAY_WIDTH; Y: HIGHWAY_LENGTH);

begin
  DrawPlane(FieldPos, FieldSize, RoadFieldColor);
end;


procedure DrawSideLines;
var
  LinePos: TVector3 = (X: 0; Y: 0; Z: HIGHWAY_LENGTH div 2 + MAP_END);
  LineSize: TVector2 = (X: 3; Y: HIGHWAY_LENGTH);

begin
  LinePos.x := - HIGHWAY_WIDTH / 2;
  DrawPlane(LinePos, LineSize, RoadLineColor);

  LinePos.x := + HIGHWAY_WIDTH / 2;
  DrawPlane(LinePos, LineSize, RoadLineColor);
end;


procedure DrawRoadParticles;
const
  PARTICLE_SIZE: TVector2 = (X: real(RP_WIDTH); Y: real(RP_LENGTH));

var
  ParticlePos: TVector3;

begin
  for ParticlePos in RoadParticles do
    DrawPlane(ParticlePos, PARTICLE_SIZE, WHITE);
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

  DrawStars;
  DrawBeams;
  DrawRoad;
end;

INITIALIZATION

  InitColors;
end.
