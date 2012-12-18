{**
@Abstract Главная форма агента управления заданиями
@Author Prof1983 <prof1983@ya.ru>
@Created 21.10.2005
@LastMod 18.12.2012
}
unit AiTasksForm;

interface

uses
  Classes, Controls, Dialogs, Graphics, Forms, Messages, SysUtils, Variants, Windows,
  ABase,
  ATypes,
  AiTaskListImpl, AiTaskForm, AiTasksTreeView,
  fPropertys;

type
  TFormTasks = class(TFormPropertys)
  private
    FTasks: TAITaskList;
    procedure SetTasks(Value: TAITaskList);
  public
    function Initialize(): AError; override;
  public
    constructor Create(AOwner: TComponent);
  public
    property Tasks: TAITaskList read FTasks write SetTasks;
  end;

implementation

{ TFormTasks }

constructor TFormTasks.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  AddToLog(lgGeneral, ltInformation, 'TFormTasks: Create');
end;

function TFormTasks.Initialize(): AError;
begin
  TreeView := TTasksTreeView.Create(Self);
  TTasksTreeView(TreeView).Tasks := FTasks;
  Result := inherited Initialize();
end;

procedure TFormTasks.SetTasks(Value: TAITaskList);
begin
  FTasks := Value;
  if Assigned(TreeView) then TTasksTreeView(TreeView).Tasks := FTasks;
  Refresh();
end;

end.

