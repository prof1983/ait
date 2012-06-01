{**
@Abstract(Функции работы с языком AQL)
@Author(Prof1983 prof1983@ya.ru)
@Created(17.03.2007)
@LastMod(03.05.2012)
@Version(0.5)

Формат сообщения на языке AQL.XML:
<aql sender="X" recepient="Y" lang="Z">...</aql>

Формат сообщения на языке AQL.String
aql <Sender ID or Name> <Recepient ID or Name> <Lang ID or Name> <Message>

Сообщения на языке AQL.Binnary пока не используются
}
unit AqlUtils;

interface

uses
  AqlConsts;

type
  //** @abstract(Тип сообщения AQL)
  TAqlMessageType = Integer;
const
  AQL_MESSAGE_NONE    = $01;
  AQL_MESSAGE_UNKNOWN = $02;
  AQL_MESSAGE_BINNARY = $04;
  AQL_MESSAGE_STRING  = $08;
  AQL_MESSAGE_XML     = $10;

//** @abstract(Разкодировать AQL сообщение в виде строки)
function AqlDecodeStr(const AStr: WideString; var ASender, ARecepient, ALang, ABody: WideString): WordBool;
//** @abstract(Закодировать AQL сообщение в виде строки)
function AqlEncodeStr(const ASender, ARecepient, ALang, ABody: WideString): WideString;
//** @abstract(Закодировать AQL сообщение в виде XML строки)
function AqlEncodeXml(const ASender, ARecepient, ALang, ABody: WideString): WideString;
//** @abstract(Определяет тип сообщения AQL)
function AqlMessageType(const AMsg: WideString): TAqlMessageType;

implementation

// -----------------------------------------------------------------------------
function AqlDecodeStr(const AStr: WideString; var ASender, ARecepient, ALang, ABody: WideString): WordBool;
var
  i: Integer;
  tmpStr: string;
begin
  tmpStr := AStr;
  i := Pos(' ', tmpStr);
  Result := (Copy(tmpStr, 1, i-1) = AQL);
  if Result then
  begin
    Delete(tmpStr, 1, i);
    i := Pos(' ', tmpStr);
    ASender := Copy(tmpStr, 1, i-1);
    Delete(tmpStr, 1, i);
    i := Pos(' ', tmpStr);
    ARecepient := Copy(tmpStr, 1, i-1);
    Delete(tmpStr, 1, i);
    i := Pos(' ', tmpStr);
    ALang := Copy(tmpStr, 1, i-1);
    Delete(tmpStr, 1, i);
    ABody := tmpStr;
  end;
end;

// -----------------------------------------------------------------------------
function AqlEncodeStr(const ASender, ARecepient, ALang, ABody: WideString): WideString;
begin
  Result := AQL+' '+ASender+' '
            +ARecepient+' '
            +ALang+' '
            +ABody;
end;

// -----------------------------------------------------------------------------
function AqlEncodeXml(const ASender, ARecepient, ALang, ABody: WideString): WideString;
begin
  Result := '<'+AQL+' '+AQL_SENDER+'="'+ASender+'" '
            +AQL_RECEPIENT+'="'+ARecepient+'" '
            +AQL_LANG+'="'+ALang+'">'
            +ABody
            +'</'+AQL+'>';
end;

// -----------------------------------------------------------------------------
function AqlMessageType(const AMsg: WideString): TAqlMessageType;
begin
  Result := AQL_MESSAGE_NONE;
  if Length(AMsg) = 0 then Exit;
  if AMsg[1] = '<' then
    Result := AQL_MESSAGE_XML
  else
    Result := AQL_MESSAGE_STRING;
end;

end.
