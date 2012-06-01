{**
@Abstract(OWL Individual)
@Author(Prof1983 prof1983@ya.ru)
@Created(08.05.2007)
@LastMod(14.02.2012)
@Version(0.0.5)

Prototype:org.semanticweb.owl.model.OlwIndividual
}
unit AiOntologyIndividual;

interface

uses
  AiCollection;

type // OWL Individual
  IAiOntologyIndividual = interface
    function IsAnonymous: WordBool;
    function GetAnonID: WideString;
    function GetTypes(Ontologies: IAiCollection): IAiCollection;
    //function GetObjectPropertyValues(Ontologies: IAiSet): IAiMap;
    //function GetIncomingObjectPropertyValues(Ontologies: IAiSet): IAiMap;
  end;

implementation

end.
