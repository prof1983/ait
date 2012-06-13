{**
@Abstract(Описание интерфейса IAiFramePool)
@Author(Prof1983 prof1983@ya.ru)
@Created(02.01.2006)
@LastMod(13.06.2012)
@Version(0.5)
}
unit AiFramePoolIntf;

interface

uses
  ABase,
  AiBase, AiBaseTypes, AiFrameIntf, AiFrameListIntf;

type
  {**
    @abstract(Источник знаний)
    UML соответствие: "Коллекция объектов [ Identity Map ]" http://ooad.asf.ru/Pattern.aspx?IdKat=7&IdPat=9
  }
  IAiFramePool = interface(IAiFrame)
    //** Возвращает базовый идентификатор (идентификатор с которого будет начинаться отсчет ID для фреймов)
    function GetBase(): TAIID; safecall;
    //** Возвращает вместимость хранилища
    function GetCapacity(): Int64; safecall;
    function GetFrames(): IAIFrameList; safecall;
    function GetIsOpened(): WordBool; safecall;
//    function Get_NextFreeFrameID(): TAIID; safecall;

    //** Закрыть пул (источник)
    procedure Close(); safecall;
    //** Сохранить все
    procedure Commit(); safecall;
    //** Пул (источник) содержит в себе фрейм
    function Contains(ID: TAIID): WordBool; safecall;
    //** Заблокировать фрейм
    function LockFrame(x: TAIID): WordBool; safecall;
    //** Заблокировать фрейм
    function LockFrameA(x: IAIFrame): WordBool; safecall;
    //** Заблокировать пул (источник)
    function LockPool(): WordBool; safecall;
    //** Пометить как измененый
    procedure MarkModified(x: TAIID); safecall;
    //** Пометить как измененый
    procedure MarkModifiedA(x: IAIFrame); safecall;
    //** Создать новый фрейм
    function NewFrame(): TAIID; safecall;
    //** Создать новый фрейм
    function NewFrameA(): IAIFrame; safecall;
    //function NewObject(): IAIFrame4;
    //** Создает новый фрейм определенного типа
    //function NewObjectA(Value: IFramerFDType): IAIFrame4;
    //function NewObjectA(Value: IFramerFDType): IAIFrame4;
    //** Открыть пул (источник)
    function Open(): AError; safecall;

    //** Начальный идентификатор для этого пула (источника) фреймов
    property Base: TAIID read GetBase;
    //** Вместимость хранилища
    property Capacity: Int64 read GetCapacity;
    //** Фреймы
    property Frames: IAIFrameList read GetFrames;
    //** Открыт
    property IsOpened: WordBool read GetIsOpened;
    //** Следующий свободный ID для создания фрейма
//    property NextFreeFrameID: TAIID read Get_NextFreeFrameID;
  end;
  //IAIPool = IAIFramePool;
  //IAISource4 = IAIPool;

implementation

end.
