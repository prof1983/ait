{**
@Abstract(Объект AI)
@Author(Prof1983 prof1983@ya.ru)
@Created(25.09.2006)
@LastMod(12.07.2012)
@Version(0.5)
}
unit AiObjectObj;

interface

uses
  {AXml2007,} AXmlObj,
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
  protected // --- from TAiObject2006 ---
    {** События }
    FEvents: TAiEvents;
    {** Исключительные события }
    FExceptions: TAiExceptions;
    {** Методы, действия }
    FMethods: TAiMethodsObject;
      //** Свойства
    FPropertys: TAiPropertys;
      //** Свойства
    FPropertys1: TAiPropertys2006;
  public // --- from TAiObject2006 ---
    function GetEvents(): TAiEvents;
    function GetExceptions(): TAiExceptions;
    function GetMethods(): TAiMethodsObject;
    function GetPropertys(): TAiPropertys;
    function GetPropertys1(): TAiPropertys2006;
    function ToXml(Name: String): TProfXml;
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

  TAiSystem = TAiObject;

implementation

{ TAiObject }

function TAiObject.GetEvents(): TAiEvents;
begin
  Result := FEvents;
end;

function TAiObject.GetExceptions: TAiExceptions;
begin
  Result := FExceptions;
end;

function TAiObject.GetMethods(): TAiMethodsObject;
begin
  Result := FMethods;
end;

function TAiObject.GetPropertys(): TAiPropertys;
begin
  Result := FPropertys;
end;

function TAiObject.GetPropertys1(): TAiPropertys2006;
begin
  Result := FPropertys1;
end;

function TAiObject.ToXml(Name: String): TProfXml;
begin
  //Result := TProfXmlNode1.Create;
  //Result := TProfXml.Create;
  Result := nil;
end;

end.
