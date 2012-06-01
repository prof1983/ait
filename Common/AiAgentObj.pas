﻿{**
@Abstract(Агент в системе AR)
@Author(Prof1983 prof1983@ya.ru)
@Created(13.11.2007)
@LastMod(17.05.2012)
@Version(0.5)

Агент - это отдельная программа или отдельный подпроцесс.
Агент - это служба/демон.
Агент выполняется на машине (как отдельная программа) или на в виде отдельного подпроцесса в
    программе-сервере (площидки).
Агент взаимодействует с системой ИИ путем приемо и отправки сообщений.
Агент может быть перемещаемым с одной площадки на другую или стационарным (привязанным к
    определенной машине).
Стационарный агент может взаимодействовать с операционной системой произвольным образом.
Перемещаемый агент может использовать только функции прощадки.
}
unit AiAgentObj;

interface

uses
  Forms, SysUtils,
  AConfigObj, ALogObj, ATypes,
  AiAgentBase, AiBase, AiFrameObj, {AiMain,} AiProcessObj, AiTypes; {ArJob;}

type
  TAiAgent2007 = class // LastMod(01.12.2007)
  private
    // Работы (задания) агента
    //FJobs: array of TARJob;
    // Онтология агента
    //FOntology: TAROntology;
  protected
    //function GetJobByIndex(Index: Integer): TARJob;
    //function GetJobCount(): Integer;
  public
    // Приостановить выполнение агента
    procedure Pause();
    // Начать/продолжить выполнение агента
    procedure Start();
    // Остановить выполнение агента
    procedure Stop();
  public
    //property JobByIndex[Index: Integer]: TARJob read GetJobByIndex;
    //property JobCount: Integer read GetJobCount;
  end;

  TAiAgent2005 = class(TAiFrameObject2005) {274}
  protected
    {FNeuro: TAINeuroNetwork;
    FLogic: TAILogic;
    FText: TAIText;
    FTree: TAIDecisionsTree;
    FGenetic: TAIGenetic;
    FProbability: TAIProbability;}
    {+Алгоритмы кластеризации ???}
    {FProgram: TAIPrograms;}
    {FModules: array of TAIModule;}
      // Процесс
    FProcess: TAiProcess2005;
      // Статус процесса
    FStatus: TAIAgentStatus;
  protected
      // Запущен ли агент
    FActive: Boolean;
      // Главное окно
    FFormMain: TForm;
      // Имя агента короткое
    FName: String;
      // Отображаемое название агента длиное
    FTitle: String;
      // Окно агента видимо
    FVisible: Boolean;
    //F_AR: TAiAr20050915;
  public
    constructor Create(Source: AiSourceObject2005; Id: TAI_Id = 0);
    function GetActive: Boolean;
    function GetName: String;
    function GetProcess(): TAiProcess2005;
    function GetStatus: TAIAgentStatus;
    function GetTitle: String;
    function GetVisible: Boolean;
    function Init(APath: String; ALog: TLog; AConfig: TConfig; APrefix: String; {AAR: TAIAR;} AFormMain: TForm): TError; virtual;
    function Initialize: TError; override;
    function Pause: TError; virtual;
    function Regist: TError; override;
    function Run: TError; virtual;
    procedure SetActive(Value: Boolean);
    procedure SetName(Value: String);
    function SetProcess(Value: TAiProcess2005): TError;
    function SetStatus(Value: TAIAgentStatus): TError;
    function SetTitle(Value: String): TError;
    procedure SetVisible(Value: Boolean);
    function Show: TError; virtual;
    function Stop: TError; virtual;
  end;

  //TAiAgent20050526 = TAiAgent2005;
  //TAiAgent20050915 = TAiAgent2005;

  //TAiAgent = TAiAgent2007;
  //TArAgent = TAiAgent

implementation

{ TAiAgent2005 }

constructor TAiAgent2005.Create(Source: AiSource2005; Id: TAI_Id);
begin
  inherited Create(Source, Id);
  FStatus := AgentStatusStoped;
end;

function TAiAgent2005.GetActive(): Boolean;
begin
  Result := FActive;
end;

function TAiAgent2005.GetName(): String;
var
  Id: TAI_Id;
begin
  Result := FName;
  Id := GetId;
  if (Result = '') and (Id > 0) then
    Result := IntToStr(Id);
end;

function TAiAgent2005.GetProcess(): TAiProcess2005;
begin
  Result := FProcess;
end;

function TAiAgent2005.GetStatus(): TAIAgentStatus;
begin
  Result := FStatus;
end;

function TAiAgent2005.GetTitle(): String;
begin
  Result := FTitle;
end;

function TAiAgent2005.GetVisible(): Boolean;
begin
  Result := FVisible;
end;

function TAiAgent2005.Init(APath: String; ALog: TLog; AConfig: TConfig; APrefix: String; {AAR: TAIAR;} AFormMain: TForm): TError;
begin
  FActive := True;
  //F_AR := AAR;
  FFormMain := AFormMain;
  Result := inherited Init(APath, ALog, AConfig, APrefix);
end;

function TAiAgent2005.Initialize: TError;
begin
  Result := inherited Initialize;
end;

function TAiAgent2005.Pause: TError;
begin
  FStatus := AgentStatusPaused;
  Result := 0;
end;

function TAiAgent2005.Regist: TError;
begin
  Result := inherited Regist;
end;

function TAiAgent2005.Run: TError;
begin
  FStatus := AgentStatusRuned;
  Result := 0;
end;

procedure TAiAgent2005.SetActive(Value: Boolean);
begin
  FActive := Value;
end;

procedure TAiAgent2005.SetName(Value: String);
begin
  FName := Value;
end;

function TAiAgent2005.SetProcess(Value: TAiProcess2005): TError;
begin
  Result := Stop;
  if Result <> 0 then Exit;
  FProcess := Value;
end;

function TAiAgent2005.SetStatus(Value: TAIAgentStatus): TError;
begin
  case Value of
    AgentStatusPaused: Pause;
    AgentStatusRuned: Run;
    AgentStatusStoped: Stop;
  end;
  Result := 0;
end;

function TAiAgent2005.SetTitle(Value: String): TError;
begin
  FTitle := Value;
  Result := 0;
end;

procedure TAiAgent2005.SetVisible(Value: Boolean);
begin
  FVisible := Value;
end;

function TAiAgent2005.Show: TError;
begin
  Result := 0;
end;

function TAiAgent2005.Stop: TError;
begin
  FStatus := AgentStatusStoped;
  Result := 0;
end;

{ TAiAgent2007 }

{function TAiAgent.GetJobByIndex(Index: Integer): TARJob;
begin
  if (Index >= 0) and (Index < Length(FJobs)) then
    Result := FJobs[Index]
  else
    Result := nil;
end;}

{function TAiAgent.GetJobCount(): Integer;
begin
  Result := Length(FJobs);
end;}

procedure TAiAgent2007.Pause();
begin
end;

procedure TAiAgent2007.Start();
begin
end;

procedure TAiAgent2007.Stop();
begin
end;

end.