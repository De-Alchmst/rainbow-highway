unit TexturesHandle;
{$mode ObjFPC}{$H+}

INTERFACE

uses
  Core,
  Raylib,
  Textures,
  PlayerShip,
  PlayerShots,
  Droner, Glider;

procedure InitTextures;
procedure DeinitTextures;

IMPLEMENTATION

procedure LoadStaticTexturesFromList(List: TTextureNameList);
var
  FileName: string;

begin
  for FileName in List do
    LoadStaticTextureFromFile(FileName);
end;


procedure LoadStaticTextures;
begin
  LoadStaticTexturesFromList(PLAYER_SHIP_TEXTURE_LIST);
  LoadStaticTexturesFromList(BASIC_PLAYER_SHOT_TEXTURE_LIST);

  LoadStaticTexturesFromList(DRONER_TEXTURE_LIST);
  LoadStaticTexturesFromList(GLIDER_TEXTURE_LIST);
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
