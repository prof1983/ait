{**
@Abstract(AiList - Список фреймов)
@Author(Prof1983 prof1983@ya.ru)
@Created(07.06.2012)
@LastMod(08.06.2012)
@Version(0.0)
}
unit AiListObj;

interface

uses
  ABase, ATypes, AiFrameObj, AiPoolUtils;

type
  TAiListObject = class(TAiFrameObject)
  protected
    FItems: array of record
      Id: Integer;
      Freim: TAiFrameObject;
    end;
  public
    function GetCount(): Integer;
    function GetCountItems(): UInt32; deprecated; // Use GetCount()
    function GetItem(Index: UInt32): TAiFrameObject;
    function GetItemById(Id: TAId): TAiFrameObject;
    function GetItemByIndex(Index: Integer): TAiFrameObject;
    function GetItemId(Index: AInt): TAId;
  public
      //** Добавить фрейм в список
    function Add(Value: TAIFrame): Integer;
      //** Добавить элемент
    function AddItem(AID: Integer): Integer;
      //** Проверить
    function Check(): Boolean; virtual;
      //** Очистить список
    function Clear(): AError; override;
      //** Удалить
    function DeleteByIndex(Index: AInt): AError;
  public
      //** Колличество
    property Count: Integer read GetCount;
      //** Id элементов
    property ItemsId[Index: AInt]: TAId read GetItemId;
      //** Элементы по индексу
    property ItemsByIndex[Index: AInt]: TAiFrameObject read GetItemByIndex;
      //** Элементы по Id
    property ItemsById[Id: TAId]: TAiFrameObject read GetItemById;
  end;

implementation

{ TAiListObject }

function TAiListObject.Add(Value: TAIFrame): Integer;
begin
  Result := -1;
  if not(Assigned(Value)) then Exit;
  Result := Length(FItems);
  SetLength(FItems, Result + 1);
  FItems[Result].ID := Value.ID;
  FItems[Result].Freim := Value;
end;

function TAiListObject.AddItem(AID: Integer): Integer;
begin
  Result := Length(FItems);
  SetLength(FItems, Result + 1);
  FItems[Result].ID := AID;
  FItems[Result].Freim := nil;
end;

function TAiListObject.Check(): Boolean;
begin
  Result := True;
end;

function TAiListObject.Clear(): AError;
begin
  SetLength(FItems, 0);
  Result := 0;
end;

function TAiListObject.DeleteByIndex(Index: AInt): AError;
var
  I: Int32;
begin
  Result := 1;
  if Index >= UInt32(Length(FItems)) then Exit;
  for I := Index to High(FItems) - 1 do
    FItems[I] := FItems[I + 1];
  SetLength(FItems, High(FItems));
  Result := 0;
end;

function TAiListObject.GetCount(): Integer;
begin
  Result := Length(FItems);
end;

function TAiListObject.GetCountItems(): UInt32;
begin
  Result := Length(FItems);
end;

function TAiListObject.GetItem(Index: UInt32): TAiFrameObject;
begin
  if Index >= UInt32(Length(FItems)) then
    Result := nil
  else
    Result := FItems[Index].Freim;
end;

function TAiListObject.GetItemById(Id: TAId): TAiFrameObject;
var
  I: Integer;
begin
  // Prof1983: 05.07.2011
  {
  Result := nil;
  try
    // Поиск в списке
    for I := 0 to High(FItems) do
      if FItems[I].ID = ID then
      begin
        Result := FItems[I].Freim;
        if not(Assigned(Result)) and Assigned(Self.Source) then
        begin
          // Получаем фрейм из источника
          Result := TAIFrame(Self.Source.Frames.FrameByID[ID]);
          FItems[I].Freim := Result;
        end;
        Exit;
      end;
  except
  end;
  }
  Result := nil;
end;

function TAiListObject.GetItemByIndex(Index: Integer): TAiFrameObject;
begin
  Result := nil;
  if (Index >= 0) and (Index < Length(FItems)) then
  begin
    if not(Assigned(FItems[Index].Freim)) and (FPool <> 0) then
      FItems[Index].Freim := Pool_GetFrameById(FPool, FItems[Index].Id);
    Result := FItems[Index].Freim;
  end;
end;

function TAiListObject.GetItemId(Index: AInt): TAId;
begin
  if Index >= Length(FItems) then
    Result := 0
  else
    Result := FItems[Index].ID;
end;

end.
