{**
@Abstract(Агент чат-бот)
@Author(Prof1983 prof1983@ya.ru)
@Created(02.05.2007)
@LastMod(27.03.2012)
@Version(0.5)
}
unit AiChatAgentImpl;

interface

uses
  Classes,
  ATypes,
  AiAgentImpl, AiChatKnowledgeBaseImpl, AiChatReasoner;

type //** Агент чат-бот
  TAIChatAgent = class(TAiAgent)
  private
    //** База знаний агента ChatAgent
    FKnowledgeBase: TAiChatKnowledgeBase;
    //** Машина логического вывода
    FReasoner: TAiChatReasoner;
  protected
    procedure DoCreate(); override; safecall;
  public
    //** Добавить сообщение
    function AddMessageStr(const Msg: WideString): Integer; override;
    //** Финализировать
    function Finalize(): TProfError; override;
    //** Инициализировать
    function Initialize(): TProfError; override;
    //** Запускает процесс выполнения команд
    function Start(): WordBool; virtual; safecall;
    //** Останавливает процесс выполнения команд
    function Stop(): WordBool; virtual; safecall;
  public
    //** База знаний агента ChatAgent
    property KnowledgeBase: TAiChatKnowledgeBase read FKnowledgeBase;
    //** Машина логического вывода
    property Reasoner: TAiChatReasoner read FReasoner;
  end;

implementation

{ TAIChatAgent }

function TAIChatAgent.AddMessageStr(const Msg: WideString): Integer;
begin
  Result := inherited AddMessageStr(Msg);
  if (Length(Msg) > 0) and (Msg[1] <> '#') then
    SendMessage('#Сообщение принято: "'+Msg+'"');
end;

procedure TAIChatAgent.DoCreate();
begin
  //if not(Assigned(FProcess)) then
  //FProcess := TAIChatAgentProcess.Create;

  inherited DoCreate();
  FName := 'ChatAgent';
  // Создаем объект работы с базой знаний
  FKnowledgeBase := TAIChatKnowledgeBase.Create();
  // Создаем объект для логического вывода
  FReasoner := TAIChatReasoner.Create();
end;

function TAIChatAgent.Finalize(): TProfError;
begin
  FKnowledgeBase.Close();
  FKnowledgeBase.Finalize();
  inherited Finalize();
end;

function TAIChatAgent.Initialize(): TProfError;
begin
  SendMessage('Инициализация агента ChatAgent');
  inherited Initialize();
  FKnowledgeBase.Initialize();
  Result := FKnowledgeBase.Open();

  FReasoner.Initialize();

  SendMessage('Агент ChatAgent инициализирован');
end;

function TAIChatAgent.Start(): WordBool;
begin
  SendMessage('Старт выполнения агента ChatAgent');
  Self.FProcess.Thread.Priority := tpLowest;
  Result := inherited Start();
end;

function TAIChatAgent.Stop(): WordBool;
begin
  SendMessage('Остановка выполнения агента ChatAgent');
  Result := inherited Stop();
end;

end.
