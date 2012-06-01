{**
@Abstract()
@Author(Prof1983 prof1983@ya.ru)
@Created(15.12.2007)
@LastMod(07.07.2011)
@Version(0.5)
}
unit KnowledgeBase;

// From Modules/KnowledgeBase/

interface

uses
  Entity, EntityPool, Module;

type
  TKnowledgeBase = class(TModule) //(TEntityPool)
  private
    FPools: array of TEntityPool;
  protected
    function GetEntityByID(ID: Int64): TEntity; //override;
    function GetEntityCount(): Int64; //override;
    function GetPoolByIndex(Index: Integer): TEntityPool;
    function GetPoolCount(): Integer;
  public
    constructor Create();
  public
    property PoolByIndex[Index: Integer]: TEntityPool read GetPoolByIndex;
    property PoolCount: Integer read GetPoolCount;
  end;

implementation

{ TKnowledgeBase }

constructor TKnowledgeBase.Create();
begin
  inherited Create();
  FLocalName := 'KnowledgeBase';
end;

function TKnowledgeBase.GetEntityByID(ID: Int64): TEntity;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to High(FPools) do
  begin
    if (FPools[i].Base >= ID) and (FPools[i].Base + FPools[i].Capacity < ID) then
    begin
      Result := FPools[i].EntityByID[ID];
      Exit;
    end;
  end;
end;

function TKnowledgeBase.GetEntityCount(): Int64;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to High(FPools) do
  begin
    Result := Result + FPools[i].EntityCount;
  end;
end;

function TKnowledgeBase.GetPoolByIndex(Index: Integer): TEntityPool;
begin
  if (Index >= 0) and (Index < Length(FPools)) then
    Result := FPools[Index]
  else
    Result := nil;
end;

function TKnowledgeBase.GetPoolCount(): Integer;
begin
  Result := Length(FPools);
end;

end.
