unit EntityBase;
{$mode ObjFPC}{$H+}

INTERFACE

uses
  Core,
  Raylib,
  Textures;

type
  TEntityBase = class
  public
    TextureList: TTextureNameList; static;
    Pos: TVector3;

    constructor Create(StartPos: TVector3);

    procedure Draw; virtual; abstract;
    procedure Update(index: integer); virtual; abstract;
  end;

IMPLEMENTATION

constructor TEntityBase.Create(StartPos: TVector3);
begin
  Pos := StartPos;
end;

end.
