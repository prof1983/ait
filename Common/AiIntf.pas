{**
@Abstract(Описание интерфейсов для AI)
@Author(Prof1983 prof1983@ya.ru)
@Created(02.01.2006)
@LastMod(08.06.2012)
@Version(0.5)
}
unit AiIntf;

interface

uses
  ActiveX, XmlIntf,
  ABase, AObjectIntf, ATypes,
  AiBase, AiConnectsIntf, AiDataIntf, AiFrame, AiTypes;

type
  Largeuint = LongWord;

type // ------------------------------------------------------------------------
  IAiSource1 = interface;
  IAiSource2 = interface;

  //** Интерфейс для работы с данными фрейма
  IAiData2 = AiDataIntf.IAiData2;
  IAiData = IAiData2;

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

  IAIFrameNamed = IAIFrame;

  IAIFreimEx1 = interface(IAIFreim)
    function GetFreimID(): TAId; safecall;
    procedure SetFreimID(Value: TAId); safecall;

    property FreimID: TAId read GetFreimID write SetFreimID;
  end;

  IAiSource1 = interface(IAiFreim)
    function Get_Freim(ID: TAId): IAIFreim;

    function GetFreim(ID: TAId): IAIFreim;

    property Freims[ID: TAId]: IAIFreim read Get_Freim;
  end;
  //IAiSource = IAiSource1;

  {
  Источник знаний.
  UML соответствие: "Коллекция объектов [ Identity Map ]" http://ooad.asf.ru/Pattern.aspx?IdKat=7&IdPat=9
  }
  IAiSource2 = interface(IAiSource1)
    function Get_FrameCount(): Integer; safecall;
    function Get_FrameById(Id: TAiId): IAIFrame; safecall;
    function Get_IsOpened(): WordBool; safecall;
    function Get_NextFreeFrameId(): TAiId; safecall;

    //** Закрыть источник
    procedure Close(); safecall;
    //** Открыть источник
    function Open(): AError; safecall;

    //** Фреймы по Id
    property FrameById[Id: TAiId]: IAIFrame read Get_FrameById;
    property FrameCount: Integer read Get_FrameCount;
    //** Открыт
    property IsOpened: WordBool read Get_IsOpened;
    //** Следующий свободный Id для создания фрейма
    property NextFreeFrameId: TAiId read Get_NextFreeFrameId;
  end;
  IAiSource3 = IAiSource2;

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

  IAINamedFrame3 = IAIFrame3;

type
  IAiSourceList3 = interface
    function GetSourceByID(ID: TAIID): IAISource3; safecall;
    function GetSourceByIndex(Index: Integer): IAISource3; safecall;
    function GetSourceByName(const Name: WideString): IAISource3; safecall;
    function GetCount(): Integer; safecall;

    property Count: Integer read GetCount;
    property SourceByID[ID: TAIID]: IAISource3 read GetSourceByID;
    property SourceByIndex[Index: Integer]: IAISource3 read GetSourceByIndex;
    property SourceByName[const Name: WideString]: IAISource3 read GetSourceByName;
  end;

type
  IAIObject3 = IAIFrame3;
  IAIModule3 = IAIObject3;

type // Интерфейс для форм
  IAIForm = interface
      // Послать сообщения ядру
    function SendMessageToCore(const AMsg: WideString): Integer; safecall;
  end;

implementation

end.
