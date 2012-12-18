{**
@Abstract Главный Агент реализации разума
@Author Prof1983 <prof1983@ya.ru>
@Created 30.10.2006
@LastMod 18.12.2012
}
unit AiReasonAgentImpl;

// TODO: Реализовать главного агента (ReasonAgent)

interface

uses
  ABase,
  AiAgentImpl, AiGlobalTaskListImpl, AiReasonProcess, AiWorldImpl;

type
  TProcReasonProgress = procedure(AID, AProgress: Integer) of object;

type //** Главный Агент реализации разума
  TAiReasonAgent = class(TAiAgent)
  protected
      //** Глобальные задачи. Задаются один раз при создании и больше не меняются.
    FGlobalTasks: TAiGlobalTaskList;
      //** Главный объект отражения внешнего мира
    FWorld: TAiWorld;
    // ... // Предметные области для решения локальных задач
      //** Сессия
    //FSession: TARSession;
  private // События
    //FOnTaskAdd: TProcMessage;
  protected
    procedure DoCreate(); override;
    function DoStart(): WordBool; override; safecall;
  public
    function Finalize(): AError; override;
    function Initialize(): AError; override;
  public
      //** Глобальные задачи. Задаются один раз при создании и больше не меняются.
    property GlobalTasks: TAiGlobalTaskList read FGlobalTasks;
      //** Главный объект отражения внешнего мира
    property World: TAiWorld read FWorld;
  public // События
    //property OnTaskAdd: TProcMessage read FOnTaskAdd write FOnTaskAdd;
  end;

  //TAiReasonAgent2007 = TAiReasonAgent;

implementation

{ TAiReasonAgent }

procedure TAiReasonAgent.DoCreate();
begin
  if not(Assigned(FProcess)) then
    FProcess := TAiReasonProcess.Create();
  inherited DoCreate();
  FName := 'ReasonAgent';
end;

function TAiReasonAgent.Finalize(): AError;
begin
  if Assigned(FGlobalTasks) then
  try
    FGlobalTasks.Free();
    FGlobalTasks := nil;
  except
  end;

  if Assigned(FWorld) then
  try
    FWorld.Free();
    FWorld := nil;
  except
  end;

  Result := inherited Finalize();
end;

function TAiReasonAgent.Initialize(): AError;
begin
  Result := inherited Initialize();

  // Создание процесса работы локального разума
  //FThread := TAIReasonThread.Create(False);

  // Создаем БЗ
  {if not(Assigned(FSource)) then
  begin
    FSource := TAISource.Create();
  end;}

  // Создаем главный объект отражения внешного мира
  if not(Assigned(FWorld)) then
  begin
    FWorld := TAiWorld.Create();
    FWorld.Pool := FPool;
    FWorld.Initialize();
  end;

  {// Создаем внутреннея Я
  if not(Assigned(FInternalI)) then
  begin
    FInternalI := TAIInternalI.Create();
  end;}

  // Создаем предметные области решения локальных задач
  // ...

  // Создаем глобальные задачи
  if not(Assigned(FGlobalTasks)) then
  begin
    FGlobalTasks := TAiGlobalTaskList.Create();
    //FGlobalTasks.Pool := FPool;
    FGlobalTasks.Initialize();
  end;
  TAiReasonProcess(FProcess).GlobalTasks := FGlobalTasks;

  {// Создаем интерпретатор кода на языке AR
  if not(Assigned(FInterpretator)) then
  try
    FInterpretator := TAICodeInterpretator.Create();
    FInterpretator.Initialize();
  except
    FInterpretator := nil;
  end;}

  {AddToLog(lgNone, ltInformation, 'Создаем новую сессию');
  FSession := TARSession.Create();
  // ...
  Result := True;}

  {AddToLog(lgNone, ltInformation, 'Создаем главный объект отражения внешного мира');
  FWorld := TARWorld.Create();}

  // Создаем предметные области решения локальных задач
  // ...

  // Создаем глобальные задачи
  // ...
  // - Не причинять вреда человеку и другим существам.
  // - Не давать возможности убить себя. (Самосохранение)
  // - Постоянно самосовершенстроваться.
  // - Узнать есть ли Бог.
  // - Изучить вселенную.
  // - Узнать что за пределами вселенной.
  // - Узнать что за пределами времени: где начало и где конец.
  // - Просто жить.
end;

function TAiReasonAgent.DoStart(): WordBool;
begin
  //Result := inherited DoStart();
  Result := True;

  // Запуск работы локального разума
  //FThread.Resume();
end;

end.
