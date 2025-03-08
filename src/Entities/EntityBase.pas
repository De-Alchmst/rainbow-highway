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
    Speed: real;
    IsAlive: boolean;

    constructor Create(StartPos: TVector3); virtual; abstract;

    procedure Draw; virtual; abstract;
    procedure Update; virtual; abstract;
  end;

  TEntities = array of TEntityBase;

procedure ResetEntities(var Entities: TEntities);
procedure UpdateEntities(var Entities: TEntities);
procedure DrawEntities(Entities: TEntities);

IMPLEMENTATION

procedure ResetEntities(var Entities: TEntities);
var
  Ent: TEntityBase;

begin
  for Ent in Entities do
    Ent.Free;
  setLength(Entities, 0);
end;


procedure UpdateEntities(var Entities: TEntities);
var
  I: integer;
  ToRemove: array of integer;

begin
  setLength(ToRemove, 0);

  for I := 0 to length(Entities)-1 do
  begin
    Entities[I].Update;

    if not Entities[I].IsAlive then
      insert(I, ToRemove, 0);
  end;

  for I in ToRemove do
  begin
    Entities[I].free;
    delete(Entities, I, 1);
  end;
end;


procedure DrawEntities(Entities: TEntities);
var
  Ent: TEntityBase;
  
begin
  for Ent in Entities do
    Ent.Draw;

end;

end.
