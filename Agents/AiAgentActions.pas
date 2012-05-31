{**
@Abstract(Форма управления действиями)
@Author(Prof1983 prof1983@ya.ru)
@Created(09.11.2005)
@LastMod(26.04.2012)
@Version(0.5)
}
unit AiAgentActions;

interface

uses
  ANodeIntf, ATypes,
  AiAgent, AiActionsForm, AiGlobals;

type
  TAIAgentActions = class(TAIAgent)
  private
    FActions: array of Integer; // Список IDs действий
    FCreated: Boolean;   // FForm создан при инициализации->должен быть удален при финализации
    FForm: TFormActions;
    function GetActionCount(): Integer;
    function GetActionID(Index: Integer): Integer;
  protected
    procedure DoDestroy(); override;
  public
    function Finalize(): TProfError; override;
    function Initialize(): TProfError; override;
  public
    property ActionCount: Integer read GetActionCount;
    property ActionIDs[Index: Integer]: Integer read GetActionID;
  end;

implementation

{ TAIAgentActions }

procedure TAIAgentActions.DoDestroy();
begin
  SetLength(FActions, 0);
  inherited DoDestroy();
end;

function TAIAgentActions.Finalize(): TProfError;
begin
  if Assigned(FForm) and (FCreated) then
  begin
    FForm.ConfigureSave();
    FForm.Finalize();
    FForm.Free();
  end;
  FForm := nil;

  Result := inherited Finalize();
end;

function TAIAgentActions.GetActionCount(): Integer;
begin
  Result := Length(FActions);
end;

function TAIAgentActions.GetActionID(Index: Integer): Integer;
begin
  Result := 0;
  if (Index >= 0) and (Index < Length(FActions)) then
    Result := FActions[Index];
end;

function TAIAgentActions.Initialize(): TProfError;
var
  ConfigForm: IProfNode;
begin
  Result := inherited Initialize();
  if not(Result = 0) then Exit;

  {if not(Assigned(FForm)) then
  begin
    if Assigned(Config) then ConfigForm := Config.GetNodeByName('FormActions') else ConfigForm := nil;
    FForm := TFormActions.Create(ConfigForm, Log);
    FForm.ConfigureLoad();
    Result := FForm.Initialize();
    if Result then
    begin
      FForm.Show();
      FCreated := True;
      FInitialized := True;
    end;
  end;}
end;

end.
