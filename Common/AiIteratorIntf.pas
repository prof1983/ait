{**
@Abstract(Итератор)
@Author(Prof1983 prof1983@ya.ru)
@Created(23.05.2007)
@LastMod(13.03.2012)
@Version(0.5)

История версий:
0.0.1.2 - 04.07.2007
0.0.1.1 - 21.06.2007 - Добавил IsEmpty()
}
unit AiIteratorIntf;

interface

uses
  AiBase, AiBaseTypes;

type
  {**
    Итератор для данных сущности, когда данные в виде коллекции.
    //Является локальной сущностью.
    Удаляется автоматически, когда никто не ссылается на эту сущность.
  }
  IAiIterator = interface
      //** Вставить элемент в коллекцию
    function Insert(Element: TAId): Boolean;
      //** Пусто?
    function IsEmpty(): Boolean;
      //** Следующий элемент коллекции
    function Next(): TAId;
      //** Удалить текущий элемент из коллекции
    function Remote(): Boolean;
  end;

implementation

end.
