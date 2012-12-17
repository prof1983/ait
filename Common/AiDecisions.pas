{**
@Author Prof1983 <prof1983@ya.ru>
@Created 24.05.2012
@LastMod 17.12.2012
}
unit AiDecisions;

interface

uses
  ABase,
  ATypes,
  AiBase, AiDependences, AiFrameObj, AiSourceObj;

type
  // Решение
  TAiDecision2006 = class(TAiFrameObject)
  private
      // Зависимости
    FDependences: TAiDependences2006;
  public
    constructor Create(Source: AiSource2005; Id: TAId);
    procedure Free(); override;
    function GetDependences(): TAiDependences2006;
    function SetDependences(Value: TAiDependences2006): AError;
  end;

  // Решения, связанные между собой
  TAiDecisions2006 = class(TAiFrameObject)
  private
    FDecisions: array of TAiDecision2006;
  public
    procedure Free(); override;
    function GetDecision(Index: UInt32): TAiDecision2006;
    function New(): TAiDecision2006;
    function AddDecision(Decision: TAiDecision2006): TAId;
  end;

implementation

{ TAiDecision2006 }

constructor TAiDecision2006.Create(Source: AiSource2005; Id: TAId);
begin
  inherited Create(Source, Id);
  FDependences := TAiDependences2006.Create();
end;

procedure TAiDecision2006.Free();
begin
  FDependences.Free();
  inherited Free();
end;

function TAiDecision2006.GetDependences(): TAiDependences2006;
begin
  Result := FDependences;
end;

function TAiDecision2006.SetDependences(Value: TAiDependences2006): AError;
begin
  FDependences := Value;
  //Result := 0;
end;

{ TAiDecisions2006 }

function TAiDecisions2006.AddDecision(Decision: TAiDecision2006): TAId;
{var
  I: UInt32;
  Source: TAI_Source;}
begin
  {Result := 0;
  Source := GetSource;
  if not(Assigned(Source)) then Exit;
  Result := Source.FreimNew(TypeDecisionId);
  if Result = 0 then Exit;
  I := Length(FDecisionsId);
  SetLength(FDecisions, I + 1);
  SetLength(FDecisionsId, I + 1);
  FDecisions[I] := Decision;
  FDecisionsId[I] := Result;}
  Result := 0;
end;

procedure TAiDecisions2006.Free();
var
  I: Int32;
begin
  for I := 0 to High(FDecisions) do
    if Assigned(FDecisions[I]) then
      FDecisions[I].Free();
  inherited Free();
end;

function TAiDecisions2006.GetDecision(Index: UInt32): TAiDecision2006;
begin
  if (Index >= UInt32(Length(FDecisions))) then
    Result := nil
  else
    Result := FDecisions[Index];
end;

function TAiDecisions2006.New(): TAiDecision2006;
begin
  Result := TAiDecision2006.Create(GetSource, 0);
  if AddDecision(Result) = 0 then
  begin
    Result.Free;
    Result := nil;
  end;
end;

end.
