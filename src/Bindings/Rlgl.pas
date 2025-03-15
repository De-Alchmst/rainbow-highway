unit Rlgl;
{$mode ObjFPC}{$H+}

INTERFACE

uses
  ctypes,
  Raylib;

const
  RL_LINES     = $0001;
  RL_TRIANGLES = $0004;
  RL_QUADS     = $0007;

procedure rlVertexVect3(vect: TVector3);

procedure rlSetTexture(id: cuint);
external;
procedure rlBegin(mode: cint);
external;
procedure rlEnd();
external;
procedure rlColor4ub(r, g, b, a : cuchar);
external;
procedure rlNormal3f(x, y, z : cfloat);
external;

procedure rlTexCoord2f(x, y : cfloat);
external;
procedure rlVertex3f(x, y, z : cfloat);
external;

IMPLEMENTATION

procedure rlVertexVect3(vect: TVector3);
begin
  with Vect do
    rlVertex3f(X, Y, Z);
end;

end.
