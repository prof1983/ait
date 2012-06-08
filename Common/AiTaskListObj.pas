{**
@Abstract(AiTaskList)
@Author(Prof1983 prof1983@ya.ru)
@Created(07.06.2012)
@LastMod(08.06.2012)
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

  TAiListTask2006 = TAiTaskListObject;
  TAiListTask20050915 = TAiListTask2006;

  TAiListTask20050830 = class(TAiListTask20050915)
  private
    FList: TAiList20050830;
  public
    function DeleteByIndex(Index: UInt32): AError;
    procedure Free(); override;
    function GetList(): TAiList20050830;
    function GetTask(Index: UInt32): TAiTask20050830;
  end;

  TAiListTask20050525 = class(TAiListTask20050830)
  private
    FList: TAiList20050525;
  public
    function DeleteByIndex(Index: UInt32): AError;
    procedure Free(); override;
    function GetList(): TAiList20050525;
    function GetTask(Index: UInt32): TAiTask20050525;
  end;

implementation

{ TAiListTask20050525 }

function TAiListTask20050525.DeleteByIndex(Index: UInt32): AError;
begin
  Result := GetList.DeleteByIndex(Index);
end;

procedure TAiListTask20050525.Free();
begin
  if Assigned(FList) then FList.Free;
  FList := nil;
  inherited Free;
end;

function TAiListTask20050525.GetList(): TAiList20050525;
begin
  if not(Assigned(FList)) then
    FList := TAiList20050525.Create();
  Result := FList;
end;

function TAiListTask20050525.GetTask(Index: UInt32): TAiTask20050525;
begin
  Result := TAiTask20050525(GetList.GetItem(Index));
end;

{ TAiListTask20050830 }

function TAiListTask20050830.DeleteByIndex(Index: UInt32): AError;
begin
  Result := GetList.DeleteByIndex(Index);
end;

procedure TAiListTask20050830.Free();
begin
  if Assigned(FList) then
    FList.Free();
  FList := nil;
  inherited Free;
end;

function TAiListTask20050830.GetList(): TAiList20050830;
begin
  if not(Assigned(FList)) then
    FList := TAiList20050830.Create();
  Result := FList;
end;

function TAiListTask20050830.GetTask(Index: UInt32): TAiTask20050830;
begin
  Result := TAiTask20050830(GetList.GetItem(Index));
end;

{ TAiListTask2006 }

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
