{**
@Abstract(AiSceneMobile)
@Author(Prof1983 prof1983@ya.ru)
@Created(11.03.2012)
@LastMod(04.07.2012)
@Version(0.5)
}
unit AiSceneMobile;

interface

uses
  ExtCtrls,
  ABase,
  AiFrameObj, AiScene;

type //** Сцена действия для модели машинки TAIModelMobile
  TAiSceneMobile = class(TAIScene)
  private
    FImage: TImage;
  public
    constructor Create(Model: TAiFrameObject);
    property Image: TImage read FImage write FImage;
    function Paint: AError; override;
    function Step: AError;
  end;

implementation

{ TAiSceneMobile }

constructor TAiSceneMobile.Create(Model: TAiFrameObject);
begin
  inherited Create(Model);
  {Canvas.Height := 200;
  Canvas.Width := 200;
  ModelPosX := 100;
  ModelPosY := 100;
  ModelAlpha := 0;}
end;

function TAiSceneMobile.Paint(): AError;
{var
  X1, X2, Y1, Y2: Int32;}
begin
  (*if not(Assigned(FImage)) then Exit;

  {}
  FImage.Canvas.Pen.Color := clBlack;
  FImage.Canvas.Rectangle(0, 0, Canvas.Width, Canvas.Height);

  {}
  if not(Assigned(Model)) then Exit;
  FImage.Canvas.Pen.Color := clRed;
  X1 := ModelPosX - cSingleToInt32(( Int32(Model.Height div 2)) * Cos(ModelAlpha));
  Y1 := ModelPosY - cSingleToInt32(( Int32(Model.Width div 2)) * Sin(ModelAlpha));
  X2 := ModelPosX + cSingleToInt32(( Int32(Model.Height div 2)) * Cos(ModelAlpha));
  Y2 := ModelPosY + cSingleToInt32(( Int32(Model.Width div 2)) * Sin(ModelAlpha));
  FImage.Canvas.Rectangle(X1, Y1, X2, Y2);

  {Направление движения}
  FImage.Canvas.Pen.Color := clGreen;
  FImage.Canvas.MoveTo(ModelPosX, ModelPosY);
  FImage.Canvas.LineTo(
    cSingleToUInt32(ModelPosX + 10 * Cos(ModelAlpha)),
    cSingleToUInt32(ModelPosY + 10 * Sin(ModelAlpha))
  );*)
  Result := 0;
end;

function TAiSceneMobile.Step(): AError;
begin
  Result := inherited Step();
  Paint();
end;

end.
