﻿{**
@Abstarct Агент модели
@Author Prof1983 <prof1983@ya.ru>
@Created 02.11.2005
@LastMod 17.12.2012
}
unit AiModel;

// TODO: Разобраться с ненужными классами
// TODO: Rename to AiModelObj.pas

interface

uses
  SysUtils,
  ABase, AConfig2007, ATypes,
  AiAgentObj, AiAgentProcessObj, AiAnalyser, AiBase, AiBody,
  AiFrameObj, AiModelForm, AiSceneMobile, AiSensors, AiSourceObj;

type
  //TAIModelMobile = class;

  TAIAgentModel1 = class(TAiAgentObject)
  private
    FFormModel: TFormAIModel;
  public
    constructor Create(AConfig: TConfigNode1; ASource: TAISource = nil; AId: UInt64 = 0);
    property FormModel: TFormAIModel read FFormModel;
    procedure Free(); override;
  end;

  // Агент управления мобильмым объектом с датчиками и действиями
  {TAIAgentModelMobile = class(TAIAgentModel)
  private
  public
    function Initialize: WordBool; override;
  end;}

  TAIModelDrive = class(TAiFrameObject)
  private
    FName: String;
    FSpeed: Int32;
  public
    function GetName: String;
    function GetSpeed: Int32;
    function SetName(Value: String): AError;
    function SetSpeed(Value: Int32): AError;
    function Step(): AError; virtual;
    function Stop(): AError;
  end;

  TAIModelDrives = class(TAiFrameObject)
  private
    FItems: array of TAIModelDrive;
  public
    function AddDrive(Drive: TAIModelDrive): UInt32;
    function Clear(): AError; override;
    function GetCountDrives: UInt32;
    function GetDrive(Index: UInt32): TAIModelDrive;
    function NewDrive: TAIModelDrive;
    function Step(): AError;
  end;

  //** Модель машинки
  TAIModel = class(TAiFrameObject)
  private
    FBody: TAIBody;            {Тело модели}
    FDrives: TAIModelDrives;   {Двигатели}
    FName: String;
    FSensors: TAISensors; {Датчики}
  public
    constructor Create(Source: AiSource2005; Id: TAId);
    function GetBody: TAIBody;
    function GetDrives: TAIModelDrives;
    function GetHeight: UInt32;
    function GetName: String;
    function GetSensors: TAISensors;
    function GetWidth: UInt32;
    function Initialize(): AError; override;
    function SetBody(Value: TAiBody): AError;
    function SetDrives(Value: TAiModelDrives): AError;
    function SetHeight(Value: UInt32): AError;
    function SetName(Value: String): AError;
    function SetSensors(Value: TAiSensors): AError;
    function SetWidth(Value: UInt32): AError;
    function Step(): AError; virtual;
  end;

type
  TAIModelMobile = class(TAIModel)
  private
    //FBody: TAIBodyBox;
    FDriveLeft: TAIModelDrive;
    FDriveRight: TAIModelDrive;
    {FDX: TAIModelDrive;
    FDY: TAIModelDrive;}
    FSX1: TAISensorButton;
    FSX2: TAISensorButton;
    FSY1: TAISensorButton;
    FSY2: TAISensorButton;
  public
    constructor Create(Pool: AiSource2005);
    property DriveLeft: TAIModelDrive read FDriveLeft;
    property DriveRight: TAIModelDrive read FDriveRight;
    {property DX: TAIModelDrive read FDX;
    property DY: TAIModelDrive read FDY;}
    property SX1: TAISensorButton read FSX1;
    property SX2: TAISensorButton read FSX2;
    property SY1: TAISensorButton read FSY1;
    property SY2: TAISensorButton read FSY2;
    procedure Stop;
    function Step(): AError; override;
  end;

type //** Агент-модель - для расположения на сцене
  TAIAgentModel2 = class(TAiAgentObject)
  private
    FAnalyzer: TAIAnalyzerMobile;
    {FForm: TAIFormModel;}
    FMobile: TAIModelMobile;
    {FProcess: TAIProcess;}
    FScene: TAISceneMobile;
    {procedure SetForm(Value: TAIFormModel);}
  public
    property Analyzer: TAIAnalyzerMobile read FAnalyzer;
    constructor Create(Source: TAISource; Id: TAId);
    {property Form: TAIFormModel read FForm write SetForm;}
    procedure Free; override;
    property Mobile: TAIModelMobile read FMobile;
    {property Process: TAIProcess read FProcess;}
    property Scene: TAISceneMobile read FScene;
    function Step(): AError;
  end;

implementation

{ TAIAgentModel }

constructor TAIAgentModel1.Create(AConfig: TConfigNode1; ASource: TAISource = nil; AId: UInt64 = 0);
begin
  inherited Create(); //(AConfig, ALog, ASource, AId);
  FFormModel := TFormAIModel.Create(nil);
end;

procedure TAIAgentModel1.Free;
begin
  FreeAndNil(FFormModel);
  inherited Free;
end;

{ TAIAgentModel }

constructor TAIAgentModel2.Create(Source: TAISource; Id: TAId);
begin
  inherited Create();
  FMobile := TAIModelMobile.Create(AiSource2005(Source));
  FScene := TAISceneMobile.Create({Source,} FMobile);

  FAnalyzer := TAIAnalyzerMobile.Create(AiSource2005(Source));

  FProcess := TAiAgentProcessObject.Create();
  {FProcess.Analyzer := FAnalyzer;}
  {FProcess.Model := FMobile;}
  {FProcess.Scene := FScene;}
  {Scene.Model := FMobile;}
end;

procedure TAIAgentModel2.Free;
begin
  {FProcess.Thread.Stop := True;
  FProcess.Free;}
  FScene.Free;
  FMobile.Free;
  FAnalyzer.Free;
  inherited Free;
end;

{procedure TAIAgentModel2.SetForm(Value: TAIFormModel);
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

function TAIAgentModel2.Step(): AError;
begin
  Result := FScene.Step;
end;

{ TAIAgentModelMobile }

{function TAIAgentModelMobile.Initialize: WordBool;
begin
  Result := inherited Initialize;
  SetTitle('AgentMobile');
end;}

{ TAIModelMobile }

constructor TAIModelMobile.Create(Pool: AiSource2005);
begin
  FBody := TAiBodyBox.Create({Pool, 0,} bBox, 100, 100, 140, 140);
  inherited Create(Pool, 0);
  SetBody(FBody);
  {Сенсоры}
  FSX1 := TAISensorButton.Create({Pool, 0});
  FSX2 := TAISensorButton.Create({Pool, 0});
  FSY1 := TAISensorButton.Create({Pool, 0});
  FSY2 := TAISensorButton.Create({Pool, 0});
  {Sensors.Add(FSX1);
  Sensors.Add(FSX2);
  Sensors.Add(FSY1);
  Sensors.Add(FSY2);}
  {Движители}
  {FDX := Drives.New;
  FDY := Drives.New;}
  {FDriveLeft := TAIModelDrive.Create;
  FDriveRight := TAIModelDrive.Create;
  Drives.Add(FDriveLeft);
  Drives.Add(FDriveRight);}
end;

function TAIModelMobile.Step{(var ResX: Int32; var ResY: Int32)}: AError;
{var
  DXSpeed: Int32;
  DYSpeed: Int32;
  H2: Int32;
  W2: Int32;}
begin
  (*inherited RunStep;
  {Движение возможно только если не упираемся в стенки или препятствия}
  {DXSpeed := Convert.ToInt32(DX.Speed);}
  DXSpeed := cFloat064ToInt032(DX.Speed);
  {DYSpeed := Convert.ToInt32(DY.Speed);}
  DXSpeed := cFloat064ToInt032(DY.Speed);
  H2 := Height div 2;
  W2 := Width div 2;
  if DXSpeed = 0 then ResX := 0 else
  if DXSpeed > 0 then begin
    if FSX2.Value = 0 then ResX := 0 else
    if FSX2.Value >= W2 + Abs(DXSpeed) then
      ResX := DXSpeed
    else begin
      if FSX2.Value > W2 then
        ResX := FSX2.Value - W2
      else
        ResX := 0;
    end;
  end else begin
    if FSX1.Value = 0 then ResX := 0 else
    if FSX1.Value >= W2 + Abs(DXSpeed) then
      ResX := DXSpeed
    else begin
      if FSX1.Value > W2 then
        ResX := - (FSX1.Value - W2)
      else
        ResX := 0;
    end;
  end;
  {CenterX := CenterX + ResX;}

  if DYSpeed = 0 then ResY := 0 else
  if DYSpeed > 0 then begin
    if FSY2.Value = 0 then ResY := 0 else
    if FSY2.Value >= H2 + Abs(DYSpeed) then
      ResY := DYSpeed
    else begin
      if FSY2.Value > H2 then
        ResY := FSY2.Value - H2
      else
        ResY := 0;
    end;
  end else begin
    if FSY1.Value = 0 then ResY := 0 else
    if FSY1.Value >= H2 + Abs(DYSpeed) then
      ResY := DYSpeed
    else begin
      if FSY1.Value > H2 then
        ResY := - (FSY1.Value - H2)
      else
        ResY := 0;
    end;
  end;
  {CenterY := CenterY + ResY;}*)
  Result := 1;
end;

procedure TAIModelMobile.Stop;
begin
  FDriveLeft.Stop;
  FDriveRight.Stop;
  {DX.Stop;
  DY.Stop;}
end;

{ TAIModel }

constructor TAIModel.Create(Source: AiSource2005; Id: TAId);
begin
  inherited Create(); //(Source, Id);
  Self.FSource := Source;
  Self.FId := Id;
  {FBody := Body;}
  {FBody := TAIBody.Create(KB);}
  {Height := 40;
  Width := 40;}
  {FDrives := TAIModelDrives.Create;
  FSensors := TAIModelSensors.Create;}
end;

function TAIModel.GetBody: TAIBody;
begin
  Result := FBody;
end;

function TAIModel.GetDrives: TAIModelDrives;
var
  Source: TAISource;
begin
  if not(Assigned(FDrives)) then
  begin
    FDrives := TAIModelDrives.Create();
    Source := TAISource(GetSource);
    if Assigned(Source) then
      Source.NewFreim(0);
  end;
  Result := FDrives;
end;

function TAIModel.GetHeight: UInt32;
begin
  Result := FBody.GetHeight;
end;

function TAIModel.GetName: String;
begin
  Result := FName;
end;

function TAIModel.GetSensors: TAISensors;
var
  Source: TAISource;
begin
  if not(Assigned(FSensors)) then
  begin
    FSensors := TAISensors.Create();
    Source := TAISource(GetSource);
    if Assigned(Source) then
      Source.NewFreim(0);
  end;
  Result := FSensors;
end;

function TAIModel.GetWidth: UInt32;
begin
  Result := FBody.GetWidth;
end;

function TAIModel.Initialize(): AError;
var
  Source: TAISource;
begin
  Result := inherited Initialize;

  Source := TAISource(GetSource);
  if not(Assigned(FSensors)) then
  begin
    FSensors := TAISensors.Create();
    if Assigned(Source) then
      Source.NewFreim(0);
  end;
  FSensors.Initialize;

  if not(Assigned(FDrives)) then
  begin
    FDrives := TAIModelDrives.Create();
    if Assigned(Source) then
      Source.NewFreim(0);
  end;
  FDrives.Initialize;
end;

function TAIModel.SetBody(Value: TAiBody): AError;
begin
  FBody := Value;
  Result := 0;
end;

function TAIModel.SetDrives(Value: TAiModelDrives): AError;
begin
  FDrives := Value;
  Result := 0;
end;

function TAIModel.SetHeight(Value: UInt32): AError;
begin
  FBody.SetHeight(Value);
  Result := 0;
end;

function TAIModel.SetName(Value: String): AError;
begin
  FName := Value;
  Result := 0;
end;

function TAIModel.SetSensors(Value: TAiSensors): AError;
begin
  FSensors := Value;
  Result := 0;
end;

function TAIModel.SetWidth(Value: UInt32): AError;
begin
  FBody.SetWidth(Value);
  Result := 0;
end;

function TAIModel.Step(): AError;
begin
  Result := FDrives.Step;
end;

{ TAIModelDrive }

function TAIModelDrive.GetName: String;
begin
  Result := FName;
end;

function TAIModelDrive.GetSpeed: Int32;
begin
  Result := FSpeed;
end;

function TAIModelDrive.SetName(Value: String): AError;
begin
  FName := Value;
  Result := 0;
end;

function TAIModelDrive.SetSpeed(Value: Int32): AError;
begin
  FSpeed := Value;
  Result := 0;
end;

function TAIModelDrive.Step(): AError;
begin
  Result := 0;
end;

function TAIModelDrive.Stop(): AError;
begin
  FSpeed := 0;
  Result := 0;
end;

{ TAIModelDrives }

function TAIModelDrives.AddDrive(Drive: TAIModelDrive): UInt32;
begin
  Result := Length(FItems); SetLength(FItems, Result + 1);
  FItems[Result] := Drive;
end;

function TAIModelDrives.Clear(): AError;
begin
  SetLength(FItems, 0);
  Result := 0;
end;

function TAIModelDrives.GetCountDrives: UInt32;
begin
  Result := Length(FItems);
end;

function TAIModelDrives.GetDrive(Index: UInt32): TAIModelDrive;
begin
  if Index >= UInt32(Length(FItems)) then
    Result := nil
  else
    Result := FItems[Index];
end;

function TAIModelDrives.NewDrive: TAIModelDrive;
var
  I: Int32;
begin
  I := Length(FItems); SetLength(FItems, I+1);
  FItems[I] := TAIModelDrive.Create();
  {GetSource.NewFreim(FItems[I]);}
  //GetSource.NewFreim(0);
  Result := FItems[I];
end;

function TAIModelDrives.Step(): AError;
var
  I: Int32;
begin
  Result := 0;
  for I := 0 to High(FItems) do begin
    if FItems[I].Step <> 0 then Result := 1;
  end;
end;

end.
