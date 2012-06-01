{**
@Abstract(Класс для задания)
@Author(Prof1983 prof1983@ya.ru)
@Created(28.06.2007)
@LastMod(05.05.2012)
@Version(0.5)

История версий:
0.0.0.4 - 06.07.2007 - Удалил DateTime, Добавил Comment
0.0.0.3 - 04.07.2007
0.0.0.2 - 29.06.2007 - Создал TTasks
0.0.0.1 - 28.06.2007
}
unit AiTask;

// TODO: Move to AiTaskImpl.pas

interface

uses
  AiEntityImpl;

type //** @abstract(Класс для задания)
  TTask = class(TAiEntity)
  private
    FComment: WideString;
    FTitle: WideString;
  public
    property Comment: WideString read FComment write FComment;
    property Title: WideString read FTitle write FTitle;
  end;

type
  TTasks = array of TTask;

implementation

end.
