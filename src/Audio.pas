unit Audio;
{$mode ObjFPC}{$H+}

INTERFACE

uses
  Core,
  Raylib;

procedure LoadMusic(FileName: string);
procedure UpdateAudio;
procedure PauseAudio;
procedure ResumeAudio;

IMPLEMENTATION

var
  IsLoaded: boolean = false;
  Music: TMusic;

procedure LoadMusic(FileName: string);
begin
  if IsLoaded then
  begin
    IsLoaded := true;
    UnloadMusicStream(Music);
  end;

  Music := LoadMusicStream(DataDir + 'music/' + FileName);
  PlayMusicStream(Music);
end;


procedure UpdateAudio;
begin
  UpdateMusicStream(Music);
end;


procedure PauseAudio;
begin
  StopMusicStream(Music);
end;


procedure ResumeAudio;
begin
  ResumeMusicStream(Music);
end;

end.
