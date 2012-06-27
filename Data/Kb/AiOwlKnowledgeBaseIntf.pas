{**
@Abstract(База Знаний, OWL элементы)
@Author(Prof1983 prof1983@ya.ru)
@Created(11.05.2007)
@LastMod(27.06.2012)
@Version(0.5)

Prototype: org.mindswap.pellet.KnowlegeBase
}
unit AiOwlKnowledgeBaseIntf;

interface

uses
  ACollectionIntf;

type
  IAiOwlKnowledgeBase = interface
    {
    function AddAnnotationProperty(p: IATermAppl): WordBool;
    procedure AddAntisymmetricProperty(p: IATermAppl);
    procedure AddClass(c: IATermAppl);
    procedure AddComplementClass(c1, c2: IATermAppl);
    procedure AddDataPropertyValue(p, s, o: IATermAppl);
    procedure AddDataRange(const DatatypeUri: WideString; Values: IATermList);
    procedure AddDatatype(p: IATerm);
    function AddDatatypeA(DataType: IPelletDatatype): WideString;
    procedure AddDatatypeB(const DataTypeUrl: WideString; Datatype: IPelletDatatype);
    function AddDatatypeProperty(p: IATerm): WordBool;
    // ...
    }

    function GetClasses(): IACollection;
  end;
  IAiKnowledgeBaseOwl = IAiOwlKnowledgeBase;
  //IAiKnowledgeBase1 = IAiKnowledgeBaseOwl;

implementation

end.
