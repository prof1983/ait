{**
@Abstract(Базовый класс для агента)
@Author(Prof1983 prof1983@ya.ru)
@Created(22.09.2005)
@LastMod(03.04.2012)
@Version(0.5)

Агент - это модуль, который имеет свой подпроцесс выполнения команд (Thread).

Агенты общаются между собой.
Агенты делают запросы к БЗ и получают ответы от БЗ.
Для формирования и расбора сообщений агент использует кодек (codec).
Для передачи сообщения агент использует транспортный объект.
}
unit AiAgent3;

interface

uses
  AConsts2, ATypes,
  AclMessageIntf,
  AiAgentIntf, AiAgentProcess, AiBase, AiInterpretatorIntf, AiMessagesImpl, AiModuleImpl;

type
  //** @abstract(Статус агента)
  TAIAgentStatus = TThreadState;
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
  TAIAgentRec3 = record
    ID: TAIID;
    Agent: IAiAgent;
  end;

type // Базовый класс для агента
  TAIAgent = class(TAIModule, IAIAgent)
  private
    function GetOnProgress: TProcProgress;
    procedure SetOnProgress(const Value: TProcProgress);
  protected
    //** Конвеер сообщений
    FMessages: TAIMessages;
    //** Процесс выполнения команд
    FProcess: TAIAgentProcess3;
    //** Окно агента видимо
    FVisible: Boolean;
  protected
    //** Возвращает True, если агент активен
    function GetActive(): Boolean;
    //** Возвращает процесс выполнения команд
    function GetProcess(): TAIAgentProcess3;
    //** Возвращает статус
    function GetStatus(): TAIAgentStatus;
    //** Возвращает True, если у агента есть видемые окна
    function GetVisible(): Boolean;
    //** Устанавливает активность агента
    procedure SetActive(Value: Boolean);
    //** Задает процесс выполнения команд
    procedure SetProcess(Value: TAIAgentProcess3);
    //** Задает статус агента
    procedure SetStatus(Value: TAIAgentStatus);
    //** Задает видимость окон
    procedure SetVisible(Value: Boolean);
  protected
    //** Возвращает выполняемый код агента в виде строки
    function GetCodeString(): WideString; safecall;
    //** Возвращает интерпретатор
    function GetInterpretator(): IAiInterpretator; safecall;
    //** Задает выполняемый код агента в виде строки
    procedure SetCodeString(const Value: WideString); safecall;
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
    function SendMessage(const AMsg: WideString): Integer; override; safecall;
  public // IAiAgent
      //** Добавить сообщение
    function AddMessage(Msg: IAclMessage): Integer;
  public
    //** Финализирует
    function Finalize(): TProfError; override; //safecall;
    //** Скрыть видимые окна. Должен быть переопределен.
    function Hide(): WordBool; virtual; safecall;
    //** Инициализирует
    function Initialize(): TProfError; override; //safecall;
    //** Приостанавливает процесс выполнения команд
    function Pause(): Boolean; virtual; safecall;
    //** Регистрирует агент в БЗ, выделяет ID
    function Regist(): Boolean; override; safecall;
    //** Показывает окно агента. Должен быть переопределен.
    function Show(): WordBool; virtual; safecall;
    //** Запускает процесс выполнения команд
    function Start(): WordBool; virtual; safecall;
    //** Останавливает процесс выполнения команд
    function Stop(): WordBool; virtual; safecall;
  public
    //** Строка с кодом, который нужно выполнить
    property CodeString: WideString read GetCodeString write SetCodeString;
    //** Интерпретатор кода
    property Interpretator: IAiInterpretator read GetInterpretator write SetInterpretator;
    //** CallBack функция. Срабатывает при изменении progress задания.
    property OnProgress: TProcProgress read GetOnProgress write SetOnProgress;
  end;
  TAIAgent3 = TAIAgent;

implementation

{ TAIAgent }

function TAIAgent.AddMessage(Msg: IAclMessage): Integer;
begin
  Result := 0;
end;

procedure TAIAgent.DoCreate();
begin
  inherited DoCreate();

  if not(Assigned(FMessages)) then
    FMessages := TAIMessages.Create();
  if not(Assigned(FProcess)) then
    FProcess := TAIAgentProcess3.Create();
  //FProcess.Messages := FMessages;
  FProcess.OnSendMessage := SendMessage;
end;

function TAIAgent.DoStart(): WordBool;
begin
  Result := False;
  if Assigned(FProcess) then
  try
    Result := FProcess.Start();
  except
  end;
end;

function TAIAgent.Finalize(): TProfError;
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

function TAIAgent.GetActive(): Boolean;
begin
  Result := False;
  if Assigned(FProcess) then
  try
    Result := FProcess.Thread.Suspended;
  except
  end;
end;

function TAIAgent.GetCodeString(): WideString;
begin
  Result := '';
  if Assigned(FProcess) then
  try
    Result := FProcess.CodeString;
  except
  end;
end;

function TAIAgent.GetInterpretator(): IAiInterpretator;
begin
  Result := nil;
  if Assigned(FProcess) then
  try
    Result := FProcess.Interpretator;
  except
  end;
end;

function TAIAgent.GetOnProgress(): TProcProgress;
begin
  Result := nil;
  if Assigned(FProcess) then
  try
    Result := FProcess.Thread.OnProgress;
  except
  end;
end;

function TAIAgent.GetProcess(): TAIAgentProcess3;
begin
  Result := FProcess;
end;

function TAIAgent.GetStatus(): TAIAgentStatus;
begin
  Result := AGENT_STATUS_UNCNOWN;
  if Assigned(FProcess) then
  try
    Result := FProcess.Thread.State;
  except
  end;
end;

function TAIAgent.GetVisible(): Boolean;
begin
  Result := FVisible;
end;

function TAIAgent.Hide(): WordBool;
begin
  Result := False;
  AddToLog(lgGeneral, ltError, stNotOverride+' '+ClassName+'.Hide');
end;

function TAIAgent.Initialize(): TProfError;
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

function TAIAgent.Pause(): Boolean;
begin
  //FStatus := AGENT_STATUS_PAUSED;
  //Result := True;

  Result := False;
  if Assigned(FProcess) then
  try
    Result := FProcess.Pause();
  except
  end;
end;

function TAIAgent.Regist(): Boolean;
begin
  Result := inherited Regist;
  // ...
end;

{function TAIAgent.Run(): Boolean;
begin
  //FStatus := AGENT_STATUS_RUNED;
  //Result := True;
end;}

function TAIAgent.SendMessage(const AMsg: WideString): Integer;
begin
  Result := inherited SendMessage(AMsg);
  if Assigned(FProcess) then
  try
    Result := FProcess.AddMessage(AMsg);
  except
  end;
end;

procedure TAIAgent.SetActive(Value: Boolean);
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

procedure TAIAgent.SetCodeString(const Value: WideString);
begin
  if Assigned(FProcess) then
  try
    FProcess.CodeString := Value;
  except
  end;
end;

procedure TAIAgent.SetInterpretator(Value: IAiInterpretator);
begin
  if Assigned(FProcess) then
  try
    // Останавливаем процесс
    if FProcess.Stop() then
      FProcess.Interpretator := Value;
  except
  end;
end;

procedure TAIAgent.SetOnProgress(const Value: TProcProgress);
begin
  if Assigned(FProcess) then
  try
    FProcess.OnProgress := Value;
  except
  end;
end;

procedure TAIAgent.SetProcess(Value: TAIAgentProcess3);
begin
  if Assigned(FProcess) then
  Stop();
  FProcess := Value;
end;

procedure TAIAgent.SetStatus(Value: TAIAgentStatus);
begin
  case Value of
    AGENT_STATUS_PAUSED: Pause();
    AGENT_STATUS_RUNED: Start();
    AGENT_STATUS_STOPED: Stop();
  end;
end;

procedure TAIAgent.SetVisible(Value: Boolean);
begin
  FVisible := Value;
end;

function TAIAgent.Show(): WordBool;
begin
  Result := False;
end;

function TAIAgent.Start(): WordBool;
begin
  Result := False;
  if Assigned(FProcess) then
  try
    Result := FProcess.Start();
    //if Result then
    //  Self.FStatus := AGENT_STATUS_RUNED;
  except
  end;
end;

function TAIAgent.Stop(): WordBool;
begin
  //FStatus := AGENT_STATUS_STOPED;
  Result := False;
  if Assigned(FProcess) then
  try
    Result := FProcess.Stop();
  except
  end;
end;

end.
