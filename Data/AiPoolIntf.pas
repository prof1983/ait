{**
@Abstract(Источник знаний)
@Author(Prof1983 prof1983@ya.ru)
@Created(02.01.2006)
@LastMod(25.04.2012)
@Version(0.5)

Prototype: org.framerd.Pool

История версий:
0.0.2.1 - 04.07.2007
0.0.2.0 - 01.06.2007 - Добавил GetIterator(), Iterator
0.0.1.2 - Добавил методы Select() и SelectT()
0.0.1.3 - Добавил методы IsBoolEntity, IsIntEntity, IsFloatEntity, IsStringEntity, IsCollectionEntity
}
unit AiPoolIntf;

interface

uses
  AiBase, AiBaseTypes, AiCollection, AiEntityIntf, AiIteratorIntf;

type
  {**
    @abstract(Источник знаний)
    UML соответствие: "Коллекция объектов [ Identity Map ]" http://ooad.asf.ru/Pattern.aspx?IdKat=7&IdPat=9
  }
  IAiPool = interface
    {**
      Возвращает базовый идентификатор
      (идентификатор с которого будет начинаться отсчет ID для фреймов)
    }
    function GetBase(): TAId;
      //** Возвращает вместимость хранилища
    function GetCapacity(): Int64;
    {**
      Возвращает колличество записаных сущностей
      (колличество использованых идентификаторов)
    }
    function GetCount(): Int64;

    {** Возвращает значение сущности как Boolean }
    function GetEntityValueAsBool(Id: TAId): Boolean;
    {** Возвращает значение сущности как Integer }
    function GetEntityValueAsInt(Id: TAId): Integer;
    {** Возвращает значение сущности как Float }
    function GetEntityValueAsFloat(Id: TAId): Double;
    {** Возвращает значение сущности как String }
    function GetEntityValueAsString(Id: TAId): WideString;
    {** Возвращает значение сущности как DateTime }
    function GetEntityValueAsDateTime(Id: TAId): TDateTime;
    {** Возвращает значение сущности как Collection }
    function GetEntityValueAsCollection(Id: TAId): IAiCollection;
    ////function GetEntityValueAsArray(): TAiCollection;
    //function GetEntityValueAsList(): TAiCollection;
    //function GetEntityValueAsSet(): TAiCollection;
    //function GetEntityValueAsMap(): TAiCollection;
    //function GetEntityValueAsStream(): IAiStream;

    {** Возвращает тип данных сущности }
    function GetEntityValueType(Id: TAId): TAiValueType;
    {** Возвращает тип сущности }
    function GetEntityType(Id: TAId): TAId;
    {** Возвращает True, если открыт }
    function GetIsOpened(): Boolean;
    {**
      Возвращает итератор.
      Служит для перечисления всех сущностей по порядку
    }
    function GetIterator(): IAiIterator;

    {** Задать значение сущности как Boolean }
    procedure SetEntityValueAsBool(Id: TAId; Value: Boolean);
    {** Задать значение сущности как Integer }
    procedure SetEntityValueAsInt(Id: TAId; Value: Integer);
    {** Задать значение сущности как Float }
    procedure SetEntityValueAsFloat(Id: TAId; Value: Double);
    {** Задать значение сущности как String }
    procedure SetEntityValueAsString(Id: TAId; Value: WideString);
    {** Задать значение сущности как DateTime }
    procedure SetEntityValueAsDateTime(Id: TAId; Value: TDateTime);

    // -------------------------------------------------------------------------

    //** Возвращает true, если сущность является Bool
    function IsBoolEntity(Entity: IAiEntity): Boolean;
    //** Возвращает true, если сущность является Int
    function IsIntEntity(Entity: IAiEntity): Boolean;
    //** Возвращает true, если сущность является Float
    function IsFloatEntity(Entity: IAiEntity): Boolean;
    //** Возвращает true, если сущность является строкой
    function IsStringEntity(Entity: IAiEntity): Boolean;
    //** Возвращает true, если сущность является коллекцией
    function IsCollectionEntity(Entity: IAiEntity): Boolean;

    // -------------------------------------------------------------------------

    // Добавить новую сущность. Задает идентификатор для сущности
    //function AddEntity(Entity: IAIEntity): TAIID;
    //** Закрыть пул (источник)
    procedure Close();
    //** Сохранить все
    //procedure Commit();
    // Сохранить сущность в пул
    //function CommitEntity(Entity: IAIEntity): Boolean;
    //** Пул (источник) содержит в себе сущность
    function Contains(Id: TAId): Boolean;
    //** Заблокировать сущность
    function LockEntity(Id: TAId): Boolean;
    //** Заблокировать пул (источник)
    function LockPool(): Boolean;
    //** Пометить как измененый
    //procedure MarkModified(x: TAId);
    // Создать новую сущность (заререзвировать идентификатор под сущность)
    function NewEntity(EntityType: TAId): TAId;
    //** Открыть пул (источник)
    function Open(): TAiError;

    //** Разблокировать сущность
    procedure UnLockEntity(Id: TAId);
    // Обновить данные сущности из пула
    //function UpdateEntity(Entity: TAIEntity): Boolean;

    //** Сделать выборку сущностей по запросу
    function Select(Query: WideString): IAiCollection;
    //** Сделать выборку всех сущностей определенного типа
    function SelectT(TypeId: TAId): IAiCollection;

    // -------------------------------------------------------------------------

    function AddElement(Id, Element: TAId): Boolean; // ToCollection, ToArray ...
    function InsertElement(Id, Element: TAId; Index: Integer): Boolean; // To Array
//    function Iterator_Insert(Iterator: IAIIterator; ID, Element: TAIID): Boolean; // To Collection
//    function Iterator_Remote(Iterator: IAIIterator; ID: TAIID): Boolean;
//    function Iterator_Next(Iterator: IAIIterator): Boolean;
//    function List_Remote(ID: TAIID; Index: Integer): Boolean;
//    function List_Insert(ID, Element: TAIID; Index: Integer): Boolean;
//    function Set_Remote(ID, Element: TAIID): Boolean;

    //** Начальный идентификатор для этого пула (источника) фреймов
    property Base: TAId read GetBase;
    //** Вместимость хранилища
    property Capacity: Int64 read GetCapacity;
    {**
    Колличество записаных сущностей
    (колличество использованых идентификаторов)
    }
    property Count: Int64 read GetCount;
    //** Сущность по идентификатору
    //property EntityById[Id: TAId]: IAiEntity read GetEntityById;
    //** Открыт
    property IsOpened: Boolean read GetIsOpened;
    {**
    Итератор
    Служит для перечисления всех сущностей по порядку
    }
    property Iterator: IAiIterator read GetIterator;
  end;

type
  {**
  @abstract(Источник знаний)
  UML соответствие: "Коллекция объектов [ Identity Map ]" http://ooad.asf.ru/Pattern.aspx?IdKat=7&IdPat=9
  }
  IAIWSPool = interface //(IAIFrame)
    //** Возвращает базовый идентификатор (идентификатор с которого будет начинаться отсчет ID для фреймов)
    function GetBase(): TAId;
    //** Возвращает вместимость хранилища
    function GetCapacity(): Int64;
    //** Возвращает сущность по идентификатору
    function GetEntityByID(ID: TAId): IAIWSEntity;
    //** Возвращает True, если открыт
    function GetIsOpened(): Boolean;

    //** Закрыть пул (источник)
    procedure Close();
    //** Сохранить все
    procedure Commit();
    //** Созранить сущность в пул
    function CommitEntity(Entity: IAIWSEntity): Boolean;
    //** Пул (источник) содержит в себе сущность
    function Contains(ID: TAId): Boolean;
    //** Заблокировать сущность
    function LockEntity(x: TAId): Boolean;
    //** Заблокировать сущность
    function LockEntityA(x: IAIWSEntity): Boolean;
    //** Заблокировать пул (источник)
    function LockPool(): Boolean;
    //** Пометить как измененый
    procedure MarkModified(x: TAId);
    //** Пометить как измененый
    procedure MarkModifiedA(x: IAIWSEntity);
    //** Создать новую сущность
    function NewEntity(): TAId;
    //** Создать новую сущность
    function NewEntityA(): IAIWSEntity;
    //** Открыть пул (источник)
    function Open(): TAiError;
    //** Выбрать все сущности определенного типа
    function Select(TypeID: TAId): IAIWSEntities;
    //** Загрузить все данные из пула
    procedure Update();
    //** Загрузить данные сущности из пула
    function UpdateEntity(Entity: IAIWSEntity): Boolean;

    //** Начальный идентификатор для этого пула (источника) фреймов
    property Base: TAId read GetBase;
    //** Вместимость хранилища
    property Capacity: Int64 read GetCapacity;
    //** Сущность по идентификатору
    property EntityByID[ID: TAId]: IAIWSEntity read GetEntityByID;
    //** Открыт
    property IsOpened: Boolean read GetIsOpened;
  end;

implementation

end.
