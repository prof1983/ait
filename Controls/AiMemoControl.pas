{**
@Abstract(AiMemoControl)
@Author(Prof1983 prof1983@ya.ru)
@Created(04.05.2007)
@LastMod(26.04.2012)
@Version(0.5)
}
unit AiMemoControl;

interface

uses
  AMemoControl, ATypesEx,
  AclMessageIntf;

type
  TAiMemoControl = class(TProfMemoControl)
  private
    //FOnSendMessageA: TProcMessageA;
  protected
    function SendMessageA(Msg: IAclMessage): Integer; virtual; safecall;
  end;

implementation

{ TAiMemoControl }

function TAiMemoControl.SendMessageA(Msg: IAclMessage): Integer;
begin
  Result := 0;
  {if Assigned(FOnSendMessageA) then
  try
    Result := FOnSendMessageA(Msg);
  except
  end;}
end;

end.
