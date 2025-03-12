unit TexturePlate;
{$mode ObjFPC}{$H+}

INTERFACE

uses
  Core,
  Raylib,
  Rlgl,
  Raymath,
  Textures;

const
  DEF_SCALE = 1;

procedure DrawTexturePlate(Texture: TTexture2D; Position, Origin: TVector3;
                           rotX: real = 0; rotY: real = 0;
                           rotZ: real = 0; scale: real = DEF_SCALE);

IMPLEMENTATION

procedure DrawTexCoord(X, Y: real; Off, Origin: TVector3;
                       RotX, RotY, RotZ: real);
const
  X_AXIS: TVector3 = (X: 1; Y: 0; Z: 0);
  Y_AXIS: TVector3 = (X: 0; Y: 1; Z: 0);
  Z_AXIS: TVector3 = (X: 0; Y: 0; Z: 1);

begin
  RlTexCoord2f(X, Y);
  Off := Vector3RotateByAxisAngle(Off, X_AXIS, rotX);
  Off := Vector3RotateByAxisAngle(Off, Y_AXIS, RotY);
  Off := Vector3RotateByAxisAngle(Off, Z_AXIS, RotZ);
  rlVertexVect3(Vector3Add(Off, Origin));
end;

procedure DrawTexturePlate(Texture: TTexture2D; Position, Origin: TVector3;
                           RotX: real = 0; RotY: real = 0;
                           RotZ: real = 0; Scale: real = DEF_SCALE);

var
  Width, Height: real;
  Vect: TVector3;

begin
  Width  := Texture.Width  * Scale;
  Height := Texture.Height * Scale;

  rotX := Deg2rad(RotX);
  RotY := Deg2rad(RotY);
  RotZ := Deg2rad(RotZ);

  RlSetTexture(Texture.Id);

  RlBegin(RL_QUADS);
    RlColor4ub(255, 255, 255, 255);

    with Position do
    begin
      // after a lot of trial and error:
      Vect.X := X;
      Vect.Y := Y;
      Vect.Z := Z;
      DrawTexCoord(0, 0, Vect, Origin, RotX, RotY, RotZ);

      Vect.X := X;
      Vect.Y := Y;
      Vect.Z := Z - Height;
      DrawTexCoord(0, 1, Vect, Origin, RotX, RotY, RotZ);

      Vect.X := X - Width;
      Vect.Y := Y;
      Vect.Z := Z - Height;
      DrawTexCoord(1, 1, Vect, Origin, RotX, RotY, RotZ);

      Vect.X := X - Width;
      Vect.Y := Y;
      Vect.Z := Z;
      DrawTexCoord(1, 0, Vect, Origin, RotX, RotY, RotZ);
    end;
    
  RlEnd;

  RlSetTexture(0);

end;

INITIALIZATION

end.
