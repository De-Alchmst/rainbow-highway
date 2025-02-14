unit BeamsLogic;
{$mode ObjFPC}{$H+}

INTERFACE

uses
  Raylib,
  Core;

const
  BEAMS_NUM = 30;
  // beam x beam gap
  BEAMS_GAP = HIGHWAY_LENGTH div BEAMS_NUM;
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
  I, Offset, Value : integer;

begin
  Value := MAX_BEAM_SIZE div 2;

  for I := low(Beams) to high(Beams) do
  begin

    // Move wave
    repeat
      Offset := random(MAX_BEAM_SIZE div 10) - MAX_BEAM_SIZE div 20;
    until (Value + Offset > 0) and (Value + Offset <= MAX_BEAM_SIZE);

    inc(Value, Offset);
    // Value := MAX_BEAM_SIZE;

    // Alter beam
    with Beams[I] do
    begin
      Pos.Y := 0;
      Pos.Z := I * BEAMS_GAP - HIGHWAY_LENGTH div 2;
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

        if Pos.Z < -HIGHWAY_LENGTH div 2 then
          Pos.Z := HIGHWAY_LENGTH div 2
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

