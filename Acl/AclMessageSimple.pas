{**
@Abstract(Простой класс для работы с сообщением ACL)
@Author(Prof1983 prof1983@ya.ru)
@Created(21.06.2007)
@LastMod(23.03.2012)
@Version(0.5)

История версий:
0.0.1.0 - 21.06.2007 - Создан на основе IAclMessage
}
unit AclMessageSimple;

interface

uses
  AclConsts, AclMessageIntf;

type
  //** @abstract(Простой класс для работы с сообщением ACL)
  TAclMessageSimple = class(TInterfacedObject, IAclMessage)
  protected
    FConversationID: WideString;
    FContent: WideString;
    FEncoding: WideString;
    FInReplyTo: WideString;
    FLanguage: WideString;
    FOntologyStr: WideString;
    FProtocol: WideString;
    FReceiverName: WideString;
    FReplyBy: WideString;
    FReplyByDate: TDateTime;
    FReplyWith: WideString;
    FPerformative: TAclPerformative;
    FPersistentID: Int64;
    FSenderName: WideString;
  protected
    {**
      Идентификатор сообщений
      Reads <code>:conversation-id</code> slot.
      @return The value of <code>:conversation-id</code>slot.
      @see jade.lang.acl.ACLMessage#setConversationId(String).
    }
    function GetConversationID(): WideString;
    {**
      Содержание сообщения
      Reads <code>:content</code> slot. <p>
      <p>Notice that, in general, setting a String content and getting
      back a byte sequence content - or viceversa - does not return
      the same value, i.e. the following relation does not hold
      <code>
      getByteSequenceContent(setByteSequenceContent(getContent().getBytes()))
      is equal to getByteSequenceContent()
      </code>
      @return The value of <code>:content</code> slot.
      @see jade.lang.acl.ACLMessage#setContent(String)
      @see jade.lang.acl.ACLMessage#getByteSequenceContent()
      @see jade.lang.acl.ACLMessage#getContentObject()
      @see java.io.ObjectInputStream
    }
    function GetContent(): WideString;
    {**
      Кодировка содержания сообщения
      Reads <code>:encoding</code> slot.
      @return The value of <code>:encoding</code>slot.
      @see jade.lang.acl.ACLMessage#setEncoding(String).
    }
    function GetEncoding(): WideString;
    {**
      Строка, идентифицирующая сообщение соответствует параметру
      reply-with при ответе на сообщение
      Reads <code>:reply-to</code> slot.
      @return The value of <code>:reply-to</code>slot.
      @see jade.lang.acl.ACLMessage#setInReplyTo(String).
    }
    function GetInReplyTo(): WideString;
    {**
      Язык кодирования сообщения
      Reads <code>:language</code> slot.
      @return The value of <code>:language</code>slot.
      @see jade.lang.acl.ACLMessage#setLanguage(String).
    }
    function GetLanguage(): WideString;
    {**
      Онтология, используемая для интерпретации сообщения
      Reads <code>:ontology</code> slot.
      @return The value of <code>:ontology</code>slot.
      @see jade.lang.acl.ACLMessage#setOntology(String).
    }
    function GetOntologyStr(): WideString;
    {**
      Протокол взаимодействия агентов
      Reads <code>:protocol</code> slot.
      @return The value of <code>:protocol</code>slot.
      @see jade.lang.acl.ACLMessage#setProtocol(String).
    }
    function GetProtocol(): WideString;
    //** Имя получателя
    function GetReceiverName(): WideString;
    {**
      Время, к которому необходимо получить ответ
      Reads <code>:reply-by</code> slot.
      @return The value of <code>:reply-by</code>slot, as a string.
      @see jade.lang.acl.ACLMessage#getReplyByDate().
      @deprecated Since the value of this slot is a Date by definition, then
      the <code>getReplyByDate</code> should be used that returns a Date
    }
    function GetReplyBy(): WideString;
    {**
      Время, к которому необходимо получить ответ
      Reads <code>:reply-by</code> slot.
      @return The value of <code>:reply-by</code>slot, as a
      <code>Date</code> object.
      @see jade.lang.acl.ACLMessage#setReplyByDate(Date).
    }
    function GetReplyByDate(): TDateTime;
    {**
      Строка, идентифицирующая сообщение
      Reads <code>:reply-with</code> slot.
      @return The value of <code>:reply-with</code>slot.
      @see jade.lang.acl.ACLMessage#setReplyWith(String).
    }
    function GetReplyWith(): WideString;
    {**
      Тип сообщения
      return the integer representing the performative of this object
      @return an integer representing the performative of this object
    }
    function GetPerformative(): TAclPerformative;
  	//** For persistence service
    function GetPersistentID(): Int64;
    //** Имя отправителя
    function GetSenderName(): WideString;

    //** Онтология
    procedure SetOntologyStr(const Value: WideString);
    //** Имя получателя
    procedure SetReceiverName(const Value: WideString);
    //** Имя отправителя
    procedure SetSenderName(const Value: WideString);
  public
    //** Онтология
    //property OntologyStr: WideString read GetOntologyStr write SetOntologyStr;
    //** Имя получателя
    //property ReceiverName: WideString read GetReceiverName write SetReceiverName;
    //** Имя отправителя
    //property SenderName: WideString read GetSenderName write SetSenderName;
  public
    property ConversationID: WideString read FConversationID write FConversationID;
    property Content: WideString read FContent write FContent;
    property Encoding: WideString read FEncoding write FEncoding;
    property InReplyTo: WideString read FInReplyTo write FInReplyTo;
    property Language: WideString read FLanguage write FLanguage;
    //** Онтология
    property OntologyStr: WideString read FOntologyStr write FOntologyStr;
    property Protocol: WideString read FProtocol write FProtocol;
    //** Имя получателя
    property ReceiverName: WideString read FReceiverName write FReceiverName;
    property ReplyBy: WideString read FReplyBy write FReplyBy;
    property ReplyByDate: TDateTime read FReplyByDate write FReplyByDate;
    property ReplyWith: WideString read FReplyWith write FReplyWith;
    property Performative: TAclPerformative read FPerformative write FPerformative;
    property PersistentID: Int64 read FPersistentID write FPersistentID;
    //** Имя отправителя
    property SenderName: WideString read FSenderName write FSenderName;
  end;

implementation

{ TAclMessageSimple }

function TAclMessageSimple.GetContent(): WideString;
begin
  Result := FContent;
end;

function TAclMessageSimple.GetConversationID(): WideString;
begin
  Result := FConversationID;
end;

function TAclMessageSimple.GetEncoding(): WideString;
begin
  Result := FEncoding;
end;

function TAclMessageSimple.GetInReplyTo(): WideString;
begin
  Result := InReplyTo;
end;

function TAclMessageSimple.GetLanguage(): WideString;
begin
  Result := FLanguage;
end;

function TAclMessageSimple.GetOntologyStr(): WideString;
begin
  Result := FOntologyStr;
end;

function TAclMessageSimple.GetPerformative(): TAclPerformative;
begin
  Result := FPerformative;
end;

function TAclMessageSimple.GetPersistentID(): Int64;
begin
  Result := FPersistentID;
end;

function TAclMessageSimple.GetProtocol(): WideString;
begin
  Result := FProtocol;
end;

function TAclMessageSimple.GetReceiverName(): WideString;
begin
  Result := FReceiverName;
end;

function TAclMessageSimple.GetReplyBy(): WideString;
begin
  Result := ReplyBy;
end;

function TAclMessageSimple.GetReplyByDate(): TDateTime;
begin
  Result := ReplyByDate;
end;

function TAclMessageSimple.GetReplyWith(): WideString;
begin
  Result := FReplyWith;
end;

function TAclMessageSimple.GetSenderName(): WideString;
begin
  Result := FSenderName;
end;

procedure TAclMessageSimple.SetOntologyStr(const Value: WideString);
begin
  FOntologyStr := Value;
end;

procedure TAclMessageSimple.SetReceiverName(const Value: WideString);
begin
  FReceiverName := Value;
end;

procedure TAclMessageSimple.SetSenderName(const Value: WideString);
begin
  FSenderName := Value;
end;

end.
