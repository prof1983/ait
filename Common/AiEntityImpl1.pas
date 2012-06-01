{**
@Abstract(Сущность - базовый класс для представления знаний)
@Author(Prof1983 prof1983@ya.ru)
@Created(11.05.2007)
@LastMod(25.04.2012)
@Version(0.5)

Эта сущность для хранения в ОЗУ в виде объекта.
Создается для использования. После использования удаляется.

Прототипы:
  ru.narod.profsoft.common.ProfEntity
  ru.narod.profsorf.ai.common.aiFrame
  aterm.ATerm
  aterm.ATermAppl
  org.framerd.FDType
  javax.swing.text.html.parser.Entity
  org.semanticweb.owl.model.OwlEntity
}
unit AiEntityImpl1;

interface

uses
  AiBase, AiBaseTypes, AiEntityIntf, AiEntitiesImpl, AiPoolIntf;

type
  //** @abstract(Сущность - базовый класс для представления знаний)
  TAIWSEntity = class(TInterfacedObject, IAIWSEntity)
  protected
    //** Объект доступа к вложенным сущностям
    FEntities: IAIWSEntities;
    //** Тип сущности
    FEntityType: TAId;
    //** Идентификатор
    FID: TAId;
    //** Имя
    FName: WideString;
    //** Пул, откуда запрашиваются сущности по идентификатору
    FPool: IAIWSPool;
    FValue: Variant;
  protected
    //** Возвращает объект работы с вложеными сущностями
    function GetEntities(): IAIWSEntities;
    //** Возвращает тип сущности
    function GetEntityType(): TAId;
    //** Возвращает идентификатор сущности
    function GetID(): Int64;
    //** Возвращает имя
    function GetName(): WideString;
    //** Задать тип сущности
    procedure SetEntityType(Value: TAId);
    //** Задать имя
    procedure SetName(Value: WideString);
  public
    //** Созранить в пул
    function Commit(): Boolean; virtual;
    {
    Конструкторы без указанием пула откуда загружать и куда сохранять данные.
    Методы commit и update не будут функционировать пока не задан Pool.
    Загружать и сохранять данные сущности можно используя функции
    TAIWSPool.CommitEntity(e) и TAIWSPool.UpdateEntity(e)
    }
    constructor Create(ID: TAId); overload;
    constructor Create(ID, AType: TAId); overload;
    constructor Create(ID: TAId; Name: WideString); overload;
    constructor Create(ID: TAId; Name: WideString; AType: TAId); overload;
    // Конструкторы с указанием пула откуда загружать и куда сохранять данные
    constructor Create(Pool: IAIWSPool; ID: TAId); overload;
    constructor Create(Pool: IAIWSPool; ID, AType: TAId); overload;
    constructor Create(Pool: IAIWSPool; ID: TAId; Name: WideString); overload;
    constructor Create(Pool: IAIWSPool; ID: TAId; Name: WideString; AType: TAId); overload;
    //** Загрузить данные из пула
    function Update(): Boolean;
  public
    //** Объект доступа к вложенным сущностям
    property Entities: IAIWSEntities read GetEntities;
    //** Тип сущности
    property EntityType: TAId read GetEntityType write SetEntityType;
    //** Идентификатор
    property ID: Int64 read GetId;
    //** Имя
    property Name: WideString read GetName write SetName;
    //** Пул, откуда запрашиваются сущности по идентификатору
    property Pool: IAIWSPool read FPool write FPool;
    //** Значение сущности
    property Value: Variant read FValue write FValue;
  end;

type
  {**
  @abstract(Сущность - базовый класс для представления знаний с дополнительными функциями)
  Для работы с вложеными сущностями создает объект класса TAIWSEntitySet
  (у ложеных сущностей могут быть не заданы идентификаторы)
  }
  TAIWSEntityEx = class(TAIWSEntity, IAIWSEntityEx)
  private
    FNumber: Integer;
    procedure CheckEntities();
  protected
    {**
    Возвращает номер сущности.
    Номер задается только для вложеных сущностей.
    }
    function GetNumber(): Integer;
  public
    {**
      Добавить сущность к этой сущности.
      Возвращает True, если добавлено успешно.
    }
    function AddEntity(ID: TAId): WordBool; overload;
    {**
      Добавить сущность к этой сущности.
      Возвращает True, если добавлено успешно.
    }
    function AddEntity(Entity: IAIWSEntity): WordBool; overload;
    {**
      Создать новую сущность.
      Возвращает идентификатор новой сущности или 0 в случае ошибки.
    }
    function NewEntity(): TAId; overload;
    {**
      Создать новую сущность с указанием имени сущности.
      Возвращает идентификатор новой сущности или 0 в случае ошибки.
    }
    function NewEntity(Name: WideString): TAId; overload;
    {**
      Создать новую сущность с указанием типа сущности.
      Возвращает идентификатор новой сущности или 0 в случае ошибки.
    }
    function NewEntity(AType: TAId): TAId; overload;
    {**
      Создать новую сущность с указанием имени и типа сущности.
      Возвращает идентификатор новой сущности или 0 в случае ошибки.
    }
    function NewEntity(Name: WideString; AType: TAId): TAId; overload;
    {**
      Создать новую сущность.
      Возвращает объект новой сущности или nil в случае ошибки.
    }
    function NewEntityA(): IAIWSEntity; overload;
    {**
      Создать новую сущность с указанием имени сущности.
      Возвращает объект новой сущности или nil в случае ошибки.
    }
    function NewEntityA(Name: WideString): IAIWSEntity; overload;
    {**
      Создать новую сущность с указанием типа сущности.
      Возвращает объект новой сущности или nil в случае ошибки.
    }
    function NewEntityA(AType: TAId): IAIWSEntity; overload;
    {**
      Создать новую сущность с указанием имени и типа сущности.
      Возвращает объект новой сущности или nil в случае ошибки.
    }
    function NewEntityA(Name: WideString; AType: TAId): IAIWSEntity; overload;
  public
    //** Номер сущности (в списке)
    property Number: Integer read GetNumber;
  end;

implementation

{ TAIWSEntity }

constructor TAIWSEntity.Create(ID: TAId);
begin
  inherited Create();
  FID := ID;
end;

constructor TAIWSEntity.Create(Pool: IAIWSPool; ID, AType: TAId);
begin
  inherited Create();
  FPool := Pool;
  FID := ID;
  FEntityType := AType;
end;

constructor TAIWSEntity.Create(Pool: IAIWSPool; ID: TAId; Name: WideString);
begin
  inherited Create();
  FPool := Pool;
  FID := ID;
  FName := Name;
end;

function TAIWSEntity.Commit(): Boolean;
begin
  Result := Assigned(FPool);
  if not(Result) then Exit;
  // Сохранить текущую сущность в БЗ
  Result := FPool.CommitEntity(Self);
end;

constructor TAIWSEntity.Create(Pool: IAIWSPool; ID: TAId; Name: WideString; AType: TAId);
begin
  inherited Create();
  FPool := Pool;
  FID := ID;
  FName := Name;
  FEntityType := AType;
end;

constructor TAIWSEntity.Create(ID: TAId; Name: WideString);
begin
  inherited Create();
  FID := ID;
  FName := Name;
end;

constructor TAIWSEntity.Create(ID, AType: TAId);
begin
  inherited Create();
  FID := ID;
  FEntityType := AType;
end;

constructor TAIWSEntity.Create(Pool: IAIWSPool; ID: TAId);
begin
  inherited Create();
  FPool := Pool;
  FID := ID;
end;

constructor TAIWSEntity.Create(ID: TAId; Name: WideString; AType: TAId);
begin
  inherited Create();
  FID := ID;
  FName := Name;
  FEntityType := AType;
end;

function TAIWSEntity.GetEntities(): IAIWSEntities;
begin
  Result := FEntities;
end;

function TAIWSEntity.GetEntityType(): TAId;
begin
  Result := FEntityType;
end;

function TAIWSEntity.GetID(): Int64;
begin
  Result := FID;
end;

function TAIWSEntity.GetName(): WideString;
begin
  Result := FName;
end;

procedure TAIWSEntity.SetEntityType(Value: TAId);
begin
  FEntityType := Value;
end;

procedure TAIWSEntity.SetName(Value: WideString);
begin
  FName := Value;
end;

function TAIWSEntity.Update(): Boolean;
begin
  Result := Assigned(FPool);
  if not(Result) then Exit;
  Result := FPool.UpdateEntity(Self);
end;

{ TAIWSEntityEx }

function TAIWSEntityEx.AddEntity(ID: TAId): WordBool;
begin
  CheckEntities();
  Result := FEntities.Add(ID);
end;

function TAIWSEntityEx.AddEntity(Entity: IAIWSEntity): WordBool;
begin
  CheckEntities();
  Result := FEntities.Add(Entity);
end;

procedure TAIWSEntityEx.CheckEntities();
begin
  if not(Assigned(FEntities)) then
  begin
    FEntities := TAIWSEntities.Create(FPool);
    //FEntities := TAIWSEntitySet.Create();
    //TAIWSEntitySet(FEntities).Pool := FPool;
  end;
end;

function TAIWSEntityEx.GetNumber(): Integer;
begin
  Result := FNumber;
end;

function TAIWSEntityEx.NewEntity(Name: WideString): TAId;
var
  e: TAIWSEntityEx;
  id: TAId;
begin
  Result := 0;
  CheckEntities();

  id := FPool.NewEntity();
  if (id <= 0) then Exit;

  e := TAIWSEntityEx.Create(FPool, id, Name);

  if FEntities.Add(e) then
    Result := id;
end;

function TAIWSEntityEx.NewEntity(): TAId;
var
  e: TAIWSEntityEx;
  id: TAId;
begin
  Result := 0;
  CheckEntities();
  id := FPool.NewEntity();
  if (id <= 0) then Exit;

  e := TAIWSEntityEx.Create(FPool, id);

  if FEntities.Add(e) then
    Result := id;
end;

function TAIWSEntityEx.NewEntity(Name: WideString; AType: TAId): TAId;
var
  e: TAIWSEntityEx;
  id: TAId;
begin
  Result := 0;
  CheckEntities();
  id := FPool.NewEntity();
  if (id <= 0) then Exit;

  e := TAIWSEntityEx.Create(FPool, id, Name, AType);

  if FEntities.Add(e) then
    Result := id;
end;

function TAIWSEntityEx.NewEntity(AType: TAId): TAId;
var
  e: TAIWSEntityEx;
  id: TAId;
begin
  Result := 0;
  CheckEntities();
  id := FPool.NewEntity();
  if (id <= 0) then Exit;

  e := TAIWSEntityEx.Create(FPool, id, AType);

  if FEntities.Add(e) then
    Result := id;
end;

function TAIWSEntityEx.NewEntityA(Name: WideString): IAIWSEntity;
var
  e: TAIWSEntityEx;
  id: TAId;
begin
  Result := nil;
  CheckEntities();
  id := FPool.NewEntity();
  if (id <= 0) then Exit;

  e := TAIWSEntityEx.Create(FPool, id, Name);

  if FEntities.Add(e) then
    Result := e;
end;

function TAIWSEntityEx.NewEntityA(): IAIWSEntity;
var
  e: TAIWSEntityEx;
  id: TAId;
begin
  Result := nil;
  CheckEntities();
  id := FPool.NewEntity();
  if (id <= 0) then Exit;

  e := TAIWSEntityEx.Create(FPool, id);

  if FEntities.Add(e) then
    Result := e;
end;

function TAIWSEntityEx.NewEntityA(Name: WideString; AType: TAId): IAIWSEntity;
var
  e: TAIWSEntityEx;
  id: TAId;
begin
  Result := nil;
  CheckEntities();
  id := FPool.NewEntity();
  if (id <= 0) then Exit;

  e := TAIWSEntityEx.Create(FPool, id, Name, AType);

  if FEntities.Add(e) then
    Result := e;
end;

function TAIWSEntityEx.NewEntityA(AType: TAId): IAIWSEntity;
var
  e: TAIWSEntityEx;
  id: TAId;
begin
  Result := nil;
  CheckEntities();
  id := FPool.NewEntity();
  if (id <= 0) then Exit;

  e := TAIWSEntityEx.Create(FPool, id, AType);

  if FEntities.Add(e) then
    Result := e;
end;

end.
