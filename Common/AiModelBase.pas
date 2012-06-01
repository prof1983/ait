{**
@Abstarct(Агент модели)
@Author(Prof1983 prof1983@ya.ru)
@Created(02.11.2005)
@LastMod(16.04.2012)
@Version(0.5)

0.0.0.2 - 03.02.2006
0.0.0.1 - 02.11.2005
}
unit AiModelBase;

// TODO: Разобраться с ненужными классами

interface

uses
  ABase,
  AiFrameImpl;

type
  Int32 = AInt32;
  UInt32 = AUInt32;

type
  TAIModelObstacle = class(TAIFreim)
  private
    FX1: Int32;
    FY1: Int32;
    FX2: Int32;
    FY2: Int32;
  public
    property X1: Int32 read FX1 write FX1;
    property Y1: Int32 read FY1 write FY1;
    property X2: Int32 read FX2 write FX2;
    property Y2: Int32 read FY2 write FY2;
    function PointA(X, Y: Int32): Boolean;
  end;

  TAIModelObstacles = class(TAIFreim)
  private
    FItems: array of TAIModelObstacle;
  public
    function Count: UInt32;
    procedure Free; override;
    function GetItem(Index: UInt32): TAIModelObstacle;
    function New(X1, Y1, X2, Y2: UInt32): TAIModelObstacle;
  end;

implementation

{ TAIModelObstacle }

function TAIModelObstacle.PointA(X, Y: Int32): Boolean;
{var
  A: Double;
  B: Double;
  Y1: Int32;}
begin
  (*if FX2 = FX1 then begin
    if (X = FX1) and (Max(FY1, FY2) >= Y) and (Y >= Min(FY1, FY2)) then
      Result := True
    else
      Result := False;
  end else begin
    A := (FY2 - FY1) / (FX2 - FX1);
    B := FY1 / (FX1 * A);
    {Y1 := Convert.ToInt32(A * X + B);}
    {FloatToDecimal( (A * X + B, Y1, fvExtended);}

    if (Y1-1 <= Y) and (Y <= Y1+1) then
      Result := True
    else
      Result := False;
  end;*)
  Result := False;
end;

{ TAIModelObstacles }

function TAIModelObstacles.Count: UInt32;
begin
  Result := Length(FItems);
end;

procedure TAIModelObstacles.Free;
{var
  I: Int32;}
begin
  {for I := 0 to High(FItems) do FItems[I].Free;}
  SetLength(FItems, 0);
  inherited Free;
end;

function TAIModelObstacles.GetItem(Index: UInt32): TAIModelObstacle;
begin
  if Index >= UInt32(Length(FItems)) then
    Result := nil
  else
    Result := FItems[Index];
end;

function TAIModelObstacles.New(X1, Y1, X2, Y2: UInt32): TAIModelObstacle;
var
  I: UInt32;
begin
  I := Length(FItems); SetLength(FItems, I+1);
  FItems[I] := TAIModelObstacle.Create();
  {GetSource.NewFreim(FItems[I]);}
  //GetSource.NewFreim(0);
  FItems[I].X1 := X1;
  FItems[I].Y1 := Y1;
  FItems[I].X2 := X2;
  FItems[I].Y2 := Y2;
  Result := FItems[I];
end;

end.
