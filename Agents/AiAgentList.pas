{**
@Abstract(Список агентов)
@Author(Prof1983 prof1983@ya.ru)
@Created(15.03.2007)
@LastMod(27.03.2012)
@Version(0.5)
}
unit AiAgentList;

interface

uses
  AiAgentIntf, AiFrame, AiFrameImpl;

type //** Список агентов
  TAIAgentList = class(TAIFrame)
  private
      //** Список агентов
    FAgents: array of IAIAgent;
      //** Возвращает агента по индексу
    function GetAgentByIndex(Index: Integer): IAIAgent;
      //** Возвращает колличество агентов
    function GetAgentCount(): Integer;
  public
      //** Добавить агента в список
    function Add(AAgent: IAIAgent): Integer;
      //** Срабатывает при получении сообщения
    function AddMessage(const AMsg: WideString): Integer; override; safecall;
  public
      //** Агенты по индексу
    property AgentByIndex[Index: Integer]: IAIAgent read GetAgentByIndex;
      //** Колличество агентов
    property AgentCount: Integer read GetAgentCount;
  end;
  //TAIAgentList3 = TAIAgentList;

implementation

{ TAIAgentList }

function TAIAgentList.Add(AAgent: IAIAgent): Integer;
begin
  Result := Length(FAgents);
  SetLength(FAgents, Result + 1);
  FAgents[Result] := AAgent;
end;

function TAIAgentList.AddMessage(const AMsg: WideString): Integer;
var
  i: Integer;
begin
  inherited AddMessage(AMsg);

  // Рассылаем всем
  for i := 0 to High(FAgents) do
    FAgents[i].AddMessageStr(AMsg);
end;

function TAIAgentList.GetAgentByIndex(Index: Integer): IAIAgent;
begin
  Result := FAgents[Index];
end;

function TAIAgentList.GetAgentCount(): Integer;
begin
  Result := Length(FAgents);
end;

end.
