{**
@Abstract(OwlIndividual)
@Author(Prof1983 prof1983@ya.ru)
@Created(01.05.2007)
@LastMod(27.04.2012)
@Version(0.5)

Prototype: org.semanticweb.owl.model.OWLIndividual.java,v 1.4 2006/03/28 16:14:45
}
unit AOwlIndividual;

interface

uses
  JavaMap, JavaUri, JavaSet,
  OwlEntity; //OwlOntology;

//import java.net.URI;
//import java.util.Set;
//import java.util.Map;

type
  {**
  An individual object. Each individual has a description and
  possibly an identifier. As with other examples of {@link OWLEntity OWLEntity,
  information about the OWLIndividual is held w.r.t. a
  particular {@link OWLOntology OWLOntology, and requests for
  information about an OWLIndividual should be made in the context of
  an ontology or set of ontologies.  <br/> Methods relating to
  property values return a {@link Map Map. This map will be keyed on
  the appropriate {@link OWLProperty OWLProperty (e.g. {@link
  OWLObjectProperty OWLObjectProperty or {@link OWLDataProperty OWLDataProperty. As OWLIndividuals can have multiple values
  for each property, the values in the Map are {@link Set Sets of
  the appropriate object (e.g. OWLIndividual or {@link OWLDataValue OWLDataValue).
  }
  IOwlIndividual = interface(IOwlEntity)
    {**
    Indicates whether the individual is anonymous or not. The
    whole issue of anonymous individuals will need particular
    thought and probably refactoring....
    }
    function IsAnonymous(): WordBool;
    //public boolean isAnonymous() throws OWLException;

    {**
    ANON: get the anonymous id URI
    Return the URI that identifies this anonymous individuals. These
    URI's are generated by the underlying RDF parser.
    }
    function GetAnonID(): IJavaUri;
    //public URI getAnonId();

    {**
    Returns a list of the {@link OWLDescription OWLDescriptions that
    this individual is asserted as being an instance of in the given ontology.
    }
//    function GetTypes(o: IOwlOntology): IJavaSet;
    //public Set getTypes( OWLOntology o ) throws OWLException;

    {**
    Returns a list of the {@link OWLDescription OWLDescriptions that
    this individual is asserted as being an instance of in the given ontologies.
    }
    function GetTypesA(ontologies: IJavaSet): IJavaSet;
    //public Set getTypes( Set ontologies ) throws OWLException;

    {**
    Returns a {@link Map Map which encapsulates the relationships
    between this individual and other individuals in the given
    ontology. See above for notes about the maps.
    }
//    function GetObjectPropertyValues(o: IOwlOntology): IJavaMap;
    //public Map getObjectPropertyValues( OWLOntology o ) throws OWLException;

    {**
    Returns a {@link Map Map which encapsulates the relationships
    between this individual and other individuals in the given
    ontology. See above for notes about the maps.
    }
    function GetObjectPropertyValuesA(ontologies: IJavaSet): IJavaMap;
    //public Map getObjectPropertyValues( Set ontologies ) throws OWLException;

    {**
    Returns a {@link Map Map which encapsulates the relationship
    between this individual and data values in the given ontology. See
    above for notes about the maps.
    }
//    function GetDataPropertyValues(o: IOwlOntology): IJavaMap;
    //public Map getDataPropertyValues( OWLOntology o ) throws OWLException;

    {**
    Returns a {@link Map Map which encapsulates the relationship
    between this individual and data values in the given
    ontologies. See above for notes about the maps.
    }
    function GetDataPropertyValuesA(ontologies: IJavaSet): IJavaMap;
    //public Map getDataPropertyValues( Set ontologies ) throws OWLException;

    {**
    Returns a {@link Map Map which encapsulate the relationships
    between other individuals and this individual in the given
    ontology. This is useful if we want to check properties of the
    individual graphs, for example to check that anonymous
    individuals are only involved in tree structures. See above for
    notes about the maps.
    }
    function GetIncomingObjectPropertyValues(ontologies: IJavaSet): IJavaMap;
    //public Map getIncomingObjectPropertyValues( Set ontologies ) throws OWLException;

    {**
    Returns a {@link Map Map which encapsulate the relationships
    between other individuals and this individual in the given
    ontology. This is useful if we want to check properties of the
    individual graphs, for example to check that anonymous
    individuals are only involved in tree structures. See above for
    notes about the maps.
    }
//    function GetIncomingObjectPropertyValuesA(o: IOwlOntology): IJavaMap;
    //public Map getIncomingObjectPropertyValues( OWLOntology o ) throws OWLException;
  end;

implementation

end.