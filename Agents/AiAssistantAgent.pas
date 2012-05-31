{**
@Abstract(Агент программы ArAsistant)
@Author(Prof1983 prof1983@ya.ru)
@Created(12.03.2007)
@LastMod(27.03.2012)
@Version(0.5)

Назначение агента:
- Обеспечивать взаимодействие с пользователем.
- Обеспечивать актуальную поставку данных для GUI пользователя.
- Обрабатывать команды от GUI пользователя.
}
unit AiAssistantAgent;

// TODO: Реализовать агента AsistantAgent

interface

uses
  AiAgentImpl;

type //** Агент программы ARAsistant
  TAIAssistantAgent = class(TAIAgent)
  protected
    procedure DoCreate(); override; safecall;
  end;

implementation

{ TAiAssistantAgent }

procedure TAiAssistantAgent.DoCreate();
begin
  inherited DoCreate();
  FName := 'AssistantAgent';
end;

end.
