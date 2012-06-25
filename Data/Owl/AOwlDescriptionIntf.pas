{**
@Abstract(OWL Description)
@Author(Prof1983 prof1983@ya.ru)
@Created(30.04.2007)
@LastMod(25.06.2012)
@Version(0.5)

Prototype: org.semanticweb.owl.model.OWLDescription.java,v 1.3 2006/03/28 16:14:45
}
unit AOwlDescriptionIntf;

interface

uses
  AOwlObject;

type
  {** An abstract interface encompassing various description types }
  IAOwlDescription = interface(IOwlObject)
    {** Accept a visit from a visitor }
    //public void accept( OWLDescriptionVisitor visitor ) throws OWLException;
  end;

  //IAiOwlDescription = IAOwlDescription;
  //IOwlDescription = IAOwlDescription;
  //IAIWSOwlDescription = IAOwlDescription;

implementation

end.
