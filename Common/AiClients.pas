{**
@Abstract(Список зарегистрированых клиентов)
@Author(Prof1983 prof1983@ya.ru)
@Created(11.06.2007)
@LastMod(23.03.2012)
@Version(0.5)

История версий:
0.0.0.2 - 04.07.2007
0.0.0.1 - 11.06.2007
}
unit AiClients;

interface

type
  IAIClient = class
  end;

type
  TAIClients = class
  private
    FClients: array of IAIClient;
    function GetClientByIndex(Index: Integer): IAIClient;
    function GetCount(): Integer;
  public
    property ClientByIndex[Index: Integer]: IAIClient read GetClientByIndex;
    property Count: Integer read GetCount;
  end;

implementation

{ TAIClients }

function TAIClients.GetClientByIndex(Index: Integer): IAIClient;
begin
  if (Index > 0) and (Index < Length(FClients)) then
    Result := FClients[Index]
  else
    Result := nil;
end;

function TAIClients.GetCount(): Integer;
begin
  Result := Length(FClients);
end;

end.
