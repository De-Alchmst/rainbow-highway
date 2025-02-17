unit EntityBase;
{$mode ObjFPC}{$H+}

INTERFACE

uses
  Core,
  Raylib,
  Collisions,
  Textures;

type
  TEntityBase = class
  public
    TextureList: TTextureNameList; static;
    HitBox: THitBox;

    constructor Create(StartPos: TVector3); virtual; abstract;

    procedure Draw; virtual; abstract;
    procedure Update(Index: integer); virtual; abstract;
  end;

IMPLEMENTATION

end.
