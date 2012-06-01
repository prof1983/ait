{**
@Abstract(XML ACL Codec)
@Author(Prof1983 prof1983@ya.ru)
@Created(28.03.2007)
@LastMod(27.04.2012)
@Version(0.5)

Имена тегов не идентичны, но соответсвуют именам тегов предложеных FIPA.
А именно имена типа "Reply-to" заменены на "replyTo"
}
unit AclXmlCodec;

interface

uses
  AConsts2,
  AclCodecIntf, AclMessageIntf, AclTypes;

type //** @abstract(XML ACL Codec)
  TAclXmlCodec = class(TInterfacedObject, IAclCodec)
  protected
    function GetName(): WideString; safecall;
  public
    class function EncodeMessage(const Msg: WideString; A: WordBool = True): WideString;
    class function EncodeQuery(const Sender, Receiver, Content: WideString;
      A: WordBool = True; APrefix: WideString = '  '): WideString;
    class function EncodeTag(const TagName, TagValue: WideString; A: WordBool = False): WideString;
  public
    function Decode(Data: string; Msg: IAclMessage; Charset: WideString): Integer; safecall;
    function DecodeA(Data: WideString; Msg: IAclMessage): Integer; safecall;
    function Encode(Msg: IAclMessage; Charset: WideString): string; safecall;
    function EncodeA(Msg: IAclMessage): WideString; safecall;
  end;

implementation

const
  NAME_XML_ACL_CODEC = 'XmlAclCodec';

{ TXmlAclCodec }

function TAclXmlCodec.Decode(Data: string; Msg: IAclMessage; Charset: WideString): Integer;
begin
  Result := -1;
  // ...
end;

function TAclXmlCodec.DecodeA(Data: WideString; Msg: IAclMessage): Integer;
begin
  Result := -1;
  // ...
end;

function TAclXmlCodec.Encode(msg: IAclMessage; charset: WideString): string;
begin
  Result := '';
  // ...
end;

function TAclXmlCodec.EncodeA(Msg: IAclMessage): WideString;
begin
  Result := '';
  // ...
end;

class function TAclXmlCodec.EncodeMessage(const Msg: WideString; A: WordBool = True): WideString;
begin
  if not(A) then
    Result := '<?xml version="1.0"?>' + EncodeTag('acl', Msg, False)
  else
    Result := '<?xml version="1.0"?>' + CRLF +
              EncodeTag('acl', Msg, True);
end;

class function TAclXmlCodec.EncodeQuery(const Sender, Receiver, Content: WideString;
  A: WordBool; APrefix: WideString): WideString;
const
  STR_QUERY = 'QUERY';
begin
  if not(A) then
    Result := EncodeMessage(
      EncodeTag('performative', STR_QUERY) +
      EncodeTag('sender', Sender) +
      EncodeTag('receiver', Receiver) +
      EncodeTag('language', 'XQuery') +
      EncodeTag('conversationID', '') +
      EncodeTag('replyTo', Sender) +          // Ответить отправителю
      EncodeTag('replyWith', 'replyWithString') +
      EncodeTag('content', Content, True),
      False
      )
  else
    Result := EncodeMessage(
      EncodeTag(APrefix + 'performative', STR_QUERY) + CRLF +
      EncodeTag(APrefix + 'sender', Sender) + CRLF +
      EncodeTag(APrefix + 'receiver', Receiver) + CRLF +
      EncodeTag(APrefix + 'language', 'XQuery') + CRLF +
      EncodeTag(APrefix + 'conversationID', '') + CRLF +
      EncodeTag(APrefix + 'replyTo', Sender) + CRLF +         // Ответить отправителю
      EncodeTag(APrefix + 'replyWith', 'replyWithString') + CRLF +
      EncodeTag(APrefix + 'content', Content, True),
      True
      );
end;

class function TAclXmlCodec.EncodeTag(const TagName, TagValue: WideString; A: WordBool = False): WideString;
begin
  if not(A) then
    Result := '<' + TagName + '>' + TagValue + '</' + TagName + '>'
  else
    Result := '<' + TagName + '>' + CRLF +
                    TagValue + CRLF +
              '</' + TagName + '>';
end;

function TAclXmlCodec.GetName(): WideString;
begin
  Result := NAME_XML_ACL_CODEC;
end;

end.
