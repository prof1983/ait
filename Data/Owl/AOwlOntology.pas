{**
@Abstract(OwlOntology)
@Author(Prof1983 prof1983@ya.ru)
@Created(30.04.2007)
@LastMod(27.04.2012)
@Version(0.5)

Prototype: org.semanticweb.owl.model.OWLOntology.java,v 1.2 2005/06/10 12:20:29
}
unit AOwlOntology;

interface

uses
  // java
  JavaSet, JavaUri,
  // org.semanticweb.owl
  OwlAnnotationProperty, OwlClass, OwlDataProperty, OwlDataType, OwlIndividual,
  OwlNamedObject, OwlObjectProperty;

//import java.util.List;
//import java.util.Set;

//import org.semanticweb.owl.model.change.ChangeVisitor;
//import java.net.URI;

type
  {**
  Represents an OWL ontology. An ontology comprises a number of
  collections. Each ontology has a number of classes, properties and
  individuals, along with a number of axioms asserting information
  about those objects.
  }
  IOwlOntology = interface(IOwlNamedObject)
//    public ChangeVisitor getChangeVisitor() throws OWLException;
    {**
      Processes changes in the change list.
      @param changeList                list of changes to the model
    }
//    void applyChanges(List changeList) throws OWLException;

    //** Returns a list of the classes of the ontology
    function GetClasses(): IJavaSet;
    //public Set getClasses() throws OWLException;

    {**
      getClass
      Retrieves a class with a given uri
      @param uri (String)
      @return OWLClass, null if there is no such thing
    }
    function GetClass(uri: TJavaUri): IOwlClass;
    //public OWLClass getClass(URI uri) throws OWLException;

    //** Returns a list of the annotation properties of the ontology
    function GetAnnotationProperties(): IJavaSet;
    //public Set getAnnotationProperties() throws OWLException;

    {**
    getAnnotationProperty
    Retrieves an Annotation Property with a given uri
    @param uri (String)
    @return OWLAnnotationProperty, null if there is no such thing
    }
    function GetAnnotationProperty(uri: TJavaUri): IOwlAnnotationProperty;
    //public OWLAnnotationProperty getAnnotationProperty(URI uri) throws OWLException;

    {**
    Returns a list of the datatype properties of the ontology
    (i.e. those whose range is a concrete data type).
    }
    function GetDataProperties(): IJavaSet;
    //public Set getDataProperties() throws OWLException;

    {**
     * getDataProperty
     *
     * Retrieves a DataProperty with a given uri
     * @param uri (String)
     * @return OWLDataProperty, null if there is no such thing
    }
    function GetDataProperty(uri: TJavaUri): IOwlDataProperty;
    //public OWLDataProperty getDataProperty(URI uri) throws OWLException;


    {**
    Returns a list of the object properties of the ontology
    (i.e. those whose range is a subset of the object domain.
    }
    function GetObjectProperties(): IJavaSet;
    //public Set getObjectProperties() throws OWLException;

    {**
     * getObjectProperty
     *
     * Retrieves a ObjectProperty with a given uri
     * @param uri (String)
     * @return OWLObjectProperty, null if there is no such thing
    }
    function GetObjectProperty(uri: TJavaUri): IOwlObjectProperty;
    //public OWLObjectProperty getObjectProperty(URI uri) throws OWLException;

    //** Returns a list of the individuals in the ontology
    function GetIndividuals(): IJavaSet;
    //public Set getIndividuals() throws OWLException;

    {**
      Retrieves an individual with a given uri
      @param uri (String)
      @return OWLDataProperty, returns null if it is there
    }
    function GetIndividual(uri: TJavaUri): IOwlIndividual;
    //public OWLIndividual getIndividual(URI uri) throws OWLException;


    //** Returns a list of the classes of the ontology
    function GetDatatypes(): IJavaSet;
    //public Set getDatatypes() throws OWLException;

	  {**
     * Retrieves a class with a given uri
     * @param uri (String)
     * @return OWLClass, null if there is no such thing
    }
    function GetDatatype(uri: TJavaUri): IOwlDataType;
    //public OWLDataType getDatatype(URI uri) throws OWLException;

    {**
    Returns a list of class axioms in the ontology. These include
    subclass axioms, disjointness axioms and equality axioms.
    }
    function GetClassAxioms(): IJavaSet;
    //public Set getClassAxioms() throws OWLException;

    {**
    Returns a list of the property axioms in the ontology. These
    include subproperty axioms and property equality axioms.
    }
    function GetPropertyAxioms(): IJavaSet;
    //public Set getPropertyAxioms() throws OWLException;

    {**
    Returns a list of the individual axioms in the ontology. These
    will include axioms asserting the equality and inequality of individuals.
    }
    function GetIndividualAxioms(): IJavaSet;
    //public Set getIndividualAxioms() throws OWLException;

    {**
    Returns a list of the Ontologies imported by this Ontology.
    @return Set{OWLOntology
    }
    function GetIncludedOntologies(): IJavaSet;
    //public Set getIncludedOntologies() throws OWLException;

    {**
    Returns a list of the Ontologies related via the
    owl:priorVersion property
    }
    function GetPriorVersion(): IJavaSet;
    //public Set getPriorVersion() throws OWLException;

    {**
    Returns a list of the Ontologies related via the
    owl:backwardCompatibleWith property
    }
    function GetBackwardCompatibleWith(): IJavaSet;
    //public Set getBackwardCompatibleWith() throws OWLException;

    {**
    Returns a list of the Ontologies related via the
    owl:incompatibleWith property
    }
    function GetIncompatibleWith(): IJavaSet;
    //public Set getIncompatibleWith() throws OWLException;

    {**
     * Returns <code>true</code> if the ontology is mutable, i.e. can
     * be changed. If the ontology has been retrieved from a URI (for
     * example as an imported ontology), then the ontology will be
     * considered immutable.
     *
     * @return a <code>boolean</code> value
    }
    function IsMutable(): WordBool;
    //public boolean isMutable() throws OWLException;

    {**
	  Identifies this ontology uniquely (enforced within one OWLConnection)
	  @return String representation of the URI
    }
    function GetLogicalUri(): TJavaUri;
    //public URI getLogicalURI() throws OWLException;

    {**
    Physical URI of the ontology.
    @return String representaion of the URI, could be null (e.g.
    not stored yet or in a database)
    }
    function GetPhysicalUri(): TJavaUri;
    //public URI getPhysicalURI() throws OWLException;
  end;

implementation

end.
