{**
@Abstract(Источник знаний)
@Author(Prof1983 prof1983@ya.ru)
@Created(23.05.2007)
@LastMod(20.06.2012)
@Version(0.5)

Прототип: org.framerd.Pool

История версий:
0.0.3.0 - 06.07.2007 - Сделал наследником от TLogingObject
0.0.2.2 - 04.07.2007
0.0.2.1 - 24.06.2007 - Изменил Contains()
0.0.2.0 - Добавил GetIterator(), Iterator
0.0.1.2 - Добавил методы Select() и SelectT()
0.0.1.3 - Добавил методы IsBoolEntity, IsIntEntity, IsFloatEntity, IsStringEntity, IsCollectionEntity
}
unit AiPoolImpl;

interface

uses
  ABase, ABaseTypes, ACollectionIntf, AEntityIntf, AIteratorIntf,
  AiBaseTypes, AiCollectionImpl, AiConsts, AiLogingObject, AiPoolIntf;

type //** Источник знаний
  TAiPool = class(TAiLogingObject, IAiPool)
  protected
    //** Начальный идентификатор для этого пула (источника) фреймов
    FBase: TAId;
    //** Вместимость хранилища
    FCapacity: Int64;
  protected
    {**
    Возвращает базовый идентификатор
    (идентификатор с которого будет начинаться отсчет ID для фреймов)
    }
    function GetBase(): TAId; virtual;
    //** Возвращает вместимость хранилища
    function GetCapacity(): Int64; virtual;
    {**
    Возвращает колличество записаных сущностей
    (колличество использованых идентификаторов)
    }
    function GetCount(): Int64; virtual;
    //** Возвращает True, если открыт
    function GetIsOpened(): Boolean; virtual;
    {**
    Возвращает итератор.
    Служит для перечисления всех сущностей по порядку
    }
    function GetIterator(): IAIterator; virtual;
  public
    {** Возвращает сущность по идентификатору }
    function GetEntityById(Id: AId): IAEntity;
    {** Return entity by index
        @return(Entity by index) }
    function GetEntityByIndex(Index: Integer): IAEntity; virtual;
    //** Возвращает значение сущности как Boolean
    function GetEntityValueAsBool(Id: TAId): Boolean; virtual;
    //** Возвращает значение сущности как Integer
    function GetEntityValueAsInt(Id: TAId): Integer; virtual;
    //** Возвращает значение сущности как Float
    function GetEntityValueAsFloat(Id: TAId): Double; virtual;
    //** Возвращает значение сущности как String
    function GetEntityValueAsString(Id: TAId): WideString; virtual;
    //** Возвращает значение сущности как DateTime
    function GetEntityValueAsDateTime(Id: TAId): TDateTime; virtual;
    //** Возвращает значение сущности как Collection
    function GetEntityValueAsCollection(Id: TAId): IACollection; virtual;
    //** Возвращает тип данных сущности
    function GetEntityValueType(Id: TAId): TAiValueType; virtual;
    //** Возвращает тип сущности
    function GetEntityType(Id: TAId): TAId; virtual;
    //** Задает значение сущности как Boolean
    procedure SetEntityValueAsBool(Id: TAId; Value: Boolean); virtual;
    //** Задает значение сущности как Integer
    procedure SetEntityValueAsInt(Id: TAId; Value: Integer); virtual;
    //** Задает значение сущности как Float
    procedure SetEntityValueAsFloat(Id: TAId; Value: Double); virtual;
    //** Задает значение сущности как String
    procedure SetEntityValueAsString(Id: TAId; Value: WideString); virtual;
    //** Задает значение сущности как DateTime
    procedure SetEntityValueAsDateTime(Id: TAId; Value: TDateTime); virtual;
  public
    //function GetEntityByIndex(Index: Integer): IAIEntity; virtual;
  public
    //** Возвращает true, если сущность является Bool
    function IsBoolEntity(Entity: IAEntity): Boolean;
    //** Возвращает true, если сущность является Int
    function IsIntEntity(Entity: IAEntity): Boolean;
    //** Возвращает true, если сущность является Float
    function IsFloatEntity(Entity: IAEntity): Boolean;
    //** Возвращает true, если сущность является строкой
    function IsStringEntity(Entity: IAEntity): Boolean;
    //** Возвращает true, если сущность является коллекцией
    function IsCollectionEntity(Entity: IAEntity): Boolean;
  public
    {** Закрывает пул (источник) }
    function Close(): AError; virtual;
    {** Сохраняет все изменения }
    function Commit(): AError;
    {** Созраняет сущность в пул }
    function CommitEntity(Entity: IAEntity): AError;
    {** Возвращает True, если пул (источник) содержит в себе сущность }
    function Contains(Id: TAId): Boolean; virtual;
    {** Блокирует сущность }
    function LockEntity(X: IAEntity): AError;
    {** Блокирует сущность }
    function LockEntityById(Id: AId): AError; virtual;
    //** Заблокировать пул (источник)
    function LockPool(): Boolean; virtual;
    {** Помечает как измененый }
    function MarkModified(Id: IAEntity): AError;
    {** Помечает как измененый }
    function MarkModifiedById(Id: AId): AError;
    {** Создает новую сущность }
    function NewEntity(): AId;
    {** Создает новую сущность (заререзвировать идентификатор под сущность) }
    function NewEntity2(EntityType: AId): AId; virtual;
    {** Создает новую сущность }
    function NewEntityA(): IAEntity;
    //** Открыть пул (источник)
    function Open(): AError; virtual;
    //** Сделать выборку сущностей по запросу
    function Select(Query: WideString): IACollection; virtual;
    //** Сделать выборку всех сущностей определенного типа
    function SelectT(TypeId: TAId): IACollection; virtual;
      {** Делает выборку всех сущностей определенного типа }
    function SelectT2(TypeId: TAId): ACollection; virtual;
    //** Разблокировать сущность
    procedure UnLockEntity(Id: TAId); virtual;
    {** Обновить все данные из пула }
    function Update(): AError;
    {** Обновить данные сущности из пула }
    function UpdateEntity(Entity: IAEntity): AError;
  public
    function AddElement(Id, Element: TAId): Boolean;    // ToCollection
    function InsertElement(Id, Element: TAId; Index: Integer): Boolean; // To Array
    function InsertElementIterator(Iterator: IAIterator; Id, Element: TAId): Boolean; // To Collection
    function RemoteElementIterator(Iterator: IAIterator; Id: TAId): Boolean;
    //function RemoteElement(ID, Element: TAIID): Boolean; // FromCollection
  public
    procedure AfterConstruction(); override;
  public
    //** Начальный идентификатор для этого пула (источника) фреймов
    property Base: TAId read GetBase;
    //** Вместимость хранилища
    property Capacity: Int64 read GetCapacity;
    {**
    Колличество записаных сущностей
    (колличество использованых идентификаторов)
    }
    property Count: Int64 read GetCount;
    //** Открыт
    property IsOpened: Boolean read GetIsOpened;
    {**
    Итератор
    Служит для перечисления всех сущностей по порядку
    }
    property Iterator: IAIterator read GetIterator;
  end;

implementation

{ TAIPool }

function TAiPool.AddElement(Id, Element: TAId): Boolean;
begin
  Result := False;
end;

procedure TAiPool.AfterConstruction();
begin
  inherited;
  FBase := 2048;
  FCapacity := 100000;
end;

function TAiPool.Close(): AError;
begin
  Result := -1;
end;

function TAiPool.Commit(): AError;
begin
  Result := -1;
end;

function TAiPool.CommitEntity(Entity: IAEntity): AError;
begin
  Result := -1;
end;

function TAiPool.Contains(Id: TAId): Boolean;
begin
  if (FCapacity > 0) then
    Result := (ID >= FBase) and (ID < FBase + FCapacity)
  else
    Result := False;
end;

function TAiPool.GetBase(): TAId;
begin
  Result := FBase;
end;

function TAiPool.GetCapacity(): Int64;
begin
  Result := FCapacity;
end;

function TAiPool.GetCount(): Int64;
begin
  Result := 0;
end;

function TAiPool.GetEntityById(Id: AId): IAEntity;
begin
  Result := nil;
end;

function TAiPool.GetEntityByIndex(Index: Integer): IAEntity;
begin
  Result := nil;
end;

function TAiPool.GetEntityType(Id: TAId): TAId;
begin
  Result := 0;
end;

function TAiPool.GetEntityValueAsBool(Id: TAId): Boolean;
begin
  Result := False;
end;

function TAiPool.GetEntityValueAsCollection(Id: TAId): IACollection;
begin
  Result := nil;
end;

function TAiPool.GetEntityValueAsDateTime(Id: TAId): TDateTime;
begin
  Result := 0;
end;

function TAiPool.GetEntityValueAsFloat(Id: TAId): Double;
begin
  Result := 0;
end;

function TAiPool.GetEntityValueAsInt(Id: TAId): Integer;
begin
  Result := 0;
end;

function TAiPool.GetEntityValueAsString(Id: TAId): WideString;
begin
  Result := '';
end;

function TAiPool.GetEntityValueType(Id: TAId): TAiValueType;
begin
  Result := aivtEmpty;
end;

function TAiPool.GetIsOpened(): Boolean;
begin
  Result := False;
end;

function TAiPool.GetIterator(): IAIterator;
begin
  Result := nil;
  // ...
end;

function TAiPool.InsertElement(Id, Element: TAId; Index: Integer): Boolean;
begin
  Result := False;
end;

function TAiPool.InsertElementIterator(Iterator: IAIterator; Id, Element: TAId): Boolean;
begin
  Result := False;
end;

function TAiPool.IsBoolEntity(Entity: IAEntity): Boolean;
begin
  Result := Assigned(Entity) and (Entity.EntityType = AIBoolType);
end;

function TAiPool.IsCollectionEntity(Entity: IAEntity): Boolean;
begin
  Result := Assigned(Entity) and (Entity.EntityType = AICollectionType);
end;

function TAiPool.IsFloatEntity(Entity: IAEntity): Boolean;
begin
  Result := Assigned(Entity) and (Entity.EntityType = AIFloatType);
end;

function TAiPool.IsIntEntity(Entity: IAEntity): Boolean;
begin
  Result := Assigned(Entity) and (Entity.EntityType = AIIntType);
end;

function TAiPool.IsStringEntity(Entity: IAEntity): Boolean;
begin
  Result := Assigned(Entity) and (Entity.EntityType = AIStringType);
end;

function TAiPool.LockEntity(X: IAEntity): AError;
begin
  Result := -1;
end;

function TAiPool.LockEntityById(Id: AId): AError;
begin
  Result := -1;
end;

function TAiPool.LockPool(): Boolean;
begin
  Result := False;
end;

function TAiPool.MarkModified(Id: IAEntity): AError;
begin
  Result := -1;
end;

function TAiPool.MarkModifiedById(Id: AId): AError;
begin
  Result := -1;
end;

function TAiPool.NewEntity(): AId;
begin
  Result := 0;
end;

function TAiPool.NewEntity2(EntityType: AId): AId;
begin
  Result := 0;
end;

function TAiPool.NewEntityA(): IAEntity;
begin
  Result := nil;
end;

function TAiPool.Open(): AError;
begin
  Result := -1;
end;

{function TAIPool.RemoteElement(ID, Element: TAIID): Boolean;
begin
  Result := False;
end;}

function TAiPool.RemoteElementIterator(Iterator: IAIterator; Id: TAId): Boolean;
begin
  Result := False;
end;

function TAiPool.Select(Query: WideString): IACollection;
begin
  Result := nil;
end;

function TAiPool.SelectT(TypeId: TAId): IACollection;
begin
  Result := TAiCollection.Create();
  // ...
end;

function TAiPool.SelectT2(TypeId: TAId): ACollection;
begin
  Result := ACollection(TAiCollection.Create());
  // ...
end;

procedure TAiPool.SetEntityValueAsBool(Id: TAId; Value: Boolean);
begin
end;

procedure TAiPool.SetEntityValueAsDateTime(Id: TAId; Value: TDateTime);
begin
end;

procedure TAiPool.SetEntityValueAsFloat(Id: TAId; Value: Double);
begin
end;

procedure TAiPool.SetEntityValueAsInt(Id: TAId; Value: Integer);
begin
end;

procedure TAiPool.SetEntityValueAsString(Id: TAId; Value: WideString);
begin
end;

procedure TAiPool.UnLockEntity(Id: TAId);
begin
end;

function TAiPool.Update(): AError;
begin
  Result := -1;
end;

function TAiPool.UpdateEntity(Entity: IAEntity): AError;
begin
  Result := -1;
end;

end.
