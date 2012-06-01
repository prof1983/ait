{**
@Abstract(OwlObjectProperty)
@Author(Prof1983 prof1983@ya.ru)
@Created(01.05.2007)
@LastMod(01.05.2007)
@Version(0.5)

package org.semanticweb.owl.model.OWLObjectProperty.java,v 1.2 2005/06/10 12:20:29
}
unit AOwlObjectProperty;

interface

uses
  OwlProperty;

//import java.util.Set;

type
  {**
  An {@link OWLProperty OWLProperty whose range is a class (a
  collection of domain objects).
  }
  IOwlObjectProperty = interface(IOwlProperty)
  {
    /**
     * Return all inverses asserted in the given ontology.
     *
     * @param o an <code>OWLOntology</code> value
     * @return a <code>Set</code> value
     */
    public Set getInverses( OWLOntology o ) throws OWLException;

    /**
     * Return all inverses asserted in the given ontologies.
     *
     * @param o an <code>OWLOntology</code> value
     * @return a <code>Set</code> value
     */
    public Set getInverses( Set ontologies) throws OWLException;
  
    /**
     * Returns <code>true</code> if the property is asserted to be
     * symmetric (in the given ontology).
     *
     * @param o an <code>OWLOntology</code> value
     * @return a <code>boolean</code> value
     */
    public boolean isSymmetric( OWLOntology o ) throws OWLException;

    /**
     * Returns <code>true</code> if the property is asserted to be
     * symmetric (in the given ontologies).
     *
     * @param o an <code>OWLOntology</code> value
     * @return a <code>boolean</code> value
     */
    public boolean isSymmetric( Set ontologies ) throws OWLException;

    /**
     * 
     * Returns <code>true</code> if the property is asserted to be
     * inverse functional (in the given ontology).
     *
     * @param o an <code>OWLOntology</code> value
     * @return a <code>boolean</code> value
     */
    public boolean isInverseFunctional( OWLOntology o ) throws OWLException;

    /**
     * 
     * Returns <code>true</code> if the property is asserted to be
     * inverse functional (in the given ontologies).
     *
     * @param o an <code>OWLOntology</code> value
     * @return a <code>boolean</code> value
     */
    public boolean isInverseFunctional( Set ontologies ) throws OWLException;

    /**
     * 
     * Returns <code>true</code> if the property is asserted to be
     * oneToOne (in the given ontology).
     *
     * @param o an <code>OWLOntology</code> value
     * @return a <code>boolean</code> value
     */
    public boolean isOneToOne( OWLOntology o ) throws OWLException;

    /**
     * 
     * Returns <code>true</code> if the property is asserted to be
     * oneToOne (in the given ontologies).
     *
     * @param o an <code>OWLOntology</code> value
     * @return a <code>boolean</code> value
     */
    public boolean isOneToOne( Set ontologies ) throws OWLException;

    /**
     * Returns <code>true</code> if the property is asserted to be
     * transitive (in the given ontology).
     * 
     *
     * @param o an <code>OWLOntology</code> value
     * @return a <code>boolean</code> value
     */
    public boolean isTransitive( OWLOntology o ) throws OWLException;

    /**
     * Returns <code>true</code> if the property is asserted to be
     * transitive (in the given ontology).
     * 
     *
     * @param o an <code>OWLOntology</code> value
     * @return a <code>boolean</code> value
     */
    public boolean isTransitive( Set ontologies ) throws OWLException;
  }
  end;

implementation

end.
