{**
@Abstract(Процесс выполнения команд для агентов)
@Author(Prof1983 prof1983@ya.ru)
@Created(07.01.2006)
@LastMod(08.06.2012)
@Version(0.5)
}
unit AiProcessObj;

interface

uses
  Classes,
  ATypes,
  AiFrameObj;

type // Процесс выполнения какого-либо метода(процедуры или функции). Используется в TAIAgent
  TAiProcess2006 = class(TAiFrameObject) //LastMod(14.03.2006)
  private
    FThread: TThread;
  public
    function GetThread(): TThread;
    function SetThread(Value: TThread): TError;
  end;

  { Процесс выполнения какого-либо метода(процедуры или фенкции).
    Используется в TAiAgent20050915 }
  TAiProcess2005 = class(TAiFrameObject)
  private
    FThread: TThread;
  public
    function GetThread: TThread;
    function SetThread(Value: TThread): TError;
  end;

  //TAiProcess20050525 = TAiProcess2005;
  //TAiProcess20050526 = TAiProcess2005;
  //TAiProcess20050830 = TAiProcess2005;
  //TAiProcess20050915 = TAiProcess2005;

implementation

{ TAiProcess2005 }

function TAiProcess2005.GetThread(): TThread;
begin
  Result := FThread;
end;

function TAiProcess2005.SetThread(Value: TThread): TError;
begin
  if Assigned(FThread) then
    FThread.Terminate();
  FThread := Value;
  Result := 0;
end;

{ TAiProcess2006 }

function TAiProcess2006.GetThread(): TThread;
begin
  Result := FThread;
end;

function TAiProcess2006.SetThread(Value: TThread): TError;
begin
  if Assigned(FThread) then begin
    FThread.Terminate;
  end;
  FThread := Value;
  Result := 0;
end;

end.
