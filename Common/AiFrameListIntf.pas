{**
@Abstract(Описание интерфейса IAiFrameList)
@Author(Prof1983 prof1983@ya.ru)
@Created(02.01.2006)
@LastMod(13.06.2012)
@Version(0.5)
}
unit AiFrameListIntf;

interface

uses
  AiBase, AiFrameIntf;

type
  IAiFrameList = interface
    function GetCount(): Integer; safecall;
    function GetFrameById(Id: TAId): IAiFrame; safecall;
    function GetFrameByUri(const Uri: WideString): IAiFrame; safecall;
    function GetFrameByGuid(Guid: TGuid): IAiFrame; safecall;

      //** Колличество фреймов
    property Count: Integer read GetCount;
      //** Фреймы по ID
    property FrameById[Id: TAId]: IAiFrame read GetFrameById;
    property FrameByUri[const Uri: WideString]: IAiFrame read GetFrameByUri;
    property FrameByGuid[Guid: TGuid]: IAiFrame read GetFrameByGuid;
  end;

implementation

end.
