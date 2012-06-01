{**
@Abstract(Логического вывода на основе онтологии OWL)
@Author(Prof1983 prof1983@ya.ru)
@Created(07.05.2007)
@LastMod(26.04.2012)
@Version(0.5)

Prototype: org.mindswap.pellet.owlapi.Reasoner

Использовать Reasoner можно примерно так:

procedure PelletRun();
var
  t: TPelletTimer;
begin
  try
    t := TPelletTimer.Create();
    t.Name := 'TotalTime';
    LoadQuery();
    LoadInput();
    CheckSpecies();
    if (FLoaded) then
    begin
      CheckConsistency();
      CheckConclusions();
      DoClassify();
      CheckUnsat();
      ExecQuery();
      // ...
    end;
  except
  end;
end;

История версий
0.0.2.0 - 04.06.2007
- Решил разделить понятия "База Знаний" (FKnowledgeBase) и
  рабочий список объектов, фактов и правил (хранится и принадлежит FOntologies)
}
unit AiReasonerImpl;

interface

uses
  AiCollection, AiKnowledgeBaseIntf, AiOwlClassIntf, AiOwlDescription,
  AiOwlIndividual, AiOwlOntology, AiOwlOntologyManager, AiReasonerIntf;

type //** Логического вывода на основе онтологии OWL
  TAIWSReasoner = class(TInterfacedObject, IAiReasoner)
  private
    // База знаний
    FKnowledgeBase: IAIKnowledgeBase;
    // Менеджер онтологии ?
    FManager: IAIWSOwlOntologyManager;
    // Набор онтологий
    FOntologies: IAICollection;
  protected
    // Возвращает классы
    function GetClasses(): IAICollection;
    // Возвращает менеджер онтологий
    function GetManager(): IAIWSOwlOntologyManager;
    function GetObjectProperties(): IAICollection;
    // Возвращает онтологию
    function GetOntology(): IAIWSOwlOntology;
    // Возвращает набор онтологий
    function GetOntologies(): IAICollection;
    function GetProperties(): IAICollection;
    // Задает менеджер онтологий
    procedure SetManager(Manager: IAIWSOwlOntologyManager);
    // Задает онтологию
    procedure SetOntology(Ontology: IAIWSOwlOntology);
  public
    function GetDescendantClasses(c: IAIWSOwlDescription): IAICollection;
    function GetEquivalentClasses(c: IAIWSOwlDescription): IAICollection;
    function GetIndividuals(clsC: IAIWSOwlDescription; direct: WordBool): IAICollection;
    function GetSuperClasses(c: IAIWSOwlDescription): IAICollection;
  public
    function AllInstancesOf(c: IAIOwlClass): IAICollection;
    //** Очистить онтологии
    procedure ClearOntologies();
    //** Возвращает потомов класса
    function DescendantClassesOf(c: IAIOwlClass): IAICollection;
    //** Возвращает потомов класса
    function DescendantClassesOfA(c: IAIWSOwlDescription): IAICollection;
    function EquivalentClassesOf(c: IAIOwlClass): IAICollection;
    function EquivalentClassesOfA(c: IAIWSOwlDescription): IAICollection;
    function HasType(individual: IAIWSOwlIndividual; AType: IAIWSOwlDescription): WordBool;
    //** Повлечет за собой
    function IsEntailed(ont: IAIWSOwlOntology): WordBool;
    //** Повлечет за собой
    function IsEntailedA(axioms: IAICollection): WordBool;
    //** OwlIndividual является объектом класса OwlClass
    function IsInstanceOf(ind: IAIWSOwlIndividual; c: IAIOwlClass): WordBool;
    //** Обновить
    procedure Refresh();
    //** Обновить онтологии
    procedure RefreshOntology();
    //** Возвращает родительские (super) классы указанного класса
    function SuperClassesOf(c: IAIOwlClass): IAICollection;
    //** Возвращает родительские (super) классы указанного описания
    function SuperClassesOfA(c: IAIWSOwlDescription): IAICollection;
  public
    //** База знаний
    property KnowledgeBase: IAIKnowledgeBase read FKnowledgeBase write FKnowledgeBase;
    //** Менеджер онтологии
    property Manager: IAIWSOwlOntologyManager read GetManager write SetManager;
    //** Набор онтологий
    property Ontologies: IAICollection read GetOntologies;
    //** Онтология
    property Ontology: IAIWSOwlOntology read GetOntology write SetOntology;
  end;

implementation

{ TAIWSReasoner }

function TAIWSReasoner.AllInstancesOf(c: IAIOwlClass): IAICollection;
begin
  Result := nil;
  // TODO -oProf: Make
  // ...
end;

procedure TAIWSReasoner.ClearOntologies();
begin
  // TODO -oProf: Make
  // ...
end;

function TAIWSReasoner.DescendantClassesOf(c: IAIOwlClass): IAICollection;
begin
  Result := nil;
  // TODO -oProf: Make
  // ...
end;

function TAIWSReasoner.DescendantClassesOfA(c: IAIWSOwlDescription): IAICollection;
begin
  Result := nil;
  // TODO -oProf: Make
  // ...
end;

function TAIWSReasoner.EquivalentClassesOf(c: IAIOwlClass): IAICollection;
begin
  Result := nil;
  // TODO -oProf: Make
  // ...
end;

function TAIWSReasoner.EquivalentClassesOfA(c: IAIWSOwlDescription): IAICollection;
begin
  Result := nil;
  // TODO -oProf: Make
  // ...
end;

function TAIWSReasoner.GetClasses(): IAICollection;
begin
  //Result := nil;
  Result := FKnowledgeBase.GetClasses();

  // TODO -oProf: Make
  // ...


	//public Set getClasses()
  (*
		try
    {
			return toOWLEntitySet(kb.getClasses(), OWLClass.class);
		}
    catch (OWLException e)
    {
			e.printStackTrace();
		}

		return Collections.EMPTY_SET;
	*)
end;

function TAIWSReasoner.GetDescendantClasses(c: IAIWSOwlDescription): IAICollection;
begin
  Result := nil;
  // TODO -oProf: Make
  // ...
end;

function TAIWSReasoner.GetEquivalentClasses(c: IAIWSOwlDescription): IAICollection;
begin
  Result := nil;
  // TODO -oProf: Make
  // ...
end;

function TAIWSReasoner.GetIndividuals(clsC: IAIWSOwlDescription; direct: WordBool): IAICollection;
begin
  Result := nil;
  // TODO -oProf: Make
  // ...
end;

function TAIWSReasoner.GetManager(): IAIWSOwlOntologyManager;
begin
  Result := FManager;
end;

function TAIWSReasoner.GetObjectProperties(): IAICollection;
begin
  Result := nil;
  // TODO -oProf: Make
  // ...
end;

function TAIWSReasoner.GetOntologies(): IAICollection;
begin
  Result := FOntologies;
end;

function TAIWSReasoner.GetOntology(): IAIWSOwlOntology;
begin
  Result := nil;
  // TODO -oProf: Make
  // ...
end;

function TAIWSReasoner.GetProperties(): IAICollection;
begin
  Result := nil;
  // TODO -oProf: Make
  // ...
end;

function TAIWSReasoner.GetSuperClasses(c: IAIWSOwlDescription): IAICollection;
begin
  Result := nil;
  // TODO -oProf: Make
  // ...
end;

function TAIWSReasoner.HasType(individual: IAIWSOwlIndividual; AType: IAIWSOwlDescription): WordBool;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIWSReasoner.IsEntailed(ont: IAIWSOwlOntology): WordBool;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIWSReasoner.IsEntailedA(axioms: IAICollection): WordBool;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIWSReasoner.IsInstanceOf(ind: IAIWSOwlIndividual; c: IAIOwlClass): WordBool;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

procedure TAIWSReasoner.Refresh();
begin
  // TODO -oProf: Make
  // ...
end;

procedure TAIWSReasoner.RefreshOntology();
begin
  Refresh();
end;

procedure TAIWSReasoner.SetManager(Manager: IAIWSOwlOntologyManager);
begin
  FManager := Manager;
end;

procedure TAIWSReasoner.SetOntology(Ontology: IAIWSOwlOntology);
begin
  // TODO -oProf: Make
  // ...
end;

function TAIWSReasoner.SuperClassesOf(c: IAIOwlClass): IAICollection;
begin
  Result := nil;
  // TODO -oProf: Make
  // ...
end;

function TAIWSReasoner.SuperClassesOfA(c: IAIWSOwlDescription): IAICollection;
begin
  Result := nil;
  // TODO -oProf: Make
  // ...
end;

end.
