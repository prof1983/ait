{**
@Abstract Микроядро системы
@Author Prof1983 <prof1983@ya.ru>
@Created 11.06.2007
@LastMod 09.08.2012
}
unit AiCoreImpl;

interface

uses
  ALogJournal,
  AclMessageIntf, AiAgents, AiClients, AiCoreIntf, AiKnowledgeBaseImpl;

type //** Микроядро системы
  TAiCore = class(TInterfacedObject, IAiCore)
  protected
      //** Список зарегистрированых агентов
    FAgents: TAiAgents;
      //** Список зарегистрированых клиентов
    FClients: TAiClients;
      //** База знаний
    FKnowledgeBase: TAiKnowledgeBase;
      //** Массив лог-журналов для записи лог-сообщений
    FLogJournals: array of TLogJournal;
  public
    function GetLogJournalsCount(): Integer;
  public
      //** Выполнить команду
    function AddCommand(Cmd: WideString): Integer;
      //** Добавить лог-сообщение
    function AddLogMessage(Msg: WideString): Integer;
      //** Добавить журнал записи лог-сообщений
    function AddLogJournal(Log: TLogJournal): Integer;
      //** Предать или выполнить сообщение.
    function AddMessage(Msg: IAclMessage): Integer;
      //** Срабатывает сразу после создания
    procedure AfterConstruction(); override;
      //** Удалить лог-журнал
    procedure RemoteLogJournal(LogJournal: TLogJournal);
  public
      //** Список зарегистрированых агентов
    property Agents: TAiAgents read FAgents;
      //** Список зарегистрированых клиентов
    property Clients: TAiClients read FClients;
      //** База знаний
    property KnowledgeBase: TAiKnowledgeBase read FKnowledgeBase;
      //** Кол-во журналов логирования
    property LogJournalsCount: Integer read GetLogJournalsCount;
  end;

implementation

{ TAiCore }

function TAiCore.AddCommand(Cmd: WideString): Integer;
begin
  Result := 0;
  if Cmd = 'run' then
    Result := 1;
  // ...
end;

function TAiCore.AddLogJournal(Log: TLogJournal): Integer;
begin
  Result := Length(FLogJournals);
  SetLength(FLogJournals, Result + 1);
  FLogJournals[Result] := Log;
end;

function TAiCore.AddLogMessage(Msg: WideString): Integer;
var
  i: Integer;
begin
  Result := 0;
  if Length(FLogJournals) > 0 then
  try
    // Возвращаем идентификатор сообщения, полученый от первого лог-журнала
    Result := FLogJournals[0].AddToLog(Msg);
    for i := 1 to High(FLogJournals) do
      FLogJournals[i].AddToLog(Msg);
  except
  end;
end;

function TAiCore.AddMessage(Msg: IAclMessage): Integer;
var
  i: Integer;
begin
  Result := 0;
  // Направляем сообщение куда надо
  // ...

  // Направляем всем
  for i := 0 to FAgents.Count - 1 do
  begin
    FAgents.AgentByIndex[i].AddMessage(Msg);
  end;

  for i := 0 to FClients.Count - 1 do
  begin
    //FClients[i].
    // ...
  end;
end;

procedure TAiCore.AfterConstruction();
begin
  inherited;
  // Создаем список зарегистрированых агентов
  FAgents := TAiAgents.Create();
  // Создаем список зарегистрированых клиентов
  FClients := TAiClients.Create();
  // Создаем объект доступа к базе знаний
  FKnowledgeBase := TAiKnowledgeBase.Create();
  IInterface(FKnowledgeBase)._AddRef();

  SetLength(FLogJournals, 0);
  if Length(FLogJournals) > 0 then
    FLogJournals[0].AddToLog('123');
end;

function TAiCore.GetLogJournalsCount(): Integer;
begin
  Result := Length(FLogJournals);
end;

procedure TAiCore.RemoteLogJournal(LogJournal: TLogJournal);
var
  i: Integer;
  i2: Integer;
begin
  for i := 0 to High(FLogJournals) do
    if (FLogJournals[i] = LogJournal) then
    begin
      for i2 := i to High(FLogJournals) - 1 do
        FLogJournals[i2] := FLogJournals[i2 + 1];
      SetLength(FLogJournals, High(FLogJournals));
      Exit;
    end;
end;

end.
