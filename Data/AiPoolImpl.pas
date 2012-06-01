{**
@Abstract(Источник знаний)
@Author(Prof1983 prof1983@ya.ru)
@Created(23.05.2007)
@LastMod(26.03.2012)
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
  AiBase, AiBaseTypes, AiCollection, AiCollectionImpl, AiConsts, AiEntityIntf, AiIteratorIntf, AiLogingObject, AiPoolIntf;

type //** Источник знаний
  TAiPool = class(TAiLogingObject, IAiPool) //(TInterfacedObject, IAIPool)
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
    function GetBase(): TAIID; virtual;
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
    function GetIterator(): IAIIterator; virtual;
  public
    //** Возвращает значение сущности как Boolean
    function GetEntityValueAsBool(ID: TAIID): Boolean; virtual;
    //** Возвращает значение сущности как Integer
    function GetEntityValueAsInt(ID: TAIID): Integer; virtual;
    //** Возвращает значение сущности как Float
    function GetEntityValueAsFloat(ID: TAIID): Double; virtual;
    //** Возвращает значение сущности как String
    function GetEntityValueAsString(ID: TAIID): WideString; virtual;
    //** Возвращает значение сущности как DateTime
    function GetEntityValueAsDateTime(ID: TAIID): TDateTime; virtual;
    //** Возвращает значение сущности как Collection
    function GetEntityValueAsCollection(ID: TAIID): IAICollection; virtual;
    //** Возвращает тип данных сущности
    function GetEntityValueType(ID: TAIID): TAIValueType; virtual;
    //** Возвращает тип сущности
    function GetEntityType(ID: TAIID): TAIID; virtual;
    //** Задает значение сущности как Boolean
    procedure SetEntityValueAsBool(ID: TAIID; Value: Boolean); virtual;
    //** Задает значение сущности как Integer
    procedure SetEntityValueAsInt(ID: TAIID; Value: Integer); virtual;
    //** Задает значение сущности как Float
    procedure SetEntityValueAsFloat(ID: TAIID; Value: Double); virtual;
    //** Задает значение сущности как String
    procedure SetEntityValueAsString(ID: TAIID; Value: WideString); virtual;
    //** Задает значение сущности как DateTime
    procedure SetEntityValueAsDateTime(ID: TAIID; Value: TDateTime); virtual;
  public
    //function GetEntityByIndex(Index: Integer): IAIEntity; virtual;
  public
    //** Возвращает true, если сущность является Bool
    function IsBoolEntity(Entity: IAIEntity): Boolean;
    //** Возвращает true, если сущность является Int
    function IsIntEntity(Entity: IAIEntity): Boolean;
    //** Возвращает true, если сущность является Float
    function IsFloatEntity(Entity: IAIEntity): Boolean;
    //** Возвращает true, если сущность является строкой
    function IsStringEntity(Entity: IAIEntity): Boolean;
    //** Возвращает true, если сущность является коллекцией
    function IsCollectionEntity(Entity: IAIEntity): Boolean;
  public
    //** Закрыть пул (источник)
    procedure Close(); virtual;
    //** Пул (источник) содержит в себе сущность
    function Contains(ID: TAIID): Boolean; virtual;
    //** Заблокировать сущность
    function LockEntity(ID: TAIID): Boolean; virtual;
    //** Заблокировать пул (источник)
    function LockPool(): Boolean; virtual;
    // Создать новую сущность (заререзвировать идентификатор под сущность)
    function NewEntity(EntityType: TAId): TAId; virtual;
    //** Открыть пул (источник)
    function Open(): TAIError; virtual;
    //** Сделать выборку сущностей по запросу
    function Select(Query: WideString): IAICollection; virtual;
    //** Сделать выборку всех сущностей определенного типа
    function SelectT(TypeID: TAId): IAiCollection; virtual;
    //** Разблокировать сущность
    procedure UnLockEntity(ID: TAIID); virtual;
  public
    function AddElement(ID, Element: TAIID): Boolean;    // ToCollection
    function InsertElement(ID, Element: TAIID; Index: Integer): Boolean; // To Array
    function InsertElementIterator(Iterator: IAIIterator; ID, Element: TAIID): Boolean; // To Collection
    function RemoteElementIterator(Iterator: IAIIterator; ID: TAIID): Boolean;
    //function RemoteElement(ID, Element: TAIID): Boolean; // FromCollection
  public
    procedure AfterConstruction(); override;
  public
    //** Начальный идентификатор для этого пула (источника) фреймов
    property Base: TAIID read GetBase;
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
    property Iterator: IAIIterator read GetIterator;
  end;

implementation

{ TAIPool }

function TAiPool.AddElement(ID, Element: TAIID): Boolean;
begin
  Result := False;
end;

procedure TAiPool.AfterConstruction();
begin
  inherited;
  FBase := 2048;
  FCapacity := 100000;
end;

procedure TAiPool.Close();
begin
end;

function TAiPool.Contains(ID: TAIID): Boolean;
begin
  if (FCapacity > 0) then
    Result := (ID >= FBase) and (ID < FBase + FCapacity)
  else
    Result := False;
end;

function TAiPool.GetBase(): TAIID;
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

{function TAIPool.GetEntityByIndex(Index: Integer): IAIEntity;
begin
  Result := nil;
end;}

function TAiPool.GetEntityType(ID: TAIID): TAIID;
begin
  Result := 0;
end;

function TAiPool.GetEntityValueAsBool(ID: TAIID): Boolean;
begin
  Result := False;
end;

function TAiPool.GetEntityValueAsCollection(ID: TAIID): IAICollection;
begin
  Result := nil;
end;

function TAiPool.GetEntityValueAsDateTime(ID: TAIID): TDateTime;
begin
  Result := 0;
end;

function TAiPool.GetEntityValueAsFloat(ID: TAIID): Double;
begin
  Result := 0;
end;

function TAiPool.GetEntityValueAsInt(ID: TAIID): Integer;
begin
  Result := 0;
end;

function TAiPool.GetEntityValueAsString(ID: TAIID): WideString;
begin
  Result := '';
end;

function TAiPool.GetEntityValueType(ID: TAIID): TAIValueType;
begin
  Result := aivtEmpty;
end;

function TAiPool.GetIsOpened(): Boolean;
begin
  Result := False;
end;

function TAiPool.GetIterator(): IAIIterator;
begin
  Result := nil;
  // ...
end;

function TAiPool.InsertElement(ID, Element: TAIID; Index: Integer): Boolean;
begin
  Result := False;
end;

function TAiPool.InsertElementIterator(Iterator: IAIIterator; ID, Element: TAIID): Boolean;
begin
  Result := False;
end;

function TAiPool.IsBoolEntity(Entity: IAIEntity): Boolean;
begin
  Result := Assigned(Entity) and (Entity.EntityType = AIBoolType);
end;

function TAiPool.IsCollectionEntity(Entity: IAIEntity): Boolean;
begin
  Result := Assigned(Entity) and (Entity.EntityType = AICollectionType);
end;

function TAiPool.IsFloatEntity(Entity: IAIEntity): Boolean;
begin
  Result := Assigned(Entity) and (Entity.EntityType = AIFloatType);
end;

function TAiPool.IsIntEntity(Entity: IAIEntity): Boolean;
begin
  Result := Assigned(Entity) and (Entity.EntityType = AIIntType);
end;

function TAiPool.IsStringEntity(Entity: IAIEntity): Boolean;
begin
  Result := Assigned(Entity) and (Entity.EntityType = AIStringType);
end;

function TAiPool.LockEntity(ID: TAIID): Boolean;
begin
  Result := False;
end;

function TAiPool.LockPool(): Boolean;
begin
  Result := False;
end;

function TAiPool.NewEntity(EntityType: TAId): TAId;
begin
  Result := 0;
end;

function TAiPool.Open(): TAIError;
begin
  Result := -1;
end;

{function TAIPool.RemoteElement(ID, Element: TAIID): Boolean;
begin
  Result := False;
end;}

function TAiPool.RemoteElementIterator(Iterator: IAIIterator; ID: TAIID): Boolean;
begin
  Result := False;
end;

function TAiPool.Select(Query: WideString): IAICollection;
begin
  Result := nil;
end;

function TAiPool.SelectT(TypeId: TAId): IAiCollection;
begin
  Result := TAiCollection.Create();
  // ...
end;

procedure TAiPool.SetEntityValueAsBool(ID: TAIID; Value: Boolean);
begin
end;

procedure TAiPool.SetEntityValueAsDateTime(ID: TAIID; Value: TDateTime);
begin
end;

procedure TAiPool.SetEntityValueAsFloat(ID: TAIID; Value: Double);
begin
end;

procedure TAiPool.SetEntityValueAsInt(ID: TAIID; Value: Integer);
begin
end;

procedure TAiPool.SetEntityValueAsString(ID: TAIID; Value: WideString);
begin
end;

procedure TAiPool.UnLockEntity(ID: TAIID);
begin
end;

end.
