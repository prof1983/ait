{**
@Abstract(Сущность - базовый класс для представления знаний)
@Author(Prof1983 prof1983@ya.ru)
@Created(11.05.2007)
@LastMod(13.06.2012)
@Version(0.5)

Эта сущность для хранения в ОЗУ в виде объекта.
Создается для использования. После использования удаляется.

Прототипы:
  aterm.ATerm
  aterm.ATermAppl
  org.framerd.FDType
  javax.swing.text.html.parser.Entity
  org.semanticweb.owl.model.OwlEntity

История версий:
0.0.2.1 - 04.07.2007
0.0.2.0 - 01.06.2007 - Полностью переделал из прототипа AiEntityImpl
}
unit AiEntityImpl;

interface

uses
  ABase, AEntityImpl, AiPoolIntf;

type
  TAiEntity = class(TProfEntity)
  protected
      //** Пул, откуда запрашиваются сущности по идентификатору
    FPool: IAIPool;
  public
    //** Возвращает идентификатор сущности
    function GetId(): TAId;
      //** Возвращает идентификатор сущности
    function GetEntityID(): TAId;
      //** Возвращает тип сущности
    function GetEntityType(): TAId;
    //** Задает тип сущности
    procedure SetEntityType(Value: TAId);
  public // Конструкторы
    constructor Create();
    constructor Create2(Pool: IAIPool; Id: TAId);
    constructor Create3(Pool: IAiPool; Id, Typ: TAId);
  public
      //** Сохранить данные в пул
    function Commit(): Boolean; virtual;
      //** Загрузить данные из пула
    function Update(): Boolean; virtual;
  public
    {**
      Идентификатор. Только для чтения.
      Идентификатор залается при создании сущности и не меняется.
      Агалоги:
        ru.narod.profsoft.common.ProfEntity.ID
        org.framerd.OID.OID
    }
    property EntityID: TAId read GetEntityID;
    {**
      Тип сущности. Номера от 0 до 1023 заререзвированы.
      Аналоги:
        aterm.ATermAppl.AFun
        org.framerd.FDType.TypeName
        ru.narod.profsoft.common.ProfEntity.EntityType
    }
    property EntityType: TAId read GetEntityType;
    //** Пул, откуда запрашиваются сущности по идентификатору
    property Pool: IAIPool read FPool write FPool;
  end;

implementation

{ TAiEntity }

function TAiEntity.Commit(): Boolean;
begin
  Result := False;
end;

constructor TAiEntity.Create();
begin
  inherited Create();
  FPool := nil;
  FId := 0;
  FEntityType := 0;
end;

constructor TAiEntity.Create2(Pool: IAiPool; Id: TAId);
begin
  inherited Create();
  FPool := Pool;
  FId := Id;
  if Assigned(FPool) then
  try
    FEntityType := FPool.GetEntityType(Id);
  except
    FEntityType := 0;
  end;
  //** Загрузить данные из пула
  Update();
end;

constructor TAiEntity.Create3(Pool: IAiPool; Id, Typ: TAId);
begin
  inherited Create();
  FPool := Pool;
  FId := Id;
  FEntityType := Typ;
end;

function TAiEntity.GetEntityId(): TAId;
begin
  Result := FId;
end;

function TAiEntity.GetEntityType(): TAId;
begin
  Result := FEntityType;
end;

function TAiEntity.GetId(): TAId;
begin
  Result := FId;
end;

procedure TAiEntity.SetEntityType(Value: TAId);
begin
  FEntityType := Value;
end;

function TAiEntity.Update(): Boolean;
begin
  Result := False;
end;

end.
