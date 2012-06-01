{**
@Abstract(Список фреймов)
@Author(Prof1983 prof1983@ya.ru)
@Created(30.03.2006)
@LastMod(27.04.2012)
@Version(0.5)
}
unit AiListImpl;

interface

uses
  AiFrameImpl;

type //** Список фреймов
  TAiList = class(TAiFrame)
  protected
    FItems: array of record
      Id: Integer;
      Freim: TAiFrame;
    end;
    function GetCount(): Integer;
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
    function Clear(): WordBool; override;
      //** Удалить
    function DeleteByIndex(Index: Integer): Boolean;
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
  TAIList3 = TAIList;

implementation

{ TAiList }

function TAiList.Add(Value: TAIFrame): Integer;
begin
  Result := -1;
  if not(Assigned(Value)) then Exit;
  Result := Length(FItems);
  SetLength(FItems, Result + 1);
  FItems[Result].ID := Value.ID;
  FItems[Result].Freim := Value;
end;

function TAiList.AddItem(AID: Integer): Integer;
begin
  Result := Length(FItems);
  SetLength(FItems, Result + 1);
  FItems[Result].ID := AID;
  FItems[Result].Freim := nil;
end;

function TAiList.Check(): Boolean;
begin
  Result := True;
end;

function TAiList.Clear(): WordBool;
begin
  SetLength(FItems, 0);
  Result := True;
end;

function TAiList.DeleteByIndex(Index: Integer): Boolean;
var
  I: Integer;
begin
  Result := False;
  if Index >= Length(FItems) then Exit;
  for I := Index to High(FItems) - 1 do FItems[I] := FItems[I + 1];
  SetLength(FItems, High(FItems));
  Result := True;
end;

function TAiList.GetCount(): Integer;
begin
  Result := Length(FItems);
end;

function TAiList.GetItemByID(ID: Integer): TAIFrame;
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

function TAiList.GetItemByIndex(Index: Integer): TAIFrame;
begin
  Result := nil;
  if (Index >= 0) and (Index < Length(FItems)) then
  begin
    if not(Assigned(FItems[Index].Freim)) and Assigned(FPool) then
      FItems[Index].Freim := TAIFrame(FPool.Frames.FrameByID[FItems[Index].ID]);
    Result := FItems[Index].Freim;
  end;
end;

function TAiList.GetItemID(Index: Integer): Integer;
begin
  if Index >= Length(FItems) then
    Result := 0
  else
    Result := FItems[Index].ID;
end;

end.
