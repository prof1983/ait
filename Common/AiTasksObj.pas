{**
@Abstract(AiTasks - Задания, связанные между собой)
@Author(Prof1983 prof1983@ya.ru)
@Created(09.06.2012)
@LastMod(09.06.2012)
@Version(0.5)
}
unit AiTasksObj;

interface

uses
  AiFrameObj, AiTaskObj;

type
  TAiTasksObject = class(TAiFrameObject)
  protected
    FTasks: array of TAiTaskObject;
  public
    function AddTask(Task: TAiTaskObject): Int32;
    function GetCountTasks(): UInt32;
    function GetTask(Index: UInt32): TAiTaskObject;
  end;

implementation

{ TAiTasksObject }

function TAiTasksObject.AddTask(Task: TAiTaskObject): Int32;
begin
  Result := Length(FTasks);
  SetLength(FTasks, Result + 1);
  FTasks[Result] := Task;
end;

function TAiTasksObject.GetCountTasks(): UInt32;
begin
  Result := Length(FTasks);
end;

function TAiTasksObject.GetTask(Index: UInt32): TAiTaskObject;
begin
  if Index >= UInt32(Length(FTasks)) then
    Result := nil
  else
    Result := FTasks[Index];
end;

end.
