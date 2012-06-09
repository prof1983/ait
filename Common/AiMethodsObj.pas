{**
@Abstract(AiMethods)
@Author(Prof1983 prof1983@ya.ru)
@Created(07.06.2012)
@LastMod(09.06.2012)
@Version(0.0)
}
unit AiMethodsObj;

interface

uses
  AiFrameObj, AiMethodObj;

type
  TAiMethodsObject = class(TAiFrameObject)
  protected
    FMethods: array of TAiMethodObject;
  public
    function GetCountMethods(): UInt32;
  end;

implementation

{ TAiMethodsObject }

function TAiMethodsObject.GetCountMethods(): UInt32;
begin
  Result := Length(FMethods);
end;

end.
