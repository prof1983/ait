{**
@Abstract(OwlDataType)
@Author(Prof1983 prof1983@ya.ru)
@Created(01.05.2007)
@LastMod(27.04.2012)
@Version(0.5)

Prototype: org.semanticweb.owl.model.OWLDataType.java,v 1.3 2005/06/10 12:20:28
}
unit AOwlDataType;

interface

uses
  OwlDataRange;

//import java.net.URI;

type
  {**
    A place holder for concrete data types. This will ultimately be
    replaced by something like XML Schema data types.
  }
  IOwlDataType = interface(IOwlDataRange) //extends OWLDataRange, OWLDeprecatableObject
    //public URI getURI() throws OWLException;
  end;

implementation

end.
