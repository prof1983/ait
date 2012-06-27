{**
@Abstract(База знаний на основе БД фреймов FramerD)
@Author(Prof1983 prof1983@ya.ru)
@Created(25.04.2007)
@LastMod(27.06.2012)
@Version(0.5)

FramerD - это распределенная БД фреймов. Главный объект там ODB (Object Data Base).
Я переимевал в FramerODB
В этом объекте есть список подключеных пулов (Pool). Это источники фреймов... (аналог моего TAISource).

Есть пулы NetworkPool и FilePool.

Из ODB и из пулов запрашиваются фреймы. Для запросов указывается OID фрейма (Object ID)

OID - это интерфейс.

Я для всех классов и всех интерфейсов добавил префикс TFramer* и IFarmer.
В имена модулей соответсвенно добавил превикс Framer*
}
unit AiFramerKnowledgeBase;

interface

uses
  ATypes;
  {FramerODb;}

type // База знаний на основе БД фреймов FramerD
  TFramerKnowlegeBase = class
  private
    //FFramerODB: TFramerODB;
  protected
    procedure DoCreate();
  public
    function Initialize(): TProfError;
  end;

implementation

{ TFramerKnowlegeBase }

procedure TFramerKnowlegeBase.DoCreate();
begin
  //FFramerODB := TFramerODB.Create();
end;

function TFramerKnowlegeBase.Initialize(): TProfError;
begin
  //FFramerODB.UsePoolA('FramerD.db');
end;

end.
