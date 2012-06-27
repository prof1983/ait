{**
@Abstract(Базовый класс для модулей)
@Author(Prof1983 prof1983@ya.ru)
@Created(20.03.2007)
@LastMod(27.06.2012)
@Version(0.5)

Модуль - это объект AI, который имеет механизм отсылки и приема сообщений.
}
unit AiModuleImpl;

interface

uses
  ABase, AMessageIntf, AModuleInformationIntf, AModuleIntf, ATypes,
  AiFrameIntf, AiModuleIntf, AiObjectImpl;

type //** Базовый класс для модулей
  TAiModule = class(TAiObject, IAiModule, IProfModule)
  protected
      //** CallBack функция отсылки сообщения ядру
    FOnSendMessageToCore: TProcMessageStr;
  public
      // Послать сообщения ядру
//    function SendMessageToCore(const AMsg: WideString): Integer; virtual; safecall;
  public // IProfModule
    function GetInformation(): IModuleInformation;
    function GetLocalId(): Integer;
    function GetLocalName(): WideString;
  public // IProfModule
    function Start(): Integer;
    function Stop(): Integer;
    function Pause(): Integer;
      //** Обработать сообщение
    function PushMessage(Msg: ISimpleMessage): Integer;
  public
      //** CallBack функция отсылки сообщения ядру
    property OnSendMessageToCore: TProcMessageStr read FOnSendMessageToCore write FOnSendMessageToCore;
  end;

implementation

{ TAiModule }

function TAiModule.GetInformation(): IModuleInformation;
begin
  Result := nil;
end;

function TAiModule.GetLocalId(): Integer;
begin
  Result := FId;
end;

function TAiModule.GetLocalName(): WideString;
begin
  Result := FName;
end;

function TAiModule.Pause(): Integer;
begin
  Result := 0;
end;

{function TAIModule4.SendMessageToCore(const AMsg: WideString): Integer;
begin
  Result := 0;
  if Assigned(FOnSendMessageToCore) then
  try
    Result := FOnSendMessageToCore(AMsg);
  except
  end;
end;}

function TAiModule.PushMessage(Msg: ISimpleMessage): Integer;
begin
  Result := 0;
end;

function TAiModule.Start(): Integer;
begin
  Result := 0;
end;

function TAiModule.Stop(): Integer;
begin
  Result := 0;
end;

end.
