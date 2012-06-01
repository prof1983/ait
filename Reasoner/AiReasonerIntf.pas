{**
@Abstract(Логического вывода на основе онтологии OWL)
@Author(Prof1983 prof1983@ya.ru)
@Created(07.05.2007)
@LastMod(26.04.2012)
@Version(0.5)

Prototype: org.mindswap.pellet.owlapi.Reasoner
}
unit AiReasonerIntf;

interface

uses
  AiCollection, AiOwlClassIntf,
  AiOwlDescription, AiOwlIndividual, AiOwlOntologyManager, AiOwlOntology;

type //** Логического вывода на основе онтологии OWL
  IAiReasoner = interface
    //** Возвращает классы
    function GetClasses(): IAiCollection;
    //** Возвращает __ классы
    function GetDescendantClasses(c: IAIWSOwlDescription): IAICollection;
    //** Возвращает эквивалентные классы
    function GetEquivalentClasses(c: IAIWSOwlDescription): IAICollection;
    //** Возвращает индивиды
    function GetIndividuals(clsC: IAIWSOwlDescription; direct: WordBool): IAICollection;
    //** Возвращает менеджер онтологий
    function GetManager(): IAIWSOwlOntologyManager;
    //** Возвращает свойства объекта
    function GetObjectProperties(): IAICollection;
    //** Возвращает онтологию
    function GetOntology(): IAIWSOwlOntology;
    //** Созвращяет набор оттологий
    function GetOntologies(): IAICollection;
    //** Возвращает свойства
    function GetProperties(): IAICollection;
    //** Возвращает родительские классы
    function GetSuperClasses(c: IAIWSOwlDescription): IAICollection;
    //** Возвращает менеджера онтологий
    procedure SetManager(Manager: IAIWSOwlOntologyManager);
    //** Задать онтологию
    procedure SetOntology(Ontology: IAIWSOwlOntology);

    function AllInstancesOf(c: IAIOwlClass): IAICollection;
    //** Ичистить онтологии
    procedure ClearOntologies();
    //** Возвращает потомов класса
    function DescendantClassesOf(c: IAIOwlClass): IAICollection;
    //** Возвращает потомов класса
    function DescendantClassesOfA(c: IAIWSOwlDescription): IAICollection;
    //** Возвращает эквивалентные классы
    function EquivalentClassesOf(c: IAIOwlClass): IAICollection;
    //** Возвращает эквивалентные классы
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
    //** Обновить онтологию
    procedure RefreshOntology();
    //** Возвращает родительские (super) классы указанного класса
    function SuperClassesOf(c: IAIOwlClass): IAICollection;
    //** Возвращает родительские (super) классы указанного класса
    function SuperClassesOfA(c: IAIWSOwlDescription): IAICollection;

    //** Менеджер онтологии
    property Manager: IAIWSOwlOntologyManager read GetManager write SetManager;
    //** Набор онтологий
    property Ontologies: IAICollection read GetOntologies;
    //** Онтология
    property Ontology: IAIWSOwlOntology read GetOntology write SetOntology;
  end;

implementation

end.
