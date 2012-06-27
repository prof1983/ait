{**
@Abstract(AiOwlNamedObject)
@Author(Prof1983 prof1983@ya.ru)
@Created(30.04.2007)
@LastMod(27.04.2012)
@Version(0.5)

Prototype: org.semanticweb.owl.model.OWLNamedObject.java,v 1.2 2005/06/10 12:20:29
}
unit AOwlNamedObjectIntf;

interface

uses
  AOwlObject;

//import java.net.URI;

type
  {**
  A superinterface for all named things (anything that has a
  @link URI URI associated with it).
  }
  IOwlNamedObject = interface(IOwlObject)
    {**
    The URI associated with the object. In the case of anonymous
    individuals, this will return null.
    }
    //public URI getURI() throws OWLException;
  end;

implementation

end.
