{**
@Abstract AiTask
@Author Prof1983 <prof1983@ya.ru>
@Created 07.06.2012
@LastMod 15.12.2012
}
unit AiTaskObj;

interface

uses
  ABase, ABaseUtils2, ATypes, AXmlObj,
  AiBase, AiFrameObj, AiMethodsObj;

type
  TAiTaskObject = class(TAiFrameObject)
  protected
    FComent: String;
    FDTStart: TDateTime;
    FDTEnd: TDateTime;
    FMethods: TAiMethodsObject;
    FName: String;
    FPriority: UInt32;
    FTimeImplementation: UInt64;
    FTitle: String;
    FText: String;
  public
    function GetComent(): String;
    function GetDateTimeEnd(): TDateTime;
    function GetDateTimeStart(): TDateTime;
    function GetMethods(): TAiMethodsObject;
    function GetName(): String;
    function GetPriority(): UInt32;
    function GetText(): String;
    function GetTimeImplementation(): UInt64;
    function GetTitle(): String;
    function Initialize(): AError; override;
    function LoadFromXml(Xml: TProfXml): AError; override;
    function SetComent(Value: String): AError;
    function SetDateTimeEnd(Value: TDateTime): AError;
    function SetDateTimeStart(Value: TDateTime): AError;
    function SetMethods(Value: TAiMethodsObject): AError;
    function SetName(Value: String): AError;
    function SetPriority(Value: UInt32): AError;
    function SetText(Value: String): AError;
    function SetTimeImplementation(Value: UInt64): AError;
    function SetTitle(Value: String): AError;
  end;

implementation

uses
  AiSourceObj;

{ TAiTaskObject }

function TAiTaskObject.GetComent(): String;
begin
  Result := FComent;
end;

function TAiTaskObject.GetDateTimeEnd(): TDateTime;
begin
  Result := FDTEnd;
end;

function TAiTaskObject.GetDateTimeStart(): TDateTime;
begin
  Result := FDTStart;
end;

function TAiTaskObject.GetMethods(): TAiMethodsObject;
begin
  Result := FMethods;
end;

function TAiTaskObject.GetName(): String;
begin
  Result := FName;
end;

function TAiTaskObject.GetPriority(): UInt32;
begin
  Result := FPriority;
end;

function TAiTaskObject.GetText(): String;
begin
  Result := FText;
end;

function TAiTaskObject.GetTimeImplementation(): UInt64;
begin
  Result := FTimeImplementation;
end;

function TAiTaskObject.GetTitle(): String;
begin
  Result := FTitle;
end;

function TAiTaskObject.Initialize(): AError;
var
  Source: TAiSourceObject;
begin
  Result := inherited Initialize;
  if not(Assigned(FMethods)) then
  begin
    Source := TObject(GetSource) as TAiSourceObject;
    FMethods := TAiMethodsObject.Create(Source.GetId(), 0);
    if Assigned(Source) then
      {Source.NewFreim(FMethods);}
      Source.NewFreim(0);
  end;
  FMethods.Initialize;
end;

function TAiTaskObject.LoadFromXml(Xml: TProfXml): AError;
begin
  Result := inherited LoadFromXml(Xml);
  Xml.ReadParamValueByName('Coment', FComent);
  Xml.ReadParamValueByNameAsDateTime('DateTimeEnd', FDTEnd);
  Xml.ReadParamValueByNameAsDateTime('DateTimeStart', FDTStart);
  {FMethods}
  {...}
end;

function TAiTaskObject.SetComent(Value: String): AError;
begin
  FComent := Value;
  Result := 0;
end;

function TAiTaskObject.SetDateTimeEnd(Value: TDateTime): AError;
begin
  FDTEnd := Value;
  Result := 0;
end;

function TAiTaskObject.SetDateTimeStart(Value: TDateTime): AError;
begin
  FDTStart := Value;
  Result := 0;
end;

function TAiTaskObject.SetMethods(Value: TAiMethodsObject): AError;
begin
  FMethods := Value;
  Result := 0;
end;

function TAiTaskObject.SetName(Value: String): AError;
begin
  FName := Value;
  Result := 0;
end;

function TAiTaskObject.SetPriority(Value: UInt32): AError;
begin
  FPriority := Value;
  Result := 0;
end;

function TAiTaskObject.SetText(Value: String): AError;
begin
  FText := Value;
  Result := 0;
end;

function TAiTaskObject.SetTimeImplementation(Value: UInt64): AError;
begin
  FTimeImplementation := Value;
  Result := 0;
end;

function TAiTaskObject.SetTitle(Value: String): AError;
begin
  FTitle := Value;
  Result := 0;
end;

end.
