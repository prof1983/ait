{**
@Abstract(Ahent thread)
@Author(Prof1983 prof1983@ya.ru)
@Created(31.01.2008)
@LastMod(04.07.2012)
@Version(0.5)
}
unit AiAgentThread;

interface

uses
  Classes,
  AMessagesObj;

type
  TAgentThread = class(TThread)
  private
    FMessages: TAMessages;
  protected
    procedure Execute(); override;
  public
    function GetMessages(): TAMessages;
    procedure SetMessages(Value: TAMessages);
  end;

implementation

{ TAgentThread }

procedure TAgentThread.Execute();
begin
  // ...
end;

function TAgentThread.GetMessages(): TAMessages;
begin
  Result := FMessages;
end;

procedure TAgentThread.SetMessages(Value: TAMessages);
begin
  FMessages := Value;
end;

end.
 