{**
@Abstract(AiFrameSchema definition)
@Author(Prof1983 prof1983@ya.ru)
@Created(06.04.2007)
@LastMod(28.04.2012)
@Version(0.5)
}
unit AiKbFrame;

interface

uses
  AConsts2;

const
  AIFrameSchema =
    '<?xml version="1.0"?>'+CRLF+
    '<xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema"'+CRLF+
    //'targetNamespace="http://www.w3schools.com"'+CRLF+
    //'xmlns="http://www.w3schools.com"'+CRLF+
    'elementFormDefault="qualified">'+CRLF+
    '  <xs:element name="frame">'+CRLF+
    '    <xs:complexType>'+CRLF+
    '      <xs:sequence>'+CRLF+
    '	       <xs:element name="ID" type="xs:integer"/>'+CRLF+
    '	       <xs:element name="DateCreate" type="xs:date"/>'+CRLF+
    '	       <xs:element name="DateModify" type="xs:date"/>'+CRLF+
    '	       <xs:element name="Data" type="xs:string"/>'+CRLF+
    '      </xs:sequence>'+CRLF+
    '    </xs:complexType>'+CRLF+
    '  </xs:element>'+CRLF+
    '</xs:schema>';

implementation

end.
