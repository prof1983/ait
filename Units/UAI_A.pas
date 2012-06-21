{**
@Abstract(UAI_A)
@Author(Prof1983 prof1983@ya.ru)
@Created(<26.09.2004)
@LastMod(21.06.2012)
@Version(0.5)
}
unit UAI_A;

interface

uses
  ABase,
  AiFrameObj, AiMethodObj, AiMethodsObj, AiQuestionsObj, AiSourceObj;

type
  AInfoProc = procedure(Str: String);

type
  TAiFreimBase = class(TAiFrameObject)
  public
    procedure ToHtml(const Name: string; B: Boolean); deprecated; // Use AiFrameObject_ToHtml()
  end;

  TAiFreimMethod = AiMethodObj.TAiMethodObject;
  TAiBaseMethods = AiMethodsObj.TAiBaseMethods;

  TAiMethods = class
  private
    FBase: TAiBaseMethods;
  public
    constructor Create();
  public
    property Base: TAiBaseMethods read FBase;
  end;

  TAiQuestions = AiQuestionsObj.TAiQuestions2004;

  TAiTasks = class
  public
    function GetCount(): Integer;
  public
    property Count: Integer read GetCount;
  end;

type
  TAI = class
  private
    FBase: TAiFreimBase;
    FMethods: TAiMethods;
    FQuestions: TAiQuestions;
    FSource: TAiSource2004;
    FTasks: TAiTasks;
  public
    constructor Create(const DataPath: string; Info: AInfoProc);
  public
    property FreimBase: TAiFreimBase read FBase;
    property Methods: TAiMethods read FMethods;
    property Questions: TAiQuestions read FQuestions;
    property Source: TAiSource2004 read FSource;
    property Tasks: TAiTasks read FTasks;
  end;

var
  AI: TAI;

function AiFrameObject_ToHtml(Frame: TAiFrameObject; const Name: APascalString; B: ABoolean): APascalString;

implementation

// --- AiFrameObject ---

function AiFrameObject_ToHtml(Frame: TAiFrameObject; const Name: APascalString; B: ABoolean): APascalString;
begin
  Result := '';
end;

{ TAI }

constructor TAI.Create(const DataPath: string; Info: AInfoProc);
begin
  inherited Create();
  FBase := TAiFreimBase.Create();
  FMethods := TAiMethods.Create();
  FQuestions := TAiQuestions.Create();
  FSource := TAiSource2004.Create();
  FTasks := TAiTasks.Create();
end;

{ TAiFreimBase }

procedure TAiFreimBase.ToHtml(const Name: string; B: Boolean);
begin
end;

{ TAiMethods }

constructor TAiMethods.Create();
begin
  inherited Create();
  FBase := TAiBaseMethods.Create();
end;

{ TAiTasks }

function TAiTasks.GetCount(): Integer;
begin
  Result := 0;
end;

end.
 