{**
@Abstract(Коллекция)
@Author(Prof1983 prof1983@ya.ru)
@Created(25.05.2007)
@LastMod(26.03.2012)
@Version(0.5)

История версий:
0.0.2.0 - 10.06.2007 - Сделал наследником от TAIEntity
}
unit AiCollectionImpl;

interface

uses
  AiCollection, AiEntityImpl, AiIteratorIntf, AiPoolIntf;

type //** @abstract(Коллекция)
  TAICollection = class(TAIEntity, IAICollection)
  private
      //** Пул для чтения и записи элементов коллекции
    //FPool: IAIPool;
  public
      //** Создает и возвращает итератор
    function GetIterator(): IAIIterator;
  public
      //** Пул для чтения и записи элементов коллекции
    //property Pool: IAIPool read FPool write FPool;
  end;

implementation

{ TAICollection }

function TAICollection.GetIterator(): IAIIterator;
begin
  Result := nil;
  // ...
end;

end.
