{**
@Abstract(AiObjects)
@Author(Prof1983 prof1983@ya.ru)
@Created(25.05.2005)
@LastMod(21.06.2012)
@Version(0.5)
}
unit AiObjectsObj;

interface

uses
  AiFrameObj, AiObjectObj, AiXmlParamObj;

type
  TAiObjects = class(TAiFrameObject)
  private
    FObjects: array of TAiObject;
  public
    function AddObject(Value: TAiObject): Int32;
    function GetCountObjects(): UInt32;
    function GetObject(Index: UInt32): TAiObject;
    function ToXml(Name: String): TAiXmlParamObject;
  end;

implementation

{ TAiObjects }

function TAiObjects.AddObject(Value: TAiObject): Int32;
begin
  Result := Length(FObjects);
  SetLength(FObjects, Result + 1);
  FObjects[Result] := Value;
end;

function TAiObjects.GetCountObjects(): UInt32;
begin
  Result := Length(FObjects);
end;

function TAiObjects.GetObject(Index: UInt32): TAiObject;
begin
  if (Index >= Length(FObjects)) then
    Result := FObjects[Index]
  else
    Result := nil;
end;

function TAiObjects.ToXml(Name: String): TAiXmlParamObject;
{var
  I: Int32;
  Param: TAIXmlParam;}
begin
  Result := nil;
  {
  Result := TAiXmlParamObject.Create();
  if (Name = '') then
    Name := 'Objects';
  Result.SetName(Name);
  for I := 0 to High(FObjects) do
  begin
    if (FObjects[I].GetId = 0) then
    begin
      Param := FObjects[I].ToXml('Object' + cInt32ToStr(I));
      Result.AddParam(Param);
    end
    else
    begin
      Param := Result.NewParam('Object' + cInt32ToStr(I), '');
      Param.NewParam('Id', cUInt64ToStr(FObjects[I].GetId));
    end;
  end;
  }
end;

end.
