{**
@Abstract(Описание интерфейса IAiProcess)
@Author(Prof1983 prof1983@ya.ru)
@Created(02.01.2006)
@LastMod(26.06.2012)
@Version(0.5)
}
unit AiProcessIntf;

interface

uses
  AiFrameIntf, AiInterpretatorIntf;

type //** Интерфейс процесса выполнения команд для агентов
  IAiProcess = interface(IAiFrame)
    function GetCodeString(): WideString;
    function GetInterpretator(): IAiInterpretator;
    procedure SetCodeString(const Value: WideString);
    procedure SetInterpretator(Value: IAiInterpretator);

    //** Начать выполнение процесса
    function Start(): WordBool; safecall;
    //** Остановить выполнение процесса
    function Stop(): WordBool; safecall;

    //** Код для выполнения в виде строки
    property CodeString: WideString read GetCodeString write SetCodeString;
    //** Интерпретатор кода
    property Interpretator: IAiInterpretator read GetInterpretator write SetInterpretator;
  end;

implementation

end.
