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
  // Center lines
  LINE_WIDTH = 3; 
  LINE_LENGTH = 20;
  LINE_GAP = 30;
  LINE_ROWS = 3;

{
  -- Road Particles --
  Road is transparent on a black background
  I will draw a bunch of white stuff under it, so it looks good
  Hopefully...
}
  RP_WIDTH = 4;
  RP_LENGTH = 30;
  RP_COUNT = 3000;

  STARS_COUNT = 1000;
  STARS_SPREAD_HOR = 200;
  STARS_HOR_OFFSET = 60;
  STARS_SPREAD_VERT = 140;
  // stars x highway gap
  STARS_GAP = 70;
  STAR_SIZE = 0.8;

var
  RoadSpeed: integer = 3;
  StarSpeed: double = 1.8;
 
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

  LinesMoved: integer = 0;

  RoadParticles: array[1..RP_COUNT] of TVector3;
  Stars: array[1..STARS_COUNT] of TVector3;


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


procedure InitRoadParticles;
var
  I: integer;

begin
  for I := low(RoadParticles) to high(RoadParticles) do
  begin
    with RoadParticles[I] do
    begin
      Y := -2;
      X := random(HIGHWAY_WIDTH) - HIGHWAY_WIDTH div 2;
      Z := -(random(HIGHWAY_LENGTH) - HIGHWAY_LENGTH div 2);
    end;
  end;
end;


procedure InitStars;
var
  I: integer;

begin
  for I := low(Stars) to high(Stars) do
  begin
    with Stars[I] do
    begin
      // choose side
      if random(2) = 0 then
        X := random(STARS_SPREAD_HOR) + HIGHWAY_WIDTH div 2 + STARS_GAP
      else
        X := -random(STARS_SPREAD_HOR) - HIGHWAY_WIDTH div 2 - STARS_GAP;

      Z := -(random(HIGHWAY_LENGTH) - HIGHWAY_LENGTH div 2);
      Y := random(STARS_SPREAD_VERT) - STARS_SPREAD_VERT div 2
                                     - STARS_HOR_OFFSET;
    end;
  end;
end;


procedure MoveLines;
begin
  LinesMoved := (LinesMoved + RoadSpeed) mod (LINE_LENGTH + LINE_GAP);
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


procedure ResetRoadParticle(var Particle: TVector3);
var
  Offset: integer;

begin
  Offset := random(41) - 20;
  Particle.Z := (HIGHWAY_LENGTH div 2) + Offset;
end;


procedure MoveRoadParticles;
var
  I: integer;

begin
  for I := low(RoadParticles) to high(RoadParticles) do
  begin

    with RoadParticles[I] do
    begin
      // no INC, because Z is float
      Z := Z - RoadSpeed;
      if Z < -HIGHWAY_LENGTH div 2 then
        ResetRoadParticle(RoadParticles[I]);
    end;
  end;
end;


procedure DrawRoadParticles;
var
  ParticlePos: TVector3;
  ParticleSize: TVector2 = (X: real(RP_WIDTH); Y: real(RP_LENGTH));

begin
  for ParticlePos in RoadParticles do
    DrawPlane(ParticlePos, ParticleSize, WHITE);
end;


procedure ResetStar(var Star: TVector3);
var
  Offset: integer;

begin
  Offset := random(41) - 20;

  with Star do
  begin
    Z := (HIGHWAY_LENGTH div 2) + Offset;
    Y := random(STARS_SPREAD_VERT) - STARS_SPREAD_VERT div 2 - STARS_HOR_OFFSET;

    if X > 0 then
      X := random(STARS_SPREAD_HOR) + HIGHWAY_WIDTH div 2 + STARS_GAP
    else
      X := -random(STARS_SPREAD_HOR) - HIGHWAY_WIDTH div 2 - STARS_GAP;
  end;
end;


procedure MoveStars;
var
  I: integer;
begin

  for I := low(Stars) to high(Stars) do
  begin
    with Stars[I] do
    begin
      Z := Z - StarSpeed;
      if Z < -HIGHWAY_LENGTH div 2 then
        ResetStar(Stars[I])
    end;
  end;
end;


procedure DrawStars;
var
  StarPos: TVector3;

begin
  for StarPos in  Stars do
    DrawCube(StarPos, STAR_SIZE, STAR_SIZE, STAR_SIZE, WHITE);
end;


procedure Move;
begin
  MoveLines;
  MoveRoadParticles;
  MoveStars;
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
  Move;

  ClearBackground(BGColor);

  BeginMode3D(PlayerCamera);

    DrawRoad;
    DrawStars;

  EndMode3D;
end;

INITIALIZATION

  InitColors;
  InitRoadParticles;
  InitStars;
end.
