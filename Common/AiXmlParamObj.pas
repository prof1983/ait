{**
@Abstract AiXmlParam
@Author Prof1983 <prof1983@ya.ru>
@Created 21.06.2012
@LastMod 09.08.2012
}
unit AiXmlParamObj;

interface

uses
  Classes,
  ABase, AiBase, AiFrameObj, AiSourceObj;

type
  TAiXmlParamObject = class(TAiFrameObject)
  private
    FName: String;
    FParams: array of TAiXmlParamObject;
    FParamsId: array of AId;
    FValue: String;
  public
    function AddParam(Param: TAiXmlParamObject): AError;
    function GetCountParams(): UInt32;
    function GetName(): String;
    function GetParam(Index: UInt32): TAiXmlParamObject;
    function GetValueStr: String;
    function LoadFromStrings(Value: TStrings): AError;
    function NewParam(Name, Value: String): TAiXmlParamObject;
    function SetName(Value: String): AError;
    function SetParam(Index: UInt32; Value: TAiXmlParamObject): AError;
    function SetValueStr(Value: String): AError;
  end;
  TAiXmlParam = TAiXmlParamObject;

implementation

{ TAiXmlParamObject }

function TAiXmlParamObject.AddParam(Param: TAiXmlParamObject): AError;
var
  I: Int32;
begin
  I := Length(FParams);
  SetLength(FParams, I + 1);
  SetLength(FParamsId, I + 1);
  FParams[I] := Param;
  FParamsId[I] := Param.GetId;
  Result := 0;
end;

function TAiXmlParamObject.GetCountParams(): UInt32;
begin
  Result := Length(FParams);
end;

function TAiXmlParamObject.GetName(): String;
begin
  Result := FName;
end;

function TAiXmlParamObject.GetParam(Index: UInt32): TAiXmlParamObject;
var
  Source: AiSourceObj.TAiSource2005;
begin
  Result := nil;
  if Index >= UInt32(Length(FParams)) then Exit;
  if Assigned(FParams[Index]) then begin
    Result := FParams[Index];
    Exit;
  end;
  {Загрузка из БЗ}
  if FParamsId[Index] = 0 then Exit;
  Source := TObject(GetSource) as TAiSource2005;
  if not(Assigned(Source)) then Exit;
  FParams[Index] := TAIXmlParam(Source.GetFreim(FParamsId[Index]));
  if not(Assigned(FParams[Index])) then begin
    FParams[Index] := TAIXmlParam.Create(AiSourceObject(Source), FParamsId[Index]);
  end;
  Result := FParams[Index];
end;

function TAiXmlParamObject.GetValueStr(): String;
begin
  Result := FValue;
end;

function TAiXmlParamObject.LoadFromStrings(Value: TStrings): AError;
begin
  {}
  Result := 1;
end;

function TAiXmlParamObject.NewParam(Name, Value: String): TAiXmlParamObject;
var
  I: Int32;
  Source: AiSourceObj.TAiSource2005;
begin
  Result := TAIXmlParam.Create;
  {Source := GetSource;
  if Assigned(Source) then
    Source.NewFreim(Result);}

  I := Length(FParams);
  SetLength(FParams, I + 1);
  SetLength(FParamsId, I + 1);
  FParams[I] := Result;
  FParamsId[I] := Result.GetId;
end;

function TAiXmlParamObject.SetName(Value: String): AError;
begin
  FName := Value;
  Result := 0;
end;

function TAiXmlParamObject.SetParam(Index: UInt32; Value: TAiXmlParamObject): AError;
begin
  Result := 1;
  if Index >= UInt32(Length(FParams)) then Exit;
  FParams[Index] := Value;
  FParamsId[Index] := Value.GetId;
  Result := 0;
end;

function TAiXmlParamObject.SetValueStr(Value: String): AError;
begin
  FValue := Value;
  Result := 0;
end;

end.
