{**
@Abstract(База Знаний для ChatAgent)
@Author(Prof1983 prof1983@ya.ru)
@Created(02.05.2007)
@LastMod(27.04.2012)
@Version(0.5)
}
unit AiChatKnowledgeBaseImpl;

// TODO: Реализовать

interface

uses
  AiBase, AiFactImpl, AiOwlKnowledgeBaseImpl, AiRule; {AiTermIntf;}

type // База Знаний для ChatAgent
  TAiChatKnowledgeBase = class(TAiOwlKnowledgeBase)
  protected
    function GetFactByID(ID: TAIID): TAIFact;
    function GetRuleByID(ID: TAIID): TAIRule;
  end;

implementation

{ TAIChatKnowledgeBase }

function TAiChatKnowledgeBase.GetFactByID(ID: TAIID): TAIFact;
{var
  term: IAITerm;}
begin
  Result := nil;
  {term := Self.GetTerm(ID);
  if not(Assigned(term)) then Exit;}

  // Если этот терм является классом AIFact или является подклассом от AIFact
  //term.SubClassOf
end;

function TAiChatKnowledgeBase.GetRuleByID(ID: TAIID): TAIRule;
begin
  Result := nil;
  // ...
end;

end.
