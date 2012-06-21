{**
@Abstract(Объект AI)
@Author(Prof1983 prof1983@ya.ru)
@Created(25.09.2006)
@LastMod(21.06.2012)
@Version(0.5)
}
unit AiObjectObj;

interface

uses
  AXml2007, AXmlObj,
  AiEventsObj, AiFrameObj, AiMethodsObj, AiNamedFrameObj, AiPropertyObj;

type
  TAiObject = class(TAiNamedFrameObject)
  private
    FAuthor: WideString;
    FBuildVersion: Integer;
    FCopyright: WideString;
    //FDateCreate: TDateTime;
    FDateModify: TDateTime;
    FHomePage: WideString;
    FMajorVersion: Integer;
    FMinorVersion: Integer;
    FRevisionVersion: Integer;
  public
    property Author: WideString read FAuthor write FAuthor;
    property BuildVersion: Integer read FBuildVersion write FBuildVersion;
    property Copyright: WideString read FCopyright write FCopyright;
    //property DateCreate: TDateTime read FDateCreate write FDateCreate;
    property DateModify: TDateTime read FDateModify write FDateModify;
    property HomePage: WideString read FHomePage write FHomePage;
    property MajorVersion: Integer read FMajorVersion write FMajorVersion;
    property MinorVersion: Integer read FMinorVersion write FMinorVersion;
    property RevisionVersion: Integer read FRevisionVersion write FRevisionVersion;
  end;

  TAiObject2006 = class(TAiFrameObject)
  protected
    {** События }
    FEvents: TAiEvents;
    {** Исключительные события }
    FExceptions: TAiExceptions;
    {** Методы, действия }
    FMethods: TAiMethodsObject;
  private
    {** Свойства }
    FPropertys: TAiPropertys2006;
  public
    function GetEvents(): TAiEvents;
    function GetExceptions(): TAiExceptions;
    function GetMethods(): TAiMethodsObject;
    function GetPropertys(): TAiPropertys2006;
    function ToXml(Name: String): TProfXmlNode1;
  end;

  TAiObject20050915 = class(TAiObject2006)
  protected
    {** Свойства }
    FPropertys: TAiPropertys;
  public
    function GetPropertys(): TAiPropertys;
    function ToXml(Name: String): TProfXml;
  end;

  TAiSystem = TAiObject20050915;

implementation

{ TAiObject20050915 }

function TAiObject20050915.GetPropertys(): TAiPropertys;
begin
  Result := FPropertys;
end;

function TAiObject20050915.ToXml(Name: String): TProfXml;
begin
  Result := TProfXml.Create;
end;

{ TAiObject2006 }

function TAiObject2006.GetEvents(): TAiEvents;
begin
  Result := FEvents;
end;

function TAiObject2006.GetExceptions: TAiExceptions;
begin
  Result := FExceptions;
end;

function TAiObject2006.GetMethods(): TAiMethodsObject;
begin
  Result := FMethods;
end;

function TAiObject2006.GetPropertys(): TAiPropertys2006;
begin
  Result := FPropertys;
end;

function TAiObject2006.ToXml(Name: String): TProfXmlNode1;
begin
  //Result := TProfXmlNode1.Create;
  Result := nil;
end;

end.
