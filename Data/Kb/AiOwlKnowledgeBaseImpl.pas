{**
@Abstract(База Знаний OWL)
@Author(Prof1983 prof1983@ya.ru)
@Created(03.05.2007)
@LastMod(27.03.2012)
@Version(0.5)

Эта база знаний предоставляет доступ к OWL фреймам.
}
unit AiOwlKnowledgeBaseImpl;

interface

uses
  ATypes,
  AiBase, AiKnowledgeBaseImpl, AiOwlClass_20070503, AiOwlKnowledgeBaseIntf,
  AiOwlOntology2;

type // База Знаний OWL
  TAiOwlKnowledgeBase = class(TAiKnowledgeBase1, IAiOwlKnowledgeBase)
  protected
    //** Идентификатор типа OwlClass
    FOwlClassTypeID: TAIID;
    //** Идентификатор типа OwlOntology
    FOwlOntologyTypeID: TAIID;
  public
    function GetOwlClass(ID: TAIID): IAIOwlClass; safecall;
    function GetOwlOntology(ID: TAIID): IAIOwlOntology; safecall;
    //function GetOwlResource(ID: TAIID): IAIOwlResource; safecall;
  end;

implementation

{ TAiOwlKnowledgeBase }

function TAiOwlKnowledgeBase.GetOwlClass(ID: TAIID): IAIOwlClass;
{var
  term: IAITerm;}
begin
  Result := nil;
  {term := GetTerm(ID);
  if not(Assigned(term)) then Exit;
  // Проверяем тип
  if term.FrameType <> FOwlClassTypeID then Exit;}
  // ...
end;

function TAiOwlKnowledgeBase.GetOwlOntology(ID: TAIID): IAIOwlOntology;
begin
  Result := nil;
  // ...
end;

end.
