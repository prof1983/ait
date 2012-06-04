{**
@Abstract(Описание интерфейса IAiPoolList)
@Author(Prof1983 prof1983@ya.ru)
@Created(02.01.2006)
@LastMod(04.06.2012)
@Version(0.5)
}
unit AiFramePoolListIntf;

interface

uses
  AiBase, AiFrame, AiFramePoolIntf;

type
  IAiPoolList = interface
    function GetCount(): Integer; safecall;
    function GetSourceByID(Id: TAiId): IAiFramePool; safecall;
    function GetSourceByIndex(Index: Integer): IAiFramePool; safecall;
    function GetSourceByName(const Name: WideString): IAiFramePool; safecall;

    property Count: Integer read GetCount;
    property SourceByID[Id: TAiId]: IAiFramePool read GetSourceById;
    property SourceByIndex[Index: Integer]: IAiFramePool read GetSourceByIndex;
    property SourceByName[const Name: WideString]: IAiFramePool read GetSourceByName;
  end;

implementation

end.
