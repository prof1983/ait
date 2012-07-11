{**
@Abstract(AiInterpretator)
@Author(Prof1983 prof1983@ya.ru)
@Created(11.07.2012)
@LastMod(11.07.2012)
@Version(0.5)
}
unit AiInterpretatorObj;

interface

uses
  ABase, AXmlObj,
  AiFrameObj, AiObjectObj, AiParamsObj;

type
  TAiInterpretator20050915 = class(TAiFrameObject)
  protected
    FCode: TProfXml;         {Выполняемый код}
    FParams: TAiParams;         {Параметры}
    FParamsIn: TAiParams;       {Входные данные}
    FParamsOut: TAiParams;      {Выходные данные}
    FSystem: TAiSystem;         {Глобальный системный объект для кода}
  public
    function GetCode: TProfXml;
    function GetParams: TAiParams;
    function GetParamsIn: TAiParams;
    function GetParamsOut: TAiParams;
    function GetSystem: TAiSystem;
    function Initialize: AError; override;
    function Run: AError;
    function SetCode(Value: TProfXml): TError;
    function SetParams(Value: TAiParams): TError;
    function SetParamsIn(Value: TAiParams): TError;
    function SetParamsOut(Value: TAiParams): TError;
    function SetSystem(Value: TAiSystem): TError;
  end;

  TAiInterpretator20050830 = class(TAiInterpretator20050915)
  public
    function GetCode: TProfXml;
    function Initialize: AError; override;
    function SetCode(Value: TProfXml): TError;
  end;

  TAiInterpretator20050526 = class(TAiInterpretator20050830)
  private
    FCode: TAiXmlParamObject;         {Выполняемый код}
  public
    function GetCode: TAiXmlParamObject;
    function Initialize: AError; override;
    function SetCode(Value: TAiXmlParamObject): TError;
  end;

  TAiInterpretator20050525 = class(TAiInterpretator20050526)
  private
    FCode: AXmlObj.TProfXml;         {Выполняемый код}
  public
    function GetCode(): AXmlObj.TProfXml;
    function Initialize(): AError; override;
    function SetCode(Value: AXmlObj.TProfXml): AError;
  end;

  TAiInterpretatorObject = TAiInterpretator20050525;

implementation

{ TAiInterpretator20050525 }

function TAiInterpretator20050525.GetCode: TMyXml;
begin
  Result := FCode;
end;

function TAiInterpretator20050525.Initialize: TError;
var
  Source: TAiSource2005;
begin
  Source := TObject(GetSource) as TAiSource2005;
  if not(Assigned(FCode)) then
    FCode := TMyXml.Create;
  if not(Assigned(FParams)) then
    FParams := TAIParams.Create(AiSource2005(Source), 0);
  if not(Assigned(FParamsIn)) then
    FParamsIn := TAIParams.Create(AiSource2005(Source), 0);
  if not(Assigned(FParamsOut)) then
    FParamsOut := TAIParams.Create(AiSource2005(Source), 0);
  Result := 0;
end;

function TAiInterpretator20050525.SetCode(Value: TMyXml): TError;
begin
  FCode := Value;
  Result := 0;
end;

{ TAiInterpretator20050526 }

function TAiInterpretator20050526.GetCode: TAIXmlParam;
begin
  Result := FCode;
end;

function TAiInterpretator20050526.Initialize: TError;
var
  Source: AiSource2005;
begin
  Source := GetSource;
  if not(Assigned(FCode)) then
    FCode := TAIXmlParam.Create(Source, 0);
  if not(Assigned(FParams)) then
    FParams := TAIParams.Create(Source, 0);
  if not(Assigned(FParamsIn)) then
    FParamsIn := TAIParams.Create(Source, 0);
  if not(Assigned(FParamsOut)) then
    FParamsOut := TAIParams.Create(Source, 0);
  Result := 0;
end;

function TAiInterpretator20050526.SetCode(Value: TAIXmlParam): TError;
begin
  FCode := Value;
  Result := 0;
end;

{ TAiInterpretator20050830 }

function TAiInterpretator20050830.GetCode: TProfXml;
begin
  Result := FCode;
end;

function TAiInterpretator20050830.Initialize: TError;
var
  Source: AiSource2005;
begin
  Source := GetSource;
  if not(Assigned(FCode)) then
    FCode := TProfXml.Create;
  if not(Assigned(FParams)) then
    FParams := TAIParams.Create(Source, 0);
  if not(Assigned(FParamsIn)) then
    FParamsIn := TAIParams.Create(Source, 0);
  if not(Assigned(FParamsOut)) then
    FParamsOut := TAIParams.Create(Source, 0);
  Result := 0;
end;

function TAiInterpretator20050830.SetCode(Value: TProfXml): TError;
begin
  FCode := Value;
  Result := 0;
end;

{ TAiInterpretator20050915 }

function TAiInterpretator20050915.GetCode: TProfXml;
begin
  Result := FCode;
end;

function TAiInterpretator20050915.GetParams: TAIParams;
begin
  Result := FParams;
end;

function TAiInterpretator20050915.GetParamsIn: TAIParams;
begin
  Result := FParamsIn;
end;

function TAiInterpretator20050915.GetParamsOut: TAIParams;
begin
  Result := FParamsOut;
end;

function TAiInterpretator20050915.GetSystem: TAISystem;
begin
  Result := FSystem;
end;

function TAiInterpretator20050915.Initialize: TError;
var
  Source: AiSourceObject2005;
begin
  Source := GetSource;
  if not(Assigned(FCode)) then
    FCode := TProfXml.Create;
  if not(Assigned(FParams)) then
    FParams := TAIParams.Create(Source, 0);
  if not(Assigned(FParamsIn)) then
    FParamsIn := TAIParams.Create(Source, 0);
  if not(Assigned(FParamsOut)) then
    FParamsOut := TAIParams.Create(Source, 0);
  Result := 0;
end;

function TAiInterpretator20050915.Run: TError;
begin
  {}
  Result := 1;
end;

function TAiInterpretator20050915.SetCode(Value: TProfXml): TError;
begin
  FCode := Value;
  Result := 0;
end;

function TAiInterpretator20050915.SetParams(Value: TAIParams): TError;
begin
  FParams := Value;
  Result := 0;
end;

function TAiInterpretator20050915.SetParamsIn(Value: TAIParams): TError;
begin
  FParamsIn := Value;
  Result := 0;
end;

function TAiInterpretator20050915.SetParamsOut(Value: TAIParams): TError;
begin
  FParamsOut := Value;
  Result := 0;
end;

function TAiInterpretator20050915.SetSystem(Value: TAISystem): TError;
begin
  FSystem := Value;
  Result := 0;
end;

end.
