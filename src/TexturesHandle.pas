unit TexturesHandle;
{$mode ObjFPC}{$H+}

INTERFACE

uses
  Core,
  Raylib,
  Textures,
  PlayerShip;

procedure InitTextures;
procedure DeinitTextures;

IMPLEMENTATION

procedure LoadStaticTextures;
var
  FileName: string;
begin
  for FileName in TPlayerShip.TextureList do
    LoadStaticTextureFromFile(FileName);
end;

procedure InitTextures;
begin
  LoadStaticTextures;
end;

procedure DeinitTextures;
begin
  UnloadAllTextures;
end;

end.
