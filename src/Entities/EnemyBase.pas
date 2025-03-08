unit EnemyBase;
{$mode ObjFPC}{$H+}

INTERFACE

uses
  Core,
  Raylib,
  Collisions,
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

procedure AttacksDealDamage(var Enemies: TEnemies; var Attacks: TAttacks);

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


procedure AttacksDealDamage(var Enemies: TEnemies; var Attacks: TAttacks);
var
  I, J : integer;
  EnemiesToRemove, AttacksToRemove : array of integer;

begin
  setLength(EnemiesToRemove, 0);

  for I := 0 to length(Enemies)-1 do
  begin

    // collide with attacks
    setLength(AttacksToRemove, 0);

    for J := 0 to length(Attacks)-1 do
      if IsCollideHitBox(Attacks[J].HitBox, Enemies[I].HitBox) then
      begin
        insert(J, AttacksToRemove, 0);
        Enemies[I].TakeDamage(Attacks[J].Damage);
      end;

    // mark enemy for removal
    if Enemies[I].Health <= 0 then
      insert(I, EnemiesToRemove, 0);

    // remove attacks
    for J in AttacksToRemove do
    begin
      Attacks[J].Free;
      delete(Attacks, J, 1);
    end;
  end;

  // remove enemies
  for I in EnemiesToRemove do
  begin
    Enemies[I].Free;
    delete(Enemies, I, 1);
  end;

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

