{**
@Abstract(Базовые типы AI)
@Author(Prof1983 prof1983@ya.ru)
@Created(23.05.2007)
@LastMod(04.06.2012)
@Version(0.5)

Prototype: org.framerd.Pool

История версий:
0.0.1.3 - 04.07.2007
0.0.1.2 - 23.06.2007 - Добавил TAIProcMessage
0.0.1.1 - 31.05.2007 - Добавил коментарии, добавил TAIProcAddToLog
}
unit AiBaseTypes;

interface

uses
  ABase, ATypes;

type //** Ошибка. 0 - OK, >0 - есть информация, <0 - ошибка
  TAiError = ABase.AError;

type //** Тип значения данных
  TAiValueType = Integer;
const
  aivtEmpty      = 0;
  aivtNill       = 1;
  aivtBool       = 2;
  aivtInt        = 3;
  aivaFloat      = 4;
  aivtString     = 5;
  aivtDateTime   = 6;
  aivtCollection = 7;

type //** Версия
  TAiVersion = Integer;

// Процедурные типы ------------------------------------------------------------

type //** Тип callback функции для добавления в лог файл
  TAiProcMessage = function(AStrMsg: WideString): Integer of object; //safecall;
  TAiProcAddToLog = TAIProcMessage;

implementation

end.
