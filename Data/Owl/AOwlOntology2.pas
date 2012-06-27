{**
@Abstract(OWL онтология)
@Author(Prof1983 prof1983@ya.ru)
@Created(01.05.2007)
@LastMod(27.06.2012)
@Version(0.5)

Prototype: org.semanticweb.owl
}
unit AiOwlOntology2;

interface

uses
  AOwlOntologyIntf,
  AiFrameComImpl;

type
  TAiOwlNamedObject = TAiFrame;

type // OWL онтология
  TAiOwlOntology = class(TAiOwlNamedObject)
  private
    FOwlOntology: IOwlOntology;
  public
    property OwlOntology: IOwlOntology read FOwlOntology write FOwlOntology;
  end;

implementation

end.
