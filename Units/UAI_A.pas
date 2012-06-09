{**
@Abstract(UAI_A)
@Author(Prof1983 prof1983@ya.ru)
@Created(<26.09.2004)
@LastMod(09.06.2012)
@Version(0.5)
}
unit UAI_A;

interface

uses
  AiFrameObj, AiQuestionsObj, AiSourceObj;

type
  AInfoProc = procedure(Str: String);

type
  TAiFreimBase = class(TAiFrameObject)
  public
    procedure ToHtml(const Name: string; B: Boolean);
  end;

type
  TAiFreimMethod = class(TAiFrameObject)
  private
    FName: string;
  public
    property Name: string read FName;
  end;

type
  TAiBaseMethods = class(TAiFrameObject)
  public
    function Get(Index: Integer): TAiFreimMethod;
    function GetCount(): Integer;
    function MGet(const Name: string): TAiFreimMethod;
  public
    property Count: Integer read GetCount;
  end;

type
  TAiMethods = class
  private
    FBase: TAiBaseMethods;
  public
    constructor Create();
  public
    property Base: TAiBaseMethods read FBase;
  end;

  TAiQuestions = AiQuestionsObj.TAiQuestions2004;

type
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

implementation

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

{ TAiBaseMethods }

function TAiBaseMethods.Get(Index: Integer): TAiFreimMethod;
begin
  Result := nil;
end;

function TAiBaseMethods.GetCount(): Integer;
begin
  Result := 0;
end;

function TAiBaseMethods.MGet(const Name: string): TAiFreimMethod;
begin
  Result := nil;
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
 