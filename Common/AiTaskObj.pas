{**
@Abstract(AiTask)
@Author(Prof1983 prof1983@ya.ru)
@Created(07.06.2012)
@LastMod(07.06.2012)
@Version(0.5)
}
unit AiTaskObj;

interface

uses
  ABaseUtils2, ATypes, AXmlObj,
  AiBase, AiFrameObj, AiMethodsObj;

type
  TAiTask20050915 = class(TAiFrameObject)
  private
    FComent: String;
    FDTStart: TDateTime;
    FDTEnd: TDateTime;
    FMethods: TAiMethods20050915;
    FName: String;
    FPriority: UInt32;
    FTimeImplementation: UInt64;
    FTitle: String;
    FText: String;
  public
    function GetComent(): String;
    function GetDateTimeEnd(): TDateTime;
    function GetDateTimeStart(): TDateTime;
    function GetMethods(): TAiMethods20050915;
    function GetName(): String;
    function GetPriority(): UInt32;
    function GetText(): String;
    function GetTimeImplementation(): UInt64;
    function GetTitle(): String;
    function Initialize(): TError; override;
    function LoadFromXml(Xml: TProfXml): TError; override;
    function SetComent(Value: String): TError;
    function SetDateTimeEnd(Value: TDateTime): TError;
    function SetDateTimeStart(Value: TDateTime): TError;
    function SetMethods(Value: TAiMethods20050915): TError;
    function SetName(Value: String): TError;
    function SetPriority(Value: UInt32): TError;
    function SetText(Value: String): TError;
    function SetTimeImplementation(Value: UInt64): TError;
    function SetTitle(Value: String): TError;
  end;

  TAiTask20050830 = class(TAiTask20050915)
  private
    FComent: String;
    FDTStart: TDateTime;
    FDTEnd: TDateTime;
    FMethods: TAiMethods20050830;
    FName: String;
    FPriority: UInt32;
    FTimeImplementation: UInt64;
    FTitle: String;
    FText: String;
  public
    function GetComent(): String;
    function GetDateTimeEnd(): TDateTime;
    function GetDateTimeStart(): TDateTime;
    function GetMethods(): TAiMethods20050830;
    function GetName(): String;
    function GetPriority(): UInt32;
    function GetText(): String;
    function GetTimeImplementation(): UInt64;
    function GetTitle(): String;
    function Initialize(): TError; override;
    function LoadFromXml(Xml: TProfXml): TError; override;
    function SetComent(Value: String): TError;
    function SetDateTimeEnd(Value: TDateTime): TError;
    function SetDateTimeStart(Value: TDateTime): TError;
    function SetMethods(Value: TAiMethods20050830): TError;
    function SetName(Value: String): TError;
    function SetPriority(Value: UInt32): TError;
    function SetText(Value: String): TError;
    function SetTimeImplementation(Value: UInt64): TError;
    function SetTitle(Value: String): TError;
  end;

  TAiTask20050526 = class(TAiTask20050830)
  private
    FComent: String;
    FDTStart: TDateTime;
    FDTEnd: TDateTime;
    FMethods: TAiMethods20050526;
    FName: String;
    FPriority: UInt32;
    FTimeImplementation: UInt64;
    FTitle: String;
    FText: String;
  public
    constructor Create(Source: AiSourceObject2005; Id: TAId);
    function GetComent(): String;
    function GetDateTimeEnd(): TDateTime;
    function GetDateTimeStart(): TDateTime;
    function GetMethods(): TAiMethods20050526;
    function GetName(): String;
    function GetPriority(): UInt32;
    function GetText(): String;
    function GetTimeImplementation(): UInt64;
    function GetTitle(): String;
    function Initialize(): TError; override;
    function SetComent(Value: String): TError;
    function SetDateTimeEnd(Value: TDateTime): TError;
    function SetDateTimeStart(Value: TDateTime): TError;
    function SetMethods(Value: TAiMethods20050526): TError;
    function SetName(Value: String): TError;
    function SetPriority(Value: UInt32): TError;
    function SetText(Value: String): TError;
    function SetTimeImplementation(Value: UInt64): TError;
    function SetTitle(Value: String): TError;
  end;

  TAiTask20050525 = class(TAiTask20050526)
  private
    FComent: String;
    FDTStart: TDateTime;
    FDTEnd: TDateTime;
    FMethods: TAiMethods20050525;
    FName: String;
    FPriority: UInt32;
    FTimeImplementation: UInt64;
    FTitle: String;
    FText: String;
  public
    constructor Create(Source: AiSource2005; Id: TAId = 0);
    function GetComent(): String;
    function GetDateTimeEnd(): TDateTime;
    function GetDateTimeStart(): TDateTime;
    function GetMethods(): TAiMethods20050525;
    function GetName(): String;
    function GetPriority(): UInt32;
    function GetText(): String;
    function GetTimeImplementation(): UInt64;
    function GetTitle(): String;
    function Initialize(): TError; override;
    function LoadFromXml(Xml: TProfXml): TError; override;
    function SetComent(Value: String): TError;
    function SetDateTimeEnd(Value: TDateTime): TError;
    function SetDateTimeStart(Value: TDateTime): TError;
    function SetMethods(Value: TAiMethods20050525): TError;
    function SetName(Value: String): TError;
    function SetPriority(Value: UInt32): TError;
    function SetText(Value: String): TError;
    function SetTimeImplementation(Value: UInt64): TError;
    function SetTitle(Value: String): TError;
  end;

implementation

uses
  AiSourceObj;

{ TAiTask20050525 }

constructor TAiTask20050525.Create(Source: AiSource2005; Id: TAId = 0);
begin
  inherited Create(Source, Id);
end;

function TAiTask20050525.GetComent(): String;
begin
  Result := FComent;
end;

function TAiTask20050525.GetDateTimeEnd(): TDateTime;
begin
  Result := FDTEnd;
end;

function TAiTask20050525.GetDateTimeStart(): TDateTime;
begin
  Result := FDTStart;
end;

function TAiTask20050525.GetMethods(): TAiMethods20050525;
begin
  Result := FMethods;
end;

function TAiTask20050525.GetName(): String;
begin
  Result := FName;
end;

function TAiTask20050525.GetPriority(): UInt32;
begin
  Result := FPriority;
end;

function TAiTask20050525.GetText(): String;
begin
  Result := FText;
end;

function TAiTask20050525.GetTimeImplementation(): UInt64;
begin
  Result := FTimeImplementation;
end;

function TAiTask20050525.GetTitle(): String;
begin
  Result := FTitle;
end;

function TAiTask20050525.Initialize(): TError;
var
  Source: TAiSource2005;
begin
  Result := inherited Initialize;
  if not(Assigned(FMethods)) then
  begin
    Source := TObject(GetSource) as TAiSource2005;
    FMethods := TAiMethods20050525.Create(AiSource2005(Source), 0);
    if Assigned(Source) then
      {Source.NewFreim(FMethods);}
      Source.NewFreim(0);
  end;
  FMethods.Initialize;
end;

function TAiTask20050525.LoadFromXml(Xml: TProfXml): TError;
begin
  Result := inherited LoadFromXml(Xml);
  FComent := Xml.GetParamValueByName('Coment');
  FDTEnd := cStrToDateTime(Xml.GetParamValueByName('DateTimeEnd'));
  FDTStart := cStrToDateTime(Xml.GetParamValueByName('DateTimeStart'));
  {FMethods}
  {...}
end;

function TAiTask20050525.SetComent(Value: String): TError;
begin
  FComent := Value;
  Result := 0;
end;

function TAiTask20050525.SetDateTimeEnd(Value: TDateTime): TError;
begin
  FDTEnd := Value;
  Result := 0;
end;

function TAiTask20050525.SetDateTimeStart(Value: TDateTime): TError;
begin
  FDTStart := Value;
  Result := 0;
end;

function TAiTask20050525.SetMethods(Value: TAiMethods20050525): TError;
begin
  FMethods := Value;
  Result := 0;
end;

function TAiTask20050525.SetName(Value: String): TError;
begin
  FName := Value;
  Result := 0;
end;

function TAiTask20050525.SetPriority(Value: UInt32): TError;
begin
  FPriority := Value;
  Result := 0;
end;

function TAiTask20050525.SetText(Value: String): TError;
begin
  FText := Value;
  Result := 0;
end;

function TAiTask20050525.SetTimeImplementation(Value: UInt64): TError;
begin
  FTimeImplementation := Value;
  Result := 0;
end;

function TAiTask20050525.SetTitle(Value: String): TError;
begin
  FTitle := Value;
  Result := 0;
end;

{ TAiTask20050526 }

constructor TAiTask20050526.Create(Source: AiSource2005; Id: TAId);
begin
  inherited Create(Source, Id);
end;

function TAiTask20050526.GetComent(): String;
begin
  Result := FComent;
end;

function TAiTask20050526.GetDateTimeEnd(): TDateTime;
begin
  Result := FDTEnd;
end;

function TAiTask20050526.GetDateTimeStart(): TDateTime;
begin
  Result := FDTStart;
end;

function TAiTask20050526.GetMethods(): TAiMethods20050526;
begin
  Result := FMethods;
end;

function TAiTask20050526.GetName(): String;
begin
  Result := FName;
end;

function TAiTask20050526.GetPriority(): UInt32;
begin
  Result := FPriority;
end;

function TAiTask20050526.GetText(): String;
begin
  Result := FText;
end;

function TAiTask20050526.GetTimeImplementation(): UInt64;
begin
  Result := FTimeImplementation;
end;

function TAiTask20050526.GetTitle(): String;
begin
  Result := FTitle;
end;

function TAiTask20050526.Initialize(): TError;
var
  Source: AiSource2005;
begin
  Result := inherited Initialize;
  if not(Assigned(FMethods)) then
  begin
    Source := GetSource;
    FMethods := TAiMethods20050526.Create(Source, 0);
    {
    if Assigned(Source) then
      Source.NewFreim(FMethods);
    }
  end;
  FMethods.Initialize;
end;

function TAiTask20050526.SetComent(Value: String): TError;
begin
  FComent := Value;
  Result := 0;
end;

function TAiTask20050526.SetDateTimeEnd(Value: TDateTime): TError;
begin
  FDTEnd := Value;
  Result := 0;
end;

function TAiTask20050526.SetDateTimeStart(Value: TDateTime): TError;
begin
  FDTStart := Value;
  Result := 0;
end;

function TAiTask20050526.SetMethods(Value: TAiMethods20050526): TError;
begin
  FMethods := Value;
  Result := 0;
end;

function TAiTask20050526.SetName(Value: String): TError;
begin
  FName := Value;
  Result := 0;
end;

function TAiTask20050526.SetPriority(Value: UInt32): TError;
begin
  FPriority := Value;
  Result := 0;
end;

function TAiTask20050526.SetText(Value: String): TError;
begin
  FText := Value;
  Result := 0;
end;

function TAiTask20050526.SetTimeImplementation(Value: UInt64): TError;
begin
  FTimeImplementation := Value;
  Result := 0;
end;

function TAiTask20050526.SetTitle(Value: String): TError;
begin
  FTitle := Value;
  Result := 0;
end;

{ TAiTask20050830 }

function TAiTask20050830.GetComent(): String;
begin
  Result := FComent;
end;

function TAiTask20050830.GetDateTimeEnd(): TDateTime;
begin
  Result := FDTEnd;
end;

function TAiTask20050830.GetDateTimeStart(): TDateTime;
begin
  Result := FDTStart;
end;

function TAiTask20050830.GetMethods(): TAiMethods20050830;
begin
  Result := FMethods;
end;

function TAiTask20050830.GetName(): String;
begin
  Result := FName;
end;

function TAiTask20050830.GetPriority(): UInt32;
begin
  Result := FPriority;
end;

function TAiTask20050830.GetText(): String;
begin
  Result := FText;
end;

function TAiTask20050830.GetTimeImplementation(): UInt64;
begin
  Result := FTimeImplementation;
end;

function TAiTask20050830.GetTitle(): String;
begin
  Result := FTitle;
end;

function TAiTask20050830.Initialize(): TError;
var
  Source: TAiSource2005;
begin
  Result := inherited Initialize;
  if not(Assigned(FMethods)) then
  begin
    Source := TObject(GetSource) as TAiSource2005;
    FMethods := TAiMethods20050830.Create(Source.GetId(), 0);
    if Assigned(Source) then
      {Source.NewFreim(FMethods);}
      Source.NewFreim(0);
  end;
  FMethods.Initialize;
end;

function TAiTask20050830.LoadFromXml(Xml: TProfXml): TError;
begin
  Result := inherited LoadFromXml(Xml);
  Xml.ReadParamValueByName('Coment', FComent);
  Xml.ReadParamValueByNameAsDateTime('DateTimeEnd', FDTEnd);
  Xml.ReadParamValueByNameAsDateTime('DateTimeStart', FDTStart);
  {FMethods}
  {...}
end;

function TAiTask20050830.SetComent(Value: String): TError;
begin
  FComent := Value;
  Result := 0;
end;

function TAiTask20050830.SetDateTimeEnd(Value: TDateTime): TError;
begin
  FDTEnd := Value;
  Result := 0;
end;

function TAiTask20050830.SetDateTimeStart(Value: TDateTime): TError;
begin
  FDTStart := Value;
  Result := 0;
end;

function TAiTask20050830.SetMethods(Value: TAiMethods20050830): TError;
begin
  FMethods := Value;
  Result := 0;
end;

function TAiTask20050830.SetName(Value: String): TError;
begin
  FName := Value;
  Result := 0;
end;

function TAiTask20050830.SetPriority(Value: UInt32): TError;
begin
  FPriority := Value;
  Result := 0;
end;

function TAiTask20050830.SetText(Value: String): TError;
begin
  FText := Value;
  Result := 0;
end;

function TAiTask20050830.SetTimeImplementation(Value: UInt64): TError;
begin
  FTimeImplementation := Value;
  Result := 0;
end;

function TAiTask20050830.SetTitle(Value: String): TError;
begin
  FTitle := Value;
  Result := 0;
end;

{ TAiTask20050915 }

function TAiTask20050915.GetComent(): String;
begin
  Result := FComent;
end;

function TAiTask20050915.GetDateTimeEnd(): TDateTime;
begin
  Result := FDTEnd;
end;

function TAiTask20050915.GetDateTimeStart(): TDateTime;
begin
  Result := FDTStart;
end;

function TAiTask20050915.GetMethods(): TAiMethods20050915;
begin
  Result := FMethods;
end;

function TAiTask20050915.GetName(): String;
begin
  Result := FName;
end;

function TAiTask20050915.GetPriority(): UInt32;
begin
  Result := FPriority;
end;

function TAiTask20050915.GetText(): String;
begin
  Result := FText;
end;

function TAiTask20050915.GetTimeImplementation(): UInt64;
begin
  Result := FTimeImplementation;
end;

function TAiTask20050915.GetTitle(): String;
begin
  Result := FTitle;
end;

function TAiTask20050915.Initialize(): TError;
var
  Source: TAiSourceObject2005;
begin
  Result := inherited Initialize;
  if not(Assigned(FMethods)) then
  begin
    Source := TObject(GetSource) as TAiSourceObject2005;
    FMethods := TAiMethods20050915.Create(Source.GetId(), 0);
    if Assigned(Source) then
      {Source.NewFreim(FMethods);}
      Source.NewFreim(0);
  end;
  FMethods.Initialize;
end;

function TAiTask20050915.LoadFromXml(Xml: TProfXml): TError;
begin
  Result := inherited LoadFromXml(Xml);
  Xml.ReadParamValueByName('Coment', FComent);
  Xml.ReadParamValueByNameAsDateTime('DateTimeEnd', FDTEnd);
  Xml.ReadParamValueByNameAsDateTime('DateTimeStart', FDTStart);
  {FMethods}
  {...}
end;

function TAiTask20050915.SetComent(Value: String): TError;
begin
  FComent := Value;
  Result := 0;
end;

function TAiTask20050915.SetDateTimeEnd(Value: TDateTime): TError;
begin
  FDTEnd := Value;
  Result := 0;
end;

function TAiTask20050915.SetDateTimeStart(Value: TDateTime): TError;
begin
  FDTStart := Value;
  Result := 0;
end;

function TAiTask20050915.SetMethods(Value: TAiMethods20050915): TError;
begin
  FMethods := Value;
  Result := 0;
end;

function TAiTask20050915.SetName(Value: String): TError;
begin
  FName := Value;
  Result := 0;
end;

function TAiTask20050915.SetPriority(Value: UInt32): TError;
begin
  FPriority := Value;
  Result := 0;
end;

function TAiTask20050915.SetText(Value: String): TError;
begin
  FText := Value;
  Result := 0;
end;

function TAiTask20050915.SetTimeImplementation(Value: UInt64): TError;
begin
  FTimeImplementation := Value;
  Result := 0;
end;

function TAiTask20050915.SetTitle(Value: String): TError;
begin
  FTitle := Value;
  Result := 0;
end;

end.
