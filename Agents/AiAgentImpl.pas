{**
@Abstract Базовый класс для агента
@Author Prof1983 <prof1983@ya.ru>
@Created 22.09.2005
@LastMod 23.11.2012

Агент - это модуль, который имеет свой подпроцесс выполнения команд (Thread).

Агенты общаются между собой.
Агенты делают запросы к БЗ и получают ответы от БЗ.
Для формирования и расбора сообщений агент использует кодек (codec).
Для передачи сообщения агент использует транспортный объект.
}
unit AiAgentImpl;

interface

uses
  ABase, AConsts2, ATypes,
  AclMessageIntf,
  AiAgentIntf, AiAgentProcess, AiBase, AiBaseTypes, AiInterpretatorIntf, AiMessagesImpl, AiModuleImpl;

type //** Статус агента
  TAiAgentStatus1 = (
      //** Остановлен
    AgentStatusStoped,
      //** Приостановлен
    AgentStatusPaused,
      //** Работает
    AgentStatusRuned
    );

type
  // TODO: Rename TAiAgentStatus -> TAiAgentStatus2
  //** @abstract(Статус агента)
  TAiAgentStatus2 = TThreadState;
  //TAiAgentStatus = TAiAgentStatus2;
const
    //** @abstract(Остановлен)
  AGENT_STATUS_STOPED = tsTerminated;
    //** @abstract(Приостановлен)
  AGENT_STATUS_PAUSED = tsPaused;
    //** @abstract(Работает)
  AGENT_STATUS_RUNED  = tsStarted;
    //** @abstract(Не известно)
  AGENT_STATUS_UNCNOWN = tsUncnown;

type
  TAiRecAgent = record
    Id: TAiId;
    Agent: IAiAgent;
  end;
  TAiAgentRec3 = TAiRecAgent;

type // Базовый класс для агента
  TAiAgent = class(TAiModule, IAiAgent)
  protected
      // Конвеер сообщений
    //FMessages: TAIMessages;
      // Процесс выполнения команд
    FProcess: TAiAgentProcess;
      // Окно агента видимо
    FVisible: Boolean;
  protected
      //** Запущен ли агент
    //FActive: Boolean; - use FProcess.Thread.Suspended
      //** Конвеер сообщений
    FMessages: TAiMessages;
      //** Статус процесса
    FStatus: TAiAgentStatus1;
  protected
      // Возвращает True, если агент активен
    function GetActive(): Boolean;
    function GetOnProgress(): TProcProgress;
      // Возвращает процесс выполнения команд
    function GetProcess(): TAiAgentProcess;
      // Возвращает статус
    function GetStatus(): TAiAgentStatus2;
      //** Возвращает статус
    function GetStatus1(): TAiAgentStatus1;
      // Возвращает True, если у агента есть видемые окна
    function GetVisible(): Boolean;
      // Устанавливает активность агента
    procedure SetActive(Value: Boolean);
    procedure SetOnProgress(const Value: TProcProgress);
      // Задает процесс выполнения команд
    procedure SetProcess(Value: TAiAgentProcess);
      // Задает статус агента
    procedure SetStatus(Value: TAiAgentStatus2);
      //** Задает статус агента
    procedure SetStatus1(Value: TAiAgentStatus1);
      // Задает видимость окон
    procedure SetVisible(Value: Boolean);
  public // IAiAgent
    //** Возвращает выполняемый код агента в виде строки
    function GetCodeString(): WideString; safecall;
    //** Возвращает интерпретатор
    function GetInterpretator(): IAiInterpretator; safecall;
    //** Задает выполняемый код агента в виде строки
    procedure SetCodeString(const Value: WideString); safecall;
    //** Задать интерпретатор
    procedure SetInterpretator(Value: IAiInterpretator); safecall;
  protected
      //** Срабатывает при создании
    procedure DoCreate(); override; safecall;
      //** Срабатывает при вызове метода Start
    function DoStart(): WordBool; virtual; safecall;
    {**
      Срабатывает при получении сообщения.
      Добавляет сообщение в стек сообщений подпроцесса выполнения.
    }
    //function SendMessage(const AMsg: WideString): Integer; override; safecall;
  public // IAiAgent
      // Добавить сообщение
    function AddMessage(Msg: IAclMessage): Integer;
      // Добавляет сообщение в стек сообщений подпроцесса выполнения.
    function AddMessageStr(const Msg: WideString): Integer; virtual;
      // Запускает процесс выполнения команд
    function Start(): WordBool; virtual; safecall;
      // Останавливает процесс выполнения команд
    function Stop(): WordBool; virtual; safecall;
  public
      // Финализирует
    function Finalize(): AError; override;
      // Скрыть видимые окна. Должен быть переопределен.
    //function Hide(): WordBool; virtual; safecall;
      // Инициализирует
    function Initialize(): AError; override;
      // Приостанавливает процесс выполнения команд
    function Pause(): Boolean; virtual; safecall;
      // Показывает окно агента. Должен быть переопределен.
    //function Show(): WordBool; virtual; safecall;
      // Запускает процесс выполнения команд ?
    function Run(): Boolean; virtual; safecall;
  public
      // Строка с кодом, который нужно выполнить
    property CodeString: WideString read GetCodeString write SetCodeString;
      // Интерпретатор кода
    property Interpretator: IAiInterpretator read GetInterpretator write SetInterpretator;
      // CallBack функция. Срабатывает при изменении progress задания.
    property OnProgress: TProcProgress read GetOnProgress write SetOnProgress;
  end;

  TAiAgent3 = TAiAgent;

implementation

{ TAiAgent }

function TAiAgent.AddMessage(Msg: IAclMessage): Integer;
begin
  Result := 0;
end;

function TAiAgent.AddMessageStr(const Msg: WideString): Integer;
begin
  Result := -1;
  if Assigned(FProcess) then
  try
    Result := FProcess.Messages.AddMessage(Msg);
  except
  end;
end;

procedure TAiAgent.DoCreate();
begin
  inherited DoCreate();

  FStatus := AgentStatusStoped;
  if not(Assigned(FMessages)) then
    FMessages := TAiMessages.Create();
  if not(Assigned(FProcess)) then
    FProcess := TAiAgentProcess.Create();
  FProcess.Messages := FMessages;
  //FProcess.OnSendMessage := SendMessage;
end;

function TAiAgent.DoStart(): WordBool;
begin
  Result := False;
  if Assigned(FProcess) then
  try
    Result := FProcess.Start();
  except
  end;
end;

function TAiAgent.Finalize(): AError;
begin
  Result := inherited Finalize();

//  if Assigned(FSource) and (FSourceCreated) then
//  begin
//    //FSource.ConfigureSave;
//    //FSource.Finalize;
////    FreeAndNil(FSource);
//  end;
//  FSourceCreated := False;
end;

function TAiAgent.GetActive(): Boolean;
begin
  Result := False;
  if Assigned(FProcess) then
  try
    Result := FProcess.Thread.Suspended;
  except
  end;
end;

function TAiAgent.GetCodeString(): WideString;
begin
  Result := '';
  if Assigned(FProcess) then
  try
    Result := FProcess.CodeString;
  except
  end;
end;

function TAiAgent.GetInterpretator(): IAiInterpretator;
begin
  Result := nil;
  if Assigned(FProcess) then
  try
    Result := FProcess.Interpretator;
  except
  end;
end;

function TAiAgent.GetOnProgress(): TProcProgress;
begin
  Result := nil;
  if Assigned(FProcess) then
  try
    Result := FProcess.Thread.OnProgress;
  except
  end;
end;

function TAiAgent.GetProcess(): TAiAgentProcess;
begin
  Result := FProcess;
end;

function TAiAgent.GetStatus(): TAiAgentStatus2;
begin
  Result := AGENT_STATUS_UNCNOWN;
  if Assigned(FProcess) then
  try
    Result := FProcess.Thread.State;
  except
  end;
end;

function TAiAgent.GetStatus1(): TAiAgentStatus1;
begin
  Result := FStatus;
end;

function TAiAgent.GetVisible(): Boolean;
begin
  Result := FVisible;
end;

{function TAiAgent.Hide(): WordBool;
begin
  Result := False;
  AddToLog(lgGeneral, ltError, stNotOverride+' '+ClassName+'.Hide');
end;}

function TAiAgent.Initialize(): AError;
//var
//  Config1: IProfXmlNode;
//  Log1: ILogNode;
begin
  Result := inherited Initialize();

//  // Инициализация источника
//  if not(Assigned(FSource)) then
//  begin
//    ToLog(lgGeneral, ltInformation, 'Источник не задан <%s.%s>', [ClassName, 'Initialize']);
//    ToLog(lgGeneral, ltInformation, 'Инициализация источника', []);
//    //FSource := TAISource...
//
//    {//if Assigned(FConfig) then Config1 := TConfigNode(FConfig.GetNodeByName('Source')) else Config1 := nil;
//    //if Assigned(FLog) then Log1 := FLog.AddToLog2('Инициализация источника DB ADO') else Log1 := nil;
//    FSource := TAISourceAdo.Create();
//    TAISourceAdo(FSource).DBFileName := FDBFileName;
//    //TAISourceAdo(FSource).DBFileName := ExtractFilePath(Application.ExeName) + 'DB\ARAgentChat.mdb';
//    //FSource.ConfigureLoad;
//    //FSource.Initialize;
//    //FSource.Log := FLog;
//    FSourceCreated := True;}
//  end else FSourceCreated := False;
end;

function TAiAgent.Pause(): Boolean;
begin
  FStatus := AgentStatusPaused;
  //FStatus := AGENT_STATUS_PAUSED;
  //Result := True;

  Result := False;
  if Assigned(FProcess) then
  try
    Result := FProcess.Pause();
  except
  end;
end;

{function TAIAgent.Run(): Boolean;
begin
  //FStatus := AGENT_STATUS_RUNED;
  //Result := True;
end;}

{function TAiAgent.SendMessage(const AMsg: WideString): Integer;
begin
  Result := inherited SendMessage(AMsg);
  if Assigned(FProcess) then
  try
    Result := FProcess.AddMessage(AMsg);
  except
  end;
end;}

procedure TAiAgent.SetActive(Value: Boolean);
begin
  //FActive := Value;
  if Assigned(FProcess) then
  try
    if Value then
      FProcess.Start()
    else
      FProcess.Pause();
  except
  end;
end;

procedure TAiAgent.SetCodeString(const Value: WideString);
begin
  if Assigned(FProcess) then
  try
    FProcess.CodeString := Value;
  except
  end;
end;

procedure TAiAgent.SetInterpretator(Value: IAiInterpretator);
begin
  if Assigned(FProcess) then
  try
    // Останавливаем процесс
    if FProcess.Stop() then
      FProcess.Interpretator := Value;
  except
  end;
end;

procedure TAiAgent.SetOnProgress(const Value: TProcProgress);
begin
  if Assigned(FProcess) then
  try
    FProcess.OnProgress := Value;
  except
  end;
end;

procedure TAiAgent.SetProcess(Value: TAiAgentProcess);
begin
  if Assigned(FProcess) then
  Stop();
  FProcess := Value;
end;

procedure TAiAgent.SetStatus(Value: TAiAgentStatus2);
begin
  case Value of
    AGENT_STATUS_PAUSED: Pause();
    AGENT_STATUS_RUNED: Start();
    AGENT_STATUS_STOPED: Stop();
  end;
end;

procedure TAiAgent.SetStatus1(Value: TAiAgentStatus1);
begin
  case Value of
    AgentStatusPaused: Pause();
    AgentStatusRuned: Run();
    AgentStatusStoped: Stop();
  end;
end;

procedure TAiAgent.SetVisible(Value: Boolean);
begin
  FVisible := Value;
end;

function TAiAgent.Run(): Boolean;
begin
  FStatus := AgentStatusRuned;
  Result := True;
end;

{function TAiAgent.Show(): WordBool;
begin
  Result := False;
end;}

function TAiAgent.Start(): WordBool;
begin
  Result := False;
  if Assigned(FProcess) then
  try
    Result := FProcess.Start();
    if Result then
      Self.FStatus := AgentStatusRuned;
  except
  end;
end;

function TAiAgent.Stop(): WordBool;
begin
  FStatus := AgentStatusStoped;
  Result := False;
  if Assigned(FProcess) then
  try
    Result := FProcess.Stop();
  except
  end;
end;

end.
