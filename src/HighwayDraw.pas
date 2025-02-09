unit HighwayDraw;
{$mode ObjFPC}{$H+}

INTERFACE

uses
  Raylib,
  Core,
  HighwayLogic;

procedure DrawHighway;

IMPLEMENTATION

var
  BGColor: TColor;

  PlayerCamera: TCamera3D = (
    position: (x: 0; y: 100; z: -200);
    target: (x: 0; y: 0; z: 0);
    up: (x: 0; y: 1; z: 0);
    fovy: 45.0;
    projection: CAMERA_PERSPECTIVE;
  );

procedure DrawHighway;
var
  StripePos: TVector3 = (x: 0; y: 0; z: 0);
  StripeSize: TVector2 = (x: 20; y: 60);

begin
  ClearBackground(BGColor);

  BeginMode3D(PlayerCamera);

    DrawPlane(StripePos, StripeSize, WHITE);

  EndMode3D;
end;

INITIALIZATION

  BGColor := BLACK;
end.
