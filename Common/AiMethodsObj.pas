{**
@Abstract(AiMethods)
@Author(Prof1983 prof1983@ya.ru)
@Created(07.06.2012)
@LastMod(07.06.2012)
@Version(0.0)
}
unit AiMethodsObj;

interface

uses
  AiFrameObj, AiMethodObj;

type
  TAiMethods2006 = class(TAiFrameObject)
  private
    FMethods: array of TAiMethod2006;
  end;

  TAiMethods20050915 = class(TAiMethods2006)
  private
    FMethods: array of TAiMethod20050915;
  end;

  TAiMethods20050830 = class(TAiMethods20050915)
  private
    FMethods: array of TAiMethod20050830;
  end;

  TAiMethods20050526 = class(TAiMethods20050830)
  private
    FMethods: array of TAiMethod20050526;
  public
    function GetCountMethods: UInt32;
  end;

  TAiMethods20050525 = class(TAiMethods20050526)
  private
    FMethods: array of TAiMethod20050525;
  end;

implementation

{ TAiMethods20050526 }

function TAiMethods20050526.GetCountMethods(): UInt32;
begin
  Result := Length(FMethods);
end;

end.
