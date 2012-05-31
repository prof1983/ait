{**
@Abstract(Базовый класс для агента)
@Author(Prof1983 prof1983@ya.ru)
@Created(22.09.2005)
@LastMod(16.05.2012)
@Version(0.5)

Агент - это модуль, который имеет свой подпроцесс выполнения команд (Thread).

Агенты общаются между собой.
Агенты делают запросы к БЗ и получают ответы от БЗ.
Для формирования и расбора сообщений агент использует кодек (codec).
Для передачи сообщения агент использует транспортный объект.
}
unit AiAgent;

// TODO: Remove

interface

uses
  AiAgentImpl;

{type
  TAiRecAgent = AiAgentImpl.TAiRecAgent;}

type //** Базовый класс для агента
  TAiAgent = AiAgentImpl.TAiAgent1;

implementation

end.
