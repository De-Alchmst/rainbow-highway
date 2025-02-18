unit TexturePlate;
{$mode ObjFPC}{$H+}

INTERFACE

uses
  Core,
  Raylib,
  Rlgl,
  Textures;

const
  DEF_SCALE = 1;

procedure DrawTexturePlate(Texture: TTexture2D; Position, Origin: TVector3;
                           rotX: integer = 0; rotY: integer = 0;
                           rotZ: integer = 0; scale: real = DEF_SCALE);

IMPLEMENTATION

procedure DrawTexturePlate(Texture: TTexture2D; Position, Origin: TVector3;
                           RotX: integer = 0; RotY: integer = 0;
                           RotZ: integer = 0; Scale: real = DEF_SCALE);
var
  Width, Height, Nx, Ny, Nz : real;

begin
  {
    TODO: actually rotate stuff
  }
  Width  := Texture.Width  * Scale;
  Height := Texture.Height * Scale;

  Nx := sin(deg2rad(RotX));
  Ny := sin(deg2rad(RotY + 90));
  Nz := sin(deg2rad(RotZ));

  RlSetTexture(Texture.Id);

  RlBegin(RL_QUADS);
    RlColor4ub(255, 255, 255, 255);

    with Origin do
    begin
      // What does this even do?
      RlNormal3f(Nx, Ny, Nz);

      // after a lot of trial and error:
      RlTexCoord2f(0, 0); RlVertex3f(X,         Y + Position.Y, Z);
      RlTexCoord2f(0, 1); RlVertex3f(X,         Y + Position.Y, Z - Height);
      RlTexCoord2f(1, 1); RlVertex3f(X - Width, Y + Position.Y, Z - Height);
      RlTexCoord2f(1, 0); RlVertex3f(X - Width, Y + Position.Y, Z);
    end;
    
  RlEnd;

  RlSetTexture(0);

end;

INITIALIZATION

end.
