unit Rlgl;
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

const
  RL_LINES     = $0001;
  RL_TRIANGLES = $0004;
  RL_QUADS     = $0007;

procedure rlVertexVect3(vect: TVector3);

procedure rlSetTexture(id: cuint);
ext;
procedure rlBegin(mode: cint);
ext;
procedure rlEnd();
ext;
procedure rlColor4ub(r, g, b, a : cuchar);
ext;
procedure rlNormal3f(x, y, z : cfloat);
ext;

procedure rlTexCoord2f(x, y : cfloat);
ext;
procedure rlVertex3f(x, y, z : cfloat);
ext;

IMPLEMENTATION

procedure rlVertexVect3(vect: TVector3);
begin
  with Vect do
    rlVertex3f(X, Y, Z);
end;

end.
