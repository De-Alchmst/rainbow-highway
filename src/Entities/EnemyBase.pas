unit EnemyBase;
{$mode ObjFPC}{$H+}

INTERFACE

uses
  Core,
  Raylib,
  EntityBase, AttackBase;

type
  TEnemyBase = class(TEntityBase)
  public
    Health: integer;

    procedure TakeDamage(Damage: integer);
    procedure HandleAttacks(var Entities: TAttacks); virtual; abstract;
  end;

  TEnemies = array of TEnemyBase;

procedure AttackEnemies(Enemies: TEnemies; var Attacks: TAttacks);

procedure ResetEnemies(var Enemies: TEnemies);
procedure UpdateEnemies(var Enemies: TEnemies);
procedure DrawEnemies(Enemies: TEnemies);

IMPLEMENTATION

procedure TEnemyBase.TakeDamage(Damage: integer);
begin
  dec(Health, Damage);
  if Health < 0 then IsAlive := false;
end;


procedure AttackEnemies(Enemies: TEnemies; var Attacks: TAttacks);
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

