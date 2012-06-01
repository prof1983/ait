{**
@Abstract(Local agent)
@Author(Prof1983 prof1983@ya.ru)
@Created(31.01.2008)
@LastMod(24.05.2012)
@Version(0.5)
}
unit AiLocalAgent;

interface

uses
  AiAgentObj1, AiAgentThread;

type
  TLocalAgent = class(TAgent)
  private
    FThread: TAgentThread;
  public
    constructor Create();
  end;

implementation

{ TLocalAgent }

constructor TLocalAgent.Create();
begin
  inherited;
  FThread := TAgentThread.Create(True);
end;

end.
 