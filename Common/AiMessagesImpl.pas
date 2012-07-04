{**
@Abstract(Конвеер сообщений)
@Author(Prof1983 prof1983@ya.ru)
@Created(04.11.2005)
@LastMod(04.07.2012)
@Version(0.5)

24.02.2012 - Объединил AiMessages.pas и AiMessagesImpl.pas
}
unit AiMessagesImpl;

interface

uses
  ABase, AObjectImpl, AMessageObj, AMessagesObj, ATypes,
  AiTypes;

type
  TAIMessage = TProfMessage3;

type //** Сообщение
  TAIMessageRec = ATypes.TProfMessageRec;

type //** Конвеер сообщений
  TAIMessages = class(TProfObject)
  private
    FMessages: TAMessages;
  protected
    function Get_Count(): Integer;
    function Get_NextRunMessage(): WideString;
    function Get_CountMessages(): Integer;
  public
    function AddMessage(const AMessage: WideString): AInt;
  public
      //** Добавить команду в список. Поставить команду в очередь выполнения.
    function AddComand(AConnectionID: UInt64; AIdent: Int32; AOwner: UInt64; AComId: UInt64;
        const AComName, AParams: WideString{IProfXmlNode}): Boolean;
      //** Добавить сообщение. Поставить сообщение в очередь сообщений.
    function AddMsg(AConnectionID: UInt64; AMsg: String): Boolean;
    constructor Create(StekSize: Int32 = 512);
      //** Найти ответ
    function FindMsgAnswer(AConnectionID: UInt64; AIdent: Integer; AComID: UInt64;
        AComName: String; var AMsg: TAIMessageRec): Boolean;
      //** Получить сообщение
    function GetMessage(Index: Integer; var AMsg: TAIMessageRec): Boolean;
      //** Вернуть следующее значение счетчика сообщений
    function GetNextIdent(): Int32;
      {**
      Возвращает следующее сообщение для разбора и выполнения
      True - сообщение есть. False - сообщения нет. }
    function GetNextMessage(var AMsg: TAIMessageRec): Boolean;
  end;

implementation

{ TAIMessages }

function TAIMessages.AddComand(AConnectionId: UInt64; AIdent: Int32; AOwner: UInt64;
    AComId: UInt64; const AComName, AParams: WideString{IProfXmlNode}): Boolean;
begin
  Result := FMessages.AddComand(AConnectionId, AIdent, AOwner, AComId, AComName, AParams);
end;

function TAIMessages.AddMessage(const AMessage: WideString): AInt;
begin
  AddMsg(0, AMessage);
end;

function TAIMessages.AddMsg(AConnectionId: UInt64; AMsg: String): Boolean;
begin
  Result := FMessages.AddMsg(AConnectionId, AMsg);
end;

constructor TAIMessages.Create(StekSize: Int32);
begin
  inherited Create();
  FMessages := TAMessages.Create();
end;

function TAIMessages.FindMsgAnswer(AConnectionId: UInt64; AIdent: Integer; AComId: UInt64;
    AComName: String; var AMsg: TAIMessageRec): Boolean;
var
  Msg: TProfMessage3;
begin
  if FMessages.FindMsgAnswer(AConnectionId, AIdent, AComId, AComName, Msg) then
  begin
    AMsg := Msg.FMessage;
    Result := True;
  end
  else
    Result := False;
end;

function TAIMessages.Get_Count(): Integer;
begin
  Result := FMessages.GetCount();
end;

function TAIMessages.Get_CountMessages(): Integer;
begin
  Result := FMessages.GetCount();
end;

function TAIMessages.Get_NextRunMessage(): WideString;
var
  m: TAiMessageRec;
begin
  if GetNextMessage(m) then
    Result := m.Msg
  else
    Result := '';
end;

function TAIMessages.GetMessage(Index: Integer; var AMsg: TAIMessageRec): Boolean;
begin
  Result := FMessages.GetMessageRec(Index, AMsg);
end;

function TAIMessages.GetNextIdent(): Int32;
begin
  Result := FMessages.GetNextIdent();
end;

function TAIMessages.GetNextMessage(var AMsg: TAIMessageRec): Boolean;
begin
  Result := FMessages.GetNextMessageRec(AMsg);
end;

end.
