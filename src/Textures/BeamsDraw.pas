unit BeamsDraw;
{$mode ObjFPC}{$H+}

INTERFACE

uses
  Raylib,
  Core,
  BeamsLogic;

procedure DrawBeams;

IMPLEMENTATION

procedure SetColor(var FullColor, AuraColor : TColor; Size: TBeamSize);
const
  JUMP = MAX_BEAM_SIZE div 6;

begin

  with FullColor do
  begin
    case Size of
      0..JUMP:
        begin
          R := 64;
          G := 59;
          B := 228
        end;
      JUMP+1..JUMP*2:
        begin
          R := 59;
          G := 228;
          B := 228
        end;
      JUMP*2+1..JUMP*3:
        begin
          R := 76;
          G := 228;
          B := 59
        end;
      JUMP*3+1..JUMP*4:
        begin
          R := 228;
          G := 226;
          B := 59
        end;
      JUMP*4+1..JUMP*5:
        begin
          R := 228;
          G := 122;
          B := 59
        end;
      else
        begin
          R := 228;
          G := 59;
          B := 60
        end;
    end;

    AuraColor.R := R;
    AuraColor.G := G;
    AuraColor.B := B;

    FullColor.A := 255;
    AuraColor.A := 200;
  end;
end;


procedure DrawbeamBase(Beam: TBeam; FullColor, AuraColor: TColor);
const
  AURA_WIDTH = BEAM_WIDTH + BEAM_AURA;

begin
  with Beam do
  begin
    DrawCube(Pos, BEAM_WIDTH, Size, BEAM_WIDTH, FullColor);
    DrawCube(Pos, AURA_WIDTH, Size + BEAM_AURA, AURA_WIDTH, AuraColor);
  end;
end;


procedure DrawBeamExtra(Beam: TBeam; FullColor, AuraColor: TColor);
const
  NORMAL_WIDTH = BEAM_WIDTH div 3;
  AURA_WIDTH = BEAM_WIDTH div 3 + BEAM_AURA div 3;
  NORMAL_HEIGHT = 400;
  AURA_HEIGHT = NORMAL_HEIGHT + BEAM_AURA div 3;

begin
  with Beam do
  begin
    DrawCube(Pos, AURA_WIDTH, AURA_HEIGHT, AURA_WIDTH, AuraColor);
  end;
end;


procedure DrawBeam(var Beam: TBeam);
var
  FullColor, AuraColor: TColor;

begin
  with Beam do
  begin

    SetColor(FullColor, AuraColor, Size);

    Pos.X := HIGHWAY_WIDTH div 2 + BEAM_OFFSET + BEAM_AURA + BEAM_WIDTH div 2;
    DrawBeamExtra(Beam, FullColor, AuraColor);
    DrawBeamBase(Beam, FullColor, AuraColor);

    Pos.X := -HIGHWAY_WIDTH div 2 - BEAM_OFFSET - BEAM_AURA - BEAM_WIDTH div 2;
    DrawBeamExtra(Beam, FullColor, AuraColor);
    DrawBeamBase(Beam, FullColor, AuraColor);
  end
end;


procedure DrawBeams;
var
  I: integer;

begin
  UpdateBeams;

  for I := low(Beams) to high(Beams) do
    DrawBeam(Beams[I]);
end;

INITIALIZATION
end.
