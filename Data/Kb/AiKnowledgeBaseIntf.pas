{**
@Abstract(Интерфейс для класса базы знаний)
@Author(Prof1983 prof1983@ya.ru)
@Created(23.04.2007)
@LastMod(27.06.2012)
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
  ABase, ACollectionIntf,
  AiFramePoolIntf, AiTermIntf;

type
  IAiKnowledgeBaseOld = interface(IAiFramePool)
    function GetTerm(Id: TAId): IAiTerm; safecall;
    function GetTermV(Id: TAId; Version: AVersion): IAiTerm; safecall;

    property Terms[Id: TAId]: IAiTerm read GetTerm;
    property TermsV[Id: TAId; Version: AVersion]: IAiTerm read GetTermV;
  end;

  {$IFDEF KnowledgeBaseOld}
  //IAiKnowledgeBase = IAiKnowledgeBaseOld;
  {$ELSE}
  //IAiKnowledgeBase = IAiKnowledgeBaseOwl;
  {$ENDIF KnowledgeBaseOld}

implementation

end.
