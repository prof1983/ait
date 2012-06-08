{**
@Abstract(Коллекция)
@Author(Prof1983 prof1983@ya.ru)
@Created(25.05.2007)
@LastMod(08.06.2012)
@Version(0.5)

История версий:
0.0.2.0 - 10.06.2007 - Сделал наследником от TAIEntity
}
unit AiCollectionImpl;

interface

uses
  ACollection, AIteratorIntf,
  AiEntityImpl; {AiPoolIntf;}

type //** @abstract(Коллекция)
  TAiCollection = class(TAiEntity, IACollection)
  private
      //** Пул для чтения и записи элементов коллекции
    //FPool: IAIPool;
  public
      //** Создает и возвращает итератор
    function GetIterator(): IAIterator;
  public
      //** Пул для чтения и записи элементов коллекции
    //property Pool: IAIPool read FPool write FPool;
  end;

implementation

{ TAiCollection }

function TAiCollection.GetIterator(): IAIterator;
begin
  Result := nil;
  // ...
end;

end.
