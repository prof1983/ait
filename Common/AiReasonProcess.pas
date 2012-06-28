{**
@Abstract(Процесс выполнения команд агента реализации локального разума)
@Author(Prof1983 prof1983@ya.ru)
@Created(01.04.2007)
@LastMod(28.06.2012)
@Version(0.5)
}
unit AiReasonProcess;

interface

uses
  SysUtils,
  AiAgentProcess, AiGlobalTaskListImpl;

type
  TReasonThread = class(TAgentThread)
  private
    //** Список глобальных заданий
    FGlobalTasks: TAiGlobalTaskList;
  protected
    procedure Execute(); override;
    //** Обработаем глобальное задание
    procedure WorkGlobalTask();
    //** Обработаем глобальные задания
    procedure WorkGlobalTasks();
  public
    //** Список глобальных заданий
    property GlobalTasks: TAiGlobalTaskList read FGlobalTasks write FGlobalTasks;
  end;

type // Процесс выполнения команд агента реализации локального разума
  TAIReasonProcess = class(TAiAgentProcess)
  private
    function GetGlobalTasks: TAiGlobalTaskList;
    procedure SetGlobalTasks(const Value: TAiGlobalTaskList);
  protected
    //** Срабатывает при создании
    procedure DoCreate(); override; safecall;
  public
    //** Список глобальных заданий
    property GlobalTasks: TAiGlobalTaskList read GetGlobalTasks write SetGlobalTasks;
  end;

implementation

{ TAIReasonProcess }

procedure TAIReasonProcess.DoCreate();
begin
  if not(Assigned(FThread)) then
    FThread := TReasonThread.Create();
  inherited DoCreate();
end;

function TAIReasonProcess.GetGlobalTasks(): TAiGlobalTaskList;
begin
  Result := nil;
  if Assigned(FThread) then
  try
    Result := TReasonThread(FThread).GlobalTasks;
  except
  end;
end;

procedure TAIReasonProcess.SetGlobalTasks(const Value: TAiGlobalTaskList);
begin
  if Assigned(FThread) then
  try
    TReasonThread(FThread).GlobalTasks := Value;
  except
  end;
end;

{ TReasonThread }

procedure TReasonThread.Execute();
begin
  repeat
    WorkGlobalTasks();
  until Terminated;
end;

procedure TReasonThread.WorkGlobalTask();
begin
  // ...
  Sleep(100);
  FProgressID := 0;
  FProgressValue := FProgressValue + 1;
  FProgressMsg := '';
  Synchronize(DoProgress);
end;

procedure TReasonThread.WorkGlobalTasks();
begin
  repeat
    WorkTasks();
    if Terminated then Exit;
    // Список заданий пуст. Выполняем глобальное задание.
    WorkGlobalTask();
  until Terminated;
end;

end.
