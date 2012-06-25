{**
@Abstract(OwlProperty)
@Author(Prof1983 prof1983@ya.ru)
@Created(30.04.2007)
@LastMod(25.06.2012)
@Version(0.5)

Prototype: org.semanticweb.owl.model.OWLProperty.java,v 1.3 2005/06/10 12:20:29
}
unit AOwlProperty;

interface

uses
  AOwlEntity;

//import java.util.Set;

type
  {**
  A Property in an OWL ontology. As with other examples of {@link
  OWLEntity OWLEntity, information about the OWLProperty is held
  w.r.t. a particular {@link OWLOntology OWLOntology, and requests
  for information about an OWLProperty should be made in the context of
  an ontology or set of ontologies.  <br/>
  }
  IOwlProperty = interface(IOwlEntity) //OWLDeprecatableObject
  {
    /**
     * Return any asserted superproperties in the given ontology.
     *
     * @param o an <code>OWLOntology</code> value
     * @return a <code>Set</code> value
     */
    public Set getSuperProperties( OWLOntology o ) throws OWLException;

    /**
     * Return any asserted superproperties in any of the given ontologies.
     *
     * @param o an <code>OWLOntology</code> value
     * @return a <code>Set</code> value
     */
    public Set getSuperProperties( Set ontologies ) throws OWLException;

    /**
     * Return all domains (in the given ontology).
     *
     * @param o an <code>OWLOntology</code> value
     * @return a <code>Set</code> value
     */
    public Set getDomains( OWLOntology o ) throws OWLException;

    /**
     * Return all domains (in the given ontologies).
     *
     * @param o an <code>OWLOntology</code> value
     * @return a <code>Set</code> value
     */
    public Set getDomains( Set ontologies ) throws OWLException;

    /**
     * Return all ranges in the given ontology.
     *
     * @param o an <code>OWLOntology</code> value
     * @return a <code>Set</code> value
     */
    public Set getRanges( OWLOntology o ) throws OWLException;

    /**
     * Return all ranges in the given ontologies.
     *
     * @param o an <code>OWLOntology</code> value
     * @return a <code>Set</code> value
     */
    public Set getRanges( Set ontologies ) throws OWLException;

    /**
     * Returns <code>true</code> if the property is declared as being
     * functional in the given ontology
     * @param o an <code>OWLOntology</code> value
     * @return a <code>boolean</code> value
     */
    public boolean isFunctional( OWLOntology o ) throws OWLException;

    /**
     * Returns <code>true</code> if the property is declared as being
     * functional in any of the given ontologies
     * @param o an <code>OWLOntology</code> value
     * @return a <code>boolean</code> value
     */
    public boolean isFunctional( Set ontologies ) throws OWLException;
  }
  end;

implementation

end.
