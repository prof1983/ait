{**
@Abstract(AiLogingObject)
@Author(Prof1983 prof1983@ya.ru)
@Created(17.05.2006)
@LastMod(25.04.2012)
@Version(0.5)
}
unit AiLogingObject;

interface

uses
  AiBaseTypes;

type
  TAILogingObject = class(TInterfacedObject)
  private
    //** CallBack функция функция. Срабатывает при поступлении лог-сообщения.
    FOnAddToLog: TAIProcAddToLog;
  protected
    //** Добавить лог-сообщение
    function AddToLog(AMsg: WideString): Integer; virtual; safecall;
  public
    //** CallBack функция функция. Срабатывает при поступлении лог-сообщения.
    property OnAddToLog: TAIProcAddToLog read FOnAddToLog write FOnAddToLog;
  end;

implementation

{ TAILogingObject }

function TAILogingObject.AddToLog(AMsg: WideString): Integer;
begin
  Result := 0;
  if Assigned(FOnAddToLog) then
  try
    Result := FOnAddToLog(AMsg);
  except
  end;
end;

end.
