{**
@Abstract(Базовые интерфейсы для работы с языком ACL)
@Author(Prof1983 prof1983@ya.ru)
@Created(23.03.2007)
@LastMod(13.03.2012)
@Version(0.5)

История версий:
0.1.0.2 - 29.07.2007 - Переименован AIAclMessage -> AclMessage
0.1.0.1 - 04.07.2007
0.1.0.0 - 21.06.2007
}
unit AclMessageIntf;

interface

uses
  AclConsts;

type
  IAclMessage = interface
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

    {**
     Reads <code>:sender</code> slot.
     @return The value of <code>:sender</code>slot.
     @see jade.lang.acl.ACLMessage#setSender(AID).
    }
    //function GetSender(): TAID;

    // [Prof]
    procedure SetOntologyStr(const Value: WideString);
    //** Имя получателя
    procedure SetReceiverName(const Value: WideString);
    //** Имя отправителя
    procedure SetSenderName(const Value: WideString);

    //** Онтология
    property OntologyStr: WideString read GetOntologyStr write SetOntologyStr;
    //** Имя получателя
    property ReceiverName: WideString read GetReceiverName write SetReceiverName;
    //** Имя отправителя
    property SenderName: WideString read GetSenderName write SetSenderName;
  end;

implementation

end.
