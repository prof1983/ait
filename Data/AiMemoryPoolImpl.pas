{**
@Abstract(Источник знаний)
@Author(Prof1983 prof1983@ya.ru)
@Created(23.05.2007)
@LastMod(04.06.2012)
@Version(0.5)

История версий:
0.0.2.1 - 28.06.2007
0.0.2.0 - 01.06.2007 - Добавил GetIterator(), GetCount(), TAIMemoryPoolIterator, Open(), Close(), Contains()
0.0.1.1 - 31.05.2007 - Переименован AIMemoryPool -> AIMemoryPoolImpl
}
unit AiMemoryPoolImpl;

interface

uses
  ABase, AEntityIntf, AIteratorIntf,
  AiConsts, AiEntityImpl, AiNamedEntity, AiPoolImpl;

type //** Пул с хранением сущностей в памяти
  TAiMemoryPool = class(TAiPool)
  private
    FEntities: array of IAEntity;
    FIsOpened: Boolean;
  protected
    {**
      Возвращает колличество записаных сущностей
      (колличество использованых идентификаторов)
    }
    function GetCount(): Int64; override;
      //** Возвращает True, если открыт
    function GetIsOpened(): Boolean; override;
    {**
      Возвращает итератор.
      Служит для перечисления всех сущностей по порядку
    }
    function GetIterator(): IAIterator; override;
  public
      {**
        Return entity by index
        @return(Entity by index)
      }
    function GetEntityByIndex(Index: Integer): IAEntity; override;
      //** Создать новую сущность (заререзвировать идентификатор под сущность)
    function NewEntity(EntityType: TAId): TAId; override;
  public
      //** Закрыть пул (источник)
    procedure Close(); override;
      //** Пул (источник) содержит в себе сущность
    function Contains(ID: TAId): Boolean; override;
      //** Открыть пул (источник)
    function Open(): AError; override;
  public
    function GetFreeId(): TAId;
  end;

type
  TAiMemoryPoolA = class(TAIMemoryPool)
  public
    function NewNamedEntity(EntityType: TAId; Name: WideString): TAId;
    function NewNamedEntityA(EntityType: TAId; Name: WideString): IAINamedEntity;
    //function NewValueEntity(): IAIValueEntity;
    function NewType(Name: WideString): TAId;
  end;

implementation

type //** Итератор для MemoryPool
  TAiMemoryPoolIterator = class(TInterfacedObject, IAIterator)
  private
    FPool: TAIMemoryPool;
  public
    {**
      Returns true if the iteration has more elements.
      In other words, returns true if next would return an element
      rather than throwing an exception.
      @return(true if the iterator has more elements)
    }
    function HasNext(): Boolean;
    //** Вставить элемент в коллекцию
    function Insert(Element: TAId): Boolean;
    //** Пусто?
    function IsEmpty(): Boolean;
    //** Удалить текущий элемент из коллекции
    function Remove(): Boolean;

    //** Следующий элемент коллекции
    function Next(): TAId;
  public
    property Pool: TAIMemoryPool read FPool write FPool;
  end;

{ TAiMemoryPool }

procedure TAiMemoryPool.Close();
begin
  FIsOpened := False;
end;

function TAiMemoryPool.Contains(ID: TAId): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to High(FEntities) do
    if FEntities[i].EntityID = ID then
    begin
      Result := True;
      Exit;
    end;
end;

function TAiMemoryPool.GetCount(): Int64;
begin
  Result := Length(FEntities);
end;

function TAiMemoryPool.GetEntityByIndex(Index: Integer): IAEntity;
begin
  if (Index >= 0) and (Index < Length(FEntities)) then
    Result := FEntities[Index]
  else
    Result := nil;
end;

function TAiMemoryPool.GetFreeId(): TAId;
var
  I: Integer;
  Id: Integer;
  Max: TAId;
begin
  Max := 0;
  for I := 0 to High(FEntities) do
  begin
    Id := FEntities[I].EntityId;
    if (Max < Id) then
      Max := Id;
  end;
  Result := Max + 1;
end;

function TAiMemoryPool.GetIsOpened(): Boolean;
begin
  Result := FIsOpened;
end;

function TAiMemoryPool.GetIterator(): IAIterator;
var
  iterator: TAIMemoryPoolIterator;
begin
  iterator := TAIMemoryPoolIterator.Create();
  iterator.Pool := Self;
  Result := iterator;
end;

function TAiMemoryPool.NewEntity(EntityType: TAId): TAId;
var
  I: Integer;
  Id: TAId;
  Entity: TAiEntity;
begin
  Id := Self.GetFreeId();
  if (Id <= 0) then
  begin
    Result := 0;
    Exit;
  end;

  Entity := TAiEntity.Create3(Self, Id, EntityType);

  I := Length(FEntities);
  SetLength(FEntities, I + 1);
  FEntities[I] := Entity;

  Result := Id;
end;

function TAiMemoryPool.Open(): AError;
begin
  Result := 0;
  FIsOpened := True;
end;

{ TAiMemoryPoolA }

function TAiMemoryPoolA.NewNamedEntity(EntityType: TAId; Name: WideString): TAId;
var
  e: IAEntity;
begin
  Result := 0;
  e := NewNamedEntityA(EntityType, Name);
  if Assigned(e) then
    Result := e.EntityID;
end;

function TAiMemoryPoolA.NewNamedEntityA(EntityType: TAId; Name: WideString): IAiNamedEntity;
begin
  Result := nil;

  //Result := NewSlotedEntityA(EntityType);
  //if not(Assigned(Result)) then Exit;
  //Result.Name := Name;
end;

function TAiMemoryPoolA.NewType(Name: WideString): TAId;
begin
  // Создаем новую именованую сущность
  Result := NewNamedEntity(AINullType, Name);
end;

{ TAiMemoryPoolIterator }

function TAiMemoryPoolIterator.HasNext(): Boolean;
begin
  Result := False;
end;

function TAiMemoryPoolIterator.Insert(Element: TAId): Boolean;
begin
  Result := False;
  // ...
end;

function TAiMemoryPoolIterator.IsEmpty(): Boolean;
begin
  Result := True;
  // ...
end;

function TAiMemoryPoolIterator.Next(): TAId;
begin
  Result := 0;
  // ...
end;

function TAiMemoryPoolIterator.Remove(): Boolean;
begin
  Result := False;
  // ...
end;

end.
