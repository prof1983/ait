{**
@Abstract(Класс для загрузки параметров из INI файла)
@Author(Prof1983 prof1983@ya.ru)
@Created(06.07.2007)
@LastMod(02.05.2012)
@Version(0.5)

История версий:
0.0.0.1 - 06.07.2007 - Создал на основе Reminder.SettingsLoader
}
unit AiEntityStorageSettingsLoader;

interface

uses
  IniFiles,
  AiEntityStorageSettings;

type //** @abstract(Класс для загрузки параметров из INI файла)
  TEntityStorageSettingsLoader = class
  public
    class function Load(Settings: TEntityStorageSettings; FileName: WideString): Boolean;
  end;

implementation

{ TEntityStorageSettingsLoader }

class function TEntityStorageSettingsLoader.Load(Settings: TEntityStorageSettings; FileName: WideString): Boolean;
var
  f: TIniFile;
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
