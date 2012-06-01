{**
@Abstract()
@Author(Prof1983 prof1983@ya.ru)
@Created(01.05.2007)
@LastMod(27.04.2012)
@Version(0.5)

Prototype: org.semanticweb.owl.model.OwlDataProperty
}
unit AOwlDataProperty;

interface

uses
  OwlProperty;

type
  {**
  An {@link OWLProperty OWLProperty whose range is some concrete data type.
  @author Sean Bechhofer
  @version $Id: OWLDataProperty.java,v 1.2 2005/06/10 12:20:28 sean_bechhofer Exp $
  }
  IOwlDataProperty = interface(IOwlProperty)
  end;

implementation

end.
