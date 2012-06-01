{**
@Abstract(AiSensors)
@Author(Prof1983 prof1983@ya.ru)
@Created(11.03.2012)
@LastMod(03.05.2012)
@Version(0.5)
}
unit AiSensors;

interface

uses
  ABase,
  AiFrameImpl, AiSourceObj, AiTypes;

type
  Int32 = AInt32;
  UInt32 = AUInt32;

type
  TAISensor = class(TAiFreim)
  private
    FName: String;
    FValue: Int32;
  public
    constructor Create({Source: TAISource; Id: TAI_Id});
    function GetName: String;
    function GetValue: Int32;
    function SetName(Value: String): AError;
    function SetValue(Value: Int32): AError;
  end;

  TAISensorButton = class(TAiSensor)
  end;

type
  TAISensors = class(TAIFreim)
  private
    FItems: array of TAISensor;
  public
    procedure AddSensor(Sensor: TAISensor);
    function Clear: WordBool; override;
    procedure Free; override;
    function GetCountSensors: UInt32;
    function GetSensor(Index: UInt32): TAISensor;
    function NewSensor: TAISensor;
  end;

implementation

{ TAISensor }

constructor TAISensor.Create({Source: TAISource; Id: TAI_Id});
begin
  inherited Create();
  FName := '';
  FValue := 0;
end;

function TAISensor.GetName: String;
begin
  Result := FName;
end;

function TAISensor.GetValue: Int32;
begin
  Result := FValue;
end;

function TAISensor.SetName(Value: String): AError;
begin
  FName := Value;
  Result := 0;
end;

function TAISensor.SetValue(Value: Int32): AError;
begin
  FValue := Value;
  Result := 0;
end;

{ TAISensors }

procedure TAISensors.AddSensor(Sensor: TAISensor);
var
  I: Int32;
begin
  I := Length(FItems); SetLength(FItems, I+1);
  FItems[I] := Sensor;
end;

function TAISensors.Clear: WordBool;
begin
  SetLength(FItems, 0);
  Result := True;
end;

procedure TAISensors.Free;
begin
  inherited Free;
end;

function TAISensors.GetCountSensors: UInt32;
begin
  Result := Length(FItems);
end;

function TAISensors.GetSensor(Index: UInt32): TAISensor;
begin
  if Index >= UInt32(Length(FItems)) then
    Result := nil
  else
    Result := FItems[Index];
end;

function TAISensors.NewSensor(): TAISensor;
begin
  Result := TAISensor.Create(); //(nil, 0);
  {GetSource.NewFreim(Result);}
  //GetSource.NewFreim(0);
  AddSensor(Result);
end;

end.
