{**
@Abstract(Объект доступа к вложенным сущностям)
@Author(Prof1983 prof1983@ya.ru)
@Created(15.05.2007)
@LastMod(20.06.2012)
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

// TODO: Move to AiConnectsImpl.pas

interface

uses
  ABase, AEntityIntf,
  AiBase, AiBaseTypes, AiEntityIntf, AiPoolIntf;

type //** @abstract(Объект доступа к вложенным сущностям)
  TAiEntities = class(TInterfacedObject, IAiEntities)
  private
    //** Сущности
    FEntities: array of TAId;
    //** Пул, откуда запрашиваются сущности по идентификатору
    FPool: IAiPool;
  protected
    //** Возвращает сущность по идентификатору
    function GetById(Id: AId): IAEntity;
    //** Возвращает сущность по индексу
    function GetByIndex(Index: AInt): IAEntity;
    //** Возвращает сущность по имени
    function GetByName(const Name: WideString): IAEntity;
    //** Возврвщает колличество сущностей
    function GetCount(): Integer;
  public
    {** Добавляет сущность (в списке может находится только один экземпляр)
        Если сущность уже присутствует в списке возвращает False,
        если добавлено успешно возвращает True. }
    function Add(Id: AId): Boolean; overload;
    {** Добавляет сущность (в списке может находится только один экземпляр)
        Если сущность уже присутствует в списке возвращает False,
        если добавлено успешно возвращает True. }
    function Add(Entity: IAEntity): ABoolean; overload;
    {** Удаляет сущность из списка }
    function Remove(Entity: IAEntity): ABoolean; overload;
    {** Удаляет сущность из списка }
    function RemoveById(Entity: AId): ABoolean; overload;
  public
    constructor Create(Pool: IAiPool);
  public
    //** Сущности по идентификатору
    property ById[Id: AId]: IAEntity read GetById;
    //** Сущности по индексу
    property ByIndex[Index: AInt]: IAEntity read GetByIndex;
    //** Сущности по имени
    property ByName[const Name: WideString]: IAEntity read GetByName;
    //** Колличество сущностей
    property Count: Integer read GetCount;
    //** Пул для чтения и записи сущностей
    property Pool: IAiPool read FPool;
  end;

implementation

{ TAIWSEntities }

function TAiEntities.Add(Entity: IAEntity): ABoolean;
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

constructor TAiEntities.Create(Pool: IAiPool);
begin
  inherited Create();
  FPool := Pool;
end;

function TAiEntities.Add(ID: TAId): Boolean;
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

function TAiEntities.GetById(Id: AId): IAEntity;
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

function TAiEntities.GetByIndex(Index: AInt): IAEntity;
var
  id: TAId;
begin
  Result := nil;
  if (Index < 0) or (Index >= Length(FEntities)) then Exit;

  id := FEntities[Index];
  FPool.EntityByID[id];
end;

function TAiEntities.GetByName(const Name: WideString): IAEntity;
var
  e: IAEntity;
  i: Integer;
begin
  Result := nil;
  {
  for i := 0 to High(FEntities) do
  begin
    e := FPool.EntityById[FEntities[i]];
    if (e.Name = Name) then
    begin
      Result := e;
      Exit;
    end;
  end;
  }
end;

function TAiEntities.GetCount(): Integer;
begin
  Result := Length(FEntities);
end;

function TAiEntities.Remove(Entity: IAEntity): ABoolean;
begin
  Result := RemoveById(Entity.Id);
end;

function TAiEntities.RemoveById(Entity: AId): ABoolean;
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

end.
