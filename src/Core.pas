unit Core;
{$mode ObjFPC}{$H+}

{
  This unit is used for storing values used all over the place
}

INTERFACE

uses 
  sysutils;

const
  WINDOW_WIDTH = 1024;
  WINDOW_HEIGHT = 768;

  TARGET_FPS = 60;

  HIGHWAY_WIDTH = 150;
  HIGHWAY_LENGTH = 800;

  CAMERA_Z = -150;
  MAP_END = CAMERA_Z - 100;

  PLAY_FIELD_BEGIN = CAMERA_Z + 50;
  PLAY_FIELD_END = 200;
  PLAY_FIELD_TOP = 55;
  PLAY_FIELD_BOTTOM = 3;
  PLAY_FIELD_PLAYER_END = 150;

var
  RoadSpeed: double = 4;
  DataDir, SourceDir: string;

function deg2rad(deg: real): real;

IMPLEMENTATION

function deg2rad(deg: real): real;
const
  TRANSFORM = PI/180;

begin
  Result := deg * TRANSFORM;
end;

INITIALIZATION
  // TODO: Search for data in various places
  SourceDir := ExtractFilePath(ParamStr(0));
  DataDir := SourceDir + '../data/';

end.
