{**
@Abstract(AiMethods)
@Author(Prof1983 prof1983@ya.ru)
@Created(07.06.2012)
@LastMod(21.06.2012)
@Version(0.5)
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

  TAiBaseMethods = class(TAiMethodsObject)
  public
    function Get(Index: Integer): TAiMethodObject;
    function GetCount(): Integer;
    function MGet(const Name: string): TAiMethodObject;
  public
    property Count: Integer read GetCount;
  end;

implementation

{ TAiBaseMethods }

function TAiBaseMethods.Get(Index: Integer): TAiMethodObject;
begin
  Result := nil;
end;

function TAiBaseMethods.GetCount(): Integer;
begin
  Result := 0;
end;

function TAiBaseMethods.MGet(const Name: string): TAiMethodObject;
begin
  Result := nil;
end;

{ TAiMethodsObject }

function TAiMethodsObject.GetCountMethods(): UInt32;
begin
  Result := Length(FMethods);
end;

end.
