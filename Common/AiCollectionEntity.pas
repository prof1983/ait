{**
@Abstract(Сущность-коллекция)
@Author(Prof1983 prof1983@ya.ru)
@Created(24.05.2007)
@LastMod(06.03.2012)
@Version(0.5)

История версий:
0.0.1.1 - 21.06.2007
}
unit AiCollectionEntity;

interface

uses
  AiCollection, AiEntityIntf;

type //** @abstract(Сущность-коллекция)
  IAICollectionEntity = interface(IAIEntity)
    function GetValue(): IAICollection;

    property Value: IAICollection read GetValue;
  end;

implementation

end.
