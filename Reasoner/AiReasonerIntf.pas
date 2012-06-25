{**
@Abstract(Логического вывода на основе онтологии OWL)
@Author(Prof1983 prof1983@ya.ru)
@Created(07.05.2007)
@LastMod(25.06.2012)
@Version(0.5)

Prototype: org.mindswap.pellet.owlapi.Reasoner
}
unit AiReasonerIntf;

interface

uses
  AOwlClassIntf, AOwlDescriptionIntf, AOwlIndividualIntf, AOwlOntologyManager, AOwlOntologyIntf,
  AiCollection;

type //** Логического вывода на основе онтологии OWL
  IAiReasoner = interface
    //** Возвращает классы
    function GetClasses(): IAiCollection;
    //** Возвращает __ классы
    function GetDescendantClasses(c: IAOwlDescription): IAICollection;
    //** Возвращает эквивалентные классы
    function GetEquivalentClasses(c: IAOwlDescription): IAICollection;
    //** Возвращает индивиды
    function GetIndividuals(clsC: IAOwlDescription; direct: WordBool): IAICollection;
    //** Возвращает менеджер онтологий
    function GetManager(): IAOwlOntologyManager;
    //** Возвращает свойства объекта
    function GetObjectProperties(): IAICollection;
    //** Возвращает онтологию
    function GetOntology(): IAOwlOntology;
    //** Созвращяет набор оттологий
    function GetOntologies(): IAICollection;
    //** Возвращает свойства
    function GetProperties(): IAICollection;
    //** Возвращает родительские классы
    function GetSuperClasses(c: IAOwlDescription): IAICollection;
    //** Возвращает менеджера онтологий
    procedure SetManager(Manager: IAOwlOntologyManager);
    //** Задать онтологию
    procedure SetOntology(Ontology: IAOwlOntology);

    function AllInstancesOf(c: IAIOwlClass): IAICollection;
    //** Ичистить онтологии
    procedure ClearOntologies();
    //** Возвращает потомов класса
    function DescendantClassesOf(c: IAIOwlClass): IAICollection;
    //** Возвращает потомов класса
    function DescendantClassesOfA(c: IAOwlDescription): IAICollection;
    //** Возвращает эквивалентные классы
    function EquivalentClassesOf(c: IAIOwlClass): IAICollection;
    //** Возвращает эквивалентные классы
    function EquivalentClassesOfA(c: IAOwlDescription): IAICollection;
    function HasType(individual: IAOwlIndividual; AType: IAOwlDescription): WordBool;
    //** Повлечет за собой
    function IsEntailed(ont: IAOwlOntology): WordBool;
    //** Повлечет за собой
    function IsEntailedA(axioms: IAICollection): WordBool;
    //** OwlIndividual является объектом класса OwlClass
    function IsInstanceOf(ind: IAOwlIndividual; c: IAIOwlClass): WordBool;
    //** Обновить
    procedure Refresh();
    //** Обновить онтологию
    procedure RefreshOntology();
    //** Возвращает родительские (super) классы указанного класса
    function SuperClassesOf(c: IAIOwlClass): IAICollection;
    //** Возвращает родительские (super) классы указанного класса
    function SuperClassesOfA(c: IAOwlDescription): IAICollection;

    //** Менеджер онтологии
    property Manager: IAOwlOntologyManager read GetManager write SetManager;
    //** Набор онтологий
    property Ontologies: IAICollection read GetOntologies;
    //** Онтология
    property Ontology: IAOwlOntology read GetOntology write SetOntology;
  end;

implementation

end.
