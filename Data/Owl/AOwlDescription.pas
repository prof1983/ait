{**
@Abstract(OwlDescription)
@Author(Prof1983 prof1983@ya.ru)
@Created(30.04.2007)
@LastMod(27.04.2012)
@Version(0.5)

Prototype org.semanticweb.owl.model.OWLDescription.java,v 1.3 2006/03/28 16:14:45
}
unit AOwlDescription;

interface

uses
  OwlObject;

type
  {**
    An abstract interface encompassing various description types
    -- boolean expressions, restrictions, enumerations etc.
  }
  IOwlDescription = interface(IOwlObject)
  {
    /** Accept a visit from a visitor */
    public void accept( OWLDescriptionVisitor visitor ) throws OWLException;
  }
  end;

implementation

end.
