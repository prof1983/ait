{**
@Abstract(Список заданий)
@Author(Prof1983 prof1983@ya.ru)
@Created(30.03.2006)
@LastMod(03.05.2012)
@Version(0.5)
}
unit AiTaskListImpl;

interface

uses
  AiFrameImpl, AiListImpl, AiTaskImpl;

type //** Список заданий
  TAITaskList = class(TAiFrame)
  private
    FList: TAIList3;
    function GetCount(): Integer;
    function GetItem(Index: Integer): TAiTask;
  protected
    procedure DoCreate(); override;
    procedure DoDestroy(); override;
  public
    function AddTask(Task: TAITask): Integer;
    property Count: Integer read GetCount;
    procedure DeleteTask(Index: Integer);
    property TaskByIndex[Index: Integer]: TAiTask read GetItem;
    property TaskCount: Integer read GetCount;
    property Tasks[Index: Integer]: TAiTask read GetItem;
  end;
  TAiTaskList3 = TAiTaskList;

type //** Задания, связанные между собой
  TAITasks3 = class(TAiFrame)
  private
    FList: TAiTaskList;
    function GetTaskCount(): Integer;
  public
    function AddTask(Task: TAITask): Integer;
    function GetTask(Index: Integer): TAiTask;
  public
    constructor Create(); override;
  public
    property TaskCount: Integer read GetTaskCount;
  end;

type //** Дерево задач
  TAITasksTree3 = class(TAiTasks3)
  private
    FTasks: array of TAiTaskNode;
  public
    procedure Free(); override;
  end;

implementation

{ TAITaskList3 }

function TAITaskList.AddTask(Task: TAITask): Integer;
begin
  Result := FList.Add(Task);
end;

function TAITaskList.GetCount(): Integer;
begin
  Result := FList.Count;
end;

procedure TAITaskList.DeleteTask(Index: Integer);
//var
//  I: Int32;
begin
  FList.DeleteByIndex(Index);

  //for I := Index to Count - 2 do FTasks.Tasks[I] := FTasks.Tasks[I + 1];
  //SetLength(FTasks, High(FTasks));
end;

procedure TAITaskList.DoCreate();
begin
  inherited DoCreate();
  FList := TAIList3.Create();
end;

procedure TAITaskList.DoDestroy();
begin
  FList := nil;
  inherited DoDestroy();
end;

function TAITaskList.GetItem(Index: Integer): TAITask;
var
  Id: Integer;
begin
  Result := nil;
  if not(Assigned(FList)) then Exit;
  Result := TAITask(FList.ItemsByIndex[Index]);
  if not(Assigned(Result)) then
  begin
    ID := FList.ItemsID[Index];
    if ID > 0 then
    begin
//      Result := TAITask.Create(TAISource(GetSource), Id);
    end;
  end;
end;

{ TAITasks }

function TAITasks3.AddTask(Task: TAITask): Integer;
begin
  Result := FList.AddTask(Task);
end;

constructor TAITasks3.Create();
begin
  inherited Create();
  Self.FList := TAiTaskList.Create();
end;

function TAITasks3.GetTask(Index: Integer): TAITask;
begin
  if (Index >= FList.TaskCount) then
    Result := nil
  else
    Result := FList.GetItem(Index);
end;

function TAITasks3.GetTaskCount(): Integer;
begin
  Result := FList.TaskCount;
end;

{ TAITasksTree }

procedure TAITasksTree3.Free();
begin
  SetLength(FTasks, 0);
  inherited Free();
end;

end.
