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
  TBeamSize = 1..MAX_BEAM_SIZE;

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
  MusicData: array of TBeamSize;
  MusicDataIndex: integer;


procedure IncMusicDataIndex;
begin
  MusicDataIndex := (MusicDataIndex + 1) mod length(MusicData);
end;


{
  This procedure will take wave samples and fill MusicData with them
  Each beam data in MusicData is average of multiple samples
  they are converted to fitting range based on min and max values
  of the samples
}
procedure SamplesToMusicData(WaveSamples: TSamples; SampleRate: Cardinal;
                             MaxValue, MinValue: single);
var
  I, SamplesPerBeam, SamplesDone, InsertIndex : integer;
  Delta, Sum : single;
  MovePerSecond, SecondsPerGap : real;

begin
  MovePerSecond := TARGET_FPS * RoadSpeed;
  SecondsPerGap := BEAMS_GAP / MovePerSecond;
  SamplesPerBeam := trunc(SecondsPerGap * SampleRate);

  setLength(MusicData, length(WaveSamples) div SamplesPerBeam);

  Sum := 0;
  SamplesDone := 0;
  InsertIndex := 0;
  Delta := MaxValue - MinValue;

  for I := 0 to length(WaveSamples)-1 do
  begin
    // convert to 0..1 range
    Sum := Sum + ((WaveSamples[I] - MinValue) / Delta);

    inc(SamplesDone);
    if SamplesDone = SamplesPerBeam then
    begin
      MusicData[InsertIndex] := round(Sum / SamplesPerBeam * MAX_BEAM_SIZE);

      Sum := 0;
      SamplesDone := 0;
      inc(InsertIndex);
    end;
  end;
end;


procedure SetWaveData(FileName: string);
var
  I: integer;
  Wave: TWave;
  Val, MinValue, MaxValue : single;
  WaveSamples: TSamples;
  DataPtr: Psingle;

begin
  Wave := LoadWave(DataDir + 'music/' + FileName);
  with Wave do
  begin
    MinValue := 10000000;
    MaxValue := 0;

    setLength(WaveSamples, FrameCount);
    writeln(FrameCount, ' ', Length(WaveSamples));
    DataPtr := Psingle(Data);

    // TODO: Support 16 and 8 bit waves
    if SampleSize = 32 then
    begin
      for I := 0 to FrameCount-1 do
      begin
        Val := abs(DataPtr^);

        if Val < MinValue then
          MinValue := Val;
        if Val > MaxValue then
          MaxValue := Val;

        WaveSamples[I] := Val;

        inc(DataPtr, Channels);
      end;
    end;
    writeln(FrameCount);

    SamplesToMusicData(WaveSamples, SampleRate, MinValue, MaxValue);
  end;

  setLength(WaveSamples, 0);
  UnloadWave(Wave);
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
      Size := MusicData[MusicDataIndex];
    end;

    IncMusicDataIndex;
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
          Size := MusicData[MusicDataIndex];
          IncMusicDataIndex;
        end;
      end
end;


procedure UpdateBeams;
begin
  MoveBeams;
end;

end.

