{**
@Abstract(Агент)
@Author(Prof1983 prof1983@ya.ru)
@Created(31.01.2008)
@LastMod(24.05.2012)
@Version(0.5)

Агенты делятся на локальные и удаленые:
LocalAgent
RemoteAgent
}
unit AiAgentObj1;

interface

type
  TAgent = class
  private
    FName: string;
    function GetStateStr(): string;
  public
    // Агент является локальным
    function IsLocal(): Boolean;
    // Запустить выполнение агента
    function Start(): Integer;
    // Остановить выполнение агента
    function Stop(): Integer;
  public
    // Имя агента
    property Name: string read FName write FName;
    // Состояние агента
    property StateStr: string read GetStateStr;
  end;

implementation

{ TAgent }

function TAgent.GetStateStr(): string;
begin
  Result := 'Stopped';
end;

function TAgent.IsLocal(): Boolean;
begin
  Result := True;
end;

function TAgent.Start(): Integer;
begin
  Result := -1;
end;

function TAgent.Stop(): Integer;
begin
  Result := -1;
end;

end.


