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
    function GetItemByID(ID: Integer): TAIFrame;
    function GetItemByIndex(Index: Integer): TAIFrame;
    function GetItemID(Index: Integer): Integer;
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
    property ItemsID[Index: Integer]: Integer read GetItemID;
      //** Элементы по индексу
    property ItemsByIndex[Index: Integer]: TAIFrame read GetItemByIndex;
      //** Элементы по Id
    property ItemsByID[ID: Integer]: TAIFrame read GetItemByID;
  end;

  TAiList20050915 = TAiListObject;

  TAiList20050830 = class(TAiList20050915)
  private
    FItems: array of TAiFrameObject;
  public
    function Clear(): TError; override;
    function GetCountItems(): UInt32;
    function DeleteByIndex(Index: UInt32): TError;
    function GetItem(Index: UInt32): TAiFrameObject;
  end;

  TAiList20050526 = class(TAiList20050830)
  public
    function Clear: TError; virtual;
  end;

  TAiList20050525 = class(TAiList20050526)
  private
    FItems: array of TAiFrameObject;
  public
    function Clear(): TError; override;
    function GetCountItems(): UInt32;
    function DeleteByIndex(Index: UInt32): TError;
    function GetItem(Index: UInt32): TAiFrameObject;
  end;

implementation

{ TAiList20050525 }

function TAiList20050525.Clear(): TError;
begin
  SetLength(FItems, 0);
  Result := 0;
end;

function TAiList20050525.DeleteByIndex(Index: UInt32): TError;
var
  I: Int32;
begin
  Result := 1;
  if Index >= UInt32(Length(FItems)) then Exit;
  for I := Index to High(FItems) - 1 do FItems[I] := FItems[I + 1];
  SetLength(FItems, High(FItems));
  Result := 0;
end;

function TAiList20050525.GetCountItems(): UInt32;
begin
  Result := Length(FItems);
end;

function TAiList20050525.GetItem(Index: UInt32): TAiFrameObject;
begin
  if Index >= UInt32(Length(FItems)) then
    Result := nil
  else
    Result := FItems[Index];
end;

{ TAiList20050526 }

function TAiList20050526.Clear(): TError;
begin
  Result := 0;
end;

{ TAiList20050830 }

function TAiList20050830.Clear(): TError;
begin
  SetLength(FItems, 0);
  Result := 0;
end;

function TAiList20050830.DeleteByIndex(Index: UInt32): TError;
var
  I: Int32;
begin
  Result := 1;
  if Index >= UInt32(Length(FItems)) then Exit;
  for I := Index to High(FItems) - 1 do FItems[I] := FItems[I + 1];
  SetLength(FItems, High(FItems));
  Result := 0;
end;

function TAiList20050830.GetCountItems(): UInt32;
begin
  Result := Length(FItems);
end;

function TAiList20050830.GetItem(Index: UInt32): TAiFrameObject;
begin
  if Index >= UInt32(Length(FItems)) then
    Result := nil
  else
    Result := FItems[Index];
end;

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

function TAiListObject.GetItemByID(ID: Integer): TAIFrame;
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

function TAiListObject.GetItemByIndex(Index: Integer): TAIFrame;
begin
  Result := nil;
  if (Index >= 0) and (Index < Length(FItems)) then
  begin
    if not(Assigned(FItems[Index].Freim)) and (FPool <> 0) then
      FItems[Index].Freim := Pool_GetFrameById(FPool, FItems[Index].Id);
    Result := FItems[Index].Freim;
  end;
end;

function TAiListObject.GetItemID(Index: Integer): Integer;
begin
  if Index >= Length(FItems) then
    Result := 0
  else
    Result := FItems[Index].ID;
end;

end.
