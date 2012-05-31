{**
@Abstract(Agents)
@Author(Prof1983 prof1983@ya.ru)
@Created(11.06.2007)
@LastMod(23.03.2012)
@Version(0.5)

История версий:
0.0.0.4 - 29.07.2007
0.0.0.3 - 05.07.2007
0.0.0.2 - 04.07.2007
0.0.0.1 - 11.06.2007
}
unit AiAgents;

interface

uses
  AclMessageIntf, AiAgentIntf;

type
  TAiAgents = class
  private
    FAgents: array of IAiAgent;
    function GetAgentByIndex(Index: Integer): IAiAgent;
    function GetCount(): Integer;
  public
    function Add(Agent: IAiAgent): Integer;
  public
    property AgentByIndex[Index: Integer]: IAiAgent read GetAgentByIndex;
    property Count: Integer read GetCount;
  end;

implementation

{ TAiAgents }

function TAiAgents.Add(Agent: IAiAgent): Integer;
var
  I: Integer;
begin
  I := Length(FAgents);
  SetLength(FAgents, I + 1);
  FAgents[I] := Agent;
  Result := I;
end;

function TAiAgents.GetAgentByIndex(Index: Integer): IAiAgent;
begin
  if (Index >= 0) and (Index < Length(FAgents)) then
    Result := FAgents[Index]
  else
    Result := nil;
end;

function TAiAgents.GetCount(): Integer;
begin
  Result := Length(FAgents);
end;

end.
