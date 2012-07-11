{**
@Abstract(AiParams)
@Author(Prof1983 prof1983@ya.ru)
@Created(11.07.2012)
@LastMod(11.07.2012)
@Version(0.5)
}
unit AiParamsObj;

interface

uses
  ABase, AiFrameObj, AiParamObj;

type
    //** Праметры для интерпретатора кода
  TAiParams = class(TAiFrameObject)
  private
    FParams: array of TAiParam;
  public
    function AddParam(Param: TAiParam): Int32;
    function GetCountParams: UInt32;
    function GetParam(Index: UInt32): TAiParam;
    function SetParam(Index: UInt32; Param: TAiParam): AError;
  end;

implementation

{ TAiParams }

function TAiParams.AddParam(Param: TAIParam): Int32;
begin
  Result := Length(FParams);
  SetLength(FParams, Result + 1);
  FParams[Result] := Param;
end;

function TAiParams.GetCountParams: UInt32;
begin
  Result := Length(FParams);
end;

function TAiParams.GetParam(Index: UInt32): TAIParam;
begin
  if Index >= UInt32(Length(FParams)) then
    Result := nil
  else
    Result := FParams[Index];
end;

function TAiParams.SetParam(Index: UInt32; Param: TAIParam): AError;
begin
  if Index >= UInt32(Length(FParams)) then
  begin
    Result := 1;
    Exit;
  end;
  FParams[Index] := Param;
  Result := 0;
end;

end.
