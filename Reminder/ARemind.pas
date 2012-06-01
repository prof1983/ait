{**
@Abstract(Класс для напоминания)
@Author(Prof1983 prof1983@ya.ru)
@Created(04.07.2007)
@LastMod(01.06.2012)
@Version(0.5)

История версий:
0.0.0.1 - 04.07.2007 - Создал на основе Task
}
unit ARemind;

interface

uses
  AiEntityImpl;

type //** Класс для напоминания
  TRemind = class(TAiEntity)
  private
    FDateTime: TDateTime;
    FTitle: WideString;
  public
    property DateTime: TDateTime read FDateTime write FDateTime;
    property Title: WideString read FTitle write FTitle;
  end;

type
  TReminds = array of TRemind;

implementation

end.
