{**
@Abstract(AiQuestions - Список вопросов)
@Author(Prof1983 prof1983@ya.ru)
@Created(09.06.2012)
@LastMod(09.06.2012)
@Version(0.5)
}
unit AiQuestionsObj;

interface

uses
  AiFrameObj;

type
  TAiQuestion = TAiFrameObject;

type
  TAiQuestionsObject = class(TAiFrameObject)
  private
    FQuestions: array of TAiQuestion;
  public
    function AddQuestion(Question: TAiQuestion): Int32;
    function GetCountQuestions(): UInt32;
    function GetQuestion(Index: UInt32): TAiQuestion;
  end;

  TAiQuestions20050915 = TAiQuestionsObject;

  TAiQuestions20050830 = class(TAiQuestions20050915)
  private
    FQuestions: array of TAiQuestion;
  public
    function AddQuestion(Question: TAiQuestion): Int32;
    function GetCountQuestions(): UInt32;
    function GetQuestion(Index: UInt32): TAiQuestion;
  end;

  TAiQuestions20050526 = class(TAiQuestions20050830)
  private
    FQuestions: array of TAiQuestion;
  public
    function AddQuestion(Question: TAiQuestion): Int32;
    function GetCountQuestions(): UInt32;
    function GetQuestion(Index: UInt32): TAiQuestion;
  end;

  TAiQuestions20050525 = class(TAiQuestions20050526)
  private
    FQuestions: array of TAiQuestion;
  public
    function AddQuestion(Question: TAiQuestion): Int32;
    function GetCountQuestions(): UInt32;
    function GetQuestion(Index: UInt32): TAiQuestion;
  end;

  TAiQuestions2004 = class(TAiQuestions20050525)
  public
    function GetCount(): Integer;
  public
    property Count: Integer read GetCount;
  end;

implementation

{ TAiQuestions2004 }

function TAiQuestions2004.GetCount(): Integer;
begin
  Result := 0;
end;

{ TAiQuestions20050525 }

function TAiQuestions20050525.AddQuestion(Question: TAIQuestion): Int32;
begin
  Result := Length(FQuestions);
  SetLength(FQuestions, Result + 1);
  FQuestions[Result] := Question;
end;

function TAiQuestions20050525.GetCountQuestions(): UInt32;
begin
  Result := Length(FQuestions);
end;

function TAiQuestions20050525.GetQuestion(Index: UInt32): TAIQuestion;
begin
  if Index >= UInt32(Length(FQuestions)) then
    Result := nil
  else
    Result := FQuestions[Index];
end;

{ TAiQuestions20050526 }

function TAiQuestions20050526.AddQuestion(Question: TAIQuestion): Int32;
begin
  Result := Length(FQuestions);
  SetLength(FQuestions, Result + 1);
  FQuestions[Result] := Question;
end;

function TAiQuestions20050526.GetCountQuestions(): UInt32;
begin
  Result := Length(FQuestions);
end;

function TAiQuestions20050526.GetQuestion(Index: UInt32): TAIQuestion;
begin
  if Index >= UInt32(Length(FQuestions)) then
    Result := nil
  else
    Result := FQuestions[Index];
end;

{ TAiQuestions20050830 }

function TAiQuestions20050830.AddQuestion(Question: TAIQuestion): Int32;
begin
  Result := Length(FQuestions);
  SetLength(FQuestions, Result + 1);
  FQuestions[Result] := Question;
end;

function TAiQuestions20050830.GetCountQuestions(): UInt32;
begin
  Result := Length(FQuestions);
end;

function TAiQuestions20050830.GetQuestion(Index: UInt32): TAIQuestion;
begin
  if Index >= UInt32(Length(FQuestions)) then
    Result := nil
  else
    Result := FQuestions[Index];
end;

{ TAiQuestions20050915 }

function TAiQuestionsObject.AddQuestion(Question: TAIQuestion): Int32;
begin
  Result := Length(FQuestions);
  SetLength(FQuestions, Result + 1);
  FQuestions[Result] := Question;
end;

function TAiQuestionsObject.GetCountQuestions(): UInt32;
begin
  Result := Length(FQuestions);
end;

function TAiQuestionsObject.GetQuestion(Index: UInt32): TAIQuestion;
begin
  if Index >= UInt32(Length(FQuestions)) then
    Result := nil
  else
    Result := FQuestions[Index];
end;

end.
