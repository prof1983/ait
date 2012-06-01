{**
@Abstract(AiCodeSchema)
@Author(Prof1983 prof1983@ya.ru)
@Created(06.04.2007)
@LastMod(28.04.2012)
@Version(0.5)
}
unit AiKbCode;

interface

uses
  AConsts2;

{const
  AI_FreimCode_Count = 1;
  AI_FreimCode: array[0..AI_FreimCode_Count-1] of TElement = (
    (Name: 'class';       Typ: etXml;   Title: 'Класс'; Elements)
  );}
// <?xml version="1.0"?>
// <xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema" targetNamespace="http://www.w3schools.com"
//   xmlns="http://www.w3schools.com" elementFormDefault="qualified">

// <?xml version="1.0"?>
// <xs:schema xmlns:xs="http://prof-ar.narod.ru/">
// ...
// </xs:schema>
const
  AiCodeSchema: WideString =
    // class
    '<xs:element name="class">'+CRLF+
    '  <xs:attribute name="name" type="String" required="False" />'+CRLF+
    '  <xs:attribute name="id" type="Integer" required="False" />'+CRLF+
    '  <xs:attribute name="description" type="String" />'+CRLF+
    '  <xs:attribute name="pclass" type="String" />'+CRLF+
    '  <xs:attribute name="pid" type="Integer" />'+CRLF+
    '  <xs:element name="property" type="String">'+CRLF+
    '    <xs:attribute name="name" type="String" />'+CRLF+
    '    <xs:attribute name="id" type="Integer" />'+CRLF+
    '    <xs:attribute name="description" type="String" />'+CRLF+
    '  </xs:element>'+CRLF+
    '  <xs:element name="method">'+CRLF+
    '    <xs:attribute name="name" type="String" />'+CRLF+
    '    <xs:attribute name="id" type="Integer" />'+CRLF+
    '    <xs:attribute name="description" type="String" />'+CRLF+
    '  </xs:element>'+CRLF+
    '  <xs:element name="interface" />'+CRLF+
    '</xs:element>'+CRLF+
    // object
    '<xs:element name="object">'+CRLF+
    '  <xs:attribute name="name" type="String" required="False" />'+CRLF+
    '  <xs:attribute name="id" type="Integer" required="False" />'+CRLF+
    '  <xs:attribute name="description" type="String" />'+CRLF+
    '  <xs:attribute name="class" type="String" />'+CRLF+
    '  <xs:attribute name="pid" type="Integer" />'+CRLF+
       // property
    '  <xs:element name="property" type="String">'+CRLF+
    '    <xs:attribute name="name" type="String" />'+CRLF+
    '    <xs:attribute name="id" type="Integer" />'+CRLF+
    '    <xs:attribute name="description" type="String" />'+CRLF+
    '  </xs:element>'+CRLF+
       // method
    '  <xs:element name="method">'+CRLF+
    '    <xs:attribute name="name" type="String" />'+CRLF+
    '    <xs:attribute name="id" type="Integer" />'+CRLF+
    '    <xs:attribute name="description" type="String" />'+CRLF+
         // Операторы языка
         // if
    '    <xs:element name="if">'+CRLF+
    '      <xs:element name="then" required="True" />'+CRLF+
    '      <xs:element name="else" required="False" />'+CRLF+
    '      <xs:element name="elseif" required="False" />'+CRLF+
    '    </xs:element>'+CRLF+
         // switch
    '    <xs:element name="switch">'+CRLF+
    '      <xs:element name="case">'+CRLF+
    '        <xs:attribute name="value" required="True" />'+CRLF+
    '      </xs:element>'+CRLF+
    '    </xs:element>'+CRLF+
         // try
    '    <xs:element name="try">'+CRLF+
    '      <xs:element name="except" />'+CRLF+
    '      <xs:element name="finally" />'+CRLF+
    '    </xs:element>'+CRLF+
         // ol - Нумерованый список
    '    <xs:element name="ol">'+CRLF+
    '      <xs:element name="li" />'+CRLF+
    '    </xs:element>'+CRLF+
         // ul - Не нумерованый список
    '    <xs:element name="ul">'+CRLF+
    '      <xs:element name="li" />'+CRLF+
    '    </xs:element>'+CRLF+
    '  </xs:element>'+CRLF+
    '  <xs:element name="interface" />'+CRLF+
    '</xs:element>'+CRLF+
    // interface
    '<xs:element name="interface">'+CRLF+
    '  <xs:attribute name="name" type="String" />'+CRLF+
    '  <xs:attribute name="id" type="Integer" />'+CRLF+
    '  <xs:attribute name="description" type="String" />'+CRLF+
    '  <xs:element name="property" type="String">'+CRLF+
    '    <xs:attribute name="name" type="String" />'+CRLF+
    '    <xs:attribute name="id" type="Integer" />'+CRLF+
    '    <xs:attribute name="description" type="String" />'+CRLF+
    '  </xs:element>'+CRLF+
    '  <xs:element name="method">'+CRLF+
    '    <xs:attribute name="name" type="String" />'+CRLF+
    '    <xs:attribute name="id" type="Integer" />'+CRLF+
    '    <xs:attribute name="description" type="String" />'+CRLF+
    '  </xs:element>'+CRLF+
    '</xs:element>'+CRLF+
    // comment
    '<xs:element name="comment" />'+CRLF+
    // enum
    '<xs:element name="enum">'+CRLF+
    '  <xs:attribute name="name" type="String" />'+CRLF+
    '  <xs:attribute name="id" type="Integer" />'+CRLF+
    '  <xs:attribute name="description" type="String" />'+CRLF+
    '  <xs:element name="const">'+CRLF+
    '    <xs:attribute name="name" type="String" />'+CRLF+
    '    <xs:attribute name="id" type="Integer" />'+CRLF+
    '    <xs:attribute name="description" type="String" />'+CRLF+
    '  </xs:element>'+CRLF+
    '</xs:element>';

implementation

end.
