unit TexturesHandle;
{$mode ObjFPC}{$H+}

INTERFACE

uses
  Core,
  Raylib,
  Textures,
  PlayerShip,
  PlayerShots;

procedure InitTextures;
procedure DeinitTextures;

IMPLEMENTATION

procedure LoadStaticTextures;
var
  FileName: string;
begin
  for FileName in PLAYER_SHIP_TEXTURE_LIST do
    LoadStaticTextureFromFile(FileName);

  LoadStaticTextureFromFile(BASIC_PLAYER_SHOT_TEXTURE_LIST[0]);
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
