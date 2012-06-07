{**
@Abstract(AiTaskList)
@Author(Prof1983 prof1983@ya.ru)
@Created(07.06.2012)
@LastMod(07.06.2012)
@Version(0.0)
}
unit AiTaskListObj;

interface

uses
  AiFrameObj, AiListObj, AiTaskObj;

type
  TAiListTask2006 = class(TAiFrameObject)
  private
    FList: TAiList2006;
  public
    function DeleteByIndex(Index: UInt32): TError;
    procedure Free; override;
    function GetList: TAiList2006;
    //function GetTask(Index: UInt32): TAiTask2006;
  end;

  TAiListTask20050915 = class(TAiListTask2006)
  private
    FList: TAiList20050915;
  public
    function DeleteByIndex(Index: UInt32): TError;
    procedure Free(); override;
    function GetList(): TAiList20050915;
    function GetTask(Index: UInt32): TAiTask20050915;
  end;

  TAiListTask20050830 = class(TAiListTask20050915)
  private
    FList: TAiList20050830;
  public
    function DeleteByIndex(Index: UInt32): TError;
    procedure Free(); override;
    function GetList(): TAiList20050830;
    function GetTask(Index: UInt32): TAiTask20050830;
  end;

  TAiListTask20050525 = class(TAiListTask20050830)
  private
    FList: TAiList20050525;
  public
    function DeleteByIndex(Index: UInt32): TError;
    procedure Free(); override;
    function GetList(): TAiList20050525;
    function GetTask(Index: UInt32): TAiTask20050525;
  end;

implementation

{ TAiListTask20050525 }

function TAiListTask20050525.DeleteByIndex(Index: UInt32): TError;
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
  if not(Assigned(FList)) then FList := TAIList.Create;
  Result := FList;
end;

function TAiListTask20050525.GetTask(Index: UInt32): TAiTask20050525;
begin
  Result := TAITask(GetList.GetItem(Index));
end;

{ TAiListTask20050830 }

function TAiListTask20050830.DeleteByIndex(Index: UInt32): TError;
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
  if not(Assigned(FList)) then FList := TAIList.Create;
  Result := FList;
end;

function TAiListTask20050830.GetTask(Index: UInt32): TAiTask20050830;
begin
  Result := TAITask(GetList.GetItem(Index));
end;

{ TAiListTask20050915 }

function TAiListTask20050915.DeleteByIndex(Index: UInt32): TError;
begin
  Result := GetList.DeleteByIndex(Index);
end;

procedure TAiListTask20050915.Free();
begin
  if Assigned(FList) then FList.Free();
  FList := nil;
  inherited Free;
end;

function TAiListTask20050915.GetList(): TAiList20050915;
begin
  if not(Assigned(FList)) then
    FList := TAiList.Create(0, 0);
  Result := FList;
end;

function TAiListTask20050915.GetTask(Index: UInt32): TAiTask20050915;
begin
  Result := TAITask(GetList.GetItem(Index));
end;

{ TAiListTask2006 }

function TAiListTask2006.DeleteByIndex(Index: UInt32): TError;
begin
  if GetList.DeleteByIndex(Index) then
    Result := 0
  else
    Result := -1;
end;

procedure TAiListTask2006.Free();
begin
  if Assigned(FList) then
    FList.Free();
  FList := nil;
  inherited Free;
end;

function TAiListTask2006.GetList(): TAiList2006;
begin
  if not(Assigned(FList)) then
    FList := TAIList.Create();
  Result := FList;
end;

{function TAIListTask.GetTask(Index: UInt32): TAITask;
begin
  Result := TAITask(GetList.GetItem(Index));
end;}

end.
