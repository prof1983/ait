{**
@Abstract(Список источников фреймов)
@Author(Prof1983 prof1983@ya.ru)
@Created(16.04.2007)
@LastMod(10.07.2012)
@Version(0.5)
}
unit AiSourceListImpl;

interface

uses
  AiBase, AiSourceIntf;

type //** @abstract(Список источников фреймов)
  TAISourceList3 = class(TInterfacedObject, IAISourceList3)
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

implementation

{ TAISourceList3 }

function TAISourceList3.GetCount(): Integer;
begin
  Result := Length(FSources);
end;

function TAISourceList3.GetSourceByID(ID: TAIID): IAiSource2;
begin
  Result := nil;
  // ...
end;

function TAISourceList3.GetSourceByIndex(Index: Integer): IAiSource2;
begin
  Result := nil;
  // ...
end;

function TAISourceList3.GetSourceByName(const Name: WideString): IAiSource2;
begin
  Result := nil;
  // ...
end;

end.
