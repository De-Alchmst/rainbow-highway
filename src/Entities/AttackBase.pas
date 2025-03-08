unit AttackBase;
{$mode ObjFPC}{$H+}

INTERFACE

uses
  Core,
  Raylib,
  Collisions,
  Textures,
  EntityBase;

type
  TAttackDirection = (Forwards, Backwards);

  TAttackBase = class(TEntityBase)
  public
    Direction: TAttackDirection;
    Damage: integer;

    constructor Create(StartPos: TVector3; Sp: real; Dm: integer);
    reintroduce;
    procedure Update; override;
  end;

  TAttacks = array of TAttackBase;

procedure ResetAttacks(var Attacks: TAttacks);
procedure UpdateAttacks(var Attacks: TAttacks);
procedure DrawAttacks(Attacks: TAttacks);

IMPLEMENTATION

constructor TAttackBase.Create(StartPos: TVector3; Sp: real; Dm: integer);
begin
  Speed := Sp;
  Damage := Dm;
  IsAlive := true;
end;


procedure TAttackBase.Update;
begin
  with HitBox, Origin do
  begin
    if Direction = Forwards then
    begin
      Z := Z + Speed;

      if Z > HIGHWAY_LENGTH then
        IsAlive := false;
    end
    
    else
    begin
      Z := Z - Speed;

      if Z < MAP_END then
        IsAlive := false;
    end;
  end;
end;


procedure ResetAttacks(var Attacks: TAttacks);
begin
  ResetEntities(TEntities(Attacks));
end;


procedure UpdateAttacks(var Attacks: TAttacks);
begin
  UpdateEntities(TEntities(Attacks));
end;


procedure DrawAttacks(Attacks: TAttacks);
begin
  DrawEntities(TEntities(Attacks));
end;

end.
