{**
@Abstract(OWL онтология)
@Author(Prof1983 prof1983@ya.ru)
@Created(01.05.2007)
@LastMod(27.04.2012)
@Version(0.5)

Prototype: org.semanticweb.owl
}
unit AiOwlOntology2;

interface

uses
  OwlOntology,
  AiFrame, AiOwlNamedObject;

type // OWL онтология
  IAiOwlOntology = IAiFrame;

type // OWL онтология
  TAiOwlOntology = class(TAiOwlNamedObject)
  private
    FOwlOntology: IOwlOntology;
  public
    property OwlOntology: IOwlOntology read FOwlOntology write FOwlOntology;
  end;

implementation

end.
