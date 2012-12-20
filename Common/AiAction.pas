{**
@Abstract Действия
@Author Prof1983 <prof1983@ya.ru>
@Created 07.06.2006
@LastMod 20.12.2012
}
unit AiAction;

interface

uses
  Classes,
  AiAssociation, AiFrameImpl, AiNamedFrameImpl;

type //** Действие
  TAIAction = class(TAiNamedFrame) // 144
  private
    FBody: TStrings;
  public
    property Body: TStrings read FBody write FBody;
  end;

type //** Действия, связанные между собой. Одновременные действия.
  TAIActions = class(TAiFrame)
  private
    FActions: array of TAIAction;
    FAssociations: array of TAIAssociation;
  public
    function GetAction(Index: Integer): TAIAction;
    function GetAssociation(Index: Integer): TAIAssociation;
    function GetCountActions: Integer;
    function GetCountAssociations: Integer;
  end;

implementation

{ TAIActions }

function TAIActions.GetAction(Index: Integer): TAIAction;
begin
  if (Index >= Length(FActions)) then
    Result := nil
  else
    Result := FActions[Index];
end;

function TAIActions.GetAssociation(Index: Integer): TAIAssociation;
begin
  if (Index >= Length(FAssociations)) then
    Result := nil
  else
    Result := FAssociations[Index];
end;

function TAIActions.GetCountActions(): Integer;
begin
  Result := Length(FActions);
end;

function TAIActions.GetCountAssociations(): Integer;
begin
  Result := Length(FAssociations);
end;

end.
