{**
@Abstract(AiBody)
@Author(Prof1983 prof1983@ya.ru)
@Created(11.03.2012)
@LastMod(03.05.2012)
@Version(0.5)
}
unit AiBody;

interface

uses
  ABase, ABaseUtils2,
  AiBase, AiFrameImpl, AiSourceObj, AiTypes;

type
  TAiBodyTyp = (bBox, bLine);

type //** Тело для модели
  TAiBody = class(TAiFreim)
  private
    FTyp: TAIBodyTyp;
    FX1: AInt32;
    FX2: AInt32;
    FY1: AInt32;
    FY2: AInt32;
  public
    constructor Create({Pool: AiSource2005; Id: TAI_Id;} Typ: TAIBodyTyp; X1, Y1, X2, Y2: AInt32);
    function GetHeight(): AInt32;
    function GetWidth(): AInt32;
    procedure SetHeight(Value: AInt32);
    procedure SetWidth(Value: AInt32);
    property Typ: TAIBodyTyp read FTyp;
    property X1: AInt32 read FX1 write FX1;
    property X2: AInt32 read FX2 write FX2;
    property Y1: AInt32 read FY1 write FY1;
    property Y2: AInt32 read FY2 write FY2;
  end;

type //** Тело для модели в виде прямоугольника
  TAiBodyBox = class(TAiBody)
  end;

type //** Внешняя линия тела для модели
  TAiBodyLine = class(TAiBody)
  private
    FAngle: Single;
    FLength: AUInt32;
  public
    constructor Create({Source: AiSource2005; Id: TAI_Id;} X1, Y1: AInt32; Angle: Single; Length: AUInt32);
    function GetAngle: Single;
    function GetLength: AUInt32;
    procedure SetAngle(Value: Single);
    procedure SetLength(Value: AUInt32);
  end;

implementation

{ TAiBody }

constructor TAiBody.Create({Pool: AiSource2005; Id: TAI_Id;} Typ: TAIBodyTyp; X1, Y1, X2, Y2: AInt32);
begin
  inherited Create();
  FTyp := Typ;
  FX1 := X1;
  FX2 := X2;
  FY1 := Y1;
  FY2 := Y2;
end;

function TAiBody.GetHeight: AInt32;
begin
  Result := Abs(FY1 - FY2);
end;

function TAiBody.GetWidth: AInt32;
begin
  Result := Abs(FX1 - FX2);
end;

procedure TAiBody.SetHeight(Value: AInt32);
begin
  FY2 := FY1 + Value;
end;

procedure TAiBody.SetWidth(Value: AInt32);
begin
  FX2 := FX1 + Value;
end;

{ TAiBodyLine }

constructor TAiBodyLine.Create({Source: AiSource2005; Id: TAI_Id;} X1, Y1: AInt32; Angle: Single; Length: AUInt32);
var
  H: AInt32;
  W: AInt32;
begin
  FAngle := Angle;
  FLength := Length;
  H := cFloat32ToInt32(FLength * Sin(FAngle));
  W := cFloat32ToInt32(FLength * Cos(FAngle));
  inherited Create({Source, Id,} bLine, X1, Y1, X1 + W, Y1 + H);
end;

function TAiBodyLine.GetAngle: Single;
begin
  Result := FAngle;
end;

function TAiBodyLine.GetLength: AUInt32;
begin
  Result := FLength;
end;

procedure TAiBodyLine.SetAngle(Value: Single);
begin
  FAngle := Value;
end;

procedure TAiBodyLine.SetLength(Value: AUInt32);
begin
  FLength := Value;
end;

end.
