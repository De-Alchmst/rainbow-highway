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
    HitBox: THitBox;

    constructor Create(StartPos: TVector3); virtual; abstract;

    procedure Draw; virtual; abstract;
    procedure Update(Index: integer); virtual; abstract;
  end;

  TEntities = array of TEntityBase;

IMPLEMENTATION

end.
