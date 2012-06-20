{**
@Abstract(Именованая сущность)
@Author(Prof1983 prof1983@ya.ru)
@Created(23.05.2007)
@LastMod(20.06.2012)
@Version(0.5)
}
unit AiNamedEntity;

interface

uses
  AEntityIntf,
  AiConsts, AiEntityImpl;

type
  //IAINamedEntity = IANamedEntity;

  //** Именованая сущность
  TAINamedEntity = class(TAIEntity, IANamedEntity)
  private
    FName: WideString;
  public
    function GetName(): WideString;
    procedure SetName(Value: WideString);
  public
    procedure AfterConstruction(); override;
  public
    property Name: WideString read GetName write SetName;
  end;

implementation

{ TAINamedEntity }

procedure TAINamedEntity.AfterConstruction();
begin
  inherited;
  FEntityType := AINamedEntityType;
end;

function TAINamedEntity.GetName(): WideString;
begin
  Result := FName;
end;

procedure TAINamedEntity.SetName(Value: WideString);
begin
  FName := Value;
end;

end.
