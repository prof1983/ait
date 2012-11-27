{**
@Abstract Сущность - базовый класс для представления знаний
@Author Prof1983 <prof1983@ya.ru>
@Created 11.05.2007
@LastMod 27.11.2012

Эта сущность для хранения в ОЗУ в виде объекта.
Создается для использования. После использования удаляется.

Prototypes:
  aterm.ATerm
  aterm.ATermAppl
  org.framerd.FDType
  javax.swing.text.html.parser.Entity
  org.semanticweb.owl.model.OwlEntity
}
unit AiEntityImpl;

interface

uses
  ABase, AEntityImpl, AiPoolIntf;

type
  TAiEntity = class(TANamedEntity)
  protected
      //** Пул, откуда запрашиваются сущности по идентификатору
    FPool: IAiPool;
  public // Конструкторы
    constructor Create();
    constructor Create2(Pool: IAIPool; Id: TAId);
    constructor Create3(Pool: IAiPool; Id, Typ: TAId);
  public
    function GetPool(): IAiPool;
      //** Сохранить данные в пул
    function Commit(): Boolean; virtual;
      //** Загрузить данные из пула
    function Update(): Boolean; virtual;
  public
    //** Пул, откуда запрашиваются сущности по идентификатору
    property Pool: IAiPool read FPool write FPool;
  end;

implementation

{ TAiEntity }

function TAiEntity.Commit(): Boolean;
begin
  if not(Assigned(FPool)) then
  begin
    Result := False;
    Exit;
  end;
  // Сохранить текущую сущность в БЗ
  Result := (FPool.CommitEntity(Self) >= 0);
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

function TAiEntity.GetPool(): IAiPool;
begin
  Result := FPool;
end;

function TAiEntity.Update(): Boolean;
begin
  if not(Assigned(FPool)) then
  begin
    Result := False;
    Exit;
  end;
  Result := (FPool.UpdateEntity(Self) >= 0);
end;

end.
