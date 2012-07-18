{**
@Abstract(Список источников фреймов)
@Author(Prof1983 <prof1983@ya.ru>)
@Created(16.04.2007)
@LastMod(18.07.2012)
}
unit AiSourceListImpl;

interface

uses
  AiBase, AiSourceIntf;

type //** @abstract(Список источников фреймов)
  TAiSourceList = class(TInterfacedObject, IAiSourceList)
  private
    FSources: array of IAiSource2;
  private
    function GetCount(): Integer; safecall;
    function GetSourceByID(ID: TAIID): IAiSource2; safecall;
    function GetSourceByIndex(Index: Integer): IAiSource2; safecall;
    function GetSourceByName(const Name: WideString): IAiSource2; safecall;
  public
    property Count: Integer read GetCount;
    property SourceByID[ID: TAIID]: IAiSource2 read GetSourceByID;
    property SourceByIndex[Index: Integer]: IAiSource2 read GetSourceByIndex;
    property SourceByName[const Name: WideString]: IAiSource2 read GetSourceByName;
  end;

  TAiSourceList3 = TAiSourceList;

implementation

{ TAiSourceList }

function TAiSourceList.GetCount(): Integer;
begin
  Result := Length(FSources);
end;

function TAiSourceList.GetSourceByID(ID: TAIID): IAiSource2;
begin
  Result := nil;
  // ...
end;

function TAiSourceList.GetSourceByIndex(Index: Integer): IAiSource2;
begin
  Result := nil;
  // ...
end;

function TAiSourceList.GetSourceByName(const Name: WideString): IAiSource2;
begin
  Result := nil;
  // ...
end;

end.
