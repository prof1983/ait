{**
@Abstract(OWL class)
@Author(Prof1983 prof1983@ya.ru)
@Created(30.04.2007)
@LastMod(27.04.2012)
@Version(0.5)

Prototype: SemanticwebOwl.Model.OwlClass
}
unit AOwlClass;

interface

uses
  JavaSet,
  OwlDescription;

//import java.util.Set;

type
  {**
  An OWL Class represents a named class within an ontology. If
  "anonymous" classes are used within descriptions, then the
  appropriate description should be used. As with other examples of
  {@link OWLEntity OWLEntity, information about the OWLClass is
  held w.r.t. a particular {@link OWLOntology OWLOntology, and
  requests for information about an OWLClass should be made in
  the context of an ontology or set of ontologies.  <br/>

  @author Sean Bechhofer
  @version $Id: OWLClass.java,v 1.4 2005/06/10 12:20:28 sean_bechhofer Exp $
  }
  IOwlClass = interface(IOwlDescription) //extends OWLDescription, OWLEntity, OWLDeprecatableObject
    {**
    Returns the explicit superclasses of this class in the given ontology. Returns a
    collection of {@link OWLDescription OWLDescriptions. Each description in this list
    provides necessary conditions for class membership.
    }
    //function GetSuperClasses(o: IOwlOntology): IJavaSet;
    //public Set getSuperClasses( OWLOntology o ) throws OWLException;

    {**
    Returns the explicit superclasses of this class in any of the
    given ontologies. Each description in this list provides necessary
    conditions for class membership.
    }
    function GetSuperClasses(Ontologies: IJavaSet): IJavaSet;
    //public Set getSuperClasses( Set ontologies ) throws OWLException;

    {**
    Returns equivalent classes to this class in the given ontology. Returns a collection
    of {@link OWLFrame OWLFrames. Each frame in the list provides
    necessary and sufficient conditions for the class. There may be
    several equivalences in which case all are deemed to be equivalent.
    }
    //function GetEquivalentClasses(o: IOwlOntology): IJavaSet;
    //public Set getEquivalentClasses( OWLOntology o ) throws OWLException;

    {**
    Returns equivalent classes to this class in any of the given
    ontologies. Each description in the list provides necessary and
    sufficient conditions for the class. There may be several
    equivalences in which case all are deemed to be equivalent.
    }
    function GetEquivalentClasses(Ontologies: IJavaSet): IJavaSet;
    //public Set getEquivalentClasses( Set ontologies ) throws OWLException;

    {**
    Returns the enumerations that have been asserted as being
    equivalent to this class in any of the given ontologies. Each
    Enumeration in the collection provides an enumeration of all
    the individuals in the class. Note that if this collection
    contains more than one enumeration, then implicit equivalances
    between individuals may be being asserted.
    }
    function GetEnumerations(Ontologies: IJavaSet): IJavaSet;
    //public Set getEnumerations( Set ontologies ) throws OWLException;

    {**
    Returns the enumerations that have been asserted as being
    equivalent to this class in the given ontology. Each Enumeration in the collection
    provides an enumeration of all the individuals in the
    class. Note that if this collection contains more than one
    enumeration, then implicit equivalances between individuals may
    be being asserted.
    }
    //function GetEnumerationsA(o: IOwlOntology): IJavaSet;
    //public Set getEnumerations( OWLOntology o ) throws OWLException;
  end;

implementation

end.
