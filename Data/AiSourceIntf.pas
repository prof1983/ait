{**
@Abstract(AiSource interface)
@Author(Prof1983 prof1983@ya.ru)
@Created(27.06.2012)
@LastMod(27.06.2012)
@Version(0.5)
}
unit AiSourceIntf;

interface

uses
  ABase,
  AiFrameIntf;

type
  {**
    Источник знаний.
  }
  IAiSource1 = interface(IAiFreim)
    function Get_Freim(Id: AId): IAiFreim;

    function GetFreim(Id: AId): IAiFreim;

    property Freims[Id: AId]: IAiFreim read Get_Freim;
  end;
  //IAiSource = IAiSource1;

  {**
    Источник знаний.
    UML соответствие: "Коллекция объектов [ Identity Map ]" http://ooad.asf.ru/Pattern.aspx?IdKat=7&IdPat=9
  }
  IAiSource2 = interface(IAiSource1)
    function Get_FrameCount(): Integer; safecall;
    function Get_FrameById(Id: AId): IAiFrame; safecall;
    function Get_IsOpened(): WordBool; safecall;
    function Get_NextFreeFrameId(): AId; safecall;

    //** Закрыть источник
    procedure Close(); safecall;
    //** Открыть источник
    function Open(): AError; safecall;

    //** Фреймы по Id
    property FrameById[Id: AId]: IAiFrame read Get_FrameById;
    property FrameCount: Integer read Get_FrameCount;
    //** Открыт
    property IsOpened: WordBool read Get_IsOpened;
    //** Следующий свободный Id для создания фрейма
    property NextFreeFrameId: AId read Get_NextFreeFrameId;
  end;

  IAiSourceList3 = interface
    function GetSourceById(Id: AId): IAiSource2; safecall;
    function GetSourceByIndex(Index: Integer): IAiSource2; safecall;
    function GetSourceByName(const Name: WideString): IAiSource2; safecall;
    function GetCount(): Integer; safecall;

    property Count: Integer read GetCount;
    property SourceById[Id: AId]: IAiSource2 read GetSourceById;
    property SourceByIndex[Index: Integer]: IAiSource2 read GetSourceByIndex;
    property SourceByName[const Name: WideString]: IAiSource2 read GetSourceByName;
  end;

implementation

end.
