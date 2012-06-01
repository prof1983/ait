{**
@Abstract(Настройки программы EntityStorage)
@Author(Prof1983 prof1983@ya.ru)
@Created(06.07.2007)
@LastMod(02.05.2012)
@Version(0.5)

История версий:
0.0.0.1 - 29.06.2007 - Создал на основе Reminder.Settings
}
unit AiEntityStorageSettings;

interface

uses
  AiBase, AiBaseTypes;

type //** @abstract(Настройки программы EntityStorage)
  TEntityStorageSettings = class
  private
      //** Идентификатор для заданий. Применяется в Pool.
    FTaskTypeID: TAIID;
      //** Заголовок окна
    FTitle: WideString;
  public // Секция "General"
      //** Идентификатор для заданий. Применяется в Pool.
    property TaskTypeID: TAIID read FTaskTypeID write FTaskTypeID;
      //** Заголовок окна
    property Title: WideString read FTitle write FTitle;
  end;

implementation

end.
