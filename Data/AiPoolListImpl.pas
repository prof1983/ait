{**
@Abstract(Список источников фреймов)
@Author(Prof1983 prof1983@ya.ru)
@Created(16.04.2007)
@LastMod(27.04.2012)
@Version(0.5)
}
unit AiPoolListImpl;

// TODO: Rename to AiFramePoolListImpl

interface

uses
  AiBase, AiBaseTypes, AiFrame, AiFramePoolIntf, AiFramePoolListIntf;

type //** Список источников фреймов
  TAiFramePoolList = class(TInterfacedObject, IAIPoolList)
  private
    FItems: array of IAIFramePool;
  private
    function GetCount(): Integer; safecall;
    function GetSourceByID(ID: TAIID): IAIFramePool; safecall;
    function GetSourceByIndex(Index: Integer): IAIFramePool; safecall;
    function GetSourceByName(const Name: WideString): IAIFramePool; safecall;
  public
    property Count: Integer read GetCount;
    property PoolByID[ID: TAIID]: IAIFramePool read GetSourceByID;
    property PoolByIndex[Index: Integer]: IAIFramePool read GetSourceByIndex;
    property PoolByName[const Name: WideString]: IAIFramePool read GetSourceByName;

    property SourceByID[ID: TAIID]: IAIFramePool read GetSourceByID;
    property SourceByIndex[Index: Integer]: IAIFramePool read GetSourceByIndex;
    property SourceByName[const Name: WideString]: IAIFramePool read GetSourceByName;
  end;

implementation

{ TAiFramePoolList }

function TAiFramePoolList.GetCount(): Integer;
begin
  Result := Length(FItems);
end;

function TAiFramePoolList.GetSourceByID(ID: TAIID): IAIFramePool;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to High(FItems) do
  begin
    if (FItems[i].FrameID = ID) then
    begin
      Result := FItems[i];
      Exit;
    end;
  end;
end;

function TAiFramePoolList.GetSourceByIndex(Index: Integer): IAIFramePool;
begin
  Result := nil;
  if (Index >= 0) and (Index < Length(FItems)) then
  try
    Result := FItems[Index];
  except
  end;
end;

function TAiFramePoolList.GetSourceByName(const Name: WideString): IAIFramePool;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to High(FItems) do
    if FItems[i].Name = Name then
    begin
      Result := FItems[i];
      Exit;
    end;
end;

end.
