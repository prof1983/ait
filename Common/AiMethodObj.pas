{**
@Abstract(AiMethod)
@Author(Prof1983 prof1983@ya.ru)
@Created(17.06.2007)
@LastMod(27.06.2012)
@Version(0.5)
}
unit AiMethodObj;

interface

uses
  ABase, AStreamObj,
  AiBase, AiBaseTypes, AiDataObj, AiNamedFrameObj, AiTypes;

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

  TAiMethodObject = class(TAiNamedFrameObject)
  protected
    FBody: TAId;
    FInput: TAId;
    FOutput: TAId;
  public
    constructor Create(Source: AiSourceObject2005; Id: TAId);
  public
    function Load(): AError; override;
    function Run(): AError;
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

{ TAiMethodObject }

constructor TAiMethodObject.Create(Source: AiSourceObject2005; Id: TAId);
begin
  inherited Create(Source, Id);
  {Prototype := frType;}
  FBody := 0;
  FInput := 0;
  FOutput := 0;
end;

function TAiMethodObject.Load(): AError;
var
  Data: TAiDataObject;
  Stream: TProfStream;
begin
  Result := inherited Load();
  if Result <> 0 then Exit;
  Data := GetData();
  {Data.ReadId(FInput);
  Data.ReadId(FOutput);
  Data.ReadId(FBody);}
  if (Data.GetType = dtStream) then
  begin
    Stream := Data.GetStreamMy();
    Stream.ReadInt64(FInput);
    Stream.ReadInt64(FOutput);
    Stream.ReadInt64(FBody);
  end
  else
  begin
    Data.GetXml.ReadParamValueByNameAsInt64('Input', FInput);
    Data.GetXml.ReadParamValueByNameAsInt64('Output', FOutput);
    Data.GetXml.ReadParamValueByNameAsInt64('Body', FBody);
  end;
end;

function TAiMethodObject.Run(): AError;
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

function TAiMethodObject.Save(): AError;
var
  Data: TAiDataObject;
  Stream: TProfStream;
begin
  Result := inherited Save();
  if (Result <> 0) then Exit;
  Data := GetData();
  {Data.WriteId(FInput);
  Data.WriteId(FOutput);
  Data.WriteId(FBody);}
  if (Data.GetType = dtStream) then
  begin
    Stream := Data.GetStreamMy();
    Stream.WriteUInt64(FInput);
    Stream.WriteUInt64(FOutput);
    Stream.WriteUInt64(FBody);
  end
  else
  begin
    Data.GetXml.SetParamValueByNameAsUInt64('Input', FInput);
    Data.GetXml.SetParamValueByNameAsUInt64('Output', FOutput);
    Data.GetXml.SetParamValueByNameAsUInt64('Body', FBody);
  end;
end;

end.
