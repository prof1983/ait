{**
@Abstract(TaskTreeView)
@Author(Prof1983 prof1983@ya.ru)
@Created(21.10.2005)
@LastMod(04.05.2012)
@Version(0.5)
}
unit AiTasksTreeView;

interface

uses
  ATreeView,
  AiTaskListImpl;

type
  TTasksTreeView = class(TProfTreeView2006)
  private
    FTasks: TAiTaskList;
  public
    property Tasks: TAiTaskList read FTasks write FTasks;
  end;

implementation

end.

