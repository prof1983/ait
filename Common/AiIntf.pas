{**
@Abstract(Описание интерфейсов для AI)
@Author(Prof1983 prof1983@ya.ru)
@Created(02.01.2006)
@LastMod(05.07.2012)
@Version(0.5)
}
unit AiIntf;

interface

uses
  ActiveX, XmlIntf,
  ABase, AObjectIntf, ATypes,
  AiBase, AiConnectsIntf, AiDataIntf, AiFrameIntf, AiSourceIntf, AiTypes;

type
  Largeuint = LongWord;

type
  IAiDataEx1 = interface(IAiData2)
    procedure Clear(); safecall;
    function Get_Text(): WideString; safecall;
    function Get_XmlNode(): IXmlNode; safecall;
    function Get_XmlDocument(): IXmlDocument; safecall;
    procedure Set_Text(const Value: WideString); safecall;
    procedure Set_XmlNode(Value: IXmlNode); safecall;
    procedure Set_XmlDocument(Value: IXmlDocument); safecall;

    property Text: WideString read Get_Text write Set_Text;
    property XmlNode: IXmlNode read Get_XmlNode write Set_XmlNode;
    property XmlDocument: IXmlDocument read Get_XmlDocument write Set_XmlDocument;
  end;

  IAIFrame2 = interface(IAIFrame) // from IAIFreim
    function LoadFromRecF64(Rec: TAIFreimRecF64): WordBool; safecall;
  end;

// --- AIIntf3 -------------------------------------------------------------------------------------

type
  {**
    @abstract(Фрейм - единица знаний)
    В случае использования БЗ OWL тип фрейма всегда edtXml.
  }
  IAiFrame3 = interface(IProfObject)
    //function Get_Connects(): IAIConnects; safecall;
    function Get_Data(): IAiData2; safecall;
    function Get_DateTimeCreate(): TDateTime; safecall;
    function Get_FrameID(): TAIID; safecall;
    function Get_FrameName(): WideString; safecall;
    function Get_FrameType(): TAIID; safecall;
    function Get_Source(): IAISource2; safecall;
    procedure Set_DateTimeCreate(Value: TDateTime); safecall;
    procedure Set_FrameID(Value: TAIID); safecall;
    procedure Set_FrameType(Value: TAIID); safecall;

    //** Связи с другими фреймами
    //property Connects: IAIConnects read Get_Connects;
    //** Данные фрейма
    property Data: IAiData2 read Get_Data;
    //** Дата создания
    property DateTimeCreate: TDateTime read Get_DateTimeCreate write Set_DateTimeCreate;
    //** Идентификатор
    property FrameID: TAIID read Get_FrameID write Set_FrameID;
    //** Тип фрейма
    property FrameType: TAIID read Get_FrameType write Set_FrameType;
    //** Имя фрейма
    property Name: WideString read Get_FrameName;
    //** Источник фрейма
    property Source: IAISource2 read Get_Source;
  end;

type // Интерфейс для форм
  IAIForm = interface
      // Послать сообщения ядру
    function SendMessageToCore(const AMsg: WideString): Integer;
  end;

implementation

end.
