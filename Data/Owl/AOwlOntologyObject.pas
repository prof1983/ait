{**
@Abstract(OwlOntologyObject)
@Author(Prof1983 prof1983@ya.ru)
@Created(30.04.2007)
@LastMod(27.06.2012)
@Version(0.5)

Prototype: org.semanticweb.owl.model.OWLOntologyObject.java,v 1.3 2006/03/28 16:14:45

Все или почти все интерфейсы, которы наследуются от OwlOntologyObject
наследуются также и от OwlNamedObject. В Delphi нельзя делать множественное
наследование, поэтому Prof сделал IOwlOntologyObject наследником от IOwlNamedObject.
}
unit AOwlOntologyObject;

interface

uses
  AiSet,
  AOwlNamedObjectIntf;

//import java.io.Serializable;
//import java.util.Set;

type
  {**
  An OWLOntologyObject knows about the ontology from which it
  came. Sub interfaces of this interface include all the various
  names entities that may occur in ontologies along with axioms.
  }
  IOwlOntologyObject = interface(IOwlNamedObject) //extends Serializable
    {**
      Returns the collection of ontologies that this object is known to occur in.
      @return a <code>Set</code> value
    }
    function GetOntologies(): IJavaSet;
    //public Set getOntologies() throws OWLException;
  end;

implementation

end.
