{**
@Abstract(TaskTreeView)
@Author(Prof1983 <prof1983@ya.ru>)
@Created(21.10.2005)
@LastMod(13.07.2012)
}
unit AiTasksTreeView;

interface

uses
  ATreeView,
  AiTaskListImpl;

type
  TTasksTreeView = class(TProfTreeView)
  private
    FTasks: TAiTaskList;
  public
    property Tasks: TAiTaskList read FTasks write FTasks;
  end;

implementation

end.

