unit Raymath;

{$mode ObjFPC}{$H+}

INTERFACE

{$linklib libraylib}

uses
  ctypes,
  Raylib;

function Vector3RotateByAxisAngle(v, axis : TVector3; angle: cfloat): TVector3;
external;

IMPLEMENTATION

end.
