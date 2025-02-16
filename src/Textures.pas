unit Textures;
{$mode ObjFPC}{$H+}

INTERFACE

uses
  fgl,
  Core,
  Raylib;

type
  TTextureNameList = array of string;

{
  Static textures stay there
  Dynamic only hold what is needed at the time
}

function  LoadDynamicTextureFromFile(FileName: string): TTexture2D;
function  LoadStaticTextureFromFile(FileName: string): TTexture2D;
procedure ClearDynamicTextures;

function  TextureFromFileName(FileName: string): TTexture2D;

procedure RemoveTextureFileName(FileName: string);
procedure RemoveTextureID(Id: integer);

  
IMPLEMENTATION

type
  TNameTextureMap = specialize TFPGMap<string, TTexture2D>;

var
  DynamicTextures, StaticTextures : TNameTextureMap;


procedure LoadTextureFromFile(FileName: string; Textures: TNameTextureMap);
begin
  Textures.Add(FileName,
               LoadTexture(DataDir + '/textures/' + FileName + '.png'));
end;


procedure UnloadAllTextures(Textures: TNameTextureMap);
var
  I: integer;

begin
  for I := 0 to Textures.Count-1 do
    UnloadTexture(Textures.Data[I]);
end;


procedure ClearDynamicTextures;
begin
  UnloadAllTextures(DynamicTextures);
end;


function LoadStaticTextureFromFile(FileName: string): TTexture2D;
begin
  LoadTextureFromFile(FileName, StaticTextures);
  Result := StaticTextures.KeyData[FileName];
end;


function LoadDynamicTextureFromFile(FileName: string): TTexture2D;
begin
  LoadTextureFromFile(FileName, DynamicTextures);
  Result := DynamicTextures.KeyData[FileName];
end;


function TextureFromFileName(FileName: string): TTexture2D;
var I: integer;
begin
  if DynamicTextures.Find(FileName, I) then
    Result := DynamicTextures.Data[I]
  else
    Result := StaticTextures.KeyData[FileName];
end;


procedure RemoveTextureFileName(FileName: string);
var
  I: integer;
begin
  if DynamicTextures.Find(FileName, I) then
    DynamicTextures.Remove(FileName)

  else if StaticTextures.Find(FileName, I) then
    StaticTextures.Remove(FileName)
end;


procedure RemoveTextureID(Id: integer);
var
  I: integer;
  Found: boolean;

begin
  Found := false;

  for I := 0 to DynamicTextures.Count-1 do
    if DynamicTextures.Data[I].Id = Id then
    begin
      DynamicTextures.Remove(DynamicTextures.Keys[I]);
      Found := true;
      break;
    end;

    if not Found then
      for I := 0 to StaticTextures.Count-1 do
        if StaticTextures.Data[I].Id = Id then
        begin
          StaticTextures.Remove(StaticTextures.Keys[I]);
          break;
        end;
end;


INITIALIZATION
  DynamicTextures := TNameTextureMap.Create;
  StaticTextures := TNameTextureMap.Create;

FINALIZATION
  UnloadAllTextures(DynamicTextures);
  UnloadAllTextures(StaticTextures);
  DynamicTextures.Free;
  StaticTextures.Free;

end.
