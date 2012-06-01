{**
@Abstract()
@Author(Prof1983 prof1983@ya.ru)
@Created(31.01.2008)
@LastMod(24.05.2012)
@Version(0.5)
}
unit AiAgentThread;

interface

uses
  Classes;

type
  TAgentThread = class(TThread)
  private
  protected
    procedure Execute(); override;
  end;

implementation

{ Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure AgentThread.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

{ TAgentThread }

procedure TAgentThread.Execute();
begin
  // ...
end;

end.
 