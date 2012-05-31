{**
@Abstract(Behavior collection)
@Author(Prof1983 prof1983@ya.ru)
@Created(08.09.2007)
@LastMod(05.05.2012)
@Version(0.5)
}
unit ABehaviorCollection;

interface

uses
  ABehavior, ABehaviorIterator;

type
  IBehaviorCollection = interface
    //function GetIterator(): IBehaviorIterator;

    // Добавить умение
    procedure Add(Behaviour: IBehavior);
    // Удалить умение
    procedure Remove(Behaviour: IBehavior);

    //property Iterator: IBehaviorIterator read GetIterator;
  end;

implementation

end.
