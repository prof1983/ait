{**
@Abstract(Базовый класс для создания локального AR)
@Author(Prof1983 prof1983@ya.ru)
@Created(22.09.2005)
@LastMod(04.07.2012)
@Version(0.5)
}
unit AiMain;

interface

uses
  AiAgentsObj,
  Prof_AI_Base,
  AiSourcesObj;

type
    // Базовый класс для создания локального AR
  TAiAr2006 = class(TAIFreim) // LastMod(07.01.2006)
  private
    FSources: TAiSources2006;
    FAgents: TAIAgents;
  public
    function ConfigureLoad(): Boolean; override;
    constructor Create(Source: TAISource = nil; Id: TAI_Id = 0; AConfig: TConfig = nil; ALog: TALogNode = nil);
    procedure Free(); override;
    function GetAgents(): TAIAgents;
    function GetSources(): TAISources;
    function Initialize(): Boolean; override;
    function GetAgentName(Index: Int32): String;
  public
    property Agents: TAIAgents read FAgents;
    property Sources: TAiSources2006 read FSources;
  end;
  //TAiAr = TAiAr2006;

implementation

{ TAiAr2006 }

function TAiAr2006.ConfigureLoad(): Boolean;
begin
  Result := inherited ConfigureLoad();
  if not(Result) then Exit;
  FAgents.ConfigureLoad();
  FSources.ConfigureLoad();
end;

constructor TAiAr2006.Create(Source: TAISource = nil; Id: TAI_Id = 0; AConfig: TConfig = nil; ALog: TALogNode = nil);
begin
  inherited Create(AConfig, ALog, Source, Id);
  FSources := TAISources.Create(AConfig, ALog, nil, 0);
  FAgents := TAIAgents.Create(AConfig, ALog);
end;

procedure TAiAr2006.Free();
begin
  FAgents.Free();
  FSources.Free();
  ConfigureSave();
  inherited Free();
end;

function TAiAr2006.GetAgentName(Index: Int32): String;
begin
  Result := '';
end;

function TAiAr2006.GetAgents(): TAIAgents;
begin
  Result := FAgents;
end;

function TAiAr2006.GetSources(): TAISources;
begin
  Result := FSources;
end;

function TAiAr2006.Initialize(): Boolean;
begin
  Result := inherited Initialize();
  if not(Result) then Exit;
  {ConfigureLoad(AConfig, APrefix);}
  FAgents.Initialize();
  FSources.Initialize();
end;

end.
 