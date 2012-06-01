{**
@Abstract(Класс для сохранения параметров в INI файл)
@Author(Prof1983 prof1983@ya.ru)
@Created(29.06.2007)
@LastMod(01.06.2012)
@Version(0.5)
}
unit ARemindSettingsSaver;

interface

uses
  IniFiles, SysUtils, Windows,
  ARemindSettings;

type //** Класс для сохранения параметров в INI файл
  TSettingsSaver = class
  public
    class function Save(Settings: TSettings; FileName: WideString): Boolean;
  end;

implementation

{ TSettingsSaver }

class function TSettingsSaver.Save(Settings: TSettings; FileName: WideString): Boolean;
var
  f: TIniFile;
begin
  Result := False;
  if not(Assigned(Settings)) then Exit;
  if (FileName = '') then Exit;

  SysUtils.DeleteFile(FileName);

  Result := False;
  try
    f := TIniFile.Create(FileName);
  except
    Exit;
  end;

  try
    f.WriteString('General', 'Title', Settings.Title);
    f.WriteInteger('General', 'TaskTypeID', Settings.TaskTypeID);
  except
  end;

  f.Free();
  Result := True;
end;

end.
