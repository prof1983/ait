{**
@Abstract(Настройки программы AiReminder)
@Author(Prof1983 prof1983@ya.ru)
@Created(29.06.2007)
@LastMod(01.06.2012)
@Version(0.5)

История версий:
0.0.0.1 - 29.06.2007 - Перенес из fReminder
}
unit ARemindSettings;

interface

uses
  AiBase;

type //** Настройки программы AIReminder
  TSettings = class
  private
      //** Идентификатор для заданий. Применяется в Pool.
    FTaskTypeId: TAId;
      //** Заголовок окна
    FTitle: WideString;
  public // Секция "General"
      //** Идентификатор для заданий. Применяется в Pool.
    property TaskTypeId: TAId read FTaskTypeId write FTaskTypeId;
      //** Заголовок окна
    property Title: WideString read FTitle write FTitle;
  end;

implementation

end.
