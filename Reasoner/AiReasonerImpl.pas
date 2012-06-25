{**
@Abstract(Логического вывода на основе онтологии OWL)
@Author(Prof1983 prof1983@ya.ru)
@Created(07.05.2007)
@LastMod(25.06.2012)
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
  ACollectionIntf,
  AOwlClassIntf, AOwlDescriptionIntf, AOwlIndividualIntf, AOwlOntologyIntf, AOwlOntologyManager,
  {AiCollection,} AiKnowledgeBaseIntf,
  AiReasonerIntf;

type //** Логического вывода на основе онтологии OWL
  TAIWSReasoner = class(TInterfacedObject, IAiReasoner)
  private
    // База знаний
    FKnowledgeBase: IAiKnowledgeBaseOwl;
    // Менеджер онтологии ?
    FManager: IAOwlOntologyManager;
    // Набор онтологий
    FOntologies: IACollection;
  protected
    // Возвращает классы
    function GetClasses(): IACollection;
    // Возвращает менеджер онтологий
    function GetManager(): IAOwlOntologyManager;
    function GetObjectProperties(): IACollection;
    // Возвращает онтологию
    function GetOntology(): IAOwlOntology;
    // Возвращает набор онтологий
    function GetOntologies(): IACollection;
    function GetProperties(): IACollection;
    // Задает менеджер онтологий
    procedure SetManager(Manager: IAOwlOntologyManager);
    // Задает онтологию
    procedure SetOntology(Ontology: IAOwlOntology);
  public
    function GetDescendantClasses(c: IAOwlDescription): IACollection;
    function GetEquivalentClasses(c: IAOwlDescription): IACollection;
    function GetIndividuals(ClsC: IAOwlDescription; Direct: WordBool): IACollection;
    function GetSuperClasses(c: IAOwlDescription): IACollection;
  public
    function AllInstancesOf(c: IAIOwlClass): IACollection;
    //** Очистить онтологии
    procedure ClearOntologies();
    //** Возвращает потомов класса
    function DescendantClassesOf(c: IAIOwlClass): IACollection;
    //** Возвращает потомов класса
    function DescendantClassesOfA(c: IAOwlDescription): IACollection;
    function EquivalentClassesOf(c: IAIOwlClass): IACollection;
    function EquivalentClassesOfA(c: IAOwlDescription): IACollection;
    function HasType(individual: IAOwlIndividual; AType: IAOwlDescription): WordBool;
    //** Повлечет за собой
    function IsEntailed(ont: IAOwlOntology): WordBool;
    //** Повлечет за собой
    function IsEntailedA(axioms: IACollection): WordBool;
    //** OwlIndividual является объектом класса OwlClass
    function IsInstanceOf(ind: IAOwlIndividual; c: IAIOwlClass): WordBool;
    //** Обновить
    procedure Refresh();
    //** Обновить онтологии
    procedure RefreshOntology();
    //** Возвращает родительские (super) классы указанного класса
    function SuperClassesOf(c: IAIOwlClass): IACollection;
    //** Возвращает родительские (super) классы указанного описания
    function SuperClassesOfA(c: IAOwlDescription): IACollection;
  public
    //** База знаний
    property KnowledgeBase: IAiKnowledgeBaseOwl read FKnowledgeBase write FKnowledgeBase;
    //** Менеджер онтологии
    property Manager: IAOwlOntologyManager read GetManager write SetManager;
    //** Набор онтологий
    property Ontologies: IACollection read GetOntologies;
    //** Онтология
    property Ontology: IAOwlOntology read GetOntology write SetOntology;
  end;

implementation

{ TAIWSReasoner }

function TAIWSReasoner.AllInstancesOf(c: IAIOwlClass): IACollection;
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

function TAIWSReasoner.DescendantClassesOf(c: IAIOwlClass): IACollection;
begin
  Result := nil;
  // TODO -oProf: Make
  // ...
end;

function TAIWSReasoner.DescendantClassesOfA(c: IAOwlDescription): IACollection;
begin
  Result := nil;
  // TODO -oProf: Make
  // ...
end;

function TAIWSReasoner.EquivalentClassesOf(c: IAIOwlClass): IACollection;
begin
  Result := nil;
  // TODO -oProf: Make
  // ...
end;

function TAIWSReasoner.EquivalentClassesOfA(c: IAOwlDescription): IACollection;
begin
  Result := nil;
  // TODO -oProf: Make
  // ...
end;

function TAIWSReasoner.GetClasses(): IACollection;
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

function TAIWSReasoner.GetDescendantClasses(c: IAOwlDescription): IACollection;
begin
  Result := nil;
  // TODO -oProf: Make
  // ...
end;

function TAIWSReasoner.GetEquivalentClasses(c: IAOwlDescription): IACollection;
begin
  Result := nil;
  // TODO -oProf: Make
  // ...
end;

function TAIWSReasoner.GetIndividuals(clsC: IAOwlDescription; direct: WordBool): IACollection;
begin
  Result := nil;
  // TODO -oProf: Make
  // ...
end;

function TAIWSReasoner.GetManager(): IAOwlOntologyManager;
begin
  Result := FManager;
end;

function TAIWSReasoner.GetObjectProperties(): IACollection;
begin
  Result := nil;
  // TODO -oProf: Make
  // ...
end;

function TAIWSReasoner.GetOntologies(): IACollection;
begin
  Result := FOntologies;
end;

function TAIWSReasoner.GetOntology(): IAOwlOntology;
begin
  Result := nil;
  // TODO -oProf: Make
  // ...
end;

function TAIWSReasoner.GetProperties(): IACollection;
begin
  Result := nil;
  // TODO -oProf: Make
  // ...
end;

function TAIWSReasoner.GetSuperClasses(c: IAOwlDescription): IACollection;
begin
  Result := nil;
  // TODO -oProf: Make
  // ...
end;

function TAIWSReasoner.HasType(individual: IAOwlIndividual; AType: IAOwlDescription): WordBool;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIWSReasoner.IsEntailed(ont: IAOwlOntology): WordBool;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIWSReasoner.IsEntailedA(axioms: IACollection): WordBool;
begin
  Result := False;
  // TODO -oProf: Make
  // ...
end;

function TAIWSReasoner.IsInstanceOf(ind: IAOwlIndividual; c: IAIOwlClass): WordBool;
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

procedure TAIWSReasoner.SetManager(Manager: IAOwlOntologyManager);
begin
  FManager := Manager;
end;

procedure TAIWSReasoner.SetOntology(Ontology: IAOwlOntology);
begin
  // TODO -oProf: Make
  // ...
end;

function TAIWSReasoner.SuperClassesOf(c: IAIOwlClass): IACollection;
begin
  Result := nil;
  // TODO -oProf: Make
  // ...
end;

function TAIWSReasoner.SuperClassesOfA(c: IAOwlDescription): IACollection;
begin
  Result := nil;
  // TODO -oProf: Make
  // ...
end;

end.
