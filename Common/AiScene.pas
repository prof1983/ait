{**
@Abstract(AiScene)
@Author(Prof1983 prof1983@ya.ru)
@Created(20.09.2006)
@LastMod(04.07.2012)
@Version(0.5)
}
unit AiScene;

interface

uses
  ABase,
  AiCanvas, AiFrameObj, AiModelBase, AiSourceObj, AiTypes;

type
  TAIScene = class(TAiFrameObject)
  private
    FCanvas: TAICanvas;
      // TAiModel
    FModel: TAiFrameObject;
    FModelAlpha: AFloat32;
    FModelPosX: Int32;
    FModelPosY: Int32;
    FObstacles: TAIModelObstacles; {Препятствия}
  public
    constructor Create(Model: TAiFrameObject);
    procedure Free;
    function GetCanvas: TAICanvas;
    function GetModel(): TAiFrameObject;
    function GetModelAlpha: AFloat32;
    function GetModelPosX: Int32;
    function GetModelPosY: Int32;
    function GetObstacles: TAIModelObstacles;
    function Paint: AError; virtual;
    function PointA(X, Y: Int32): Boolean;
    function SetModel(Value: TAiFrameObject): AError;
    function SetModelAlpha(Value: Single): AError;
    function SetModelPosX(Value: Int32): AError;
    function SetModelPosY(Value: Int32): AError;
    function SetObstacles(Value: TAIModelObstacles): AError;
    function Step: AError;
  end;

  // Изображение сцены модели
  TAIImageScene = class(TAiFrameObject)
  private
    FScene: TAIScene;
  public
    constructor Create(Scene: TAIScene);
    procedure Free;
    function GetScene: TAIScene;
    function Refresh: AError; virtual;
    function SetScene(Value: TAIScene): AError;
  end;

implementation

uses
  AiModel;

{ TAiScene }

constructor TAIScene.Create(Model: TAiFrameObject);
begin
  inherited Create();
  FCanvas := TAICanvas.Create();
  FModel := Model;
  FObstacles := TAIModelObstacles.Create();
  {GetSource.NewFreim(FObstacles);}
  //GetSource.NewFreim(0);
  FModelPosX := 100;
  FModelPosY := 100;
end;

procedure TAIScene.Free;
begin
  FObstacles.Free;
  FCanvas.Free;
  inherited Free;
end;

function TAIScene.GetCanvas: TAICanvas;
begin
  Result := FCanvas;
end;

function TAIScene.GetModel(): TAiFreim{TAIModel};
begin
  Result := FModel;
end;

function TAIScene.GetModelAlpha: AFloat32;
begin
  Result := FModelAlpha;
end;

function TAIScene.GetModelPosX: Int32;
begin
  Result := FModelPosX;
end;

function TAIScene.GetModelPosY: Int32;
begin
  Result := FModelPosY;
end;

function TAIScene.GetObstacles: TAIModelObstacles;
begin
  Result := FObstacles;
end;

function TAIScene.Paint: AError;
begin
  Result := 0;
end;

function TAIScene.PointA(X, Y: Int32): Boolean;
var
  I: Int32;
begin
  Result := True;
  if (X <= 1) or (X >= Int32(FCanvas.GetWidth)) then Exit;
  if (Y <= 1) or (Y >= Int32(FCanvas.GetHeight)) then Exit;
  for I := 0 to FObstacles.Count - 1 do begin
    if FObstacles.GetItem(I).PointA(X, Y) then Exit;
  end;
  Result := False;
end;

function TAIScene.SetModel(Value: TAiFreim{TAIModel}): AError;
begin
  FModel := Value;
  Result := 0;
end;

function TAIScene.SetModelAlpha(Value: Single): AError;
begin
  FModelAlpha := Value;
  Result := Paint;
end;

function TAIScene.SetModelPosX(Value: Int32): AError;
begin
  FModelPosX := Value;
  Result := Paint;
end;

function TAIScene.SetModelPosY(Value: Int32): AError;
begin
  FModelPosY := Value;
  Result := Paint;
end;

function TAIScene.SetObstacles(Value: TAIModelObstacles): AError;
begin
  FObstacles := Value;
  Result := 0;
end;

function TAIScene.Step: AError;
begin
  if not(Assigned(FModel)) then
  begin
    Result := 1;
    Exit;
  end;
  Result := TAiModel(FModel).Step;
end;

{TAIImageScene}

constructor TAIImageScene.Create({Source: TAISource; Id: TAI_Id;} Scene: TAIScene);
begin
  inherited Create({Source, Id});
  FScene := Scene;
  {if Assigned(FScene) then FScene.Used := FScene.Used + 1;}
end;

procedure TAIImageScene.Free;
begin
  {if Used = 0 then begin FScene.Free; FScene := nil; end;}
  inherited Free;
end;

function TAIImageScene.GetScene: TAIScene;
begin
  Result := FScene;
end;

function TAIImageScene.Refresh: AError;
begin
  Result := 0;
end;

function TAIImageScene.SetScene(Value: TAIScene): AError;
begin
  FScene := Value;
  Result := 0;
end;

end.
