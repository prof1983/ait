{**
@Abstract(Главная форма агента управления заданиями)
@Author(Prof1983 prof1983@ya.ru)
@Created(21.10.2005)
@LastMod(04.05.2012)
@Version(0.5)
}
unit AiTasksForm;

interface

uses
  Classes, Controls, Dialogs, Graphics, Forms, Messages, SysUtils, Variants, Windows,
  ATypes,
  AiTaskListImpl, AiTaskForm, AiTasksTreeView,
  fPropertys;

type
  TFormTasks = class(TFormPropertys)
  private
    FTasks: TAITaskList;
    procedure SetTasks(Value: TAITaskList);
  public
    constructor Create(AOwner: TComponent);
    function Initialize(): WordBool; //override;
    property Tasks: TAITaskList read FTasks write SetTasks;
  end;

implementation

{ TFormTasks }

constructor TFormTasks.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  AddToLog(lgGeneral, ltInformation, 'TFormTasks: Create', []);
end;

function TFormTasks.Initialize(): WordBool;
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

