{**
@Abstract(OwlObject)
@Author(Prof1983 prof1983@ya.ru)
@Created(30.04.2007)
@LastMod(27.04.2012)
@Version(0.5)

prototype: org.semanticweb.owl.model.OWLObject.java,v 1.2 2005/06/10 12:20:29
}
unit AOwlObject;

interface

//import java.io.Serializable;
//import java.util.Map;

//import org.semanticweb.owl.util.OWLConnection;
//import java.util.Set;

type
  {**
  A top level interface for the kinds of things that are found in Ontologies.
  Each OWLObject knows about the {@link OWLDataFactory OWLDataFactory that was
  used to create it.
  OWLObjects also accept visits from {@link OWLObjectVisitor OWLObjectVisitor.
  The use of the Visitor pattern (see <i>Design Patterns</i>,
  Gamma et. al. p.331) allows us to extend the functionality of the data
  structures without having to alter the underlying implementation.
  <br/>
  In addition, we can store metadata about any OWLObject using a
  {@link Map Map. This allows us to store pretty much anything we
  want, although any clients of the objects will, of course, need to
  know something about the way in which that metadata is structured
  in order to make use of it.
  }
  // (TODO) : 09-06-2002 Phillip Lord :-  Serializable? Yes? No?
  IOwlObject = interface //extends Cloneable, Serializable
{
    /**
     *
     * Return any objects which are contained within this object. By
     * contained this means, any of the objects which can be reached
     * from any of more specific methods in the interface. The
     * ordering of the objects in the array is undefined. A null
     * return represents an empty collection.
     * @return an <code>OWLObject[]</code>, or null.
     */
    public OWLObject[] getContainedObjects() throws OWLException;

    /** Returns an OWLDataFactory 
     * [REVIEW] the DataFactory should live with the connection object... */
    public OWLDataFactory getOWLDataFactory() throws OWLException;
    
    /** Returns the Connection of this object */
    public OWLConnection getOWLConnection() throws OWLException;

    public Object clone();

    /** Accept a visit from a visitor */
    public void accept( OWLObjectVisitor visitor ) throws OWLException;

    /** Get metadata -- this returns a {@link Map Map which allows
     * the support of arbitrary metadata. */
    public Map getMetadata() throws OWLException;

    /** Returns the annotations on the object. */ 
    public Set getAnnotations() throws OWLException;

    /** Returns the annotations on the object in the given
     * ontology. */ 
    public Set getAnnotations( OWLOntology o ) throws OWLException;
  }
  end;

implementation

end.
