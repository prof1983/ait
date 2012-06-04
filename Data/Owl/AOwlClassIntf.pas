{**
@Abstract(OWL класс)
@Author(Prof1983 prof1983@ya.ru)
@Created(07.05.2007)
@LastMod(04.06.2012)
@Version(0.5)

Prototype: org.semanticweb.owl.model.OwlClass

Является сущностью.

История версий:
0.0.1.3 - 05.07.2007
0.0.1.2 - 04.07.2007
0.0.1.1 - 25.05.2007 - Добавил Name
}
unit AOwlClassIntf;

interface

uses
  ACollection, AEntityIntf;

type //** OWL класс
  IAiOwlClass = interface(IAEntity)
    function GetName(): WideString;
    procedure SetName(Value: WideString);

    function GetSuperClasses(Ontologies: IACollection): IACollection;
    //function GetSuperClassesA(o: IOwlOntology): IJavaSet;
    function GetEquivalentClasses(Ontologies: IACollection): IACollection;
    //function GetEquivalentClassesA(o: IOwlOntology): IJavaSet;
    function GetEnumerations(Ontologies: IACollection): IACollection;
    //function GetEnumerationsA(o: IOwlOntology): IJavaSet;

    property Name: WideString read GetName write SetName;
  end;

implementation

end.
