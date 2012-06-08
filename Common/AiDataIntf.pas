{**
@Abstract(Описание интерфейса для IAiData)
@Author(Prof1983 prof1983@ya.ru)
@Created(02.01.2006)
@LastMod(08.06.2012)
@Version(0.5)
}
unit AiDataIntf;

interface

uses
  AiTypes;

type //** Интерфейс для работы с данными фрейма
  IAiData = interface
    //** Очистить данные
    procedure Clear(); safecall;
    //** Получить тип данных
    function Get_DataType(): TAIDataType; safecall;
    //function Get_Opened(): WordBool; safecall;
    procedure Set_DataType(Value: TAIDataType); safecall;
    //procedure Set_Opened(Value: WordBool); safecall;

    property DataType: TAIDataType read Get_DataType write Set_DataType;
    //property Opened: WordBool read Get_Opened write Set_Opened;
  end;

type //** Интерфейс для работы с данными фрейма
  IAiData2 = interface(IAiData)
    //** Получить тип данных
    function Get_DataTypeEnum(): AIDataTypeEnum; safecall;
    function Get_Opened(): WordBool; safecall;
    //function Get_Stream(): IStream; safecall;
    function Get_Text(): WideString; safecall;
    //function Get_Xml(): IXmlNode; safecall;
    //function Get_XmlDocument(): IXmlDocument; safecall;
    procedure Set_Opened(Value: WordBool); safecall;
    procedure Set_DataTypeEnum(Value: AiDataTypeEnum); safecall;
    procedure Set_Text(const Value: WideString); safecall;
    //procedure Set_Xml(Value: IXmlNode); safecall;
    //procedure Set_XmlDocument(Value: IXmlDocument); safecall;

    property DataTypeEnum: AiDataTypeEnum read Get_DataTypeEnum write Set_DataTypeEnum;
    property Opened: WordBool read Get_Opened write Set_Opened;
    //property Stream: IStream read Get_Stream;
    property Text: WideString read Get_Text write Set_Text;
    //property Xml: IXmlNode read Get_Xml write Set_Xml;
    //property XmlDocument: IXmlDocument read Get_XmlDocument write Set_XmlDocument;
  end;

type
  IAiStreamData = interface(IAiData)
    //function Get_Stream(): IStream; safecall;

    //property Stream: IStream read Get_Stream;
  end;

type
  IAiTextData = interface(IAiData)
    function Get_Text(): WideString; safecall;
    procedure Set_Text(const Value: WideString); safecall;

    property Text: WideString read Get_Text write Set_Text;
  end;

type
  IAiXmlData = interface(IAiData)
    //function Get_Xml(): IXmlNode; safecall;
    //function Get_XmlDocument(): IXmlDocument; safecall;
    //procedure Set_Xml(Value: IXmlNode); safecall;
    //procedure Set_XmlDocument(Value: IXmlDocument); safecall;

    //property Xml: IXmlNode read Get_Xml write Set_Xml;
    //property XmlDocument: IXmlDocument read Get_XmlDocument write Set_XmlDocument;
  end;

implementation

end.
