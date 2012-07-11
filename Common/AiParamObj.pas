{**
@Abstract(AiParam)
@Author(Prof1983 prof1983@ya.ru)
@Created(11.07.2012)
@LastMod(11.07.2012)
@Version(0.5)
}
unit AiParamObj;

interface

uses
  ABase, AiFrameObj;

type
  TAiParam = class(TAiFrameObject)
  private
    FName: String;
  public
    function GetName(): String;
    function SetName(Value: String): AError;
  end;

implementation

{ TAiParam }

function TAiParam.GetName(): String;
begin
  Result := FName;
end;

function TAiParam.SetName(Value: String): AError;
begin
  FName := Value;
  Result := 0;
end;

end.
