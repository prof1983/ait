{**
@Abstract(Итератор)
@Author(Prof1983 prof1983@ya.ru)
@Created(25.05.2007)
@LastMod(08.06.2012)
@Version(0.5)
}
unit AiIteratorObj;

interface

uses
  ABase, AiBaseTypes;

type
  //** Итератор для данных сущности, когда данные в виде коллекции.
  TAiIteratorObject = class
  public
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

{ TAiIteratorObject }

function TAiIteratorObject.Insert(Element: TAId): Boolean;
begin
  Result := False;
  // ...
end;

function TAiIteratorObject.IsEmpty(): Boolean;
begin
  Result := False;
  // ...
end;

function TAiIteratorObject.Next(): TAId;
begin
  Result := 0;
  // ...
end;

function TAiIteratorObject.Remote(): Boolean;
begin
  Result := False;
  // ...
end;

end.
