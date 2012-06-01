{**
@Abstract(Процесс выполнения команд агента реализации локального разума)
@Author(Prof1983 prof1983@ya.ru)
@Created(01.04.2007)
@LastMod(27.04.2012)
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
    FGlobalTasks: TAIGlobalTaskList3;
  protected
    procedure Execute(); override;
    //** Обработаем глобальное задание
    procedure WorkGlobalTask();
    //** Обработаем глобальные задания
    procedure WorkGlobalTasks();
  public
    //** Список глобальных заданий
    property GlobalTasks: TAIGlobalTaskList3 read FGlobalTasks write FGlobalTasks;
  end;
  //TReasonThread3 = TReasonThread;

type // Процесс выполнения команд агента реализации локального разума
  TAIReasonProcess = class(TAIAgentProcess3)
  private
    function GetGlobalTasks: TAIGlobalTaskList3;
    procedure SetGlobalTasks(const Value: TAIGlobalTaskList3);
  protected
    //** Срабатывает при создании
    procedure DoCreate(); override; safecall;
  public
    //** Список глобальных заданий
    property GlobalTasks: TAIGlobalTaskList3 read GetGlobalTasks write SetGlobalTasks;
  end;
  TAIReasonProcess3 = TAIReasonProcess;

implementation

{ TAIReasonProcess }

procedure TAIReasonProcess.DoCreate();
begin
  if not(Assigned(FThread)) then
    FThread := TReasonThread.Create();
  inherited DoCreate();
end;

function TAIReasonProcess.GetGlobalTasks(): TAIGlobalTaskList3;
begin
  Result := nil;
  if Assigned(FThread) then
  try
    Result := TReasonThread(FThread).GlobalTasks;
  except
  end;
end;

procedure TAIReasonProcess.SetGlobalTasks(const Value: TAIGlobalTaskList3);
begin
  if Assigned(FThread) then
  try
    TReasonThread(FThread).GlobalTasks := Value;
  except
  end;
end;

{ TReasonThread3 }

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
