{**
@Abstract Процесс выполнения команд для агентов
@Author Prof1983 <prof1983@ya.ru>
@Created 07.01.2006
@LastMod 17.12.2012
}
unit AiProcessObj;

interface

uses
  Classes,
  ABase,
  ATypes,
  AiFrameObj;

type
  {**
    Процесс выполнения какого-либо метода (процедуры или функции).
    Используется в TAiAgentObject
  }
  TAiProcessObject = class(TAiFrameObject)
  protected
    FThread: TThread;
  public
    function GetThread(): TThread;
    function SetThread(Value: TThread): AError;
  end;

  //TAiProcess = TAiProcessObject;
  //TAiProcess2005 = TAiProcessObject;

implementation

{ TAiProcessObject }

function TAiProcessObject.GetThread(): TThread;
begin
  Result := FThread;
end;

function TAiProcessObject.SetThread(Value: TThread): AError;
begin
  if Assigned(FThread) then
    FThread.Terminate;
  FThread := Value;
  Result := 0;
end;

end.
