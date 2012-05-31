{**
@Abstract(Процесс выполнения команд для агентов)
@Author(Prof1983 prof1983@ya.ru)
@Created(20.03.2007)
@LastMod(26.04.2012)
@Version(0.5)

Термины:
сообщение - текстовое сообщение обмена информацией меду агентами и БЗ.
команда - последовательность действий, которая выполняется относительно быстро
задание - сложная последовательность действий, с запросами к пользователю и внешней среде,
  с формированием подзаданий и т.д.
глобальное задание - глобальные основопологающие задания. Например:
  узнать есть ли Бог,
  узнать есть ли инопланетяне,
  учиться, развиваться.

Процесс выполнения команд для агентов спроектирован таким образом, что
можно завершить работу программы и продолжить выполнение с того места где закончили.
Процесс выполнения сохраняется в ComandLine.
(еще не реализовано)

Агент работает взаимодействует с другими агентами, БЗ, и внешней средой только
путем обмена сообщениями в виде текстовой строки.
Формат строки регламентируется языком AQL.

В агенте реализована работа с конвеером сообщений,
с конвеером команд,
с конвеером заданий и
с конвеером глобальных заданий.
(еще не реализовано)

Работа агента реализуется следующим образом (выполняем по порядку):
1. Рассматривается конвеер сообщений
  1.1. выделяются запросы
    на запрос о состоянии, параметрах и т.д. ответ отправляется сразу
  1.2. выделяются команды
    команды помещаются в конвеер команд
    если конвеер команд переполнен, то отправляется ответ с ошибкой
  1.3. выделяются задания
    задания помещаются в конвеер заданий
    если конвеер заданий переполнен, то отправляется ответ с ошибкой
2. Выполнение команды
  2.1. если список команд пуст, то goto 3
  2.2. выполняем одну команду
  2.3. после выполнения команды goto 1
3. Выполнение задания
  3.1. если список заданий пуст, то goto 4
  3.2. выполняем одно или несколько небольших действий для выполнения задания
  3.3. goto 1
4. Выполнение глобального задания
  3.1. выполняем одно или несколько небольших действий для выполнения глобального задания
  3.2. goto 1
}
unit AiAgentProcess;

interface

uses
  SysUtils,
  AiCommandsImpl, AiInterpretatorThread, AiMessagesImpl, AiProcessImpl, AiTaskImpl, AiTasksImpl;

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
