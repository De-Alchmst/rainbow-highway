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

var
  RoadSpeed: double = 4;
  DataDir: string;

IMPLEMENTATION

INITIALIZATION
  // TODO: Search for data in various places
  DataDir := ExtractFilePath(ParamStr(0)) + '../data/';

end.
