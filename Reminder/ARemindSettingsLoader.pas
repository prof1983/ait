{**
@Abstract(Класс для загрузки параметров из INI файла)
@Author(Prof1983 prof1983@ya.ru)
@Created(29.06.2007)
@LastMod(01.06.2012)
@Version(0.5)

История версий:
0.0.0.1 - 29.06.2007
}
unit ARemindSettingsLoader;

interface

uses
  IniFiles,
  ARemindSettings;

type //** Класс для загрузки параметров из INI файла
  TSettingsLoader = class
  public
    class function Load(Settings: TSettings; FileName: WideString): Boolean;
  end;

implementation

{ TSettingsLoader }

class function TSettingsLoader.Load(Settings: TSettings; FileName: WideString): Boolean;
var
  f: TIniFile;
  //i: Integer;
begin
  Result := False;
  if not(Assigned(Settings)) then Exit;
  if (FileName = '') then Exit;

  Result := False;
  try
    f := TIniFile.Create(FileName);
  except
    Exit;
  end;

  try
    Settings.Title := f.ReadString('General', 'Title', '');
    Settings.TaskTypeID := f.ReadInteger('General', 'TaskTypeID', 0);
  except
    f.Free();
    Exit;
  end;

  f.Free();
  Result := True;
end;

end.
