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
                           rotX: integer = 0; rotY: integer = 0;
                           rotZ: integer = 0; scale: real = DEF_SCALE);

IMPLEMENTATION

procedure DrawTexCoord(X,Y: real; Vect: TVector3; RotX, RotY, RotZ: integer);
const
  X_AXIS: TVector3 = (X: 1; Y: 0; Z: 0);
  Y_AXIS: TVector3 = (X: 0; Y: 1; Z: 0);
  Z_AXIS: TVector3 = (X: 0; Y: 0; Z: 1);

begin
  RlTexCoord2f(X, Y);
  Vect := Vector3RotateByAxisAngle(Vect, X_AXIS, RotX);
  Vect := Vector3RotateByAxisAngle(Vect, Y_AXIS, RotY);
  Vect := Vector3RotateByAxisAngle(Vect, Z_AXIS, RotZ);
  rlVertexVect3(Vect);
end;

procedure DrawTexturePlate(Texture: TTexture2D; Position, Origin: TVector3;
                           RotX: integer = 0; RotY: integer = 0;
                           RotZ: integer = 0; Scale: real = DEF_SCALE);

var
  Width, Height, DX, DY, DZ : real;
  Vect: TVector3;

begin
  {
    TODO: actually rotate stuff
  }
  Width  := Texture.Width  * Scale;
  Height := Texture.Height * Scale;

  RlSetTexture(Texture.Id);

  RlBegin(RL_QUADS);
    RlColor4ub(255, 255, 255, 255);

    with Origin do
    begin
      // after a lot of trial and error:
      Vect.X := X;
      Vect.Y := Y + Position.Y;
      Vect.Z := Z;
      DrawTexCoord(0, 0, Vect, RotX, RotY, RotZ);

      Vect.X := X;
      Vect.Y := Y + Position.Y;
      Vect.Z := Z - Height;
      DrawTexCoord(0, 1, Vect, RotX, RotY, RotZ);

      Vect.X := X - Width;
      Vect.Y := Y + Position.Y;
      Vect.Z := Z - Height;
      DrawTexCoord(1, 1, Vect, RotX, RotY, RotZ);

      Vect.X := X - Width;
      Vect.Y := Y + Position.Y;
      Vect.Z := Z;
      DrawTexCoord(1, 0, Vect, RotX, RotY, RotZ);
    end;
    
  RlEnd;

  RlSetTexture(0);

end;

INITIALIZATION

end.
