{**
@Abstract(Ai module object type)
@Author(Prof1983 prof1983@ya.ru)
@Created(04.06.2012)
@LastMod(04.06.2012)
@Version(0.5)
}
unit AiModuleObj;

interface

uses
  AiBase, AiFrameObj;

type
  TAiModule20050525 = class(TAiFrameObject)
  private
    FDataIn: TAiFrameObject;
    FDataOut: TAiFrameObject;
  public
    constructor Create(Source: AiSource2005; Id: TAId = 0);
    procedure Free; override;
    function GetDataIn: TAiFrameObject;
    function GetDataOut: TAiFrameObject;
    function SetDataIn(Value: TAiFrameObject): AError;
    function SetDataOut(Value: TAiFrameObject): AError;
  end;

implementation

{ TAiModule20050525 }

constructor TAiModule20050525.Create(Source: AiSource2005 {= nil}; Id: TAI_Id = 0);
begin
  inherited Create(Source, Id);
  {FIn := TBitArray.Create;
  FOut := TBitArray.Create;}
end;

procedure TAiModule20050525.Free;
begin
  {FIn.Free;
  FOut.Free;}
  inherited Free;
end;

function TAiModule20050525.GetDataIn: TAIData;
begin
  Result := FDataIn;
end;

function TAiModule20050525.GetDataOut: TAIData;
begin
  Result := FDataOut;
end;

function TAiModule20050525.SetDataIn(Value: TAIData): TError;
begin
  FDataIn := Value;
  Result := 0;
end;

function TAiModule20050525.SetDataOut(Value: TAIData): TError;
begin
  FDataOut := Value;
  Result := 0;
end;

end.
