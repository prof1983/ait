{**
@Abstract(ACL Codec)
@Author(Prof1983 prof1983@ya.ru)
@Created(20.03.2007)
@LastMod(27.04.2012)
@Version(0.5)
}
unit AclCodecIntf;

interface

uses
  AclMessageIntf;

const
  DEFAULT_CHARSET = 'US-ASCII'; // ISO-8859-1

type
  {**
    Абстрактный интерфейс для преобразования сообщений ACL, согласно FIPA
    описания сообщений ACL.
    (Abstract interface for converting ACL messages back and forth
    between Java objects and raw byte sequences, according to a FIPA
    ACL message representation.)
  }
  IAclCodec = interface
    {**
     Query the name of the message representation handled by this
     <code>Codec</code> object. The FIPA standard representations have
     a name starting with <code><b>"fipa.acl.rep."</b></code>.
     @return The name of the handled ACL message representation.
    }
    function GetName(): WideString; safecall;

    {**
     Encodes an <code>ACLMessage</code> object into a byte sequence,
     according to the specific message representation.
     @param msg The ACL message to encode.
     @param charset Charset encoding to use (e.g. US_ASCII, UTF-8, etc)
     @return a byte array, containing the encoded message.
    }
    function Encode(Msg: IAclMessage; charset: WideString): string; safecall;

    //** Закодировать объект AclMessage в WideString строку
    function EncodeA(Msg: IAclMessage): WideString; safecall;

    {**
     Recovers an <code>ACLMessage</code> object back from raw data,
     using the specific message representation to interpret the byte
     sequence.
     @param data The byte sequence containing the encoded message.
     @param charset Charset encoding to use (e.g. US_ASCII, UTF-8, etc)
     @return A new <code>ACLMessage</code> object, built from the raw
     data.
     @exception CodecException If some kind of syntax error occurs.
    }
    function Decode(Data: string; Msg: IAclMessage; charset: WideString): Integer; safecall;
    //function Decode(data: string; charset: WideString): IAclMessage; safecall;

    //** Восстановить AclMessage объект из WideString строки
    function DecodeA(Data: WideString; Msg: IAclMessage): Integer; safecall;

    //** Имя кодека
    property Name: WideString read GetName;
  end;

implementation

end.
