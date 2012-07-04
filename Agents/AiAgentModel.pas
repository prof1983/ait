{**
@Abstract(AiAgentModel)
@Author(Prof1983 prof1983@ya.ru)
@Created(11.03.2012)
@LastMod(04.07.2012)
@Version(0.5)
}
unit AiAgentModel;

// TODO: Rename to AiAgentModelObj.pas

interface

uses
  ABase,
  AiAnalyser, AiAgentObj, AiAgentProcessObj, AiBase, AiModel, AiSceneMobile, AiTypes;

type //** Агент-модель - для расположения на сцене
  TAIAgentModel = class(TAiAgentObject)
  private
    FAnalyzer: TAIAnalyzerMobile;
    {FForm: TAIFormModel;}
    FMobile: TAIModelMobile;
    {FProcess: TAIProcess;}
    FScene: TAISceneMobile;
    {procedure SetForm(Value: TAIFormModel);}
  public
    property Analyzer: TAIAnalyzerMobile read FAnalyzer;
    constructor Create(Source: AiSource2005; Id: AId);
    {property Form: TAIFormModel read FForm write SetForm;}
    procedure Free; override;
    property Mobile: TAIModelMobile read FMobile;
    {property Process: TAIProcess read FProcess;}
    property Scene: TAISceneMobile read FScene;
    function Step(): AError;
  end;

type //** Агент управления мобильмым объектом с датчиками и действиями
  TAIAgentModelMobile = class(TAIAgentModel)
  end;

implementation

{ TAIAgentModel }

constructor TAIAgentModel.Create(Source: AiSource2005; Id: AId);
begin
  inherited Create();
  FMobile := TAIModelMobile.Create(Source);
  FScene := TAISceneMobile.Create({Source,} FMobile);

  FAnalyzer := TAIAnalyzerMobile.Create(Source);

  FProcess := TAiAgentProcessObject.Create();
  {FProcess.Analyzer := FAnalyzer;}
  {FProcess.Model := FMobile;}
  {FProcess.Scene := FScene;}
  {Scene.Model := FMobile;}
end;

procedure TAIAgentModel.Free;
begin
  {FProcess.Thread.Stop := True;
  FProcess.Free;}
  FScene.Free;
  FMobile.Free;
  FAnalyzer.Free;
  inherited Free;
end;

{procedure TAIAgentModel.SetForm(Value: TAIFormModel);
begin
  if Assigned(Value) then begin
    FForm := Value;
    FForm.FAgent := Self;
    FScene.Image := FForm.Image;
    FScene.Paint;
  end else begin
    FScene.Image := nil;
    if Assigned(FForm) then FForm.Agent := nil;
    FForm := Value;
  end;
end;}

function TAIAgentModel.Step(): AError;
begin
  Result := FScene.Step;
end;

end.
