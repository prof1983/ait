{**
@Abstract(OWL класс)
@Author(Prof1983 prof1983@ya.ru)
@Created(07.05.2007)
@LastMod(06.03.2012)
@Version(0.5)

Prototype: org.semanticweb.owl.model.OwlClass

Является сущностью.

История версий:
0.0.1.3 - 05.07.2007
0.0.1.2 - 04.07.2007
0.0.1.1 - 25.05.2007 - Добавил Name
}
unit AiOwlClassIntf;

interface

uses
  AiCollection, AiEntityIntf;

type //** OWL класс
  IAiOwlClass = interface(IAiEntity)
    function GetName(): WideString;
    procedure SetName(Value: WideString);

    function GetSuperClasses(Ontologies: IAiCollection): IAiCollection;
    //function GetSuperClassesA(o: IOwlOntology): IJavaSet;
    function GetEquivalentClasses(Ontologies: IAiCollection): IAiCollection;
    //function GetEquivalentClassesA(o: IOwlOntology): IJavaSet;
    function GetEnumerations(Ontologies: IAiCollection): IAiCollection;
    //function GetEnumerationsA(o: IOwlOntology): IJavaSet;

    property Name: WideString read GetName write SetName;
  end;

implementation

end.
