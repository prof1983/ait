{**
@Abstract(Процесс выполнения команд для агентов)
@Author(Prof1983 prof1983@ya.ru)
@Created(20.03.2007)
@LastMod(26.06.2012)
@Version(0.5)
}
unit AiAgentProcess;

interface

uses
  SysUtils,
  AiCommandsImpl, AiInterpretatorThread, AiMessagesImpl, AiProcessImpl, AiTaskImpl, AiTaskListImpl;

type //** Подпроцесс выполнения команд для агентов
  TAgentThread = class(TInterpretatorThread3)
  private
      //** Конвеер команд
    FCommands: TAICommands;
      //** Конвеер сообщений
    FMessages: TAIMessages;
      //** Конвеер заданий
    FTasks: TAITasks;
  protected
    procedure DoCreate(); override; safecall;
    procedure DoCommand(Cmd: TAiMessageRec); virtual; safecall;
    procedure DoMessage(Msg: TAiMessageRec); virtual; safecall;
    procedure DoTask(Task: TAITask); virtual; safecall;
  protected
    procedure Execute(); override;
      //** Обработаем команды, сообщения
    procedure WorkCommands(); virtual;
      //** Обработаем сообщения
    procedure WorkMessages(); virtual;
      //** Обработаем задания, команды, сообщения
    procedure WorkTasks(); virtual;
  end;
  //TAgentThread3 = TAgentThread;

type //** Процесс выполнения команд для агентов
  TAIAgentProcess = class(TAiProcess)
  private
    function GetMessages(): TAiMessages;
    procedure SetMessages(Value: TAiMessages);
  protected
    //** Срабатывает при создании
    procedure DoCreate(); override; safecall;
  public
    //** Конвеер сообщений
    property Messages: TAIMessages read GetMessages write SetMessages;
  end;
  TAIAgentProcess3 = TAIAgentProcess;

implementation

{ TAIAgentProcess }

procedure TAIAgentProcess.DoCreate();
begin
  if not(Assigned(FThread)) then
    FThread := TAgentThread.Create();
  inherited DoCreate();
end;

function TAIAgentProcess.GetMessages(): TAiMessages;
begin
  Result := TAgentThread(FThread).FMessages;
end;

procedure TAIAgentProcess.SetMessages(Value: TAiMessages);
begin
  TAgentThread(FThread).FMessages := Value;
end;

{ TAgentThread }

procedure TAgentThread.DoCommand(Cmd: TAiMessageRec);
begin
  // ...
end;

procedure TAgentThread.DoCreate();
begin
  inherited DoCreate();
  // Создаем конвеер команд
  if not(Assigned(FCommands)) then
    FCommands := TAICommands.Create();
  // Создаем конвеер сообщений
  if not(Assigned(FMessages)) then
    FMessages := TAIMessages.Create();
  // Создаем конвеер заданий
  if not(Assigned(FTasks)) then
    FTasks := TAITasks.Create();
end;

procedure TAgentThread.DoMessage(Msg: TAiMessageRec);
begin
    // ...
    // На сообщения о запросе ответим
    // ...
end;

procedure TAgentThread.DoTask(Task: TAITask);
begin
  // ...
end;

procedure TAgentThread.Execute();
begin
  repeat
    // Выполняем задания, команды, сообщения
    WorkTasks();
  until Terminated;
end;

procedure TAgentThread.WorkCommands();
var
  cmd: TAiMessageRec;
begin
  try
    repeat
      // Обработаем сообщения
      WorkMessages();
      // Список сообщений пуст.
      if not(Terminated) then
      begin
        if not(FCommands.GetNextMessage(cmd)) then Break;
        // Выполним команду.
        DoCommand(cmd);
      end;
    until Terminated;
  except
  end;
end;

procedure TAgentThread.WorkMessages();
var
  msg: TAiMessageRec;
begin
  try
    while not(Terminated) and FMessages.GetNextMessage(msg) do
    begin
      DoMessage(msg);
    end;
  except
  end;
end;

procedure TAgentThread.WorkTasks();
var
  Counter: Integer;
  Task: TAITask;
begin
  Counter := 0;
  try
    repeat
      // Обработаем команды
      WorkCommands();

      // Список команд пуст.
      if not(Terminated) then
      begin
        // Выполним задание.
        Task := nil; //FTasks.GetNextTask(Task);
        if not(Assigned(Task)) then Break;
        DoTask(Task);
      end;
      Inc(Counter);
    until Terminated or (FTasks.TaskCount <= 0) or (Counter > 100);
  except
  end;
end;

end.
