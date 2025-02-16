unit BeamsLogic;
{$mode ObjFPC}{$H+}

INTERFACE

uses
  Raylib,
  Core;

const
  BEAMS_NUM = 18;
  BEAMS_GAP = 60;
  BEAMS_LENGTH = BEAMS_NUM * BEAMS_GAP;
  // beam x beam gap
  MAX_BEAM_SIZE = 75;
  // beam x xhighway gap
  BEAM_OFFSET = 20;
  BEAM_WIDTH = 8;
  BEAM_AURA = 4;

type
  TBeamSize = 1..MAX_BEAM_SIZE;

  TBeam = record
    Pos : TVector3;
    Size : TBeamSize;
  end;

var
  Beams: array[1..BEAMS_NUM] of TBeam;

procedure UpdateBeams;

IMPLEMENTATION

{
  For now just generate some data
}
procedure InitBeams;
var
  I, Value : integer;

begin
  Value := MAX_BEAM_SIZE div 2;

  for I := low(Beams) to high(Beams) do
  begin

    // For now just get random value
    Value := random(MAX_BEAM_SIZE) + 1;

    // Alter beam
    with Beams[I] do
    begin
      Pos.Y := 0;
      Pos.Z := I * BEAMS_GAP + MAP_END;
      Size := Value;
    end;
  end;
end;


procedure MoveBeams;
var
  I: integer;

begin
  for I := low(Beams) to high(Beams) do
    with Beams[I] do
      begin
        Pos.Z := (Pos.Z - RoadSpeed);

        if Pos.Z < MAP_END then
          Pos.Z := BEAMS_LENGTH + MAP_END
      end
end;


procedure UpdateBeams;
begin
  MoveBeams;
end;

INITIALIZATION

randomize;
InitBeams;

end.

