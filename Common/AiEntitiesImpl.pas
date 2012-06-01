{**
@Abstract(Объект доступа к вложенным сущностям)
@Author(Prof1983 prof1983@ya.ru)
@Created(15.05.2007)
@LastMod(25.04.2012)
@Version(0.5)

Записываются идентификаторы сущностей.
Идентификатор сущности должен быть обязательно задан.

Аналоги:
  aterm.ATermAppl.GetArgument()
  org.framerd.FDType.Enumerate
  org.framerd.FDType.Get()
  ru.narod.profsoft.ai.common.aiFrame.Slots
  java.util.Set
}
unit AiEntitiesImpl;

interface

uses
  AiBase, AiBaseTypes, AiEntityIntf, AiPoolIntf;

type //** @abstract(Объект доступа к вложенным сущностям)
  TAIWSEntities = class(TInterfacedObject, IAIWSEntities)
  private
    //** Сущности
    FEntities: array of TAId;
    //** Пул, откуда запрашиваются сущности по идентификатору
    FPool: IAIWSPool;
  protected
    //** Возвращает сущность по идентификатору
    function GetByID(ID: TAId): IAIWSEntity;
    //** Возвращает сущность по индексу
    function GetByIndex(Index: Integer): IAIWSEntity;
    //** Возвращает сущность по имени
    function GetByName(Name: WideString): IAIWSEntity;
    //** Возврвщает колличество сущностей
    function GetCount(): Integer;
  public
    {**
    Добавить сущность (в списке может находится только один экземпляр)
    Если сущность уже присутствует в списке возвращает False,
    если добавлено успешно возвращает True.
    }
    function Add(ID: TAId): Boolean; overload;
    {**
    Добавить сущность (в списке может находится только один экземпляр)
    Если сущность уже присутствует в списке возвращает False,
    если добавлено успешно возвращает True.
    }
    function Add(Entity: IAIWSEntity): Boolean; overload;
    constructor Create(Pool: IAIWSPool); 
    //** Удалить сущность из списка
    function Remote(Entity: TAId): Boolean; overload;
    //** Удалить сущность из списка
    function Remote(Entity: IAIWSEntity): Boolean; overload;
  public
    //** Сущности по идентификатору
    property ByID[ID: TAId]: IAIWSEntity read GetByID;
    //** Сущности по индексу
    property ByIndex[Index: Integer]: IAIWSEntity read GetByIndex;
    //** Сущности по имени
    property ByName[Name: WideString]: IAIWSEntity read GetByName;
    //** Колличество сущностей
    property Count: Integer read GetCount;
    //** Пул для чтения и записи сущностей
    property Pool: IAIWSPool read FPool;
  end;

implementation

{ TAIWSEntities }

function TAIWSEntities.Add(Entity: IAIWSEntity): Boolean;
var
  i: Integer;
begin
  Result := False;
  // Проверяем наличие добавляемой сущности в списке
  for i := 0 to High(FEntities) do
    if ((Entity.ID <> 0) and (FEntities[i] = Entity.ID)) then
      Exit;

  i := Length(FEntities);
  SetLength(FEntities, i + 1);
  FEntities[i] := Entity.ID;

  Result := True;
end;

constructor TAIWSEntities.Create(Pool: IAIWSPool);
begin
  inherited Create();
  FPool := Pool;
end;

function TAIWSEntities.Add(ID: TAId): Boolean;
var
  i: Integer;
begin
  Result := False;
  if ID = 0 then Exit;
  // Проверяем наличие добавляемой сущности в списке
  for i := 0 to High(FEntities) do
    if (FEntities[i] = ID) then
      Exit;

  i := Length(FEntities);
  SetLength(FEntities, i + 1);
  FEntities[i] := ID;

  Result := True;
end;

function TAIWSEntities.GetByID(ID: TAId): IAIWSEntity;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to High(FEntities) do
    if FEntities[i] = ID then
    begin
      Result := FPool.EntityByID[ID];
      Exit;
    end;
end;

function TAIWSEntities.GetByIndex(Index: Integer): IAIWSEntity;
var
  id: TAId;
begin
  Result := nil;
  if (Index < 0) or (Index >= Length(FEntities)) then Exit;

  id := FEntities[Index];
  FPool.EntityByID[id];
end;

function TAIWSEntities.GetByName(Name: WideString): IAIWSEntity;
var
  e: IAIWSEntity;
  i: Integer;
begin
  Result := nil;
  for i := 0 to High(FEntities) do
  begin
    e := FPool.EntityByID[FEntities[i]];
    if e.Name = Name then
    begin
      Result := e;
      Exit;
    end;
  end;
end;

function TAIWSEntities.GetCount(): Integer;
begin
  Result := Length(FEntities);
end;

function TAIWSEntities.Remote(Entity: TAId): Boolean;
var
  i: Integer;
  i2: Integer;
begin
  Result := False;
  for i := 0 to High(FEntities) do
    if FEntities[i] = Entity then
    begin
      for i2 := i to High(FEntities) - 1 do
        FEntities[i2] := FEntities[i2 + 1];
      SetLength(FEntities, i - 1);
      Result := True;
      Exit;
    end;
end;

function TAIWSEntities.Remote(Entity: IAIWSEntity): Boolean;
begin
  Result := Remote(Entity.ID);
end;

end.
