unit BeamsLogic;
{$mode ObjFPC}{$H+}

INTERFACE

uses
  Raylib,
  Core;

const
  BEAMS_NUM = 18;
  // beam x beam gap
  BEAMS_GAP = 60;
  BEAMS_LENGTH = BEAMS_NUM * BEAMS_GAP;
  MAX_BEAM_SIZE = 75;
  // beam x highway gap
  BEAM_OFFSET = 20;
  BEAM_WIDTH = 8;
  BEAM_AURA = 4;

type
  TBeamSize = 0..MAX_BEAM_SIZE;

  TBeam = record
    Pos : TVector3;
    Size : TBeamSize;
  end;

var
  Beams: array[1..BEAMS_NUM] of TBeam;

procedure LoadBeams(FileName: string);
procedure UpdateBeams;

IMPLEMENTATION

type
  TSamples = array of single;
  Psingle = ^single;

var
  MusicData: array of single;
  MusicDataIndex: integer;


{
  This procedure will take wave samples and fill MusicData with them
  Each beam data in MusicData is average of multiple samples
  First I get averages, min and max values. This is sotres in MusicData,
  so that I don't have to make another array.
  This is also why MusicData is not TBeamSize, but single
  Then I normalise MusicData based on min and max values
}
procedure SamplesToMusicData(WaveSamples: TSamples; SampleRate: Cardinal);
var
  I, SamplesPerBeam, SamplesDone, InsertIndex : integer;
  Sum, Val, MinVal, MaxVal, Delta : real;
  MovePerSecond, SecondsPerGap : real;

begin
  MovePerSecond := TARGET_FPS * RoadSpeed;
  SecondsPerGap := BEAMS_GAP / MovePerSecond;
  SamplesPerBeam := trunc(SecondsPerGap * SampleRate);

  setLength(MusicData, length(WaveSamples) div SamplesPerBeam);

  Sum := 0;
  SamplesDone := 0;
  InsertIndex := 0;

  MinVal := 1000;
  MaxVal := 0;

  // get averages, min and max values
  for I := 0 to length(WaveSamples)-1 do
  begin
    Sum := Sum + WaveSamples[I];

    inc(SamplesDone);

    if SamplesDone = SamplesPerBeam then
    begin
      Val := (Sum / SamplesPerBeam);

      if Val < MinVal then MinVal := Val;
      if Val > MaxVal then MaxVal := Val;

      MusicData[InsertIndex] := Val;

      Sum := 0;
      SamplesDone := 0;
      inc(InsertIndex);
    end;
  end;

  Delta := MaxVal - MinVal;

  // normalise
  for I := 0 to length(MusicData)-1 do
    MusicData[I] := (MusicData[I] - MinVal) / Delta;
end;


procedure SetWaveData(FileName: string);
var
  I: integer;
  Wave: TWave;
  WaveSamples: TSamples;
  DataPtr: Psingle;

begin
  Wave := LoadWave(DataDir + 'music/' + FileName);
  with Wave do
  begin
    setLength(WaveSamples, FrameCount);
    DataPtr := Psingle(Data);

    // TODO: Support 16 and 8 bit waves
    if SampleSize = 32 then
    begin
      for I := 0 to FrameCount-1 do
      begin
        WaveSamples[I] := abs(DataPtr^);

        inc(DataPtr, Channels);
      end;
    end;

    SamplesToMusicData(WaveSamples, SampleRate);
  end;

  setLength(WaveSamples, 0);
  UnloadWave(Wave);
end;


function NextBeamSize: TBeamSize;
begin
  Result := round(MusicData[MusicDataIndex] * 6) * MAX_BEAM_SIZE div 6;
  MusicDataIndex := (MusicDataIndex + 1) mod length(MusicData);
end;


procedure LoadBeams(FileName: string);
var
  I: integer;

begin
  SetWaveData(FileName);
  MusicDataIndex := 0;

  for I := low(Beams) to high(Beams) do
  begin
    with Beams[I] do
    begin
      Pos.Y := 0;
      Pos.Z := I * BEAMS_GAP + MAP_END;
      Size := NextBeamSize;
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
        begin
          Pos.Z := BEAMS_LENGTH + MAP_END;
          Size := NextBeamSize;
        end;
      end
end;


procedure UpdateBeams;
begin
  MoveBeams;
end;

end.

