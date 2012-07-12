{**
@Abstract(AiAgentList)
@Author(Prof1983 prof1983@ya.ru)
@Created(04.12.2007)
@LastMod(12.07.2012)
@Version(0.5)
}
unit AiAgentListObj;

interface

uses
  AiAgentObj;

type
  TArAgentList = class
  private
      //** Зарегистрированные агенты
    FItems: array of TAiAgentObject;
  protected
    function GetAgentByIndex(Index: Integer): TAiAgentObject;
    function GetAgentCount(): Integer;
  public
    property AgentByIndex[Index: Integer]: TAiAgentObject read GetAgentByIndex;
    property AgentCount: Integer read GetAgentCount;
  end;

  //TArAgentList = TAiAgentList;

implementation

{ TArAgentList }

function TArAgentList.GetAgentByIndex(Index: Integer): TAiAgentObject;
begin
  if (Index >= 0) and (Index < Length(FItems)) then
    Result := FItems[Index]
  else
    Result := nil;
end;

function TArAgentList.GetAgentCount(): Integer;
begin
  Result := Length(FItems);
end;

end.
