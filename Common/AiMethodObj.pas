{**
@Abstract(AiMethod)
@Author(Prof1983 prof1983@ya.ru)
@Created(17.06.2007)
@LastMod(07.06.2012)
@Version(0.5)
}
unit AiMethodObj;

interface

uses
  ABase, AiBase, AiBaseTypes, AiDataObj, AiFrameObj, AiTypes;

type // Метод
  TAiMethod = class
  private
    //** Выполняемый код метода
    FCode: WideString;
    //** Имя метода
    FName: WideString;
    //** Тип возращаемого результата
    FResultType: TAiValueType;
  public
    //** Выполняемый код метода
    property Code: WideString read FCode write FCode;
    //** Имя метода
    property Name: WideString read FName write FName;
    //** Тип возращаемого результата
    property ResultType: TAiValueType read FResultType write FResultType;
  end;

  TAiMethod2006 = class(TAiFrameObject)
  private
    FBody: TAId;
    FInput: TAId;
    FOutput: TAId;
  public
    constructor Create(Source: AiSourceObject2005; Id: TAId);
    function Load(): AError; override;
    function Save(): AError; override;
  public
    property Body: TAId read FBody write FBody;
    property Input: TAId read FInput write FInput;
    property Output: TAId read FOutput write FOutput;
  end;

  TAiMethod20050915 = class(TAiMethod2006)
  private
    FBody: TAId;
    FInput: TAId;
    FOutput: TAId;
  public
    constructor Create(Source: AiSourceObject2005; Id: TAId);
    function Load(): AError; override;
    function Save(): AError; override;
  public
    property Body: TAId read FBody write FBody;
    property Input: TAId read FInput write FInput;
    property Output: TAId read FOutput write FOutput;
  end;

  TAiMethod20050830 = class(TAiMethod20050915)
  private
    FBody: TAId;
    FInput: TAId;
    FOutput: TAId;
  public
    constructor Create(Source: AiSourceObject2005; Id: TAId);
    function Load(): AError; override;
    function Save(): AError; override;
  public
    property Body: TAId read FBody write FBody;
    property Input: TAId read FInput write FInput;
    property Output: TAId read FOutput write FOutput;
  end;

  TAiMethod20050526 = class(TAiMethod20050830)
  public
    function Run(): AError;
  end;

  TAiMethod20050525 = class(TAiMethod20050526)
  private
    FBody: TAId;
    FInput: TAId;
    FOutput: TAId;
  public
    constructor Create(Source: AiSource2005; Id: TAId);
    function Load(): AError; override;
    function Save(): AError; override;
  public
    property Body: TAId read FBody write FBody;
    property Input: TAId read FInput write FInput;
    property Output: TAId read FOutput write FOutput;
  end;

  // From AilMethod.pas
  {TAilMethod = class
  public
    Name: WideString;
    //Domain - сущность (класс или индивид) к которому применим метод
    //Code: TAilCode; - выполняемый код метода
  end;}

implementation

{ TAiMethod20050525 }

constructor TAiMethod20050525.Create(Source: AiSourceObject2005; Id: TAId);
begin
  inherited Create(Source, Id);
  {Prototype := frType;}
  FBody := 0;
  FInput := 0;
  FOutput := 0;
end;

function TAiMethod20050525.Load(): AError;
var
  Data: TAiDataObject;
begin
  Result := inherited Load;
  if Result <> 0 then Exit;
  Data := GetData;
  Data.ReadId(FInput);
  Data.ReadId(FOutput);
  Data.ReadId(FBody);
end;

function TAiMethod20050525.Save(): AError;
var
  Data: TAiDataObject{2005};
begin
  Result := inherited Save;
  if Result <> 0 then Exit;
  Data := GetData;
  Data.WriteId(FInput);
  Data.WriteId(FOutput);
  Data.WriteId(FBody);
end;

{ TAiMethod20050526 }

function TAiMethod20050526.Run(): AError;
{var
  HBody: THandle064;
  FBody: TAIFreimA;
  Body: String;
  Comands: TAIIComands;
  I: Int032;}
begin
  (*if H = 0 then H := aiFreim03Select;
  if H = 0 then Exit;
  HBody := aiFreim03BodyGet(H);
  FBody := Source.F(HBody);
  Body := aiFreimStrGet(HBody);
  FBody.Free;
  {Разделение на команды}
  IComands(Body, Comands);
  for I := 0 to High(Comands) do begin
    {Выделение команды}
    {IComand(Comands[I], Comand);}
    {...}
  end;*)
  //Result := 1;
end;

{ TAiMethod20050830}

constructor TAiMethod20050830.Create(Source: AiSourceObject2005; Id: TAId);
begin
  inherited Create(Source, Id);
  {Prototype := frType;}
  FBody := 0;
  FInput := 0;
  FOutput := 0;
end;

function TAiMethod20050830.Load(): AError;
var
  Data: TAiDataObject;
begin
  Result := inherited Load;
  if Result <> 0 then Exit;
  Data := GetData;
  if (Data.GetType = dtStream) then
  begin
    Data.GetStream.ReadInt64(FInput);
    Data.GetStream.ReadInt64(FOutput);
    Data.GetStream.ReadInt64(FBody);
  end
  else
  begin
    Data.GetXml.ReadParamValueByNameAsInt64('Input', FInput);
    Data.GetXml.ReadParamValueByNameAsInt64('Output', FOutput);
    Data.GetXml.ReadParamValueByNameAsInt64('Body', FBody);
  end;
end;

function TAiMethod20050830.Save(): AError;
var
  Data: TAiDataObject;
begin
  Result := inherited Save;
  if Result <> 0 then Exit;
  Data := GetData;
  if Data.GetType = dtStream then
  begin
    Data.GetStream.WriteUInt64(FInput);
    Data.GetStream.WriteUInt64(FOutput);
    Data.GetStream.WriteUInt64(FBody);
  end
  else
  begin
    Data.GetXml.SetParamValueByNameAsUInt64('Input', FInput);
    Data.GetXml.SetParamValueByNameAsUInt64('Output', FOutput);
    Data.GetXml.SetParamValueByNameAsUInt64('Body', FBody);
  end;
end;

{ TAiMethod20050915 }

constructor TAiMethod20050915.Create(Source: AiSourceObject2005; Id: TAId);
begin
  inherited Create(Source, Id);
  {Prototype := frType;}
  FBody := 0;
  FInput := 0;
  FOutput := 0;
end;

function TAiMethod20050915.Load(): AError;
var
  Data: TAiDataObject{20050911};
begin
  Result := inherited Load;
  if Result <> 0 then Exit;
  Data := GetData;
  if Data.GetType = dtStream then
  begin
    Data.GetStream.ReadInt64(FInput);
    Data.GetStream.ReadInt64(FOutput);
    Data.GetStream.ReadInt64(FBody);
  end
  else
  begin
    Data.GetXml.ReadParamValueByNameAsInt64('Input', FInput);
    Data.GetXml.ReadParamValueByNameAsInt64('Output', FOutput);
    Data.GetXml.ReadParamValueByNameAsInt64('Body', FBody);
  end;
end;

function TAiMethod20050915.Save(): AError;
var
  Data: TAiDataObject;
begin
  Result := inherited Save;
  if Result <> 0 then Exit;
  Data := GetData;
  if Data.GetType = dtStream then
  begin
    Data.GetStream.WriteUInt64(FInput);
    Data.GetStream.WriteUInt64(FOutput);
    Data.GetStream.WriteUInt64(FBody);
  end
  else
  begin
    Data.GetXml.SetParamValueByNameAsUInt64('Input', FInput);
    Data.GetXml.SetParamValueByNameAsUInt64('Output', FOutput);
    Data.GetXml.SetParamValueByNameAsUInt64('Body', FBody);
  end;
end;

{ TAiMethod2006 }

constructor TAiMethod2006.Create(Source: AiSourceObject2005; Id: TAId);
begin
  inherited Create(Source, Id);
  {Prototype := frType;}
  FBody := 0;
  FInput := 0;
  FOutput := 0;
end;

function TAiMethod2006.Load(): AError;
{var
  Data: TAI_Data;}
begin
  {Result := inherited Load;
  if not(Result) then Exit;
  Data := GetData;
  if Data.GetType = dtStream then begin
    Data.GetStream.ReadInt64(FInput);
    Data.GetStream.ReadInt64(FOutput);
    Data.GetStream.ReadInt64(FBody);
  end else begin
    Data.GetXml.DocumentElement.ReadInt64('Input', FInput);
    Data.GetXml.DocumentElement.ReadInt64('Output', FOutput);
    Data.GetXml.DocumentElement.ReadInt64('Body', FBody);
  end;}
end;

function TAiMethod2006.Save(): AError;
{var
  Data: TAI_Data;}
begin
  {Result := inherited Save;
  if not(Result) then Exit;
  Data := GetData;
  if Data.GetType = dtStream then begin
    Data.GetStream.WriteUInt64(FInput);
    Data.GetStream.WriteUInt64(FOutput);
    Data.GetStream.WriteUInt64(FBody);
  end else begin
    Data.GetXml.DocumentElement.WriteInt64('Input', FInput);
    Data.GetXml.DocumentElement.WriteInt64('Output', FOutput);
    Data.GetXml.DocumentElement.WriteInt64('Body', FBody);
  end;}
end;

end.
