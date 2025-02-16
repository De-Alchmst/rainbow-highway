unit TexturePlate;
{$mode ObjFPC}{$H+}

INTERFACE

uses
  Core,
  Raylib,
  Textures;

const
  DEF_SCALE = 1;

procedure DrawTexturePlate(Texture: TTexture2D; Position: TVector3;
                           rotX: integer = 0; rotY: integer = 0;
                           rotZ: integer = 0; scale: real = DEF_SCALE);

IMPLEMENTATION

procedure DrawTexturePlate(Texture: TTexture2D; Position: TVector3;
                           rotX: integer = 0; rotY: integer = 0;
                           rotZ: integer = 0; scale: real = DEF_SCALE);
begin
end;

INITIALIZATION

end.
