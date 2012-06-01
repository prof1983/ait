{**
@Abstract(Выборка фреймов)
@Author(Prof1983 prof1983@ya.ru)
@Created(26.04.2006)
@LastMod(25.04.2012)
@Version(0.5)
}
unit AiSelectObj;

interface

uses
  ATypes,
  AiBase, AiFrameObj;

type //** Выборка фреймов
  TAiSelectObject = class
  private
    FItems: array of TAId;
    FQuery: String;
    FSource: AiSourceObject;
  public
    function GetFreim(Index: Int32): TAiFreimObject;
    function GetItem(Index: Int32): TAId;
  public
    function Count: Int32;
    constructor Create(AQuery: string);
  public
    property Freims[Index: Int32]: TAiFreimObject read GetFreim;
    property Items[Index: Int32]: TAId read GetItem;
    property Query: String read FQuery;
    property Source: AiSourceObject read FSource write FSource;
  end;
  TAiSelect = TAiSelectObject;
  TAI_Select = TAiSelect;

implementation

uses
  AiSourceObj;

{ TAiSelect }

function TAiSelectObject.Count(): Int32;
begin
  Result := Length(FItems);
end;

constructor TAiSelectObject.Create(AQuery: String {AConfig: TConfigNode = nil; ALog: TLogNode = nil});
begin
  inherited Create();
  SetLength(FItems, 0);
  FQuery := AQuery;
end;

function TAiSelectObject.GetFreim(Index: Int32): TAiFreimObject;
var
  Id: TAId;
  Source: TAiSourceObject;
begin
  Source := TAiSourceObject(FSource);
  if not(Assigned(Source)) then
  begin
    Result := nil;
    Exit;
  end;
  Id := GetItem(Index);
  if (Id = 0) then
  begin
    Result := nil;
    Exit;
  end;
  // TODO: Conflict TAI_Freim and TAiFreimObject types
  Result := nil; //Result := Source.Freims[ID];
end;

function TAiSelectObject.GetItem(Index: Int32): TAId;
begin
  if (Index >= 0) and (Index < Length(FItems)) then
    Result := FItems[Index]
  else
    Result := 0;
end;

end.
