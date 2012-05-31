{**
@Abstract(Агент)
@Author(Prof1983 prof1983@ya.ru)
@Created(08.05.2007)
@LastMod(23.03.2012)
@Version(0.5)

Прототип: jade.core.Agent ?
}
unit AiAgentIntf;

interface

uses
  AclMessageIntf, // for IAiAgent.AddMessage
  AiInterpretatorIntf, AiModuleIntf,
  AiKnowledgeBaseIntf; // for IAIWSAgent

type //** Базовый интерфейс для агента
  IAiAgent = interface(IAiModule)
      //** Получить выполняемый код в виде строки
    function GetCodeString(): WideString; safecall;
      //** Получить интерпретатор кода
    function GetInterpretator(): IAiInterpretator; safecall;
      //** Задать выполняемый код в виде строки
    procedure SetCodeString(const Value: WideString); safecall;
      //** Задать интерпретатор кода
    procedure SetInterpretator(Value: IAiInterpretator); safecall;

      //** Добавить сообщение
    function AddMessage(Msg: IAclMessage): Integer;
      //** Добавить сообщение
    function AddMessageStr(const AMsg: WideString): Integer;
      //** Начать выполнение процесса
    function Start(): WordBool; safecall;
      //** Остановить выполнение процесса
    function Stop(): WordBool; safecall;

      //** Выполняемый код в виде строки
    property CodeString: WideString read GetCodeString write SetCodeString;
      //** Интерпретатор кода
    property Interpretator: IAiInterpretator read GetInterpretator write SetInterpretator;
  end;

type
  IAiWSAgent = interface
      // Возвращает базу знаний
    function GetKnowledgeBase(): IAiKnowledgeBase;
      // Задать базу знаний
    procedure SetKnowledgeBase(KnowledgeBase: IAiKnowledgeBase);

      // База Знаний
    property KnowledgeBase: IAiKnowledgeBase read GetKnowledgeBase write SetKnowledgeBase;
  end;

implementation

end.
