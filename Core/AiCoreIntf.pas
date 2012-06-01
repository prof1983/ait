{**
@Abctract(Микроядро системы)
@Author(Prof1983 prof1983@ya.ru)
@Created(20.06.2007)
@LastMod(24.04.2012)
@Version(0.5)

История версий:
0.0.0.6 - 29.07.2007
0.0.0.5 - 07.07.2007
0.0.0.4 - 05.07.2007
0.0.0.3 - 04.07.2007
0.0.0.2 - 21.06.2007 - Добавил AddCommand()
0.0.0.1 - 20.06.2007
}
unit AiCoreIntf;

interface

uses
  ALogJournal,
  AclMessageIntf;

type
  IAiCore = interface
      //** Добавить команду
    function AddCommand(Cmd: WideString): Integer;
      //** Добавить лог-сообщение
    function AddLogMessage(Msg: WideString): Integer;
      //** Добавить журнал записи лог-сообщений
    function AddLogJournal(Log: TLogJournal): Integer;
      //** Предать или выполнить сообщение.
    function AddMessage(Msg: IAclMessage): Integer;
  end;

implementation

end.
