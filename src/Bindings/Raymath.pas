unit Raymath;
{$mode ObjFPC}{$H+}
{$MACRO ON}

INTERFACE

{$ifndef WINDOWS}
  {$ifdef STATIC}
    // static raylib does not include 'libc' and 'libm'
    {$linklib c}
    {$linklib m}
    {$linklib raylib, static}
    
  {$else}
    {$linklib raylib}
  {$endif}
  
  {$define ext:=external}
  
{$else}
  {$define ext:=cdecl; external 'raylib.dll'}
{$endif}

uses
  ctypes,
  Raylib;
  

function Vector3RotateByAxisAngle(v, axis : TVector3; angle: cfloat): TVector3;
ext;

function Vector3Add(v1, v2: TVector3): TVector3;
ext;

IMPLEMENTATION

end.
