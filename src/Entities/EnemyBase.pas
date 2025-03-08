unit EnemyBase;
{$mode ObjFPC}{$H+}

INTERFACE

uses
  Core,
  Raylib,
  EntityBase;

type
  TEnemyBase = class(TEntityBase)
    procedure HandleAttacks(var Entities: TEntities); virtual; abstract;
  end;

  TEnemies = array of TEnemyBase;

procedure AttackEnemies(Enemies: TEnemies; var Attacks: TEntities);

procedure ResetEnemies(var Enemies: TEnemies);
procedure UpdateEnemies(var Enemies: TEnemies);
procedure DrawEnemies(Enemies: TEnemies);

IMPLEMENTATION

procedure AttackEnemies(Enemies: TEnemies; var Attacks: TEntities);
var
  Enemy: TEnemyBase;

begin
  for Enemy in Enemies do
    Enemy.HandleAttacks(Attacks);
end;

procedure ResetEnemies(var Enemies: TEnemies);
begin
  ResetEntities(TEntities(Enemies));
end;


procedure UpdateEnemies(var Enemies: TEnemies);
begin
  UpdateEntities(TEntities(Enemies));
end;


procedure DrawEnemies(Enemies: TEnemies);
begin
  DrawEntities(TEntities(Enemies));
end;

end.

