{**
@Abstract(Источник знаний)
@Author(Prof1983 prof1983@ya.ru)
@Created(23.05.2007)
@LastMod(08.06.2012)
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
unit AiPoolObj;

interface

uses
  ABase, ABaseTypes, ACollectionUtils, AEntity, APoolObj,
  AiBaseTypes, AiIteratorObj;

type //** Источник знаний
  TAiPoolObject = class(TAPoolObject)
  protected
    //** Начальный идентификатор для этого пула (источника) фреймов
    FBase: TAId;
    //** Вместимость хранилища
    FCapacity: Int64;
  protected
      {** Возвращает базовый идентификатор
          (идентификатор с которого будет начинаться отсчет ID для фреймов) }
    function GetBase(): TAId; virtual;
      {** Возвращает вместимость хранилища }
    function GetCapacity(): Int64; virtual;
      {** Возвращает колличество записаных сущностей
          (колличество использованых идентификаторов) }
    function GetCount(): Int64; virtual;
      {** Возвращает True, если открыт }
    function GetIsOpened(): Boolean; virtual;
      {** Возвращает итератор.
          Служит для перечисления всех сущностей по порядку }
    function GetIterator(): TAiIteratorObject; virtual;
  public
      {** Return entity by index
          @return(Entity by index) }
    function GetEntityByIndex(Index: Integer): TAEntityObject; virtual;
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
    function GetEntityValueAsCollection(Id: TAId): ACollection; virtual;
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
    function IsBoolEntity(Entity: TAEntityObject): Boolean;
    //** Возвращает true, если сущность является Int
    function IsIntEntity(Entity: TAEntityObject): Boolean;
    //** Возвращает true, если сущность является Float
    function IsFloatEntity(Entity: TAEntityObject): Boolean;
    //** Возвращает true, если сущность является строкой
    function IsStringEntity(Entity: TAEntityObject): Boolean;
    //** Возвращает true, если сущность является коллекцией
    function IsCollectionEntity(Entity: TAEntityObject): Boolean;
  public
    //** Закрыть пул (источник)
    procedure Close(); virtual;
    //** Пул (источник) содержит в себе сущность
    function Contains(Id: TAId): Boolean; virtual;
    //** Заблокировать сущность
    function LockEntity(Id: TAId): Boolean; virtual;
    //** Заблокировать пул (источник)
    function LockPool(): Boolean; virtual;
    // Создать новую сущность (заререзвировать идентификатор под сущность)
    function NewEntity(EntityType: TAId): TAId; virtual;
    //** Открыть пул (источник)
    function Open(): AError; virtual;
    //** Сделать выборку сущностей по запросу
    function Select(Query: WideString): ACollection; virtual;
    //** Сделать выборку всех сущностей определенного типа
    function SelectT(TypeId: TAId): ACollection; virtual;
    //** Разблокировать сущность
    procedure UnLockEntity(Id: TAId); virtual;
  public
    function AddElement(Id, Element: TAId): Boolean;    // ToCollection
    function InsertElement(Id, Element: TAId; Index: Integer): Boolean; // To Array
    function InsertElementIterator(Iterator: TAiIteratorObject; Id, Element: TAId): Boolean; // To Collection
    function RemoteElementIterator(Iterator: TAiIteratorObject; Id: TAId): Boolean;
  public
    procedure AfterConstruction(); override;
  public
      {** Начальный идентификатор для этого пула (источника) фреймов }
    property Base: TAId read GetBase;
      {** Вместимость хранилища }
    property Capacity: Int64 read GetCapacity;
      {** Колличество записаных сущностей
          (колличество использованых идентификаторов) }
    property Count: Int64 read GetCount;
      {** Открыт }
    property IsOpened: Boolean read GetIsOpened;
      {** Итератор
          Служит для перечисления всех сущностей по порядку }
    property Iterator: TAiIteratorObject read GetIterator;
  end;

implementation

{ TAiPoolObject }

function TAiPoolObject.AddElement(Id, Element: TAId): Boolean;
begin
  Result := False;
end;

procedure TAiPoolObject.AfterConstruction();
begin
  inherited;
  FBase := 2048;
  FCapacity := 100000;
end;

procedure TAiPoolObject.Close();
begin
end;

function TAiPoolObject.Contains(Id: TAId): Boolean;
begin
  if (FCapacity > 0) then
    Result := (ID >= FBase) and (ID < FBase + FCapacity)
  else
    Result := False;
end;

function TAiPoolObject.GetBase(): TAId;
begin
  Result := FBase;
end;

function TAiPoolObject.GetCapacity(): Int64;
begin
  Result := FCapacity;
end;

function TAiPoolObject.GetCount(): Int64;
begin
  Result := 0;
end;

{function TAIPool.GetEntityByIndex(Index: Integer): IAIEntity;
begin
  Result := nil;
end;}

function TAiPoolObject.GetEntityByIndex(Index: Integer): TAEntityObject;
begin
  Result := nil;
end;

function TAiPoolObject.GetEntityType(Id: TAId): TAId;
begin
  Result := 0;
end;

function TAiPoolObject.GetEntityValueAsBool(Id: TAId): Boolean;
begin
  Result := False;
end;

function TAiPoolObject.GetEntityValueAsCollection(Id: TAId): ACollection;
begin
  Result := 0;
end;

function TAiPoolObject.GetEntityValueAsDateTime(Id: TAId): TDateTime;
begin
  Result := 0;
end;

function TAiPoolObject.GetEntityValueAsFloat(Id: TAId): Double;
begin
  Result := 0;
end;

function TAiPoolObject.GetEntityValueAsInt(Id: TAId): Integer;
begin
  Result := 0;
end;

function TAiPoolObject.GetEntityValueAsString(Id: TAId): WideString;
begin
  Result := '';
end;

function TAiPoolObject.GetEntityValueType(Id: TAId): TAiValueType;
begin
  Result := aivtEmpty;
end;

function TAiPoolObject.GetIsOpened(): Boolean;
begin
  Result := False;
end;

function TAiPoolObject.GetIterator(): TAiIteratorObject;
begin
  Result := nil;
  // ...
end;

function TAiPoolObject.InsertElement(Id, Element: TAId; Index: Integer): Boolean;
begin
  Result := False;
end;

function TAiPoolObject.InsertElementIterator(Iterator: TAiIteratorObject; Id, Element: TAId): Boolean;
begin
  Result := False;
end;

function TAiPoolObject.IsBoolEntity(Entity: TAEntityObject): Boolean;
begin
  Result := Assigned(Entity) and (Entity.EntityType = AIBoolType);
end;

function TAiPoolObject.IsCollectionEntity(Entity: TAEntityObject): Boolean;
begin
  Result := Assigned(Entity) and (Entity.EntityType = AICollectionType);
end;

function TAiPoolObject.IsFloatEntity(Entity: TAEntityObject): Boolean;
begin
  Result := Assigned(Entity) and (Entity.EntityType = AIFloatType);
end;

function TAiPoolObject.IsIntEntity(Entity: TAEntityObject): Boolean;
begin
  Result := Assigned(Entity) and (Entity.EntityType = AIIntType);
end;

function TAiPoolObject.IsStringEntity(Entity: TAEntityObject): Boolean;
begin
  Result := Assigned(Entity) and (Entity.EntityType = AIStringType);
end;

function TAiPoolObject.LockEntity(Id: TAId): Boolean;
begin
  Result := False;
end;

function TAiPoolObject.LockPool(): Boolean;
begin
  Result := False;
end;

function TAiPoolObject.NewEntity(EntityType: TAId): TAId;
begin
  Result := 0;
end;

function TAiPoolObject.Open(): AError;
begin
  Result := -1;
end;

function TAiPoolObject.RemoteElementIterator(Iterator: TAiIteratorObject; Id: TAId): Boolean;
begin
  Result := False;
end;

function TAiPoolObject.Select(Query: WideString): ACollection;
begin
  Result := 0;
end;

function TAiPoolObject.SelectT(TypeId: TAId): ACollection;
begin
  Result := ACollection_New();
end;

procedure TAiPoolObject.SetEntityValueAsBool(Id: TAId; Value: Boolean);
begin
end;

procedure TAiPoolObject.SetEntityValueAsDateTime(Id: TAId; Value: TDateTime);
begin
end;

procedure TAiPoolObject.SetEntityValueAsFloat(Id: TAId; Value: Double);
begin
end;

procedure TAiPoolObject.SetEntityValueAsInt(Id: TAId; Value: Integer);
begin
end;

procedure TAiPoolObject.SetEntityValueAsString(Id: TAId; Value: WideString);
begin
end;

procedure TAiPoolObject.UnLockEntity(Id: TAId);
begin
end;

end.
