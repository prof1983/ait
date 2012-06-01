{**
@Abstract(Список источников фреймов)
@Author(Prof1983 prof1983@ya.ru)
@Created(16.04.2007)
@LastMod(16.03.2012)
@Version(0.5)
}
unit AiSourceListImpl;

interface

uses
  AiBase, AiIntf;

type //** @abstract(Список источников фреймов)
  TAISourceList3 = class(TInterfacedObject, IAISourceList3)
  private
    FSources: array of IAISource3;
  private
    function GetCount(): Integer; safecall;
    function GetSourceByID(ID: TAIID): IAISource3; safecall;
    function GetSourceByIndex(Index: Integer): IAISource3; safecall;
    function GetSourceByName(const Name: WideString): IAISource3; safecall;
  public
    property Count: Integer read GetCount;
    property SourceByID[ID: TAIID]: IAISource3 read GetSourceByID;
    property SourceByIndex[Index: Integer]: IAISource3 read GetSourceByIndex;
    property SourceByName[const Name: WideString]: IAISource3 read GetSourceByName;
  end;

implementation

{ TAISourceList3 }

function TAISourceList3.GetCount(): Integer;
begin
  Result := Length(FSources);
end;

function TAISourceList3.GetSourceByID(ID: TAIID): IAISource3;
begin
  Result := nil;
  // ...
end;

function TAISourceList3.GetSourceByIndex(Index: Integer): IAISource3;
begin
  Result := nil;
  // ...
end;

function TAISourceList3.GetSourceByName(const Name: WideString): IAISource3;
begin
  Result := nil;
  // ...
end;

end.
