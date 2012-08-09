{**
@Abstract AiInterpretator
@Author Prof1983 <prof1983@ya.ru>
@Created 11.07.2012
@LastMod 09.08.2012
}
unit AiInterpretatorObj;

interface

uses
  Classes,
  ABase, AXmlObj,
  AiBase, AiFrameObj, AiObjectObj, AiParamsObj, AiXmlParamObj;

type
  TAiInterpretatorObject = class(TAiFrameObject)
  protected
      //** Выполняемый код
    FCode: TProfXml;
      //** Выполняемый код
    FCode1: TAiXmlParamObject;
      //** Параметры
    FParams: TAiParams;
      //** Входные данные
    FParamsIn: TAiParams;
      //** Выходные данные
    FParamsOut: TAiParams;
      //** Глобальный системный объект для кода
    FSystem: TAiSystem;
  public
    function GetCode(): TProfXml;
    function GetCode1(): TAiXmlParamObject;
    function GetParams(): TAiParams;
    function GetParamsIn(): TAiParams;
    function GetParamsOut(): TAiParams;
    function GetSystem(): TAiSystem;
    function Initialize(): AError; override;
    function Run(): AError;
    function SetCode(Value: TProfXml): AError;
    function SetCode1(Value: TAiXmlParamObject): AError;
    function SetParams(Value: TAiParams): AError;
    function SetParamsIn(Value: TAiParams): AError;
    function SetParamsOut(Value: TAiParams): AError;
    function SetSystem(Value: TAiSystem): AError;
  end;

function AiInterpretator_LoadFromStrings(Interpretator: TAiInterpretatorObject;
    Strings: TStrings): AError;

implementation

function AiInterpretator_LoadFromStrings(Interpretator: TAiInterpretatorObject;
    Strings: TStrings): AError;
begin
  Interpretator.FCode1.LoadFromStrings(Strings);
  Result := 0;
end;

{ TAiInterpretatorObject }

function TAiInterpretatorObject.GetCode(): TProfXml;
begin
  Result := FCode;
end;

function TAiInterpretatorObject.GetCode1(): TAiXmlParam;
begin
  Result := FCode1;
end;

function TAiInterpretatorObject.GetParams(): TAiParams;
begin
  Result := FParams;
end;

function TAiInterpretatorObject.GetParamsIn(): TAiParams;
begin
  Result := FParamsIn;
end;

function TAiInterpretatorObject.GetParamsOut(): TAiParams;
begin
  Result := FParamsOut;
end;

function TAiInterpretatorObject.GetSystem(): TAiSystem;
begin
  Result := FSystem;
end;

function TAiInterpretatorObject.Initialize(): AError;
var
  Source: AiSourceObject;
begin
  Source := GetSource;
  if not(Assigned(FCode)) then
    FCode := TProfXml.Create;
  if not(Assigned(FCode1)) then
    FCode1 := TAiXmlParam.Create(Source, 0);
  if not(Assigned(FParams)) then
    FParams := TAiParams.Create(Source, 0);
  if not(Assigned(FParamsIn)) then
    FParamsIn := TAiParams.Create(Source, 0);
  if not(Assigned(FParamsOut)) then
    FParamsOut := TAiParams.Create(Source, 0);
  Result := 0;
end;

function TAiInterpretatorObject.Run(): AError;
begin
  {}
  Result := 1;
end;

function TAiInterpretatorObject.SetCode(Value: TProfXml): AError;
begin
  FCode := Value;
  Result := 0;
end;

function TAiInterpretatorObject.SetCode1(Value: TAiXmlParam): AError;
begin
  FCode1 := Value;
  Result := 0;
end;

function TAiInterpretatorObject.SetParams(Value: TAiParams): AError;
begin
  FParams := Value;
  Result := 0;
end;

function TAiInterpretatorObject.SetParamsIn(Value: TAiParams): AError;
begin
  FParamsIn := Value;
  Result := 0;
end;

function TAiInterpretatorObject.SetParamsOut(Value: TAiParams): AError;
begin
  FParamsOut := Value;
  Result := 0;
end;

function TAiInterpretatorObject.SetSystem(Value: TAiSystem): AError;
begin
  FSystem := Value;
  Result := 0;
end;

end.
