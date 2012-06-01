{**
@Abstract()
@Author(Prof1983 prof1983@ya.ru)
@Created(01.05.2007)
@LastMod(27.04.2012)
@Version(0.5)

Prototype org.semanticweb.owl.model.OWLEntity.java,v 1.4 2005/06/10 12:20:28
}
unit AOwlEntity;

interface

uses
  {OwlOntology,} OwlOntologyObject;

//import java.io.Serializable;
//import java.util.Set;

type
  {**
  A top level interface for entities -- the primitive kinds of things
  that are found in Ontologies. OWLEntities accept visits from {@link OWLEntityVisitor OWLEntityVisitor.
  The use of the Visitor pattern (see <i>Design Patterns</i>, Gamma
  et. al. p.331) allows us to extend the functionality of the data
  structures without having to alter the underlying implementation.
  <br/>
  In general, information about subclasses of OWLEntity is held
  w.r.t. a particular {@link OWLOntology OWLOntology, and requests
  for information about an OWLEntity should be made in the context
  of an ontology or set of ontologies.
  }
  IOwlEntity = interface(IOwlOntologyObject) //extends OWLNamedObject, OWLOntologyObject
    //** Accept a visit from a visitor
    //public void accept( OWLEntityVisitor visitor ) throws OWLException;

    {**
      Returns a {@link Set Set of those all {@link
      OWLOntologyObject OWLOntologyObject instances that use this
      OWLEntity in some way. For example, for {@link OWLClass OWLClass this will include all classes that use the class in a
      superclass, or equivalent class expression.
    }
    //function GetUsage(ontology: IOwlOntology): TJavaSet;
    //public Set getUsage( OWLOntology ontology ) throws OWLException;

    {** Returns a {@link Set Set of those all {@link OWLEntity OWLEntity instances that are used by this entity in the
     * ontology. For example, for {@link OWLClass OWLClass this will
     * include all classes that are directly used in superclass or
     * equivalent class expressions. Note that if, for example a
     * disjoint class axiom stating that A and B are disjoint is added
     * to the ontology, asking A for objectsUsed will not return
     * B. Similarly for equivalences.
    }
    //public Set objectsUsed( OWLOntology ontology ) throws OWLException;
  end;

implementation

end.
