{**
@Abstract(База Знаний OWL)
@Author(Prof1983 prof1983@ya.ru)
@Created(03.05.2007)
@LastMod(27.06.2012)
@Version(0.5)

Эта база знаний предоставляет доступ к OWL фреймам.
}
unit AiOwlKnowledgeBaseImpl;

interface

uses
  AOwlClassIntf, AOwlOntologyIntf, ATypes,
  AiBase, AiKnowledgeBaseImpl, AiOwlKnowledgeBaseIntf;

type // База Знаний OWL
  TAiOwlKnowledgeBase = class(TAiKnowledgeBase, IAiOwlKnowledgeBase)
  protected
    //** Идентификатор типа OwlClass
    FOwlClassTypeID: TAIID;
    //** Идентификатор типа OwlOntology
    FOwlOntologyTypeID: TAIID;
  public
    function GetOwlClass(ID: TAIID): IAIOwlClass; safecall;
    function GetOwlOntology(ID: TAIID): IAOwlOntology; safecall;
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

function TAiOwlKnowledgeBase.GetOwlOntology(ID: TAIID): IAOwlOntology;
begin
  Result := nil;
  // ...
end;

end.
