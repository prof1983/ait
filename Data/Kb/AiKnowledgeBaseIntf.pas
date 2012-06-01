{**
@Abstract(Интерфейс для класса базы знаний)
@Author(Prof1983 prof1983@ya.ru)
@Created(23.04.2007)
@LastMod(22.05.2012)
@Version(0.5)

База знаний - это объект, который работает с несколькими источниками (пулами) фреймов.
База знаний предоставляет работу с термами.
Терм - это несколько объединеных версий фреймов.

История версий
0.0.5 - 06.03.2012 - Объединил c AiKnowledgeBase_20070430
0.0.2.2 - 05.07.2007
0.0.2.1 - 04.07.2007
0.0.2.0 - 03.06.2007 - Заменил AIWSSet на AICollection
}
unit AiKnowledgeBaseIntf;

interface

uses
  {$IFDEF KnowledgeBaseOld}
  AiBase, AiBaseTypes, AiFramePoolIntf, AiTermIntf,
  {$ENDIF KnowledgeBaseOld}
  AiCollection;

type
  {$IFDEF KnowledgeBaseOld}
  IAiKnowledgeBaseOld = interface(IAiFramePool)
    function GetTerm(Id: TAiId): IAiTerm; safecall;
    function GetTermV(Id: TAiId; Version: TAiVersion): IAiTerm; safecall;

    property Terms[Id: TAiId]: IAiTerm read GetTerm;
    property TermsV[Id: TAiId; Version: TAiVersion]: IAiTerm read GetTermV;
  end;
  //IAiKnowledgeBase2 = IAiKnowledgeBaseOld;
  {$ENDIF KnowledgeBaseOld}

  IAiKnowledgeBase1 = interface
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

    function GetClasses(): IAiCollection;
  end;

  {$IFDEF KnowledgeBaseOld}
  IAiKnowledgeBase = IAiKnowledgeBaseOld;
  {$ELSE}
  IAiKnowledgeBase = IAiKnowledgeBase1;
  {$ENDIF KnowledgeBaseOld}

implementation

end.
