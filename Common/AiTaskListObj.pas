{**
@Abstract(AiTaskList - Список заданий)
@Author(Prof1983 prof1983@ya.ru)
@Created(07.06.2012)
@LastMod(09.06.2012)
@Version(0.5)
}
unit AiTaskListObj;

interface

uses
  ABase, AiFrameObj, AiListObj, AiTaskObj;

type
  TAiTaskListObject = class(TAiFrameObject)
  protected
    FList: TAiListObject;
  public
    function DeleteByIndex(Index: UInt32): AError;
    procedure Free; override;
    function GetList(): TAiListObject;
    function GetTask(Index: UInt32): TAiTaskObject;
  end;

implementation

{ TAiTaskListObject }

function TAiTaskListObject.DeleteByIndex(Index: UInt32): AError;
begin
  Result := GetList().DeleteByIndex(Index);
end;

procedure TAiTaskListObject.Free();
begin
  if Assigned(FList) then
    FList.Free();
  FList := nil;
  inherited Free;
end;

function TAiTaskListObject.GetList(): TAiListObject;
begin
  if not(Assigned(FList)) then
    FList := TAiListObject.Create();
  Result := FList;
end;

function TAiTaskListObject.GetTask(Index: UInt32): TAiTaskObject;
begin
  Result := TAiTaskObject(GetList.GetItem(Index));
end;

end.
