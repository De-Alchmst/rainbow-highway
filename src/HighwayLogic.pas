unit HighwayLogic;
{$mode ObjFPC}{$H+}

INTERFACE

uses
  Raylib,
  Core;

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
  RP_COUNT = 1600;

  STARS_LENGTH = 1000 - MAP_END;
  STARS_COUNT = 700;
  STARS_SPREAD_HOR = 200;
  STARS_VERT_OFFSET = 80;
  STARS_SPREAD_VERT = 180;
  // stars x highway gap
  STARS_GAP = 70;
  STAR_SIZE = 0.8;


var
  RoadParticles: array[1..RP_COUNT] of TVector3;
  Stars: array[1..STARS_COUNT] of TVector3;
 
  LinesMoved: double = 0;


procedure UpdateHighwayLogic;

IMPLEMENTATION

var
  StarSpeed: double = 1.8;


procedure InitRoadParticles;
var
  I: integer;

begin
  for I := low(RoadParticles) to high(RoadParticles) do
    with RoadParticles[I] do
    begin
      Y := -2;
      X := random(HIGHWAY_WIDTH) - HIGHWAY_WIDTH div 2;
      Z := random(HIGHWAY_LENGTH) + MAP_END;
    end;
end;


procedure InitStars;
var
  I: integer;

begin
  for I := low(Stars) to high(Stars) do
    with Stars[I] do
    begin
      // choose side
      if random(2) = 0 then
        X := random(STARS_SPREAD_HOR) + HIGHWAY_WIDTH div 2 + STARS_GAP
      else
        X := -random(STARS_SPREAD_HOR) - HIGHWAY_WIDTH div 2 - STARS_GAP;

      Z := random(STARS_LENGTH) + MAP_END;
      Y := random(STARS_SPREAD_VERT) - STARS_SPREAD_VERT div 2
                                     - STARS_VERT_OFFSET;
    end;
end;


procedure MoveLines;
begin
  LinesMoved := LinesMoved + RoadSpeed;
  if LinesMoved > LINE_LENGTH + LINE_GAP then
    LinesMoved := LinesMoved - (LINE_LENGTH + LINE_GAP);
end; 


procedure ResetRoadParticle(var Particle: TVector3);
var
  Offset: integer;

begin
  Offset := random(41) - 20;
  Particle.Z := HIGHWAY_LENGTH + MAP_END + Offset;
end;


procedure MoveRoadParticles;
var
  I: integer;

begin
  for I := low(RoadParticles) to high(RoadParticles) do
    with RoadParticles[I] do
    begin
      // no INC, because Z is float
      Z := Z - RoadSpeed;
      if Z < MAP_END then
        ResetRoadParticle(RoadParticles[I]);
    end;
end;


procedure ResetStar(var Star: TVector3);
var
  Offset: integer;

begin
  Offset := random(41) - 20;

  with Star do
  begin
    Z := STARS_LENGTH + MAP_END + Offset;
    Y := random(STARS_SPREAD_VERT) - STARS_SPREAD_VERT div 2
                                   - STARS_VERT_OFFSET;

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
    with Stars[I] do
    begin
      Z := Z - StarSpeed;
      if Z < MAP_END then
        ResetStar(Stars[I])
    end;
end;


procedure UpdateHighwayLogic;
begin
  MoveLines;
  MoveRoadParticles;
  MoveStars;
end;

INITIALIZATION

  randomize;
  InitRoadParticles;
  InitStars;
end.
