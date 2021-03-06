﻿{**
@Abstract Агент в системе AR
@Author Prof1983 <prof1983@ya.ru>
@Created 13.11.2007
@LastMod 20.12.2012

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
  SysUtils,
  ABase,
  ALogObj,
  ATypes,
  AiAgentBase, AiProcessObj;

type
  TAiAgentObject = class //(TAiNamedFrameObject)
  protected
    FId: AId;
    FInitialized: ABoolean;
    // Работы (задания) агента
    //FJobs: array of TARJob;
    FOnAddToLog: TAddToLogProc;
    // Онтология агента
    //FOntology: TAROntology;
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

      {** Процесс }
    FProcess: TAiProcessObject;
      {** Статус процесса }
    FStatus: TAiAgentStatus;
  protected
      //** Запущен ли агент
    FActive: Boolean;
      //** Главное окно
    //FFormMain: TForm;
      //** Имя агента короткое
    FName: String;
      //** Отображаемое название агента длиное
    FTitle: String;
      //** Окно агента видимо
    FVisible: Boolean;
  protected
    //function GetJobByIndex(Index: Integer): TARJob;
    //function GetJobCount(): Integer;
  public
    function GetActive(): Boolean;
    function GetId(): AId;
    function GetName(): String;
    function GetProcess(): TAiProcessObject;
    function GetStatus(): TAiAgentStatus;
    function GetTitle(): String;
    function GetVisible(): Boolean;
    procedure SetActive(Value: Boolean);
    procedure SetName(Value: String);
    procedure SetVisible(Value: Boolean);
  public
    function AddToLog(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
        const StrMsg: WideString): AInt; virtual;
    function Init(): AError; virtual; deprecated 'Use Initialize()';
    function Run(): AError; virtual;
    function SetProcess(Value: TAiProcessObject): AError;
    function SetStatus(Value: TAiAgentStatus): AError;
    function SetTitle(Value: String): AError;
    function Show(): AError; virtual;
  public
      //** Финализирует
    function Finalize(): AError; virtual;
      //** Производит инициализацию
    function Initialize(): AError; virtual;
      //** Приостанавливает выполнение агента
    function Pause(): AError; virtual;
      //** Запуск выполнения агента
    function Start(): AError; virtual;
      //** Останавливает выполнение агента
    function Stop(): AError; virtual;
  public
    constructor Create();
    procedure Free(); virtual;
  public
    property Id: AId read FId write FId;
    //property JobByIndex[Index: Integer]: TARJob read GetJobByIndex;
    //property JobCount: Integer read GetJobCount;
    property OnAddToLog: TAddToLogProc read FOnAddToLog write FOnAddToLog;
  end;

  //TAiAgent = TAiAgentObject;

implementation

{ TAiAgentObject }

function TAiAgentObject.AddToLog(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
  const StrMsg: WideString): AInt;
begin
  if Assigned(FOnAddToLog) then
    Result := FOnAddToLog(LogGroup, LogType, StrMsg)
  else
    Result := 0;
end;

constructor TAiAgentObject.Create();
begin
  inherited Create();
  FStatus := AgentStatusStoped;
end;

function TAiAgentObject.Finalize(): AError;
begin
  FInitialized := False;
  Result := 0;
end;

procedure TAiAgentObject.Free();
begin
end;

function TAiAgentObject.GetActive(): Boolean;
begin
  Result := FActive;
end;

function TAiAgentObject.GetId(): AId;
begin
  Result := FId;
end;

{function TAiAgentObject.GetJobByIndex(Index: Integer): TARJob;
begin
  if (Index >= 0) and (Index < Length(FJobs)) then
    Result := FJobs[Index]
  else
    Result := nil;
end;}

{function TAiAgentObject.GetJobCount(): Integer;
begin
  Result := Length(FJobs);
end;}

function TAiAgentObject.GetName(): String;
var
  Id: TAId;
begin
  Result := FName;
  Id := FId;
  if (Result = '') and (Id > 0) then
    Result := IntToStr(Id);
end;

function TAiAgentObject.GetProcess(): TAiProcessObject;
begin
  Result := FProcess;
end;

function TAiAgentObject.GetStatus(): TAiAgentStatus;
begin
  Result := FStatus;
end;

function TAiAgentObject.GetTitle(): String;
begin
  Result := FTitle;
end;

function TAiAgentObject.GetVisible(): Boolean;
begin
  Result := FVisible;
end;

function TAiAgentObject.Init(): AError;
begin
  Result := Initialize();
end;

function TAiAgentObject.Initialize(): AError;
begin
  FActive := True;
  FInitialized := True;
  Result := 0;
end;

function TAiAgentObject.Pause(): AError;
begin
  FStatus := AgentStatusPaused;
  Result := 0;
end;

function TAiAgentObject.Run(): AError;
begin
  FStatus := AgentStatusRuned;
  Result := 0;
end;

procedure TAiAgentObject.SetActive(Value: Boolean);
begin
  FActive := Value;
end;

procedure TAiAgentObject.SetName(Value: String);
begin
  FName := Value;
end;

function TAiAgentObject.SetProcess(Value: TAiProcessObject): AError;
begin
  Result := Stop;
  if Result <> 0 then Exit;
  FProcess := Value;
end;

function TAiAgentObject.SetStatus(Value: TAiAgentStatus): AError;
begin
  case Value of
    AgentStatusPaused: Pause;
    AgentStatusRuned: Run;
    AgentStatusStoped: Stop;
  end;
  Result := 0;
end;

function TAiAgentObject.SetTitle(Value: String): AError;
begin
  FTitle := Value;
  Result := 0;
end;

procedure TAiAgentObject.SetVisible(Value: Boolean);
begin
  FVisible := Value;
end;

function TAiAgentObject.Show(): AError;
begin
  Result := 0;
end;

function TAiAgentObject.Start(): AError;
begin
  Result := 0;
end;

function TAiAgentObject.Stop(): AError;
begin
  FStatus := AgentStatusStoped;
  Result := 0;
end;

end.
