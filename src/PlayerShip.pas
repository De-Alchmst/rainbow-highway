unit PlayerShip;
{$mode ObjFPC}{$H+}

INTERFACE

uses
  Core,
  Raylib,
  Textures,
  TexturePlate,
  EntityBase;

type
  TPlayerShip = class(TEntityBase)
  private
    Bottom, Base, Top : TTexture2D; static;

  public
    procedure Draw; override;
  end;

IMPLEMENTATION

procedure TPlayerShip.Draw;
begin
end;


INITIALIZATION

  with TPlayerShip do
  begin
    TextureList := TTextureNameList.Create(
      'lone-comrad-bottom',
      'lone-comrad-base',
      'lone-comrad-top'
    );

    Bottom := LoadStaticTextureFromFile('lone-comrad-bottom');
    Base   := LoadStaticTextureFromFile('lone-comrad-base');
    Top    := LoadStaticTextureFromFile('lone-comrad-top');
  end;


end.
